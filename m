Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515926;
	b=bUv0BeZ9HtRXqSZDyDXGJa24DolDDaZnUbI2CB6MKbWctrkbghUqEF1RWM1jYtVNgz3M
	 b3Prap1jviDdDGAoExgwfIj0jiDp6Du1SSFNG9imRHotfEK8j3ymkpElIDrBxmhZz9C7K
	 zYf3WgVi1m4jovrOczAjX53iVq55Q1Avawl07+UubAhA5tdmQOtXM9uLVUmFxy1XvQPiP
	 vtrXOhsaXkHCt+aH4SfZuLWxcM1eLt+7NTdkhRKZMcpLW0Mkz/rHHxNzwl69xYt9Ji+So
	 fG10lQVR3npsh9KvinFKcP+IGuHdXmqLWm+zXynjU7vABO9et2gjWcuYfb+9wWYPDNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iUeaN24ubqK+XseRTkWoI3CKdK3A8caVIym6MWDEuks=;
	b=XeZuVYr5HjUQ3BvGe3msf9U4Rq5vAsz0QTnI+f2ulYG6vM587hH25tsA5EhNe2izonr9
	 9b7SyRio/LBu3AhiYPTvlTD2gtEF0Y869rPcK8yrLfrDvvnKNM0sVsETf3OCUfvsUbBy3
	 k3533gcOxOxNRL7yxPtZIguSaBe1+fM65cYadvZwZEQqurwaH++ciqgRdEI1IvkpbXKRt
	 vLtRcEvILvyh+g7OJM9PCRru56Kevr7twRVX7EtCRqxSMx503UAVci/zl46Xrr2Rk+KCD
	 i5rJo/ABlEq8XHLsnO2qn1Pr9IfJWsJtCuT5p5atXCHjpy9RjgGkGU5NxQO2iE93zBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Xsqj3+XU;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BAD606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 06:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32BAD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Xsqj3+XU
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so20342185e9.2
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 23:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793515924; x=1794120724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUeaN24ubqK+XseRTkWoI3CKdK3A8caVIym6MWDEuks=;
        b=Xsqj3+XU3mQZSjjf07wQPdY/nmNLohqUNEGClT80Km4NVcC0DJ9ziP4b+NhVBFUURH
         xMpKsdKp8aA/ZhcXRuqyrX1kErYa90Zz980aUDriWDi7zh/8kXpFqTyMrvSo7xbyOcxA
         3CpjbrNeUS4DNaMBuP86gG+Kfl2qh6rhEID9C/LL1bpu+gHWWbnOAIpyxg6cTbViaxVJ
         FxagSd8MeNMXKezwdbV4/7NNZ8gybxv5sXXjtY788OEV0Qy0ExtbNlgU/XOL1QUt4rE6
         S0QiWK0v9GmENMwapszTSxvxOTsxpvPETcvQREDmzg+r0iEHWPIXaLWjvS7cpwXw90JP
         rn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793515924; x=1794120724;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iUeaN24ubqK+XseRTkWoI3CKdK3A8caVIym6MWDEuks=;
        b=g1gg5tJKo9ctT8oKykt21Z6Kxj0gWmED6JOlnticztZBrDcIfqXm/OOcdlIRkHTvJu
         iTqqEanvN2jRazo9BgzVH4AvsIw8l45leHQd8EM4wKSgsCzKrchkqljW4U1VeZau/mIb
         bN4DD+qzvyI8NFKWYMpZQPrcbykF5BhXGXz//jA4zzYB/6S+nRmrHWLk60O25zfuuCZW
         shjCm5oj/25oqBhadOF96eubejHB6XPDX80z7gXb+ZRh5YWU3bOuyiYPvEZmFVFF9uCx
         6JN6ZOs8YcXFz6TsHfFWmjwuQZkb01+ysLJ3wewgGqjAj43s+VyEag9Q9CwbCP9RvGpe
         kogA==
X-Forwarded-Encrypted: i=1; AKwUvBzOjcGvQw9Iom/TLLgMVxwquegyOwnzbEec3/GNTmsVjQ4P6XCqJZ3pVceZngx7dvxgAmZLRNc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIbSeLYmySv5gER9+CfQyj6tPACrr/Du45PiDFwMg97RLoStFh
	Hos7VvSqrfS/cqXJEOS82OA7dB9V8xbGk+f8C7txZzRhP7j/vyXVERI/ZQ4ohvv2DQY=
X-Gm-Gg: AYBFou12cH/KbQuQlnsSIapfN2wN1qg7a0nmoPPTZs8i0Mup53eKbdpU9DAkC93/xOA
	bo5XEU29gqejwyfrJLuoZSHg4XbZjJYsrV2hjYu/jSx/Kj1j219soRIMEjXqvz3kqHUoKV8INVb
	Pjgeni5iSWyhb6ucgjgf9MESWp8j/pSjXnvLEaaj7GOoH+kmvquwaFr3QBIuPjalLHclMZI1edW
	pvKqtMrdefKU37bMKClXLfwuc4sePHm76kEHMATeF4ABup9VS3h646HmWMwoxtt0VHvdBDGgHYk
	9dpWiJ9hEw242uD1qhue+TR1Z4EKq2zdHJ990OdWAb7uAO6yp35sT7DQ+Y1ZTnXReLS2tOdt0ZX
	7TF9hmiRuVuyGvudwrCVz/A75CLnHwil2EB+APTbefG7slc3DooxR6wdB9aHXvLkVBpAgQB4o08
	UEiChl50ocrKDxHptOX3fw+6DEoE5QLSTEETgnfCxILAOuyImBrBc7XhEP/L56oOoLoGNJcct7V
	pcUGxMQ74n49emRPnw87tquahUleZz91oRsfNTmdsAGAKceEUAVLSR0oa9NMv56yM00+HFBHgxi
	T4hLzsSRJGKef1lMf45IECR42cLQ7Gmjhw41LqPSmA==
X-Received: by 2002:a05:600c:1d29:b0:4a5:5fb9:5d35 with SMTP id 5b1f17b1804b1-4ac187a7678mr161246385e9.21.1793515924452;
        Sat, 31 Oct 2026 23:52:04 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1a16sm19922956c88.1.2026.10.31.23.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 23:52:03 -0700 (PDT)
Message-ID: <a92d223b-55fa-493e-821a-e5acc8afee08@suse.com>
Date: Sun, 1 Nov 2026 17:21:58 +1030
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
Subject: Re: [PATCH v2] btrfs: reject refs=0 subvolume without DEAD in
 SUBVOL_SYNC_WAIT
To: Cheng Yongkang <teel4res@gmail.com>, David Sterba <dsterba@suse.com>
Cc: Chris Mason <mason@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261101062539.1744605-1-teel4res@gmail.com>
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
In-Reply-To: <20261101062539.1744605-1-teel4res@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/11/1 16:55, Cheng Yongkang 写道:
> btrfs_ioctl_subvol_sync() assumes that a cached root with zero
> references has BTRFS_ROOT_SUBVOL_DEAD set, and asserts that before
> waiting for the cleaner. Two states break the assumption:
> 
> - A corrupt ROOT_ITEM with zero references and a matching orphan item,
>    on a writable filesystem.
> - A failed subvolume deletion. btrfs_delete_subvolume() zeroes the
>    root references, aborts the transaction, which forces the filesystem
>    read-only, and then clears DEAD again. No on-disk metadata is
>    corrupted in this case.
> 
> With CONFIG_BTRFS_ASSERT=y, both reach a BUG().
> 
> Before waiting for a deleted subvolume, return -EROFS if the
> filesystem is read-only, since the cleaner does not drop dead roots
> then. The check runs on every iteration, so it also stops a waiter
> when the filesystem becomes read-only during the wait. Subvolume
> deletion holds subvol_sem for writing across the abort and the DEAD
> rollback, and each iteration takes it for reading before inspecting
> the root, so the read-only state and the cleared flag are seen
> together. On a writable filesystem, report a zero-reference root
> without DEAD and return -EUCLEAN instead of asserting.
> 
> Subvolumes that were not deleted or do not exist still return -EEXIST
> and -ENOENT, also on a read-only filesystem.
> 
> Tested on btrfs for-next with CONFIG_BTRFS_ASSERT=y. A deletion made
> to fail by fault injection after the references are cleared hits the
> assertion in SUBVOL_SYNC_WAIT without this change and gets -EROFS with
> it. A waiter on a deleted subvolume now returns -EROFS when the
> filesystem is remounted read-only, instead of waiting until it is
> signalled.
> 
> Fixes: 6c83d153ed86 ("btrfs: add new ioctl to wait for cleaned subvolumes")
> Cc: stable@vger.kernel.org
> Suggested-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Link: https://lore.kernel.org/linux-btrfs/dd97efe9-91ec-495b-b698-acff1447421c@gmx.com/
> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
> ---
> Changes in v2:
> - Return -EROFS on a read-only filesystem before waiting for a deleted
>    subvolume (Qu).
> - Use unlikely() for the inconsistent-root check (Qu).
> - Describe the failed-delete case separately from corrupt metadata.
> - Add the Fixes tag and Cc stable.
> 
> v1: https://lore.kernel.org/linux-btrfs/20261025180258.349175-1-teel4res@gmail.com/
> 
> Testing notes (btrfs for-next d1dca33127ef, KASAN):
> - The fault-injection case reached the cleared-references state in 2
>    of 4 attempts on each kernel. The other attempts aborted earlier, and
>    both kernels returned -EEXIST.
> - FOR_ONE, FOR_QUEUED, COUNT and PEEK return the same results with and
>    without this change for live, missing and deleted subvolumes, on
>    writable and read-only mounts.
> - The -EUCLEAN branch was not exercised. A crafted image with a
>    zero-reference root and no DEAD flag hits the assertion without this
>    change, but remounting that image read-write stalls in a transaction
>    commit with or without this change, before the filesystem becomes
>    writable.
> 
>   fs/btrfs/ioctl.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9857d6a9d456..5a1f2edfd831 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -5166,8 +5166,14 @@ static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *a
>   			return -ENOENT;
>   
>   		wait_for_deletion = true;
> -		ASSERT(root_flags & BTRFS_ROOT_SUBVOL_DEAD, "root_flags=0x%llx",
> -		       root_flags);
> +		if (unlikely(test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state)))
> +			return -EROFS;

I'm not suggesting such an ad-hoc check, but some more comprehensive 
checks, like mnt_want_write_file().
As this one won't handle aborted transaction.

But it's not a good idea using that mnt_want_write_file() either, as 
that will block pm suspension/hibernation, especially considering the 
wait will only be handled by cleaner thread.

The default timeout for waking up cleaner is 30s, which is definitely 
not suitable for such calls.


If you are not sure what to do with the RW check and cleaner behavior, 
just don't put an adhoc solution into the update.
At least it won't be any worse.


> +		if (unlikely(!(root_flags & BTRFS_ROOT_SUBVOL_DEAD))) {
> +			btrfs_err(fs_info,
> +				  "subvol %llu has refs 0 without DEAD flag",
> +				  args.subvolid);
> +			return -EUCLEAN;
> +		}
>   		sched_ret = schedule_timeout_interruptible(HZ);
>   		/* Early wake up or error. */
>   		if (sched_ret != 0)
> 
> base-commit: d1dca33127efacd86ac550aa86352f8ea9f29a5a

