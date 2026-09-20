Received: from va-2-18.ptr.blmpb.com (va-2-18.ptr.blmpb.com [209.127.231.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1E3D3D07
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905072; cv=none; b=BFt1Ub5EWdFXHq3eciheMMaKldLqtkqKaPQqH4x4KXk4/TzxtZswFNU2RVGesnv6pKNkKDHfR7aD97Jv2Pk5qtIp+zXkxv3qZvIU8mbuKBnNMPSmJxqhVjoCmLLuqGtIgFs9mYeiHq4Fza/2erFqpOqAHRDe4hCRobxi8nyAV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905072; c=relaxed/simple;
	bh=Bw39X9AkTUoh/aHMDqTy8Y4i1sHlfc+cuooNbm5nWgs=;
	h=Message-Id:Content-Type:Cc:Subject:Date:References:To:From:
	 Mime-Version:In-Reply-To; b=Ij23SWWWNvXsv8ibPKKVBqr0bWRZDN0LNuR3FADA5r1GD1MmhEOCq5jWfXC6R9WzjEBZ0tWFwVfSSOeM72HoDoAep65l/4OXvJNHEG1N59B3xahrTkALQTyM9fi6N48v5BUomWNZSYMEP96VEJ/XY5Xe/ZuZ1wRNkG+no/yDnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=hoEAV1xd; arc=none smtp.client-ip=209.127.231.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="hoEAV1xd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1789905060;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=4ohIn79VTQwaPZDLQ4bf9CpjIqYPmTtX+vxVGjEsJ6w=;
 b=hoEAV1xdoM8YXlEeuRiY5gBu5pkX7HNjUMg/5Fl68O2CGyeIV93mo1zlqde12TdlQ3YHbk
 RS1EZ0AWU3TZJJ5YDEQLNo/MzoKD3scjtcluzpJSxfRMPB7R4CSQsMRmCm8azIR2wNzSJz
 Dk8brnZ70ELHcixUGg+35rmg1ZiZ9WsuwNqFZei95eHsAV85Gzq2pLvz7u9WtRr2ojgeN6
 S5Ps7QI+Z2CgqejWjr1N2nguOndBD5EzShHAPP025FB1ADlqNchCN3shlxVt4Xv0OR99ed
 ujF0/xDPlKmxUbvbKRK/i9chlx/tBMsz3tbkLZVTXUvrpyUa4/jj6qo87k4Qdw==
Message-Id: <fad92649-e362-443a-93ea-205b11247e6d@fygo.io>
Content-Type: text/plain; charset=UTF-8
X-Original-From: yu kuai <yukuai@fygo.io>
Cc: "Li Nan" <magiclinan@didiglobal.com>, "Xiao Ni" <xiao@kernel.org>, 
	"NeilBrown" <neil@brown.name>, <linux-raid@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] md: fix bblog_size-driven OOB read in super_1_load() and super_1_sync()
Date: Sun, 20 Sep 2026 19:50:56 +0800
Content-Transfer-Encoding: quoted-printable
References: <20260917083820.57091-1-ndaugoing@gmail.com> <20260917083820.57091-2-ndaugoing@gmail.com>
Received: from [192.168.1.104] ([39.182.0.142]) by smtp.larksuite.com with ESMTPS; Sun, 20 Sep 2026 11:50:59 +0000
To: "zjamg" <ndaugoing@gmail.com>, "Song Liu" <song@kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26aafc8a4+ef42b0+vger.kernel.org+yukuai@fygo.io>
Reply-To: yukuai@fygo.io
In-Reply-To: <20260917083820.57091-2-ndaugoing@gmail.com>
User-Agent: Mozilla Thunderbird

Hi,

=E5=9C=A8 2026/9/17 16:38, zjamg =E5=86=99=E9=81=93:
> In super_1_load(), when the on-disk feature_map does not have the
> MD_FEATURE_BAD_BLOCKS flag set, but sb->bblog_offset is non-zero,
> rdev->badblocks.shift is initialized to 0 while completely bypassing
> the sectors > (PAGE_SIZE / 512) validation check on sb->bblog_size.

How can this happen? If this is just raw disk metadata inject failure,
just add a checking in super_1_load() is enough.

>
> Subsequently, when badblocks are updated, super_1_sync() enables the
> MD_FEATURE_BAD_BLOCKS feature flag and assigns bb->size directly from
> sb->bblog_size without validating that bb->size fits within the single
> allocated rdev->bb_page (which is PAGE_SIZE, or PAGE_SIZE / 512 sectors).
>
> When md_update_sb() later writes metadata via md_write_metadata(), an
> unvalidated bb->size (e.g. 0xFFFF) results in a bio whose length exceeds
> the backing page, causing out-of-bounds reads into kernel memory during
> block I/O and leaking kernel slab/page contents to disk.
>
> Fix this by:
> 1. Validating sb->bblog_size in the 'else if (sb->bblog_offset !=3D 0)'
>     branch of super_1_load(), returning -EINVAL on oversized values.
> 2. Clamping bb->size in super_1_sync() to PAGE_SIZE / 512 to ensure it
>     never exceeds the backing rdev->bb_page capacity.
>
> Fixes: 2699b67223ac ("md: load/store badblock list from v1.x metadata")
> Cc: stable@vger.kernel.org
> Signed-off-by: zjamg <ndaugoing@gmail.com>
> ---
>   drivers/md/md.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 680b34a63cb3..d2433cf41e65 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1934,8 +1934,11 @@ static int super_1_load(struct md_rdev *rdev, stru=
ct md_rdev *refdev, int minor_
>   			if (!badblocks_set(&rdev->badblocks, sector, count, 1))
>   				return -EINVAL;
>   		}
> -	} else if (sb->bblog_offset !=3D 0)
> +	} else if (sb->bblog_offset !=3D 0) {
> +		if (le16_to_cpu(sb->bblog_size) > (PAGE_SIZE / 512))
> +			return -EINVAL;
>   		rdev->badblocks.shift =3D 0;
> +	}
>  =20
>   	if ((le32_to_cpu(sb->feature_map) &
>   	    (MD_FEATURE_PPL | MD_FEATURE_MULTIPLE_PPLS))) {
> @@ -2313,7 +2316,8 @@ static void super_1_sync(struct mddev *mddev, struc=
t md_rdev *rdev)
>  =20
>   			bb->sector =3D (rdev->sb_start +
>   				      (int)le32_to_cpu(sb->bblog_offset));
> -			bb->size =3D le16_to_cpu(sb->bblog_size);
> +			bb->size =3D min_t(sector_t, le16_to_cpu(sb->bblog_size),
> +					 PAGE_SIZE / 512);
>   		}
>   	}
>  =20

--=20
Thanks,
Kuai
