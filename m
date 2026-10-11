Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10C2C15A0
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 05:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791697995; cv=none; b=UVOmyrlkKT+pf395zq8txxJFdOW+njZjdJZ37SHvSl4rGZnZegRzrV4QXd5YVjsCTHrJxCCptgXGDUPb9wdZtbr52+GriZeAUP2gap8gv17LRcNqFlSPM2TuG1iBKlNX4ZVz/q1THRqRdfDp2K+SkAYk1m1mNaWtysnsjr/x8ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791697995; c=relaxed/simple;
	bh=Q2pNT5QI49/eCQ+6LLxDbJY+NZld/P+BgMZAKwL3VzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sD+clKeSmDSazXvAkDLVRAp4CnzF7cY52nAplGZoLHTlIjG7EdewZ9mPK+K8f/gJgFeDtYcVrLgcObiigsTOXQVwX28fLYt5slobiOAvcLOXhzkGOLNtds/Jq4weO5srpErKxoixYt8y2OTip1ou4w2Zf2vpbfuZyRcbYVrJJwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Iyu4VLd9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Iyu4VLd9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956869750eso7574125e9.2
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 22:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791697992; x=1792302792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4KwlwLxNiXywZ3YcnnEn9jaLW3rrEnQf5taDjKIMYs=;
        b=Iyu4VLd9XVLDI2RqdU5xbGub5gY4NPeH9MY9C2t/06A2ANKzIrn1jeFxmHSbNMZoEF
         l+Kf8dTl2qRo7wa20I7Gy35S82GZmk8uRaJujh3bok+7SvDDOuVEnA0RpR7E3p+ZDKZS
         WKM2h9+OdLeCRhZudcW5RyWWPQ08RFlPfsDJTryiChbj1B4ea4Csbp3nRoOoaZ605EGy
         0Cc1Ay6Wdt+bwW8PmzRrXEkl/OtCTmvh62yrZOMZ/nIaOebpyHrmfrgORmuKTGOYo1J3
         nau0SHKswaegsaQuVum2WySgNrfMqZfjMwybhWeOTOcXIZuB3JkhuZzEw1SMPKSHyQef
         VxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791697992; x=1792302792;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C4KwlwLxNiXywZ3YcnnEn9jaLW3rrEnQf5taDjKIMYs=;
        b=bTk6+Uv8jK3qdYKbuRJkrJu8/B+2JRukLGiEiet67MCmu3TrX/oYQfwsDuPhyDH8+K
         lwJWND5FUGvFGfF7Ak7Ta/ulhx7KFTWefyHktAM3SrTDC77qR3bxxYJBQq1IHSRZ3/Yg
         18skV5bi3W1aUu0NValdBpUUCWfGYv2exTByj4EMc3Lhyi4xlq7aI+DPRy3GL+jmyBnp
         PhOwiPezqKuu5pJR3DrUvsriBKGlnDu/ZwJl2pDKxsDXbQGmQ3b6dmi23P16xEiBBRAb
         DIS2CAKTN7RTmDX5AdtDIm3H9IvVkCwYOrgkCSLqhI4VMVNwRlNdIcPvxu86nIwTx00U
         YdKg==
X-Forwarded-Encrypted: i=1; AKwUvBwMyNwwpAQuMpZuUGiiRMXGH+CP+lKGotaPwv9oxq/pKdRxFtj7CxSiI69lIDqvEI/qnnCvzsc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLblTHMpstG9fSFP1Ed4YkfKZ9U7PfMNKCugnOsajaFLZWkCDwU
	TOTU37rueqRSaBENWt5fV6y1J5ZjUbqScJo4ivfhHZ9ahjkBa5DgDd6tybl1zZYBCj4=
X-Gm-Gg: AYBFou3WACfR2TviWlPnFwU48JzlaarJraCdm9tfXeaZvsnEq95qWhvnRx5Gw2yp7Rg
	g/QW6/2wb1gnDtFL8kkZsqQXd9CL/NTuV1E+0LrYL2jnElSdlgmzCNX4ck/DgPnh6RCL58vxGs3
	MlyL3F/LQCZMXDJ16NlJFFFNutKysZ/OgdyYO1G1M1YdoCQB5b8zUJhWqanay8FNhdjRMYBNMCQ
	VMQXN7KvGHKA0Fui4d649VdICoRoY1RTsDKPMqMPcHj346U7rA8EsyaNeyyXnHKtktX5qe/DTT+
	Y7jMU5b8Hgh3U3sJrw5dT/nLDCGEfY71ODGfIhJRh6C8MPL4x5wUmIiFWfASo0VZMAprcuIXAJ4
	K1Z67C6tXf2rH+cy+PY0N667Q2cBqYQASKzjyDMTL4Ppf093YCmikrxwWk+ZrgywwmJ1vMtiW/V
	is6UiaGOxTPjY5j+l6CSUYNLRhZH5m1I8fvuC67C95MVfzNRVs1Ga7Xt4TOasS7G4=
X-Received: by 2002:a05:600c:3e83:b0:4a1:6d35:779a with SMTP id 5b1f17b1804b1-4a18e446880mr95813325e9.3.1791697991391;
        Sat, 10 Oct 2026 22:53:11 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e1c89sm28468345ad.75.2026.10.10.22.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 22:53:10 -0700 (PDT)
Message-ID: <841e395e-f85d-4359-b680-1eee502ec2f0@suse.com>
Date: Sun, 11 Oct 2026 16:23:03 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix chattr failing on nodatasum files that have
 the compress flag
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>,
 Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <41987a33-f2dd-4ffe-b35f-d669d36dbcfe@suse.com>
 <20261011034731.1054465-1-hengyul@cs.unc.edu>
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
In-Reply-To: <20261011034731.1054465-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/11 14:17, Hengyu Liang 写道:
> On 2026/10/11 07:47, Qu Wenruo wrote:
>> This is very LLM-like, and very LLM's objective-oriented behavior.
>> Disclose it first.
> 
> Yes, and sorry for not saying so in the patch. I found this while
> comparing the behaviour of different kernel versions. I used an LLM to
> analyse the difference, write the patch and the changelog and run the
> tests in VMs.
> 
>> Explain the reason why it fails.
> 
> chattr reads the flags and writes the whole set back, so FS_COMPR_FL is
> in the new flags. btrfs_fileattr_set() then calls btrfs_set_prop() for
> btrfs.compression, and since cf1afec09e9f that runs
> prop_compression_validate(), which returns -EINVAL because
> btrfs_inode_can_compress() is false for a NODATASUM inode.
> 
>> So when setting compress in the first place, the NODATASUM/NODATACOW
>> flag should be cleared.
> 
> OK, I will do it this way: a new inode that inherits the compress flag
> does not get NODATASUM/NODATACOW from the mount options, and chattr +c
> on an empty file clears NODATASUM.
> 
> This differs from the documentation in one place. btrfs(5) says that
> all files created under nodatasum have no checksums and that
> compression is disabled when nodatasum is enabled.

Prop has higher priority than mount option, and defrag has even higher 
priority than prop.
That's the long existing behavior.

> With this change a
> file created in a +c directory on a nodatasum mount has checksums and
> is compressed. Is that what you intend?
> 
> In chattr there are two cases where I would not clear the flag:
> 
> - The file has NODATASUM and already has data. The existing extents
>    have no checksums, so clearing NODATASUM would make them unreadable.
>    chattr +c would return -EINVAL here, the same as setting the
>    btrfs.compression property does since commit 0e852ab8974c ("btrfs:
>    do not allow compression on nodatacow files").

That's expected. Non-empty files can not change their 
NODATASUM/NODATACOW flags.

Thus in that case, adding compression to a nodatasum/nodatacow inode 
should fail.

> 
> - The file has +C. check_fsflags() already rejects chattr +c on it
>    with -EINVAL and I would keep that.
> 
> One more question before v2. Files with both flags and data can already
> exist on disk,

In that case NODATASUM/NODATACOW overrides the COMPRESS inode flags, and 
no compressed extent will be generated.

That's a much safer default behavior.

If we go the other way, we will trigger a log problems like odd csum items.

Although setting COMPRESS flag on NODATASUM/NODATACOW is a much bigger 
change, it should be addressed in a dedicated series, with a lot of 
extra corner cases to consider.

> and chattr +A on them fails since 7.2. Is it OK to leave
> the compress flag and the property alone on these files when only other
> flags change?

Yes, that's why unlike other properties, compression has both 
FS_NOCOMP_FL and FS_COMPR_FL.

If neither FS_NOCOMP_FL nor FS_COMPR_FL is set, COMPRESS flag should not 
be touched.

Obviously the code just before update_flags: label is not properly 
following that behavior.

If your objective is only to not return error, then that's what you 
should touch, skipping the btrfs_set_prop() completely when neither 
FS_NOCOMP_FL nor FS_COMPR_FL is set.

> 
> Thanks,
> Hengyu

