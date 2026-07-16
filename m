Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA640860C
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197280; cv=none; b=oM4alSZHKWGB02D8ZECF38JVFQdCzM/lm92CWjPGpq47Gssx+9qRvfA2xiNByt2wWxgbyYaxhIfDA4uQJaDbW5RnBWThWOtpfMSbGagLpNTZCLjoCGesHasLiBXVxMJnqkpqhH3gQHxr0sqaru4fw0uFgZBu7o+Rs7R03MW0lvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197280; c=relaxed/simple;
	bh=hY65Q8DL8UNfZVFsi0xMC3qLRY+v4k3EZLpVlcQ75ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifhPYFR1ZS32LwtiqoSLNrOxgtSpOtE8z2gnu/5wSxFsO5nASDzLYtsU5vZKMmyXlKHos/cUO5zsoViMZYPM6klL7LBKlyrOvsE3zveXGiM9xa0AMpXYmEkIFbMbUNIny+EARsj9fgHo8CpGTg7rr04+yXLX3H2SNH5/5iA2uK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgQ6FmV0; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgQ6FmV0"
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-38dc7618a1dso2292416a91.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 03:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784197278; x=1784802078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cFSo7gayLvsIlyLfjq185Phbk4IPPO2uTWuq5Wwy6eg=;
        b=QgQ6FmV0+eXlDrF8KE4QaM5L9xxIu90VSkWgXNTNfnHBdegsrdvvD8rE2g93lB9xhh
         aBS6N6WH5zlI0nSGSUzvuEjMmeVFh3VgzOuLaZjUqa5Oo2oBQ3nW1+JJfhMmD065gq7e
         xcIJmnKBGu49avtnXkvTlV/CgF41dZ0yOHeplGLhkA2MSBNqiI0QbFYGXydyPM0/6T5l
         L4JsLXSDayJhAhxClKGQWOphMDzDPsumfqaC3MEb9DYrBVIzoogVlp1XRmu6ByBcI7Z5
         2+11dDYgUR/EuT9CoZMOYeJwsKXkgZ0ecJ+sKE1S7Wym/b4IZSg/tOKaiXXzfwbmNczg
         jg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784197278; x=1784802078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cFSo7gayLvsIlyLfjq185Phbk4IPPO2uTWuq5Wwy6eg=;
        b=pOa+vU705hmS2Q63iIUFjogbJ4Xh3wpg86F0d+d1UXijVDihTzyqbmCsPMMIZVp7aB
         TrqQWFw/3aEBywmlqgC7R4GHZMcjLWT/EJG2J8YOVkQ43oKBl2segZfmdq00FUivw5qq
         Va2ShwZarA4ebWW9wKVXZAouU0Pf3YuFYWePGrO+cZFMRzbcR0ljDc5T543TGkJl3Q4Q
         z+6w/OiutVA9h5LfaX1T1RO+S62X7UZmHeibU2B0+n/ZYQLnYbD8zcX38bBe7bvQ/2RS
         vzpA+DPThClvpFG7WeDZ9zZ5WxZeN38y4HqFArDD4ozJaZ/rEo9I5rYLTdjCjXEtHG8P
         vK5A==
X-Forwarded-Encrypted: i=1; AHgh+RofUXMyJ8h2G1IowIajK+S8TKtaLSZk216SQ05ldbGB6AHDfGop/jpoFAuBEgJY+YpUgiphNgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJGCoypcEXx8/FFywHbU8+pr4dzLtRHuYR5nK9jZbZg4PXkKeb
	kjHDpZ3ShpV/eQyBhRslk+BJxYnRCzivLcHtsjCUhsF0e4DvBG6feBba
X-Gm-Gg: AfdE7cnKFUQIHNR0WpeBPhg+Rx5Zst3e0YtUp9PbP4F48S2s6RONYKfCn6oJSqVigZj
	QKb93fOmy2eI3V8GmP5gtKvUTsXIIm9LuhoarJ5s/pW+WafMy+NwgRXnyMqL1cRuE6jZIOB+MbB
	YpV7EkSIMXoxfXcc28ahaCNZ4NXCcKRY7GLfIGFy2yT6Gm74Rqs8B+lMd2qKftKW4Jt0p/KheFY
	6Q3mHAnyL9yTq1ppL/onBbCWGhOUlJF9Ao+WXWArTE4IBX0ZRodoisXs+vUZjFT9EtpgOSyIFrB
	AZhW+FotMKJK2mh6+jfzGxRXehkK9+Qs1u6y+6O49iTf7MXJRZWXYtJKyyn3BdU0KzB9b/UL+H2
	nMeeCgC51TeNByBEYHSit6xeWrqVYKdXlKrSMWCo1C5+MxHeTNaStQXFVkzsAvKc95s6tvTDTq3
	Y85foxR+lx
X-Received: by 2002:a17:90b:5863:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-38dc73bcfdfmr19331163a91.1.1784197277956;
        Thu, 16 Jul 2026 03:21:17 -0700 (PDT)
Received: from workstation.. ([182.180.105.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e500e8fsm11626180eec.6.2026.07.16.03.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:21:17 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Ali Tariq <alitariq45892@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] PCI: starfive: Fix resource leaks on error paths in host_init()
Date: Thu, 16 Jul 2026 15:20:53 +0500
Message-Id: <20260716102053.185276-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714113029.326207-1-alitariq45892@gmail.com>
References: <20260714113029.326207-1-alitariq45892@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

starfive_pcie_host_init() acquires the PHY, clocks/resets, and an
optional regulator in sequence, but does not correctly unwind these
resources when a later step fails.

If starfive_pcie_clk_rst_init() fails after the PHY has already been
successfully enabled, the function returns directly without disabling
the PHY, leaking it and leaving it powered.

If regulator_enable() fails for the optional vpcie3v3 regulator, the
failure is only logged; the function falls through and returns
success, leaving the driver believing the regulator is enabled while
continuing to configure PCIe hardware that may be unpowered. This
also leaves the clocks and PHY enabled with nothing to clean them up.

Disable the PHY on the clk/reset failure path, and disable the
clocks/resets and PHY, then return the error, if the regulator fails
to enable.

Build-tested and boot-tested on StarFive VisionFive 2 v1.2A

Fixes: 05a75df4182e ("PCI: starfive: Use regulator APIs to control the 3v3 power supply of PCIe slots")
Fixes: 39b91eb40c6a ("PCI: starfive: Add JH7110 PCIe controller")
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
Cc: stable@vger.kernel.org
---
Changes in v3:
- Add Fixes: tags for both introducing commits
- Add Cc: stable@vger.kernel.org

Changes in v2:
- Use a shared error-handling label instead of duplicating cleanup code
---
 drivers/pci/controller/plda/pcie-starfive.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index ba8ef7842e35..fab44054a5de 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -304,12 +304,14 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 
 	ret = starfive_pcie_clk_rst_init(pcie);
 	if (ret)
-		return ret;
+		goto err_disable_phy;
 
 	if (pcie->vpcie3v3) {
 		ret = regulator_enable(pcie->vpcie3v3);
-		if (ret)
+		if (ret) {
 			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");
+			goto err_clk_rst;
+		}
 	}
 
 	if (pcie->reset_gpio)
@@ -379,6 +381,13 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 		dev_info(dev, "port link down\n");
 
 	return 0;
+
+err_clk_rst:
+	starfive_pcie_clk_rst_deinit(pcie);
+err_disable_phy:
+	starfive_pcie_disable_phy(pcie);
+
+	return ret;
 }
 
 static const struct plda_pcie_host_ops sf_host_ops = {
-- 
2.34.1

