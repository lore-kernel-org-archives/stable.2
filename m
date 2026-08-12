Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175335DA63
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786495399; cv=none; b=tBkcQa2ZvmtGKXFAUEsPnE7UNIQxDhYYZ9sml/zVx5bByIxo+zUnADaPT5IiMypFCqOKi7OLbhDFDzv9ohX0GQfcTrsI0YHzBP7YB/XCb4ejkI/0wnUteonjyqcSWyKi1Q+iJhIMq6pz5togffCVKtEwmww+Hx3/LMRZiwzPi50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786495399; c=relaxed/simple;
	bh=pFjHOBi0fcCzwXfwWgUug1wC1lC2q6Leg8SO0PxPvEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJ8udGPYfBfXzCBrn0pSQKJyx4zrwODljb9bYc4G9RrHKV3KpvQ0pyI98V0K1b/G5lMja2EvEHak90yCiQ6nEIaKofwnA6TIqM8WWU8UZzjFb7jzS8eL0uN2xFLFJUvTfsQG/l9yHJJ2vHxCQWGKNwsB0y5IsFZz9roHuume93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S7rTqAql; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S7rTqAql"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49802c418b5so3444215e9.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 17:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786495395; x=1787100195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QF3fb9ZAkhXo6h+jgx2cbFOV68J0LylUOH1B39VsBBk=;
        b=S7rTqAqlg962zX26c8oyng6kr7M8vQjz0AetJy3wMcGlGDpAAQUj5MLh1qH1Ek769k
         m/VYmlWF4aYcjaEz4WXeOGs728ygMQNy71615aMX53ur6cwNB7UCtdjMt498fi4jkWGl
         sxEbs7uan8kzsxCW5is7icH28fgDrxEedvKXzHIhPgdAMjpld/gnPOjFkcd9lHNFuX4P
         vz6FO9ETx19Lhcrg/5B/utwUPbAJiyY7mJIHDBBxKRFLHH408qlx9r56kuiB25N3W8r3
         gQlTUYenV3eR9x8E9kL7EK2g9Fejib5l2L1Lw7EOsaZxX0wQoe9hGUORlvG3jGIMmoqh
         KHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786495395; x=1787100195;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QF3fb9ZAkhXo6h+jgx2cbFOV68J0LylUOH1B39VsBBk=;
        b=USCPgCfajYEQIYCrdCbxuMULv7FmX43qm+opC6zj+OfQlX5c5k5TXk+ta0GiItvE20
         IraEbnP+HyeBgCZy4HB8H6y+m1erExDfejqvMTgf4yl4tG1spThhmzJ0PjFS7hCFgNzF
         6yuRU0w/37pIRJBxPiKnPcOfjmp8d3jjOEXKsGqA9VC497/QdUlxOywMy3a0K51UmJ8c
         6xxxPk3pmItV36bzKZ5jyd9Azvu1ZyMHt8RyAypXDviF16Oqvf/lwvzR+a/I3W1UNdYm
         iXbh6KZbzi6K/pDPGzHlZS+XLkYe5eGjSJF5QcDfvQzUYgLJK1eYRlubJ6exEyEqUWXI
         EHPA==
X-Gm-Message-State: AOJu0Yw/7gzWqDNfZmp1WP3PRrTWDmPK06w26pOHge2MCLsDe2Bgzs82
	y4iQpX4r5CjlYOhz9sjXh1ipRsgP1rk9b4d+7cGBo8nMLfol88FfSiKHI5mDAqD4GIYIdsY+Nx8
	hWsIUAztQJA==
X-Gm-Gg: AR+sD12yw7qJlnOWS2yUkOvw/tcDakCXVPe+T+k3l464/1jOp8x9Tc03y0ii6c1cjQ3
	Let/wgA27mJdNW1KxBYuhF4a5JOtEJ9tQ3XC3CiM772NXe+i66YC8Vd1zGVeTcl2c934Ax/B1wT
	L1vfk+iY/T0r73Y9mu1nD48P2n+Vo4ujunCWuQawHEqOTLMCsPoiuWtIW/2QRUEhPin941ERwtG
	gP+4lcJWbeBVMd6W3mfa1y8CZ3lmSSs/nqx1c2iVnFN46/I7qKCKk1UPOW8//SiI46mJpJ5F1I2
	22takWTpGc37mKn0Y1jzXiEdAgKLAFcJtbwj7E4KGbDCrWZU9ymckjQXJvVpKHPBvztp0bpqeHy
	yd6K9bdAD9x8YhQQ59eMjGdsR+LS3fawLKrIrBfJb7Kcx8/p3wt85NsRRcQwJTngFQ4MtTNzudj
	4xN7cHw1WK6rl/bTv+vb+k4pU15ZjPsCSYqhOyRPT3SmrERfSr2xx7Ew==
X-Received: by 2002:a05:600c:8b52:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-4997c0e6f2emr14928665e9.3.1786495395379;
        Tue, 11 Aug 2026 17:43:15 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf40f9cfbsm3823101eec.13.2026.08.11.17.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 17:43:14 -0700 (PDT)
Message-ID: <b4749071-b0f9-475f-83e6-13153ab20b13@suse.com>
Date: Wed, 12 Aug 2026 10:13:09 +0930
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "btrfs: move large data folios out of experimental
 features" has been added to the 7.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
References: <20260812000703.4150441-1-sashal@kernel.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20260812000703.4150441-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/12 09:37, Sasha Levin 写道:
> This is a note to let you know that I've just added the patch titled
> 
>      btrfs: move large data folios out of experimental features
> 
> to the 7.1-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       btrfs-move-large-data-folios-out-of-experimental-fea.patch
> and it can be found in the queue-7.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please don't merge this new feature into any stable tree.

This feature is not compatible with the COW fixup mechanism in old kernels.

Thanks,
Qu

> 
> 
> 
> commit 3d8483065b9a103c8f10a57dd8638ce0f29b1dba
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Fri Apr 24 10:20:25 2026 +0930
> 
>      btrfs: move large data folios out of experimental features
>      
>      [ Upstream commit 9bce95edb1b4d2802de9273b5170bfcff3090d24 ]
>      
>      This feature was introduced in v6.17 under experimental, and we had
>      several small bugs related to or exposed by that:
>      
>        e9e3b22ddfa7 ("btrfs: fix beyond-EOF write handling")
>        18de34daa7c6 ("btrfs: truncate ordered extent when skipping writeback past i_size")
>      
>      Otherwise, the feature has been frequently tested by btrfs developers.
>      
>      The latest fix only arrived in v6.19. After three releases, I think it's
>      time to move this feature out of experimental.
>      
>      And since we're here, also remove the comment about the bitmap size
>      limit, which is no longer relevant in the context. It will soon be
>      outdated for the incoming huge folio support.
>      
>      Reviewed-by: Neal Gompa <neal@gompa.dev>
>      Signed-off-by: Qu Wenruo <wqu@suse.com>
>      Signed-off-by: David Sterba <dsterba@suse.com>
>      Stable-dep-of: 4c375ac546ea ("btrfs: disable bs > ps support if no transparent hugepage support")
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index 5e75438e0b738..55eba4f1b6c79 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -110,7 +110,7 @@ config BTRFS_EXPERIMENTAL
>   
>   	  - extent tree v2 - complex rework of extent tracking
>   
> -	  - large folio and block size (> page size) support
> +	  - block size > page size support
>   
>   	  - asynchronous checksum generation for data writes
>   
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index beb75f152d5cd..8a802e3675cd8 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -533,12 +533,9 @@ static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
>   	/* Metadata inode should not reach here. */
>   	ASSERT(is_data_inode(inode));
>   
> -	/* We only allow BITS_PER_LONGS blocks for each bitmap. */
> -#ifdef CONFIG_BTRFS_EXPERIMENTAL
>   	mapping_set_folio_order_range(inode->vfs_inode.i_mapping,
>   				      inode->root->fs_info->block_min_order,
>   				      inode->root->fs_info->block_max_order);
> -#endif
>   }
>   
>   void btrfs_calculate_block_csum_folio(struct btrfs_fs_info *fs_info,
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 7e2db5d3a4d4c..9111308351f82 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -859,23 +859,6 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
>   	if (IS_ERR(folio))
>   		return folio;
>   
> -	/*
> -	 * Since we can defragment files opened read-only, we can encounter
> -	 * transparent huge pages here (see CONFIG_READ_ONLY_THP_FOR_FS).
> -	 *
> -	 * The IO for such large folios is not fully tested, thus return
> -	 * an error to reject such folios unless it's an experimental build.
> -	 *
> -	 * Filesystem transparent huge pages are typically only used for
> -	 * executables that explicitly enable them, so this isn't very
> -	 * restrictive.
> -	 */
> -	if (!IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL) && folio_test_large(folio)) {
> -		folio_unlock(folio);
> -		folio_put(folio);
> -		return ERR_PTR(-ETXTBSY);
> -	}
> -
>   	ret = set_folio_extent_mapped(folio);
>   	if (ret < 0) {
>   		folio_unlock(folio);

