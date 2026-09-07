Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6DB446BEA
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821162; cv=none; b=SbEykco+3KuftNKUzeT8E7sUSYy27HFs0xvGPgPS18posTsuhOTsf2/L5vJAQS6j6ER9z0LuGsfGc5xYF1cL3eJSuBKpe8YfnGlpWQ2H4FzYmF1i/H6kwrnJVCubTzCe8J49BoOaVxnjYdc8KTkUKCm/1R+6ZYNpi/MUnOt2irM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821162; c=relaxed/simple;
	bh=wtHaGgI8y/QOAz3JpX9YgmfzY4xG4+6GFCpWKQhKrZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoGGMEKbwDqDDHgohkv6q9k3exZl/EeF123E4XvGZgW3HqMpHS8rwM/kzTMd5GzpL8Eu8195cROAME21aszw2slKsaFUqPIpz/Ou+K7nChzI2KxkfyySTwUyQ1GD95SFzrQmocnSNW4erJQ/ILfcsOfJQt9FQU97em+tmt01Zkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO1k/pff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO1k/pff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67E11F00A3A;
	Mon,  7 Sep 2026 22:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788821161;
	bh=bMIWVd5xHJm3x3li0Zx6uQbzqcA/Y4GV03OY/do5c8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iO1k/pff+XGF1OowTLXrwXA3XgL776pPmsK3ZkajM4WLcuqN8sTkxgrBSQRmbZ61y
	 kn1J60/ogFOesw3trso7/krLI6Wpmlgv/ktJaiaegQmfQ5o/xglfgnYDziC1tG8B28
	 +sxkYk30VKONFvhf25MUS8L39BTXf4p2i3lqDPmOznsOTc0d8+NIdHn5MUexjeB2HE
	 RVyHedavcAN7Xj9IHuHfiLeYEbiQ7vUSHynnYoZyrF2GTXBUL6t29ZM5hRd/yBRyNw
	 ZJDRq4Bw/UoIGKmBNeRwNc1BElNN8fQY0L9Th71dUC/xg0zubWKxNs/30ViH6NGFTz
	 gw6NulS5y+0cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] smb: client: fix UAF and buffer leak in cifs_check_trans2() for malformed secondary T2
Date: Mon,  7 Sep 2026 18:45:55 -0400
Message-ID: <20260907224555.689206-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907224555.689206-1-sashal@kernel.org>
References: <2026090304-drowsily-unread-e280@gregkh>
 <20260907224555.689206-1-sashal@kernel.org>
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
index b79256be7380d..5c65b11daa632 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -386,10 +386,18 @@ bool
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

