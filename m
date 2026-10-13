Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5671F47A872
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913299; cv=none; b=uPhZYVJ3NiI43oInp+Gz2PRHSzJ0KIQpUTIA58Pemx5XmL4vRzT1jwe+pZtppHD0sAm15Kjq0gAITjX3+64/K78MCpu0m6lbJgTTpBIlsriP5kbHPmYwPUBwYlUpNZ2/8MTrzqMvZs+fHGEy0rRJUvK4Bn9zSmtYCwKPCyLh+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913299; c=relaxed/simple;
	bh=azrwaP3EjcpCGMcel2UtnvUNaj967l0YfSG4IbJ78e4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ChckXE/Olaquwp5QjhEDnG3ZlE2nYlR0AyZOuQ3y14oYRiO1TuRGbUHZ0mAHvOi5PNfDR0zKqgbktwHaYHUDytm9IPZPurFiqa/13IBpEwR3fVuRiwa4BYXKuI7JDLvuMn8hH3+PDRoJGc7kvC+hlvT5evPRLuFe9OnmPu5pwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=HuUvvco8; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="HuUvvco8"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15756f82e8aso102753c88.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791913297; x=1792518097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hJcqPQi6+D12Tb3NW8V6vQnLueTCqkF2wzq1kz/2UGc=;
        b=HuUvvco8ibC6NjFC48anzVdBR02DEYZ1BRuReIIPL+fcVjGffRP0BN3Ctk/js2tNw5
         wULh37dAUSaUAu/KCUF3X/4Ogo7XEGXHxyKhs7SCafJSKL7nxL7gq6Cpjd2NJG04vQXc
         JzZHKwJY/MWI5nx2+xPv7MiKbMt7XGTgZ2f76mZunLXpomCqG5zs92NByHgvzIDp/RPl
         Uy7p5ksD8Xm4aWFcKUpwRZzYFvIoRFimyZ9u40DB93/rFjVGac+bM6jZVOJHA1iRtQmm
         RPE3sJ1XTOFkkLaTyHTMBszPo3oOjqNYz8PhzSJXptYlpfUIPqisjAfDfIJODs120DUC
         VNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791913297; x=1792518097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJcqPQi6+D12Tb3NW8V6vQnLueTCqkF2wzq1kz/2UGc=;
        b=a1qnn+wD5cauEJM9O9vSgMG7fST4pd4SnkICyqJ/GLfZ5LpfFKGNtaSDwmn1TVvhDE
         aR71OuFBWwST1QiGE53XzbdAq6fh7N/MB7fDnIItseAg5ZJDPfz1J4QurjLX0AkPyICH
         JFyojauF5OwJfPFhAlaLHLL3KtphBJjFTnSmvxgpZ83W9vWKIselPGemHxx01K8auNzj
         LTdzLHf6al8uCeKUFaoWM/cHVojB4JHqXDRHAy1A6YlE/wNhk2q8azy3Sh1mAGdHuOCY
         E0vB1J6zKvya6bM3NxFm5M7jRhWYbgWBWuWdKPvqaMRlhONaUunO/Ag9MTawGCbUdy5l
         wMtQ==
X-Gm-Message-State: AFq9FYLQ7Qa+++i44DSB5ZghEy+6KZgf/hv98gPsbj2uIaOiEijSXu6T
	5ZIz5bWhwel8QLB5kseWsfXV6g0s8KkmtdxBM9uFc4/dl0tX6iaFYuTUB6ovbjgqmok5Gmo/yg2
	xM2nBuHfMVA==
X-Gm-Gg: AYBFou2VsOLftXlFCz1PTXpG/wlNhghbUFrDPoCoBUnBEjVZw3jgcPTsq69NBvNOFow
	fpy37qtQxVP/Ox/dLc7ibJOA1Ng69aEDoqX1fj4cz+CD2wa1pwg+P4sfpsQJXfDMcoanNezZBpi
	WcSgGAD/WNwthp5SylzGrtAajAvmkBFh+4pyj63GebFNsoYHSnS7OKZxq7SCHeI0m4IJPIlc69Y
	eFpBDW04qbSaZNxGSEUBlY6Yy8cPx4glLZ82ygLrii33Y6jMAd7xcu2TC5G3dpFLAdzaNjg45xz
	0Ji708jzOaxGQQ1sIqTlfN+T4B2Yqng4sD6WCalXPc5xS/gEY1b/bBqWW6340SZqbnamrESKh/Z
	loxAJ8EWGcel5dNXTeNapD9dDzIlIxOkU7DTDU0OHnE6uEyVhLk4cllY+f8/Fh73OscdJU7mMNM
	dXUHp5q2BuK2RxubSRJJvmdxCDvLLyybbSMxaUrNWxrNAipuoFjsfMxc0KWRGWdo9H3v6gtwUMP
	fgKWGfY90vCj9RBUoSeDs1XbskDB+dtO+Mm2GEBDClf8kMfU62Cet6bnpTi4vj19i3FobY=
X-Received: by 2002:a05:701b:450c:10b0:143:1bb1:3300 with SMTP id a92af1059eb24-16a133b7925mr16855532c88.17.1791913297163;
        Tue, 13 Oct 2026 10:41:37 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:494a:328e:aed2:b92f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6f5csm38850601c88.11.2026.10.13.10.41.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 10:41:36 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com,
	leon@kernel.org,
	johan@kernel.org,
	broonie@kernel.org,
	ethantidmore06@gmail.com,
	peter@korsgaard.com,
	sigmaepsilon92@gmail.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	joro@8bytes.org,
	zhen.ni@easystack.cn
Subject: [6.18.y, 6.12.y] Please apply five upstream fixes
Date: Tue, 13 Oct 2026 13:41:30 -0400
Message-ID: <20261013174132.80015-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg and Sasha,

Please consider applying the following upstream commits. Each applies
cleanly to the listed releases (6.18.56, 6.12.112), and all are
already in 7.2.y.

6.18.y and 6.12.y:

76645c1fd682c9df746c3f7c149b868ceff914fb
  spi: mpc52xx: clean up interrupt handling
  Follow-up to the CVE-2026-46241 fix: only free IRQs that were
  actually requested on the probe-error and remove paths.

2c863dbbeac7b919d4634ad886978a6731916de3
  usb: gadget: f_hid: Add missing error code
  Fixes the CVE-2026-31606 fix (81ebd43cc0d6): a failed cdev_alloc()
  in hidg_bind() returns success.

6.18.y only:

00baeade709fb66da647e8327e8398bb532e30f7
  RDMA/erdma: Use IRQ-safe XArray helpers for QP and CQ tables
  Fixes an EQ-interrupt deadlock in the CVE-2026-90308 and
  CVE-2026-90309 fixes (a52eeff32024, 98df2aee1459), both in 6.18.y.

6.12.y only (please apply together, in this order):

82582f85ed22ba6cd27fea76b4248745f3b9fdf7
  iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
923b70581cb6acede90f8aaf4afe5d1c58c67b71
  iommu/amd: Fix ivrs_base memleak in early_amd_iommu_init()

  6.12.y already writes DTEs with a 128-bit cmpxchg in update_dte256()
  but never checks for CMPXCHG16B. The first commit adds the check;
  the second fixes the ACPI table leak it introduces on failure.

The 6.18.y set and the 6.12.y AMD pair were build-tested on x86_64
allmodconfig with CONFIG_WERROR=y on each target plus stable-queue
371f783b5fdd; spi-mpc52xx was also built for powerpc on 6.18.y. The
6.12.y spi and f_hid picks apply with line offsets only; all four
6.12.y picks were then applied together in the order above and built
on x86_64 allmodconfig with CONFIG_WERROR=y (kernel and all modules),
and spi-mpc52xx was built for powerpc (mpc5200_defconfig +
CONFIG_SPI_MPC52xx=m, CONFIG_WERROR=y). No warnings or errors.
Nothing was runtime tested.

Assisted-by: LLM

Thanks,
Artem Dinaburg
