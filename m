Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016495;
	b=IOByD6or/SNPrVBznYMktpCkhu8fwwK2kk5AV6zwHsnBG4Pwmjgxs85v1maDlM0HVx/T
	 hknGG/w7r0ZQKVEF7PUSVbiXeccEEeqDRGtsEs8UBsQOQCFD+xEu9T/Q/u6Uk7ZSem6Zv
	 GNraAPVx+9xp5RvxzLixcfQCNlRnZOaYIkEt7VSpJBEpRfz+AGvfls9zwYegcm+YxK4Pj
	 SADt4T3xc0FhMC18Uqh9PqcgGUmPyhrkKAWBTvTTvk1nRsG6yIOEiyYFLKlMte4IMKjHU
	 MnXhDczJFeCFibiQG+TZLCAiPa7OmFTyhlfqI2gB6Nw8HfGJHFHBOiKY26y2ODa2VMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cD/07tCbP0c2PveFePONvl73YWhDWOPfUwb001eQKwE=;
	b=tkoY9rpAZ7+kkadw7ceQr/lszJxmMuhsFFq9Me1fJUYUiq1E1e0wWw+j7K9+pVQNo5Kp
	 Qvva4dEH6mmPXT5omhx+MgHAHd0TR+5szFzOBvgi+lqn1jVuz2AzX0vKUpzOHVODtxSJJ
	 5AzRhRB/+5NkxZjvKT/u1JFPFYfs66XKSVXfWTj6Hkrq4o4qiQolpJmrm1W+TW10QAGc7
	 RG2fhgGnqO+SXw4OTLfZrB4kwviAJyO8ijJNwqqK6B2umSd/qI9t0HWVEp8l7H7+oTYx2
	 ofouHzIP/bGWhi80ZcBacB67ylelrRzahOHG4qov6QPkxp6eIsSMA0plZoAG2/65uhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xh4RhHqr;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC18606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DC18606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xh4RhHqr
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b894a5ce3dso1262865a12.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795016494; x=1795621294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cD/07tCbP0c2PveFePONvl73YWhDWOPfUwb001eQKwE=;
        b=Xh4RhHqrHc3yc56+v81B6EtxtJ0ODDySLnhAH6Bcyo+2KI4tb4m0sow/x8cyaDqfJO
         8Q+GA32xhbsvG9hVZ54LsAdBS8FFPPokzwLwGrQKCbwVfwV2vmeKVJ3C/5b8PX71niNC
         WgAHlQxGht204JVx93ADZwzNuyhN1HX2gaOxQjuZBijmqfBBjB/y8GerqI7D9v4uBTHt
         TWnxI7Rvl1PkKhiKF+n1daFsNkmMPYiqIX0/orF6Lxw7IgqtJnpp0OYKfEgvJJCyBWmE
         e9VhAkiD5Uw+s2MVjs4DGBkwBAJh4QgIIu65X56e50h5v1v8WE/rzC95z0A1Ph6CFlrv
         nhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795016494; x=1795621294;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cD/07tCbP0c2PveFePONvl73YWhDWOPfUwb001eQKwE=;
        b=kv4YC2Fg1s23fg4A1uHX5zcysdcI8hOonXBjhMWrh90QvWeI+u62xXyNAA5l++c6sz
         3VFEIeX19GcTqG0BH5CG06StzL1UscUkkLSj7jJ311Mi4hnt8b+hm2jalrR54V8jqM+1
         BYQPPhywJ0YpXMP5fGh3JcYNAjqEfjVyZBHbOiclENdL2wlDZqkWnk0H3p84lHK72Dcr
         PcequG3IbWpx8HehXD8Bg8QTe0mGs9x1GXym5mkA3uVSoWilTWP1NEkr8i+CZ/aUl8s+
         tN+3INiLI4ykzw3/cvxVMOxWvTt6C92kuYXBSmjdEi2kL+LvdLpP9m5cTkEi9MrrvYtD
         2LEQ==
X-Forwarded-Encrypted: i=1; AL+hErE2xSrmMkgmVY0rHTna1qEGf4QiXxhGnmCqaepjcu4K24aZIKwe6RB+dpeTmBdKUGCimps0l3I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KoWpH8l6robI6a+qi5J6qL6pwllmjOrpdeY3Ip44vnUqOnSso
	yCJefcpMYT18/AmAK6Ll+mh6XObyqmXjFYT1UCuI6ziKTm+CthJegDhR
X-Gm-Gg: AYBFou3dI/IWj2a53s+gmqK5Zc88SH7qXz9ufaWuJ5ZpgFCdoBMnGFG/m2j7VWcIq0V
	Qf74YYzNdhEqlaXtfiYzwOndK6CeTWux6jfM/3sZa/C71+zFwLiWAYK3i7q843gOyzzgaj0eu2G
	HRTrysdlB1iyN0ZSl79sBKG1iLTfFAm18vPX44SF0owoiZbUBjRfKyOBJPyYo2/tefqNlaofceB
	RZv6hBMNgcZmmEP5gCUDM/mvKrkm6mJmGUIR7fsCW2FVooXsAwLV/mcx1Vj0JChdMW1GwEv96VL
	4UUlt5L1+8n5lsB4app0M4Y5qbIDRPhHKBgqNNvf9Ukv9sYsA1Jc2WycqVN9+tK+bLRF8zvf8nK
	mhsn2k4a6zCM1C9/LlXEF0/OHhotOYE9EmKpYjJzBz/IK6CrmKH1uikCSBTfRSkOQWTT9Rwz8op
	VUF6sXRR279Z3xBmEMb/xOha7iBM4Xxym+lV/t96EUHdVV8tUHRzCYsNtU43We5AIzpF9l60xvH
	q3RBj0bajhimWMQO4BT60iGtyKYQF3cCajchHviEuiCzN4cqYjHSR0dxWpDhxNbE6LWWUfuAAcW
	2pNvtW3podyHeGwekNSQ/hhs//ZgObWbxxraV2jp8HcHuv1Jiw==
X-Received: by 2002:aa7:d0d1:0:b0:6b5:8cd9:fc1b with SMTP id 4fb4d7f45d1cf-6b887f0e5fcmr1777268a12.23.1795016493632;
        Wed, 18 Nov 2026 07:41:33 -0800 (PST)
Received: from rigel (106-68-220-184.tpgi.com.au. [106.68.220.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a0021d0sm1192372a12.22.2026.11.18.07.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:41:31 -0800 (PST)
Date: Wed, 18 Nov 2026 23:41:21 +0800
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
Subject: Re: [PATCH v6 5/8] gpiolib: cdev: don't leak the IRQ name when the
 chip is removed
Message-ID: <20261118154121.GC46152@rigel>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
 <20261116-gpiolib-chip-removal-v6-5-aambrozewicz@nvidia.com>
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
In-Reply-To: <20261116-gpiolib-chip-removal-v6-5-aambrozewicz@nvidia.com>

On Mon, Nov 16, 2026 at 03:47:08PM +0200, Adrian Ambrozewicz wrote:
> The character device requests line IRQs with a copy of the consumer
> label as the name, and frees the name that free_irq() returns. When
> gpiochip_remove() frees the IRQ first, it drops that name and the copy
> leaks:
> 
>   unreferenced object (size 8):
>     comm "gpio-hold"
>     backtrace (crc dc8eac94):
>       kstrdup
>       kstrdup_and_replace
>       edge_detector_setup
>       linereq_create
>       gpio_ioctl
> 
> Keep the name with the line or v1 line event, and free it there,
> whoever freed the IRQ.
> 
> Reproduced with gpio-sim: remove the chip under an open request with
> edge detection and a consumer label. kmemleak reports up to 23 such
> objects after 30 cycles; with this change, none after 100.
> 

Reviewed-by: Kent Gibson <warthog618@gmail.com>

Cheers,
Kent.
