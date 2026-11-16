Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851951;
	b=tFveVPlagIOgf5Ogz7svwypYH5T8+oMjNqqFya13J1U3/tqGnHOeLQhY+pnVdvoFVy/p
	 /nIpV00S3HBTWc8spv/+37yKzNiiPyTqPShSolqoqHC1kTWrfRAczg40w3lzq944940nK
	 WlMHBk4GyNVubMCy41ZSzYp8rENyYkYLcGMjNxrAWDmW3tlPm4brgtCvxtTi0jaaZBdcq
	 WYqcd1ai8R2BT9BT+MPhCscfmMXRr344nSsDQRBNI4EV2W6bgmb79oUoGRtS9kLFGBitJ
	 g1KDwCZH2wGJ09dyBmRRMyf9583ydrqZsx5Rf+AlYgHQBAEvvhPJVoRBI1Fl4yWmT8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=MzIWkLn7LWceUnVUNfdJIKQEv2EZdc6qVOozRNgVcqY=;
	b=X1u5sfhYcf5bLCxUjRCT2Hz6gO0a7+/Qfarqol7sRyx9YfRWqt7+gmuem6Yzk1kzJx3h
	 S7cr8SB0/um9oQ8dqJ5xDex22DVea7j1tMlglwhU4+Rooe8uayjBkXSYerJWGqWoczrYl
	 XY1vuWByAT2DFyZmnuPsNQvQRKTgwUaLdNNqHvTyRNtHeiIfkMCx5+xEZxbtePpOzHo1r
	 uAJC26ZrBO9GfQ53BGtbqFgSy9uAKSEj7yfAWmuHcrPNCl+yhooqYCKXfsGZe8NcEkEYd
	 B1vbDND2MUGqS6kK8Gzp/LDG8frIKQZ5El3B5BAH9bUgzmAdqe6oQ90hqqCPbMfrJnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=H5xVzZXu;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03118606A335
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03118606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=H5xVzZXu
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-37071c0f42aso5540749eec.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794851948; x=1795456748; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MzIWkLn7LWceUnVUNfdJIKQEv2EZdc6qVOozRNgVcqY=;
        b=H5xVzZXuWyaYDxJHU0F1P5iLWbsxtbg01SESJ1nk51+cUzckuz1N6DeMkf5EtMIztC
         gnSWz3mFaT0dS8LQVH6dG7LWtfbiSOoPZY87LmFYDzOERM/N176NhXK99cTjII+Jou4Y
         vtZJ6U0AL9te4vpK3qKvHOouNcJ9ZACvhbB9Y13qr0La86IK0Sx0yKS15YYuq8y4XsLe
         mARBgIeGqvMrMVTsWyPzhbnfXVOfcpl9oBbTI75dPSP3X0tb+l1yTm1C0WB4wsWHb6k3
         Lcg346EN32sfhN38YE6SBHZKR37QWvN+BeQRxTNGk3SzZnioHT9NNts3Jm6+liRa4Bda
         B1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794851948; x=1795456748;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MzIWkLn7LWceUnVUNfdJIKQEv2EZdc6qVOozRNgVcqY=;
        b=aGeaVeNZ0QelYeM39PteOE0kg9LpdbuLtmy/z6GheJ/gcKlyrjNu9iCr4zMqyKN3ak
         siuwFXP2LRyBf1iltYKQvrFc4pJEVImZrM/QrtHnELJ/lUCN1bEfH2hNIagF6al/0ju8
         5/7FzhJAgnBxBou9wvQIud99FjWMPhg8zLEJYufIBUNlX5ERQtzGYZtgVxPX7KmkfRkC
         3s4cke1U7QwwyQ4cJ5P0M57UxT4tvqxMKyMCztbBszixk03OyD8VHTyxA3IbBRgCoz/E
         GrRHPER/cXqZe7FTAejI2Yv2LVlfhM4JwLmGMJLY6QtyCSyo0kfl+IO4I6r/8JqPWsOC
         RbHA==
X-Gm-Message-State: APuU4Z8E+p8cJ9A+1kXGhkylXEwhu3nW63THXvuDF9zuWBW0Rk3Y3auz
	9pDvqOqWzP3ASkHAkMo4P3twIrt/qUDF/f+FzU22cZCmxze4/TB+9RFBBIPdpKsK+Ng=
X-Gm-Gg: AZFdTZdIfwbEEJkbgskkbcgEDAzEAQqRgJq6i0PcWfav56vvCumFoz8ifyOylgxoytK
	YSqx665YTUkoD1miZqyWE+9eCvQ1UDSSNiKeE+jqmrLH7WdbYdfrPuJNbHYfCPhL0yVplpX0JvN
	DH8hNl9gGSBmZA/h1wPfkdkthxDag340cG2dNAfvhem5sFGKwtvM6LLlLfiUVBnIqZSH9KKR+V8
	uJFZjgd1s98uHiZ05jZY/0aUqockCecKPd1Hf16OroQ4Y6JLfBTbt5Sof+I5LUXMHVYLO6tBukR
	cepb6+1/ocv3SdiIPJv/B2SdHaGzv2sx4K+uJiLybuYmlQjoWD9t6kmqO6sKYmxV72aRLbvuNgU
	psJJYepFXJUEwai4Qhl2WIHCcOr9VdKsIUxDrK9oPU6RHEIRWK0Bg5nQ4t+9Tm/QqwAnqnvXpuW
	f9KlZKvfVJh9DfJJNh70XJ4OAJ9ACQeW0SbN6U328fyUaD23/6DFSLDL1iOAkPf32yA9iZ+5xfT
	JrX9hfVNuTJlN/pOV0WxucVxOU64rxPkIzH9EfQIOxR2LX4GHPjKvPZl0uVU+snwk7Xsih/gOjH
	dYZtiXn40QlWxRVF2sYQ2/L6pEkGDz61DyDNOIF6o30=
X-Received: by 2002:a05:7300:fd12:b0:369:a162:af96 with SMTP id 5a478bee46e88-379673164cbmr17242191eec.17.1794851947930;
        Mon, 16 Nov 2026 09:59:07 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795591f4f8sm35569496eec.13.2026.11.16.09.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:59:07 -0800 (PST)
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
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC03LjMueTogKGJ1aWxkKS4vaW5j?=
 =?utf-8?b?bHVkZS9saW51eC9tbWFwX2xvY2suaDo2MDQ6MjU6IGVycm9yOiDigJhzdHJ1Y3Qg?=
 =?utf-8?b?bW1fc3RydWN04oCZIGhhcyBuLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 16 Nov 2026 17:59:07 -0000
Message-ID: <179485194706.205922.3407440483109815236@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-7.3.y:

---
./include/linux/mmap_lock.h:604:25: error: ‘struct mm_struct’ has no member named ‘mm_lock_seq’ in arch/mips/kernel/asm-offsets.s (arch/mips/kernel/asm-offsets.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
                 from arch/mips/kernel/asm-offsets.c:14:
./include/linux/mmap_lock.h: In function ‘vma_end_write_all’:
./include/linux/mmap_lock.h:604:25: error: ‘struct mm_struct’ has no member named ‘mm_lock_seq’
  604 |         if (unlikely(!mm->mm_lock_seq.sequence))
      |                         ^~
./include/linux/compiler.h:77:45: note: in definition of macro ‘unlikely’
   77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:67a9daede976aa8a41462073c2b2735ae64a42fa
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  2a640ccd9d0b0927413e9778fa8970767b7d97d5

# Builds where the incident occurred:

## 32r2el_defconfig on (mips):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-mips-32r2el_defconfig-6afb3cac99c74e1a996191bf/.config
- dashboard: https://d.kernelci.org/build/maestro:6afb3cac99c74e1a996191bf

#kernelci issue maestro:67a9daede976aa8a41462073c2b2735ae64a42fa

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
