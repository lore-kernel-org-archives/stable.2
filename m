Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586870;
	b=fXvF0t4mKOYalT4zFS80NzVk2cAJ+1QTqsGwRe86ErjtRkIh7oQk4mcHYHUC3TG6Lx9f
	 0imD98NnIbGeMAeGoWL/6qh6QU5hcM3+QIXAUpY1HlqBuKrks9y6KlRP0AxbimE7BcCsb
	 kWprdAu5DUVQSDhNiWHxK8FGDFbpD6RwaXpoKPIkPqwnxlHt+b3UVcmQJl4hvW5h8x/63
	 ymhGLMEKaTmJWzddbe/NIqJkQ7PAf8zNM9IQDMvJvariCIPdrNXibWTWVs3TED9cl+Wku
	 KI6rPYhDTcdfkmhX5+7doF2sooE7owuuIJha7TNfPzO4UfzCBQ1/xj7+yGTyViEgp0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References;
	bh=Rban1o+3rHAQ224PepepFMfp591GJyTcm+aUhX8XsN8=;
	b=dq92istcyoE1A/q8bclI7SgXnbrJnEAx02CD+39G58HF20ZYcGNpmjhPMvpV8iUIt48t
	 l8TXwMOOrgLcjDhVK+iUq0qrFxE26U7PzgPeceTbbq0AEtBnq71ydBvftxlp5ePAmdOYx
	 qQil0DYRhJsvRWgRCQcIzSlGrnkJlUQq6pB/bSfGb7EswfaHNV5iEC013lGAn3dnngiu1
	 E8xorEVYNARB0UrxLAxCtb8ED/zim/Te0tAqcIPTmg86HW9LD6vdwP+zLYlE0SnCy7pRm
	 X9N1mmkPq8IjC8AX8+aRuLidGfjgN5+gj73k7YcSC8JPy9qpCJ9gbCbUm+X3sm+CXIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m20RcNT7;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4B606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06F4B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m20RcNT7
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso6757005e9.2
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792586868; x=1793191668; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Rban1o+3rHAQ224PepepFMfp591GJyTcm+aUhX8XsN8=;
        b=m20RcNT7je0a+KNQjU1SwmEpZWoqGmQ+JrOXQRvXhC1nrBS8zQscp/Ex3PBtg1vvjF
         a7si+CiVWgth8ABVMpL6nL9OZL564mgzXYkb6ojKpcnL/++aJIJqJusyPuojsoeuLDtP
         XzZZatT6kFQScwQT/Fhb67ehT49aCD4bCdcqOeQVAtJfYJIREOvzXzANT43EIcD0RMeD
         IOvW+tjva8LTX6l2R/Z+wq2Crsg3RXySISTfFN6TpnQreUAwUP4gCP2FUPvc0NzsVczI
         epFGaXEJ0u/jWcm86mo7060mf+rshFj50yP83l0yjtFBFDFEK6djHQ4i8wTk5Jrxld+f
         nTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792586868; x=1793191668;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rban1o+3rHAQ224PepepFMfp591GJyTcm+aUhX8XsN8=;
        b=pnXPBLS4PK2/fL4zvz8oV4FJE/siLj7J/wSBig5KOHvZRqubahzJRL47vkqtq3Uviq
         rygRH0gG4HiSvjBHUwR/PWC348lZarlkjKtjRgkFUhz/88HYZlPbOK6uXt5+EH5FfnxS
         +fi49TASdleXebxjiqTwRVwK9ta2c9A2PcY2EzzPchAdvKFRSjyMRBWQnP7/bnd72P6f
         gn8g5jUf6x6x9vOPhJtG2NdUn1phS7mnvEeNCVKCt02tviKdO5oCpjw+BAaz10kU6wf4
         i51+ue8CkixahkW5CVGnyUX6VfOpGNY+Ar7y+6lpX+eQD2wii9El9fGtQN5IAoesgcuc
         if3w==
X-Gm-Message-State: AFq9FYLTE59IEfPSlmowSbhJYGOO2CveBXkZ9SMlV8iT4mty1XRKZStz
	D+ktf9Ch4LEaXKRF+lyTf71kM5rmV9LIRr/Ft/lSAgr7BX3/iBGSnoPc
X-Gm-Gg: AYBFou3FoDCATcjBLy4Q94eXmeto5T3ZAyCnBMOFZzUnpSYAZO4JijED/d/RhD2w6fx
	MBHCgvJdq8RYSMg1GQ+S3tMDKYmF/ZPk1XwsOVNLX/HeHPBF3GuSNdUMlfXCiU35XG6Yas/x2cU
	Mw0H3zfQZl/qKivmDj4ofX7HPKF1K9vP2v0nO2bM0lyr58vT6oQLiPp5GVT4Q1mKAdEe2LF1x/i
	W5JDWdPM/W8jK4VCwFlxeV9W00qa3ThsKViwqN2jtD9WOsNA6Ad1JzPjzr0cGALzUihL7cy621k
	hPZFyFrICgLGEo87ACJ8k6tdAPP917YjM1nl6BIeDUnYlmeWZy3HbCkRe6FADPBAeNVfNdPKakp
	ADWy/hK15VjA6OiUXCu8sDj8EQXH2g4hxGc3Kns+3wXqLpqRCvMggSVen/DMS/sYhGtKiTUZaKH
	UBQQP5s3sXpFpvutv4REUmZq+FX89XrnIQYAYLJLNfsFB+3NK5r7hx8ISWZnNlTFxh+6Xid43hw
	s7C3HQDzrs6YxkTroUNxcGQ5kox/NOwp98HToJC6qPs+W5fM4dc9vzWu45dDT6Y3prWg7tpGSPi
	NGill77Ib6mhIS+nsKzK+gItS/etJLaI
X-Received: by 2002:a05:600c:83c7:b0:4a1:d087:f6ab with SMTP id 5b1f17b1804b1-4a1fdd22df7mr41166515e9.18.1792586868245;
        Wed, 21 Oct 2026 05:47:48 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.114.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ca3666sm164270815e9.1.2026.10.21.05.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:47:47 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Abdifatah Suruur <suruurism@gmail.com>
To: pablo@netfilter.org
Cc: stable@vger.kernel.org, fw@strlen.de, security@kernel.org, w@1wt.eu, sashal@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [SECURITY] netfilter: nft_byteorder leaks uninitialised kernel stack on 6.12.y with CONFIG_INIT_STACK_NONE (CWE-457)
Date: Wed, 21 Oct 2026 15:47:44 +0300
Message-ID: <179258686469.28311.5894488032414438351@gmail.com>
In-Reply-To: <atXZxmkU9Yrv4h_b@chamomile>
References: <179235055956.10524.6485282696272965887@gmail.com> <atU2brRgmeb6ght2@1wt.eu> <179236182769.4914.3317139682579833845@gmail.com> <atWvQFXJzJ434qGd@strlen.de> <179239012164.14465.16534329674629579851@gmail.com> <atXZxmkU9Yrv4h_b@chamomile>

Hi Pablo,

I am not asking for a CVE for the upstream code, and I am not disputing
that bb061d3 fixes it in 7.1. I have not sent a cve@kernel.org request.

The only reason I mentioned a CVE is that 6.12.y still carries the
pre-bb061d3 multi-register path, and with CONFIG_INIT_STACK_NONE the
marked-but-unwritten destination word is exposed to a later nft load.
That is why I sent the 6.12.y backport rather than a mainline patch. On
the default CONFIG_INIT_STACK_ALL_ZERO builds the same oracle reads
zero, so the affected population is narrow.

If you and the CNA consider a stable-only infoleak that is already fixed
upstream not CVE-worthy, I will drop the request. The stable fix is the
part that matters to me. If you do want it tracked, I will follow the
documented process once the patch is queued.

Thanks,
Abdifatah Suruur
