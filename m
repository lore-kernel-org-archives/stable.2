Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581562F39AB
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783201701; cv=none; b=IVX6RCatwjMiWSCHhnVr3i94cSWOrizgBm7ZFrQGcGLUMR6w9b8I0ZYo/+pHvLmHlaGCijWEdV0cpSPaK4nHsYPKs9ICOmiV2yGPVLAL2uTo9RJtVIIJYzMTnnkito+PVoyleL/fobFVWm5C/byzfhcS4eSqy6JW6LWgTHSODLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783201701; c=relaxed/simple;
	bh=z3R8AtQftcGwlO+0IEJHngliyLgsjvnUXbrOecFxsMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SifwNfZbhPZ2v1gJv7EJRyJSPjMMjiYq1vhkHI+xdWVzh8dTWUVOZ14U46JzqTc7tlENJzQxTKlecuUd40DRPav24+iAubnZWg4uWGHwqm7kJ3yByOcgmWE+7AE9rEN7mf2zz4eg2of1gfySjQz6gGXUiAP7JNvUwkwQjKGYsMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H09rEDa7; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H09rEDa7"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso1871837b3a.0
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 14:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783201700; x=1783806500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBu8eLtgFyfxE/8WdHQMx0CxcKxhtWNKmO3kujqn2EI=;
        b=H09rEDa7gp8sOwQykueObeZ6ssJ4RVFZZXj3KTrtnQyR2tUrcI9PiX9U9hKtf37D5o
         KLDz2V10LefoucH4U77U+owPeilkuJgiSmiwumjv9lLa+YWmQ+TODPDxW1y2dG4FQseW
         g5f+HEeSd7WT0I7C4k8OjAlDKDimRXtkWlNgJtOhqlIdB62biGKzASg6fc54LT4Wa3Fw
         up3ifqcICcZSdBwkVamfhHWpfWvtKjxfWQkkE3BXXT2ZS7A1c9dqMcHF/HJVZyOaHZKP
         /t5fh9NWGZsJdNCllExB2/1F7+S84bbRyK9KFGCKcEpEuo9Mo3f4Csz7WUuo1/RCNonL
         pOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783201700; x=1783806500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBu8eLtgFyfxE/8WdHQMx0CxcKxhtWNKmO3kujqn2EI=;
        b=b9N3PsIYpptaFgS5PYv3SwN2zWCMPl3MOEEJFhv6yx0FZ6bHFPDIadPlVklXjrDmoc
         3YOR+qqBWxZxgMIkz7Q1CWKaDHC8kcKWrjy2hmvlqXNRC5Mge5WimN+PQmSN7ds08N4E
         XmaM5ulzsOzUjRiMQ33pG2iGyGXTntvyBW0Otg3eDRLxC2oSR8rxS9uvvhB3gIcapbwT
         m49Usk/bvat6+XzGAzuLNYkcSJFHAs29ZciyTl4TKv0nk4LL1FwqwFDqi3bowttMlyzN
         xbjLKpvnXuz8ndOLt8bVKg4XlfONrkR7QrXdYhpxm3ToOP6ftjXmXE/XqV1kPvOH6i96
         oJyw==
X-Forwarded-Encrypted: i=1; AHgh+RovMtH1gD9+4b2vibKTG4VrKp+dNU/p7SC/Eco2er/aIadXFibsy2azMWIip6HghH9jxvWkBGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCznX/koYv4S5LH2hy62SPPn+YkVO2y3yKoQi3I1ZsrJKeJszC
	K5C3TNfS0o4wwa55LIChf7Ymw4DdtSF7WBtk0+iYJOtm968dHzoKjgZT
X-Gm-Gg: AfdE7cmbmV3TIn6JSkM+hRvrb+/x4lUfl1PpoaZHWf19ZHOOCjPnxW4OIezdGINHKH5
	mbp6TMCDcPj5qAEuM8R8xj++YhLTs/I3+WR2NuIAkCEA5QG7vVVFQvYzxLj1fBPK7BbwVGZhIuT
	9mOd8GMP4WQECssT03mXkYpSBnQkz/Zlrx26nZ0TBR4PM2wdydxlzb7grFU3StJWpVNui3dCuiJ
	1jkUPjaqc3rIk2FoPK2H/dmmBh82oWHbVmRadDglqUbvUii1TjCrbwuQzZLDw01tJBEOZ22fRMX
	CUf3ZGPz+oStmJqjq3N8DWunUdJb4kDJ9+WmcjzQqpTCcyBKu3PRhsJ+mPfnWvtHZBtGxS0xC9G
	wFTfrws27HZXASTKhuPWvoQuhIPVEzqKl2v1kJAqBhD+CPFYCdnxilX24LaByZ5gatxaGF75+Dr
	0HcTvXEY+OZKU=
X-Received: by 2002:a05:6a00:1805:b0:845:ce2c:2a2e with SMTP id d2e1a72fcca58-847f6dc1003mr4199953b3a.17.1783201699536;
        Sat, 04 Jul 2026 14:48:19 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6bcf03bsm1570479b3a.26.2026.07.04.14.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 14:48:17 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: pcs: xpcs-plat: fix runtime PM initialization
Date: Sun,  5 Jul 2026 05:48:08 +0800
Message-ID: <20260704214808.1566710-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver calls `pm_runtime_set_active()` before runtime PM is enabled,
and before the clock is prepared and enabled.

This causes the clock to be unprepared/disabled later in the suspend
callback even though it was never prepared/enabled, resulting in warnings:

clk_csr already disabled
clk_csr already unprepared

Fix this by setting the initial runtime PM status to SUSPENDED instead
of ACTIVE.

The clock will be properly enabled when the device is first resumed
via runtime PM (e.g., during MDIO access).

Fixes: f6bb3e9d98c2 ("net: pcs: xpcs: Add Synopsys DW xPCS platform device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index f4b1b8246ce96..fb80773379df5 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -285,7 +285,7 @@ static int xpcs_plat_init_clk(struct dw_xpcs_plat *pxpcs)
 		return dev_err_probe(dev, PTR_ERR(pxpcs->cclk),
 				     "Failed to get CSR clock\n");
 
-	pm_runtime_set_active(dev);
+	pm_runtime_set_suspended(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret) {
 		dev_err(dev, "Failed to enable runtime-PM\n");
-- 
2.47.3

