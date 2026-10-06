Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D022425B
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272567; cv=none; b=AeCud4PC/KR3s2VknXt+/LbdxHc6k1inpDCXvHUK9T+N3kNYApwvLrNUhH77ChD6F2f0LeQdHhsGOvgkhu7Kjbj+iB2QdvYkf8+n0jane6M0K6awOnIKlTTRquRhMbd+vOMQUcK3L8y5H2BmphBl4zfZ3yjp0/1M2CF3/7j4hKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272567; c=relaxed/simple;
	bh=bdG4xlmQKvzog15FzXKy4B66wcGbkaS3KeDqwQszfoE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G+fZScbwz5NBpXEOlfwWeGi9i4LNiSxtGo7Ul6hVgUtyzw0jyiCvsictnOoK8l/QvzaqHmqyKGI4DVU8Knisops65n0YEfgHtkyle3++JJHQLshbapS8HzWYG1auqk8YYr/nR1rM9x0u0f3NF/Ux5gYDkE4+cXvqh93n8/a81Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ib3wsnBN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ib3wsnBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A2F1F000FF;
	Tue,  6 Oct 2026 07:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272566;
	bh=4glHT0XijwMKGS9IOz3LpsGKSVBdK/f0e54Lp28XLT8=;
	h=Subject:To:Cc:From:Date;
	b=Ib3wsnBNkEo7TpAXqQJGtwvQP6BW57YQB4v2wpeIEzh9FBWlBbcDdsfJCOGA6Y4Ze
	 ihffsMg/SaKrNW+nIMtpHqjqfd9fK5CfnPP8wr+bJMMlMbJaQ92Xw7AB61T3OMPMrJ
	 A9VD3C1PAnLiSyxoRQZCIlh4+tttrTVIKaaaGaG0=
Subject: FAILED: patch "[PATCH] smb: client: drain outstanding I/O before truncating on" failed to apply to 7.2-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,brauner@kernel.org,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sorenson@redhat.com,sprasad@microsoft.com,tom@talpey.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:42:30 +0200
Message-ID: <2026100630-smoked-amusing-608a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 3581f843defa0bb30fd7da1e7dba170465e13a95
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100630-smoked-amusing-608a@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3581f843defa0bb30fd7da1e7dba170465e13a95 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Fri, 25 Sep 2026 20:16:09 -0300
Subject: [PATCH] smb: client: drain outstanding I/O before truncating on
 O_TRUNC open

cifs_do_truncate() flushes the pagecache with filemap_write_and_wait()
before resetting the file size to zero, but that does not wait for
direct/async I/O that was already in flight, which can complete after the
truncate and reinstate stale data past the new EOF.

Drain outstanding netfs I/O with netfs_wait_for_outstanding_io()
before resizing the file.

Reported-by: Frank Sorenson <sorenson@redhat.com>
Fixes: a8603b52b39f ("smb: client: fix data corruption with concurrent writes and O_TRUNC")
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

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 4bcb87610897..11355d6bf89d 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1012,6 +1012,8 @@ static int cifs_do_truncate(const unsigned int xid, struct dentry *dentry)
 	}
 	mapping_set_error(inode->i_mapping, rc);
 
+	netfs_wait_for_outstanding_io(inode);
+
 	cfile = find_writable_file(cinode, FIND_FSUID_ONLY);
 	rc = cifs_file_flush(xid, inode, cfile);
 	if (!rc) {

