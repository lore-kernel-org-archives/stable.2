Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF9485CE1
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781643; cv=none; b=fvROwTshAsArSKj5ts+UyyY6PIuFwIzNvStfwj6Q8H7mMTo4pxwWRADBMY9odiVOrzWFoqObddyyorSk4I2/imSnWEI75NP+cNv0lGS9qR4fRFsU5Ic8LSE6K9nh02EFtaXBXKpaG5lrb568Oxz830Lf+FassnFrphKR987oRbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781643; c=relaxed/simple;
	bh=YIioS4yvUO0poaVvnwW4ma1srA3tmoyJLoyjVMocvXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDurayb7ZIYjx8iHGXRhBv8rkcaOKCENCT7I7Q7qKVfeoYkmZSMwlOCnM3a8OcwOAuffljdwfc0s5bFtbyxEmNSr0sr5XnMwn//yzXZN7iuZiO7Yn1wik3OR5nilbe5A+TFV2HJFUqNdGX0IeQHsoaPOolk9cjY2YqlVB6irWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meGBJd3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meGBJd3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFCA1F00A3A;
	Mon,  7 Sep 2026 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781642;
	bh=q9zV623/MGEoL2cryRbfXMglPShTXIMkdXx8NQDj658=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=meGBJd3SrpteiS4+40TWHM6pvqFJDqplKzAZz2+fHdIa1WA68ya5p4jGbGVwdBMxG
	 odeKbiNbra5WVQeEIKTh/RhrKPWKcNci4GHSwIrG2PHP4u+mNIRTZIQ0w2YVS06Bc4
	 4Z0K5uGPh1BS6Qhz2Ibl9dHR+Q4Z1PM8Agi1d4ku5NMpIipqHmOtgfSmfsd/jDb5eZ
	 GMHTJ7Vi7CNeiKHBrWvvCJvSiqJdmGImnjtIDGmvkGw21kvjERFdE3/Hp7YFEh3j3J
	 ceonLeSJeht4ip9ymLpikQDBdWzDiWCMGr11lXYwLEM9r3WDPsALpkGZ1BSh+95QAC
	 YihiL2QZZPQnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] smb: client: fix UAF and buffer leak in cifs_check_trans2() for malformed secondary T2
Date: Mon,  7 Sep 2026 07:47:14 -0400
Message-ID: <20260907114714.2870258-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907114714.2870258-1-sashal@kernel.org>
References: <2026090302-harddisk-sinless-6dc1@gregkh>
 <20260907114714.2870258-1-sashal@kernel.org>
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
[ changed dequeue_mid(server, mid, true) to the older dequeue_mid(mid, true) API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb1transport.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb1transport.c b/fs/smb/client/smb1transport.c
index f7b00bcb9df1a..344ad0d5b5ab6 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -708,10 +708,18 @@ bool
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
+			dequeue_mid(mid, true);
+			return true;
+		}
 		return false;
+	}
 	mid->multiRsp = true;
 	if (mid->resp_buf) {
 		/* merge response - fix up 1st*/
-- 
2.53.0

