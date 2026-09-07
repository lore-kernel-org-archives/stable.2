Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D935526A96
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811225; cv=none; b=ljTCxg5T3KQrCSR6H0A5PjIF8hvL7JkhmaCMKOvX6UsXdM9xD0v+4TgXqqXiJDjSRwBC5PiqJNUCpFM3CFiHutkpy75vmDQQ1PbK4O5UcnMPvr1HC/YhAE6INGC78Ko5UjY6pGxq/jv6r1sxigPADnFyteg0Fhsa83mxVFksk1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811225; c=relaxed/simple;
	bh=E2xdLiKqaFWt8bFhlE1xPHszk592SqyouTCmZI9OCPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6gGl5AY1WEooCScAhnPxUDI5ToYaUhcMxMWXT645o6PsoshxfXVFA015w1RtpvbDmmJji/MXETQOC1FsYsFDaPYVX8O5jYqVni9hbfpET3r+i7VSv6/IfyKfCFq+5sKoXxJQEptJKTktghJ3fDvd1XAEdetvHo6XMytTVrd5s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW9ch3US; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW9ch3US"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14BA1F00A3F;
	Mon,  7 Sep 2026 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788811224;
	bh=bGxEjeszGSXFaq/NFJE2nmr6S7ZDUhq92M/F2L0Xz2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GW9ch3USErw9iDHh9cBZ+Vh9h/uvCAK5dDiObMfHOC5E+w74y2Fj0I/cjuEsb+LDF
	 7MfUyJjgvIJugJoRQqFYOxCf5OPG1uHTu2RetPB4naqaiKzR+o1JT2wRgNjKMm/MU9
	 XcsbTtZcmW6KquqTDkIwdSeYXixruZQU1lki++9Yfne1QdyehxBhqHXpXTYpzcGtB6
	 3WHFvU8ddV5K9s2Y4QkeGkSVqKYEFA+tVh5oticGPmPFgA2sjVHbZsKgUIglv9ruvl
	 A4FewngRxm/eyHu6YmPRCeeizIDqyY5jWblhHujmG0sw24tGrYnmA4T4SI3pXM4Rn5
	 SsJiHkKWhZMpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] smb: client: fix UAF and buffer leak in cifs_check_trans2() for malformed secondary T2
Date: Mon,  7 Sep 2026 16:00:18 -0400
Message-ID: <20260907200018.326904-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907200018.326904-1-sashal@kernel.org>
References: <2026090303-fiddling-giant-6389@gregkh>
 <20260907200018.326904-1-sashal@kernel.org>
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
index 824604cb0e468..de240840d59ff 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -386,10 +386,18 @@ static bool
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

