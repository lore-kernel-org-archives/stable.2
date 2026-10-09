Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2313C5DC3
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579864; cv=none; b=qppkOCV+fCSIyKbq3dfBet16TeK1vJ0tQS65/lf4Mj7iHehjePh/Ohwq/h40RVrg5mgI+mczoKfAPqNuKD5In3XoQXklPrVIJrF9R5GJzLp2lRuQwH1MyqhYnkgy41XvobCzxN1y1Xsknclox8aDAvnZb1eSY9nqJJk8TxR6n8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579864; c=relaxed/simple;
	bh=qN6wTt6esSVYwsfd775JJM+9/nreJkmrqFCaV4SlCAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4CNjrRbM2kAbXQktpvgxTxVrJkT41eIl6IVQfoT5T+JQNH+7JOr+apq8PgSfzO5/3ZvXlcsnth0OlLKxc1IudLBawrG6e3xEP8h1XEu5fdnMBFxLmEsSsKtM1mqPBHWsSs9XwGsB74T5T/A5oCEUlSoFnRAFwluaj3/x1tb+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V9y0hJ+d; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V9y0hJ+d"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so2885325e9.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791579861; x=1792184661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YL0mzFwQsFAIJ3BQgODpXdK53+kc5uCfH8dR9lXMlSQ=;
        b=V9y0hJ+duaCgJpjG4lfBxAFlTGgfvYJ+uBQSPqRWpHs7N3oFKp/+D65slP9/gwdKtZ
         UYCeFkHqXdghGfogf/HQIQnTvDy+LSAYE5tejZKznAz2LWwUlz175FTKqdqHIeK1TKCQ
         o9vru3GXIXsrMgOyEA7BnrQtqsKeqT0SrmaeqaUxuyDPdG+LAtyFB5FZiZwgkpMBi7+C
         HBMcJk4jmDFjNstJT5VnHTZiYiazSJ7t88KD51kKYe6I6ud1MMtxDvW0hVzBGFO64L+2
         w0ES1tAH34139Fzb4Xa5L6l+AK+U7oD7TmqlO7Mb33PhxgAE0YRqWKOJlfLm6H0hmh6F
         9MpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791579861; x=1792184661;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YL0mzFwQsFAIJ3BQgODpXdK53+kc5uCfH8dR9lXMlSQ=;
        b=oKGG7LqrKIwcZBgrkdXqLCNYUnSNQeM6BESFxB2UvRvF5ZvxRUCHk71slN6gv6Tsmv
         Y/5oo0pYDIxpTQ471qqjMUCaSMLNy+CljPKK/0npuXlEx+oK4F9g0B1KlS7M/x3W12xo
         ETw/W8SBcqJq1yvhJBVCUTP+Bpt8wxjZ4df7+NYKmi0+YfNPIw9mY+KIAhJHc7oYyzdp
         YOXuxjjm8l2RFVjrILknoXszrUeQ6jC/6pCFuqYM3ra4Mt0tyg674J0BAu/JgmhKwx1g
         Ru4rNnHjvl2HyrDYxcTjRNFhb6MwQe9Z0rbwtAAuDK3OqC3wJagmAtxRRJ2CCHWqttLB
         7c5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzFLPkcBEnIgeGrutuNcyyizcDhkiYGb3slyTy5/lgXAyYRekFwgssYE/hYwN3gXZEeTtXsgwU=@vger.kernel.org
X-Gm-Message-State: AFuF++ld7pf3NXGVltq4+EhPfVRaf2ly839bhF+Mq/VQbUFPmlocJGJe
	Y3BWGczKmKyGdnTxwiGyASd34f9W/UJcDfdfazAJhp1NTdMng4RU7JGGTNXo+Xf0/qk=
X-Gm-Gg: AYBFou0om65VO5xK2ZiMDp2iYjPEYUu5gDNq0kV6jS9oUR3o3modFQg1rabjRtG1yj8
	6/KZKJ9MHGFuWedBKUb3CvX4WDYxNG7WaoFu3f33O7MKU5+Ht6bviCEUDRZLvYAyPzaGU8F4Z1F
	0lQw10m96tmH3/VIE8euChq/yVCb6lK/jrLmiw+iZxdzJKOhB9cBFU3onr2S5Xn3EYT8J9AsIJs
	bKh1YEp+biu4NGVbJBXpVJZL0bKtu4Fd9N34NmHQfSjfOygK790jQwh8rmQHvViEmL4o6sCN//M
	a1a5a5KxryS1++3Rg7Hr1v0viYFzBF098gJ1IREbYt30sY+1DAUEIGElGItqvCA8ktBSbOvBDMO
	/2Buc0SdQGUrXKYCVwjGAs1JQqZJmT5QNHLOV/Vri86dvfgeLXcy8+QwRCEIbXEA8A1Ykv/Eiwp
	2osGwlzx3F/+eQKrS/V167x/UR7SKNb2UT9u0aMVKF6OjjxdcAmec5WUpk0wfNRkM=
X-Received: by 2002:a05:600c:83c7:b0:4a1:7733:5102 with SMTP id 5b1f17b1804b1-4a18e4a3fc8mr56932985e9.15.1791579861503;
        Fri, 09 Oct 2026 14:04:21 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e6cdsm16113685ad.28.2026.10.09.14.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 14:04:20 -0700 (PDT)
Message-ID: <5f16e819-f9e9-432a-9544-9277c356ce09@suse.com>
Date: Sat, 10 Oct 2026 07:34:15 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: return -ENOTTY for unknown ioctls on the control
 device
To: Hengyu Liang <hengyul@cs.unc.edu>, David Sterba <dsterba@suse.com>
Cc: Chris Mason <mason@kernel.org>, Boris Burkov <boris@bur.io>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261009173359.3486877-1-hengyul@cs.unc.edu>
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
In-Reply-To: <20261009173359.3486877-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/10 04:03, Hengyu Liang 写道:
> Commit 5ab2b180884c ("btrfs: factor out validation of
> btrfs_ioctl_vol_args::name") made btrfs_control_ioctl() store the result
> of btrfs_check_ioctl_vol_args_path() in ret before it looks at the
> command.
> 
> However, ret is initialized to -ENOTTY and the switch has no default
> case, so this initial value was what an unknown command returned. As of
> now, every unknown ioctl on /dev/btrfs-control returns 0. A tool that
> tries a control ioctl which the running kernel does not have is told
> that the ioctl succeeded.
> 
> The issue can be reproduced with a simple C program, run as root:
> 
>      #include <fcntl.h>
>      #include <stdio.h>
>      #include <sys/ioctl.h>
> 
>      int main(void)
>      {
>              static char buf[4096];
>              int fd = open("/dev/btrfs-control", O_RDWR);
> 
>              if (ioctl(fd, TCGETS, buf) < 0)
>                      perror("ioctl");
>              else
>                      printf("ioctl succeeded\n");
>              return 0;
>      }
> 
> Before commit 5ab2b180884c ("btrfs: factor out validation of
> btrfs_ioctl_vol_args::name"), the result is:
> 
>      ioctl: Inappropriate ioctl for device
> 
> After that commit, the result is:
> 
>      ioctl succeeded
> 
> This patch will add a default case that returns -ENOTTY.
> 
> Fixes: 5ab2b180884c ("btrfs: factor out validation of btrfs_ioctl_vol_args::name")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/super.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 823a58bd2685..acb704b20c2b 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2291,6 +2291,9 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>   	case BTRFS_IOC_GET_SUPPORTED_FEATURES:
>   		ret = btrfs_ioctl_get_supported_features((void __user*)arg);
>   		break;
> +	default:
> +		ret = -ENOTTY;
> +		break;
>   	}
>   
>   out:

