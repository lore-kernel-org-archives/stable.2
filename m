Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425813C908
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788826827; cv=none; b=gOHuB4jmCvHjcuaGrqtuXckBEcwVbxA11L2YH/sdEa3BUNVrsUUUvNGi+HXnast2hKGFqFS6C4mtP0hNq1j8I4X6gdT/iQxj8Ow9AGzCeJ+FT/yafkxczVRK+ZY/zxHud1wxjJrhhJevoGkVI45apqvqbl8JdcGDZ8VsZbjxwXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788826827; c=relaxed/simple;
	bh=VM78Hp6DUBwWcxdzDE8P1TsbE589lTCA+ZcXc8zRv04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ei87N584lgs0rHa2wkcZIgtYkkm7L1L3d3TlOzGQ180nzHM1ZHgz3DhZrACyNWBRzfWTw5DATiJhrbHpbm1r5aiEPuuioQP5BbLVwtyCDJte/ZKZoibleowBAJBdGBfhCJ7qQCBN9bCpgIs/P2/KT31HyrHA5+2HpiaUHlKfjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0L2vMhO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0L2vMhO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215181F00A3D;
	Tue,  8 Sep 2026 00:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788826826;
	bh=gnd+dgbfUPyuAfOUsMgrlhXhnFf3J+Uhdy11jKq9y2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C0L2vMhO0C6/U0mx0hN1qo+HPBMbyrlCuCWgT9PW3lODlSYn6+xDEDwbEwO/oI7y9
	 tOwIPAgBMdfAuyWbtUxmToGDFgVeINtZAi3ygfRBBr7l+hPBqRsirVgAD/HWsfCwf7
	 x/MihtPcJ2CA+dmiSJ6O/4Sp5L3AhNAhQyzdpwB9BTygznc0msrXfReA74xzZ0VOL4
	 xZ3cGxTikMCINYyjZp5kQFqb7ZArCyYoLKXM4paIukcUg7EBbRZeTJ6ZTBgahzYRnC
	 DAFHPvyduKeTj5mo6CrD3f2sYw2ZeIJOwNwMzB1uqOgG0sMywf0pbGJOz6SPxahGYF
	 S5HDelaaH+e8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] smb: client: fix UAF and buffer leak in cifs_check_trans2() for malformed secondary T2
Date: Mon,  7 Sep 2026 20:20:22 -0400
Message-ID: <20260908002022.1543220-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908002022.1543220-1-sashal@kernel.org>
References: <2026090304-muscular-diligent-73ea@gregkh>
 <20260908002022.1543220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 730d0bb19507b9e19c2fe5343109ac618e2fbce5 ]

When a valid primary TRANSACT2 response has been received (mid->resp_buf
set, mid->multiRsp true) and a subsequent secondary response causes
cifs_check_trans2() to return false -- either because the SMB header is
invalid (malformed != 0) or because check2ndT2() rejects the PDU --
handle_mid() overwrites mid->resp_buf with the new buffer (leaking the
primary buffer) and, because mid->multiRsp is set, skips the
server->smallbuf/bigbuf NULL-out.  When the user thread frees
mid->resp_buf, server->smallbuf or server->bigbuf is left dangling; the
demux thread reuses it for the next packet, resulting in a use-after-free.

Combine both early-exit conditions and, when mid->multiRsp is already
set, abort the pending transaction inline: set multiEnd, call
dequeue_mid() with malformed=true, and return true so handle_mid() exits
without touching mid->resp_buf or the server buffer pointers.

Fixes: 316cf94a910f ("CIFS: Move trans2 processing to ops struct")
Cc: stable@vger.kernel.org # cifs_check_trans2() is in smb1ops.c on kernels < 7.0
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb1transport.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb1transport.c b/fs/smb/client/smb1transport.c
index 73edca2ac98b3..63270f3abe058 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -382,10 +382,18 @@ bool
 cifs_check_trans2(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 		  char *buf, int malformed)
 {
-	if (malformed)
-		return false;
-	if (check2ndT2(buf) <= 0)
+	if (malformed || check2ndT2(buf) <= 0) {
+		/* mid->multiRsp blocks the server buf detach in handle_mid();
+		 * returning false here would leak resp_buf and leave a dangling
+		 * server->smallbuf/bigbuf after the user thread frees resp_buf.
+		 */
+		if (mid->multiRsp) {
+			mid->multiEnd = true;
+			dequeue_mid(server, mid, true);
+			return true;
+		}
 		return false;
+	}
 	mid->multiRsp = true;
 	if (mid->resp_buf) {
 		/* merge response - fix up 1st*/
-- 
2.53.0

