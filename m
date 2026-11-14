Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665806;
	b=Z8mMgBdwDW7eGl/0I5ZpEK0O9OPakv3BOr8wiu198BcDDO3OqUQbv02spZTZ/QLWRiIu
	 xFh+XpuE3+aTDR7xGAe9XaAjPTw3xNs7BY+jPG6rI6tLlePK+ZyJSxiK5w0UUOUMw3niW
	 5nK6nxmCy3jsD7YIBy7oFMJSN1u8LKyt78kbv9fV/I2tgl1P8Rhv4Bmy7LRPLMaVRyLlm
	 yarKFdN0Kyj4FdVA8ykBzBAyoN7EoUQwD5ruWpVQyq3iT1Ns+Na+WlG8mlHFrGt7WOhdz
	 7bvxVYByuQHGvhGja+qeLxk8barPe1SQ30I4V2woSFykvIK3VC63ddkEhGfBaX6r1hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Rsh3PSgy5EeLZfkj2Ume/HSuLoP9g7O08oXc9D5ZzEE=;
	b=w0D9MR9BrgoaRtVxmIYf63ItkZlfkFNFHoJu/cwIX1Vy4uCdZIRuEcRACADAevnNWNoP
	 6S8zZQsAQlcjXfWENOxzreF4fscmADp3B4e6b0xGDlffJuN1xI/RkeAPXOQqYIptJKPDq
	 4eX/TONYH5JGcY0JqnIm3GPTJeVzpq5eUYUlZD5tGUB85eGNlAxHohrJfLdM1OLQEiWG0
	 l9RBclEjIw2qf9Kt1cZtT2h48NpAeIeIRg5sSP4Hj9URHVG4DxM3uedSGeg/++j/37WC2
	 3gGZ2fqas2k79kOAqKCAWXQeUOPIU7NC4/NpzHPcpnPmb6S1kWxCIfIld/HfsNpsq4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0c5nFMdk;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A0606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 14:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 826A0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0c5nFMdk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1034061a91.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794665806; x=1795270606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rsh3PSgy5EeLZfkj2Ume/HSuLoP9g7O08oXc9D5ZzEE=;
        b=0c5nFMdk+yWbf+C71VnSAz6BsODM7dxwkDZmx2JZm5IkItwZpYWzZfIvg6VsN8404b
         HTmIIYJuqYP2sCa26kYtaDGmw6/fSO7ma0s4eNBzdDrUw3NI2mgBJn6HxyZACOODKRbJ
         bBZJb8UzWt3pXG97XUG3hFsbegZjKtfiU5HgKEYcOGj1LdurgttVu+PCFtUoacel/GXa
         zKWYHFe572C1e/q2OkehmmkkAFBLAmY6X/Qu0lQGzE+2FU6SrMxsAsjFV+jPxQNxVGMJ
         kxtKQovgbBec4A8Y6J4uilYZFLQB1yzzBSyO3jfoToPvImCHJOga22LziUdcDaYNuwu1
         5aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794665806; x=1795270606;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rsh3PSgy5EeLZfkj2Ume/HSuLoP9g7O08oXc9D5ZzEE=;
        b=zf28Os1A7N6QadCGNQFREsyhx8N8lYbkpCU9anVIqFaKSA+DjQ/e9Y/7/TeT5cKbcp
         UjfUTvysNYsCIh5uckVHOAObk5dzf2cKc/WBcSbwx/57Kz6zrcWVuHUrt8bHWiYIw5dI
         8tAP6Imo3kT2G1gbaxH0TWGY4cqAg0KGRmkJHld8cu7rdvwka8cSYBNQAv6LmrIxL3Gp
         iO9d1QevGOzk5mvjA/eBn/zNkQ86zfG3bgxeXVpJ/M/lUGph44bzLNYqbWMyxwePAGpH
         MoB+LmrBVS55hKvA0y/17lCIFPYvKzZw4fhvRgf+GkPXiiBiVWy1igBzY1Zy1O03Ii5t
         4QWA==
X-Forwarded-Encrypted: i=1; AL+hErH0zB9zxyUMrKuui8D+zpcf379FLqC+/0gfr5vO75SKJvFKjVBsj5OMioYMz9xZ8dae8V2YKVs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CIjtE58tknK1W5wxA3zbrZp4FX3B8H+t5CjBVh/Ty0+YAr4VS
	U3DKUmyQuucsXaKZ82tLD1YYNPGbsfkb72wRbR4HF2nIv6qAOyNSmWPQ
X-Gm-Gg: AYBFou3nmeGLPCH3h/ttLFDHVC2ZK8A7YUbUYmADtg8aulhd8fU6G0GnAG4fVOjcQiG
	Tfht5dE+peUVcFwYnT5jsi8svfVQGeVdcTTCL+VlTG2pibg+Je8x2AmpLTHtj8YvfdaHbtuTA95
	2Tqii9J4fzCpskhdzTfgpqG1C6xYEkCLAWjPcp2DRYJLgzgm3POXDLvOIaQXBEizJJl0rhJTDy6
	r2QHTwTcJBJKP4hYp6HSYZuDdJh3RHT3WFgfIfwUrq9V+3cq1lQ6V2g0bZr5+vdKVQtCWxEYQ3f
	pDXfKzOrVoqps9pDayAtexjMSi3L3UIu7yq0f1I4jqeCkThGlRZFMBtSI7cMX6ZBw0hmir4v/fJ
	6bZjpFJfgnZo1CYyouWDq5Ryjc8h66W8gGxt6nhjhVKlGsPJJUSp1E12psydBKiCwX2Pi0FZfMx
	5saffdq1SJhnxI2UpG3KHOEZdxFgvYNegpV6vQXMR4ByqJ8G6a092zFNn3SWJ0d8/lpYRl8c2Pm
	H5kgwqDWWx4LuMc9Ls4gBTlgPl7uHIZSjnL6qUdW4+vizLogWmhEci7A+kfWiOKxFJP/mphVjYe
	S6cEpCA660524LqXbSVlZoDN5lPoKaqmmK+j2uzm872lwDTTlvfu0dxDN/VjCeWgIvg=
X-Received: by 2002:a17:90b:440b:b0:3ac:adce:60a8 with SMTP id 98e67ed59e1d1-3b1b07ef8bbmr5367145a91.5.1794665805884;
        Sat, 14 Nov 2026 06:16:45 -0800 (PST)
Received: from [192.168.35.40] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b245f0c3sm4377768a91.0.2026.11.14.06.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 06:16:45 -0800 (PST)
Message-ID: <94a65d65-e81f-4942-b119-51b71e8eabb4@gmail.com>
Date: Sat, 14 Nov 2026 23:16:41 +0900
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
Subject: Re: [PATCH v2] PM / devfreq: governor_userspace: Guard against NULL
 governor_data during switch
Content-Language: ko
To: Finley Xiao <finley.xiao@rock-chips.com>, heiko@sntech.de,
 linux-pm@vger.kernel.org
Cc: cw00.choi@samsung.com, myungjoo.ham@samsung.com, kant@allwinnertech.com,
 kyungmin.park@samsung.com, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, tony.xie@rock-chips.com,
 huangtao@rock-chips.com, stable@vger.kernel.org
References: <20261022022109.642339-1-finley.xiao@rock-chips.com>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20261022022109.642339-1-finley.xiao@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/2026 11:21 AM, Finley Xiao wrote:
> The userspace governor is the only one that uses devfreq->governor_data,
> allocated in its DEVFREQ_GOV_START handler (userspace_init()) and freed
> in its DEVFREQ_GOV_STOP handler (userspace_exit()).
> 
> When switching governors via sysfs (governor_store in devfreq.c), the
> sequence is:
> 
> STOP(old) -> df->governor = userspace -> START(userspace) -> userspace_init
> 
> Between the df->governor assignment and userspace_init() completing,
> governor_data is still NULL (the previous governor never touched it,
> and the core does not clear or pre-allocate it). During that window,
> asynchronous paths that call update_devfreq() outside of the driver's
> control -- the OPP notifier (devfreq.c:686) and the pm_qos notifier
> (devfreq.c:707) -- run devfreq_update_target() under df->lock and reach
> devfreq_userspace_func(), which dereferences governor_data without a
> NULL check, causing:
> 
>   Unable to handle kernel access to user memory outside uaccess routines
>   pc : devfreq_userspace_func+0xc/0x28
>   lr : devfreq_update_target+0x58/0x158
> 
> Add a NULL check in devfreq_userspace_func() and fall back to
> previous_freq, which is the same behaviour as the existing "no user
> frequency specified yet" branch. This closes the race for all callers
> since every path ultimately goes through get_target_freq.
> 
> Additionally, take devfreq->lock around the kfree()/NULL assignment in
> userspace_exit(). Without it, a concurrent OPP/pm_qos notifier running
> under devfreq->lock could read governor_data after it is freed but
> before it is set to NULL, constituting a use-after-free.
> 
> Fixes: 5fdded844892 ("PM/devfreq: governor: Add a private governor_data for governor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Link: https://lore.kernel.org/linux-pm/20260723080806.1451-1-finley.xiao@rock-chips.com/
> ---
> Changes in v2:
> - Add Fixes: tag and Cc: stable@vger.kernel.org
> 
>  drivers/devfreq/governor_userspace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 3906ebedbae8..f7a485c43fd7 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -24,7 +24,7 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>  {
>  	struct userspace_data *data = df->governor_data;
>  
> -	if (data->valid)
> +	if (data && data->valid)
>  		*freq = data->user_frequency;
>  	else
>  		*freq = df->previous_freq; /* No user freq specified yet */
> @@ -110,8 +110,10 @@ static void userspace_exit(struct devfreq *devfreq)
>  	if (devfreq->dev.kobj.sd)
>  		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
>  
> +	mutex_lock(&devfreq->lock);
>  	kfree(devfreq->governor_data);
>  	devfreq->governor_data = NULL;
> +	mutex_unlock(&devfreq->lock);
>  }
>  
>  static int devfreq_userspace_handler(struct devfreq *devfreq,

Hi,

Looks good to me.

I think that it is needed to lock  on usrespace_init.

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index f7a485c43fd7..cfbd72892598 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -94,7 +94,9 @@ static int userspace_init(struct devfreq *devfreq)
 		goto out;
 	}
 	data->valid = false;
+	mutex_lock(&devfreq->lock);
 	devfreq->governor_data = data;
+	mutex_unlock(&devfreq->lock);
 
 	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
 out:

