Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668731;
	b=DrbidydsY2kEGXuek17+gvNlekMZdSxnjuYPWAjYSct/tWmoPqLcQNDe2D5MudRB3GUa
	 Hh5uDTlYGnGsbetDM8Wv+EtF1i1arAyhydZmXFJW+6zxCpX+C1RhVrptNr3HPNhWp7JFF
	 r8r08Yr0INBtc6+c4xXELiDCaMS1Iy1ec8y38QXWhVimw+7rP06P6ZwixyRL6j8r5AKkp
	 /mxCo4aG2KpdY9GxcsPuaYUcT7gKBk9dfKUqNP0UVeIogZN7EfCXphPItKj+APqUV4Tzh
	 nCwvBTmUZ6cXfsTpw4kkKtf8JPnJhq8iPpMbhCorbKly9BfCzKM9c4IeO0FHTh3B7pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S3q8xfPDIBkp3Q9114uqxEU+8XToiBPIWTZl/xj0hLw=;
	b=JB3fIO8AsA402qTbhWFcM9jAVPPbkcZtjzC8PAElWr8ryQmOJkNDr3mjL/MS+CZyMyws
	 0G9PN1ipjxYvSwcQ3VhZZZOZeJ33jd9Yw5LcNZyf0Si7YTRYFD3hEMNTkQZCz/8osdiun
	 r66m8yiSUFTgWgvYgFdulMowPZAPk8TiVqd1Zr/boY3M7t8TiJVl/Z76iP+6PwLwSqDPh
	 9wh5DWc/kgM+U27LiUjapKiQmHzCqEW3699saX3O4Yu8plhcbUuKmmPoLUNjZ2039pN89
	 uEnAfI6Wfr86ukiwHomiy4VOdKI6sof37DlP1oOQOfdqaV0v7micC3RfitALq5JIifA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PxMtADLx;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372E606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6372E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PxMtADLx
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f04fab527eso50781775ad.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795668731; x=1796273531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3q8xfPDIBkp3Q9114uqxEU+8XToiBPIWTZl/xj0hLw=;
        b=PxMtADLxgQywbpOu55+IWj6I1eNzRpzXQEgsa9sOqYKUYvhjiLQcp2nY39hwQpwYCy
         E8p+EJmBUkPocvUQSxpaI9A+rdeGsOCqhU+266Q2Dm/ivfUXI9ET7wiQz7FJ4EK+aRR/
         sGoEMOfrizBqGjI4k6PooxW0ORmmQcHs3tMpRdlkVJ3hz9Kps9cmqNHRCAqf/Y3XavUk
         9d2dpcySLkVtB3YVgtDsuTuWwf7cSyi7KFaF2bMB2FkGgjiLBzTPhW0Z0iGju/Euig9U
         WyRGpF3y5E2N3icXayoGw/MpdvCJi2099nQQiR/WnMvNfN5B2PyZ1DcNi3zT0gb6Iknw
         hvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795668731; x=1796273531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3q8xfPDIBkp3Q9114uqxEU+8XToiBPIWTZl/xj0hLw=;
        b=rZR8lL5Q/tV6gY8SqturQTyc8BeZeLA9L80AS1QpEhake+0R+jfn5OMNoVTjoCYo8m
         MYauxcRWCD4b+syIIsdVRnAb/Ux7lm8J/NczPD5Cj3vkoaHrTVMrVXuip9fBMs1zNxbs
         Pp1dXaXYPud4s6OIqaK4Til3fX5SLmuD+lta6y7/+4CUNAjVxZ7LMpxW9tZ/zgNM5OsH
         mn0n6ilHSXOwvpRoAnb3TLlWkflJPcyV5mcM6KZbm6z2onUegX4sQQLO9Ue1Td41D/Q7
         xXX/NHTrd7LF+AWEsrzYDeTytH5VEsfN57QvAjibqIe2e42sio2luISa5vzxVKQ4ljCM
         Fhag==
X-Forwarded-Encrypted: i=1; AL+hErHHJQ+oGVNlGHcwDzdz2oak/vPd/3ehO9HbZDG/f/2gu10RE9Ybv7YwweZdKCM74yArqNdDpt0=@vger.kernel.org
X-Gm-Message-State: APuU4Z//AnCIlcx/elQIfUSkQcb3KHaDfIGnTCk5fsN1Iw4VjElmXjnd
	a7lr/PIpSYlnzDTjnfk4r6WsC5U04oOEivu2rt64bjMXZrxLyWYXHIfk
X-Gm-Gg: AZFdTZd2mVe10mqLU4ybM1cZlsn7xCol83l0TCrjcFvfDNWzGtxx5QUuigOtrmHiaEv
	gaNLP8mfhsZ4HOrIyTTl8Q5Hs/tn3mJ+pzlf8fj/i0SHGAv+GdPhqzeiTsdjvJr31/klhDbhRhL
	4WpqBEXvXOHVpVlSzAJi5ewxLKhq1rFtzs71s2lCCO4jiDRlLbJKpEm0Z/xS3k1ou0RVHKDxW2i
	gNLPEgXMiLe7SMdRkMwO3Jj3VwhjfhqU0uuyMHQvifTz+SW6FV2nzX9Y6koDNGWCcmYvn4yYSbW
	WnJQsn2q+EYxCE6OleFg2D1yMX9YMJlUDNi5Fgh7JSE32XajhGpAJwjwXLVAajZZftTLSIfplox
	oe5ZcHkYfngtxdinf9klWHMxQ3GCPWz0jsbAFzArSsksFkUmMDnx/ktOTSTbY0d0a0DuzhnnIGY
	PZutw3oBKZOMBlOWjus24tQXB/Vvb8SrFDBfV7QUh3FhZ4yxJ49p59cytyb72lY6AxuSkfiW35X
	sclhU5LUL3Raz2VtAna+tlDeObS14ocA0IIo0Rv2HPxDeuifkgk6HV3KKGignceXE24BPVFtejX
	zbG08Nt+hAhB20AbCcIESOI0DFGm32YUvsICCUo7ACbdJHTp2E/xW1RqJfe7Ja+4vYZNnSDqvJc
	sOIclqP81Ksj3xAvsLz5bnXJsFGA37Vevj9W6XV1LEg==
X-Received: by 2002:a17:902:ce85:b0:2f0:3e44:4761 with SMTP id d9443c01a7336-2f03f25e801mr210179985ad.54.1795668730721;
        Wed, 25 Nov 2026 20:52:10 -0800 (PST)
Received: from LDYT9Q2G2M.pvgl.sap.corp ([2a09:bac5:cad0:1caa::2db:4c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120830sm96700655ad.61.2026.11.25.20.52.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 20:52:10 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Zhiqi Zhang <zhiqizhangg@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/exynos: Disable runtime PM on registration failure
Date: Thu, 26 Nov 2026 12:52:03 +0800
Message-ID: <20261126045203.62181-1-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
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

exynos_sysmmu_probe() enables runtime PM and then registers the SysMMU
with the IOMMU core. If iommu_device_register() fails, the error path
currently only removes the sysfs entry before returning.

That leaves runtime PM enabled for a device whose probe failed. The same
path can also leave dma_dev pointing at this SysMMU when it was the first
one to initialize the global DMA helper device, so later domain allocation
may use a device that never finished probing.

Add an unwind label for iommu_device_register() failures. Disable runtime
PM there, clear dma_dev if this probe set it, and then remove the sysfs
entry as before.

Found during static probe error-path review with help from OpenAI Codex.
The fix was build-tested with ARCH=arm exynos_defconfig and W=1 using an
arm-linux-gnueabihf GCC cross-compiler.

Fixes: bbc4d205d93f ("iommu/exynos: Fix driver initialization sequence")
Cc: stable@vger.kernel.org # 6.2+
Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 7c337ba96..18a536008 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -844,10 +844,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
 	if (ret)
-		goto err_dma_set_mask;
+		goto err_iommu_register;
 
 	return 0;
 
+err_iommu_register:
+	pm_runtime_disable(dev);
+	if (dma_dev == &pdev->dev)
+		dma_dev = NULL;
 err_dma_set_mask:
 	iommu_device_sysfs_remove(&data->iommu);
 	return ret;

base-commit: ebb7a8dc1e74c705daffe11c2faf38ec2628f838
-- 
2.54.0 (Apple Git-157)

