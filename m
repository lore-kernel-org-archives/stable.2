Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011300;
	b=g7KIPnXKG7gxPAiHCHyoLvq43sFUg10nTCy65jc9yoPv9FZwMYTqut7DYVgqn3MYo/K1
	 A/Zrc/pr6fs468sQG8+TZrCfl9rltwtVrlq8yuodNivRhEsY5AN1uVn2oaxzxcPmmDk3I
	 2tlV+DpejkTsowF8HZsj6WLqNEZJR0fyBZPa/8nyS5iy+jguFtizYKYS9zRsWdszR71N8
	 ih32hUGX0+ev6/tf5/WuxHmVjzkrxwADIsHP2QaCIWNVyK8QUr8VeajZLzMeyDN/TRl2m
	 cJyf3uf9RCYOts+Y+u+SLwv5lTBKgORL8CXWRjYywF3QrXe0Fl9y4wn6+JV9NnnFWTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Lr6L+cYeRUIJDJyNctOopXpHFnq46QKdQrQ9Ke1StVE=;
	b=sabHnd6oftGLDycH3/ADrxPI1DMz/qj8Qy6dhIkuSMyviCGgOPdCL0NAs9FhLoXjHFZU
	 0oMw2SYMerdFEBQeq8MHPC015u1V8H3sQDpLhnlk2nhxBa7EW7zDwuBbYPsquEkmhIINf
	 14vyLf6lgcx8c5DLcyjnbyPim4EDX38dqvMU8OHURs9a8EvrsSaQKdW64f5QjUHCo8QDp
	 UbpePlwuJwKL3Z/bk6dsrKoSdQrV8Gg7A0Y0yiDffFhzd3hJ1iJk1z8uOwnrKmzTtIZye
	 9q1TsOBkpTBQ+SQ5x7nSi9Y76HsdhueK3XKijjSPoKafXsZmb8gU9HgCijTZVM0jmLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Owut/OfF";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF1606A338
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ACF1606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Owut/OfF
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso517561f8f.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795011298; x=1795616098; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lr6L+cYeRUIJDJyNctOopXpHFnq46QKdQrQ9Ke1StVE=;
        b=Owut/OfFa6E71kOopud76C/B5gBb9b7Sz2N38c23akPgcj6Qm1z+UL6sXme/0Pao3y
         qS4qK3drbWZRzdMIOMD3Ih+B/ksIu5sHIXGXJ3awEe+oVHABGh7Pl1junppwjc9V6JUU
         XUC2c2iM4q5RsoR3otxYFcLvEf44ROR5UrM3oMCdh47tpI75gQWnR1BEmTYncyFTWMAR
         /DTZowrkx1xO/gJOZeatRIGTjkmlIcXXfK2FyPbu+JL/gUBrweFoMclDqUH9W+l6Gcsr
         uFAxy7rxyNCXq1t7r60B+8GEkFzzNLAGvUqiqkXIftfcWbHwZJHYoMFf3FOQe80lmX3V
         zuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795011298; x=1795616098;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Lr6L+cYeRUIJDJyNctOopXpHFnq46QKdQrQ9Ke1StVE=;
        b=EqX9KLuNU8FOtyCsmjGo2bUjFmWnRK8/Wsk6Y3NDNRS1sIyw1zfy9jDFhZDykTLC5Y
         VFs3jVXaZR1pOQddOmu2KySucOeEm1cPPNaO0yRGsAt7WoqknqDsJINw5m7HtKuJ+IUV
         RI1GCF7i7jsT3sfYOo9++tzHk7VBx1ZeskRnJtQfytv2pKbcFQLunNWFH5uEAeSoGT/z
         8GwlfTl7sTNaBn0h0PaPa9C6Sr+7ZlCwxYaxjrP4xWnqLunSEgAcTsVu5jUfJWH7rLgz
         EO2IU1rzM8wiuum2Xp7SC//2qFK6pHJEZ2x5j4ykb5Vwv5rjK2AETF++nXmORWCFIt9N
         yQsg==
X-Forwarded-Encrypted: i=1; AL+hErGs9OPAFfLIQqSolvkS+eGi7THy1npqXTtaT8gEFkThZZODAQnr/6B2tYXZZqLMIocRrsTviXI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cdcBa4/j3vwIJKgY4TXZX7ALPE6VgR78OOOb2A56z2zHkUcrx
	qLHxvMgLjepcYKt/7j5gZPjNZ1QG1TwJbpDkz5SVheyjQQM7KuKVoUCq
X-Gm-Gg: AZFdTZcVHuJ/GHVGV5O8ZIwPog5kUsvplEunYhdmN+t1QW4l5RbvO9GViBl1r7Ran7U
	hGSIAeioi62vbFev3ZQAOMLKgBhPO3iHyOB/qihF4Ck2UfkbtuXcf00ojIQ4hD7dCvyMfiJg/9g
	cCaeSEc+O0Yy9T7pRYwkOuqo5cGfvev9EWPJuCAM6VEP30PZzPNMFIOK8ga8HkVkWNIi7E9UtC8
	kFq64AgssGjJhtpT+siOr7MeWlxiGuVEd9uedeIKQo29r3v1qYu5etfKe2ZdiYHmnMEhZRBBXwS
	rRx/AdtPZ7XJabMuHpk3Q55CuZAQCX2P+l4+3mzFHe24AGnruzhZwxKi3TkKDzpsAUpHM+o6u/B
	EeE2ax/NvwIIX/8QlfC3+Dtru4vhDORf93jVEb85KdiiyUqGCBvOQZr6kwpvxTTr1vTC/84bu7+
	gy5nb41sfXLrd5Ice2bSXQUhWeyaab94Yz2xDNnzW7m2IM/ZLQWtRnsT5wiOTAJ7jV6v6UQaeWe
	heVzXrzMQKY1Xand3xz+jEGk4fRqB/oqUT7gn+WzMQD7nSTL2j4YoneAkRt0pCagXA/IFXP0E1N
	LEhkRhl6c0dZ7iN1bT90u2aI2f6uGwjQsj/KOXcI1N2qRgQYY4xypCDi/AAAaFxAK+Cw5SimvHT
	fgipT
X-Received: by 2002:a05:6000:4812:b0:48f:bc05:76fc with SMTP id ffacd0b85a97d-4a63c657f66mr5381340f8f.11.1795011298295;
        Wed, 18 Nov 2026 06:14:58 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a6569338acsm5108876f8f.45.2026.11.18.06.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:14:57 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fuse: stop stealing pipe pages into the page cache
In-Reply-To: <20261118135359.6256-1-suruurism@gmail.com>
Date: Wed, 18 Nov 2026 17:14:54 +0300
Message-ID: <179501129496.10449.5445396291756842907@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hello,

Please ignore/drop my patch "fuse: stop stealing pipe pages into the page
cache" (message-id <20261118135359.6256-1-suruurism@gmail.com>). After
further checking I found that this issue has already been reported and
fixed upstream by commit 80beb226de50b859913a55be0d6bff9046662294, which
predates my submission. I should have checked the post-snapshot history
more carefully; my patch is redundant. Sorry for the noise.

Thanks,
Abdifatah Suruur
suruurism@gmail.com
