Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664537;
	b=5cm8bTFpCbMQhAkYvQDOT4tPDWShcX4+vsFn6iYoCC435jeDFyfmcfz4Y3EubJuxnbSD
	 XGYXWc+T3ilacENNnjPGjtEM82Jz3L1GrBLWJRqP7RiRQDyStEPbaJwfCZRKpfIhU5GWV
	 4LdaTRtmfNJYs7FIVRMDoImKzDcra/SBR2ZLKksHeQN2qZPQzYmcJKxkeyjzFlCTOJZgm
	 BNkqKQzGDpqByUfi359ZpbtFYsN5SbeHJ4OS+E5S0atVTaDhCMRappf7L+hD07eNtB9x9
	 0xp+qbqGHasW83LvpWaB0YpvZOUfuC3R0xye3woZJf+dww42dGeB/CQPZW2NDLyT8xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BShTI+UobISHlwtvnbR0ufLcpJkUNzJIdEPohOxpHf4=;
	b=kVhVj2DJ15JtGjdTXj/0aLuJkXu+v9ItmzPZD9Vqub2dDuPswqXHbEodR0tl4ku8CGqm
	 k51XRK2TlBYbr0C7ekPcJ7h1SYkzST8xUvGXlDu0HO0GJ5GoL6JM0BYSDYVW5civhD6bt
	 p8srvePiChsn4ZaS4W/Ja5xZhk2pXahQWP9gKTy4uTLZlKvMYjvy0/BZS5zYsBp4RR4pJ
	 r1VYzwExxPKsfinqGigKzX1OKW2v/7CmuvYx9uoO+QccG12XOR+MWmYQZ1fTY9dqix9En
	 Xwm/sBjmNUkRMJRtSrnn4x2nkYNSUZwfw9v7cDlz8/ltw7/WM1RWdUL5Ak34mGKdzvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CpX3Ke6g;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880E606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 00:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D880E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CpX3Ke6g
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso40619085e9.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 16:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793664535; x=1794269335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BShTI+UobISHlwtvnbR0ufLcpJkUNzJIdEPohOxpHf4=;
        b=CpX3Ke6g70akGgdDbzuTxgVpruv3xYq8FXN9MJO08DWtxiCDqIC9fKQ+C5nGfBcfKG
         v7GApdisZ5enj7u4SnIvU/Qk+8j4pCzSqx2JlLu884vo2bL4bq7AtHdAwEsR4TXrsvsi
         Q0sjgKrjkySKJj7FaBIOHv6FBd0ToArEOcbjOZU9HHXtwaKb7G4aHYZt0xQsoBmMucMR
         QEt3j02ts+IcA29L4KsMidGa/LtGbc6KAfTu9ElmhZlJsOJVetb16YlzM3+QBay5z4MA
         giuvcKksXpNP6hbyRsn7RDP1b4ggYbEvZTuNOh2ALfYCEEa8gbobDaO+EwgH62CESrXM
         HuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664535; x=1794269335;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BShTI+UobISHlwtvnbR0ufLcpJkUNzJIdEPohOxpHf4=;
        b=nSUM8IpQRr/dFkcgIM7oGnYLJV0OuQkIbb4DJSSFGmNl5w26GFvguk9CrpxwO/ACUS
         JSv57NrjeMGIgYzgskGmvIKiJ/s4Sqgv9RMYMGcSWn1EWYLradfPNuNn7A0I30y3boBU
         G78STaPEr4wlafpnqBJc1QPU+A/YLUzam+lGB3ULeZN+bTy7aqj03n4aTob5PHX0+85S
         8Njo26bjNuXGlIfPsbQtKPihTjERB+WRzcGH48YHalzie11XCxbH2aLix5JliOn9Qw/P
         R5byoGhZ3zhgbLHaiciDNaSq9VUI6frLZLOGQQvbOFtEJcLqFJ6h3GWM5JPZ0Z1kKW4P
         Qwsw==
X-Forwarded-Encrypted: i=1; AKwUvBwGKZVHUbxuF+bvwFlIU3VLofO8w2/xj2e9gSyjdH8SHfLdS3rJcLvYxOgNlDRQC639bfO8YNE=@vger.kernel.org
X-Gm-Message-State: AFq9FYInXZSOmwonjVhcTm7ceN+a3C548dFaQMtJA9Ut2o2crHeLfG0J
	W8N2bguYJVg+K/ZU2K9YV4G43KFzyzuBQfe1qSv5VPIB5eqgoK6lRw+mJmXqrTDiS2k=
X-Gm-Gg: AYBFou06jeqKvly1YFsw1ewrKKzWNjnPE3E0Qfc2PWK6IsjDFeH/VoI8dYtv1+KB+JW
	zDyUiRg3Qnpd5TfrvHi8ZWCGn5iVpIG7TS7j0i/4uN+YZy2A8TQgtFwXaUsh0siKLeAZzLNI3SV
	1CpTZxujHCBDPIv3v3WFHuJ5v8m/LKWN3FtjYQMXrJtK51JOdYvO1vjolz7Ij6rSS2cjdW1zH6J
	6vhv5JVrvwZGk8WQz2b2F3BgtRzLidvhlCIMNfJbGwO3ufo9gGvRnBQx1opH1ezj1Gu4l7T2K0H
	5D+36ipGqNxbjTJwPi/ToF8dpHnZfnja0K1Gg9+jwelK01RV2/62i3EDQx3BG6zacOhu4ro1LO7
	Qw25u+8/PGlkDqq/D9k9rEBSfe+CGdqXd1Q17a70PbxCihEfC8dyntmCGXZrWBCRBdLsyY2BBaN
	VQYHwaHWf8L25i4lyENqX4NMCwIqVhKSEzuWLCVz3mSqljhgOh2fl7R5ELdr96jWaaq91zF7JeX
	azkM1DC7OzmJ1EuGJASZ0hYphThSBY35kKYwWxq1kU6HWWs6H2LxqlC0CV3TC/pGwgDhUz8CgGO
	ALnDaRmRkMxCZdNADktsDw==
X-Received: by 2002:a05:600c:3b97:b0:4a3:5a91:5f64 with SMTP id 5b1f17b1804b1-4ac18e5dcbamr256643425e9.27.1793664535225;
        Mon, 02 Nov 2026 16:08:55 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429018casm36727241eec.14.2026.11.02.16.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 16:08:54 -0800 (PST)
Message-ID: <8743c195-1204-4829-85ae-342bdab6503c@suse.com>
Date: Tue, 3 Nov 2026 10:38:49 +1030
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
Subject: Re: [PATCH] btrfs: do not check support for an invalid sectorsize
To: Siddharth Mishra <smish149@asu.edu>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Siddharth Mishra <brightprogrammer@asu.edu>, stable@vger.kernel.org
References: <20261102233041.310900-1-smish149@asu.edu>
 <a12db355-d677-4656-9715-a537980e928a@suse.com>
 <CAKpDGtncRzRwkv6yfxNvMHOMSk_Ejg_HJHEs3k9TVNb_6mArvQ@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ujyBQkUpLw5AAoJEMI9kfOh
 Jf6o8OIH/0mqW+TQM4m2x3hCsnK+oB4yJH1qnGvIhFF/Lhs48wI02sGh6/4aA0hkCDfd9LHQ
 +ci4FUepZ9y4VS01+oIExbg/8ytzGYTzLtb44jK2GBOBVSJkMiha6jp22XFt7WUkT/tvbreu
 WWdGsaJIRQaZChy7xsMI8lqQ2WdmluZJ4LT0wD3l/l6QU1ZseMGySebdY9sVOQEOJNV7Qj92
 /KOAFNmeZshV/qDI8Iw1RTs6TvLqCcqmlZLCmJkYSVhT1RonWRren8xIRcFEgMe004IDnt7V
 qdQhk/nhTS9x9MBAhMRl0TTE1VKDLvVALsud3iZLrmmtYvwPApzGJk052f0m28vOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ukKBQkUzDspAAoJEMI9kfOhJf6o
 SNsH/1ysUWOKmzY0rGS3ZdS61QgqMGhSWD/EJ4UiPw+xO4l4+GtX0fOAqxqsmBKqje3vyhBa
 Z5o/1Y+gNiN+E6RBcSz4b1TAd78sQ2bvT5DWOvBjeeVxHdiuQMIn4S8xk5ZpySBw5ifjoiuL
 0M33UVtJOzM8yfAeL+d/Rp4leJw72SutjkLyZTG/gJIp4pJGD/kFHn24OLL0IxEcO0gOekNZ
 os5e1R6jAJ2ILk7+MDnvU8wXHcCiVzuDhJLI1tih1uUIE50muHQJWbYuVBbdJeu8WlIDDssx
 UOCxLylNG3gDXV5MhLubPTOpp9OiFc/XC37nvkgEcrlmlOFBv4/NJCbECpo=
In-Reply-To: <CAKpDGtncRzRwkv6yfxNvMHOMSk_Ejg_HJHEs3k9TVNb_6mArvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/11/3 10:36, Siddharth Mishra 写道:
> On Mon, Nov 2, 2026 at 4:42 PM Qu Wenruo <wqu@suse.com> wrote:
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 8e8fb942d..b348591f8 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -2520,9 +2520,7 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
>>>                     sectorsize > BTRFS_MAX_METADATA_BLOCKSIZE)) {
>>>                btrfs_err(fs_info, "invalid sectorsize %u", sectorsize);
>>>                ret = -EINVAL;
>>> -     }
>>> -
>>> -     if (unlikely(!btrfs_supported_blocksize(sectorsize))) {
>>> +     } else if (unlikely(!btrfs_supported_blocksize(sectorsize))) {
>>
>> If you want to change this, you should touch all callsites.
>> Not only this one, but every unlikely() branch to return immediately.
>>
>> I do not like the ad-hoc fix just be cause you can trigger an ASSERT().
> 
> Thanks for the response. I'm assuming you mean I change the whole function
> to return -EINVAL on the first failure it encounters and not just the sectorsize
> because it reached an ASSERT. Given that, I'll send a v2 right away where
> any failed check in btrfs_validate_super() returns early rather than
> continuing ahead.

Already done

https://lore.kernel.org/linux-btrfs/7350d541824422978116bfb536d2c7bc68cbb826.1793664043.git.wqu@suse.com/
> 
> Siddharth Mishra

