Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D53191CA
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931942; cv=none; b=cY3a6kf9o+nSiZYacxBKg6jvab2CcBnd595emFwwemGcXt0l6F2Bv2ctwLu7CNToCDiGq0lzVR9nURSfeWj+GRZ8uO0cZ+8IvWPrIJKDYwHNCMU8RkAQSYRXDw4lC9RHGBUyz/ir0wHnsJAyRD+0hxukoBbP5GQ+NzscbLS8v8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931942; c=relaxed/simple;
	bh=H4xtHTy0Y/+ISkPD7Sj0/x/AQMrNK7QdhnbZvMN4QtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHxgmMNI9nRWYj3zEzHTJTCBoo+iREzHgGYNg4jA8A7lp17CDpYLBBkQlxdPeJF9SnTPrSsp2+UY6Tj4IrXN9ozrI74FqqWsAaMMP2j8qYIZftThklznqB71NhHLkisgiuwtUXtJaeGBZUB1wcly4q9x3A0njLvUJGii9O+0HL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U+IwacFB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U+IwacFB"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4998590d392so30202475e9.0
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 18:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786931939; x=1787536739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ptYF6ab5Z9M20KdmYdCTVqvwqsjoun1wXpSUUWxQIf0=;
        b=U+IwacFB/Aftpr9+3HMsFAEpQo2DPNzlPJEADOAEulBHKoEHOT/7JhjdNGYr5v5rLA
         BEXZE0SphrBJKUFX1mQuXYdeUWBMdu2tSpZpjQjFUaUIcM6myOb54G+4ZKL8b2CaWf/C
         mLk9XFE9GWktOTPkul4nIZwHZewqb50BvwJUX6FytNc0zIBClBuvB9+mIaep2ucWUdtp
         RiwVxgwR3AhDiN0M+S6m2IfaDHivcX5ohUB370Spu2+5yELy20XkFzN65/6xf2fqNYo9
         zd2F90OKegG5PlPRtARbDIAOIsiOrZ+3G+rgi4CO3GU9o6WaJVhfkrLjvqDvMrEvcq7H
         khgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786931939; x=1787536739;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ptYF6ab5Z9M20KdmYdCTVqvwqsjoun1wXpSUUWxQIf0=;
        b=epa+jyE0GVg2KL/8YZWa95S+beaF74a6dugDAYrm/v3PaZ4roxYnS7la3TfT4vKjpL
         Eg7CmaTLNKrD0gdDtJx65NfvCo2iNL6hvOIS+fompTZ4UUs9/5RD6Wokt4pY4eL6hmIJ
         klqYn/HnUZQHxI7emZWwpM1xjyIS2xp6ShKfsOiZOtsilpeO2jROvZRWENHu3diNJm8m
         hG3zBd/a7mFySAI2zdCV43lWYpRVKzqLAZF5I9x3qVNY2k07+GddPIR9HbVGZRja1LEC
         iGAQtyma0QSO0a1sfqWWXPFoxx0C5puxOSbSPkKsocqbmNpRXnz1bgs92LuV5t8VIVIl
         X3pw==
X-Gm-Message-State: AOJu0Yx34UmcpC9Uu7SiTrd8Vvn1DPVMJhAY/+pn/FXEK4D2mJ1jf0xB
	8RwIuCAsqZ5DXNeli1VM9SFEE0Oju5mZ/F9LHVPwzgTBJLhKOw22v0z3+pGlruaC0PKGSMVD3xp
	uWdCpe0D0Ig==
X-Gm-Gg: AR+sD10ICRsW4KW9Z6ny57vL1c2WiHpZpZJretYPQrDnCStOv5F2uotN4eqOUUa5662
	nTjB6bZsqNEzDVnS0IjIxEhOb6fGmeQMLVjfG0sMW2F/YV7ZLw/FQezItS5JcHK7lTLPzxP2aCt
	JaJt6PdjwUQWGevCg7Fo5xB3VRYwPoPP9IZcu244FEj7ZHgmM+6Z+W82zMxIJX3DsriJ9YxnpqZ
	oa6Dw/jysl2AHbM3rHmTaV03Z45Y4BsJXMwXJ00XngYcsd3AanTu9c7204du+R3NMsUA6A6X+2W
	68BjAwzG4Ma7d8RMQdI+PK7tiSfJHwxCTf3k811Ca3DjEUuTKqoweICVdIX9z5udoXonEYFq5Ww
	Z9VSjYVIjA/0kisk9Hz+TVJKp1/sBlv62lN6EQrYkFKJ1vlPhUcRuGK9lhDn8NaEettv0W4z30Q
	WNORdvoN/iJL1u/jVTSqT8JkoJ/+6MvEa+gDfB+zNRkNGSpPqirkNDtQ==
X-Received: by 2002:a05:600c:5754:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-49987951a06mr202374255e9.7.1786931939363;
        Sun, 16 Aug 2026 18:58:59 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267cc91278sm305879eec.31.2026.08.16.18.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 18:58:58 -0700 (PDT)
Message-ID: <e1d92bdd-306e-43a7-97b1-d7c801acf4b6@suse.com>
Date: Mon, 17 Aug 2026 11:28:52 +0930
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix use-after-free in mark_block_group_to_copy
To: Hongling Zeng <zenghongling@kylinos.cn>, linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260817014545.13169-1-zenghongling@kylinos.cn>
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
In-Reply-To: <20260817014545.13169-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/17 11:15, Hongling Zeng 写道:
> mark_block_group_to_copy() iterates over the commit root with
> skip_locking=true to avoid lock contention. Without holding
> commit_root_sem,a concurrent transaction commit can swap and free
> the commit root during iteration, leading to use-after-free when
> accessing extent buffers.
> 
> The fix adds commit_root_sem locking, but CRITICALLY must only cover the
> actual search period (btrfs_for_each_slot), NOT the preceding while loop
> which calls btrfs_commit_transaction(). If held during that loop, we get
> self-deadlock: down_read(commit_root_sem) → btrfs_commit_transaction()
> → switch_commit_roots() → down_write(commit_root_sem), blocking forever
> on our own read lock.
> 
> Lock scope:
> - down_read() after path setup, before btrfs_for_each_slot
> - up_read() immediately after btrfs_for_each_slot completes
> - NOT held during while loop (btrfs_commit_transaction) path
> - NOT held on the !path error path (goto unlock before lock
>    acquisition)
> 
> This matches the established btrfs pattern used in send.c, backref.c, etc.:
> hold commit_root_sem read lock ONLY while searching commit root, never
> across transaction commits.
> 
> Fixes: 78ce9fc269af ("btrfs: zoned: mark block groups to copy for device-replace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

Please disclose LLM usage.

> ---
>   fs/btrfs/dev-replace.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index dc0834f920c3..734807bf48b3 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -499,6 +499,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
>   	key.type = BTRFS_DEV_EXTENT_KEY;
>   	key.offset = 0;
>   
> +	down_read(&fs_info->commit_root_sem);
>   	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
>   		struct extent_buffer *leaf = path->nodes[0];
>   
> @@ -525,6 +526,8 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
>   	if (iter_ret < 0)
>   		ret = iter_ret;
>   
> +	up_read(&fs_info->commit_root_sem);
> +
>   	btrfs_free_path(path);
>   unlock:
>   	mutex_unlock(&fs_info->chunk_mutex);

