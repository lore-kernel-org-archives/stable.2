Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793732835;
	b=MV7fwmv3PdjSv3U/r/zrH0eUnKGDQY5Y92CCSgqAA5X91tPBO0/4Sn58lusNLMCUhY/W
	 s2qY8SnZnu4GGtDrA5X+Hn8KxBEVm3Argzo9vomJSLLeDKR0FnFPGiuYN2Zx4hQ3u52lf
	 pVNmAzw0bqWzkZyCRnxrDOAp/RE264mEoKQRpcLMqVQhOY5PIy5RxYN/nwe2cajW8Mc9Q
	 j7iG+7Dmg/1hUxOQhPV2gO7CwCdmpRrjgTb8FCIsouc4NMtzXU8rH8YW/gbinbulmMcSA
	 kYhzK4Hm7Kss2wGOPOVl5mexWN91rk/c0dzCDKr5RccKy5n42IWLJdL2f3s4kN9K8Ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=0+u/BWUffFdCK5nAB/ga6GWLedobIPyeWluDDSR1ayw=;
	b=L4rR3yt9trHw+M7RQp96MsIcJpspYh47LESf0GVCXisUJoKCkRGJY6lLT0tZV38yu5MO
	 eh7R+hrm7YkbL9Xnk2sGNKt9GxBBRFNUpnxQhnEM4g/aFhobPP9XVVjdJ7VHXD7xlyo8U
	 wwNkzCeKXqTvsh25T3fkCEiSNdqAKuVJwkYDEfjTLDelIKYlUZc+rZTGgiRrhHoxTil99
	 mOLsuonuK2c5MGTr0Aej6WCRweX3SmgOB3EnbFj6keHPhtY2npwxzFPMrKye73ctH3a+T
	 YgNwrSaHLaFoK60pquzrD5kDVJUqhY+nsC/P3TMtEs9QFv2oPMafy87Ll/8+FzhMe9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFPmZ9oB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98B2606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C98B2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFPmZ9oB
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-5179f3beaedso325316b6e.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:07:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793732834; cv=none;
        d=google.com; s=arc-20260327;
        b=HZ044qiGsK/hj2Gdqab71WC3EsOLoTNaGoFjFvpY6d3NfFB0SQ2lHsG5rdatIenXNI
         LHSqsG0qIxnlBdBsUDpsXbFVodoFrNBEamzqGU+NWWhyp3qm7YPP0BJ+Ul2sGMmCLPl/
         hE9vcOhd80KIDxyoPX+GYzIEeE2HewpTD+MjHYmH3vLWil85jFPEz4bUCfwbrkBmwJ23
         Mk4+69akP06HPPxUT94PKi8PZNgDIe5Kia+P+FSC2U1tvzCJkzgqOanF9PQ/j9bgUAnF
         n3T3o1no8KjgvzP3yygKVEacA2zbNjz3xUyAhlCBpqlieBDkAzt1aCk5E86cyRglc4eT
         ++Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0+u/BWUffFdCK5nAB/ga6GWLedobIPyeWluDDSR1ayw=;
        fh=PwGNetWOHpVLyPwob1VuG2ysmBgq7hGCGTL9ZasJJic=;
        b=bv1TG5LaRaGuQZTmWWcKXvoQTSAq+9TQmt50JanG0GXpzOOAMU/6xZE4KC+yxj2jps
         /lbXZOn6wQVUxnQu/aKw70v4gFlUor4+zNRbHKVBJQCJJFGIqad7VGR8ZWUmiHvWkdzO
         NlNznQCeX/5iXRCljWZ16sDy0rDBES5mLs1Pdx9N476sCD6TKSPJpyX6RIGGs/18RGIl
         CONmkzaTnqUtmJCHWgzEnfIQ3Lm1btUEJV3C3ag4oRaSHWQcFDcvxKlwFptIwrMm3GDe
         O2LgafK9q+3h/rr48r7Wa3QR9pLMPPS8H2AifuQZmPc4wku76UpdHFsmGNORqEsFb6/Y
         xXgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732834; x=1794337634; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+u/BWUffFdCK5nAB/ga6GWLedobIPyeWluDDSR1ayw=;
        b=cFPmZ9oBtx6sPRiaoSpMhTsu/UgMBSoUg22SmPUWKZtTiPqs6CrMsI/VE/th70956B
         MVR8J6qRtAb/eVlxAs/9TsKwx2vnJ0sn66lNOYbIGzCABHlV9KKjng1KBw+OVpYu/3kx
         40eO71sWgNJSamIiN9eY5SbzLnTaU4WxNvhggS1NPAD2r0+anEsUsOi1dPiOpMJ/QqbH
         Sdb3LxWrv/zmiWA6L7yfVza5hciJIhXQIHdZqNVu9TCMKknagCQf8HD9A/04gnoO1O9T
         BgRYpijIJydDETK6pBBNJrJD5R1TOX8EvtdDdCewmhiLmn6ktMfYAo+LuB5MJHfGzc6L
         7R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732834; x=1794337634;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0+u/BWUffFdCK5nAB/ga6GWLedobIPyeWluDDSR1ayw=;
        b=1iIq+4RH4uk/LPisACgOTf2hpzCQe7oSFNPqaeqHsRVv68ALBu08p12WuEAZCKoqIC
         XpHS6/miZi1va8RK1rTy3IvxWVg2pvwWGWk5leKsKj0RN8m70Y7Jt37M+rGblj6HhUy6
         SlXrvK8GBY2Elvr5tD0FYU3NivZDk96L73eJW/jzZaW6FlaPVwGxdYnFpZ/C6qkuXQ8S
         5EsfL5GkEFw5zAGyDHJqCHzxB89ZPZ6iTfaowhaYQAUdf4O+dBSf1/hMflvlk7qqJswP
         q0bQtXyUrkHtyibKfX3b2SkKXHl/I+tC5BcxrTzuVr2rRGT6l5KjCGdM69vYoWRzae+y
         0fZw==
X-Forwarded-Encrypted: i=1; AKwUvBwP6C3b1ol9NUCX+AXO+SiL3a1Sntn9M71Fs7Dmz/ixd+Sx7FXm/EoypX58pSM3aHn6RhPml5o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MoEjm6CFGes2LkLuSTQmbXoTlb93cYqceLsTrEcmO7Wrq26lx
	rwGPW/1Mck5GUkX/3r9cSv/c7O7ObfYcxink2croLtZyXZEh7Qn5VvhQez/2PFHoiLU8ZM6tg/q
	ZZ215L0X+ox3UwJzS1F580i01TI2a7Csqj8tBiabcAtti
X-Gm-Gg: AYBFou0bertNOiyHyorY6M6kOkcHMG0oclXLWl5BtaJcleF/u30MWy8B1reaTGtg21U
	eCXzzpc8Vu2L3kP/i7p7d5naJdQ3+ZcbTkCXi/wJ3vpawsxe9uayMl8tz69gRYnt0eFezClsH7s
	aPE+yX1SxIZIBvKF0TzqkUlOtcjiUvDhGU0+KABZKdcz1hSeAp+jvrKL0/sc9umC0fFnqZDL0DM
	uWeTNCR6ZtWP06ZwsTtX+uSSoHvH/SYE+sEqlUmVK93g6DFs0SuKZcQakKmqdQoGxDM7GMkwmNe
	uWX+6i7mVcuy/6r7HWOMrJ0cky34GeYuA/SdRcs+FPwI9LcoQDljgWFgGdBFkiLkoe1WqvbcDXy
	8OO9a7oMUQk5cwtG+IYuBEDwLOsNY8vwaFmjG+RWZDFT2OH5BSe/mf81Yu82o9Wg1PPURQAB/uB
	2HDaptiWDc1GH3aw==
X-Received: by 2002:a05:6808:17a3:b0:55c:928:69d7 with SMTP id
 5614622812f47-5640e0a4dd6mr8734775b6e.67.1793732833765; Tue, 03 Nov 2026
 11:07:13 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103072234.55611-1-dennylin0707@gmail.com> <aunPPm1d3G6yVCLC@thinkstation>
In-Reply-To: <aunPPm1d3G6yVCLC@thinkstation>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 3 Nov 2026 11:07:02 -0800
X-Gm-Features: AclHuK_s_h176gaiDao9usKlX4K0x8D5lo_mqJC-t5QWJ8dGUnHlKYyTf7Wz6B8
Message-ID: <CAGEkeHcANE5wkbQHkOZ0E0NsJJ-_JaD45yidU8XJatw56tqaGQ@mail.gmail.com>
Subject: Re: [PATCH] buffer: avoid extending i_size after failed writes
To: Kiryl Shutsemau <kas@kernel.org>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	willy@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Do you want to give it a try instead? Or want me to submit a proper patch?

Thanks for the suggestion. I'll try your approach in
generic_perform_write() and send a patch after testing.

Thanks,
Hungyu
