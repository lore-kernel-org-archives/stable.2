Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529104;
	b=gyaYuS1prPY3rqSYx+apxSySbqYB106XSJ0MfP8nyCVMW6kq80NJY3HKs/8iDuLI9q3h
	 o/K65RNwMIw9+VPz+22p7DG/4AmWGOzsM8y3HwiNoNjbcXtlliUNUx27LiFlg6CAxGtS4
	 vRAEShcMIrvkXNj9YH4QxcVxwLlQW6Of5dOPmb+5v3wsDbs43LC9ZI4ucqh/gfIrLjWbj
	 hQG0Kij5fu2pf2JpOimSp9Kp9HGfcQ0GFQ8ACLgWv1g1PArn9TKWeIDF/YUqpyetX3G+/
	 Gkj1Lzy6DYBvnu76Q96SY8HKwRhhh8CRjo5qgzM+NMUEETWm7OYF5Xk1a7QUbNvO6tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qRxeIQVtFm0RG+YlFLd95lVJGB8ZwXlO3/rFlUGzh8s=;
	b=mw8IBfLQxwL1aFaCBI5btTe9LZeeSoIlodyF1e+3e+BrLi6X7N7OLIHlN4jXTInliKh5
	 x8rKyDtmM0y33NyIx7fd+89h7pdSeYkC+W1wd4QpHCjid8esqLMC972QBwD4ziSkw04MN
	 zYwckm8tLyHYMCZUThszGy5ijEvlDofu7qE2ngNegvJbV91IX6/5p4c58+Z6GErefM6nI
	 Q65V66HggH4cdyA2VzijfBzFV/ecGfY54ynu9RHstAFchmQdHhTWyU07PdCseu15N1f0B
	 MAo9tMCI9NORLjHIObbEuDnuQgwHE4A89lY4dPfKaFsmji0VuYN0xTRHdQot1pUoUaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bR+JMWeh;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3960784A3
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81F3960784A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bR+JMWeh
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8c5ebbc5150so3134951b3a.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 06:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795529104; x=1796133904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qRxeIQVtFm0RG+YlFLd95lVJGB8ZwXlO3/rFlUGzh8s=;
        b=bR+JMWehXBgbqMLi3u84uQem+5jCS5iotKKbd3Wxb5MsH2wa8wEzAKNE1e7xM2nBBd
         jquKKBrCNUJbeljTCMi+KOyIJDCZjUEehUY7ZchGMU99GQLtUxnOtSmquyRWtOLj8ko6
         FTWyXSamVK0ufrEu0gN9QmAM2EsyaSQ3iOvFmr+nk5/89V0L7DLjzkml4hf+Q8QwmBY+
         uCsh4REXWU2ZYu8S+bFimhZ9WUSS6gzxhUyZAv6upKZ9RGj/+fCS77gjrlIr/HMacxHY
         eM0LnkUCEhsSkXm25xPTlsB/qDQvir7gO6PO6Hz9IOzp6e84qtnBhgcI8smO3HrmcKkR
         HybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529104; x=1796133904;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRxeIQVtFm0RG+YlFLd95lVJGB8ZwXlO3/rFlUGzh8s=;
        b=KNRWMa5oupoNIbFJSkeYgQ53Q7EHKLEZaTQaaVMDkCeULzPF/qlbXTF3YTTbaDp+Oe
         qmUlly3f/Y5YU7PDbkNPcbDx7rGBiwHLD0u4ZJaudALuDCv1kqTKaO+JwbbqfGWcWkC8
         iIyjSYzlWk/5SOqY0JEUQ9v7BGopzIaUibXr5Rf4qL7h+J9VaYf+9o3iBje8kZKE6YE1
         fSDY9GRO/SOtCJPOrXsCNWaExvSpGm6WQYNFqnWIaqqtxpomYrcQmBBy+F1e4yIMRkxt
         oj8Yq8FLs2Ktn/7Hiy2crjHb9v3Yh2ZuvFgHyCDCBxs/NuGgQMGxgtf0l1QhlYpFM+dJ
         Q8+w==
X-Forwarded-Encrypted: i=1; AL+hErHD0xGxga+qPOcRKHo0Cea/i7SXhACsYWATUBYLscJDL6L3DcR/3hZn0+5j7RK24igvjsirPW4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RJ+ZS/moF1cbzeT8m3JIoLsBTMwk7SAc425/h9AXkNK6YDaau
	5B4P/0rXWS+iJ1P4yuqwhiuUfhxZ0cZ1ER3KfLT+Y0xiDGDOWBVqx4H5
X-Gm-Gg: AZFdTZexMuxwuDK/BaFxMUH613mxhlnFt0j46eI4qL6CFZVRYYopCw7drTaRBwpOk7b
	hACjuzHl+skHwtSj0EnZ9MZWKl3dSZ6R1medC2bet9EZZKu/eVulJHASNMoSIlYpXCfWXHaE/Ty
	AASOeXlep/xxAkKpSQ60IyTdV7zS+j+jzZNjP2TxIwHO7Yy//chbMwJS9YpPnugAZY6k6Aez8Pa
	HcAQ/jYjSVqseXWLIaqY+aVJMLa9UFGPMEpTNvCpqRfxSl1coDok4fjbAoCtD8dfSEQCk9HLoWG
	cgP/J0G4qxOA/fBCw9+LiBjjnfzJyHWdGapkg0DsyaB5gV3CUlRgmydbM4RW6xL+2NCTfQptEwN
	BzHzD46GmT0uKqm/gY/lLtp3O0Vs92RXkgUaWHX1uc4Cr1160DhcjM7WHVFnxrjmkCdZUxU00Ih
	kALuVYVDLCJ5795m8skPr7VlP9Zh/mDMfR5ILyHzwrHi83zZ58PkHRkvp1j4hkCgCENLhhNtCxa
	iPyKOcBMzMqWFo5YxSfoSyR8IOAm2LO3Ee3ty1CdCSbcoKsOUdc9oMprO624DC+skbP++G2dwOB
	2i/4Kwev+sQy1GuHQd5RmAd/Lo4JpUG99G4fUo0NFJPtFaYR
X-Received: by 2002:a05:6a21:778b:b0:3eb:8ae3:e1a8 with SMTP id adf61e73a8af0-4014ee5082dmr13456271637.72.1795529103728;
        Tue, 24 Nov 2026 06:05:03 -0800 (PST)
Received: from rigel (106-68-220-184.tpgi.com.au. [106.68.220.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077bff6sm7287946b3a.3.2026.11.24.06.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:05:03 -0800 (PST)
Date: Tue, 24 Nov 2026 22:04:55 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v8 7/8] gpiolib: let the character device free its IRQs
 first on chip removal
Message-ID: <20261124140455.GA48187@rigel>
References: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
 <20261124-gpiolib-chip-removal-v8-7-aambrozewicz@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124-gpiolib-chip-removal-v8-7-aambrozewicz@nvidia.com>

On Tue, Nov 24, 2026 at 11:20:38AM +0200, Adrian Ambrozewicz wrote:
> gpiochip_remove() force-frees the remaining IRQs, removes the irqchip,
> and only then calls the notifier on which the character device frees
> its IRQs. It may then free an IRQ it no longer owns, after its mapping
> was disposed of and the number reused, or from a release racing
> gpiod_free_irqs() and gpiochip_irqchip_remove(). free_irq() then warns
> "Trying to free already-free IRQ" or uses a disposed descriptor.
> 
> Herve Codina first proposed calling the notifier earlier [1]. Call it
> after the chip pointer is cleared and SRCU synchronized, when no ioctl
> can request IRQs, then free the rest. The release paths now free their
> IRQs before unregistering, under the lock the callback takes
> (config_mutex, or a new mutex for v1 line events). Initialise
> config_mutex on allocation: linereq_free() takes it, also on
> linereq_create()'s error returns.
> 
> IRQs left requested by in-kernel users are now freed after the chip
> pointer is cleared, when gpiod_*() calls fail.
> 
> Reproduced with a test chip on the hierarchical irqchip: both races
> warned in 30 of 30 cycles; with this change, none.
> 
> This patch depends on patches 3 and 5 of this series.
> 

Reviewed-by: Kent Gibson <warthog618@gmail.com>

Cheers,
Kent.
