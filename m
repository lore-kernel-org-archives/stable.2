Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCFC35C6AC
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789196347; cv=none; b=UK1vhn0mLFYpfeI9E2+naHksQg08a2CXNiR1SvZdTbRAAvyj9o5Wa7Tpy2SIalikR5owEotgG2KiWQNjfMytvtCeOkdfWhTVEA5h0ZIqSILlQFKThsV2o7Dci9HPGbdkwOljPdOwBW7uzEqMmrWCR1m/VUC3JPo70u6i5Ht8AFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789196347; c=relaxed/simple;
	bh=7Ad+U55EkMuKOVINSmJ6b84mWwCS5D5xfAcqlY/s2lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+YmOehoa+wfXn76V2MDrMYfThDheZ84REHiUn24BTWP+/U3jhXKhMlktoZ/ZToaSlXckIqSuC3Ifrjc3Ybq8l78xEiWDomNFYeHW3SLW8DHk6RtBxmHcYA+I18Tg1S2yjX8ZgvYjPs1nT8CkSst4Bn2OOKz/xbjUpYISIeqzq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1zB2K0F; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1zB2K0F"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so1623595e9.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 23:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789196344; x=1789801144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ve9TjNtAR1yRkdeuTb/54fs6qejMaivLp/JWxfSV1gU=;
        b=o1zB2K0Frr3JoUp+vrMGWkC1P2uAw4F0C9upXZvALx6TCbpeq+E0eq3J9hyfvrLqhi
         s1gHRHFkkT7Slr4L5FDIuPfxbeJa1qVBhhpk5Bx/yJSCQXxdmvS2r5PAcutuvPqiH9W3
         7BYUfeFnqGFyPAQ3yWJJYZ9UVCP+KgtsXsd9ib76Z6SXrxGZQZ9Nx4aSAUgzGP+r+8iC
         qcN1tlSBBAmGLbxVO1kxloN+ZASig82u6305n82DZ3MALaC6fIsNcKd01wt6WfWoc1RI
         nDbY4PhoWm8d3LPnzaCaXVzCPnSKheqJ+NxiZsw0iytLXM9pd/fgESBH/kSCbwA1GLL2
         +pKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789196344; x=1789801144;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ve9TjNtAR1yRkdeuTb/54fs6qejMaivLp/JWxfSV1gU=;
        b=E8O7YpQChoW1gLVxV2DmyGhtSTFrSCUZn9/FfSz+wpS86UQl6WLEYQBc05sLV2Gl/p
         HT32m0BnJ1Uu5B13gzMCuaOdhboXm/zTXPwOMUTN8DZdrf/Qjcbrb1ZK1PupbB37I2lB
         EzGzTAxJGVGbL1c2YSOUqS8wXvW7g7Vc4cipIgcme62NFP5jJuPKVnoDdrAkc2rYA94i
         qax22GDZ+9WmFqtBugBwvrSP8siePvHJIBKEW7Asoy4aTPAp0PCplGEy2nePw3v/i6k7
         NQcPOJlhTEw7KxTpGwvdatNGcQSvm4+EQuGi1nkUE6G0UAeGPSNWZ47FcbvLQfZzxxmc
         DMTA==
X-Forwarded-Encrypted: i=1; AKwUvBxxc/fc24FY2G3r+xbpFGWBGDnFYv+VWbYpsxV0FRoeM517/ufGeQ/XV/G4cq4skxtxa3PybMc=@vger.kernel.org
X-Gm-Message-State: AFuF++kGHEnsda3DlrzysH/pDHRgDC1dh7v5fDCcLg/SEZhgNO+mFkN3
	6LTDjF0FMbInnIqJ9D7ISEhxw2QVrgMTCR4nRH24Iw/yugx4NSXEkSww
X-Gm-Gg: AYBFou3xQPJ24ECW+DKm84R5mBpu91HKOHok7a1GnsAxTnbk6JMEvExNLpKZhQMPNPE
	JaoRzPReYQ9SLOtxyXaBdc9uhmVQxFOBPeCZ8HxMsJO06V7aebqSLf4fGSW8zQuZAXgZphJD4Xe
	wd2pixFh/mVp+hVd53Oh8BU4FFmslALuTwIvrRoc+tpRdUto3ux38x5n26GFlx3Gq4gjrFwZZYb
	JIg7pf5LEiFv4vbwmruI08MG9jGuNfq9Wf1jK3FGGD4utvmfyJaL460MAcutc2VvJTUTplbtTzj
	ndReNt84k5Ipq4KOGehsOAiEvlvAkvTAdGj8E+K8bOeS4/moukqUUrw3bcUzZlZSUkaO17G1HzT
	Djjos2gWXMjfIWxQNS0XocMxfVIgrKU4E6NX6CkXeFxtKoItsSe9Kn03dNRwQfKmlxuum7pCQ3x
	FTbV4bzaZM6H44ksPG2Qu/3Qx4xmXGxpTbifiEEfYbtI7Q3gKLBEgNSQvb+/ocZTmsUN3q3M0Tx
	2FbyDf1MY8HAGBPJFbNN5F1aBi5DfPya2spHTYtAKSlEOvxTogKNHSNBeR6RmGXvz5Re1+4LRrr
	ROZO2TpeARS8FBdPk1Qc8u77Z1WdUHPDkpRBn+HgJhCq8oAfDpLHO4dZ9Sknmg4uxSJ2cW8NqCP
	lAwJMloqqRA==
X-Received: by 2002:a05:600c:3509:b0:49c:f13e:e4d with SMTP id 5b1f17b1804b1-49e61082a1dmr89197245e9.10.1789196344222;
        Fri, 11 Sep 2026 23:59:04 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6576122bsm146181225e9.2.2026.09.11.23.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 23:59:03 -0700 (PDT)
Date: Sat, 12 Sep 2026 08:59:01 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, 
	Hans Ulli Kroll <ulli.kroll@googlemail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 0/2] ARM: preserve DMA_FROM_DEVICE buffer contents
Message-ID: <aqT3UcHPXHIwlqqd@gmail.com>
References: <20260910063620.17768-1-kmehltretter@gmail.com>
 <2ea28a17-f36f-4dfb-8e2a-375e7a3a4d6b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea28a17-f36f-4dfb-8e2a-375e7a3a4d6b@app.fastmail.com>

On Thu, Sep 10, 2026 at 11:14:28AM +0100, Arnd Bergmann wrote:

Hi Arnd,

> - actually measure the performance overhead: you already did the
>   work to test this on three separate arm implementations but did
>   not share performance numbers.
>   Can you quantify how much this costs us on the hardware you used?
> 

I measured DMA_FROM_DEVICE map/unmap round trips without a device transfer.
The 1 MiB results were unchanged within noise on Pi 400 and SAM9X75, and
faster on ARM11. The only reproducible increase was about 22 ns for a
256 B round trip on Pi 400.

These are the mean times per round trip. I wrote to the dirty buffers
before each iteration and left the clean buffers untouched.

                                         control     patched       change
  Cortex-A72, v7, 256 B dirty           353 ns         376 ns       +6.3%
  Cortex-A72, v7, 1 MiB dirty        73.840 us      73.994 us       +0.21%
  Cortex-A72, v7, 1 MiB clean        73.108 us      73.115 us       +0.01%

  ARM926EJ-S, legacy, 256 B dirty      1.208 us       1.203 us       -0.4%
  ARM926EJ-S, legacy, 1 MiB dirty    656.888 us     656.827 us       -0.009%
  ARM926EJ-S, legacy, 1 MiB clean    656.608 us     656.601 us       -0.001%

  ARM11 MPCore, v6, 256 B dirty        4.639 us       3.095 us      -33.3%
  ARM11 MPCore, v6, 1 MiB dirty       16.380 ms      15.550 ms       -5.1%
  ARM11 MPCore, v6, 1 MiB clean       16.380 ms      15.560 ms       -5.0%

Pi 400 and SAM9X75 used 786262be6048 and GCC 13.3, with three boots per
kernel. On Pi 400, only the v7 map change from patch 1 takes effect.
On SAM9X75, patch 2 changes map-time invalidate to clean-and-invalidate.
Unmap remains a no-op.

ARM11 used a 5.11-based tree and Clang/LLD 22.1.8 on both sides. Its clock
has 4 ms resolution, so I timed batches and subtracted a separate
memset-only batch for dirty buffers. I alternated kernels for five boots
each, with five batches per scenario per boot and 500,000 iterations per
256 B batch. Every patched boot's mean was below every control boot's
mean in all three scenarios.

Both ARM11 kernels invalidate at unmap, as current mainline does.
They differ only in whether they invalidate or clean at map time.

Below is the benchmark source used on Pi 400 and SAM9X75.

----- dma_from_device_benchmark.c -----
// SPDX-License-Identifier: GPL-2.0-only
/*
 * Streaming DMA_FROM_DEVICE map/unmap cost benchmark.
 *
 * Times dma_map_single()+dma_unmap_single() round trips for a few
 * buffer size / dirty-state scenarios, to quantify the cost of the
 * architecture's cache-maintenance choice for DMA_FROM_DEVICE (e.g.
 * invalidate-at-map vs clean-at-map). No real DMA hardware is used or
 * required: only the architecture's cache-maintenance side effects of
 * the streaming DMA API are measured, against a throwaway platform
 * device, so this runs unmodified on any architecture.
 *
 * insmod dma_from_device_benchmark.ko and read dmesg for one line per
 * scenario: mean/min/max nanoseconds per round trip and ns per KiB.
 */
#include <linux/dma-mapping.h>
#include <linux/interrupt.h>
#include <linux/ktime.h>
#include <linux/math64.h>
#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/slab.h>

struct scenario {
	const char *name;
	size_t size;
	unsigned int reps;
	bool dirty;
};

static const struct scenario scenarios[] = {
	{ "small-dirty-256B", 256,      5000, true  },
	{ "large-dirty-1MiB", 1 << 20,  300,  true  },
	{ "large-clean-1MiB", 1 << 20,  300,  false },
};

static struct platform_device *pdev;

static int run_scenario(struct device *dev, const struct scenario *sc)
{
	u64 sum = 0, min = U64_MAX, max = 0;
	unsigned int i;
	u8 *buf;
	int ret = 0;

	buf = kmalloc(sc->size, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;

	for (i = 0; i < sc->reps; i++) {
		unsigned long flags;
		dma_addr_t dma;
		u64 t0, t1, d;

		/* Re-dirty every line each pass; a "clean" scenario never
		 * writes buf at all, so it stays whatever the allocator left
		 * it as (steady-state after the first map/unmap invalidates
		 * it out of cache).
		 */
		if (sc->dirty)
			memset(buf, (u8)(i | 1), sc->size);

		local_irq_save(flags);
		t0 = ktime_get_ns();
		dma = dma_map_single(dev, buf, sc->size, DMA_FROM_DEVICE);
		if (!dma_mapping_error(dev, dma))
			dma_unmap_single(dev, dma, sc->size, DMA_FROM_DEVICE);
		t1 = ktime_get_ns();
		local_irq_restore(flags);

		if (dma_mapping_error(dev, dma)) {
			ret = -EIO;
			break;
		}

		d = t1 - t0;
		sum += d;
		min = min_t(u64, min, d);
		max = max_t(u64, max, d);
	}

	if (!ret) {
		u64 mean = sum, ns_per_kib;

		do_div(mean, sc->reps);
		ns_per_kib = mean * 1024;
		do_div(ns_per_kib, sc->size);
		pr_info("dmabench: %-16s size=%8zu reps=%u mean_ns=%llu min_ns=%llu max_ns=%llu ns_per_KiB=%llu\n",
			sc->name, sc->size, sc->reps, mean, min, max, ns_per_kib);
	} else
		pr_err("dmabench: %s: dma_map_single failed\n", sc->name);

	kfree(buf);
	return ret;
}

static int __init dmabench_init(void)
{
	struct device *dev;
	unsigned int i;
	int ret;

	pdev = platform_device_register_simple("dmabench", -1, NULL, 0);
	if (IS_ERR(pdev))
		return PTR_ERR(pdev);
	dev = &pdev->dev;

	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
	if (ret) {
		platform_device_unregister(pdev);
		return ret;
	}

	pr_info("dmabench: START\n");
	for (i = 0; i < ARRAY_SIZE(scenarios); i++)
		run_scenario(dev, &scenarios[i]);
	pr_info("dmabench: DONE\n");
	return 0;
}

static void __exit dmabench_exit(void)
{
	platform_device_unregister(pdev);
}

module_init(dmabench_init);
module_exit(dmabench_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Streaming DMA_FROM_DEVICE map/unmap cost benchmark");

-- 
Karl
