Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090CB38D
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161085; cv=none; b=YOIr8qKR9d5NW7SaQLc5MhKZd6YunyFf+vRpYsnSyGDcEq1q0eVRSHzUJLXxWqbx8E9WmoXSxFRcnNqlUkwYt3Q3mQQZbmjW9gWhEt16OeGSSlZUEWFtomatSXvBYc5Sd5z8JM/bxnUjrOOAvY2TmWCkA+gAbr6DDijCRRGvQxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161085; c=relaxed/simple;
	bh=Dwak2X8ug1+O5w1ginv9rTPC6Vd6vCeMy0xItYVbPtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4LfCwedfK2z/mHGF1UZxC6wgLQ2po+D6chfwURhO7ICRG0DieOtDH2LK7PxAM/gU6LzWtSX6hjmn/WycTZDCgQ1v984gMObNscy1L8XCJyRBlfwJx3AlF2vdYTlY5YiGIreXrKHSJZ4ncSWcsCQQQF91s/VefTASxT+cdjOEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKz8Y7I/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKz8Y7I/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC871F000E9
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 07:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788161083;
	bh=V4tCMQDBO+Y0yv576KgJ9uC7rdHznojwiVTQ/LHcN8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WKz8Y7I/WalnjVawpNSMCEZnu/Lwb3vOHK5eKkY96O8POEPww5fPPmNY/KStKBKKP
	 P/Zbc+9LOYzp9WV2irVEBMgL9PNGr/Hf+5HwGE4E5zbUtrWJ1EC+joiTKWUShmat7Q
	 2MxnivuN6fCOS2z2fe6P2lSH9fnwJL/eU0nyIZSwtW6qOBVhPPggeX4ZHkJA9RwiGD
	 5I0Vi3eNj1AaIAEGBLD2xuzJ9YTB1RJhk4Nl1QtQMt0HJySnCVTR0L24bUHn9N+NKJ
	 qbtBv3nGszl4kR4r4vf9eHM6/1/ONpa2KfqfGh8soOKgDhP5EWOUjdMQtDDgSxPIqY
	 I2DUWqgJAQSCg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so3919184a12.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 00:24:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwoQZNmv0g9spYya9IBkoivWIqkPoyvGUSpD1pfnxl8CArUoUDEZ0GJVyWR8iYxecKcFVbV1t8=@vger.kernel.org
X-Gm-Message-State: AFuF++l3PZJyBU9nqHCAt6yUREaoJBNeRKpJLKH73f0dR9WM4PXlevHq
	pX4gygb//6/Cu5TXysLRkUmUhAsmslgV8bNrwIbO/GpUTPpKCGmk/cCkjHUftRQW/ZmD34KH6du
	58YtU7idisEoLI6Msfv8B4dBzdKEfEyU=
X-Received: by 2002:a05:6402:c44:b0:6a6:32fa:1e9a with SMTP id
 4fb4d7f45d1cf-6a632fa1f2bmr5986166a12.18.1788161082357; Mon, 31 Aug 2026
 00:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828061607.240845-1-zenghongling@kylinos.cn> <20260828061607.240845-2-zenghongling@kylinos.cn>
In-Reply-To: <20260828061607.240845-2-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 31 Aug 2026 16:24:29 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_v3iw1N9PxDznpGRu4yE2atNG=7WPYM4Z2xNFq2tMx2g@mail.gmail.com>
X-Gm-Features: AcwNN1UE3hrpbCfdKuNuk-KlWFB8oCsf6qM7Zhviul1R6n6HDA3WqghENaKoscc
Message-ID: <CAKYAXd_v3iw1N9PxDznpGRu4yE2atNG=7WPYM4Z2xNFq2tMx2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ntfs: take invalidate_lock in ntfs_filemap_page_mkwrite()
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>         if (NInoWofCompressed(NTFS_I(inode)))
> @@ -684,7 +685,14 @@ static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
>         sb_start_pagefault(inode->i_sb);
>         file_update_time(vmf->vma->vm_file);
>
> +       /*
> +        * Serialize against truncate/fallocate which hold the lock
> +        * exclusively while invalidating pagecache and changing extents.
> +        */
> +       filemap_invalidate_lock_shared(mapping);
>         ret = iomap_page_mkwrite(vmf, &ntfs_page_mkwrite_iomap_ops, NULL);
> +       filemap_invalidate_unlock_shared(mapping);
> +
Please move filemap_invalidate_unlock() after truncate_pagecache() and
pagecache_isize_extended(). Otherwise, ntfs_filemap_page_mkwrite() can
race with the page-cache cleanup after fallocate extends the file.

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 1969e4f444f7..a266105180a9 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1178,13 +1178,15 @@ static long ntfs_fallocate(struct file *file,
int mode, loff_t offset, loff_t le

        err = file_modified(file);
 out:
+       if (!err && mode == 0 && NInoNonResident(ni) &&
+           offset > old_size) {
+               truncate_pagecache(vi, old_size);
+               pagecache_isize_extended(vi, old_size, offset);
+       }
+
        filemap_invalidate_unlock(vi->i_mapping);
+
        if (!err) {
-               if (mode == 0 && NInoNonResident(ni) &&
-                   offset > old_size) {
-                       truncate_pagecache(vi, old_size);
-                       pagecache_isize_extended(vi, old_size, offset);
-               }
                NInoSetFileNameDirty(ni);
                inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
                mark_inode_dirty(vi);
