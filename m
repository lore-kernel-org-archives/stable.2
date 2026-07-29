Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4976026
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291529; cv=none; b=n1NEK9Jbgc0iADq9i7gIpoGU1JqcprNoGt7EUlmkeZIlSj5pLmeKAFOgmo9mi4gqWHZXF6hhYQnj4S255rD2XD1zpxuQTVXU93YJDSJ6As8Y2r249hxsdojMiVl7ppShLv0d35V645SeAYHmK7dFnD4T0Vy+KQ3FgntQ4MrgTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291529; c=relaxed/simple;
	bh=dmriazfhWcf5wW8lxOVtQBUgCYLeSYhcaY4KgrG7ctA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dn8n4fCtp81JMzpLZFM/Oj9HDOZUvgQUfATd0+OtMr8tLPYkbH3sGKHMLAEVLbd7Zmf8TE73ylmFA5gqSRGL89opAaABkzOoJnRpS6nOKRZN0bRbqTnekzxjvikx2TwTkh5FzvGMrGnU2CFOPlohaHNFhhfxH5VigSzRz5EEjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxcpqN8r; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxcpqN8r"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceaf8a1265so5678235ad.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785291527; x=1785896327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A3vGTZ+9cBJHUjmSn73Xe4evmb/1PkSIQ94tual6z3w=;
        b=cxcpqN8rq7HglPHwR2IbvxtN3GRe4NGzynmTkyK5gm0qBOA+Aoz+G+e9xEZZjKgB6P
         3Q/limCrCp0xbEw3GNbLkuj5QLRHJTRt6eORffvT3s+BMDQDUJeAGZbTg3wHS+m/UPij
         ngZ3i1pVCHG/6wDjRDKQ5BU62/lfhPfTq3duGviYVBcd2Oe8KQM6Xcm2sqAI9+7O0pSI
         lluM3cOhYR/sIi8ZXxX1DuHyxd5gO2E/FZEPjnRBZmIkOq7LGkhLaqqnZKKTvwOxDqt0
         LB+a5BjnJZzHdtUivq1OnMYyrc5XvRRlg+EJRY7wnHHcDz5D6znhpAQtkKUXRb0gAfLw
         Whrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785291527; x=1785896327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A3vGTZ+9cBJHUjmSn73Xe4evmb/1PkSIQ94tual6z3w=;
        b=VJ4SNO9+wdLiA0lw+cEzDPqQWL2T1ma36pu5OFQb5zDOZJfAJNV/ppJtajX/zEEQ5b
         /zeKW0qo/95Afuf4l6AUQ3WWfVSZR82hqFRe5i6hhM2JDaZuvLz5lfOPMCxRN86zL2Gw
         dIUECNiBqbMTLJt+VoMvDh8+fimr0w6UdwsflqtiXl7YMQ/N1W/BhkA9pVE2tP4IMqrz
         hcktP+2MdUN6BzCQrTs6A1fOiL1kz2J81x+dAorAThsW9dw12tHhnFuT2FJ3PRgnzG1G
         QiVUN1wjMVn/Jg9lhpRiroAzg4sXMaX/WlsxnATYDjmVw5+4ZmIDUhoJrDRS/MZEEkZb
         haJw==
X-Forwarded-Encrypted: i=1; AHgh+RqrGGs6OFDMlTPcytARAC+GHVTo+DBZ2TtbEj/mIEHpAXSegoSfaPEIlZ7EIVFWnfa+q6kU82Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRvEKE0HjtqUPbcoDKgsGiet+R4lej9fjlv/kZq1whYNvdal5i
	SZ+T6N7V4c4Na1LnlpU5sYk2MaNsKc4Jlcurb7Vs73io9VznKuGXG2g=
X-Gm-Gg: AR+sD110KM9ppxnGP5EQEYYCSbYSuD4lr2BDf9VCMdaPTm7i4GaJPLDDdDy80qlaT0F
	EihVSpA2zzpbhB/rHvEiGDkNVXszaiTtLqjuCo21BylsrJyhCzzrqGnlY1afiUyaaouHjpZczG7
	pCT+MNxcm4SN0lX/uVS8DemqVN0JgjcU1QMRiiEOFoKhBX6QYI0mFitDR+k5pctpI3MoG47AG5y
	AFDzBR7n/KdwE0WlLIf2ZNa204YJlw0QbnfK//YLwxXM2LAUmGM6rrwzY/iFnFKAgWvYmqGXe7N
	93gDXLXDlt8SJ7ZtYwV6RDB3Zd4w76dHWBLyBFhep+d06I1RXpwjCPq/3Bj67WXPLSGYHjHWVT5
	4L12AR+xqa2k++Tglz0T8lvzwMMumtTyE4bzfnHCD79ZeKGFqYuxCYY2UERdJfD7DS1KnwiZB5h
	z3BfqbB8Eg3SoCLw3U14AICs95x2CFdyzcTHvcuS4HWlXRS3S2clQ6pilnhdW6LseXimKzL7vc0
	4+dF+AYD1FokZl3rgK0TqOrwGWYjGmER7QnrYDoUl9voIm0IxEyR6oRfsAdI0Bk2RDa+uMf73dO
	7MyfTsYJoNzbMcit+41vjFPz3ruH9jCkDA==
X-Received: by 2002:a17:903:1905:b0:2ca:ca48:c36a with SMTP id d9443c01a7336-2d015c0fcacmr52704555ad.18.1785291527425;
        Tue, 28 Jul 2026 19:18:47 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a46774sm3848685ad.27.2026.07.28.19.18.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 19:18:45 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Alain Volmat <alain.volmat@foss.st.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-media@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] media: stm32: csi: unregister async notifier on cleanup
Date: Wed, 29 Jul 2026 11:18:34 +0900
Message-ID: <20260729021834.50550-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stm32_csi_parse_dt() registers the async notifier before probe finishes.
If a later operation fails, the error path only cleans up the notifier's
connections.  It does not unregister the notifier, leaving its entry on
the global notifier list after the devm-allocated csidev is freed.

The remove path has the same problem.  A later async operation can then
walk the stale notifier entry and access freed memory.

Unregister the notifier before cleaning up its resources on both paths.

Fixes: dcb0f4c16be5 ("media: stm32: csi: addition of the STM32 CSI driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/st/stm32/stm32-csi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/st/stm32/stm32-csi.c b/drivers/media/platform/st/stm32/stm32-csi.c
--- a/drivers/media/platform/st/stm32/stm32-csi.c
+++ b/drivers/media/platform/st/stm32/stm32-csi.c
@@ -1059,6 +1059,7 @@ static int stm32_csi_probe(struct platform_device *pdev)
 	return 0;
 
 err_cleanup:
+	v4l2_async_nf_unregister(&csidev->notifier);
 	v4l2_async_nf_cleanup(&csidev->notifier);
 	return ret;
 }
@@ -1068,6 +1069,8 @@ static void stm32_csi_remove(struct platform_device *pdev)
 	struct stm32_csi_dev *csidev = platform_get_drvdata(pdev);
 
+	v4l2_async_nf_unregister(&csidev->notifier);
+	v4l2_async_nf_cleanup(&csidev->notifier);
 	v4l2_async_unregister_subdev(&csidev->sd);
 
 	pm_runtime_disable(&pdev->dev);
 }
-- 
2.50.1
