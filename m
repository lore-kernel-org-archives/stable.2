Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331213B3888
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132886; cv=none; b=rdbG5FEI/9vSoq0jhmyT3Dg38E145Mk+DR9hTVt0UwkGo89RcX1O3NTq3P5AKTm0O/0Zus8RkBqsdWNdztRdewanfjgdAXQatHsEE2TKrd0j/oxvnpk8q261MVYddgU0kUBIO25gyepU+Lms6bxOg6wA9uXE5lGlLVmVyUpovuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132886; c=relaxed/simple;
	bh=vlc6n0wucwwzcyFpYrDIRDUbt+XJH5Ilzdk8lMP19vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRlJ2mH3v1hm4dI6xEL5Eow+Cnz2+PfluPoBMBbTWUhubXdsYEBE6/dERm1DrXjeL73YQGFKwcfwSBhsleYaA9i4e8bDbJZ3U1AK+mTEPoaftNTHq4TrVu9P4PihDjJ6vpZfDIx9raMAPUJAb0vIux7wAiDy84C4EeZnZHboBGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=lTjQ+76d; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="lTjQ+76d"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b779003fso24618075e9.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784132883; x=1784737683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vlc6n0wucwwzcyFpYrDIRDUbt+XJH5Ilzdk8lMP19vE=;
        b=lTjQ+76dDNnxMKnz3PquFQnbQNK9JgbYf/axe60O2u8ydZuUKN4pSytt+EDnGsZHuA
         OzKfU0UemRvB63LTTT+7stZEBYp2NMkGTNwm2bXm8VA0C6+8kbypAFRyDx52FbSypddJ
         g2GGA4yqno9RQ1gYW+M5nMv9vr2Go1rDDau5qhdlcsT15dsbKiiG1Fs69dUSQ9xhR5cq
         7O70yglDObYvz5106xA87W7i6+Dm6DWiAhV2zSNzlzK7gngu8r7YeHVDqqR6SI2xNTxu
         EZ/f4JBKStXGqh8y9San8O5ZNZL+q0LKAgSrjz3riOoRRptqqYjZetIjnMKZUQGwlwkx
         9xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132883; x=1784737683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vlc6n0wucwwzcyFpYrDIRDUbt+XJH5Ilzdk8lMP19vE=;
        b=qn1O7ggcWiBU9T2KkSrebuHj/lTi8sZyVS0Fs/A/LuFBbYLqg26oZc0/oPqaxuyA41
         2/WrYt1Dz2bovEEYjMunEyUqq/qIMx3QUZBwfiRANd0zTUZNmXnrTj4hyzC5xzbjOt8j
         eZ6et2TjxsptoKCnXBYyRFtnF6Z1BJNFw/rXXhYR+2KlCgXwkwWJDaXlVmhoaCnuP4fv
         RFO7NiVctHgqmwp7wonGtnmB9tgv+SgXU88azpfDIjFudPoWkb9WdERLls3zdt8oU+87
         8tdxH8U92dToB/98uMSeSqkbLnuXfwoWl3TYCWT51Odh2jglXfIUH9LNH1OpZFp7bgKC
         7TCw==
X-Forwarded-Encrypted: i=1; AHgh+Ro+3VYHp7K3o8ZyI7wSizHcg6xtRBdVNnrZd+tiLdf+uVuTVSND5lSURE8NwJWdl4M+KqDoO1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1uO2Z8CZCsHcbZwJx86WrGnwTRaGGpzfeTiE39mLKdiLVixr
	zeeeH4DlWx0fArp6QUwVRfbryGaSuPs/U2+YSg1U0yLoldUSKR7cfSAukhL/bEjl6ZrpkQz5GHV
	VbUSEdosz
X-Gm-Gg: AfdE7cmmqMxT2+VB64bRle7NHZ2XoABaCljkvyhUmb5TD8SwR8kDvvEg3qnVAabYz4B
	JXkAHbAEoHL0WqxCK1/kdkX8MPPZeE4EWuUWgqE3GntoXg7Qw+mQozxW/q34ohqJnWzgWhTdxFM
	JHkxAu7ZMHXU/fPEaAzdAfPVLg+pGmCCLBRrhd5Vz/hHKvSOsYxmq8jTguKMSt6rW/cv+TDlq16
	PRxtFEnE6UlKRdLcf9MTG4mvwLz6Pxox5nI8TRz7DGHsowmKsCEjBEr9TO7khrEWOL/gjfZu9uF
	nhVl4qQCtDQBPFtEAdhgkVcBIKyJU1kB8gyTi2OCZGEBMwWEEJ66agIYMYWwSG5hx0eYOwFC/Z1
	ZiWmSBCtrdskPd41AI1XLrkW6u3Iz2pXEEa43v/iETmivzko7cZVhhbqcb0VyLYnb0N0Rr+khEO
	abqj7rDuRSLkRo+ZxXkhDpCnqHAHK4T4+Aikk1O6anjiV1hzvqjiQJBxl0qqCxMSh/HkFevzKsq
	YGkilDkKCiiTnf2aJRekgROlvyUEw==
X-Received: by 2002:a05:600c:3218:b0:493:e81c:fc9 with SMTP id 5b1f17b1804b1-495389a2301mr50045645e9.15.1784132882816;
        Wed, 15 Jul 2026 09:28:02 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508731fcdsm142523185e9.4.2026.07.15.09.28.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 09:28:02 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>,
	Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: validate HT/VHT capability and operation IE lengths
Date: Wed, 15 Jul 2026 18:28:00 +0200
Message-ID: <20260715162800.1922-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715144021.GE56330@francesco-nb>
References: <20260715144021.GE56330@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Were you able to test that this is not breaking the driver functionality?

Unfortunately I don't own one of these cards, and mwifiex is fullmac so
there's no hwsim either, so it was source and compile only. The added checks
only skip elements too short for what the driver later reads, so they
shouldn't affect a well-formed beacon.

> why break and not return -EINVAL? (this in general, not only on this
> specific one).

To skip the one malformed optional element and keep parsing the rest of the
beacon, like the FH/DS/CF/IBSS cases just above in the same loop. Happy to
switch to -EINVAL if you'd rather reject the whole BSS.

-Doruk
