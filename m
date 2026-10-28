Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173853;
	b=c4P+apx3g6KrJmvj7yC+R6A0GN+xhCRzQh7DnER5DOqnIzMqjkRXrm+GVAtA93QgazjW
	 IcLghp2wg3vi5T1YoIruFWKwoOcnVfL8t+/+LWdCVdRdwB+pX/XHWp8WqTEP9UPJevIoc
	 Ry1+5brNBmunqLZa0LBNEGGvPwpZPXKm1qToCO9WsltWKsi85k19Jk6sagpbE41JZjW0z
	 0zKaXxFwmsdnxJoxxU21nh+E8eUHxkEIWRJ3DVcRzY6AdARvJDWIEWGQhAdFZMF2zDiuM
	 oj9+KYanU7wT+FOf7Wub+tpCrLUDUWN5neRsGnzlg/n7ZcXnPdctUUhWGsFHrEMolDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QabUepZshTuWcPWLH/f6M3OiVm66qar29q1ZiPFt4co=;
	b=bvKRBY2cQbe6lUR6Fb8rhtkvPd3A+apROFzTJ6t6wu/D+Y01AXNnxOMHTOyURfnRppMd
	 a2oyworPlAbZbVV4bmVKrh0pMNV+9WoUaPZMuC75X/TRMgixGNiYEpQe41bO5Olnp8hcX
	 xenn9pXCWn28/hP9/a88gqRhuK8UFwLIWFSLXPk13gx6L0pNobuQv3n/Sg1JX4qD2RcTX
	 mdduDEi1PuI5BkBevqDztIfkW4gyE/8tJrRxJg67YLzFfuOo5L2x+Fd0O/7wm5Ig9uZ6a
	 Wsy6Ip8+tgKqicm5ceook3cBv7D/IR6o0Hy6VZvmcBQnj+2J9liSda8NfbdClHfVwLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=cIzTfwvI;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA0606A333
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0FA0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=cIzTfwvI
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so10752785e9.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793173851; x=1793778651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QabUepZshTuWcPWLH/f6M3OiVm66qar29q1ZiPFt4co=;
        b=cIzTfwvIeV2p3+HZONnaLs8OrALR1BiQZsuEHFv22k5tMpn87c699RB4pXtpO1BknZ
         w7mFc/NBuJ/LAraXW70R5EtX0MqSS4DHIYhaaK3x8RDhKQETu2gPyFaLw8QlT07DFmBy
         h4TeAG55cDuS9WgM/KuuXL/YnXqyY0QDsLIj4e3bPqq5OyiMw+/0Mfdyk6LGeGLmZyaE
         I2kApHS+fxHb6U8Xha4YMCFI9beSJ/0SgvmgggOctUagsh08ImbV+oTWYJfOT6s0xrWL
         t3VuHw/TDKPR6xf82IXNxdgzIU0r5Nf2P+iQ1/pq4Zq3Ps5LagWwiwVa+Ej2c5BIOp/V
         usRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793173851; x=1793778651;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QabUepZshTuWcPWLH/f6M3OiVm66qar29q1ZiPFt4co=;
        b=KjBypAPpXu47B3bd7QptRPhnaRrBmXeAVjfgop9Lg+C1587n+AnUo2xr/3rowPk9tA
         cNABR5ggwKASxmM4rYQuzP/Co+I78gE/zW3aXaR6F9PJCQng8ZNonzLcgDC8I9IFVkWg
         41yUoUYYxuytkfpaErUolX1+ktTDpVVif4UbTw2bQNIEMpozBb54hsesDYLZxHMwsXjQ
         q/pVZ2nnWz6F4mtH5GyAzme7x+S2Hsu8R3QZ7ghhILB4R1NOT3QLFV/G4GSOvfJviHxu
         fLwHS57drZhpdc8wYKUce1l8SgLcdJp6F4bQu7jZFeCCDh6olszrcTyOO0NhrIr84myL
         pohw==
X-Forwarded-Encrypted: i=1; AKwUvBxI/r5w6nuTYMcaTo5uvuGd+s934q9qddF32kDvuE+vDJRMkDZ4/lwuTCWPgtfsOJ4ghO9TcwM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQy2U3mQNmW3/+jiabuFH81X5+puX1w6XM5Qxt7dI3ZZIGcjbB
	aD7T+tj/Aou3rHLkNc+IT0KbtIeVashtYf5yFFckcHG0NDGbHFuIETjo2VFaJ8PopCw=
X-Gm-Gg: AYBFou22Bjxp+9xOdbY5anx8MSqv7666iXnz70RGl2BTNUfcKYIfo1zoSqXd6pSNCwZ
	6BL/e5cpRAVZ0Gyp9tRCX9+GeXhealGuzpcA3VxZBIaYNihP3k1wwweO/eDM9Q5ftUk8uwnm52E
	NPfzJNc6tR2P6ge+9HYWnxkFaCdsc8QMmVpKouYvg7zxCC4phSskqQR7Pz8k3UbnT5MAD9IJ0aI
	bUngg4Pnw6bOTqorCKk96RxjHGn2oFMUEJevKY4VXhcOhCth/2uAMVj8VD7HMlqASW4mwNfiJyh
	hpAgoXD5eSydXnnXXsRwoDgKoThZuW3JG0FPkucXw2PgqydLffmY1gF/jDTCvIJrofAfPL2zoh2
	Gk5w5WgkDaIhVXCzTGmKRL4VsrweMRyMo2IemYjxWC4/hNIUA6m2/Pv8+231KrGxN8SNh6O3i+V
	MN3CGVjnnKsOQQoEUESXzkHLzK6Ez7pNippU5zgm556tLF9tt256f+Atp5JaRSmGRXAZgcL/zkO
	RDwwS9Xl7ZCk1awCFim5sdNMj3oj2sZppeQjmhpcBOaPMy3J+3oe3Ny5XJA3+88tkbbdhrgdSDR
	bHsLcrYcbLdr74iUWoH5Cg==
X-Received: by 2002:a05:600c:6dc2:b0:4a3:5d64:e063 with SMTP id 5b1f17b1804b1-4a7c4c7e93dmr87769765e9.9.1793173851270;
        Wed, 28 Oct 2026 00:50:51 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a4fc46csm1876135a91.7.2026.10.28.00.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 00:50:50 -0700 (PDT)
Message-ID: <8ac505b5-cb6c-46ae-8791-c39de5babe66@suse.com>
Date: Wed, 28 Oct 2026 18:20:42 +1030
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
Subject: Re: [PATCH] btrfs: do not leak -ERESTARTSYS from FITRIM to userspace
To: zhiwei.liang@zliang.me, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Filipe Manana <fdmanana@suse.com>, Robbie Ko <robbieko@synology.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261028-btrfs-fitrim-freezer-v1-1-0ad1d58aa94d@zliang.me>
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
In-Reply-To: <20261028-btrfs-fitrim-freezer-v1-1-0ad1d58aa94d@zliang.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/28 17:27, Zhiwei Liang via B4 Relay 写道:
> From: Zhiwei Liang <zhiwei.liang@zliang.me>
> 
> When a suspend starts during FITRIM, fstrim can fail with:
> 
>    fstrim: /: FITRIM ioctl failed: Unknown error 512
> 
> On a Fedora 44 laptop with kernel 7.2.7, 3 of the last 21 weekly
> fstrim.service runs were in progress when an automatic suspend started.
> All three failed this way and left the filesystem untrimmed.
> 
> Since commit 69313850dce3 ("btrfs: add cancellation points to trim
> loops"), the trim loops return -ERESTARTSYS when
> btrfs_trim_interrupted() sees freezing(current), and FITRIM returns it
> to userspace. Since commit bfb670b9183b ("btrfs: handle user interrupt
> properly in btrfs_trim_fs()"), btrfs_trim_fs() returns it right away.
> 
> -ERESTARTSYS is only valid while a signal is pending, because only the
> signal handling on syscall exit turns it into a restart. But
> freeze_processes() first sets pm_freezing, which makes freezing() true
> for every user task. Then it walks the task list and sends each task a
> fake signal. The trim loops check btrfs_trim_interrupted() after every
> extent. If a check falls in this window, the loop returns -ERESTARTSYS
> with no signal pending. Nothing restarts the syscall. On that laptop,
> with a few thousand threads, freezing user space took 2 to 5 ms in each
> of the three suspends above, and all three runs hit this window.
> 
> Make btrfs_trim_interrupted() treat a freeze as an interruption only
> once the fake signal has arrived, i.e. when
> freezing(current) && signal_pending(current). freeze_processes() sends
> that signal in the same call. The trim loop stops at the next check
> after it, so suspend is not delayed.
> 
> The restarted syscall re-reads struct fstrim_range from user memory.
> When the device phase is interrupted, btrfs_trim_fs() has already stored
> the trimmed byte count in range->len, and btrfs_ioctl_fitrim() copies
> the struct back unconditionally. The restart is then asked to trim
> [start, start + trimmed) instead of the requested range, or fails with
> -EINVAL when nothing was counted yet. Skip the copy_to_user() for
> -ERESTARTSYS. In all other cases the partial count is still copied back.
> 
> Tested in a VM with pm_test=freezer. Without the patch, 18 of 20 freezes
> during a trim leaked errno 512, and 10 of 10 restarts after a
> device-phase interruption failed with -EINVAL. With the patch, all 30
> runs restarted and trimmed the full amount.
> 
> Fixes: 69313850dce3 ("btrfs: add cancellation points to trim loops")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Zhiwei Liang <zhiwei.liang@zliang.me>
> ---
>   fs/btrfs/free-space-cache.h | 3 ++-
>   fs/btrfs/ioctl.c            | 7 +++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
> index e22443598b..cba2f5fd6b 100644
> --- a/fs/btrfs/free-space-cache.h
> +++ b/fs/btrfs/free-space-cache.h
> @@ -58,7 +58,8 @@ static inline bool btrfs_free_space_trimming_bitmap(
>   
>   static inline bool btrfs_trim_interrupted(void)
>   {
> -	return fatal_signal_pending(current) || freezing(current);
> +	return fatal_signal_pending(current) ||
> +	       (freezing(current) && signal_pending(current));

What if pm freeze has began but a real signal is also pending before the 
fake pm signal?

>   }
>   
>   /*
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index ac070c745b..b02c59cbb0 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -529,6 +529,13 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
>   	range.minlen = max(range.minlen, minlen);
>   	ret = btrfs_trim_fs(fs_info, &range);
>   
> +	/*
> +	 * A restart re-reads the range from user space, so do not clobber it
> +	 * with the partial len the rerun would otherwise take as its input.
> +	 */
> +	if (ret == -ERESTARTSYS)
> +		return ret;
> +
>   	if (copy_to_user(arg, &range, sizeof(range)))
>   		return -EFAULT;
>   
> 
> ---
> base-commit: e17e64baf63f7c85bec209ed73f14c1b2a7e39fb
> change-id: 20261028-btrfs-fitrim-freezer-d4cba16e7e13
> 
> Best regards,

