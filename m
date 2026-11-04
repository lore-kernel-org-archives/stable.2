Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802945;
	b=itgbOdDlRfqThHFC48w5r2M9BJprvo9xzCoH33oktP8+Ce6DN0Hc3iB+db7jalSJ2c4/
	 u7lZFsAdPUJCCX75XwI3V/3U+el4aMi+n/RffQFsMKHVjWXn8x77ofjIMOXwQSsgaYOhu
	 0O0PhbhsV1sis+UaBpRZaYd8oKCWip4FzJPDu3smkAV20cIScR1Qj+F7DVkKutlPTxLVE
	 P40bRFeThkK/6m8tC8fuEzRH86n3mTjGTLmqNsJ+oxxOIoyWUs/dj7UQKvMwhDyRsADvO
	 T9F2mCZo3wo4atuVwk0YPnYFBh+hwXbfedCzg9qQSWOOsADzQbFvZp2Beo2AMvbpd6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802945;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qTwtOdDYhB9bYfKrPxEHBGRh6X+d3HQeKEwR3AgOAJs=;
	b=B+Q2cFr5XL0zvPggluAsJEcX//x6q/tG09OvVlijD/bnIeY4cqL96bkNUOcKlvUIB2a3
	 nmVn6jwHYqijWspQPqGtz8ZisxA/K9a6DDgUCbMUqOFrfahmBRjezUdJoJwDGWBaH8+o5
	 1WRfHgwfEBC1sWOJN4vhSWgipWyjH4Kxvr6WhXfWXXjQv49bHD/kt07u03R39faKttAt7
	 BjKZ4WnFQsG3naCzjOiMl9IbLcSZRNeOe3RKM0g7Ug7Peyx9S+WAH7wH4n4udpYEqlnJ2
	 NJ2MgPIjcajs6eYwNlkK8XN9dlbmnw6rY796toFmrJRmYrkMCjKjhHIcML6n8egnUEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WQ3RjX59;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD55606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WQ3RjX59
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2511F00919;
	Wed,  4 Nov 2026 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802945;
	bh=qTwtOdDYhB9bYfKrPxEHBGRh6X+d3HQeKEwR3AgOAJs=;
	h=Subject:To:Cc:From:Date;
	b=WQ3RjX592TNX9h7v2KK1k1/J6j80L2Zk2XgSDJbzjhf4u4jEDE/mC2oiGgBw8a4ha
	 noUSFboTknHSwKmFwM/NjYAFHQf0R2IL9A/ekzqEcAaa1yj9FYb6sA6lV8L9ayXV8p
	 /5nC86vuwTTH1ABKgjsPY8xwLSEb0l/+ZgHMmezE=
Subject: FAILED: patch "[PATCH] ovl: always encode the origin fh when index is enabled" failed to apply to 6.6-stable tree
To: mason@kernel.org,amir73il@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:35:44 +0100
Message-ID: <2026110444-paralysis-cement-a86c@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 949f9d8a5580c77a45fa759123367682aba4d173
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110444-paralysis-cement-a86c@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 949f9d8a5580c77a45fa759123367682aba4d173 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Fri, 16 Oct 2026 21:17:07 +0000
Subject: [PATCH] ovl: always encode the origin fh when index is enabled

On an overlay with index=on,nfs_export=on, copy up of a directory
crashes the kernel once an LSM has started to deny CAP_DAC_READ_SEARCH
to the mounter, the task that mounted the overlay. The mount and the LSM
policy change require root. After that, any user who can write to a
directory that exists only in a lower layer triggers the oops by doing
so.

Before a file or directory that exists only in a lower layer is changed
for the first time, overlayfs copies it to the writable upper layer.
This is called copy up.

On copy up, ovl_get_origin_fh() encodes the file handle of the lower
inode, called the origin. It returns NULL if ovl_can_decode_fh() says
that the lower filesystem cannot decode handles. Whether the callers can
handle NULL depends on the index option:

- Without an index, NULL is fine: the callers store an empty origin
  xattr.
- With index enabled, overlayfs keeps entries for copied up inodes in an
  internal index directory. The name of an index entry is derived from
  the handle, so ovl_get_origin_fh() must return a handle or an error.

The mount only enables the index if ovl_can_decode_fh() succeeds for all
layers, but the result can change later. The function checks the export
operations of the filesystem and capable(CAP_DAC_READ_SEARCH). Copy up
runs with the mounter's credentials, and an LSM can start to deny the
capability to those credentials after the mount. ovl_get_origin_fh()
then returns NULL with index enabled.

This goes wrong in two callers:

- With nfs_export=on, copy up of a directory creates an index entry for
  the directory. ovl_create_index() passes the NULL handle to
  ovl_get_index_name_fh(), which dereferences it.
- If the result changes while mount(2) is still running,
  ovl_get_indexdir() passes a NULL from ovl_get_origin_fh() to
  ovl_verify_set_fh() in the same way.

Before the commit in the Fixes tag, these two callers encoded the handle
themselves, without consulting ovl_can_decode_fh().

Reproduced with a BPF LSM program that started to deny the capability
after the mount. An unprivileged touch in a directory that had not been
copied up yet oopsed in ovl_get_index_name_fh(). With this patch the
touch succeeds and the directory gets its index entry.

Fix this by calling ovl_can_decode_fh() in ovl_get_origin_fh() only when
index is disabled.

Fixes: 5b02bfc1e7e3 ("ovl: do not encode lower fh with upper sb_writers held")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 0cd76ca5b8d7..c147ad155b79 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -474,8 +474,12 @@ struct ovl_fh *ovl_get_origin_fh(struct ovl_fs *ofs, struct dentry *origin)
 	 * When lower layer doesn't support export operations store a 'null' fh,
 	 * so we can use the overlay.origin xattr to distignuish between a copy
 	 * up and a pure upper inode.
+	 *
+	 * With index enabled, mount already found that all layers can decode
+	 * file handles.  Do not ask again, because an LSM may change its answer
+	 * about CAP_DAC_READ_SEARCH and index users cannot cope with a 'null' fh.
 	 */
-	if (!ovl_can_decode_fh(origin->d_sb))
+	if (!ofs->config.index && !ovl_can_decode_fh(origin->d_sb))
 		return NULL;
 
 	return ovl_encode_real_fh(ofs, d_inode(origin), false);

