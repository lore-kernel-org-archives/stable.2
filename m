Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368014;
	b=Hz2269pstFAqXFI7UBrV7QMiOHuFzm3G9Rre6WYe9xnS1jN06YI5DHBxNNX+M3hEZeQ6
	 HKVi++gK+pArDAEIHXEGY+U7k2anFjRTP+URY71/NumYHycR6Z1FXNUr/fBh4cJ7nwCuZ
	 oWBnYp/j8RlTFdl/invxk6piWOJ3y0h9NNuyve9cXlEGU2EkXupatu4aJISLMec03V76C
	 SjukeD7m2b3P3LDwqdAUYWb59TKyzseSOFqmJQy8lYbu7Jnt0oaoBqBvfWQP2xGVLCEmc
	 Qz00G3dVyq0a6RoWqUKSi/m5ptGXRGSdYlEO4hkk7Br8H91HvfbeWBn0fZ8+9JHPEbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jpSzV26D6Rjz/NJkyTxMWgMImq37uaP+9bbwc82yg1k=;
	b=WX2BEsroHJ6jn9J2+4p/nX2YzX+7g/4/kgkQXfiAikJ0YBhfjRXfgZxcuh9RSD3mWHBn
	 zfkvkztdR0HaoYvFvvIReRIcX45HZgXl3H588jcaj5r0KCYhk+UgiyevNbENNLXW69MTC
	 yZTIvcGnjHfvNaR339U+XCpTk8ntT/zhr8FznyNv2m7VNQxxohI4CkQKwSejv72AaAkKl
	 V/gMwr6wKSFFGOXO+H9yvyR51VQu8HAVCWLXBUo3kxuUPEed6mSbpn1to4NlrZmQoyDb/
	 u+7abvvuMMjnYK17uIAPqsNc8mTEFhyOvNu5xSQP+BGYXeSuKFWrOt95q+7LEurktKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tEMVM9yt;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB67606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 13:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BB67606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tEMVM9yt
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso428594a12.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368013; x=1793972813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jpSzV26D6Rjz/NJkyTxMWgMImq37uaP+9bbwc82yg1k=;
        b=tEMVM9ytv4rWMJK8XQ+62+lBj1mX8zgGbbJCTo/Jk65iCKRvUVZnxa5aTEBTP6vDjW
         N2FpYrTBUV5Kg/wCqrS6mBJ1EL35JYfAToBL9Ipo/38Sve8mWYXWd8v2180GOzoRZDmf
         JVwsUF4OXmYd752CdtLReIlE4YOexd6EfptJSBQjg//ILWR7agYdbUQLskQAIslDRwcE
         RwWt3uJOG/rjlh4zAjAOFHLFk5FRVmRa5Y1rNX9CqIhXBrpyQ3+JExhEU2p62XmBg5A1
         tjpzaYDnZWZj/B6yjWrzO4uVQjPnYSWK7lSDrCFazUDUKcc2DHIP+FFvAhSU+zkUBAzf
         XHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368013; x=1793972813;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jpSzV26D6Rjz/NJkyTxMWgMImq37uaP+9bbwc82yg1k=;
        b=lNMZ1eM2+qYGCZbCKE3EKChSizokHUvNeCY+OmAu1DcLuCJJ64EBqGUDU+Z+H2g0eA
         dqA5PxYo4aqC/sDgyNIhjp3Ev0Oia/iDhyYd5oXBLyu39rxV1zYjeD0b3MNEMvG2UHUR
         ssPlI4zLpPB/RKtncp+oc0/KniwSKoiL4WJ1sYZWEfdzpYj2GJkOFpBChpcZ4ycBe3fM
         eUF0tflm0ndGfjPk+D2TgHlbVlkSzRjShtizhFgA2oRotTYHVSIMKAlKXISmKfrgQUPD
         yeUnz67yIuFC+5DlFZASuwvxR2Q5BQH6kDOUx76vmIKoLUgS3+qlMX2WdXqFj14zMjUz
         i9QQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBcmPDXc6ykUf4lbQWYCAtM6TrEO2fHyCsSMEjtPc0/Z8NKwlCq0tB3+kmwAMw/EIwKGW4ZIk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkT/zh1K5nEJyykGpib8zrhfSBkPZxYndty6LccV+ooBLE1KXe
	LIBP0pcnRRfmXPDPAcA/63IpGEo9Lx3jSoQHI8l9WMPg9teFngejNrgm
X-Gm-Gg: AYBFou2hPSYUucy1AVbfFSri5Ou6lSQ4iFJmnnuJJUkabo14MHGu29T+BeU4zPQ2HFV
	quyj9WHVo26onb6w94BvuXIhIFlk8qM2iPndj1ujRTNPhOmC/aALosK1dzb5kvTMqFflDzwoebB
	uNSVf09YEwYKEk7OBBYhSKeKZ4e/GEgL0n5nPioB1jbN0pO+VMEi4sSi5bu465ydEhTUy1p15bI
	N7U9t2Ojkrg9rzUEUp5NvFetonhLYvcTywSOs5xTSNl8W24JaBWwEPfiDzDdCrVG6FC3A1q9kJR
	/7zcMzRi7GdOIOAwOaku+5cHztF+6yRIZraq+NKBcmLcDcRk3jSgfv3EFfptMaX7hrxFm+UOfe8
	zqh3rAyT9s0C1h3qR2mlQaQ4G2A4TacXBbki+w13nyOKBZUbYJsIE8ynpXDMRFPyxm0NjKLa1TC
	2d6F5ENbMZTlK3Cqtij6/USiDm3VM9HpT5Q69eHEP6MEgZpN4XXtBz959ehM3bwrXW4u2NlSyMH
	sNc8ksd9LwjAt7qSZCyovoEObFfwej6N1sW8xwx3HBHYgO+ikAnCbNdC2BMTEJZE8gNia2bKWHx
	OjXNURocF6N9p8kSFb9xgU+SnnqqWsGv3hE/sxEaTn+fJ5ETCA==
X-Received: by 2002:a05:6a20:2583:b0:3e5:904c:78d3 with SMTP id adf61e73a8af0-3e928aa2158mr2405789637.69.1793368013382;
        Fri, 30 Oct 2026 06:46:53 -0700 (PDT)
Received: from rigel (194-223-74-160.tpgi.com.au. [194.223.74.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef96e53sm791024b3a.20.2026.10.30.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:46:52 -0700 (PDT)
Date: Fri, 30 Oct 2026 21:46:39 +0800
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
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 6/7] gpiolib: cdev: don't report a failed line read as
 an edge
Message-ID: <20261030134639.GA94733@rigel>
References: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
 <20261029-gpiolib-chip-removal-v4-6-aambrozewicz@nvidia.com>
 <20261030111435.GA76958@rigel>
 <20261030123109.1935475-2-aambrozewicz@nvidia.com>
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
In-Reply-To: <20261030123109.1935475-2-aambrozewicz@nvidia.com>

On Fri, Oct 30, 2026 at 02:31:10PM +0200, Adrian Ambrozewicz wrote:
> On Fri, Oct 30, 2026 at 07:14:35PM +0800, Kent Gibson wrote:
> > > Fixes: 61f922db7221 ("gpio: userspace ABI for reading GPIO line events")
> > > Fixes: 73e0341992b6 ("gpiolib: cdev: support edge detection for uAPI v2")
> > > Fixes: 2068339a6c35 ("gpiolib: cdev: Add hardware timestamp clock type")
> >
> > How did you determine that?  Those commits are where the associated blocks
> > of code were first added - not where the problem first exhibited.
> 
> From the hot-plug case in the message: a driver's ->get() error has
> reached these checks since each was added. Removal is newer, as you
> say.
> 
> > The failure mode you are addressing was added by
> > commit d83cee3d ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU").
> > Prior to that gpiod_get_raw_value_commit(), and gpiod_get_value_cansleep()
> > and gpiod_get_raw_value_cansleep() that wrap it, wouldn't return the error
> > that you are handling.
> >
> > Could you bisect to confirm?
> 
> Confirmed: with gpio-sim and delayed IRQ threads, a falling edge
> during removal reads as falling on the parent of commit d83cee3d2bb1
> ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
> and as rising on it, 10 of 10 each.
> 
> A test chip whose ->get() returns -EIO gives a rising edge on that
> parent and on gpio/for-current, none with this patch. pcf857x and dln2
> already returned such errors at commit 61f922db7221
> ("gpio: userspace ABI for reading GPIO line events").
> 

Ok, so the driver ->get() itself may return an error if the physical chip
has gone away.  Hadn't considered that path.

Could you update the commit message to better describe that case?

> I would use Fixes: 61f922db7221 for ->get() errors and d83cee3d2bb1
> for removal. Is that OK?

Not sure - I'll defer to Bart on that.

Cheers,
Kent.
