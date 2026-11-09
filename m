Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189961;
	b=pK4h4QvdFtL9LKvpY4fE7rMRIttYM4oDkGVdUgLS5DUxiyY5AxNy5gcBL3Su/qaITclq
	 m60FYshhLIIqAPmmO98DzXnK5CdPLNzFRfto+PJtsl/p/tpLKbBEcqFrJPcieO8LIFohG
	 zp5fq5zkmPAvGJ83GdrfkQdipneAmVvYMX6b3m6Ik45oanBQAWy/Zqzr0ozGeym1+rY8Q
	 Whg/fzAaCJlto4+rMkwkTQFv9yD41jiU5E98LntpIg4Z9iPjqkE7D8SfhdSt6t7ZU5Mwg
	 jVyTE5j+hwHULIe5kMFiSdYXydvd2+55fw4XwR70no4N0CY0Xl0tXqIzca4oNAb2hUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aj9oR9Ww8FoQrbaajKI3tgdOoEt+pimjjkjSqzvb7B0=;
	b=lc6KRYU7KiUWcRm++W3jyIk0fCw5ZJokpjcEK+gXUAk8oLYNG5+TUxqTOMLfMeO+1xoH
	 1smW33neN0IpmGo4E72VpTnmwSOHnNYHBAeYDwO8mPk2mUb52pv+985m6T3WyZjfITAoF
	 /FoujqjNsYaPc2nw3D73im/2ehG4JJ2Ep+avxq/g8pN0eqMaKn57kcC36GW6czVK2rYIY
	 7ilBtKg/bN4czTr9MuBG4hO3Xjl5GgaDA4qMIamjZC2vgPvDYjvqJdpnq4W1bbXSi7B8q
	 Bk0RhC98FPJ3E5vMQh2WGMeKj+1M3k6V3EpebWEOqdP+2e8YDKqNPqPvKIYcyNsDfvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uv0OdyJq;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752C606A320
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4752C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uv0OdyJq
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37198ed3727so594441eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 18:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794189959; x=1794794759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aj9oR9Ww8FoQrbaajKI3tgdOoEt+pimjjkjSqzvb7B0=;
        b=uv0OdyJqexO4HHQPX7ing3MyQxnuXcDSupkfl2rTn8US3X0SGCLZkZ39UdnAlHBQ7k
         iBnIYmncCRRgY9gbfDvdpGMJzYza0k7K55fZLI6u50bqLcffxkyBh4lnSUh5Qt9afOJP
         Mb9QLeHc988GsncdPodk8Rmt/khqaj3BVkbW+SLaKTZmPOcvIgcAhJcYMeEfTqsVdDU2
         CMSBsNyUQdeT4VmWFgGtQoRNdMEMR58WRJyq9qHc2Ak37aJQwzaqZIT/kf8kympEGyx4
         iIwURrAtBSbMZ4Yy78P8asAmSpPsU3H5Y4Q0p+h8lhHASbvabth/61+hVFcJU3WEZhjM
         wwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794189959; x=1794794759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aj9oR9Ww8FoQrbaajKI3tgdOoEt+pimjjkjSqzvb7B0=;
        b=PKwfGePQxD9m7BxH2VwfyDAWGboqcPBAK9OGB/TnuRJzqhKiJtiml08MqQYkFwW872
         KWeos2lCTsvd4bfXC426Iwo1QKY5w/QzdvPXIgVTuaJQjErAujDaRYYh3XTMY4stbc6c
         QBZDMLDwJetYQo7EeUkfuoQBdo7HvcpQ9S3w3hC/6FnoktJ43R9z7lW4b3m/A6KMn4qE
         yL6ny+ZohqRCABnbW/vdervreCjnm0tUTMFtlL4/RQ1X8mOclUq6wGlULI6Xw7jjJ2wI
         9tL0DMc5T8p7Sk4WppscJDG37ddZz+qWK5BGVP59XG3fScsiagBnMQkbNafiozw6tKBC
         X4sQ==
X-Forwarded-Encrypted: i=1; AL+hErHOjgdBFIyhFNmxN8TYaGbcHMY6dVnmS+2xbIajZxWmtvWEMeqY6bTxK7yWfGZI9CdDpgHNnCg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DnfyeCAE5ggUCZVVJE2TxPw16nlyiB2LO8ZTM4cXwVzavlBqP
	SiUyWsp7y0jSQgJXHVZQ1kaHoEvUWnoURIRlaSMIvym0ChqZ1yQQhl3t
X-Gm-Gg: AYBFou0Jd0F52kEpLWObMOe7PLCjtKrsj7tWGPxJG0kB71sTlbDkhOIzVzBO+5P8vKh
	judObH5uE+kCREE/5uccU7SRTnrhv9KFzkiawzb5CVkWMI6uAzUB0HCDd/3MTDajzEdB48pI9Mj
	eRbaH/FCCQqWTekVqwYDHBO2nCxWU0iYj+c9AOX1U1yBPF03vbt2hggmtI3XeEMVK2wk8D6GRp1
	cC7UlPZ5Wb5IsAEmwy8RpsKEUNrS1O3rvsUybf0d++k+JGqeRWCDxtUmXmlWXFJKUEE/1FJwlxM
	2kkiDf3D7541I6ZIQJ/jis08+9lReCf+25BmGOyL577Tmj9weHhJF64Ffz95qzH9x6oyqFicaAk
	6R/THTPeKomlqyD5Z7BBbSdSXsoa2cRXKrOJbxENXjlVoWD3ZHJJ1K9elJc1FajCRzZdxcn8yem
	F7NTmRG6KLuoip9EUf5YuC7GLGWDMbhy8b4LwZG4T1RiMLdxDXd92PKDKsTLsHko4/nkDjoxzXj
	4FZ/p+3Swo5onKejNuD3LPpKDhSuv5mShWQW08L7R84nO5GcrSG72CUIjjTquobH3RONhNBe6dF
	AGsbnpdScB4lUq1Unw==
X-Received: by 2002:a05:7022:108d:b0:17a:a3d4:8b17 with SMTP id a92af1059eb24-1b39fea5ca7mr4535840c88.12.1794189958972;
        Sun, 08 Nov 2026 18:05:58 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771f833esm9042336c88.21.2026.11.08.18.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 18:05:58 -0800 (PST)
Date: Mon, 9 Nov 2026 11:05:55 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: xkeyC <xkeyc@qq.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ntfs: don't let a fatal signal interrupt metadata reads
Message-ID: <avEqgxgLl17nq8SU@hyunchul-PC02>
References: <tencent_2859327A0C68D0D0429ED90F931234059808@qq.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_2859327A0C68D0D0429ED90F931234059808@qq.com>

Hi xkeyC, 

On Sat, Nov 07, 2026 at 05:41:23PM +0800, xkeyC wrote:
> read_mapping_folio() returns -EINTR when the caller has a fatal signal
> pending while it waits for the read it submitted. ntfs reads its metadata
> through it and treats the failure as a volume error, so killing a task
> that waits on a metadata read turns the volume read-only with
> errors=remount-ro. A read that is part of an update also stops the update
> half way: killing an rm can leave clusters allocated in $Bitmap, an MFT
> record in use without a directory entry, or a directory index with
> entries that point to freed records.
> 
> Add ntfs_read_metadata_folio(), which waits for the read uninterruptibly,
> and use it for metadata reads. Mount-time checks, compressed data and
> named stream contents keep using read_mapping_folio(). A killed task now
> waits for its metadata read to complete, as it does on filesystems that
> use the buffer cache.
> 
> Closes: https://github.com/namjaejeon/linux-ntfs/issues/98
> Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator")
> Fixes: 115380f9a2f9 ("ntfs: update mft operations")
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: xkeyC <xkeyc@qq.com>

Could you double-check the Fixes tag and Could you confirm that
xkeyC is your known identify for the sign-off?

> ---
> Reproducers and logs: https://github.com/xkeyC/linux-ntfs/tree/eintr-repro
> 
> In QEMU (KASAN, lockdep, reads throttled), killing rm, ls -l, fallocate
> or dd partway through turned the volume read-only within a few runs
> without this patch, and ntfsck found damage after rm. With it, 20 runs of
> each stayed read-write and clean. Index inserts were not reached.
> 
> Developed with an AI coding assistant (Claude Code), which wrote the
> change and the reproducers and ran the tests.
> 
>  fs/ntfs/aops.c     | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ntfs/attrib.c   |  2 +-
>  fs/ntfs/bdev-io.c  |  2 +-
>  fs/ntfs/bitmap.c   |  4 ++--
>  fs/ntfs/dir.c      |  4 ++--
>  fs/ntfs/inode.c    | 12 +++++++---
>  fs/ntfs/lcnalloc.c |  2 +-
>  fs/ntfs/mft.c      | 20 ++++++++--------
>  fs/ntfs/ntfs.h     |  4 ++++
>  9 files changed, 88 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
> index ad781674f..767aecf42 100644
> --- a/fs/ntfs/aops.c
> +++ b/fs/ntfs/aops.c
> @@ -7,6 +7,7 @@
>   * Copyright (c) 2025 LG Electronics Co., Ltd.
>   */
>  
> +#include <linux/swap.h>
>  #include <linux/writeback.h>
>  
>  #include "attrib.h"
> @@ -304,6 +305,63 @@ static int ntfs_swap_activate(struct swap_info_struct *sis,
>  			&ntfs_read_iomap_ops);
>  }
>  
> +/**
> + * ntfs_read_metadata_folio - read a metadata folio, ignoring fatal signals
> + * @mapping:	address space of the metadata inode or block device
> + * @index:	page cache index to read
> + *
> + * Like read_mapping_folio(), but the wait for the read cannot be interrupted,
> + * so a fatal signal cannot fail a metadata read in the middle of an update.
> + * The caller must not hold the lock of the folio at @index.
> + *
> + * Return: the uptodate folio with a reference held, or an ERR_PTR().
> + */
> +struct folio *ntfs_read_metadata_folio(struct address_space *mapping,
> +				       pgoff_t index)
> +{
> +	struct folio *folio;
> +	bool read_failed = false;
> +	int err;
> +
> +	folio = filemap_get_folio(mapping, index);
> +	if (!IS_ERR(folio)) {
> +		if (folio_test_uptodate(folio))
> +			goto out;
> +		folio_put(folio);
> +	}
> +repeat:
> +	folio = __filemap_get_folio(mapping, index, FGP_LOCK | FGP_CREAT,
> +				    mapping_gfp_mask(mapping));
> +	if (IS_ERR(folio))
> +		return folio;
> +	/* $MFT updates clear uptodate under the folio lock, so check it locked. */
> +	if (folio_test_uptodate(folio)) {
> +		folio_unlock(folio);
> +		goto out;
> +	}
> +	if (read_failed) {
> +		folio_unlock(folio);
> +		folio_put(folio);
> +		return ERR_PTR(-EIO);
> +	}
> +
> +	/* ->read_folio() unlocks the folio when the read completes. */
> +	err = mapping->a_ops->read_folio(NULL, folio);
> +	if (err) {
> +		folio_put(folio);
> +		if (err == AOP_TRUNCATED_PAGE)
> +			goto repeat;
> +		return ERR_PTR(err);
> +	}
> +	folio_wait_locked(folio);
> +	read_failed = !folio_test_uptodate(folio);
> +	folio_put(folio);
> +	goto repeat;
> +out:
> +	folio_mark_accessed(folio);
> +	return folio;
> +}
> +
>  const struct address_space_operations ntfs_aops = {
>  	.read_folio		= ntfs_read_folio,
>  	.readahead		= ntfs_readahead,
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 800e53df5..cf73fa4c3 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -2323,7 +2323,7 @@ int ntfs_attr_set(struct ntfs_inode *ni, s64 ofs, s64 cnt, const u8 val)
>  
>  	index = ofs >> PAGE_SHIFT;
>  	while (cnt) {
> -		folio = read_mapping_folio(mapping, index, NULL);
> +		folio = ntfs_read_metadata_folio(mapping, index);
>  		if (IS_ERR(folio)) {
>  			ret = PTR_ERR(folio);
>  			ntfs_error(VFS_I(ni)->i_sb, "Failed to read a page %lu for attr %#x: %ld",
> diff --git a/fs/ntfs/bdev-io.c b/fs/ntfs/bdev-io.c
> index 4f27eed3b..afb1d1df3 100644
> --- a/fs/ntfs/bdev-io.c
> +++ b/fs/ntfs/bdev-io.c
> @@ -99,7 +99,7 @@ int ntfs_bdev_write(struct super_block *sb, void *buf, loff_t start, size_t size
>  	for (; idx < idx_end; idx++, from = 0) {
>  		u32 len;
>  
> -		folio = read_mapping_folio(sb->s_bdev->bd_mapping, idx, NULL);
> +		folio = ntfs_read_metadata_folio(sb->s_bdev->bd_mapping, idx);
>  		if (IS_ERR(folio)) {
>  			ntfs_error(sb, "Unable to read %ld page", idx);
>  			return PTR_ERR(folio);
> diff --git a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
> index af86fb1c1..1002d9c98 100644
> --- a/fs/ntfs/bitmap.c
> +++ b/fs/ntfs/bitmap.c
> @@ -203,7 +203,7 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
>  
>  	/* Get the page containing the first bit (@start_bit). */
>  	mapping = vi->i_mapping;
> -	folio = read_mapping_folio(mapping, index, NULL);
> +	folio = ntfs_read_metadata_folio(mapping, index);
>  	if (IS_ERR(folio)) {
>  		if (!is_rollback)
>  			ntfs_error(vi->i_sb,
> @@ -267,7 +267,7 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
>  		folio_unlock(folio);
>  		kunmap_local(kaddr);
>  		folio_put(folio);
> -		folio = read_mapping_folio(mapping, ++index, NULL);
> +		folio = ntfs_read_metadata_folio(mapping, ++index);
>  		if (IS_ERR(folio)) {
>  			ntfs_error(vi->i_sb,
>  				   "Failed to map subsequent page (error %li), aborting.",
> diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> index 9fb5bb3d3..ce87799a2 100644
> --- a/fs/ntfs/dir.c
> +++ b/fs/ntfs/dir.c
> @@ -327,8 +327,8 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni, const __le16 *uname,
>  	 * of PAGE_SIZE and map the page cache page, reading it from
>  	 * disk if necessary.
>  	 */
> -	folio = read_mapping_folio(ia_mapping, vcn <<
> -			dir_ni->itype.index.vcn_size_bits >> PAGE_SHIFT, NULL);
> +	folio = ntfs_read_metadata_folio(ia_mapping, vcn <<
> +			dir_ni->itype.index.vcn_size_bits >> PAGE_SHIFT);
>  	if (IS_ERR(folio)) {
>  		ntfs_error(sb, "Failed to map directory index page, error %ld.",
>  				-PTR_ERR(folio));
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 62dd5bd5b..9bf7957af 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -3773,8 +3773,14 @@ s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
>  
>  	index = pos >> PAGE_SHIFT;
>  	do {
> -		/* Update @index and get the next folio. */
> -		folio = read_mapping_folio(mapping, index, NULL);
> +		/*
> +		 * Update @index and get the next folio.  The contents of a named
> +		 * stream are user data, so a fatal signal may still stop that read.
> +		 */
> +		if (ntfs_inode_is_named_stream(ni))
> +			folio = read_mapping_folio(mapping, index, NULL);
> +		else
> +			folio = ntfs_read_metadata_folio(mapping, index);
>  		if (IS_ERR(folio)) {
>  			err = PTR_ERR(folio);
>  			break;
> @@ -3926,7 +3932,7 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
>  				break;
>  			}
>  		} else {
> -			folio = read_mapping_folio(mapping, index, NULL);
> +			folio = ntfs_read_metadata_folio(mapping, index);

The read when writing to non-resident stream should remain
interruptible.

>  			if (IS_ERR(folio)) {
>  				ret = PTR_ERR(folio);
>  				ntfs_error(vi->i_sb, "Failed to read a page %lu for attr %#x: %ld",
> diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
> index 3ebcac4c2..7e00016f4 100644
> --- a/fs/ntfs/lcnalloc.c
> +++ b/fs/ntfs/lcnalloc.c
> @@ -340,7 +340,7 @@ struct runlist_element *ntfs_cluster_alloc(struct ntfs_volume *vol, const s64 st
>  		if (vol->lcn_empty_bits_per_page[index] == 0)
>  			goto next_bmp_pos;
>  
> -		folio = read_mapping_folio(mapping, index, NULL);
> +		folio = ntfs_read_metadata_folio(mapping, index);
>  		if (IS_ERR(folio)) {
>  			err = PTR_ERR(folio);
>  			ntfs_error(vol->sb, "Failed to map page.");
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index 89288b794..3601f77ee 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -143,7 +143,7 @@ static inline struct mft_record *map_mft_record_folio(struct ntfs_inode *ni)
>  	}
>  
>  	/* Read, map, and pin the folio. */
> -	folio = read_mapping_folio(mft_vi->i_mapping, index, NULL);
> +	folio = ntfs_read_metadata_folio(mft_vi->i_mapping, index);
>  	if (!IS_ERR(folio)) {
>  		u8 *addr;
>  
> @@ -549,8 +549,8 @@ static int ntfs_sync_mft_mirror_unit(struct ntfs_volume *vol,
>  	if (unit->folio_ofs + unit->len > folio_size(source))
>  		return -EIO;
>  
> -	mirror = read_mapping_folio(vol->mftmirr_ino->i_mapping,
> -				    mirror_file_ofs >> PAGE_SHIFT, NULL);
> +	mirror = ntfs_read_metadata_folio(vol->mftmirr_ino->i_mapping,
> +					  mirror_file_ofs >> PAGE_SHIFT);
>  	if (IS_ERR(mirror))
>  		return PTR_ERR(mirror);
>  
> @@ -1023,7 +1023,7 @@ static bool mft_reserved_is_free(struct ntfs_volume *vol,
>  	if (!m)
>  		return false;
>  
> -	folio = read_mapping_folio(vol->mft_ino->i_mapping, index, NULL);
> +	folio = ntfs_read_metadata_folio(vol->mft_ino->i_mapping, index);
>  	if (IS_ERR(folio))
>  		goto free_m;
>  
> @@ -1199,8 +1199,8 @@ static s64 mft_bitmap_alloc_free_rec(struct ntfs_volume *vol,
>  		 * for a zero bit.
>  		 */
>  		if (size) {
> -			folio = read_mapping_folio(mftbmp_mapping,
> -					ofs >> PAGE_SHIFT, NULL);
> +			folio = ntfs_read_metadata_folio(mftbmp_mapping,
> +							 ofs >> PAGE_SHIFT);
>  			if (IS_ERR(folio)) {
>  				ntfs_error(vol->sb, "Failed to read mft bitmap, aborting.");
>  				return PTR_ERR(folio);
> @@ -1392,8 +1392,8 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
>  	 * to us.
>  	 */
>  	ll = lcn >> 3;
> -	folio = read_mapping_folio(vol->lcnbmp_ino->i_mapping,
> -			ll >> PAGE_SHIFT, NULL);
> +	folio = ntfs_read_metadata_folio(vol->lcnbmp_ino->i_mapping,
> +					 ll >> PAGE_SHIFT);
>  	if (IS_ERR(folio)) {
>  		up_write(&mftbmp_ni->runlist.lock);
>  		ntfs_error(vol->sb, "Failed to read from lcn bitmap.");
> @@ -2207,7 +2207,7 @@ static int ntfs_mft_record_format(const struct ntfs_volume *vol, const s64 mft_n
>  	}
>  
>  	/* Read, map, and pin the folio containing the mft record. */
> -	folio = read_mapping_folio(mft_vi->i_mapping, index, NULL);
> +	folio = ntfs_read_metadata_folio(mft_vi->i_mapping, index);
>  	if (IS_ERR(folio)) {
>  		ntfs_error(vol->sb, "Failed to map page containing mft record to format 0x%llx.",
>  				(long long)mft_no);
> @@ -2725,7 +2725,7 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol, const int mode,
>  	index = NTFS_MFT_NR_TO_PIDX(vol, bit);
>  	ofs = NTFS_MFT_NR_TO_POFS(vol, bit);
>  	/* Read, map, and pin the folio containing the mft record. */
> -	folio = read_mapping_folio(vol->mft_ino->i_mapping, index, NULL);
> +	folio = ntfs_read_metadata_folio(vol->mft_ino->i_mapping, index);
>  	if (IS_ERR(folio)) {
>  		ntfs_error(vol->sb, "Failed to map page containing allocated mft record 0x%llx.",
>  				bit);

Other paths still using interruptible reads include $LogFile and
$MFTMirr checks, $AttrDef and $Upcase loading, bitmap scans through
ntfs_get_locked_folio(), and ntfs_bitmap_check_used().

> diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
> index fac72d40f..f33df986f 100644
> --- a/fs/ntfs/ntfs.h
> +++ b/fs/ntfs/ntfs.h
> @@ -294,6 +294,10 @@ static inline int ntfs_ffs(int x)
>  	return r;
>  }
>  
> +/* From fs/ntfs/aops.c */
> +struct folio *ntfs_read_metadata_folio(struct address_space *mapping,
> +				       pgoff_t index);
> +
>  /* From fs/ntfs/bdev-io.c */
>  int ntfs_bdev_read(struct block_device *bdev, char *data, loff_t start, size_t size);
>  int ntfs_bdev_write(struct super_block *sb, void *buf, loff_t start, size_t size);
> -- 
> 2.56.0
> 

-- 
Thanks,
Hyunchul
