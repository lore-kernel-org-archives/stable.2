Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4634C36729C
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241549; cv=none; b=I/pl9uWzCqKbGzlXIRNH/dnj8mLUzpecSMXOsu+3Cgptq4fcFKg/8dea/Mu9NCUI9f6zDRGaEYm6txOuE7cuTA4TaLyo1tY/JFcbr2wqP0mcf3O+YM4zJVJQu0ktzRE3Wb9ZbFDOi/9E5+jjXNAMmZmzSV52AAjF1jMihzM5PAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241549; c=relaxed/simple;
	bh=/+zY3OBdYB8GTo2YOz8QusBJIcoc0lHZkphRvMTbBtg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=ug5Zg8kTLbfb1rstwIg8ixqgvsytyNX+jay+PU4bv6MxOIXkMoZt3+U7PoWhbpnHM7PevGT0EP2+cnX2e4OhTaMvlhEd8j8EndMBPald6SiICywUs9q7c7aoiE5jKwPOeV1RwFoNydomaqVSV9+Z6M00IYAzfDIEfx29P2nMxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=WHBXJrwF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="WHBXJrwF"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab973140bso296935ad.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787241547; x=1787846347; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dVhF16cuPembEZ+aN8vR1PQZBFSoMQlLc599iTk7aG0=;
        b=WHBXJrwFwSWCxHXwKijTIynsV8/rrMZE21kK/VYvGhPJqo4hKTijpHJsBvZa1GMR/H
         S4aHYcgFpvNFXLKMB7uR3EB7Zl2L8CT80ZOj+L43HeqnkvJ5MfW+gyJYGf7O0AJ9umIL
         449ThBJXbgZDQYQ7ZcgVt8Z7NLwvk9sfK0f9CDT85C6TvnFMpR8mkh12K7fyXBtBl/4u
         qLcxAMQBcQYElPLMWhAgLPKotuiT6f4RfdGnqT1ZHCLjzBmHRb2aPhZVylDjQR3ug4Cw
         kgdyfB2+QrDPd87u/+enJyuKrRE9nqjid2n9SCnBPFdpdvPjC7IpyOZqgnjLdgW+Wedu
         ujSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787241547; x=1787846347;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dVhF16cuPembEZ+aN8vR1PQZBFSoMQlLc599iTk7aG0=;
        b=D+jRbVdAXgHNAABFCFQqYiMYsRTH2uB0xgL5j5cA/oKcRVPwuXsObHwE1s7vwfCsfM
         JJ0kcLjlaQ1f/6DtvYTNqTb2tZo0NTbG52BSzTpRXclgj895UG+6a8Mgb9wlZz+Ad7Gs
         MgrRx9cSnjEPylBQzocByIyckppWBkYXZnqT4XrXZAGzqmUqVzRRb33f5CcJVneijMTy
         Vr2FkQjMTl/Q/8eiFx0W6+xOWI4L+vsfNgo2xpPGkBVyY6DuJpmHtZC3BEnvkGLTeERx
         rh56tZn19yCfwydmr/tIWt74PLRNngFDozK/RLe1hm82l5amexPj+kO73EcZYO3l/237
         BVag==
X-Gm-Message-State: AFuF++koyobVoOfJqE6X5cpk0BXmx+TUBRcwBAx+86dHlMhCIQMLJzqp
	ZVNTYumtVoChkTsrPuoTqmWsV3ZZdsLWhUEOb47AI0JYhl4FyZ8yzLYfHNbozeCPPfexKJ+lgzY
	UcK+U
X-Gm-Gg: AR+sD11DzRPnDnT0iz9B/ke5GsbrTZutUHpZlev248zl+K0uZ+7y2nBwbhRmOUUEk2W
	kWCW/RenfFNeSm7z3FUQE5DXFtPEDIZ8Ly/ZTVrZb1BVCCsjB/cOINE0vx1NzvbGXIe4BoY9geo
	DuTy6Ke+b7sXrKoSxYR5QjOGd3c3H8L/5+/7xsRMBbKy+PlUrTyCzJCTlAoAsjlOzP4r1DjPyWg
	n0YbTp+CrMHc+e/tptcCusbenKM4xC4ifxSWyF2wdaLfxF/9tsONMGsVNuwjL1r2c5Yy82Ll5Iy
	AHQAq9ePnSdjyGzKYu0ykIThVQb44JWBsXpzq6+RNarlPoaAuvZ3wpqC9VHHj1DdUCV6TEXG9IS
	Rz1m1DrmcUUZHqVcSRidGJF65N0recl5tGnggBthp+suXyURjvnqeOuZlR26bOR/vVNMgFILyx/
	36E22rHSboOwULETQrvVfTGXFnTLJgyk2PHoF3IyzPjMhnGJQn+F9E
X-Received: by 2002:a17:903:1b66:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2d601763a7dmr261200955ad.14.1787241547474;
        Thu, 20 Aug 2026 08:59:07 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf1a1de1sm19087104eec.31.2026.08.20.08.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) assigning to 'struct
 nft_pipapo_field *' from 'const struct nft_pi...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 20 Aug 2026 15:59:06 -0000
Message-ID: <178724154561.746.1810558119709747974@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
 assigning to 'struct nft_pipapo_field *' from 'const struct nft_pipapo_field[]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers] in net/netfilter/nft_set_pipapo.o (net/netfilter/nft_set_pipapo.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/net/netfilter/nft_set_pipapo.c:547:2: error: assigning to 'struct nft_pipapo_field *' from 'const struct nft_pipapo_field[]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
  547 |         nft_pipapo_for_each_field(f, i, m) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/net/netfilter/nft_set_pipapo.h:85:15: note: expanded from macro 'nft_pipapo_for_each_field'
   85 |         for ((field) = (match)->f, (index) = 0;                 \
      |                      ^ ~~~~~~~~~~
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:8ef3ca96d72087f62eb47fce3cd36f95e993222a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  14df5e0143e243ed3fb811cd7bfdcd730f29c9f4

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a87118f62f33761c0f0b4a5

#kernelci issue maestro:8ef3ca96d72087f62eb47fce3cd36f95e993222a

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
