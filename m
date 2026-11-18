Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003150;
	b=ntSzj86PKNEI2IEBdf9iTGgUkpOxsIzPOs7m6SPp54ajBHNw+4jmRE2MqbgPKYHFy2gS
	 3BJKo78PFapXSctJUvoRSFm1YhPTkzBF61OgrgObJZAkO36e8JEHvup8/mHdzzKdWcQas
	 aSq9FJHKXcP4S2MKXBt6r1OCI0KlnQ7Qz2ci1pnpC+/opq1OgZrdXKY0gWMfBwmTvzSAZ
	 b9F6rLkr3ZiLL+x695Xwu9xTed4ph5TiNAmq8jukMLj6SCdJyRtc5OjBPORtkzuNTK64q
	 xBLpEIUTBIDFBVnMyn+EWEw4ckoWhA4vs+kvozqggv3q9cvPqS2clqNTInGrS8o4h4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=7lzQkT2lVjFO6hNDpH6jXmLKxQ3MqqFIyPUDsfGuNxw=;
	b=AkiKHH/7TOdvcBA1tsWnzE3rfjBbkFcbiwB8e3PyAvhK0QuL/10c1s81f2hbu6Q5pMat
	 ZC23EuNItohdYGNANYHXdd+4PvKrRGkeG904NGGvVY9xRhsFhMRheiCWs70aKteru6B+Y
	 jLVl5ArBCW4QWYCHyxQZmi1KvpLDBe0Rp2cpgUQzvniiOqxvqNcP5+De3RHKw/nZI2Eil
	 Zdq+5Ppm628vNnr8/waYraJU26trgFUhg5pd1Jx8YprE2AIraVmlcm+KsD1RI7X3u8Cfu
	 TGcdxUlchQy6LmxYRBuFBOPFJl43FUH5mm2XIEZcgR8BP9mi+MRjl9XqfUH05NV1aZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=hRvbde7x;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A4606A32F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C3A4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=hRvbde7x
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-170135e43c7so1438302c88.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795003149; x=1795607949; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7lzQkT2lVjFO6hNDpH6jXmLKxQ3MqqFIyPUDsfGuNxw=;
        b=hRvbde7xDMBXdsHUElitILQ166u7CdLaQU+9RTmMEwx+rcZ++SMEh8tjzCEP1WRkI9
         vXG7x1s1rtto/A0O9oGCyVzwtVK8ZT4um9GBsQHZRDzkrcRgakwJ15G/k5eU37ZVOY+4
         9hBGxYtYvWAjadj3P/nynZ/oBnaYcrWvj6kMmuELxmvKDbXSwsO7WY56HnFuV+XfPQkB
         l0/yf6CyfNShd+Mhkr36UQl1jqE8sM/W3Q+w/NDWbl3SIorRed3NnMGcTIwQx4WiaNWB
         80nI+enXr+cDJ99ePLECSo2BWH2h04LV++ZrW/QVzCOg8VFXt+f7VNyPQ7VPQoDlU5VG
         Trkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003149; x=1795607949;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lzQkT2lVjFO6hNDpH6jXmLKxQ3MqqFIyPUDsfGuNxw=;
        b=FR84XdZ2WpKyAvz97FWaevqrofY5nkWMBSFkIg2R9fUkVRQ7j4hwNXeRa5ZxGBSxVO
         if8Llh0CSmKW65I3rY/j9M6EacpCHMQpSDZLgmgkNVcZn4ajKaul16ghANRX0InsKAiZ
         BBhbEWlVT5I1B5NDNHPm2vouwhgKKoOJXqEr/V6oOlDPEkwseuNtpiRz51jVDMrK6txm
         F0uhAIsQxmmt7YjM9IrKnvehTtSn3XI/WR2skpJ34lczJ6as3tdMpNXdJEG228WtDkN+
         YmXIWt58rkW2+5sPQ5wjlCYAlLt0HRQMnj7HqHeAlgZ9m93FhBYwbWlHyeKes3u0eCcc
         Ni2g==
X-Gm-Message-State: APuU4Z+q7bJu/zqviD3TcERXyGlneV43Kd5YZVS1NWoEYoC5Ic6kZw9K
	RRAV/G30wUZNx760oiyqXkRyj4EWv0GiViFASfdiyuBZL3mqnS2ngPQ48kxIYugafNpoRwWfRBz
	cyeFo
X-Gm-Gg: AYBFou3CL0FlUdl9O3L3mxmu5LrqhCfbikMzpofpuCVnOdi6Cl2lb+1p4vE7e7KQJGZ
	KoJCIQkb2jznsD0pc1hvZ0pF2pp5+R5zLWhx0w+V2oTzgc9HlzPNmboMWq6SjbJ7exp+4eQHxxl
	4l9f9VNMxw8kFs0a4mMzOfGhzOi+4ef5K2WjtomgqnSl8W86naiiEUJSztqbUsOca0t4R9tU+T3
	D6Djhw5Q/kgxi2pIinjVZeNnbBFSy7w9nqj8SybXf1bD7b+vT3rSJo3f/uBGIa0YJeauNSbiXSx
	5S3RtPCXkoZOmbjEmvg9n8HUQDAVlVKH4/Id4Shnq0JVkSKPPZCWjIGKWRO+uRHKS7RyxEyVAcS
	wspN9lUKU/I0mcmrYKoERY5ZeyaKA38JO1ZaalMQXT610Jx3T+Frk0DelH+rSHnwy2Ern2VSIaF
	PIbyoopdI0dhCQUaQU+VNohV9glNjvF8MJBPZYzmHKu7OfUWl1o+KVjj9ywZ+n6JIVeO6e0mcbq
	dMSsVFHeZL2PSzosyl6K/BJdAEOIM0q8wfpzNFbxZCVgD4Ll+T0CS3t9BmJpnRU5x1cEfPABv+D
	HeNx0bULXaHnS4ufTJ4pJQ==
X-Received: by 2002:a05:7022:ec85:b0:1a5:52f6:db9a with SMTP id a92af1059eb24-1b543c12ea4mr2927304c88.22.1795003149171;
        Wed, 18 Nov 2026 03:59:09 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a45260a8sm12936341eec.3.2026.11.18.03.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:59:08 -0800 (PST)
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
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E10=2Ey=3A_=28build=29too_few_?=
 =?utf-8?q?arguments_to_function_=E2=80=98pm=5Fruntime=5Fget=5Fif=5Factive?=
 =?utf-8?q?=E2=80=99_in_drivers=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 11:59:08 -0000
Message-ID: <179500314741.299494.12000405943938686539@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.10.y:

---
too few arguments to function ‘pm_runtime_get_if_active’ in drivers/dma/ste_dma40.o (drivers/dma/ste_dma40.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/dma/ste_dma40.c:1695:15: error: too few arguments to function ‘pm_runtime_get_if_active’
 1695 |         ret = pm_runtime_get_if_active(base->dev);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from /tmp/kci/linux/drivers/dma/ste_dma40.c:19:
/tmp/kci/linux/include/linux/pm_runtime.h:42:12: note: declared here
   42 | extern int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);
      |            ^~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/dma/ste_dma40.c: In function ‘d40_hw_detect_init’:
/tmp/kci/linux/drivers/dma/ste_dma40.c:3306:32: warning: returning ‘int’ from a function with return type ‘struct d40_base *’ makes pointer from integer without a cast [-Wint-conversion]
 3306 |                         return -EINVAL;
      |                                ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:339c3c8632c391ccc33bb39c49f373b27da9ec56
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  61c312b5c114d6e6f4e6a3c6685f001cfcff5e4a

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd8fed99c74e1a997d3589

#kernelci issue maestro:339c3c8632c391ccc33bb39c49f373b27da9ec56

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
