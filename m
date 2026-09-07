Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7304FDE69
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793271; cv=none; b=UmOmSmc+CYU1LZ7CtFTrXQtZt4xC6OIxpvEwSXjQLqipba7VEbfhaYEQHjEfap6BkwjEqrq7B4cPeQ76gMnVW+IVbLRP+Zm+zLVfweqKN3NwUd0dixa6qE4yTdB+5ueqaoGERH5a2K5aVNAWQeM5dJaj1AoMk7CF4lWy6MfyOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793271; c=relaxed/simple;
	bh=cCHH/WcMLePT4CzQs0qe+orKA6zQJvaQ4a848ibTyb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+1wbv6O8lcz03m67sW8Ej6JzxxwMBHO2MO4wuo+Jf4oWlG6lgn+M82rpGjEZGDVA0fxIGrGf53YyfGTchx7vAKrxl7Ajcdcw/ww1+Gtr4Rz5Fd/YsngxyRtiBNg9ZttxC7yxAPJemtlHLss/93wsGASJjBiawkCAZSd+Xoq0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hudPfjJ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hudPfjJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40611F00A3A;
	Mon,  7 Sep 2026 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788793267;
	bh=4ayJfwfjeNi/BPXvY4xEX8x3AUb9Jjhc6mj7RqBVwBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hudPfjJ09FGn3ojvX2BtE8SGlvT12Sz9ee2ooOo8IbclPuOCRpxMxYijbei6VfE3s
	 jU763ydizKvXvndKVeP84T/rgsye4cF6/OtoKZcfxgTeGYcI+WaMpM7VJaObhnwFJF
	 abcQS39oyBOC4JDLwYoV6EU9dXLiwkMkAcnOV8IeGZg1puAPihNHtzVx4so3HxhWzU
	 xnl5u1OlA6vqHON+fym840xMd/FZhmmp4lCOPp2wGKhF7hgqpjvCArTQKXgnvzaHrk
	 n+6+2HPeE1tui86UWCwlr2FvW1THFlCv87TbH4OYiie4BUUCOrBQD2i/E53Og7YGW5
	 sp2M+DogCa91w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/6] smb: client: fix UAF and buffer leak in cifs_check_trans2() for malformed secondary T2
Date: Mon,  7 Sep 2026 11:00:59 -0400
Message-ID: <20260907150059.3712249-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907150059.3712249-1-sashal@kernel.org>
References: <2026090303-ashamed-silver-ed5c@gregkh>
 <20260907150059.3712249-1-sashal@kernel.org>
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
index 8e66a2d21f406..081885c222a9c 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -157,10 +157,18 @@ bool
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

