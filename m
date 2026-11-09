Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211642;
	b=cX5PTzSOPE0P4pjW9VZp14/mXzUlQY1CwnAlK23xIOPWlPa91bkK/bS7WRO7epL1R3Ph
	 d+r5+AlsQsW/EY49hQ7DHAFqFeXlTZrZcJQNEPi/Nhm3QfNn5Avq0sH5wxw9NFQoU7p6J
	 1zHMXfL61KwJU3PMgPgXsLAMFx6HJwIckoXc+xpUoy5giRcgE1kx9CSLBQH1UcIG2iCF6
	 nsm//ZAmXtwmySmnFNhLKFpYVhUox3NB2ov4FmzRMONoOY7J+B0IKj6KIR8vmhjTKhNEt
	 unGNmoCd+YAZR5HuEf/4Dkw4UTHmlrMCYMdjanscPvdPSKqK4hY8UcHzFv/4BiATJSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tSuGt5zJ2pU286bCSrjG244N3zz8YI+MYqo9ROV43xA=;
	b=gLSHqhPE0hQsX+uXeGXLDSA40gotaHz6MXd/gY+fA3NSBPzYZ4kmFiIkonSBuAHBVrza
	 xkC6WvexKwtcDx2mmQqXb9e4Z8k4KycwIdnjOWDMmP1zdUW/iiJG1M5n0ynK6GZB6oeT+
	 Mqe74Eavlk2d9NlEjgUgtiaa6OqJx1tOSQ2InREixIpuRk9EMcsYE5YBj2GD4AZzyA0Kh
	 ij0KRdRIj1SuvBnhvQljEDFYwIZc+6jgSp037Jff4Th05MwoGsProJDTZtgrRbEbguQhX
	 0KlEi1ADt6+4+22QRIW2GXzzoaZ2vG22/f7MOqjhJC9ExcivFMMGAA2GlT0TY4IC77g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RIbOmdy2;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5D606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 08:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CC5D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RIbOmdy2
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15dd124bbe7so1145992c88.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 00:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794211641; x=1794816441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tSuGt5zJ2pU286bCSrjG244N3zz8YI+MYqo9ROV43xA=;
        b=RIbOmdy2ib6vKnkVWcn7VT8GORG++zi3RESLnZOwHMKnhlQzuHv6n1iDPPs0KmvGmC
         IreK21HSKKgVXbd213rMInKk2+ksnzTHAavfooHKKHqF6thg4SmrsFiMEwnVGwP5Q8f7
         wcjYIY1hvsXS38Mp113/lTQPX2mX42r+6zib4GjlOiO0X07eKZSjjWQDjrLmV2IH+0qe
         Hb5rxfCm4BM8MwKgstbByJq72QaOjIG3FkHzbGdALWcnNEY/eB8PFDoUClya1TusHafq
         RgXyVt07EqNCMSZhfIFkBPeJlBdjaWZpOa4Bkyt9RsMZNNbLKDCgP+OgZ3UAJCN62yUu
         8N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794211641; x=1794816441;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSuGt5zJ2pU286bCSrjG244N3zz8YI+MYqo9ROV43xA=;
        b=uz57DkQXkaXMGB6bih1vrGzZkqckRKmooizxz83zJL10RwEwPosQugRhV9bC3Pyn3P
         WmHFxQT39hOetgyf5jgln47XM17i93SzS5M5wA/SUsGRWKMou7RSwKDHFdeqH3G85m9j
         4e7SGrdeLru15CHLVjOr9n7Nj6/wNHcQfwX4B9uiDBNhDoAF3RxP1Z03vjFvs8rGljqR
         YD/+ElZ8B+W1KirpWXc/8kidCU77D933JSzL5pISz07cJQ8ani5if4WRJA64CKeAimCa
         GCCyNkJR187+SRKT3lOLGOUdlroyzrtS/cMUERECdeNvzXHZJKiu73urXkv1n8fo2XE7
         /hhA==
X-Forwarded-Encrypted: i=1; AL+hErFt8f7zZdhvDJT2UjoBYmNu/nyl+OCRsEEYG9zxMn2T3+TT2amVELGQGx5yLp53PFu5b+YBipM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dkf+R9jtqL/3Wz0bLCYPNqNwMRpzlYGwadIsJI7LwD+rHg/CL
	7Cuwapm+qpeUY4swrwFPfLG1TU8XPa8fHIDfFU9mIkM3n4wuHYGBtPvc
X-Gm-Gg: AYBFou1u+gjNgCkiwh+/pXGly9heDL5aLZ5X9peVIQPslWM+Zl8ukiKzCD8RSix5z7U
	j77Ooch6vIaeDSL1Kx7nOS1xkrlX2ERADuLzp1JYrDy2WnZo5KIBhEMRRM3Xt0zxJNPFGkOFbVu
	GV700YpdH155kg0s0cycJZSCwMs3nZMu1U5btrJg8Zv8xWQbm1BxQM4PGHnooTgHNudbsQ/k+bz
	P80oT7iTPUAP0yptVQ9AKbKLM3mjSMmHljNYx/YD4kgVmKpJF3Fgwo/UGYMJdBlA0IcJd+5u7ds
	Mc5krGkZnopLRv2mL1puytLM5XrVdGCYTEVtsvvDOebdbS/QWhahcelm7i0ewJ1EKLHAYq+Mb/x
	9PXC/1jHkJGFclzllCxOQUsqDwbCHb9uXu1DdirkZOTWlZ3YyTycRJo0YHBQ0nwocXBs+djSDyl
	GiHlbnw97TeIMtYzuqRcdLzKfNH5H2+m29BeZu3ifQnzeDZujCXo0fjhv0E7R2R5/pB6iz/+mwP
	J/Ske7v2tJj0NcWYAIzMitGRZOqAfYggxHaUx4QhhLIKAa3qV5GvFrISL0iIJW+8IG/FHneqPq6
	enU8U5Mr8gXJ5HtcZG7zC/p5pMBxp3IKzKRjkGhiO0KKQVJTt3g/16r7DiXfn55Z3g74bTLjA64
	dA5LwwH0HNyWZnw==
X-Received: by 2002:a05:7022:220a:b0:15a:2b63:a0cb with SMTP id a92af1059eb24-1b3a32c135amr6400658c88.13.1794211640937;
        Mon, 09 Nov 2026 00:07:20 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771fa200sm10691247c88.22.2026.11.09.00.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:07:20 -0800 (PST)
Date: Mon, 9 Nov 2026 00:07:17 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] Input: lpc32xx-keys - reject matrices bigger than the
 hardware has
Message-ID: <avF_I_6WkF4B7tPI@google.com>
References: <aurPvymSFACa_kXH@google.com>
 <20261106014928.328020-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261106014928.328020-1-zhugl3@xiaopeng.com>

On Fri, Nov 06, 2026 at 09:49:28AM +0800, Guanglei Zhu wrote:
> The scanner state array holds the last state of eight matrix
> columns, and the interrupt handler walks the matrix size that the
> device tree declared:
> 
> 	u8 lastkeystates[8];
> 	...
> 	for (i = 0; i < kscandat->matrix_sz; i++)
> 		lpc32xx_mod_states(kscandat, i);
> 
> The probe path only checks that rows and columns match; the
> hardware supports square matrices from 1x1 up to 8x8, but nothing
> stops a device tree from declaring more, which makes the state
> array index run past the field into the rest of the driver data -
> including the keymap pointer the same code dereferences.
> 
> Reject matrices larger than the hardware supports.
> 
> Fixes: 69690bec400e ("Input: add support for key scan interface of the LPC32xx SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Applied, thank you (but dropped stable).

-- 
Dmitry
