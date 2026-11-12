Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448574;
	b=QJ/iKdyfFpatJPqYOFt5AXBJBZGlnq6YkspWBWBo8uAMEzCQGYBWPWzMR+wRVQQgoSSQ
	 8JnhUe1szQvfTj5CAQvyIMtZ3AeuwPEJySV/MEqc6XDJBbHCcblxmGI+09eub7aEPP9cu
	 VEgJDTKzrPbkVmffnSMB1SRFZl7q4VeHUlJkC+Vx2hGDHqQoSXFWZiEx/An+3d2Qw+A0t
	 TxQnNBoMGrBquv/Js0e8Fz/IN61ksQ+aFV/c2HcR6GYftxqGSvSkvVd8b20tj/WX3GcwB
	 64hX+cv/h4c6NsucYbpOI1JtQwRDEfMZJfvw19mrkmVnxqIrMyPNtRFkL8B450rQRrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448574;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=WNp2IsbbdHN7j8eijtKS/l6kmXS53HTe8DPmA9TvK4c=;
	b=hb6jD7D6CSOmJ5wOmCJqEZVJbuH71z+APRCUPjJ/p6lbLpQYR7po2QjZmfCASIVjUQEn
	 74Q2j1A3+Tg7m0giO7c3sQLSS1GPYKGSTR26OyqvWYx+0T1K69Kl1mF0wTu5Q84yCNugO
	 FDo95OGE7KXS1HlS62eVb1tn/GtCaUVunw6Ix28Bt48O581T7h5aaW5BoXcRvQ4M2E9KW
	 prjbN576H03q3ZwLVF5EvzzFh4o6cZz3386WAUwbcMpkcwH0VAC9iHivVuei+78LUAam/
	 I+PvUIPGAaxnK3jf+bFavC6LcjlZeYSbAu/Uft31HuXWdydsBwNILQiUgfQqvPB20tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kVReCn4e;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD7606A31C;
	Thu, 12 Nov 2026 01:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73DD7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kVReCn4e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=WNp2IsbbdHN7j8eijtKS/l6kmXS53HTe8DPmA9TvK4c=;
	b=kVReCn4eHacOsZSv8Q4ErKjxLErTe8EvT6TNkFz3bs52xK1frrvPddK+GcI8Uf
	cPo6+VX8mVEm2l9KgTQ+ub+DpAQ+r7HZFdsDww6ki9kUHYeHXQEpn09bBqcLVsxv
	IZX8RYFQFwRC2XlxTXZ6bk0HpAqHXGNTdcs7aWkPcYWOc=
Received: from [IPV6:2409:8900:1a93:3634:9bae:9736:f6e5:b25c] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXN52kHPVquqCRFQ--.48061S2;
	Thu, 12 Nov 2026 09:55:49 +0800 (CST)
Message-ID: <6629b42f-32c5-43e5-88e5-b12c358bbda9@163.com>
Date: Thu, 12 Nov 2026 09:55:48 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs: trim the sizes after a short write
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhanxusheng@xiaomi.com, stable@vger.kernel.org
References: <20261111093459.660484-1-zhanxusheng1024@gmail.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261111093459.660484-1-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAXN52kHPVquqCRFQ--.48061S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw45Wr4kKw45Kr4UZryftFb_yoW7GF13pr
	9I9Fs8t3y8JrZ7GrnxJa4xXF10vFZ5uF1UuFyYgF1fAr1vkrnFqF1UtFW09aykt3yvyw1F
	yayv9rZ5Xrn0vw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTKZAUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6QZIE2r1HKam3AAA3r



在 2026/11/11 17:34, Zhan Xusheng 写道:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> ntfs_file_write_iter() moves the data size and, for a non-resident
> uncompressed file, the initialized size to pos + count before the copy.
> __ntfs_extend_initialized_size() only zeroes [old initialized size, pos),
> so the range [pos, pos + count) is initialized only by the copy itself.
> When iomap_file_buffered_write() copies less than count, it returns a
> positive short count and the error rollback at out: does not run.  The
> file keeps the size pos + count, and [pos + ret, pos + count) reads back
> whatever the freed clusters held before, also after a remount.  A local
> user can read the old contents of freed clusters this way.
> 
> Run the existing rollback for a short write as well, and roll the two
> sizes back to the end of what was written instead of to the old sizes.
> 
> Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> A reproducer is available on request.
> 
> Tested in a VM on mainline b3dfbde62cf1, with the free space filled
> with a known pattern first.  Short append of 4M that stops after
> 1056768 bytes:
> 
>                       write()   size grows by   old data readable
>    before             1056768   4194304         3137536 bytes
>    after              1056768   1056768         0
> 
> A short write 1M past EOF gives the same results.  Full writes and
> compressed files are unchanged.
> ---
>   fs/ntfs/file.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 3213a0c9f96b..98bb3d5d420e 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -928,10 +928,21 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		ret = iomap_file_buffered_write(iocb, from, &ntfs_write_iomap_ops,
>   				&ntfs_iomap_folio_ops, NULL);
>   out:
> -	if (ret < 0 && ret != -EIOCBQUEUED) {
> +	/*
> +	 * Both sizes were moved to end before the copy, so a short write,
> +	 * like a failed one, must take back what it did not write.
> +	 */
> +	if (ret < count && ret != -EIOCBQUEUED) {
> +		loff_t new_init_size = old_init_size;
> +		loff_t new_data_size = old_data_size;
>   		int init_err = 0;
>   		int data_err = 0;
>   
> +		if (ret > 0) {
> +			new_init_size = max(old_init_size, pos + ret);
> +			new_data_size = max(old_data_size, pos + ret);
> +		}
> +
>   		/*
>   		 * Like ntfs_setattr_size(): __ntfs_attr_truncate_vfs()
>   		 * expects the invalidate lock held across the size
> @@ -940,13 +951,13 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		filemap_invalidate_lock(vi->i_mapping);
>   
>   		/* ntfs_attr_set_initialized_size() rejects a resident one. */
> -		if (ni->initialized_size != old_init_size &&
> +		if (ni->initialized_size != new_init_size &&
>   		    NInoNonResident(ni)) {
>   			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
>   
>   			mutex_lock(&mrec_ni->mrec_lock);
>   			init_err = ntfs_attr_set_initialized_size(ni,
> -					old_init_size);
> +					new_init_size);
>   			mutex_unlock(&mrec_ni->mrec_lock);
>   		}
>   		/*
> @@ -955,13 +966,13 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		 * the uninitialized tail, so skip it unless the rollback
>   		 * above restored that size.
>   		 */
> -		if (ni->data_size != old_data_size && !init_err) {
> +		if (ni->data_size != new_data_size && !init_err) {

Hi Xusheng,
    Do we also need to clear the cached bytes beyond new_init_size when 
rolling back initialized_size, independently of whether data_size changes?

    Consider a short buffered write into allocated but uninitialized 
space within the existing EOF:
old_init_size < pos + ret < end <= old_data_size
    Here new_data_size equals ni->data_size, so truncate_setsize() is 
skipped. During a short-copy retry ending inside a block, 
__iomap_write_begin() can read the whole mapped block and mark it 
uptodate, including bytes beyond pos + ret. At that point, 
ntfs_iomap_put_folio_non_resident() still sees the temporarily extended 
initialized_size, so those trailing bytes can remain uncleared.

    ntfs_attr_set_initialized_size() does not clear the page cache. A 
subsequent buffered read can therefore return those cached bytes without 
going through the read path that zeros uninitialized data.

    Could we also clear the newly uninitialized cached range under the 
invalidate lock, while preserving the successfully written prefix?

Thanks,
Baolin.

>   			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
>   
> -			truncate_setsize(vi, old_data_size);
> +			truncate_setsize(vi, new_data_size);
>   			mutex_lock(&mrec_ni->mrec_lock);
> -			data_err = __ntfs_attr_truncate_vfs(ni, old_data_size,
> -					old_data_size);
> +			data_err = __ntfs_attr_truncate_vfs(ni, new_data_size,
> +					new_data_size);
>   			mutex_unlock(&mrec_ni->mrec_lock);
>   			/* Like ntfs_setattr_size(): stay on the durable size. */
>   			if (data_err)
> 
> base-commit: b025f526c5d04929212c9d5fb7ffc96608f3eacc

