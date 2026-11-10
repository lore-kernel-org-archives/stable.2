Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317136;
	b=QhdoFw/syEiayARauzpvOV7TXBcjIzBOhRayyw5CKJwwkOlF7Mq0yKjjv0LS6qcBAZFd
	 XK7KwEPJe7YauOs3Aa/p1eEFM/RNysHPGlHlub00ZvafDMZX2eu6RGdie6Fz3v/TU/d8T
	 E/jFsUH3BdX4O0CXeEbwk40UeSI9Ch+bFPFGPM+zLCRYsrXRu1MF1svoLmbf/qlPApUIj
	 KXcOJ2eqH4dV8wB9pYowJrFdfqUQf/I2y47qq5Rk7iN6akIp4cs+P+c2BCKBIFzzCh9eQ
	 4iawXlvjXNj8YF1u8hfH9EQ/0qX88K8bjyUItEO3gtjQ24XX912QGmbuWRay4osiPog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YKd/kHsAOXGiQQzEOqTVusTgtAD/RculmOME4VJ/9Ks=;
	b=U+SS5d4WJgggErreeZtu1pQmC/YxiGI9QDWH8a1RH+JeDYADJ4rrLijhzdc4bxc84Li7
	 MpokyZ5ouh57cUytbPu37qVch1aZ+w0sJ3SPbZUHg2D3quBcwylWETQIKX8GcCgng5g8h
	 YTPooyz+B/pz45Nq6QIqZBD8/yLzveEQSdz/Pqqj99s3Dq9J4hr7Nyc2rDftD/5vZugN1
	 b9K79Il1yPmAQPMcpJYH7dANqrPJih9o4AZZKGQebSfxLTNIW326yQzLuGhxiqa+MXmsL
	 L+hHToaRWzRLnpXrA0XSaUMFdQoSAhhyE83nmltIxp/iyfC/2D5gR/E9a4+5iEUSPTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=N2UfvVcH;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A453A60727A4
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A453A60727A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=N2UfvVcH
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso15534955e9.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794317134; x=1794921934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YKd/kHsAOXGiQQzEOqTVusTgtAD/RculmOME4VJ/9Ks=;
        b=N2UfvVcHrDHJqPWtz/QMS71N4YCSe0N3FxfMUhjmXmE+gKHx7xQJ0fZSNA6Ki27DLI
         4NUez5humOsWmpUfLlwGSxiFajGxk0XR+uCM1tyInuAVXbsD/vp1SAOeyPGDU0mJFrWW
         VmfYZ+OVpTIMMTKebquNXGwuJclH5f6Ek6pEyoaAsxWSAAMox3fYDL7+PE3aXI/3RERz
         bWD9BXEM/xNvzwZKfWJkrp56i3YWcwxZ/kvmhSWI1o/3nmMaYwcy4bjxyGs5EL+exW4c
         XRm8O0w3lxMXGwL9L1l37bzSKpnrrimyF6rI+/RRN2kF8S/l4mEKt52yizG7cJnuPHsE
         CEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794317134; x=1794921934;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKd/kHsAOXGiQQzEOqTVusTgtAD/RculmOME4VJ/9Ks=;
        b=RTH5xN3VugG+3HiohuD3W6KYGWMzT3yES2gQvpUICv6C/FS8dyAtEiTrSaeQ0mipeo
         bTwODrb/VFc1JYEh70wK2qnoUDoX3PdOwW9OYZNjeAruuDxFJwFSRAYyh6UX9gW+DSt+
         vF+PmSz5uhFGnZhQXBUOHZtFQ5Vg7fWIXt5v9YimFRhPX5Us7E0sFH2n8DcFfh9LcI6y
         A9NPDOBtRM7NmJBeWr/1r+zA/Px6kvE60/KrK2b8ccEaWS0YaMPeNzkYASXmIl8iKgUb
         t5leQy4cdvnAvJksiSORg9RUBR3DaLPBIsQBj6z5TJ2ea9y514TJQPHHtvsS9/hQeBay
         J+4g==
X-Forwarded-Encrypted: i=1; AL+hErEcXquVr26MVFUAUeru+HQ6qYp6nRa5ZHGje/72XA83vexouAyp6uy0WVRSs0NV7YQtVJmi5qM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NylgwqAw/YeCvrIHV2neOOBmiA3Yih81C670nYHkk9vtSIm9t
	g1/SlwPTRlF0zXLsUqk8TskBOwAyEYXy+k2p6Fa7zfOOXaqO1CE7XJGDhQf2TAbBrqU=
X-Gm-Gg: AYBFou2SE8Z+HvJ6EtRtRUnCJIVLcWVsCyvPLIkXxuwN2U62/TSLRG79sOpo+Mw1tpn
	ntzyPsRHRmYAzhLIr7COXsL1L7xRbFwX3r1sMeiN6l1uQcOI43GHTNAXiMBAUb4b7SanmCmvtoH
	L1G0dPoJiGIt9Ujbv0b15MBqnrhU6WT2GsfiXheVmD+SWXB/fB91iof2MshC3tbVyBXczp5wGPU
	VOlPd9/e320WK4O2PPZDgLvah9arhQ9GCmKyqPonI2zc1UN4YiOv10csbidQtygfK8K7Ku3MG6y
	V1nD0r6bOnxNCNS/2JwL5OCKfNcpfwvpE+w/2LOVqW5FpkVDb2dRw3f6M9UAfiycdkUON6LzcOl
	gZBqJ9CzmYgWXBZqzurPFktyYpkoatRIKkh5xUk/mai4HA5C9Gwyd2Cbc3xAtjy7+HKTPhd23em
	x9o/rpHzSpC/1UlgIrHooXa9xnT3wdszHxMo7tCDvX41dvvjAlXwm6SHPOhc6GRIRcimQXQf/lQ
	sgU8sG/RyPEtA2XKjtPJp7UWizTsLNmrSZOpwi85Rlh7uKaIasStqWiMY4/ayBmWeiqGC7rfDqr
	slviVLJjygxPlp++8iEGsdXTqNd+v6pSztxLUOJBbWqYEW7T4PPawQsmU6jzt7DLd5g=
X-Received: by 2002:a05:600c:46cb:b0:4a4:de70:2ad4 with SMTP id 5b1f17b1804b1-4ba0234dda8mr46784525e9.22.1794317134025;
        Tue, 10 Nov 2026 05:25:34 -0800 (PST)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba020433casm61728495e9.7.2026.11.10.05.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:25:33 -0800 (PST)
Date: Tue, 10 Nov 2026 14:25:31 +0100
From: Petr Mladek <pmladek@suse.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
	linux@rasmusvillemoes.dk, senozhatsky@chromium.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	keithrteeple@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] lib/vsprintf: Preserve the sign of seconds in %ptSp
Message-ID: <avMbS0HxxVBo76tq@pathway.suse.cz>
References: <20261109215445.43419-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261109215445.43419-1-dennylin0707@gmail.com>

On Mon 2026-11-09 21:54:45, Hungyu Lin wrote:
> The documentation defines %ptSp as equivalent to %lld.%09ld, but
> timespec64_str() formats tv_sec with default_dec_spec, which does not
> have SIGN set. Negative seconds are therefore printed as unsigned
> values: {-1, 0} produces "18446744073709551615.000000000" instead of
> "-1.000000000".
> 
> Negative values can arise from time differences, for example in
> fnic_get_stats_data() after the realtime clock steps backwards.
> 
> Use a signed decimal printf_spec for the seconds and add printf KUnit
> coverage for zero, negative seconds and the signed limits.
> 
> Fixes: bccd5937447f ("lib/vsprintf: Add specifier for printing struct timespec64")
> Cc: stable@vger.kernel.org
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Keith Teeple <keithrteeple@gmail.com>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

JFYI, the patch has been committed into printk/linux.git,
branch for-7.5-trivial.

Best Regards,
Petr
