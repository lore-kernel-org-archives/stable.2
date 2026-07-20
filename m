Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47047434E27
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562509; cv=none; b=f22CihwgwpKV+UVzMzw2JB89pV4aSSKysvJeXH1dymzesTQvo7DRH2rTAtA/SXzL0+idgOzCNhywRnYSrHyLTRIYxG242tdXPYWWrX66K35kTYlE3kpvRiC6h/dVa6CQCBQzvmtzQxOEz9COmVdDTQ9dvPnuRvTBoTkJjbj2VhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562509; c=relaxed/simple;
	bh=9SrXS1sbmRLOzrAn7qDAhDWT/7qZmh7/qvkhjQoCTnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTTD2PcP5nH27vJJKn6Sfh/w1UPZVPCkB6EB7twMU0dZsF8ONP21ZW4wgdUc8+RaTvJWRW4zUV415zeh01QB9EZ3dWm9CnquieiGwHFE69lUtcPpL3E+7xEnmU98iREIfYKVPG0yvlSKM+ul/23gJNSwGx9+OYReoYGCoXY0/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m97wtsbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m97wtsbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763531F000E9;
	Mon, 20 Jul 2026 15:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784562508;
	bh=CvmH3t6cqqMNa2xdCW7Cdmcld9x/hpRFW+Yc11G5jJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m97wtsbZrWJKZKsaOjhXK1z4UXxXCAGEkSmQZLpXf7CXjOnczt6DGct2ZdNceIVb2
	 6p+1hlEaW7W5EZZLWpXHXwICesl2wf6DSsc41+BYGWjIFWO16N9bp1BVbXV1NJqZWK
	 Hn8V5XE7SF4vkje7aQxUoS/AyqPMqjW9wv3NVarle4bvQxoCMz1qBNplr7goxN7AL3
	 3bpuIA3A/YCiQD8VB+TevsL/QS4G917csgSyL+LA0mvAsz4VmUHq6unc4CAG7McajL
	 k3O2uXuW22diuPECrbqme0BX9nhYGUDyrOZZfz0p0hlbMzHBoHXHVftR3WmEbxtEL4
	 vhFiF/QJeQdew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: gadget: f_fs: Tie read_buffer lifetime to ffs_epfile
Date: Mon, 20 Jul 2026 11:48:25 -0400
Message-ID: <20260720154825.2322611-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071426-halogen-shrubbery-b87a@gregkh>
References: <2026071426-halogen-shrubbery-b87a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Neill Kapron <nkapron@google.com>

[ Upstream commit 8bdcf96eb135aebacac319667f87db034fb38406 ]

Currently, ffs_epfile_release unconditionally frees the endpoint's
read_buffer when a file descriptor is closed. If userspace explicitly
opens the endpoint multiple times and closes one, the read_buffer is
destroyed. This can lead to silent data loss if other file descriptors
are still actively reading from the endpoint.

By tying the lifetime of the read_buffer to the ffs_epfile structure itself
(which is destroyed when the functionfs instance is torn down in
ffs_epfiles_destroy), we eliminate the brittle dependency on open/release
calls while correctly matching the conceptual lifetime of unread data on
the hardware endpoint.

Fixes: 9353afbbfa7b ("usb: gadget: f_fs: buffer data from ‘oversized’ OUT requests")
Cc: stable <stable@kernel.org>
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Neill Kapron <nkapron@google.com>
Link: https://patch.msgid.link/20260619040609.4010746-3-nkapron@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adjusted context in ffs_epfiles_destroy() since 6.12 lacks the simple_remove_by_name() rework and still uses dentry-based cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6efa8ac71b1a08..bfee2eece27cd5 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1291,7 +1291,6 @@ ffs_epfile_release(struct inode *inode, struct file *file)
 
 	ENTER();
 
-	__ffs_epfile_read_buffer_free(epfile);
 	ffs_data_closed(epfile->ffs);
 
 	return 0;
@@ -1955,6 +1954,7 @@ static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count)
 
 	for (; count; --count, ++epfile) {
 		BUG_ON(mutex_is_locked(&epfile->mutex));
+		__ffs_epfile_read_buffer_free(epfile);
 		if (epfile->dentry) {
 			d_delete(epfile->dentry);
 			dput(epfile->dentry);
-- 
2.53.0

