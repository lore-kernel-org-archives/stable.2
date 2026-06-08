Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7476145B27
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938175; cv=none; b=utEvbz1wNr5SgrEgZz0OxmgOM0wNymEzIuCioiw0eq3TJnbYoCHR1QMN96yY80maOwz+qcAui4QjWobY6cXvs6BaxyyjJo2gm+phsuabU63AOWixkgCocOSJUzU3PoGNQ5kVRKDMqiTWJ0Kex0QeS0zWrhGzGpqMPchDlAZ03PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938175; c=relaxed/simple;
	bh=TeGUevqJjKKdHILxWcVaQKAnxXmxLmDs6VfY4SGfpoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdjH/3b6YcP0CzS8Bw/zQ89vsyX6lRSj4ExjB4DFSE23/lkYgpr4rssIkHVU+8fLWSFB+yJ70m0bry9S6uky3oERaF4b38/hcDToVTBfLrDlrEitDwC/U+taM2eNRPogsvnQPpIDAcv0RoJGF+DLNDcZs/WiTKBmNK4UyvGwC38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvCB2X5d; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvCB2X5d"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8423f1e2f8eso3486004b3a.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780938172; x=1781542972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IVjaYMlS8AytKKUy6WaMPwOlFtLwcyoaO4rV2Eiq+9U=;
        b=JvCB2X5dTOa3Nvr99o9JynwvR/EvPlMw6DKZ9Uxiu2FOq1yE3p220Oau7WPNhJzyFv
         FyP56qxQatasAXgHeNlh76D7NfkrDz4vSgtrUwbzzXbOsdCp0YehabQwqiV052VO7FXP
         N63a3fTkQj4z3l1FDBrio29wYsNWQLQMJKIM1jJGGzCBqq0yDXrfK41l39juX9EgFD5A
         qqqPiX9Qm+/4Cmm8drUONklQEW3g12KZ/QlB1MltoJcrErB26nTMaNzuP1P/QQdBg2jO
         mtFIxb/qVOv2VlFYNPybchqnjd4G1rcUSOEr5oLsWnGcNhEHo+iAi4f36wTI4lJh7qPb
         t46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780938172; x=1781542972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVjaYMlS8AytKKUy6WaMPwOlFtLwcyoaO4rV2Eiq+9U=;
        b=HZOsUjlx9qZ5tjpwMIg7cgAZvmAJfvGMv7x364QJLWcyK7quOD9BD0L72NadVD5q0I
         QLH/02j7mgbS5YqDUxGRBtPlikKFG1NqrrLrgHwF7K6y39T1sErSG6QmXGDIDMJIDgDs
         jWXRGKkmFcM4C30Zf3kgVJH4/Vm0uRf9GGL2xAvTrarujyvbFzviETXKEiS3epRXzG6b
         Cc0NjunO8jusMHQXKn1KGeoGj1nlg1mx5gXhWo7uMHL5pYFkiEljdo+wn6H4isV2qrHC
         UeWaDInhZ/2/P+GBv/AKVMsNLd6IAKvse1gT6Xt75F6m+el7oX0LN8jLt9Uh9baBmPmG
         UIeA==
X-Forwarded-Encrypted: i=1; AFNElJ+xYQMq3pHU779dKnHyKmjT6N2brNmVFo2CTeFusL136GcP9Zvxliuia6RoABWtH2pAYlycH70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCzPeAXhjGqiOi4KWtMONSpobCM0Syha1PDYyREpd8r/xHVING
	O64/Ybln9I0XyBplbfMrmxnhYJnHzM0k0Bp6SnTrh6WFIxzUr/pZe6L3
X-Gm-Gg: Acq92OGrvNCaVIQyY2yLXmknpbNm3scw7RXF2LtJXmm2xkYl26Zi9EpBntmZ6oFrl60
	CeTAYAbwKweW/mj8dEGhvak5Y1wMNjGWiYGj+dDVVDn5So6Mx3hIcoYmNfThElMP/evowPlOAmT
	TdDWzm9tn+tQj9w1LQjo1z9wa+elM6UKmlhNjqV9iQbjVj+EgqwpfHky2sUPqcCxW0W6RqiO1vH
	aOsEyOCPCn5Y+kIK0WiNjM176fSOyY2h4ozXm+6+rjmL+OgYYr9QBfR3KivZtaamiWU65PK42+2
	at8Pe4WVn4pxFsfZIsi7VnfP/JD1JLIOHKTiODUztLJz6qF+PLYiNBx20T6GT/EN0ny/d8QLmdl
	zUbhPAto5fej8RyTSX+xf25DIHqmiBvBJTmmmbCva1ABSmt7IK6WhKyszF4hzV4ogbgXied0Jsf
	gMHmMAPzrGLp9E96u5cVigdHAZAaZNlfh2QpuT
X-Received: by 2002:a05:6a00:94d8:b0:832:e65:ddcd with SMTP id d2e1a72fcca58-842b0f4278cmr16028206b3a.45.1780938172116;
        Mon, 08 Jun 2026 10:02:52 -0700 (PDT)
Received: from google.com ([2402:7500:498:d80a:6ed1:11c1:50ff:fc30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842820e8e6asm18289053b3a.0.2026.06.08.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:02:51 -0700 (PDT)
Date: Tue, 9 Jun 2026 01:02:47 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org
Cc: gregkh@linuxfoundation.org, marscheng@google.com, wllee@google.com,
	aarontian@google.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] interconnect: Fix use after free in icc_get() and
 of_icc_get_by_index()
Message-ID: <aib1t4SWw0aiJyv2@google.com>
References: <20260416190840.1753468-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416190840.1753468-1-visitorckw@gmail.com>

Hi Georgi,

On Thu, Apr 16, 2026 at 07:08:40PM +0000, Kuan-Wei Chiu wrote:
> In of_icc_get_by_index() and icc_get(), if the dynamic allocation for
> path->name fails via kasprintf(), the error handling path directly
> calls kfree(path) to free the path object and returns an error.
> 
> However, prior to this point, path_find() calls path_init(), which
> already links the path's requests into the req_list of the respective
> interconnect nodes via hlist_add_head(). Directly invoking kfree(path)
> leaves dangling pointers in the hlist. A subsequent call to icc_get()
> or icc_set_bw() will traverse or modify these corrupted lists, triggering
> a slab use afterfree.
> 
> KASAN report showing the vulnerability when reproducing via debugfs:
> 
>   BUG: KASAN: slab-use-after-free in path_find+0x6f8/0xcfc
>   Write of size 8 at addr fff000000d43f748 by task sh/1
>   ...
>   Call trace:
>    kasan_report+0xac/0xfc
>    path_find+0x6f8/0xcfc
>    icc_get+0x148/0x380
>    icc_get_set+0xf8/0x2d0
>   ...
>   Freed by task 1:
>    kfree+0x1a0/0x4a4
>    icc_get+0x2cc/0x380
>    icc_get_set+0xf8/0x2d0
> 
> Fix this by replacing kfree(path) with the proper teardown function,
> icc_put(path), which safely removes the requests from the req_list using
> hlist_del() and drops the provider usage references before freeing the
> memory.
> 
> Additionally, in icc_get(), ensure that the icc_lock mutex is released
> prior to calling icc_put(path) to avoid a deadlock, as icc_put()
> internally acquires the same lock.
> 
> Fixes: 3791163602f7 ("interconnect: Handle memory allocation errors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

I haven't seen this patch show up in linux-next yet.
Since the merge window is approaching, I was wondering if you had any
comments on this?

Regards,
Kuan-Wei

> ---
> I discovered this bug while reviewing Krzysztof's patch [1]. 
> To verify my hypothesis, I injected an artificial kasprintf() failure
> into  the source code and wrote a minimal dummy icc provider module.
> This allowed  me to successfully trigger the use after free via the
> debugfs client and catch it with KASAN, confirming the issue.
> 
> [1]: https://lore.kernel.org/lkml/20260416130912.375013-2-krzysztof.kozlowski@oss.qualcomm.com/
> 
>  drivers/interconnect/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 8569b78a1851..e14280ced381 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -528,7 +528,7 @@ struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
>  	path->name = kasprintf(GFP_KERNEL, "%s-%s",
>  			       src_data->node->name, dst_data->node->name);
>  	if (!path->name) {
> -		kfree(path);
> +		icc_put(path);
>  		path = ERR_PTR(-ENOMEM);
>  	}
>  
> @@ -626,8 +626,9 @@ struct icc_path *icc_get(struct device *dev, const char *src, const char *dst)
>  
>  	path->name = kasprintf(GFP_KERNEL, "%s-%s", src_node->name, dst_node->name);
>  	if (!path->name) {
> -		kfree(path);
> -		path = ERR_PTR(-ENOMEM);
> +		mutex_unlock(&icc_lock);
> +		icc_put(path);
> +		return ERR_PTR(-ENOMEM);
>  	}
>  out:
>  	mutex_unlock(&icc_lock);
> -- 
> 2.54.0.rc1.555.g9c883467ad-goog
> 
