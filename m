Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B84AAC73
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213323; cv=none; b=oXCRLwNAN0Gb22r56R6j8OIGEyz1fxqsMPUX2jCgCUdJDJLrZZ/GWBhYHytAaktg5iqD/t4fh/zFvijP2zm4EGDaYyFvD5JviOn0JGU+/Qgo5TekAMAxc8cGsPm6PV+c4yYuMmPMOg2Ohh+83Ai5aHsX2SsoKSCA6EcaATJXtrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213323; c=relaxed/simple;
	bh=nK66EQ0a3AjREquWMR7BvnzfMufTKE6W6EtaVhEZcpo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HYytV8eMXNophcVGsYkE7ZJOa6urxfVp6hdAyv85bBpgbYSHj0Bq7eYSYr+CCfegmyC/wrBeWhZGWBNHDvqGmXDex2Y7doKWITwBHL/kfCXQWWXrdazwVezkg24yHZcoaqnDxXmkeDCLyknWt4SFtwaV8E3xey9FhuI3lKgWquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NRY6KL3X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NRY6KL3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211EA1F000FF;
	Mon,  5 Oct 2026 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791213321;
	bh=GKp6cVgDTBuizhn4qhQSlMA/BYHYZT1+eM/xFahoFts=;
	h=Subject:To:Cc:From:Date;
	b=NRY6KL3XaheYIqDlob7tWXcmNTy0Ej3RlVzS+0zpeYqHpSjJVSxcll7A4EqkR3J0c
	 8c4F4+TVwJpY25AcYky1VmYq58VQ2XrAzWyhgQiVpDlqQciBr2IrBUYVnxk1aBNePH
	 OazuCWOQTARepe7F20dFnGEYuazhC5a/6yomxQes=
Subject: FAILED: patch "[PATCH] smb: client: require stable pages for signed connections" failed to apply to 6.12-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,brauner@kernel.org,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 17:12:44 +0200
Message-ID: <2026100544-sasquatch-illusive-c85c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 53c5c2c1095eb21e214811fec16cd75f89d72ee2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100544-sasquatch-illusive-c85c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

