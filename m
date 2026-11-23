Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460053;
	b=npQqI/lugCncRqfDYIyIk0CklR7jMgh6XOd6eGR8nGMJQ8TFckooa/XfxMk/2dovmoby
	 HMRqeE4WWenW147JWHewoKSxp7YLzC8o69TyJPTABj+i70FyZMSe+ZAsRx1LV3WWfbnaX
	 Q+qCi3d5vw+rHxl2Bf3g/XpuN4oO+KlQx/LAN8SSbekqw1r35Y/qX/kW9kYJ78SSuITkr
	 tb5PaA4mRCMMx5tCVWNY6rEXIB86Rtd5p/schOCPNWsX1nyxfZPQ/uTwIyszv2sHDnrON
	 OCrOQ5bB+CZVTezLvOfHHrVi9CUK57IoaqvVJ33B/1Q+WyRoDp8LhBz5XCro/gJnKvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=Un0k2zq/NBWK8TpOG7W4o6jrkmU6EU/STMy7oHRK2yo=;
	b=wL8kcMGD/jw/0nshMINy7y3vjc+j15og/7TEstrKF9923oI3oh4hk+gCzaBVsA01W6s/
	 kx5mXPhTwz3P5mFkZP5RkLLwX8zbI/XRDB1+lJevm19+UvoBmNiYfGWVIxhDpy0/WP01p
	 mdCt6JmhDmT6vwdP2fsFXFbZJJzXjlqwSjWgvflvm8SlxR1wpOMVyKHakaS/WNaeGqVhb
	 /epquP0p6vd/6S5UqHe1RUAUcqgMLvNU8vxNyt7+3cfxwUH1Dwo1OKe+J0sIwjlDqhI2u
	 mZkiM4jpdRRM2QFqfghqNVs0fqd3Wc7ZKr/tMdO3I4GarNz6gGNIrhw+ShMQlRXdlVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIpW11g2;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21C606A336
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D21C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIpW11g2
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38587f3de36so4393999eec.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795460052; x=1796064852; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Un0k2zq/NBWK8TpOG7W4o6jrkmU6EU/STMy7oHRK2yo=;
        b=OIpW11g2gVzbasg136CCV/9dpq6CgBph+I2MQdPv4F2/U18tMPOXDpzI1VvMXYhx3e
         J6e9yGfIHO44UVaB0+NpVZ/A5Xd43MoKbGyvRA2zHncMw0PDdz1iEXjrT8TLCrUAr8yb
         j2NUHT2PcgPvZ2pYu+oXu7wizkHr8cq9dOQSenVNCzvFyMHr6ksUz43v1s7w1IwRVzI9
         JNVAVyZePccb8JKjgRLnP9yIo8zeM7YocIwJ1GX/q05OybH2sq9lIflcq1gHcma4V1c9
         gHVlx/x+u2+DKpJfupkcfAa07gE1Jo4IHLqpSuqWFG47SfMC3k3+tTvh2WgstdTXADeV
         yOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460052; x=1796064852;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Un0k2zq/NBWK8TpOG7W4o6jrkmU6EU/STMy7oHRK2yo=;
        b=rdT76qnUhslj4QSOU+Qaf/saX4IeHKl/vGZgXc765R+3bM3a938yxpv2hkqVozFMux
         sizl/Aar951KaRN4vzeV0/c3iQILpIoROg/qgIY4Bwg3F9iMtjdM6fjMG+MrEPlmiqIU
         DvC/tMpIu54u8FH0UL07YyznT6ONnsh4XAO/0MJVOE+G+kxcuOwsao8O9Kq8qJY2XQa4
         LiMaSTsJFKCx39lxHkpsekOzrFWFkYU5nCPZRgLhE9HhD2AsqF/RIvmPcpX0RxEMUwwZ
         7GqZoLvfzNaG17TUBexhWAZS88CMG+ZyxRYM9Ynb00fazAa6q9m0n2GAf2LAx8NKo52i
         NYKg==
X-Forwarded-Encrypted: i=1; AL+hErEFzySpKboAJqOlHjm5VwIFQOi+wEXMDhIn3fBuAPT9FNiJ1pE4U48p72OHz8EL6h16ro/5+tg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6KCC4TX6kKqJaN3iJocSQFUYDALL6+3wZ4b2O8Ie99xqyPmlD
	GSGohdRoyGCPQ1TXS1ZCnWl1VUUjhXzpWzS0aPgEVSQh0H8/SsDfMOds
X-Gm-Gg: AZFdTZeo99kF/f7/B52Jb5eGups5FYxlQFx+f9DFNS72zW/OaSHviAwMF13Kup7b8LC
	6Aj5SgqXYIfMVtke8clsBvMeiJBEZZRprFb3dJUQpl7JzZ9o+FeZq7s3YZ1Js9+ADDybWzYj/5g
	KLkSRmoiwEAc+hOFZ9Gg+eF70UsZalPtwywliVdQm4gQFPrVAOEr4WwjwVEriam5sLJND4OHLh0
	PZcAEzj7vQWyl6q1GCp2kGGf8lugeEkE8dp49bIUiu41johgpQMnspgfUNt58oiFlhsZ6fm1Jom
	WLFHhK3N4JvT0QBAXpXRQF58Xi/LGL6Sq1J/4uyVB+85NpHvxdT2nZqna6QcXQ228XF4Jin5FxW
	Lo7p2zLlkcR9MscljRGLLIjnn+Z2Tys43FyInlbHxz+ylCH/z/vkawtdNTb5qOnDOxKRJBZBE1L
	CZke3J7Ev7cVUf/RPa2KB2uwlo6Sut8W6xfaUskdWHzZ+ex26sTE2R6SX/AR4HTU0a+G1uTXEFK
	wgUxcl/rBrbicauJuiWsivqOiPH2tWY+0gVizVNjaOm/Z0f0XoRESKyPl7583DlaZAVUVoi9Dju
	ZhXGcuqtC1VWo17VnDTFMssnPjlbf3g9fCMTqDl5Y5kDHYEnQre01dnuzBrUQzGX+oPvjg==
X-Received: by 2002:a05:7301:d813:b0:386:8bd2:da35 with SMTP id 5a478bee46e88-3868bd2dbe9mr10377444eec.5.1795460052262;
        Mon, 23 Nov 2026 10:54:12 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567ea2cc5sm35609839eec.29.2026.11.23.10.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 10:54:11 -0800 (PST)
Date: Mon, 23 Nov 2026 10:54:10 -0800
Message-ID: <78d3f2f7715e3b66c06dcc7268966964@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wei Jie Law <98lawweijie@gmail.com>
Cc: andrew.smirnov@gmail.com,
	bentiss@kernel.org,
	e.velds@gmail.com,
	gideonheinz02@gmail.com,
	hadess@hadess.net,
	hansg@kernel.org,
	jikos@kernel.org,
	lains@riseup.net,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stuart.a.hayhurst@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 22/33] HID: logitech-hidpp: shut down G920 force feedback on input unregister
In-Reply-To: <20261119064303.274901-1-98lawweijie@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-22-30743e91d83b@gmail.com> <20261119064303.274901-1-98lawweijie@gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Wei Jie,

On Thu, Nov 19, 2026 at 02:43:02PM +0800, Wei Jie Law wrote:
...
> I was auditing some HID drivers and found this exact same use-after-free.
> My analysis agrees with yours, but I am replying as I think there is
> a stable-tree gap -- this patch does not have Cc: stable and your cover
> letter also only explicitly mentions the "first 14 patches". This UAF is
> worse than a crash and can lead to LPE if exploited.
...
> If you'd like, I already have a patch for stable trees that I can
> contribute. Let me know your thoughts, thanks!

I actually dropped this patch in v3 in favor of fixing the lifetime in
input core across all force-feedback drivers: see commit 2ae35f090d02
("Input: destroy force-feedback device on input unregistration") in
v7.4-rc4, which is marked for stable.

With input_ff_destroy() called from __input_unregister_device(),
hidpp_ff_destroy() runs synchronously during hidinput_disconnect() while
the driver and HID device state are still alive, so no G920-specific
stable workaround is needed.

2ae35f090d02 will apply cleanly to 7.3.y, and for 6.18.y and older LTS
trees (which do not have ef166ce08801 and ff->stop) it will just need a
trivial backport dropping the ff->stop removal hunks.

Thanks.

-- 
Dmitry
