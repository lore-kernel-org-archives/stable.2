Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95173D2FEC
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889838; cv=none; b=H8J/lcQwXyGIXlRXzBan90/89xuNGnl4eLFKKRTUSay22lsqfiLgD2CLJUCwPaPIOVT1O98E0bStvldEOeQGbdnoJprBrgWHNQF5lZZmDCpp+LtOsgD69dsDSKilKtE1EP5774JQeQJKXPFYGKC4sR87ssgPNEgchNFH3GZxnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889838; c=relaxed/simple;
	bh=UAd3pyrjYJ79zz7XvVbYN8zMVTiBQfNrye9emGFKP5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOvZTarzo5k5F00S3yAW8XFhltYPHK/5KtirSVXT1cU1s9p9A1Fg9uBNpK5wQRyMrw9NjYd5QugUMWEKQ8STlA3RQgU93a1+fhlfTFHejUijLMDmDMY/LbeOVD1ZyXauvixv/PHsXvwG33J3aEY5wXrN3o2fyX84XVkv1X84VKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sVaAixj8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVaAixj8"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e762768f3so335924085a.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791889836; x=1792494636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UAd3pyrjYJ79zz7XvVbYN8zMVTiBQfNrye9emGFKP5E=;
        b=sVaAixj8n6mW5lttIFrdGDdfQ+taPo0y1Euck2qGQ8pdQ0cj6+cacTSUeItSOqO/9A
         XoJ4ynr6L4HjuRs/gJstu7kpOc04QIJhcw/CbvV4qDm5fCnzsHfDJ5IeZPJpJanuDn+P
         +Q27ImxuLdauqZTGt/idPeKMtMKWmVVrOznXR0NVqzWvRfQu6LoaRxl2+yWR0Ur6lt/E
         83MQqUfFwwrk2O+9+k0pZXRfExtWWVV2o6EJXIs3HJSn0DnGtZj+2iWL1R4FL0kQfCVo
         RwPzYAq/mlKCDs7wfc4MtQjWfd58GKuMmr81JoXLVkGl4OQu9CRZu4M1PqKYoFkwD3cA
         Wf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889836; x=1792494636;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UAd3pyrjYJ79zz7XvVbYN8zMVTiBQfNrye9emGFKP5E=;
        b=DV27/7hqdv7j8b0woyMskXygCxAPE+e6cpNpOhxFBi0hRDIhOpNCXCXQXwweNsrVKs
         stwiXvfLuU2mOfVrkX+T+bky1b5Nk8GqGYlXmiKmGMzevPu9EQia+Q2wCm+hKtKtG5lA
         xL1hp/MzK4nkH5N+V1BH5vsNqpSGn1oYeB7RRL6bWccN/eadpwG0e4dT9ge6zvsGaJO8
         oeeX+g8iaOJo3UTdQLHOaP0h1TyE1toZuxT1jD0pfRRK++IgXTy5B5KlCxSsMc8k7DzF
         3EvGfYNxdgVT5bdjL3lFA3sKc+egO4oFTzDnRPQPgha64fWxBQ5ScTDf3+yBWHOAQNWT
         uqDw==
X-Gm-Message-State: AFq9FYJw3zIK2vOTcicNSkr/2BwdZp5Kxx57ixdYuDC3aqyYk6cKphq4
	xhTxjP26aAasRs7L4Wvkp9XN1SVyynmlN9xOr9fIgd2tdop1GIcwrw60
X-Gm-Gg: AYBFou1WygYIfgVk7wFh9eseiO3uN6jKYbPT6140guw5u9tcTH8HRY/sL0LTu4cNp37
	V4KzO3dHFYE5Tt2iTw0zHbz6tlwF2a1wCHsGiOy9i88Hf6JWoSZFq+CWpxePY4rviWp6WVXFp9y
	xtAZqteZDQV9JbSDwshOjbKKLsZ0dnvDBvRJ16rm3bfBBe9fjAf32q5vJApeKuszaztMF+b2TfT
	sBApiFII+I/i8LlDVeVp7hOCcGBIzUl4atRP1TIwpOpjw0voaD6OP1pwHNPUPtklQpITTB0S85f
	yca088hKKl5HL1Y9mKp4R/rkXEEfhXZNOJuzu9eNzxJEz2oScdzT1lFQeAQ8bG2KgZvcgpWgJ5i
	KqDc+ESnEjuwNtRIolgmFjNdXloXmXhushCDaFA0GBT8yNbZhsGCd4soM4eQwxr+8YHS1UvFuCs
	ksHyxOa551ytIzeDTftUoV2sXm4fm1jNaVfXLZBSoDyMBtAyXxJkYPx2cyP2y5x9krGGtUmN2rP
	lTu03iE5gQHkFo9fUlSi5Wt3lQYhi1Bx7cH8HNEsAIvxrehg9D0wwyGF8zhEL7fBLj9LMardQ==
X-Received: by 2002:a05:620a:4515:b0:93e:9171:b72 with SMTP id af79cd13be357-93ebd27ab18mr2002162085a.49.1791889835669;
        Tue, 13 Oct 2026 04:10:35 -0700 (PDT)
Received: from server0.lan (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef502497bsm212394585a.17.2026.10.13.04.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:10:34 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Gao Xiang <xiang@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	linux-erofs@lists.ozlabs.org
Subject: Re: Patch "erofs: remove fscache backend entirely" has been added to the 6.18-stable tree
Date: Tue, 13 Oct 2026 07:10:11 -0400
Message-ID: <20261013111011.2814836-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <as3drCZLoTUPS_oC@XiangdeMacBook-Pro.local>
References: <20261013020044.2527207-1-sashal@kernel.org> <as3drCZLoTUPS_oC@XiangdeMacBook-Pro.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For context, the original bug I found can hit both 100% deterministic
local DoS and a textbook UAF on kmalloc-128 slab that requires timing,
but I don't think an LPE can be ruled out...

Since it is reachable by an ordinary read() on Nydus or others that
enabled ondemand in Kconfig, I think it is worth thinking about what to
do for all of the pre-deprecation users (even if it's just comms).

I would defer to Gao, but I sent a minimal fix in June that can
close the UAF without any other breaking changes.

Thanks,
Michael Bommarito
