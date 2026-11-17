Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794936917;
	b=A6wP3GhEnho/obTU/LNHRWDNchJ/XxxL5zbdlyO7o+0Yf/RJ0qYHwrZyS2WqWIiWEEXB
	 VwhXshzDWNa1ltHI9WSHkJx8iZob5071ko1jOIQIqc0Vn0ajnyZvwQ+ID8UWefmW7uIzk
	 KTxNZo+m5uuUmkCCyfVhXiF+pYYnVQDDO656y4K/jN92vLHGiVrG1y5E0Ap+lQNSvOJfv
	 4UHeh7LXMulYRMKV3XNzbtmsQ9BIu6vvohes9Szqr/KUZB4C7Sz9LRQ+f/eSn98kl4Tma
	 R9/VO1XCqokz+Ck/aSgJpfhQ5KE+OqStWqgaWZjSSjMVK9Nj4px5Mej+oQLx05LFnxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+iEPT4fOLUy2C57JftfFB6MsPWk0QDV4EEMGYI+go7Q=;
	b=cky2HX03f30da48yqVKmBQrWKkCSv1xF6qFJAR8SLmQC/ioYNG/RgGLHvBpBp8OejMoP
	 62X5sqQOZoEp5RNcCZGDR9Rewt3mfATlPHqEXMxsxN5NxmzbEF/UPZmzqq0K+0BuCBu6G
	 FGK7DvXgO82g11QY+qHwoigBwXHlSSsidWHMGOx95faPwa1sPWLHvbLHusXRNIk4HKEZG
	 /7GUhR1PIFiTxlqbXnGN1cspyo6P4ZJDgjOJ9IOKJNRDdwLnz5N8+V/rEqYrmamARQ5OE
	 BpX8tmAj7t8iAyM+rT7qyvM+uHlf4urjIWGNfaDxT0COmSp6ZXfjj1qPYSq2r4aUgcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YPiE5lyO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BE606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D4BE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YPiE5lyO
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ed3df47bc7so14105ad.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:35:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794936917; cv=none;
        d=google.com; s=arc-20260327;
        b=nG0uitwQW8csrwOp28Gmy3DGKSkitwmRe0LlIsaqRd8HFXEFTNQVAELP1h7NiN10UW
         FnZXVF7zjsHzzPycfvx64WbBaRqTeitGJZe4azNRATBcLpFYJ864hnykh5uSAg9jhDl1
         v9JMh4sJBuN8UNGI/+TSbH75MdsQr7I+Jndk6or6rZECaVTpCwKa5XqLWOTBLQq8SOwJ
         Tz/tcuwp82Yw+DsXWocPAJeESW1dMuShfd2EvMrh+CX8eEBMf2OITpt6qGSVuQBvWThN
         tiDUj5JX4gD8w+AMnBsuXhV5UBDpKEj8ybDB9EUK6NWfJ7BZo6ctZmxc2Ag7MbE1RxPo
         WPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+iEPT4fOLUy2C57JftfFB6MsPWk0QDV4EEMGYI+go7Q=;
        fh=DNVq1EVG/udUJr07XSQuh2F04xhwV9GnAAwLWTeWl9E=;
        b=MKzYwLyXoWRnBksUHuUx+FddujI+kEGq6FcKEBZGNnXIWfmCLeFL/1Q1l2+l6LHh2u
         DUC1AdGSFwMka6B+SDj8DxdUxKFFm3Z7EqQBG2T/5bLlWP3BOS217J7D/PgA6fjmKfhU
         dEBrxlk6hKqjFQ2UxDsfPhJ1OoU63PORbaEYevyY5m3puOhlaIqNLjcv53BxMrzxGlVu
         I1znTEnJlSe4O9DiiC3OZ5dTXKDOyN+ghyA5JYQrVSkUyeALjrEUBGgoRQQJSvp575Bi
         XU07OV0arXwjTk8r+gjZEhSpp8aNv/yzCvlf9sxNc6b0mZRglqozfhhblF8l2K0N9cN7
         2+WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936917; x=1795541717; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+iEPT4fOLUy2C57JftfFB6MsPWk0QDV4EEMGYI+go7Q=;
        b=YPiE5lyO+qDn7QvlOgjPIJqviO6zK9UEeMs074eOxfruV0I9O7vf/ajZk7U7508YXN
         OfChmUxxF51tf/PwQbFetcAv0Xr14ORMQFEwzlFU87wl66TfB9uo1zd1MSt0F1Wt49xs
         nkgCqN7PdNwCOJv0j1zetrtDFKLhZO2nzwxVC+M7ZQ6TWvRqJqAPtgGEK3Gt3GpA1Sc2
         oBnXRXeEy+RuUJmt60z/EPZfT8jj4nR7TxTVGUesPbJKkNB8zOZK9qg3rnYHAh5l1rMf
         wb8zBzrske8iwbuOFhcUyimAE7SYNsKZd8CQLXrqVIyLIJA6TKtYLF4uFrhW9Ax5X5qv
         gurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936917; x=1795541717;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+iEPT4fOLUy2C57JftfFB6MsPWk0QDV4EEMGYI+go7Q=;
        b=MRrLOkyoGdsgKfSKXQEFJ2mhLxKLMyBfKbbqotJWljlcrgLBWhwAZfY2JPRjnw2nk0
         41tmBgFT20Pkeub1Hw5KFusi3Iq7NaWQ+s17eMep+Pj9q6YiwpapyzUb3N9NmMxkZ0Bv
         NThU6h/qLBbtsxmRN79zLfZ/GMKw2/if0esF+he8Mq+o9CtKN/8O92tZWiqk7ISqoN4O
         U3PiR6WbhHWwfukKq/IPdkfaLxAkUsCj6ua7U2G9GvhOZ+UagR5Nc0m+TRH6UmuaeBa1
         mZxVSFwhcxFgT5h+AkZwbcb9CTOoHAKK0tBgMHPYS6Ts1+8TYy04MLPr4853/ajnXo2L
         KxCA==
X-Forwarded-Encrypted: i=1; AL+hErGgxSb6yRnnshSK1vsNHpziA/7V6lgXqD9PxICsES9dlDEmVIqI7wTAMv9eiVcRUUepsZJcKNY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VnoVohASl60E4uOrXNzL82pSGuk4K4mLgOV4mTNb/Qov5OGKA
	AE8D+55B397etn168oBDM0EVhJeqXowcSDe1V/WGPUWjqtIa52544meWMOvloBgGaMWIusdt7p9
	a5DMpSLe7sLQNVo0NuvwYkGPcynpzYeU=
X-Gm-Gg: AZFdTZcaFYdlbHx1YbrgUifCDQE/jWUVCUX0W75PCVypqmfjzX2UjrpM4nINsL6DYud
	Qvpmip7337M4jhwYpR6vGM6xErtQtBNoNs31RHXdUAXz7Th824nnAX81YopkSJbLfa+TWUJwraM
	o0SNMHvRqcWpBxX3ED7EX5pGdaPkYUSS7wtdaI4ot2vWtwMF8JIv+oJ0eci9/G1wHCZCR/fCDSU
	Mdue5vQVcPMenj3Cz9zHUZj+j7E3S/tDZ2ggKwvCJMZGgSwssTemqEZRBr1LGEAilvW8ceYp6/v
	c6X7cypofAVIP6rRrjKuC+3042lNbVNXX/K9WvIX0rLcdM4QF0UuLvk+0/ndpJQMohYKrpf4e8a
	5kSIYlLgLFYwb98PEbFYANH9N1vWhGL34qrbdNg==
X-Received: by 2002:a17:903:41ca:b0:2df:8ab7:fe3a with SMTP id
 d9443c01a7336-2eff751fc0cmr213765ad.4.1794936916611; Tue, 17 Nov 2026
 09:35:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116084211.3066460-1-cristian.marussi@arm.com>
 <20261116084211.3066460-2-cristian.marussi@arm.com> <20261116-astonishing-urchin-from-jupiter-838cfc@sudeepholla>
 <avw5o7sTyriZ2ZiX@pluto> <20261117-prodigious-limpet-of-fame-3d72e6@sudeepholla>
In-Reply-To: <20261117-prodigious-limpet-of-fame-3d72e6@sudeepholla>
From: Chengyu Liu <lui2012qwq@gmail.com>
Date: Wed, 18 Nov 2026 01:35:04 +0800
X-Gm-Features: AclHuK-3dP_RVRp9S7UU3KZcH-t0O4kwljf1AMinJpV8gpEOTdKcRjWE-9zLE7Q
Message-ID: <CAE=Q7=4+HMtqbiK9v3jw4t31TQOYUfRXKRurZ7KcMi7GTi1v2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Fix deadlock between reboot
 notifier and forceful work
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org, 
	philip.radford@arm.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I think the current v2 may have reintroduced the second deadlock
described in my original commit message.

scmi_forceful_work_func() still calls unregister_reboot_notifier()
while holding sc->state_mtx. Could you also check the potential lock
inversion between state_mtx and reboot_notifier_list.rwsem?

The reboot path holds the rwsem read lock while executing the notifier
callback, which then waits for state_mtx. Meanwhile, the worker holds
state_mtx while trying to unregister the notifier, which requires the
rwsem write lock.

Thanks,
Chengyu
