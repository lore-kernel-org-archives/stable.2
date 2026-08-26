Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF63B6C05
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787736248; cv=none; b=HiCxTnJ7SC6E5mRm5onzdEc5yBicZu+XdidqqjTPfmk3QtEVg6cehHkW1vYByOzk2/Ba06ufvoP3cSo+AHdL3Ty+osEfJSQDTSNyCtvunSzp8jlhGz2ayXNdErje72Gw8Qv2LBtl7QFF8O3+WBkfpl+daHDnlqQlO2/XxAr1/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787736248; c=relaxed/simple;
	bh=HqnDvKEanItWN4sZGrC35XsJJ1cF3PJL+CnWLNUiuN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EeIGDinTjvPMh6D7VqWehOTYHehU0Q5fH1GcJU8ZY865nHTuKALQ2J4NXv5RpkFc90kN9zcWCn4y2ams/SD45QMzYPHNci+OQM4RtZm2eJUXabOZLa+Uu59qXKThFChWiLkuMGXX5xDrWB2renwLs/smU4SVTEdrJZ8ix07JKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KyluUFwF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KyluUFwF"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c16794450aeso75157766b.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 02:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787736245; x=1788341045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCn0c8on5VhTMPvJMk79IvJUhN4ps8pLKsOfBaE2aTk=;
        b=KyluUFwFXoyN/tfgV/Tz4QF3bTjfmxkyRl/Sq65/7GnZ3UGKkb8obPY8gIl3nDJONZ
         XojL2AXT7C5nwlXXQNlUdbJPjkpz39mH6oX3gmcjSr0KsHQ7MmL1zeUC6YlufOS7IYNn
         CMzQ5/d06NOMJXrOpVeDxQ8M3u+2wGKmg9TFFdKp+F1sHH2lQS3vgXZ5OYz8k6njjY5w
         Yx3KAMNcp5/eVnqIYOKtSVzkm8YkAqnQLNdOpMDnmZRtCQsvyFjcvoyZ1A7Q9kTC+O4B
         rDF5dQF4dHOtEZtT5kiL8eLIYxMe0KTg31wcPJmi4O1cRbJYVXAyWStJ9bEXbsry6Emw
         Z6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787736245; x=1788341045;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jCn0c8on5VhTMPvJMk79IvJUhN4ps8pLKsOfBaE2aTk=;
        b=N/rL40AacCE/9A1tH+s43TCYwlZtHU94B8ehdkeuC96U8BIxpsy2SDOLpyCPoTJTwl
         r80GOwOpd31RHRPb4JfbqSS9TSOMHzp2ONHEbxkpbWAZnHI3g/iqG/jlQUYOFfeOeisE
         80uxNlx48/LjQOUk0fr9CBZ6DdWWtBvIB+vy/CeHbohb4xw3jKj54daBiPCUouThDGvP
         Sns5EgD9hnHENKvEtj34yUS2Hl+oh2m6H5sc7asV5KE6L2XijaIUKaAMmeB3o7Q5fUBx
         lsGuDM/zpVJX3U6zX30LT7brMWMXsOFV5Zy/Y5u64lkEkORaemrjMdYHTnZwLrMZ2Jdy
         wlSw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4L2dC7MfXPx1/PF4N+YTpPxK+OnxSg0kbY9gHxkmY9FgjdsKD7omgm98XVQw0yx8SQ8so0CA=@vger.kernel.org
X-Gm-Message-State: AFuF++l45s6N76CyjVImEbVZG24J8CK2b8MLac04Jc0VuSrMC7CjXDFM
	dXyvCjnG/bjmRdztgtdZoCA/cDHo49vJZUwcw0wfDCj9LJu7vIOa7FzTjxLiS3TOjCc=
X-Gm-Gg: AR+sD10nqX+3icYexEjJFBJHsM6T3HI4qOC3YTWG1M1Vm6qDFqajPZVKUsDJw+erD4v
	lJhSuNdoS8ePBZa6Il/KEvG9v3ylMBzhWpYwZwnBcwVAUvuDtbwK0Djmp/eqElrW9h0yGq3SDQT
	Sbhr7CZy05mmSKnZ37k/TkGGTyatyeAWYpt7aLsjrQUt3SpS7nvnwz6eZI7+qht6sCwLBWDb7f0
	yZjj9NUs0HRjtMV9MqexgcRyt6/IgeYd6kyVgrS2eJHu+rejZhddLcN5A2zAYp4PuE0L6RMXz8X
	hoEdyfQ+mi+T0Z6GgbNInw5UqGHeco2iSb5uZGXpOfVuQA0AG2Oh47USbxNqhXsNZ+FRb53pn1K
	qL0T0Gfug8H5FfiwakthDNm3SS5Liivv9Xru5hdRq1n8FPRmDf9D+qqAzvUyQ8Goge30rv7GdUN
	p3NK5tSy0/8vnf5bgvtAxh3NqAksFDcK+jeofIBmoAOyGTwkd1WYz7JZfhyvubAK0MHMugbqs3Y
	1FHHEX4w1yG5nLfmCRzDH6S
X-Received: by 2002:a17:907:8749:b0:c25:2fb5:e572 with SMTP id a640c23a62f3a-c252fb5efa7mr36929566b.23.1787736244662;
        Wed, 26 Aug 2026 02:24:04 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5dea83a25sm3726306a12.18.2026.08.26.02.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 02:24:04 -0700 (PDT)
Message-ID: <cd6b372d-cc68-445d-bcae-6cfc83d9e4db@suse.com>
Date: Wed, 26 Aug 2026 11:24:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: fix lost error code from codetag_load_module()
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260824014736.35026-1-hao.ge@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260824014736.35026-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 3:47 AM, Hao Ge wrote:
> If codetag_load_module() fails, err is never set and load_module()
> returns 0 after the module has been torn down.
> 
> Fixes: 044d2aee6c57 ("alloc_tag: handle module codetag load errors as module load failures")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  kernel/module/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..afb810f0154c 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3568,7 +3568,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  			goto sysfs_cleanup;
>  	}
>  
> -	if (codetag_load_module(mod))
> +	err = codetag_load_module(mod);
> +	if (err)
>  		goto sysfs_cleanup;
>  
>  	/* Get rid of temporary copy. */

This looks ok to me but there appears another bug related to this code
that would be good to fix at the same time. If the module is
a livepatch, the preceding call to copy_module_elf() allocates
mod->klp_info. However, if codetag_load_module() fails, the code doesn't
free it.

I think we want something like this (not tested):

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad0..c1b34dc1e89a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3581,8 +3581,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
 			goto sysfs_cleanup;
 	}
 
-	if (codetag_load_module(mod))
-		goto sysfs_cleanup;
+	err = codetag_load_module(mod);
+	if (err)
+		goto livepatch_cleanup;
 
 	/* Get rid of temporary copy. */
 	free_copy(info, flags);
@@ -3592,6 +3593,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	return do_init_module(mod);
 
+ livepatch_cleanup:
+	if (is_livepatch_module(mod))
+		free_module_elf(mod);
  sysfs_cleanup:
 	mod_sysfs_teardown(mod);
  coming_cleanup:

-- 
Thanks,
Petr
