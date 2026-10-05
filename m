Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4554C4B0E3B
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213320; cv=none; b=T4du3ZBO8S8BK120tX6snAsgb9GSsq5VUm4Wsta3yPhww4jVFJL2MvRn1m+jdKPn084spFbhzyvn0Jgm+vjtDT5+urQTP/UhPznebo8oi75gQrPl09TPILXecif3mpznkLchP6gbe5guATgIzJ2FW4z7bKW7TUB8dy7JNUtie7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213320; c=relaxed/simple;
	bh=6gedoSFcYxymATNguVt6+jfbV9VTuAJnr1VATVqA9Z8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WpVf1Sp4Olyso0u4bS0lb9hu6hYZtbnLrkWe1w7GcO0BtXi2i1Bw02EiuIIQHTvE4QNDG60pL7qfivrJJJPalta0IZYq1nsJ8+qnv58ZdAOiGMTJM7EiVA9UFoY7BlIuMseUZr5xYIuuZRiqzvyeDBPWpFCd6Fct+xufbU+syAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A7nMv4/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A7nMv4/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF071F000FF;
	Mon,  5 Oct 2026 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791213318;
	bh=8k30wTd2dtje0Xexgxt46BK6dGaI4tXUXv+G98mct3Y=;
	h=Subject:To:Cc:From:Date;
	b=A7nMv4/TJNAZOmRA7IGVT4tpP+8wEwTnP6fwbcuzcyYEkktmpjUiU/i298TpOTkpt
	 iG23sKVLWaY6TebUD9j/qd332fxXxhGZM74yA+iAhaQ4D9VzqV5iq1RGcj4cGQgopu
	 sI4QsGi/dmo6CTT3nJn4CmGQ1SAFeehTDoGz2b2g=
Subject: FAILED: patch "[PATCH] smb: client: require stable pages for signed connections" failed to apply to 6.18-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,brauner@kernel.org,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 17:12:43 +0200
Message-ID: <2026100543-helper-putt-aa16@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 53c5c2c1095eb21e214811fec16cd75f89d72ee2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100543-helper-putt-aa16@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 53c5c2c1095eb21e214811fec16cd75f89d72ee2 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Mon, 28 Sep 2026 10:23:00 -0300
Subject: [PATCH] smb: client: require stable pages for signed connections

When signing, cifs computes the SMB signature over the pagecache folios
in place and then hands those same folios to the socket.  If a buffered
write mutates a folio while a write subrequest is still in flight, the
signature no longer matches the data that follows it, the server rejects
the write with STATUS_ACCESS_DENIED (-EACCES), and the error is latched
in the mapping, so the next fsync()/fallocate() returns -EIO.

Mark the mapping for stable writes so netfs_perform_write() waits for
writeback to complete before modifying an in-flight folio.  This is
only needed when the connection is signed.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Reviewed-by: David Howells <dhowells@redhat.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 5062474991cf..f29555f3c7d0 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -88,6 +88,8 @@ static void cifs_set_ops(struct inode *inode)
 		else
 			inode->i_data.a_ops = &cifs_addr_ops;
 		mapping_set_large_folios(inode->i_mapping);
+		if (tcon->ses->server->sign)
+			mapping_set_stable_writes(inode->i_mapping);
 		break;
 	case S_IFDIR:
 		if (IS_AUTOMOUNT(inode)) {

