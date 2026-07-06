Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2633C381EA7
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350899; cv=none; b=isNJFgFh75g8QoX3hwoKSG8xE/Vi1XS+ZJJJasj6pK0Ozdkz7j855YJvZlvBJapj7hT2B0wCf/ugx2fxvsy3YtyNU4qA5xYxg21gJY+kXDBHJ1S9GOtSqyuuO1TvbAd/GpDJBLdUJe09MD90xW2Hsz5Zjlae1a4uhtyKFqd1+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350899; c=relaxed/simple;
	bh=vDU41NdjFea6rhG0v3jf/z1FWs9UPuWRum9UfbYivKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwtLtYWNS/BgiZzDwV99mOtwa9vbIOCydIDfDfn4/swYzk2kiCO3x2KzDcxGWAMcyW+c32rr4i2SuZbttZ60DNi+bw1e8t0gJVyILnOX3sYRQ0u9TFHHeEJc78PQk8vSjOF6AjDdBforPf3qIJFLlcAehxfT5XGu8/N3eaKgE6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6V81ji6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EV/Rr2bN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6V81ji6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EV/Rr2bN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783350896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVa6ctAi5t78VnS5MdfYUXx+WGiwq/yUHuM1oy2LXDs=;
	b=I6V81ji60xF3dDkSlHZnJIcn5PKeVVDDXneEYu0ah+mnVf0SQvBEc8u1j+BLscjzzyMF62
	k/ZpfnnTt0O9FDdl7ID4b/Ify/SGOkh46Jmd953cN8Wm0wtP1m8Uhn4DVnSr1OPYQHXrqa
	aJbax4s2KwAwYsAnjbcXrB6AAgVYET4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-ttKLzY5CPmWbi_HML29fiA-1; Mon, 06 Jul 2026 11:14:55 -0400
X-MC-Unique: ttKLzY5CPmWbi_HML29fiA-1
X-Mimecast-MFC-AGG-ID: ttKLzY5CPmWbi_HML29fiA_1783350894
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47bbe3b9705so1724672f8f.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783350893; x=1783955693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVa6ctAi5t78VnS5MdfYUXx+WGiwq/yUHuM1oy2LXDs=;
        b=EV/Rr2bNoX6AemKEHA7uLtchpRjLwBd8IyQtHG4FzGnjLSZ+jt6UOCFPjqSkFuAwo1
         0YWDeGh+66sRBiVcpV26kBM6Vr6Xvgfp9LoTWLxTaeCvZiGCXXc/X4cDoB6jCewdwikk
         Mat5C8nZhR+Sn/Fh03VhQcNT/WJmrMIWBeFU2ZaO9A5UEpTNj82mBe4oSNR2wfEVfXAl
         elnhWKUmBM4ES3Xp2K4oYjpeIdFFtmiVnCWFzePGIQmSMPRfhmF6ArpT8j9T7xxAxXam
         3OOjHIb16ZFCRpxs78ajVO5GX+iU0kefSkxjOeeTZek7/+aCH1VNpiDFgQQ0fNGopj1G
         kSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350893; x=1783955693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVa6ctAi5t78VnS5MdfYUXx+WGiwq/yUHuM1oy2LXDs=;
        b=pDvtzywA/AdHsqbkGilX3stQKhH7cV6dn9CMa9+nAHVugcyhphPyesYJ+rPfsgDqrb
         oegXSuizflmQVOj0s1JZCFgZMM/zxZMatY4LQBceViSIPVEnAyDQJDC6MdukkiPyMEmO
         x/ltC9AWrzmTPhtWIrjDj74KnYF7FnocOvA0CeOU38Kiq6YAvrw8TQrgbluE2igmaxWU
         vdig9ifg3kX4DDcA5MnWTvcWzKsjz5VQkc24PqqFPi9yeSOUEjfFPMIsYoRxysKy89l1
         oCk9Oo9Ow5pQJObfugJEn3VVyYz9aLYrhHinDTmV30ndxl+cp+AWmCB8UCGVwpv6KKXq
         kfOw==
X-Forwarded-Encrypted: i=1; AHgh+RocOMdLHvkF7n9pPWev6mykiZGc9cBxkBcrv1Fs8WOyVZUREvVE0lwmSZ9HckTdkCJVo7LS6Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxohlpAwI67phXyRn1lCfk+/kIcm9etO3/1uT5KSckSrIU/CcrN
	d+MVckVtbySg8QYpl8Lj7Picmafx4+BkUJMiUaHpy+nbNGBYQ7obMopD5Mmnfe1ykNEmCouD2C+
	e5bAOkFhw7tTFHYS6CQrpNnAAEnXqe8+djhQNXAWqwAOagGqoUTuLv6aYFA==
X-Gm-Gg: AfdE7clffsiTfziT5+rEcgnqjcSOyTyoNRuAze1wHhxV/BubGDK4A3uptxGQkU7JyDV
	csPvl04HFcPogMLnE/PtxOZ8cJFFtvMJh/x6Ovr7T+PnHoLR1rDDtgxfytFGfEuYuf8oj8j3Zcn
	zRIZDH1CJy9xyjkmX+RV9SPyTgBjWf9kHqA2LS/wQf64nR4jhpkmjmKDrdqenSxRNPuJ4Qh0KQK
	1J1XPEt3a0L+QfrSNLwhdADKz778rJuhWyKT3ICSkkTM5gmqb2rtWssk+lEC4xebJMlWEvlRhzM
	C3WPDwBmmG2apQvliqQj0CrrMes5Ud8kMn4fkQypwRVFQ/fFrRRAZ3zfxT1EFsxn/rk/FHPZ/qH
	Dz/6AObPVAk4OWv8G35PtvZrjonE7H6dQDbW0UUwLXm7EtPZvYYY07YNswVWF9YPuREVDpRE=
X-Received: by 2002:adf:e40e:0:b0:475:f0c2:75a6 with SMTP id ffacd0b85a97d-47de66f2e70mr550500f8f.55.1783350893639;
        Mon, 06 Jul 2026 08:14:53 -0700 (PDT)
X-Received: by 2002:adf:e40e:0:b0:475:f0c2:75a6 with SMTP id ffacd0b85a97d-47de66f2e70mr550456f8f.55.1783350893203;
        Mon, 06 Jul 2026 08:14:53 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm22403251f8f.34.2026.07.06.08.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 08:14:52 -0700 (PDT)
Message-ID: <74871a78-5243-4898-8e63-92e918912980@redhat.com>
Date: Mon, 6 Jul 2026 16:14:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gfs2: validate stuffed inode size before unstuffing
Content-Language: en-US
To: Jiaming Zhang <r772577952@gmail.com>, agruenba@redhat.com
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
 stable@vger.kernel.org, gfs2@lists.linux.dev
References: <CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQqco4gjdmKVbdURg@mail.gmail.com>
 <20260705140620.1732914-1-r772577952@gmail.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20260705140620.1732914-1-r772577952@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2026 15:06, Jiaming Zhang wrote:
> A corrupted GFS2 image can store a dinode size that is larger than what VFS
> i_size can represent. gfs2_dinode_in() reads the on-disk di_size as a u64 and
> writes it directly into inode->i_size. If the value is larger than S64_MAX, the
> incore i_size becomes negative. That negative value can bypass the existing
> stuffed inode size check:
> 
> inode->i_size > gfs2_max_stuffed_size(ip)
> 
> Later, gfs2_quotad may try to sync the quota file and unstuff the quota inode.
> gfs2_unstuffer_folio() reads the negative i_size into an unsigned length and
> passes it to memcpy(), turning it into a huge copy size and triggering a
> out-of-bound issue.
> 
> Reject dinodes whose size exceeds sb->s_maxbytes before storing the value in
> inode->i_size. Also make the stuffed inode check use the raw on-disk size while
> it is still unsigned. As a defensive measure, validate the incore i_size again
> before unstuffing and pass the checked size down to gfs2_unstuffer_folio().
> 
> Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
> Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQqco4gjdmKVbdURg@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5-xhigh
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
>  fs/gfs2/bmap.c  | 18 ++++++++++++------
>  fs/gfs2/glops.c | 10 +++++++---
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 51ac1fd44f78..89c46c1d622c 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -52,16 +52,15 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length);
>   * Returns: errno
>   */
>  static int gfs2_unstuffer_folio(struct gfs2_inode *ip, struct buffer_head *dibh,
> -			       u64 block, struct folio *folio)
> +			       u64 block, struct folio *folio, size_t size)
>  {
>  	struct inode *inode = &ip->i_inode;
>  
>  	if (!folio_test_uptodate(folio)) {
>  		void *kaddr = kmap_local_folio(folio, 0);
> -		u64 dsize = i_size_read(inode);
> - 
> -		memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
> -		memset(kaddr + dsize, 0, folio_size(folio) - dsize);
> +
> +		memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), size);
> +		memset(kaddr + size, 0, folio_size(folio) - size);
>  		kunmap_local(kaddr);
>  
>  		folio_mark_uptodate(folio);
> @@ -92,9 +91,15 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
>  	struct buffer_head *bh, *dibh;
>  	struct gfs2_dinode *di;
>  	u64 block = 0;
> +	loff_t size = i_size_read(&ip->i_inode);
>  	int isdir = gfs2_is_dir(ip);
>  	int error;
>  
> +	if (unlikely(size < 0 || size > gfs2_max_stuffed_size(ip))) {

How might the size be invalid here?

> +		gfs2_consist_inode(ip);
> +		return -EIO;
> +	}
> +
>  	error = gfs2_meta_inode_buffer(ip, &dibh);
>  	if (error)
>  		return error;
> @@ -116,7 +121,8 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
>  					      dibh, sizeof(struct gfs2_dinode));
>  			brelse(bh);
>  		} else {
> -			error = gfs2_unstuffer_folio(ip, dibh, block, folio);
> +			error = gfs2_unstuffer_folio(ip, dibh, block, folio,
> +						     size);
>  			if (error)
>  				goto out_brelse;
>  		}
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index 28f32424ee64..33575fa681f5 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -393,11 +393,16 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
>  	umode_t mode = be32_to_cpu(str->di_mode);
>  	struct inode *inode = &ip->i_inode;
>  	bool is_new = inode_state_read_once(inode) & I_NEW;
> +	u64 size = be64_to_cpu(str->di_size);
>  
>  	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
>  		gfs2_consist_inode(ip);
>  		return -EIO;
>  	}
> +	if (unlikely(size > (u64)inode->i_sb->s_maxbytes)) {
> +		gfs2_consist_inode(ip);
> +		return -EIO;
> +	}

This check is likely all that's needed.

Andy

>  	if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
>  		gfs2_consist_inode(ip);
>  		return -EIO;
> @@ -418,7 +423,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
>  	i_uid_write(inode, be32_to_cpu(str->di_uid));
>  	i_gid_write(inode, be32_to_cpu(str->di_gid));
>  	set_nlink(inode, be32_to_cpu(str->di_nlink));
> -	i_size_write(inode, be64_to_cpu(str->di_size));
> +	i_size_write(inode, size);
>  	gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
>  	atime.tv_sec = be64_to_cpu(str->di_atime);
>  	atime.tv_nsec = be32_to_cpu(str->di_atime_nsec);
> @@ -462,7 +467,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
>  		return -EIO;
>  	}
>  
> -	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
> +	if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
>  		gfs2_consist_inode(ip);
>  		return -EIO;
>  	}
> @@ -707,4 +712,3 @@ const struct gfs2_glock_operations *gfs2_glops_list[] = {
>  	[LM_TYPE_QUOTA] = &gfs2_quota_glops,
>  	[LM_TYPE_JOURNAL] = &gfs2_journal_glops,
>  };
> -

