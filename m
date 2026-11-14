Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794652200;
	b=REAddHj3zShe8S7RTrqHWUY28oeUwIYcj7GaYU2DQxgvJhP8eWgstBn/twgRK3QLgFfS
	 oJ3uDpVL3242E3HG0lhyWt3L1VNZwB4JkVG6XaISZpccOoimjLXILNuBDGKOKmuV1CyZB
	 UMX2j2z31s7D+SF9HJ3OnjblRyqWoqa9VndSswQvjvxX6BRYNbWDfflSoZWc8veLjHxHt
	 BcQ4BRTA2+DhCwYFZtYncMmlLQWj7zq0fwa17ftD7tVE9CgsraTz5Spc/WBrQGxarK5Zw
	 mESGS5gOQmTaScYGOoxR7eQ1lccgpu7mWj3eryPyyWAM23c1gVNU9B3D8mGLByFSAjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794652200;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=7qzyQTytGIVocE0P2u5FtBTwHVXRHKKKFn7q9lDBX0M=;
	b=sohxdOCvUo/UvCq+vuBs+W6w0w+oCH2yKyF+QPcH0jvgdOW5hNbm8CInFCPB1m+tvKek
	 tjEIeEsSIJeBhrFd6d6C9haxiNvrInEAIFtyCwucLuI4A8otbPvZrMUjrq7c6PGBwIvoq
	 WyeeeVc2X+3vGNIo9jOQJ7f7PUmjFKmJ5DgpyOT69r+2PU99XsERFF+cGjK9I+PkhVUrq
	 eEs9BHbUtQ1L9T7BczRen6Wb2LjtSAKF9sKFJqHHoEBDouA2C7ZwbLinfxyo4y1WiYXhM
	 PSfKzKuY3ltn35Sl49VR72l5dPWD6ynKA89XCNrdtagqDmoDJfdnxF55Pep99dUGlqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mmDYWTqu;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C5606A332;
	Sat, 14 Nov 2026 10:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A3C5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mmDYWTqu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=7qzyQTytGIVocE0P2u5FtBTwHVXRHKKKFn7q9lDBX0M=;
	b=mmDYWTquRWpixKXUtbxR/qFd8450hboJsmOizGnKYvwiErOLnJDP24oULVg5l6
	q3+oLxuZtUkjlMlei+8Jxwnh5G38zw5UzyTZczfQA5W0B6uxP6PvxszsiLmK3jB3
	zxoB7BcC79GrCA+JjriShiVTJssI2C5TtTfJwV6fAbkyc=
Message-ID: <63d1fb27-5d05-494f-8452-f0a7b7438f4d@163.com>
Date: Sat, 14 Nov 2026 18:29:27 +0800
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
Subject: Re: [PATCH v9] ntfs: convert a named $DATA stream safely when making
 room in a record
To: Wahid Khan <wahidzk0091@gmail.com>, linkinjeon@kernel.org
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261109173229.1921147-1-wahidzk0091@gmail.com>
 <20261114073451.367708-1-wahidzk0091@gmail.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261114073451.367708-1-wahidzk0091@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V9EJOPhqZDTDGw--.54315S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3urW5tF4ftFW8JF17Jr4kXrb_yoW8Xr1kCo
	WfZw4Yvw40vr98CrW0kw1kJr9xWay5Cr48J34YyrsrAFsaqryDC3y3uw4DW347uw1rKr4D
	W34xtwn0yFs5tr93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUe0edUUUUU
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6Qros2r4OAqtqAAA3d



在 2026/11/14 15:34, Wahid Khan 写道:
> When an attribute has to grow and the mft record is full,
> ntfs_resident_attr_resize() walks the other resident attributes and
> converts them to non-resident ones. For $DATA it always opens the
> unnamed data inode of the base inode, even if the attribute found is a
> named stream:
> 
>    tvi = ntfs_iget(sb, base_ni->mft_no);
>    ntfs_attr_make_non_resident(NTFS_I(tvi), value_len);
> 
> value_len is the length of the stream, so it does not match the
> attribute that ntfs_attr_make_non_resident() looks up for the unnamed
> inode, and the WARN_ON() on entry fires:
> 
>    WARNING: fs/ntfs/attrib.c:2115 at ntfs_attr_make_non_resident
>     ntfs_resident_attr_resize
>     ntfs_attr_expand_locked
>     ntfs_expand_for_write
>     ntfs_file_write_iter
>     vfs_write
> 
> It does not need a damaged volume. A file with an alternate data stream
> whose record has no room left is enough.
> 
> Open a named stream by name with ntfs_attr_iget(), as is done for the
> other attribute types in this loop, and keep ntfs_iget() for the
> unnamed one. The loop runs with the mft record lock held and takes no
> lock of the stream inode, so converting a stream from here needs more
> care than the plain lookup gives:
> 
> - A reader of the stream holds the folio lock and then takes the mft
>    record lock in ntfs_read_iomap_begin_resident(), the conversion takes
>    them the other way round and waits for folio 0. Take the folio with
>    FGP_NOWAIT in this loop and skip the attribute if it is busy. The loop
>    only tries to free space. The same inversion exists for the conversion
>    of the attribute being resized, which waited for folio 0 with the lock
>    held and hangs against an mmap fault or splice reader. Use FGP_NOWAIT
>    there too. The resize then fails with -EBUSY while such a reader is
>    stuck on the lock, instead of hanging.
>    Do not look for room in other attributes either: the reader keeps the
>    folio until the lock is dropped, so the attribute can neither be
>    converted nor written without waiting for it, and the loop would only
>    convert other attributes for nothing.
>    FGP_NOWAIT also fails when the folio can not be allocated, so on
>    failure look the folio up: only one that is there means a busy folio,
>    otherwise return -ENOMEM.
> 
> - A stream that is in the inode cache can be open, being written, being
>    removed or already unlinked. A write that passed its residency check
>    before the conversion carries on with a non-resident attribute, and
>    a stream in the middle of ntfs_stream_finish_remove() is converted
>    under its feet. Convert only a stream that is not cached.
> 
> - An attribute inode of a file that has no links left is evicted on the
>    last iput() with its dirty folio, so what was converted is lost and
>    an open file reads its extended attributes back as missing. Convert
>    nothing, of any type, in a file that is being deleted or has no links
>    left.
> 
> - The unnamed data is converted through the file's own inode, whose
>    i_rwsem only a resize of the unnamed data itself holds. When a stream
>    or an extended attribute is being resized, a writer of the file can
>    have passed its residency check and carry on with a non-resident
>    attribute (iomap_iter warnings, recursive mrec_lock). When the
>    unnamed data is the attribute being resized, its conversion was just
>    tried by the caller. Do not convert the unnamed data from this loop.
> 
> - Do not convert the attribute that is being resized either. Its
>    conversion was just tried and failed, for instance on a busy folio,
>    and a second try that succeeds leaves the resize to go on with the
>    resident layout of a record that is now non-resident.
> 
> - The lookup of a stream ignores case, so a stream whose name differs
>    only in case from an earlier one resolves to that one and the length
>    does not match again. Compare the names exactly.
> 
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
> ---
> v9: A busy folio on the resized attribute returns -EBUSY and not -ENOSPC,
>      as Namjae asked (-EAGAIN would reach user space and index.c uses it for
>      its own retry, -ENOSPC is not true as the record is not full).
> v8: Sashiko's review of v7: the fall-through on a busy folio could still
>      convert other attributes for nothing, also below the record size (the
>      attribute may not fit resident either), and a resident write that
>      follows waits for folio 0 under mrec_lock. A busy folio on the
>      resized attribute now fails the resize with -ENOSPC at any size,
>      nothing is converted. A forced -EAGAIN while growing an EA to 800
>      bytes now fails and the EA keeps its old value, also after a remount.
>      Also: FGP_NOWAIT fails with -EAGAIN when it can not allocate the folio
>      too, which would have shown up as a bogus -ENOSPC under memory
>      pressure. Now only a folio that is in the cache means busy, otherwise
>      -ENOMEM.
> v7: Sashiko's review of v6: when the resized attribute cannot be resident
>      at the new size (newsize >= mft record size), a busy folio (-EAGAIN,
>      mapped to -ENOSPC) still ran the make-room loop and converted the other
>      streams before the resize failed with -ENOSPC anyway. Reproduced with a
>      forced -EAGAIN (setxattr of 1500 bytes fails, two streams converted),
>      fixed: the resize fails right away and nothing is converted.
> v6: Sashiko's review of v5: when the conversion of the resized attribute
>      returns -EAGAIN (busy folio) and is mapped to -ENOSPC, the loop could
>      reach that attribute itself, convert it and resize its record as if it
>      were resident. Reproduced with one forced -EAGAIN (the EA is lost, the
>      resize fails with -EINVAL), fixed: the attribute being resized is never
>      converted from the loop, and neither is the unnamed data (its branch
>      was dead code once that is skipped).
> v5: Sashiko's review of v4 found more, each reproduced with a forced make-room
>      pass and a debug delay, fails before and passes after:
>      - the WofCompressedData stream of a WOF file was converted, and the
>        file read stale clusters until writeback (249 of 250 bytes wrong)
>      - an attribute converted in a file with no links left was evicted
>        with its dirty folio (open file reads its EA back as missing)
>      - a resize of a stream converted the unnamed data under a writer of
>        the file (iomap_iter WARNs, recursive mrec_lock)
>      - the conversion of the resized attribute itself waited for folio 0
>        with mrec_lock held (hung task against mmap fault and splice)
>      The six v4 scenarios still pass.
> v4: v3 (convert a named stream via ntfs_attr_iget()) can deadlock against
>      a reader of the stream and has other races with an open or removed
>      stream. Each is reproduced with a forced make-room pass and a debug
>      delay, fails on v3 and passes here: reader/converter deadlock
>      (hung task), write continuing on a converted attribute (iomap_iter
>      WARNINGs, recursive locking), unlinked file with an open stream (mft
>      record reported corrupt), stream converted during its own removal,
>      and a stream pair that differs only in case (WARN in
>      ntfs_attr_make_non_resident).
> v3: use ntfs_attr_iget() for a named stream instead of skipping it (v2).
>   fs/ntfs/attrib.c | 109 +++++++++++++++++++++++++++++++++++++++++++----
>   fs/ntfs/inode.c  |  19 +++++++++
>   fs/ntfs/inode.h  |   2 +
>   3 files changed, 121 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index ce7c1b524180..613b6482d720 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -1975,7 +1975,21 @@ int ntfs_resident_attr_value_resize(struct mft_record *m, struct attr_record *a,
>    * inode i_size is that this is not necessarily uptodate.  This happens when
>    * ntfs_attr_make_non_resident() is called in the ->truncate call path(s).
>    */
> +static int __ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size,
> +		bool nowait);
> +
>   int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
> +{
> +	return __ntfs_attr_make_non_resident(ni, data_size, false);
> +}
> +
> +/*
> + * With @nowait the folio lock is only tried: a caller that holds mrec_lock
> + * must not wait for a folio lock, the read path takes them the other way
> + * round. Fails with -EAGAIN if the folio is locked.
> + */
> +static int __ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size,
> +		bool nowait)
>   {
>   	s64 new_size;
>   	struct inode *vi = VFS_I(ni);
> @@ -2056,10 +2070,23 @@ int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
>   		 * outside all ntfs locks, we need to get the folio now.
>   		 */
>   		folio = __filemap_get_folio(vi->i_mapping, 0,
> -					    FGP_CREAT | FGP_LOCK,
> +					    FGP_CREAT | FGP_LOCK |
> +					    (nowait ? FGP_NOWAIT : 0),
>   					    mapping_gfp_mask(vi->i_mapping));
>   		if (IS_ERR(folio)) {
>   			err = -ENOMEM;
> +			if (nowait) {
> +				/*
> +				 * FGP_NOWAIT also fails when it can not
> +				 * allocate the folio. Only a folio that is
> +				 * there and locked means a busy folio.
> +				 */
> +				folio = filemap_get_folio(vi->i_mapping, 0);
> +				if (!IS_ERR(folio)) {
> +					folio_put(folio);
> +					err = -EAGAIN;
> +				}
> +			}
>   			goto err_out;
>   		}
>   
> @@ -4895,8 +4922,23 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
>   	/* There is not enough space in the mft record to perform the resize. */
>   
>   	/* Make the attribute non-resident if possible. */
> -	err = ntfs_attr_make_non_resident(attr_ni,
> -			le32_to_cpu(ctx->attr->data.resident.value_length));
> +	err = __ntfs_attr_make_non_resident(attr_ni,
> +			le32_to_cpu(ctx->attr->data.resident.value_length), true);
> +	/*
> +	 * A reader holding folio 0 waits for mrec_lock, which we hold. Do not
> +	 * wait for it and do not look for room elsewhere either: the reader
> +	 * keeps the folio until we drop the lock, so the attribute can neither
> +	 * be converted nor written without waiting for it, and the loop below
> +	 * would only convert other attributes for nothing.
> +	 */
> +	if (err == -EAGAIN) {
> +		/*
> +		 * Not -EAGAIN, it would reach user space and index.c uses it
> +		 * for its own retry. Not -ENOSPC, the record is not full.
> +		 */
> +		err = -EBUSY;
> +		goto put_err_out;
> +	}
>   	if (!err) {
>   		mark_mft_record_dirty(ctx->ntfs_ino);
>   		ntfs_attr_put_search_ctx(ctx);
> @@ -4913,12 +4955,14 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
>   	while (!(err = ntfs_attr_lookup(AT_UNUSED, NULL, 0, 0, 0, NULL, 0, ctx))) {
>   		struct inode *tvi;
>   		struct attr_record *a;
> +		__le16 *name;
>   		u32 value_len;
>   
>   		a = ctx->attr;
>   		if (a->non_resident || a->type == AT_ATTRIBUTE_LIST)
>   			continue;
>   		value_len = le32_to_cpu(a->data.resident.value_length);
> +		name = (__le16 *)((u8 *)a + le16_to_cpu(a->name_offset));
>   
>   		if (ntfs_attr_can_be_non_resident(vol, a->type))
>   			continue;
> @@ -4933,18 +4977,65 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
>   		if (a->type == AT_DATA && !value_len)
>   			continue;
>   
> -		if (a->type == AT_DATA)
> -			tvi = ntfs_iget(sb, base_ni->mft_no);
> -		else
> -			tvi = ntfs_attr_iget(VFS_I(base_ni), a->type,
> -				(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
> +		/*
> +		 * The attribute inode of an unlinked file is evicted on the
> +		 * last iput() together with its dirty folio.
> +		 */
> +		if (NInoBeingDeleted(base_ni) || !VFS_I(base_ni)->i_nlink)
> +			continue;
> +
> +		/*
> +		 * Not the attribute being resized. Its conversion was tried
> +		 * above and failed, for instance on a busy folio, and
> +		 * converting it here would leave the resize to go on with the
> +		 * resident layout of a non-resident record.
> +		 */
> +		if (a->type == attr_ni->type &&
> +		    a->name_length == attr_ni->name_len &&
> +		    (!a->name_length ||
> +		     !memcmp(name, attr_ni->name,
> +			     a->name_length * sizeof(__le16))))
> +			continue;
> +
> +		/*
> +		 * Not the unnamed data either. Only the resize of the unnamed
> +		 * data itself holds its i_rwsem, a writer of the file can be
> +		 * between its residency check and the mft record lock.
> +		 */
> +		if (a->type == AT_DATA && !a->name_length)
> +			continue;
> +
> +		/*
> +		 * A named $DATA stream is converted only if nobody has it open:
> +		 * an open one can be unlinked, being removed or in use. A WOF
> +		 * file reads its stream from the device, so the stream must
> +		 * stay resident.
> +		 */
> +		if (a->type == AT_DATA) {
> +			if (NInoWofCompressed(base_ni))
> +				continue;
> +			tvi = ntfs_attr_ilookup(VFS_I(base_ni), a->type,
> +					name, a->name_length);
> +			if (tvi) {
> +				iput(tvi);
> +				continue;
> +			}
> +		}
> +		tvi = ntfs_attr_iget(VFS_I(base_ni), a->type, name,
>   				a->name_length);
> +		/* the lookup ignores case for streams, ours does not */
> +		if (!IS_ERR(tvi) && a->type == AT_DATA &&
> +		    memcmp(NTFS_I(tvi)->name, name,
> +			   a->name_length * sizeof(__le16))) {
> +			iput(tvi);
> +			continue;
> +		}
>   		if (IS_ERR(tvi)) {
>   			ntfs_error(sb, "Couldn't open attribute");
>   			continue;
>   		}
>   
> -		if (ntfs_attr_make_non_resident(NTFS_I(tvi), value_len)) {
> +		if (__ntfs_attr_make_non_resident(NTFS_I(tvi), value_len, true)) {
>   			iput(tvi);
>   			continue;
>   		}
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 62dd5bd5bb81..ec9c7b219192 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -287,6 +287,25 @@ struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
>   	return vi;
>   }
>   
> +/*
> + * ntfs_attr_ilookup - find an attribute inode that is already in the cache
> + *
> + * Like ntfs_attr_iget() but never reads anything. Returns the inode with an
> + * increased reference count, or NULL if it is not cached.
> + */
> +struct inode *ntfs_attr_ilookup(struct inode *base_vi, __le32 type,
> +		__le16 *name, u32 name_len)
> +{
> +	struct ntfs_attr na = {
> +		.mft_no = base_vi->i_ino,
> +		.type = type,
> +		.name = name,
> +		.name_len = name_len,
> +	};
> +
> +	return ilookup5(base_vi->i_sb, na.mft_no, ntfs_test_inode, &na);
> +}
> +
>   /*
>    * ntfs_index_iget - obtain a struct inode corresponding to an index
>    * @base_vi:	vfs base inode containing the index related attributes
> diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
> index a18cbcf1c631..7ea52c59c04b 100644
> --- a/fs/ntfs/inode.h
> +++ b/fs/ntfs/inode.h
> @@ -326,6 +326,8 @@ struct ntfs_attr {
>   int ntfs_test_inode(struct inode *vi, void *data);
>   int ntfs_test_inode_rcu(struct inode *vi, void *data);
>   struct inode *ntfs_iget(struct super_block *sb, u64 mft_no);
> +struct inode *ntfs_attr_ilookup(struct inode *base_vi, __le32 type,
> +		__le16 *name, u32 name_len);
>   struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
>   		__le16 *name, u32 name_len);
>   struct inode *ntfs_index_iget(struct inode *base_vi, __le16 *name,


Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

