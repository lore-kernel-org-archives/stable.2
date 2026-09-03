Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE254B1294
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443322; cv=none; b=RNwHJqQVH2Fl0CpmtSY1KFQADl/uDH7S3wsZ36QiRwxyGSGTd1kusOKpUgc30xHAb7ewsvxUggl1+3CLrQIbKu5CIFSNxDozyhK5Y1eUhL44Yjaew0ygonnFnRciqRcFSOyCspxkU2FK090/MXFI43fyZcXx/I+vRsc6dcm/sho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443322; c=relaxed/simple;
	bh=DgkW3QSGswuhx5FRfSwzM0hsJXSQq7h2sZyblnDy9yk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b9rN0AiOgza7Ntj7DIh7czZL61LSZ6fsVSeafodFHY3f4fsKCjgke5m4/iI10E6zroP/o05zZ9dc91osjmhWi01ZPP5u524nwIcpkHvVGEWrOxoQe/7zAbAhconiPLATJt0xpmqQn3PiNoT0K/NIytRB8Qb35cfQWNWuqKITzBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=po1jcBWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="po1jcBWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC181F00A3A;
	Thu,  3 Sep 2026 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443309;
	bh=WZRw3eJOj7i55IhUDH7sYQWdRuDhlNZItzTSoRzI3Nc=;
	h=Subject:To:Cc:From:Date;
	b=po1jcBWof2sM1liXUhj7ffHQlrFcggaai3Z+BXiHbceFsZrPS/mHPYfwY6/Sxhrc4
	 cRJ3V6vqbEhyEQfKpmjfPF7tM4liU39O4ROChE81j7GV9098P4I4X2IE/4SrnxPqDp
	 C6FpvVGX7uNzTmrMBeowWa6ebnu+SUJaSAtj9Hf4=
Subject: FAILED: patch "[PATCH] smb: client: fix UAF and buffer leak in cifs_check_trans2()" failed to apply to 6.6-stable tree
To: sorenson@redhat.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:26:03 +0200
Message-ID: <2026090303-fiddling-giant-6389@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 730d0bb19507b9e19c2fe5343109ac618e2fbce5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090303-fiddling-giant-6389@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

