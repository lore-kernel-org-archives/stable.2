Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18B38F947
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728503; cv=none; b=Jhif35c03yXe4aaopvrPk1Fjd6QWk7HGSrgdUtKx8vf05NLuNKJWlHNad+bNtzdZ9igEAfNWU+A8Q8gGwRvUnrBKlGf1eAtZJTIrIB+H0bNyAXl4a8iMcak9ZAIpuu4aweINtirO8kWiBu2R+4c+3ELnaUFzHVEqYO+dNk2xaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728503; c=relaxed/simple;
	bh=dYooKYiHa15h/EN9ez2zCDVXDYqOT/fEufW+QXrSSLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZXVydqPCtDBbFy5srRK06HgdHRmfhW2VjA6D8ZW6aU/7c5QthVq5PgyNzyAhLEktWNy8PXGF5wtfpfqIsMV9oM7WN4yTNlaSwq4+zqfW/1/XShD9EJ1OZiL0zafVComBp0CZuNVtHlU/nyASeC6NCk5skj9rvMsh2t6w2trHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCypx7cF; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCypx7cF"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39aeb9513efso13843251fa.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782728499; x=1783333299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+caonJAAiE2inmJFUDedx+R6t5Q7baaAhhwhNNIaaPg=;
        b=lCypx7cFRCb1R2mojKw98mPzDLrmYyxZRcT5YRBp3aV6lFNOt2sbruMWBvp2dlGPnl
         FlfDB2ZhHuVuCoCw6KvVUyhZwnPGqLqEoyz+95rQjhFtzU9dvp5pf9bEQdy5tXgZJ7S7
         m4N4cztDrzM/PNcQpGlBQTSgYqY1hU2LEuhssPrt1IreLD/iXx0yc3gPenn0eLM7z2Hn
         qwShV6Izz3RSvqT99mLj7M8lX6+I/V/vJ2W2RE/qaGUL3DGJtrlO2nNXolgjoW4JRj1Y
         eSIshTkVW7efYrH0BwkIygwW22ciOluSR+bEPrlwiYaL3kU6F1vkJ70KUqqiPtoNvQYt
         Jxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728499; x=1783333299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+caonJAAiE2inmJFUDedx+R6t5Q7baaAhhwhNNIaaPg=;
        b=XUKuUe2LC8DkqCS6eKfoea4DdmmpT9R4YSbO4hkwmNuplGa3GOx+n5AIK9TDkI9DCb
         zvraBYskt+OBbFOcpcBHmaMZiD6OZNincWfxNDGm3L2VEhCR5hMCPmYdqv034yVmCq0a
         xEnGG7Bd53NL6aj7eN0XaBq/LE0QAa5toHMSr94sXOaOQPMV67GKa4Qp5ViYXcaur7bJ
         n1Xr2X1r3CJ5IiHSBtyrjrO0S/Nq9ifJ+Xl2+bNALrxs7IHf7h8ZjXDlNfb0CtgI/r8J
         kVcH0nQihbi+DzA3Nzy8ZuW8bnYZaMwgDEbwO3nO+s4obUb6dYzYgweYEh/yhCqIdPRC
         vW0g==
X-Gm-Message-State: AOJu0Yz8jpLDmwDNbwe62FvCJ6tV8RNwDUHJmxiAm0OO2BHvVdu6LXeu
	GcUMhbIPApas1JwgJKvWnyUKZ13quWXuAwKoJ4tp1DojWtZKBetDuO4EAArMExky
X-Gm-Gg: AfdE7cnu7Jgq8yHQTDhcz/n+36T9VuLisOp9Qkfun0qSz3i+4h2T+KyPluB4BToEekn
	yCfGpRCeXBK1sQk5gYLZqtI9q1eGdDys17UUeYIntehKtD3X6UG17Eqxlk5y+FzpjztZsARpszk
	0rnvD+4fv24L3b8I7Ob8X/H3aQ9gslmZTVBOhoJyfWJIki0wQ/3Qo/FC/VMcw2Ke6KdZS6wmjAB
	Y42GAgeOBncW0LNGiGMwrBS8MDxxfjwMx0g9CNQM7PyWU2rFhvnGzeYQw0MEWYlQ7EDScvdkLDC
	rLTXuoOaB5Yp6S6YCI0Ud1CmLctz2cF1ot788nHDPn17FmMbvPIFWuOZAvQko7DVFcHlMpbgzoy
	FKBQgckv7XO9JLuuoZurhx5rDX9d/2PhHdheSDesf0MdLyHQYRWzvffA+advmo+70E9HRZbvqam
	+qFm+DkToay+8JQ9LAFVMCjwpwXhQ5ZA==
X-Received: by 2002:a05:6512:350d:b0:5ae:bae2:f0df with SMTP id 2adb3069b0e04-5aebae2f1e2mr427697e87.10.1782728498823;
        Mon, 29 Jun 2026 03:21:38 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aea2cffc04sm3560539e87.17.2026.06.29.03.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:21:37 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	David Airlie <airlied@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 5.10/5.15/6.1/6.6/6.12] agp/amd64: Fix broken error propagation in agp_amd64_probe()
Date: Mon, 29 Jun 2026 13:21:23 +0300
Message-ID: <20260629102124.252403-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

commit b08472db93b1ccff84a7adec5779d47f0e9d3a30 upstream.

A NULL pointer dereference was observed in the AMD64 AGP driver when
running in a virtualized environment (e.g. qemu/kvm) without a physical
AMD northbridge. The crash occurs in amd64_fetch_size() when attempting
to dereference the pointer returned by node_to_amd_nb(0).

The root cause of this crash is broken error propagation in
agp_amd64_probe(): When no AMD northbridges are found, cache_nbs()
correctly returns -ENODEV. However, the probe function erroneously
checks the return value against exactly -1, rather than < 0.

As a result, the hardware absence error is masked, allowing the driver
to improperly proceed with initialization. It eventually calls
agp_add_bridge(), which invokes amd64_fetch_size(). Since the hardware
does not exist, node_to_amd_nb(0) returns NULL, leading to a General
Protection Fault (GPF) when accessing its ->misc member.

Fix the issue by correcting the error check in agp_amd64_probe() to
abort properly when cache_nbs() returns any negative error code. This
prevents the driver from erroneously proceeding without hardware, thereby
avoiding the subsequent NULL pointer dereference at its source.

Fixes: a32073bffc65 ("[PATCH] x86_64: Clean and enhance up K8 northbridge access code")
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v2.6.18+
Link: https://patch.msgid.link/20260504074823.99377-1-w15303746062@163.com
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
 drivers/char/agp/amd64-agp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index 8e41731d3642..c9d7cefa5192 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -546,7 +546,7 @@ static int agp_amd64_probe(struct pci_dev *pdev,
 	/* Fill in the mode register */
 	pci_read_config_dword(pdev, bridge->capndx+PCI_AGP_STATUS, &bridge->mode);
 
-	if (cache_nbs(pdev, cap_ptr) == -1) {
+	if (cache_nbs(pdev, cap_ptr) < 0) {
 		agp_put_bridge(bridge);
 		return -ENODEV;
 	}
-- 
2.43.0

