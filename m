Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36EB640
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791667071; cv=none; b=oIlSjV2MBYyTIARB6X+HDNU5RQCmnJKBLC+u+e1Nfyo988IA+ezPLHThnsOwTt2z8bbKBTvhn3zgVrTMuarrCVHiEEHp7In0j2LcNIaiijs9aOJteT+iI9SrPOzhTuoYmeo4tsDbHYWnPvKcWeIvVszS2CRIe7p9xFD2E9kpBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791667071; c=relaxed/simple;
	bh=sX/IOUyiNB9UW/7dJN3j8/EJO8eTtlYJpH2gKUP+csI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbA7HfsaiioLrKo62RdPvgJ3a4mbQthw2eKYQPxsYovMrhfZ6glQxyjGQZK040GCyzg0F/EcJMY8BI5QvhPeM1gcBlSIFYmqogS49ylGB7VFtZr0X7nu6XJjNxDXyZZhTBwSDYtYPldEDXRskGKIvsJ4zohKpvt439LGIpqvWhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BHVHClLg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BHVHClLg"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so7035725e9.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791667067; x=1792271867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fSwyFmQWlZ7A/ReGcJEYV2ZxqTqob7BeqZTXwEelfWg=;
        b=BHVHClLgRW20gb9bJhhc0Pubgh1nsJSvLTvybYd3N4PuOfMkwZLHz9GrcJke0x0d4Y
         Fd5eMXK5FYNNxZoU90xIdnEA4lDhrKrE0KnaUlfV09T2++gHl6yfQB5xZVAj7i/nXbKJ
         1DmWGpS3IG9Ou0++oBVbRrhZQl4v5Hhp7Yw4Yhqxqcj0GJK8GmfUQBkVSP/xw2JFgNxc
         tJ0lk1QT994ZOKlnytufnhrq2JUFbfK33XmWOMUy5a43+jaXPDYH1mh6pv8+/jFF1i+9
         nk3VyCfn5fyTQllX9r1L/IT+ySSE/JKM/4WGESxtppdLW759DibuPAkvtS5EuMyr9GmA
         w6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791667067; x=1792271867;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fSwyFmQWlZ7A/ReGcJEYV2ZxqTqob7BeqZTXwEelfWg=;
        b=wA59DwjxqmoqsnqWmvTzRZgegKEvHH2tiaTQxuERKJ/nCCF5hM4Dv7omD7I2L1bt2N
         CVSesFyLQKOdrrNWTt/u5ZIUb76V6kgA+UNu9HonnBxrVn/ZeyRlx7Lp9GWkG/C/niEU
         q65JwKRR3xnhSYaSolpkVTF3T7keLKbdxBweTg3DqdqvlqLRmeA/8T44VkRmPVl7JuiI
         rZfTn2cUUmJf7S2fnkbWj253fh2Ycy9e2VZs0L0bXB/dXDaVVPzA3bHhlBEngSSoityg
         cTGDCDwdOEO0gGd9cu3zveQGokzmEPcNIxYB1Y+GK5OEqE5pIJAeSYkmPR+7RsblKh8e
         SmPA==
X-Forwarded-Encrypted: i=1; AKwUvBzaSWTUTqWJr0NILhJ1fJb/PkTaXOVrIp5recEzfzbysbzzwnfecoURzM0oiam3PkAzn5YiTYY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgloBnSmh8WA0cuHhHL7RaWZiHOCTRzubFgCaYCngTEoFbip4o
	golf0KRjWfupskD2gSxMksmhMIV6Rhc4Hk+addODws9NTuT2b7jfYBJkXL5go273L6Y=
X-Gm-Gg: AYBFou0rzbjt9aDvek+p/0NQ8D7wl+vAOcCF5lH4UmguYLupNJKSkeFmiyYaTjbbcON
	tC6Oa7B6UW/zwRJLMhS0sQtB1ScKvfMDZ2J6lqzr+t4WeOaAMaQibMbI5bUnmmm8sq2E9W+A4eU
	Z6nNQPI4O4ShpNyWNkhwTMppL6YGumR+6v2VnciaWUo6t5zIeGmPp2pubmrO75pJc3ASXBTsMmD
	kTCaaotq/s2ludefRIpW/EkZvBk36RyzSGZYBRjrII4klNoX9ojmWw4CaPC8PlcKiYTrSc+d1es
	sZ0iTmWYDow+kiPzX+BP2+OF9Pbnt+JQiCxpzJEw4nzI+X3lRkAlrZQMjxSkC2sHztO3Yb3ygJq
	18pRw2+b62x8PU3uQ2rtYEREF3yWVrJYRp+CLZ9DOnLztM1+oFG+CzQZuHKrQ6Z1njSQVv3gEiU
	qssDhFLhzltcev4ULR1Rw5aARjjRIv61Tyh0OuFYAtL5rV3r33xoaRmDXgbfBE4Zw=
X-Received: by 2002:a05:600c:5397:b0:4a1:7ba9:da2c with SMTP id 5b1f17b1804b1-4a18e4a7cacmr101542395e9.25.1791667067286;
        Sat, 10 Oct 2026 14:17:47 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab32c0f59bsm5921472a91.0.2026.10.10.14.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 14:17:46 -0700 (PDT)
Message-ID: <41987a33-f2dd-4ffe-b35f-d669d36dbcfe@suse.com>
Date: Sun, 11 Oct 2026 07:47:39 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix chattr failing on nodatasum files that have
 the compress flag
To: Hengyu Liang <hengyul@cs.unc.edu>, David Sterba <dsterba@suse.com>
Cc: Chris Mason <mason@kernel.org>, Filipe Manana <fdmanana@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261010105425.165104-1-hengyul@cs.unc.edu>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJqqw0NBQkUl/JeAAoJEMI9kfOh
 Jf6o/xYH/3AaWnGSq58XnY/T3/YYjr6g+TUZxa7MPyiYTELNpNlvmNlbtbAL0nW0LNvkeiqf
 SmYA+xkwY4RbxnZYQK0H5iv2w1eqa9qqFZb4bIBRmTapu26GEEkpad0W0ZhoSPMO8bV2Bwkf
 YdtPZQLaeUKvHZqNqBKnmtRLQj2Cgy3kuXX3bEGvWjzUOxPUSCj/S++JWBewMdMBPT62vZM0
 3156gfn5mHA94s2p+NFJoWkERY+JPTMu9NISkpD7yuGhXN88qd/aqD0RrlhxvKsrQogdPwn9
 vP18FGG3CRlHtOvOLVoY5NKSOWTDc+o+8t2XEETFTGbKYTcqeTzi4SxhvBLtTinOwE0EWdWB
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
In-Reply-To: <20261010105425.165104-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/10 21:24, Hengyu Liang 写道:
> Commit cf1afec09e9f ("btrfs: validate properties before setting them")
> made btrfs_set_prop() validate a property before setting it. For the
> compression property, the validation fails with -EINVAL when the inode
> has NODATASUM.
> 
> However, a file created on a filesystem mounted with nodatasum has
> NODATASUM and still inherits the compress flag from its directory, and
> btrfs_fileattr_set() sets the compression property whenever the new
> flags include FS_COMPR_FL. As of now, chattr fails on such a file, even
> when it only changes another flag.
> 
> The issue can be reproduced with:
> 
>      mkfs.btrfs -f /dev/sdb
>      mount -o nodatasum /dev/sdb /mnt
>      mkdir /mnt/dir
>      chattr +c /mnt/dir
>      touch /mnt/dir/file
>      chattr +A /mnt/dir/file
> 
> Before commit cf1afec09e9f ("btrfs: validate properties before setting
> them"), the last command succeeds.
> 
> After that commit, it fails with EINVAL.

Explain the reason why it fails.

> 
> This patch will make btrfs_fileattr_set() set the compression property
> only when the inode can be compressed.
> 
> Fixes: cf1afec09e9f ("btrfs: validate properties before setting them")
> Cc: stable@vger.kernel.org # 7.2+
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
>   fs/btrfs/ioctl.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 52aab510aea0..347509043f2e 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -421,7 +421,12 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
>   	if (IS_ERR(trans))
>   		return PTR_ERR(trans);
>   
> -	if (comp) {
> +	/*
> +	 * An inode with NODATASUM can not be compressed but can still have the
> +	 * compress flag, inherited from its parent directory. Setting the
> +	 * property fails validation for such an inode, so leave it unset.
> +	 */

This is very LLM-like, and very LLM's objective-oriented behavior.
Disclose it first.

Secondly it just slightly do nothing, which is not the expected behavior.

Furthermore, this introduced another layer of exceptions.

For regular mount options, -o nodatasum,compress, the later compress 
will override the nodatasum.

So when setting compress in the first place, the NODATASUM/NODATACOW 
flag should be cleared.

> +	if (comp && btrfs_inode_can_compress(inode)) {
>   		ret = btrfs_set_prop(trans, inode, "btrfs.compression",
>   				     comp, strlen(comp), 0);
>   		if (ret)

