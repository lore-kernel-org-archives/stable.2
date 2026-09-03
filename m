Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD454B1284
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443332; cv=none; b=hjBABXNVC790tQ33RTSPSsDSSNpqeUDVIjTB/yj94iIaPp0N46CHA2f278hCYZnqwiyo0RzFI/GMhP5ty5hvBve4r7wiR/sePMalDH431hF7qvbmI6sMOpRwKbFfbAPc1ncg5txQce1AbJnLQYh+NHVctwEsLSqWjpEtaD1drPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443332; c=relaxed/simple;
	bh=QQgvZX5YR4wLBYsrZCTPgaKNs3eG79K20R+lK0A4icM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aTi4rv2vR+cris7TBl3TLVRzTYATpfKzWRAUtxWJxiPxAPklACVSNBRsLcF4L2g2owtJONInyOy4qV+oqz7m3VXE8FDzE6mqn+7277uxaJL7hAP3yiPKL8w10+c5uE+CDbvf5A+P9HFhqx9YjS9o5K7lu6jjHCvY6DsoS1BmO18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BvjYziFI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BvjYziFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD061F000E9;
	Thu,  3 Sep 2026 13:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443321;
	bh=TvkRcjQ8Szz3AtzS/LcSojjTbS7qL5FmaP4w8/M/Rmg=;
	h=Subject:To:Cc:From:Date;
	b=BvjYziFItEG4FgfULFONrZRSMNpGFANKtOzPniSCxPHn3N931rW6CRpF4vL/ZZD4n
	 yiSo+tTacG3ZIdYEZPgBj+aGD7XdSNz7DHcnsPa7m9a1vPJZYRSManC6oQv/AYihlo
	 xNGe148je92C+XBm8Wu5994EuHNCDth1aSmz+mYY=
Subject: FAILED: patch "[PATCH] smb: client: fix UAF and buffer leak in cifs_check_trans2()" failed to apply to 5.10-stable tree
To: sorenson@redhat.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:26:05 +0200
Message-ID: <2026090305-henchman-snipping-25aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 730d0bb19507b9e19c2fe5343109ac618e2fbce5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090305-henchman-snipping-25aa@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 730d0bb19507b9e19c2fe5343109ac618e2fbce5 Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Wed, 12 Aug 2026 21:39:51 -0500
Subject: [PATCH] smb: client: fix UAF and buffer leak in cifs_check_trans2()
 for malformed secondary T2

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

diff --git a/fs/smb/client/smb1transport.c b/fs/smb/client/smb1transport.c
index 66daa5a37e4a..42e95cc1bd89 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -449,10 +449,18 @@ bool
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

