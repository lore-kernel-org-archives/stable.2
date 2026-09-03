Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9386B3B6362
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429714; cv=none; b=mZ25BIKcnyG+3S8qz3I/Hb4k753wtNbghMrVkCLIqQyeb9cDKuaLb2sfHweQDLKwqbH2CrSjIiy9sy2G3h9FQ5OQJ6yDR9Now27n/SSUTV0Kd+NkrEm5sKIDLFAAMFcw4vWyURsom9zzeUy9EzRkN8O8TjC25Db9cIcGsltOOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429714; c=relaxed/simple;
	bh=eVvi+oZ7zm88Ak3ECTPd8lI8OZXgbUS6E+jFC1A/eAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5UNWsQGhaGeihpgFUd9z9j7Tl6Fo49qqD5uqM/lN7On5GN1vTMKx/GBfMsNKqGgQzaUo8M9tF3eLxyGLr238xjFTECBRIX0RD72iFXj5KeQnyDj994ZNjyzUG9BYfkayaVELnGm/FPnGKezEHzbBPwrIW/J07Zm6QwCTFnTTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY6QSZ0s; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY6QSZ0s"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so1955322a12.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788429712; x=1789034512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ce8M/7qhkjbYOloNei8s08cubgJ3TDWZ5Dcu7749Xg=;
        b=QY6QSZ0sHTL8yz9B4MF6wHI+j+VZNO/a4VAS3sVZHsuN2C6RBZC/Dp67vQAQY7EoTR
         tXC2ZrgirvQMViYy4EJHGoI3BJR0hVS5bMSCj0DBB/Ree3clrWHa6oSAPEIe9YRvjIVD
         MIKgxfGpyMGPetHR+IED4St5NvGHZZgbfBKB9J9xvLZJ/lLD+tzVqOYddN7QTEoQxnXU
         YS/0YMRnoeA21hlWatP5UyvzJT0XWY+AjeEkwQGQdkBr7ubqJE4QFaQ5dO12S48ZBm90
         jMJGZ/5Ry1cJFIR1Kl68ldSP78AjTCpdcjADhavlNKFs0hcoLw6go+fyjqY1VS9jF+Wa
         uqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788429712; x=1789034512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ce8M/7qhkjbYOloNei8s08cubgJ3TDWZ5Dcu7749Xg=;
        b=F3hzryKuPQcSS/lqcGRD3PqhZbflpRMxciNQ0de9vw29cMUBEjyH5uOi5wPkP59oTe
         +vv66d/XY8s3q8RXvwc1Wxe3JL5Ft6NAbWWl6VDO2aSpOI2tG5DLpWMdRDJ1YiV53+Wc
         UX1AKlUu7Z8NYIDzAtOXIdMZKVpVfDrh7aRtGQqgHrH/BXtv8YfkaNjGYQCBShmWi/eM
         wIYAh6+zteBBzFTme00hKCNIEQSxVylQH9nvk0YN5QYJqcoWfiRfop/gn33nZadMyDsN
         t3c64t4xScg6FReNDsX2/zat4uDscBSKmrmwINlfb5o8f3e/mBA2M1v7czu+XRtUrorG
         moyg==
X-Forwarded-Encrypted: i=1; AKwUvBw7wHJ0PtEFtKvaDRN24W5MA7MKX4ptpTEVx1W/LDPVYH+wyYHwKzkId7+hWrzxGFQrGFGHAtY=@vger.kernel.org
X-Gm-Message-State: AFuF++kENwhAVacT1ktTdAvX/bExHIZ/hJ8q4pZVjkRoPfM5/Dt3bwlc
	n9kGHyzHxZPnKRsbsoOTJaNjPqaZ5j7NEuDY1kMrWEd8ZCaiitI4bmZ5
X-Gm-Gg: AYBFou1wXGnSWkWzyf1cvC+lIixPLzmiw9OnmJQlFAEkJ/4cSVngONfIuS4XWOzf9E0
	Eu/n6kLW4NkH7UNKGfj4IbqbTqgJ/OBgVyOXOtcU0kUgEc26rGvwkcdcnbc2KDiMs5Rkxn3efjp
	FNYrtKTZ4+CNeh6i3G+fm1Rkp3YyBx2mQt2pu/flPRuiPFoyIkzKuvhftMvVJKIg7NEskeNA+Xb
	22ATqCbDvGXEpcVw8b+1ETHeSVit6MtS4RfkKmWkoVHoNi9fKAoKEe9rv0VXaIcnE+2uktFB/AM
	tlFMGO4axzMJvy/w7OLf7gCEh/y8pRLtHCiLRct0Nmy1jNzDzIUGpSQNLwIBglm4YleUCKqYxNl
	iLIx0GP0DAehlgCtXAaLsRFStcu4A5S4EgwYuHuqGN7F8F2D0hzAmqt19W+fffYXtksFCD06uy4
	3EJ2Xh1EcetVHP2iRrSXD/UOwNSer39GeRTpT3YHEN1at4/4GRo99ymWXo94w=
X-Received: by 2002:a17:90b:4c4c:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-39aedfc9616mr16315183a91.11.1788429711355;
        Thu, 03 Sep 2026 03:01:51 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08766a2dsm4456658a91.15.2026.09.03.03.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:01:50 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 4/4] mm/damon/sysfs: set next refresh jiffies per sysfs context
Date: Thu,  3 Sep 2026 18:01:41 +0800
Message-ID: <20260903100142.106449-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902002725.108635-5-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 17:27:23 -0700 SJ Park <sj@kernel.org> wrote:

> When 'refresh_ms' is set, DAMON sysfs interface periodically updates
> auto-tuned parameters and DAMOS stats.  The timestamp for the next
> refresh is initialized when a DAMON context starts, and updated in its
> damon_call() callback function.  That is, each DAMON context updates it.
> However, the timestamp is a global variable that is shared with all the
> contexts.  When there are multiple DAMON contexts having different
> refresh_ms, the update frequency will be changed, depending on the order
> of the contexts.  When there are multiple kdamonds, it will be even more
> chaotic.  Fix the problem by having the timestamp per each context.
> 
> The user impact is not very critical.  It does not leak, corrupt or
> crash.  The update will not be faster or slower than the lowest and
> largest refresh_ms values of the contexts, respectively.  The user can
> also manually ask the updates on demand using kdamond state commands.
> That said, clearly this is a bug and can easily be reproduced.
> 
> Fixes: 9fd7bb5083d1 ("mm/damon/sysfs: change next_update_jiffies to a global variable")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/sysfs.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 3c81b4c91ac0d..dcb739ce0a729 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1788,6 +1788,7 @@ struct damon_sysfs_kdamond {
>  	struct damon_sysfs_contexts *contexts;
>  	struct damon_ctx *damon_ctx;
>  	unsigned int refresh_ms;
> +	unsigned long next_refresh_jiffies;
>  };
>  
>  static struct damon_sysfs_kdamond *damon_sysfs_kdamond_alloc(void)
> @@ -2213,17 +2214,15 @@ static struct damon_ctx *damon_sysfs_build_ctx(
>  	return ctx;
>  }
>  
> -static unsigned long damon_sysfs_next_update_jiffies;
> -
>  static int damon_sysfs_repeat_call_fn(void *data)
>  {
>  	struct damon_sysfs_kdamond *sysfs_kdamond = data;
>  
>  	if (!sysfs_kdamond->refresh_ms)
>  		return 0;
> -	if (time_before(jiffies, damon_sysfs_next_update_jiffies))
> +	if (time_before(jiffies, sysfs_kdamond->next_refresh_jiffies))
>  		return 0;
> -	damon_sysfs_next_update_jiffies = jiffies +
> +	sysfs_kdamond->next_refresh_jiffies = jiffies +
>  		msecs_to_jiffies(sysfs_kdamond->refresh_ms);
>  
>  	if (!mutex_trylock(&damon_sysfs_lock))
> @@ -2271,8 +2270,8 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
>  	}
>  	kdamond->damon_ctx = ctx;
>  
> -	damon_sysfs_next_update_jiffies =
> -		jiffies + msecs_to_jiffies(kdamond->refresh_ms);
> +	kdamond->next_refresh_jiffies = jiffies +
> +		msecs_to_jiffies(kdamond->refresh_ms);

The fix looks correct to me.

Moving next_refresh_jiffies into struct damon_sysfs_kdamond gives 
each kdamond ownership of its refresh schedule, so refresh activity 
from one kdamond can no longer interfere with another.

I also checked the initialization path: the new field is zero-initialized 
by kzalloc_obj(), and damon_sysfs_turn_damon_on() sets it to 
jiffies + refresh_ms before registering the callback via damon_call().

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

>  
>  	repeat_call_control->fn = damon_sysfs_repeat_call_fn;
>  	repeat_call_control->data = kdamond;
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
