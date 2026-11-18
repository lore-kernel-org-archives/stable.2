Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018064;
	b=WzyZTeTz/HuKnIfVi87Bz/z3qBH6VZ3J57+bbqI089QTqrfMc3jtXGz8diZv5EjWS93p
	 7KX0guR+ZzX87MYFVhx3DnPy8rNXAiSOEGfro1Salwaa66ebfHK1lqR9eb90tV7cvUnUw
	 rDThgYu/UketczgzGP28EC010h7ylEz9i08uyuptGE9vdqc3NJIiMEZVn655CE1JJ4moh
	 IiL5kn4BAPtdDzmUQ2mx9LL7I+Z2KcSaSNHqcBUpEpthB1moRn23Cjq+b+zdxritEbj/K
	 vjj5TBBmSB9wmvtxSF545CjFuV0wvycCWlfRLtRpBgyUCcbacCtz3QNxToiV7rU8T0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=Daq83ZrmsgMu0hFMnqIG7pmefbD4GjLgNHcMc6rgY7Q=;
	b=zYX4WDo4qhVU+JrW252PjZ5ufoMKXMLAgSyS97TKS026OlOHn3xqazEiF8xdPgmTVp4o
	 ABVpqvnUBVssZlCumVoUY9/HL8CtqhYFKZdpk3kSHTtuywe/Ed5ltbL3YfGvdUPxDDS2c
	 /yM95Ck+j9AjxZ02VldYYQQgMqtEXbkkRuOzBq+NtkBceOcnuGI8Hy9d7VY7UYLfRN4Pb
	 ekOP6wbybJWJEE2G1qz6q5prXrJLYFcPvz0yz4/6xDh3sza7ClkjMTQCrpoi1U1N58pu1
	 C2w9tD0JFUmyYXHAgzLGcUKvMMp78FcneT8gna3XivdOKoawmhpcrWQ4IyKr61b1a6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=D2PdDMAP;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887760A262F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E887760A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=D2PdDMAP
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4ada9579947so682653fac.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018063; x=1795622863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Daq83ZrmsgMu0hFMnqIG7pmefbD4GjLgNHcMc6rgY7Q=;
        b=D2PdDMAPMDy8UNJuMaPlzqLIFFNb7Ja/2WtNZH2stvVdL0+MsOYWG33s8IMzKVzdXL
         iq6Gb2+/achS+nqScVdDn+xTrPTybI97E+ZAI16eoLeS8xXrIAZLAYgpvaBpgOpQ9e4c
         AlwqlaJKHuj62lF6haPfdjua6nI3KGr7pCUsDM/bNYNuw/Fobp8O/tVyL8zjHzU3RiPR
         0ur2t+i2Gla48dnssTsOWpMjQPw49CCymhgj0GdtsvXFEyFdk5TdUllnhHD8Q+y9qsb0
         vdP4ffyyAjJRh2zfAyX070/Pa2PMxMHH3LePxvykBYHTzs73zIEr3rP5hMUnFxvw4z0s
         oU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018063; x=1795622863;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Daq83ZrmsgMu0hFMnqIG7pmefbD4GjLgNHcMc6rgY7Q=;
        b=wr8mnZi1ShJf+Ofk4ijQA5N1404TpIcrAN1gwiW34QNyIrezZAkq+fD9hNf83hszYb
         srnqboG316FkAeddX5tEmZx5XFubysEMgC7SaYWYAzFWZAc/wZkmFI+Xb2zMAloU3+v9
         555T09p9lhMesDDsNJJnDWw6I+oua9Ye8F/QLK7GkSHto5CeoLATHmbGbfXbX4626lEd
         vmNg48uBJ2CYIng0DDYdvIOnirWG1cahzGFpU+0HZl+XS+hTzKzCeNpOpGg5d4cY/70u
         1SJVUr8qBMQbad9J5e4cAWyymiMiRb6CP7w1ZIGWMHiGv+l6g5B81aD30ZZ9QZ8oEzJc
         BbAQ==
X-Forwarded-Encrypted: i=1; AL+hErFpnNnRovCs2tYWBJhOrd98tPJRo+b+VoHYeimT7H7gBqBTbmO09J8mw/DZe3KauxLw5MxD16I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SiedKt5pVV3TZpO7hasyGRDHKpgMJSFpmbXfiLWrdINyJo8Ub
	gobxT7a951xkN8ueyR4k1bolN/NQW9R9FjnD5v9Z262jlhZj/S/aGln40paKa7qTi7I=
X-Gm-Gg: AYBFou2RPyMtug9pDpgrsUYEc2RkhZRQIokV0XLKxrFqwdcdG9n/SNSsmYn4MXnMRku
	EQ+lc52c+IXKF9U8H0KIyA/16gHyccbKT+9DslI2hfFurpYOjuThotjjGS0GZ/UeV9w0rd0xtSN
	6fjUUf3BhpRfOT3LnozYrydJ0Qnp0Ey4SQrFVB+M7twPJtGqFqAYCU9CVh+Poc4WTrGUrCS/r9F
	r7JXCuhkYANXmDcM32Vj/30fjWCNrrO/jwugi8DOftW+2xSAteaCWMCnEbRofOPihNsNEaOg0X3
	BphchRiAGXndSPRhfE0+Toz2KzUP7vs4zw514wxWP1yLg9F6VZxOgFr2MrTAJm7ja9dmNqaXgaI
	gs/1ymJBdotldTYmMD8GZ8egBvxiq5gE277Ia0L4BM8jFoDjo+4wZ3f9LIJvaHX0PMx2MAzDj92
	xiccLlcx1kLPcLFHBWcoPmW4iVrLYJ3PMneyljddPPf5TSzcEFJJMeohBEC6AXBO0IkKYqLDHIt
	2GdFPoUl2q3aVI8A9Rz96KSIgDDHeY6TIjONtt4fOpOv5/KKDVkB8a1UY8n+OTz8kinyV5EoG3l
	+csbmZ+On+xXNWglAYy4RBchRfngXl3tVGgcxylXtJqKitxgT4iumHgL5HLkEl67mt4sJEIgWLA
	6U8TLKqcKVoZH8MYEy/OE4ZVITh2CoxHjAFDov+avFwZKox349e8=
X-Received: by 2002:a05:6870:aa89:b0:4b5:65d9:5bbf with SMTP id 586e51a60fabf-4b75fd1764fmr2554172fac.29.1795018062902;
        Wed, 18 Nov 2026 08:07:42 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261115003347468yvY7EkDVXpRQABqNYceKf@zte.com.cn>
References: <20261115003347468yvY7EkDVXpRQABqNYceKf@zte.com.cn>
Subject: Re: [PATCH] partitions: sun: calculate partition starts in
 sector_t
Message-Id: <179501806201.17649.16236946055978931642.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:42 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 15 Nov 2026 00:33:47 +0800, shao.mingyin@zte.com.cn wrote:
> The Sun label parser calculates sectors per cylinder and partition
> starts in unsigned long. On 32-bit systems a start above UINT_MAX
> sectors wraps before put_partition() receives it, potentially exposing
> a partition at the wrong location. The same label is parsed differently
> on a 64-bit system.
> 
> Keep both values in sector_t and promote the first geometry operand
> before multiplication. This also prevents the two 16-bit geometry
> fields from being multiplied as signed int when their product exceeds
> INT_MAX.
> 
> [...]

Applied, thanks!

[1/1] partitions: sun: calculate partition starts in sector_t
      commit: a5be44a8243fd7f7875f54ce1c5df3df713257a9

Best regards,
-- 
Jens Axboe



