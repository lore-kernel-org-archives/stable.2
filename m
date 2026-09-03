Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716C4B1269
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443292; cv=none; b=fNyYvt9LqRN4uu7tmpHTJjCEnUXNnb3MbD01cDqzK4yHl4/RQLoHY2QlXs4tulcGogjCAjJnh2MCbWoOOzltncIq00/rChbDYwDh9srGDrBFjq/j2eJpkaYOcTRf9hzNabQacETyqSFHCaxNFKZFuOPgqVW+vE4KkUE5oXCL/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443292; c=relaxed/simple;
	bh=xieixY3hmcWJPPsvu1YBG5IppBE5VTuihtktktQVCM0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=caKvjiqW6BzJPoNMXwkl9kvC94vcKcv1bd6OWUP1I2ytScIgOEJJOtlnunR3xIMkpsEi1wS6kQen18slJzlEPXzl0nZNbc4KX0DnLTjc883hunWTtFOttLmfnSckYeuk7ehntZEtJQugWybt8jqcToAuKbkQuOn2yGOd0e4WFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CscXCPBk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CscXCPBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2862B1F00A3A;
	Thu,  3 Sep 2026 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443284;
	bh=qLZoP62k4mzju7eVKn7II0ZhLgZi6/E2923MaxECjm8=;
	h=Subject:To:Cc:From:Date;
	b=CscXCPBkCfr+Amx8ciBlejmls9GsptY30h2GpduRL+IYC7ikEXrWJ93IiUXbQ2xbp
	 8nsYjp+L5ffRqYNN7IgrG2p75mAdNbB7KOUkjZ1oy/vVWLSuHLNIyQpxLtnQfRFNi6
	 re/jdTYPCV7Rq6RU3z315wlGbqNK/IUIclfrfV08=
Subject: FAILED: patch "[PATCH] cifs: fix loff_t underflow in cifs_remap_file_range() when" failed to apply to 5.10-stable tree
To: sorenson@redhat.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:25:22 +0200
Message-ID: <2026090322-dweeb-catchy-bac2@gregkh>
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
git cherry-pick -x 6c322f5cf7476ded7a9a20f7be72462065a03c68
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090322-dweeb-catchy-bac2@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6c322f5cf7476ded7a9a20f7be72462065a03c68 Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Sat, 22 Aug 2026 16:55:17 -0500
Subject: [PATCH] cifs: fix loff_t underflow in cifs_remap_file_range() when
 len == 0

With len == 0 (clone to EOF), the effective length is computed as:

    len = src_inode->i_size - off;

If off > i_size, this is a negative loff_t, corrupting the ByteCount
in the FSCTL_DUPLICATE_EXTENTS_TO_FILE request and inverting the range
in filemap_write_and_wait_range().  The existing off >= i_size check
fires only after the ioctl has already been sent.

Snapshot i_size_read() once for both the bounds check and the length
calculation, eliminating the TOCTOU and 32-bit torn-read risk.  Reject
off > src_size with -EINVAL.  Treat off == src_size as a no-op,
consistent with __generic_remap_file_range_prep().

Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2073b29ff969..7ecd70efdfea 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1413,8 +1413,19 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	 */
 	lock_two_nondirectories(target_inode, src_inode);
 
-	if (len == 0)
-		len = src_inode->i_size - off;
+	if (len == 0) {
+		loff_t src_size = i_size_read(src_inode);
+
+		if (off > src_size) {
+			rc = -EINVAL;
+			goto unlock;
+		}
+		len = src_size - off;
+		if (!len) {
+			rc = 0;
+			goto unlock;
+		}
+	}
 
 	cifs_dbg(FYI, "clone range\n");
 

