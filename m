Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4FB3B47C4
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155833; cv=pass; b=rc2fH2c1Rb4GR86QeqLkAeBJ4RsCSWulHlWo6Lm41qdkniD4X07F1qULS4wFVkyF5cpcnZwuWZCvYAbMdXvtIzfN3A8ZaxqCH8Sgjb6qqRdpwVdJieb5cJ50I6XxoAOgjz7QLlk1m8NO0ApW1xBJt/T6t1qkySlwtH/7l0BCLnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155833; c=relaxed/simple;
	bh=yJOOToxkAkkDWuxX+DQ8CmAe8YR1dGRhzSMXe+5DDPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCyLKFDRgdoXj7S9wtiUHJ4Bt9+6bF4/dy7Zq25z3vYsqL04C3i1ESzA9pdM/4VRPLJpsSx+8Ej6bbgSV1vBCuab6IbaQx/5ikR3vQlaX/A6AUledk2Eba+y8MCP0l3LqTppscxF30YLKH+rkLGBZ8202dOdSxIp+zqycsMPpv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKeUjK0W; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKeUjK0W"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b01910b499so2818707e87.0
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 22:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788155828; cv=none;
        d=google.com; s=arc-20260327;
        b=bWKg5d18YV1rMn67UyspzEEeng3ZYoH8aMcaBlYXtvix5Cr5ewoH92Cb6NSwKHNf6F
         bg5BvBwB02WGd6xbrw6X8IcVahggjgMCcKXDpl8Ox02J0105Tb3Kv0fJ01ChUrqPML79
         ddrOyOq99xHD05bq4Efsmb0nU6OSL9gUw4yJcNyDMlvM1RIZVO1rJS/CfTzvYMgrpaT0
         WqPlY1gUWIpPgFi4u/p4l2nvrJ3jT4cW7yCgp16ti/RJHdzAe9fe58JSCS8jeYl5jRHh
         nty29dPyASsdzzEpkxcLIfnA0xDs7G/yXzNW8m+P4IIUBo2sFAN15Lv3w5DFmJemurFK
         QAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uh5CA8yZ22ZcY5tvWBU8xuO3ZeT05hPXjolSHDs/8lM=;
        fh=LLCbERzZEKWpx3wOGznkMeBVYkLuQLJkfnu+/2105dk=;
        b=AbVKjjk1miMSwKicR9d71h9PNzPzxSgXNmyQNkNcqbHnTci1QICC5CfKeX6qDBVVUe
         HnfPk9G+fp9vXF9pOZE/n32zYxCLJsYUd51jucdxxTBGtIafcVLfsvGPIXNkPvLTzCF1
         knFwzAho6EZFwSEVtzH9gFueXjYF8BO4JWHPN+eYGxtIDu8YfgugdCNituU+pbglLIA5
         7V6a991lgXqFAUDdPOgGIEC4qxyiCrwXGqAD9/vBJIyCF6NjVs/0grlEBcwfZSGdcK/t
         BgK10uzj/0A77JCiY2xGYdVZ8ZbLq/+zDDObKij8/UN9T4FMpDFAo3+n3fB11rDaYOv8
         sxug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788155828; x=1788760628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uh5CA8yZ22ZcY5tvWBU8xuO3ZeT05hPXjolSHDs/8lM=;
        b=XKeUjK0Wz12iE7Zf6P93LQPxUcocZmfhcCR3rvFhS5pco1GsH5XcFplLPyFRJeezv+
         6OxcC2NNXiVjLVrz0JukDIlB6cE0sX/x9m9/E96gIy2H6aniH5L0R4WZre2/7WhyxRWx
         a7THdAAYkV0J2cG2+Ycz0pCdL6AP9TgWWHkXicdPTDT+cjnNWQwAWB+74bCBNPNta0l5
         lKdQNu+5Hb8xVzyjwC7188rYN2gF8OcG93gjEX57ZcyWXZRB1gnwtDNAKj7hMDu94Sw5
         rARoq8YrBh1Du6tFMd/sPktXAaou/Qv93QBK/CV65RpKfVI95w3L02VHH+cq4D/f/AxI
         8p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788155828; x=1788760628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uh5CA8yZ22ZcY5tvWBU8xuO3ZeT05hPXjolSHDs/8lM=;
        b=QdrugXHqcUBChEeTqZQKdxDopBIagTus4myHqFVSEYKntpru31YMR6auemvR0cMmsm
         DDF7br3NaCukRncQmt/JVhcFCk3jIYV2sL1ORST1Ep2YRVa1LPdr7MIN9ppF8lVQY5mv
         aU6uUVYLQRQK6SKF9N/d8dEIo79nb4jiKwj2Wrx3snUhVQSrzuU6pDdB2ODXLcRlLnYs
         /0RwufgNQB9JOn2ZhWJ6HE9F5oPWyeW7E1CTSkwcMdGxtjW9rTTxnar3BzdBbpWF5ynf
         Az93zjiE+vHSrZhi+EYKE6rAYTBFbr+D/OtE4XdckBIxxlvd0E2r1/EtEojQSk0w8+Du
         /a/w==
X-Forwarded-Encrypted: i=1; AKwUvBw/9arDGe5VFlWdhEpZb1kIePOAMilpxd5XVacNeEOQpnXbF7UKMUpMtPPcrXzm97y1N1lLTTc=@vger.kernel.org
X-Gm-Message-State: AFuF++kD53Sfrp/RddGz46czG20lEOymKzPSqCVZ7pDrUV00YUVmbxEc
	E3DkL5nKgWFTVpA2qEmzCFtOSbvnDsWusCPnD9CUiZaeJvRk7UIW7XQLVKYsxh0VZm+EPNZbFUV
	kMBNbaH4Qk9PSH3CPTybhe3qQoAIpjYA=
X-Gm-Gg: AYBFou0JhadY/bwK2z767sPeMbJfX/FjSHlyoRUe05vnfgJpO+vUTCCB6PPaSc/WRgZ
	k5DH49usg/Me3GNMparmUh3BRaE5L6wc1KhT0dJqMT83c9Zp6TPmoAFHfn5uVQtCeRM0bA9Ea/W
	QDUFI5yLogUYpEC4Wyn1yAtLerPlYaZ/NI2VD7S/Z6ScQRsjUPuXqyaMwcf11MDyLEf1wHc5Uk6
	HHh5RI8MJMXgrHnafnGcd1SceZ3ZFEl/vLtY/QRXnZw4kGsGE9DpRwHCxsEuiVyu1yag6YtGOnX
	pP3boiRofwT5Ve+tJ5j3D2Ul0ZlDx4Bpcn33stdnxZTM
X-Received: by 2002:a05:6512:1055:b0:5b4:5a42:ab3d with SMTP id
 2adb3069b0e04-5b5f61530e4mr1709713e87.8.1788155828153; Sun, 30 Aug 2026
 22:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828061607.240845-1-zenghongling@kylinos.cn> <20260828061607.240845-2-zenghongling@kylinos.cn>
In-Reply-To: <20260828061607.240845-2-zenghongling@kylinos.cn>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 31 Aug 2026 14:56:54 +0900
X-Gm-Features: AcwNN1UEO22loL_9cAauGdY1uAnAW-E3bmZBOHdEltAmoHBEhjOa9i53okdSeAU
Message-ID: <CANFS6bbNoXUMBzAV2yAdXSgBD-VaP8_bxY7f-E56qQdNkpX5XA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ntfs: take invalidate_lock in ntfs_filemap_page_mkwrite()
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: linkinjeon@kernel.org, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 8=EC=9B=94 28=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 3:16, H=
ongling Zeng <zenghongling@kylinos.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> ntfs_filemap_page_mkwrite() calls iomap_page_mkwrite() without holding
> mapping->invalidate_lock, so a concurrent truncate or fallocate can be
> in the middle of invalidating pagecache and rewriting the runlist while
> the write fault maps blocks and dirties the folio.  This races with
> ntfs_attr_fallocate(), which merges clusters into the in-memory
> runlist, drops the runlist lock, and only afterwards zeroes the newly
> allocated clusters on disk; and with the punch-hole/insert/collapse
> paths that free clusters after truncating the cache.
>
> Per Documentation/filesystems/locking.rst, ->page_mkwrite() must ensure
> there are no truncate/invalidate races, "usually mapping->invalidate_lock
> is suitable for proper serialization".  xfs takes its mmaplock (=3D the
> invalidate_lock rwsem) shared in exactly this path.
>
> Take invalidate_lock shared around iomap_page_mkwrite().  The read-only
> fault path is already covered because filemap_fault() itself grabs
> invalidate_lock shared on instantiation/read paths; only page_mkwrite
> was bypassing it in this driver.
>
> Fixes: 9c87959601e8 ("ntfs: update file operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
