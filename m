Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0764395AE6
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073849; cv=none; b=Dko2p0doG+5Cf+DyjNrHjt+UbQqCqMU1IKEgdgugNDBZPswI9iDgJsCAy72Qf/ZZNCqt1Dl7GTVpCdBimFe+Rg2ffwtj8d2xg4spDoSgW9cOMCmW3HxBS917XNXU3ut/RhVbZLOkSP0k6UIT9tLCHbPbypLpRjYoHU7UOjyPJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073849; c=relaxed/simple;
	bh=jtexLRd0LMEvWjSqgopV5i9TmNSBRk6qk2dv0E078/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nK4u9H7fNDTw9LQJ0d1hxnhpes+tvt2pGE1rHWnPd7nMp7sV7+Lq+cH8hCKuwJ001eMOn1KBhCVHYyxY+yYQlfxHXUagEhrmQc8VO4SfJzbVpTGyKLPbM/bg49WO6G+itNIMhzJ6updyQLSMn4Jzd3vaJVahNdafo2wZa97BB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgNfjCxw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgNfjCxw"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e04df8c46so3270147b3a.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 20:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786073845; x=1786678645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q+fTOtPno7yWUV/SDfx7o6rMybrKsJN3GZDuyA1kW44=;
        b=lgNfjCxwz6BA6r8khcLhKKnd+YOUSYJDMOaGG+0DFZezRR/VhjhtmuE7M6TngxKiBP
         /roAPCFWT0lKzKE19iQKeT3ZYGOzdUoZdFxrlUmguLy1j5kdCus3LWtUUOTyTBDMU1Tu
         ciKqoy+DV27jOqroCdVsIQVWK3EWo5+fHMDbMxfxiAkv+n8sXGFsB/1kawNe+vH4O1nN
         mG7tahrV68GChoNF7ahiupLXxo4ZhaChArJr7VldS3AA5yysqWVtwU7YAhKIqK3QzQ2L
         rqq7vVBsYcIuesXUJrprgSmxwn6ZV+kw2Xd68dJ4WPUegQgiLHg+saFuuf1h491qV100
         KAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786073845; x=1786678645;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+fTOtPno7yWUV/SDfx7o6rMybrKsJN3GZDuyA1kW44=;
        b=e0f62pNr6K0rCxLO4Sf1Niw0G6NuJkQe0Wp5RVcC2Kw2uDqUd1ZZH5wzaGyqHgnEHy
         lrANGMojRIz5fDdbuYjciJY8xjWZiX/mq/0MsCR7taW4lOt6wm1pnWzDKYOcS/naIP/a
         +P7dxJYR7m7oTsnObmweylRKzJZ1bAHKlYjK8oWN1BzHI/dJJS+I8bKJLmUwaCUgATFj
         7uUo0NZZdea21zt2f+nSTaS8zCqLC4nsbCavAkGqfHnZlqfPvada72uc8tXlTh8voKvM
         6bOO8y6yNhYUGn0juq2/K2f5llA5vynpdibCt0O56MXB7ghQBaQuYSIaCj9zQEglYaf5
         kHCg==
X-Forwarded-Encrypted: i=1; AHgh+RrWrU5mW69ybvZ3LhE7HQz5cTsg/R5mNUbY9afhNi7hXwm1zhhJoE2ZDpCPfPNiScwgKtF097E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2EVzs/ubGeFivkvlBVOiC6QfyJygYVIgPyDmj5UcIY3bbljE4
	ru4QNrK/Rfe9OH1OYTOMUe1Sh4Cl7V3q7e4QG+bm+RgFy2fqAROFjlYC
X-Gm-Gg: AR+sD13NkfgMo3/00uQYOQOE02BdWAE5eNQTGqMZvsSj7Sd29IUqBnjQ36wwhjDi8rs
	LzQuDTXpjnlGy2im4SMQRg/ZJBdorBpnoK64fcX4+39s/k2oTaoD2kMBkHKKS9i5w4RVBnSwgq3
	d5bOYgqNqrK9S5mk7ah0OTupyB8UE1GP+ahxXHiVTRkWj7ENS16dtsmk7J7kfLU7G3HAvHKSymc
	XAObmjdOyfQiI26g36gGjDydDyYXZM2rHcxJwkXuK8URrF32vgQ+GjDmLWPOUoUKB1iIKY7tRlP
	Qti+CQfP2QC2Ld25w/P8FXD/Jmy9Xf5DA7Hy76hcVn+u42ieyNZxNvm2xhPQMhmQkjicpJAXe57
	CIrq1g+rP0qWyNOzKYXfxwmYG/uPX7xW4zUpN4GeJEMyzjNW+oTPJq1Whi+a2Ir03bC0GqVkOzr
	5Np6IcBwFyKSerxrZcPyU6YlScqAvbP3sX19w/ugo8hW4j3PHh8GUoyg7y8sZWLDn7XmNhDyxwx
	eE/NuaCbHdh2CBs8bM1
X-Received: by 2002:a05:6a00:1895:b0:842:6004:3fda with SMTP id d2e1a72fcca58-84f5e0685a6mr685783b3a.25.1786073844634;
        Thu, 06 Aug 2026 20:37:24 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3cade6sm285307b3a.21.2026.08.06.20.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 20:37:24 -0700 (PDT)
Message-ID: <c8c6f8ea-3aba-4dbb-ab16-4f696441033c@gmail.com>
Date: Fri, 7 Aug 2026 11:37:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: cls_api: fix tp_created race losing
 existing tcf_proto
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, corvus@tencent.com, henrymei@tencent.com,
 stable@vger.kernel.org
References: <20260805093012.95155-1-henrymei@tencent.com>
 <CAM0EoMmZGXhHL2v=AyjR9xSs8-s9EfkA9FkpULqtFBEOUxHQQA@mail.gmail.com>
 <aabdf499-20ad-4667-b289-626c09a56c0a@gmail.com>
 <CAM0EoMmM-7cphQGmfZa+H3p5HjQ71gJ=8J6-HhhRwzAv--74AA@mail.gmail.com>
From: Lin Jiapeng <ljp1205831794@gmail.com>
In-Reply-To: <CAM0EoMmM-7cphQGmfZa+H3p5HjQ71gJ=8J6-HhhRwzAv--74AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/7 02:38, Jamal Hadi Salim 写道:
> Thanks. Please respond to that patch and add a tested-by tag
> 
>> BTW, "TencentOS Corvus AI" found this bug; and the patch was mannualy
> 
> Also add a reported-by tag to the patch response
> 
>> written and validated, so no `assisted-by` tag here. Noted for future
>> submissions.
> 
> It does look like there was some human touch to it (other than the
> verbose comment) - and is a reasonable patch except you missed one
> spot.
> I am wondering how you tested it. We had to craft printks to see the issue.
> 
> I was kind of suprised how quickly you found the issue. Victor had
> something already based on what Sashiko said but i said to wait until
> the first patch made it in.
> Does Corvus AI watch what Sashiko comments on?
> 
> cheers,
> jamal
Thanks for the review! Glad to share our testing approach.

For this bug we placed kprobes on tcf_chain_tp_delete_empty, 
tcf_proto_destroy and the classifiers' change() callbacks, capturing the 
tp pointer arguments ($argN) and return values. Matching tp pointers 
across the traced PIDs shows the losing thread calling delete_empty on a 
tp owned by the other racing thread — right after destroying its own 
tp_new, which is exactly the signature of tp_created not being reset. On 
an unpatched kernel we observed 927 such wrongful deletions in 3000 
rounds; with this patch applied, zero, and normal filter 
creation/deletion is unaffected.

As for how we found it so quickly: Corvus AI continuously explores bugs 
and security issues in the Linux kernel and generates reports. Each 
report ships with a PoC and a QEMU-based reproduction procedure, 
covering both static audit and dynamic verification; a human then 
reviews the report and reproduces the result before we post and patch 
the bugs.

cheers,
Aohan Mei
