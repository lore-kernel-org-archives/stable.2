Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210356;
	b=x7jik9qd1X1ZIquwPWUcxvonICwXJ9YhUVP10f1xalutJ2UI1mwOUtv1UNg3jjN4+/Qt
	 yL7Ug67+iJK3axc5Qg5j19X19LMYPFav5TwMJmaCl+dWXTU/WUvEykwyNPjdV+QebJM8z
	 jOzISw4TRRWgJ9u+0NV3tghA09S6NMwO15kDSP7b2mG9MJCJQy0nvDZMOuP4jZiFv6t27
	 OJj7aEEmLSRDcBre3Sxt46eDri6rgZKcA3CJ+2VlkO+XUhz0dI+WSUdn2qC49aOwukOWv
	 PFrh/6AmDDHrJMo2DJffR9vWqzQFWYjdh0yPAqnacF6bPduCrrO61vn6WuBpL4qG32Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=GBinUKb1UJqP+yjgVIIQKpHz5wyZeqnP0j+6N604dtY=;
	b=TDUkepzUbjYBFiqAsh4s8//XSVISq5fH8uYpEpLaskXS5uyrL1ucMp9UTKLPehnfEm1O
	 McKCeSqKXmGYnJVMnroQgCt5V6+zJ3hA4OA7rtSKc7f7PE8YkMGOLNIuHyZ6gimz4Mo/X
	 rSkVASeMyqv48cHI9k9wGF1eMNgm54SQ5V4N6tyaqROfLYmUNup0yNuL70YSwhjajvV54
	 ks4os6UPL7Yhn6lPXacrywtG/BtrxABEuy7WT/6XeeO9QjdWS6+aP1dSjp/a2e1YOsrHE
	 NI8H9BQqTNcqxRSenl/u618H/5NFrWS6VYwqxie058BCcCkK4cJQqvGEZ0eM+KR9ipQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=VCvHsNX1;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F3606A329
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E00F3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=VCvHsNX1
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35829219da8so2935129eec.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793210355; x=1793815155; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GBinUKb1UJqP+yjgVIIQKpHz5wyZeqnP0j+6N604dtY=;
        b=VCvHsNX1a8h9seO1GFmAf1YB2ecY6gnqRfaMf9Fp0ahTh/5Qc/LeJ5g2ulVKMsYkCB
         RUuiBIuaLBQoZK8MrQV4Ursu7TFPD9VUkPJGBMoVs986gIRg2gN1Qe/gO2CypVGUMILc
         yfZYVRUzBThCLZ+ejiuQ9AGDgvbj0jfkUPVXGoFYeGUB+g3/eeAACPjHNaSCTgM4BopU
         HCFU60moGz0OfTn1SeIhYEQ7IsujPd6OuMHnOe9eVqyqBCiNMmmFOGxSncSCeQf7DVhU
         iWR027vZ8HM1wZ8WuyYiPpVKhB1gtPD+tleQ5SuZafn1OM7XHOikC/ljK5WbbpPJkZjt
         PzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210355; x=1793815155;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GBinUKb1UJqP+yjgVIIQKpHz5wyZeqnP0j+6N604dtY=;
        b=kI6TYN20Z8N2oJ7hbdOyvsWdFBPgumBMnGzKb2S5RtIU3W1CRDS2m4hrSbUf7CitlX
         4Kj/TcwqbwZVmD9AGPG+vztdrD3xl4//WG150cGkGG8i9CGFUieSmdIe0OqfzhnnqKr+
         2UXS8R91YMepGvQpneE8zuuj7gjQZHqs6L8aNAfRUnDVQPhVnIUnXLk7I895K34hksDe
         UXUdvsGvuW9twvxstU/fAzsfjPZWnymQ6vBfNjaR7uHyHb15/U9Oi0i5cLwdWZS25t8Q
         zSncLZcMrJfJuV186fO2Yy5c75CzEjWP0Cg8xwys67aoB7CqP+eRa2U/6UYTycKL1a+3
         UrDw==
X-Gm-Message-State: AFq9FYKuMyBh5liHk6qZAfoqxECkgWD3FsTDcOPFPFvqKSfet0Wu4p6r
	tvik+6pbZYcnFoQoxflz3CPZZURt6BmZ3LhP74OmMilPuby7xF+wfDy8I5VkJTGx/Tp2zce8f8N
	rCO1P
X-Gm-Gg: AYBFou0rNfCn44cajOI7h3afg6mlkVp+yejmI43MjsXuFU223rosFrJb54XT3yIk39T
	wwJLpJB6HTYU0hSZl4mwHF36sdI5R6XaAfTwJg+UA80RTqAQXGekufLIAN+tgtq41daqMrn+ris
	VWyw3Ximm/F3uYSjU2rB+aXU4szceoIF51LZEKuXzjQDFEvZidbeZVOi2n1vb+TJTaVL57lLB8M
	NoMNAd11NfqIUv0HjqL5hvpQkoeuSSptCYxbWEtUxgGYbHsJhAF7ljiPbSzua5NFpyOKwQ0Q1mq
	X9IeKo43ebQX1DR4efh+n837dEpI9qAufUz1o+uIPvYJlkPijdnp0Xp/Vnoo//pybVoL9Pubt8H
	arne/Kr9dXCZ0I6an9jE2P501NuGDGVt2aMBWUL/xyHyD/ZsIW/ldQMX6xTj704qcyeyjIaYl86
	mH7K8ql87/fml0K0vfhzFB/743EvEhVx4QZSroQUfTI5VhrHbRxDeV66K4fnpgs1nVomGIqHtZ/
	Cq9x6tSTjsbW9I82NCBzR1QIDLqRpNc5u4+jspC7zOUV7an0G+Ns1mgfXxKxvBuVKKK9qykygDn
	298qqWYjH+USd8oPtttd9Q==
X-Received: by 2002:a05:7022:42b:b0:19e:3464:ce40 with SMTP id a92af1059eb24-1a941feb674mr373816c88.1.1793210354154;
        Wed, 28 Oct 2026 10:59:14 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75fdc1031sm7344953c88.19.2026.10.28.10.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:59:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REGRESSION] stable-rc/linux-6.1.y:
 (build)/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit decl...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 17:59:13 -0000
Message-ID: <179321035315.43309.6852840306455965382@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration] in arch/arm/mach-at91/pm.o (arch/arm/mach-at91/pm.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
                 from /tmp/kci/linux/arch/arm/mach-at91/pm.c:16:
/tmp/kci/linux/include/linux/highmem.h: In function ‘memcpy_from_folio’:
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^~~~~~~~~~~~~~~~~~
      |                     folio_test_hugetlb

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:bcf30513ef8fa8e953eb76805ee4ebfe8e0eb10c
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  406de00ce2971abe3010eaabc26c71e84b4ee9b3

# Builds where the incident occurred:

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae228785c0836a8c2f04750

#kernelci issue maestro:bcf30513ef8fa8e953eb76805ee4ebfe8e0eb10c

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
