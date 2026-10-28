Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210347;
	b=K2TAHrP5y7+4kd+lOdVsc+0ttq8ExL4e0IZatC3KpzUQKyUdBEMqoajHLvDBQ3t32sxg
	 EoejMWgWkBBGhMf//HmmzgNHfG5z4B/+RreyDIcvrqdJdXFHEjIEsiHvFJ2iRwgBpzOD2
	 mfo5uPDOmpNAFFO457feEox5JvS0RQnKIRGBUGf7TrekzNtmRkOZcJImsV/LhSJUTqPgi
	 f5mIdxD8ILKpZs8b/azU0IxY448befyRf8O05StEcAdEg7SlITBQJq7KkHxHPrjlN1R7i
	 ov0DJ4jn3pyLHGgBKQqEdSe1gx+YnQXpLDc8ocamQAzsxllQaCVs0xIKeasx+7gB65Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=SnVYEbvwsNSQmiu+vZ+rpMOaEIYSL63cLX8ppYdNFzo=;
	b=z3buNqo6CIVEs11yF9Txwe/c9MM//ux8KhLKRwzi+gcAla2YYAHinuHwVtYQfqlQ2LAo
	 B24oOWj0gNYxy/ZE+c/9h08zyk45P3aIAVi7aW9fXwhMuGxFbswi5pGQbJ1Th1okdrbtC
	 YhCFxeHLg1L4geeuta1bVhjLfJASGwWw6JhiSXUMsBX1TByVd0ZXJn9szsxunE5KZEtvw
	 xU1QjZ0YAWanRRvZKa7+KO8xYYa+O/Upng//huFX7svhKf9YZ9+j9gm4PkHwc83imOPla
	 uNfxMzmBZmVwD8kA3ARaHDYeLlfiojHOv+PBsAfvveuazLQP9bFISJK/q2AQIpL/6oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=F6aEJTuX;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C7B606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C7B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=F6aEJTuX
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3282db206d3so1144821eec.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793210346; x=1793815146; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SnVYEbvwsNSQmiu+vZ+rpMOaEIYSL63cLX8ppYdNFzo=;
        b=F6aEJTuXzISB0h5d5T5TkZLuiwZXx+hVp7Xm1mF7QmormrF8FdQhgfhJq1eZRwG8IR
         OJz3I72gmLjsnLSMLu3R+mGkzlBL11O8aju5kjJm22utwUOvXNgiaqEMe2WaJO3ZoU/J
         AC8gtYfIYcD0xv0BjpoNgGPEiupWxZlxGpcWrTARYaBJ0y6dVMy8bRkiOfyPB2uk4lLI
         637+RUajyn6PA0fxQ8gLlQHbJtnO81L61yCpA2Qs7DUebUh2NeU2qBJs1IB1kkaERFR1
         yOXy6IBPvoc2uLuBygfygLg8rcMu6LRYbcrxKz6VAgkbpaft3c+zJNY9130G3EVfsVtu
         eTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210346; x=1793815146;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SnVYEbvwsNSQmiu+vZ+rpMOaEIYSL63cLX8ppYdNFzo=;
        b=VHy9z9/1f+euVcBOnWxs6uIcjc7tg5FiWHv8HcgIX3/0+N7B52iKzipmwTQqcGWRkD
         AthVs43elmb8B8Bjszak4ZT6421KPoSaODM62EYlr77fLowgnMMcCPw23FXIKvD14cwB
         pxff3GyIv++PRtGaZQhIyb1pjoBBKoljb+ctPU/hUkk4kTsaJYFhTW9BUcO2GGiDbq3v
         jg/qbA5CFbbcvbALvav3JEF6cn9TDZ2OTr+F0G55KRO8+LddYRTsHyRajBcBoKBHct/+
         0+y0mmZgyj8R8Q9XPNIUB0ZVWjSkTnkDVQkDDplBX1Njv1DCm01I+uw7Q5WBpGLIbfu+
         iR6w==
X-Gm-Message-State: AFq9FYIBR74yrfDAzPIHnRCAvmhUMJ2Zuzu6UQwnNjvUeTHuQbKb5H8O
	I2EuvA24GAJZyl5QUqlu7tOTnd3uaL6DihRRdgMxDcwX6TW+pjUy3q81kGmT7SYl+Ew=
X-Gm-Gg: AYBFou3e9rHz/agLxlK4FN3+tqO5lCidnphr2KsG+mpX5APmPdB1yDjNB3UHz19uw9I
	VqcaJ+UgWrWgIDTr8LKrWMQXKX31sUJRYbnhYhCNWXR6pUct9FYN+s/lApPb8mX4HsX92jXtK3N
	b6o0mU+IhNEa7lFkB7MgA1loJObYgnVbIo83Mhz2E/2tQCsMCQD/F3tfOL+DbV/QJQD7zkI+Zed
	4rSIoocQrR27A36ooJ9BlAu8YI75qU+IJAKCtpcdIigjcPRInKORbKxaP0gILM026cQAw8tHMFM
	u6RBqHQDWC9/3tgce+S7nIOV/BxdgzR4t/dJyYHZJv2iRSVw9bFiDWIFsvMe2NRucc2l2awgGZm
	9riZjw2hgHoSF3AJpWKxIjD/jDZuti2Opda6nY+jxCnsxvWIwNqJuWdUPtuEvKT+ArsKU6kz1O7
	sLCwBODeWST6xIFjraDqrvvow7R18C2A2avr/BlROxOjlwSGZ2QLAn/ZA9T+q9Ox/YwYlHcBTBr
	Voo7kIKxqAGWmOukIFoS6DGRjRAb26icllqdkgSOGtMB3Qlnb492Ges2pDQENBH0vjY4kLPID7s
	HkeALzO79VZb0wZ9WdnawQ==
X-Received: by 2002:a05:7300:cf96:b0:368:2548:c078 with SMTP id 5a478bee46e88-36a203d36b0mr3936484eec.17.1793210345562;
        Wed, 28 Oct 2026 10:59:05 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238d9c14sm7920930eec.7.2026.10.28.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:59:05 -0700 (PDT)
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
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y:
 (build)/tmp/kci/linux/include/linux/highmem.h:427:7: error: call to undecl...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 17:59:04 -0000
Message-ID: <179321034405.43309.7676621121049933717@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
/tmp/kci/linux/include/linux/highmem.h:427:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in init/do_mounts_initrd.o (init/do_mounts_initrd.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from /tmp/kci/linux/init/do_mounts_initrd.c:13:
In file included from /tmp/kci/linux/init/do_mounts.h:3:
In file included from /tmp/kci/linux/include/linux/blkdev.h:9:
In file included from /tmp/kci/linux/include/linux/blk_types.h:10:
In file included from /tmp/kci/linux/include/linux/bvec.h:10:
/tmp/kci/linux/include/linux/highmem.h:427:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^
/tmp/kci/linux/include/linux/highmem.h:448:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  448 |                 if (folio_test_highmem(folio) &&
      |                     ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:78556695026d12066b10d53b0e5ab522e54b7c52
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  406de00ce2971abe3010eaabc26c71e84b4ee9b3

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae228475c0836a8c2f04365

#kernelci issue maestro:78556695026d12066b10d53b0e5ab522e54b7c52

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
