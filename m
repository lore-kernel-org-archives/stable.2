Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239123D564B
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491726; cv=none; b=iHtwVBrAxN8glicd6dhXEDmm5wUJ67XZnqoemedEU6OnxVqw2EUcTW+pDevP593hL6O+q0pnTnNcnV+aT+qIJ2IKym6r99SXuwFVR93vzzfSaPbBQ3MubLTVUmVSpk7DBf183K5X/xCx5nkIas85fGVuZ5/Aik72kv1jyunho2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491726; c=relaxed/simple;
	bh=0FY7jKL7i3nWdtV5UjM7+2QUOG8pr5+5FtouvWun+Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bE4c0yuKzGW46b2hZmv+Fex7rsS3w2PMAW5mrZp/DWdCifYME2LfM245J48fVQSjZ3uSWxF228vGBYpHsIL15ir1eKkGoDga3X5aMSdDuRSku8eMz5y5gc4phs4H35TjFskajIpSNvkRyx0XsoHj5B/AME0wh8b4/6m9SsYr+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIsP34oL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIsP34oL"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c169ae1cb26so312995666b.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 02:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785491718; x=1786096518; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9+u78jPs6mbf9nu7a3juoU6/fY5OSZEmkTw029HZ1ME=;
        b=DIsP34oLLpnOLcCADogXHmkWP94OQ+LihHCEjzS2nUWh/hLqbqC7uL/vp/cGV9Okt3
         nrOa0qnez1M1qblU81WgdlCQ04u7SmTvuFIXJQAZGcRln1snMyrnATrOt0yTvoreHIAs
         8Tjv/jJF+dw1e4/OBHKOBYWH4Kto2gwmvOKsgWEeFDFdBI6Kp3mBuAV304ECbtSiDxJ/
         jZQjC+T/mAl4Rv8M0lkI3DYN9J2/iRgpppTOfWxf/WPANgpMAwemj6O++NuGQMLZoln4
         PJk/M8b9h3PHIqerTVBBvjroMXanVYNpkz2NXY68XQyH0KFtcnAXrsdcB/25UCNO9kZu
         Hplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785491718; x=1786096518;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9+u78jPs6mbf9nu7a3juoU6/fY5OSZEmkTw029HZ1ME=;
        b=cybnA+M0I3qCHMhyZU0+wlgLcp751DB7fHuEkfq7mFa/OrFXBLfO+VkOLaG/CxT2Dv
         p5EoIkxnVSelzVkwo0+hgD6PYsCtwtvEWX7R21gHEmTu4SeVYB/EAEzvrJ/cmCSqyR/1
         c4y/s6vey6gAwNSQWhhAXtaqSMcPIeL++9nhsxuywkfO4bvjUqKoOGC+Dn3FRW8kE70P
         mCUaGxZBeZ3WYebIZMRjopBOG48PfnpftlmeRhddlCRvuYAN1DpRBOK542/2yz0JNzLG
         jlIg6X0VMWYFGzYYEXucNhq/GxNO248fUZTnkT72iC6PjpmfwOgBtLAuQaZG1eJ4jzk6
         VUyg==
X-Forwarded-Encrypted: i=1; AHgh+RqenVN7BvLcrl1UyNbaKoqQ+SXt/wN8KnK0qV9uc0P9IratkfPH6cTkC84o8UUxEc4bTS3LgSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH96gSzvchvXgyLOFut+A/dLvMFIewmhdkL8nDfZmxo8NN7ERH
	MAfqG/dxNs4v1hkgUdY9DRrOR2f2CtqYRVkfGXmucQxMV0ooXXZ7aPeR
X-Gm-Gg: AR+sD13rH+ti5GNz/6A4p2pbMlauYyr9bJ85oe0tbSgmTqzZ5CJpFGk1KXVwCpLbXNV
	hGSGAgmPFx+CM8e/iG0n0R23EdpskMrerbDWlUNJd4OQp12WfW91v3TkMpGmuqTm0DG7ChXmvFl
	ZufTFsBNyF3owu6vxte37kfpZblDAOnYBX2a9PlXfwAMj72lrQkbRDUvlL1TqmaNSNl7pwjb0BK
	GQVCnlqao0PWWxnXMOCoOEofwEAuQYCGI1fFR563RwLUODf0+6TyP3CGkNH/+wSzyGrTDuRvU4C
	YWX4LZbu+sXqrwvDQz70dYnLl315JpR6L1GLnV9DYe96K69/bQ9dMIhLHPFVylX6b7aCIY/QdAd
	YbyOSop4KV0ng04iqTfRiUpnFBw9e/Q1CPb4lmyoMC12Kel96JE5s+27epuHOFKokCUu9BkYGHy
	/76H3JxYYFtC+cmeid4ZCPvC4qyDf4zaBR+9fo5+3MSAu1nGtGqu4Vxus0P0dLXtmPF6Qc74uah
	mNlZBGDuiV567GGnLMles4vR8NyGQ1OYs4SCT+vroStubu7bxBYhWbWThDG8eCt+g==
X-Received: by 2002:a17:907:97d0:b0:c1c:49d9:4c34 with SMTP id a640c23a62f3a-c1fd3245942mr80761666b.11.1785491712646;
        Fri, 31 Jul 2026 02:55:12 -0700 (PDT)
Received: from [192.168.178.24] (cgn-195-14-217-60.nc.de. [195.14.217.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b0fasm90919766b.5.2026.07.31.02.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 02:55:12 -0700 (PDT)
Message-ID: <a91f850e-0bc2-484a-ba77-2138949eba58@gmail.com>
Date: Fri, 31 Jul 2026 11:55:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configfs: unhash the dentry before dropping the item
 in rmdir
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com
References: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
 <20260730093435.195441-3-vasilisalmpanis@gmail.com>
 <amxrCqfgaWnoWcte@gmail.com>
Content-Language: en-US
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
In-Reply-To: <amxrCqfgaWnoWcte@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/31/26 11:29 AM, Breno Leitao wrote:
> On Thu, Jul 30, 2026 at 11:30:25AM +0200, Vasileios Almpanis wrote:
>> configfs_get_config_item() treats a hashed dentry as proof that
>> sd->s_element is a live config_item.  configfs_rmdir() breaks that:
>> simple_rmdir() leaves the dentry hashed, the last reference to the item is
>> dropped right after, and the dentry is only unhashed by d_delete() once
>> ->rmdir() has returned.  configfs_symlink() resolves its target holding no
>> lock on it, so get_target() can land in that window:
>>
>>    BUG: KASAN: slab-use-after-free in config_item_get+0x26/0x90
>>     get_target fs/configfs/symlink.c:128 [inline]
>>     configfs_symlink+0x4ab/0x1030 fs/configfs/symlink.c:185
>>
>> Unhash in configfs_remove_dir(), while the item is still guaranteed to be
>> there.  A reference obtained just before that stays harmless, as
>> create_link() rechecks CONFIGFS_USET_DROPPING, already set by
>> configfs_detach_prep().  Both configfs_unregister_subsystem() paths
>> d_drop() after detaching, so this only makes rmdir match them.
> Is the claim that "a reference obtained just before that stays harmless,
> as create_link() rechecks CONFIGFS_USET_DROPPING" accurate?
I believe so.  Everything configfs_remove_dir() will now d_drop(), had
DROPPING set on its dirent beforehand by configfs_detach_prep(), and
once detach_prep() has succeeded the flag is never cleared again on
that subtree.

The race is closed by configfs_dirent_lock. create_link() checks DROPPING
and incs ->s_links in one locked section, and detach_prep() set DROPPING
and checks ->s_links in another. Either symlink gets ->s_links++ in 
first and
rmdir fails with -EBUSY before unhashing, or DROPPING is set first and
create_link() fails with -ENOENT.
