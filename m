Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D2423A79
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413958; cv=none; b=Ozj1J+SZPHoWnp0DkZ0a5JCF+QiUD+Dfpz/n48p6OjmZR81BOsNhTofmMJgsygbgdzOBJ2sHofeCZxzJxjE6lRXZBnwl5HbHoRHcL6OcueISE/s3jVBXQRTj50dtC1BCNSQhNpFEBOjoAnnQfoculMpfHZstU7FAkzYVh/6/juc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413958; c=relaxed/simple;
	bh=ChwpBgvydSRCyl30CYsOXGRWljoGGY9h81QLREQDLPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw2et1Bk2ksahCNLOiRmbEDLnJOyQg3PMmlOYB3iSYvM8/DVWdrgEpgqVj/VdvPj2k7Vh7mkzQYawXC8RasQFZfHDLLL6TqIAdaAOI2yDhpY0dvVgymc/R0N8b5O5eVfWERaFS5lqWUzuDEtsXgqlLX0jRYq8OHwC4oZolf2egI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=f6V3VpJq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="f6V3VpJq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954df200ddso12443865e9.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1785413954; x=1786018754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aGfVWtxrVG8Gs+fqhc2m5PVIKlSxiEIBozWBl1vrMD4=;
        b=f6V3VpJq0HGmnMSl04/RHdEnlAxgcPgjXxluE/FnFhlJR+RX+juRF/IubAyb27buJH
         sgmoGZyPhzCr285CYwPrnYs1eLutvIHxfBQEnkn0OdVLR+psUXBt7Ul62AaJCIa/SgfY
         N9Ul7Q8BjOKVbFJMnYYo5/qcZ5xH1Hcb75oskLa23tvzvLFVhUT6WYlhlV+5o8BdbA7J
         pUHKp/ZbL3MD1MpY3MAmyCnIdGB+bA7O3BWdaDo4+DMPOVybo0KPBOZg3CQ0zpRLLxUy
         i5Raw3SVZZw0tKnITWTkNxIUiTiyWQlwJoVMwB0jFxRnGroI40xV/0JG/yUAfXQxvlxi
         f8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785413954; x=1786018754;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aGfVWtxrVG8Gs+fqhc2m5PVIKlSxiEIBozWBl1vrMD4=;
        b=NngvQV0eM0xocaB6B4B77puSI0xuJnhx5Mqk/fH6iglqDYQNoAN+c/fuvyiT8i+8Qj
         TYY/+K8TNdHhE4hT6Y9rXSpNw4s6V3nz4LdZ1f5EcFPfinCbJJNsxl10/h0FzOEsYzEK
         7jlfMgoDnABZVdMjzuCXRUAVj/sh2EzG91Iu3ZSNFTUElF3TxTjppQY3l9fB3+tLc8WB
         SUgbWRQPB6H4mu/oYun4ekbj2w2TFyZHQZv+A8GEKpx5pv2uewZJpZnuC6hsVjXQHLyg
         2SeJZc4Qgy0589OUH4aDuDCC3ivmhCXuby5ov0kt+pFSnGNSdU7HQPFo35q/zNP4l7PG
         jWTA==
X-Forwarded-Encrypted: i=1; AHgh+Roc4tGlwzThLxL4PJFpLQTNeNdIYmIc3GNnceWDrw35zzJylT28Cuasw9Ai4mL5NsEOkLb5QRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypAOhNVH3QPwL4V8eh5UGkQrviHdK0fNINm45HY9TEA1uzFZmI
	QcqcxK4KBZW2uyDHlBMhN2IGPDch9bHez4pnIaCASuA7ohq6jPyxnGnoaDmX0aKer3E=
X-Gm-Gg: AR+sD12b7Xbz8N11jWF4fArvgq7LTnxWLZSTrJIacDWPPX6lNxZwdK3LOsZ42Zp7Fat
	Vws5RKO0WIeDMDnj1Qfmu8x71dA6l9lmT38niwkyfEbN8GXvhf85xGlLUsubRr/lA4Pqsik2xv5
	QH8E3VKxvwLzEuAQTNcHocLYpwa9tvEwvY/2XesZUF5DZkbSYf7Hmdn4traxnX1mb9+NjwLVWvm
	uo4EdEPVtvpB5wIonLHgRCBwzf3hYkVd9AJCwzdYnxGZXtP2LIFT3K2VVFDjP5J3GckryD9Ghv8
	x95H5YWAuO/6JliIC8JlmTxgUPZDqw+pRyaPJ+s7aJit5Yd1Mx4C3ww+/6YKUcz/DdvcaeAyEMh
	h1kYgt36Yf2nJg9Z/wzBLfLdzla8LWWDPJ0StKF2TG8F3MSUEnixgWUFbMfO1yrbTEcocF7AEHm
	H/dUf5UbnRIKULgY71YHSrLRqHJc4EnJ00hPPtghl1DXf0kBo=
X-Received: by 2002:a05:600c:e548:20b0:495:6022:5a14 with SMTP id 5b1f17b1804b1-49800eb98b3mr22025465e9.34.1785413953494;
        Thu, 30 Jul 2026 05:19:13 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:ebe::178:11c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498010aae15sm58243785e9.13.2026.07.30.05.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:19:12 -0700 (PDT)
Date: Thu, 30 Jul 2026 13:19:11 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH] rcu-tasks: Defer IRQ-disabled callback enqueue to
 irq_work
Message-ID: <amtBE9JlGBPwsIuU@matt-Precision-5490>
References: <20260713101245.3207634-1-matt@readmodwrite.com>
 <amiGJWJ-tzUMYizu@matt-Precision-5490>
 <6f002779-3607-47d8-af61-a74eeb987e6a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f002779-3607-47d8-af61-a74eeb987e6a@paulmck-laptop>

On Tue, Jul 28, 2026 at 11:44:04AM -0700, Paul E. McKenney wrote:
> 
> Apologies for the delay!!!
 
No worries :)

> Alternatively, please do feel free to hold off until we get the public
> posting of the call_rcu() and call_srcu() deferral patch series.
> It will likely provide a helper function that you can use.  To your
> credit, your initial definition of the irqsoff local variable within
> call_rcu_tasks_generic() is what we seem to be settling on.  It should
> also clarify what needs to happen when a CPU goes offline with deferred
> callbacks.

Sure, I saw the patch series and will piggyback on top of it.

Thanks,
Matt
