Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9A48E0C6
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049813; cv=none; b=S0akzLjVB8ge3mw1EeZCpgTJ0u3YDhIrPpnthW7lFICZoIBM8zoDf/5NWd9fxr1E5FdsY5QNZbAeA1m57X+CE0U06bNvpvbha6m09A1uUuWDfCKb6xBr0KO7ARNkbXYhvSmDDeSZxlGOGn9DJNDGjl0Hbpk3W2OTi29ClBOYkAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049813; c=relaxed/simple;
	bh=f+oWL0l2lQ4U824rI7f2G+wEgBL0XsHytujTRnyC4Po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqDttCEj/x1vdqBPiN1Qx9Jkx8kkn3BaBxXY7tRAtipe8LV3nJv5/P216aUxRYleK/CjzQMajjIfv4c/A3/R0hLiYlfD3EbG7k7XqFs3DqE+VbhvKmiTWY2E7rYI/0gfJ0h2e1VgqCU85R/ruAJAJcrx1k+KRWAij7aCdbpH2UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoA3lIu0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoA3lIu0"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-484392e3d33so5078075f8f.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789049810; x=1789654610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7pblcn7/kuaqKjgHIuNVXFQ3fC4U6ULeesMxuIl3oA=;
        b=SoA3lIu02V/+HIQIJPbl1OTBto7tEri+nXWpDjgW9ky9I9ucv1dUFtJ/Nn/7XidKc2
         vyJqZjKS9KjOJsGy0ixIw0XPyFN7G1sZNkwj+m4sbtOG1E80a+mgMhe+BKm8pIYuJnwL
         DX+mBfqd0gBXV6b4mH+TEH9iK8qumE/ewEsvSsQbM+ga04weCgzFzg+sCr20nbQTWFZX
         XvTkKz4jBL89Z4G6vTbzYP/JFHiuD3XHEqMQh7CZ87wDeoawiQasZHoynaFvsoAz6JdL
         8A0DeaY7FN7pmrMSNOpGarEIsodrBjYEcF53adw0OjsjeTqJSiK8AG2ZahIXVmYgs+XC
         hY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789049810; x=1789654610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7pblcn7/kuaqKjgHIuNVXFQ3fC4U6ULeesMxuIl3oA=;
        b=WfFtUlXrEqO9PdvYbDNbk4BVoCt3+OaELJ7idqMK7/b0lCp3LEKrQj1MEVrySmSkeD
         GqTZ22P11uD5W0gNc6wPXeEhuKcv9MmzrhR83r4/ntvfBw7fABaoeHB1vIpE1IGc4e8t
         Y2t89Sx1TBnP58IOrl/jh0ZGvnml6TcuIzUrA87CpH/exooq087uRw6oCpYvOQNYX80P
         3zXxWALsDkuCyYXCKknXX8bX7OCPN3M6HyfnKNLdad8nzrtRr03JcvVL6JAoKq3Y8sWp
         H67QNIpOUbgf2EDTbZUzquOyqOUL9lkr1vgxhtcuQ4nZRcrmY80VCM+mO1euER6S2F01
         WQtg==
X-Forwarded-Encrypted: i=1; AKwUvBxqC6BEOSI7a5bzvM1758OOGwlJv0LfwmnoUFOQW6NriQcbBshh9w0jxzIVkZpwRc8eXRY37NM=@vger.kernel.org
X-Gm-Message-State: AFuF++l2w0Lyzl16MuLGwfTtYdPtE0eZ9ZdpvzOGMttisZh4DRQmFbPc
	9/8X4A+7H0bmK0/+jYiVcDWsInKj3qsyV39Qhjhn0NCrSzMAMDjUerpP
X-Gm-Gg: AYBFou16ZIrhUivjJzaYvEmiFyVGeWaJa6uQxOo8TvOUiT7CZxEHFD7CO/IR/mN1Om9
	zxXzfIwN5kxndr4K0UJ13dENna7AS7liWcDmZa1hpJRQ4uND+CFChCxQYw/fh7dgUiYk8bu1mmi
	j4UbQ7XxuXIV+bt+jSsI7+8v1nJVUKCC2BZqkunpNnP89cyjPb0e9b0SrWYXuIxraxQ35Xbvqmr
	1Z5K9UsVeYJqJFOaE2H5HIv7MGZ6htle/quYT7Fh0jPAnvozUOLeTECPGHYanvbPjvI26WwRfGH
	M8XC0mklBtljKFNjuTaamDPRoZRPtBrxWbT6i/8p0NL6ce4J+6oz2fFePTwqPlL+77y2gFztVyB
	KKYO8IlWsuxMUrq0TikjDt5wcMnZbmNAgdWgziryuWumf1ptXJ6wJ0ELNgyBZTqMqg4R8J2r7a7
	6kWpBbvFb7JJIC4MfqSYWTHZ1qy01PTCOzRo6oQ4ip4pQiZb0dcTMUNnD2QnTItuAQOp7SoroIT
	tFb145VT85rKQzLCed8L5E0Yt2OVTykhxftOTlU6HXtdnQwbd2GWMSGSyB1cWNzboTysxtMxA==
X-Received: by 2002:a05:600c:190d:b0:49d:72d:9ba3 with SMTP id 5b1f17b1804b1-49d072d9bccmr328667225e9.14.1789049809381;
        Thu, 10 Sep 2026 07:16:49 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm293895575e9.4.2026.09.10.07.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:16:48 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Thu, 10 Sep 2026 16:16:42 +0200
Subject: [PATCH v2 1/7] of: property: fw_devlink: Follow GPIO nexus maps
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-fw-devlink-nexus-ready-v2-1-17ac82dbe226@toradex.com>
References: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
In-Reply-To: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, 
 Frank Li <Frank.li@oss.nxp.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Leonardo Costa <leonardo.costa@toradex.com>, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

GPIO consumers use of_parse_phandle_with_args_map() to resolve
specifiers through gpio-map properties. fw_devlink instead parses GPIO
properties as direct phandle references, so it records the nexus node as
the supplier rather than the mapped GPIO provider.

A nexus is a translation node, not the GPIO provider, and need not be
populated as a device. The resulting fwnode link can therefore remain
unresolved and indefinitely defer the consumer while
device_links_check_suppliers() waits for the nexus.

Use the map-aware parser for all supported GPIO property spellings. This
makes fw_devlink resolve the same provider as the GPIO consumer API.
Direct GPIO references continue to work because the map-aware parser
returns the original provider when no gpio-map property is present.

Fixes: 7f00be96f125 ("of: property: Add device link support for interrupt-parent, dmas and -gpio(s)")
Reported-by: Leonardo Costa <leonardo.costa@toradex.com>
Link: https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jbauradujrre@gc5nbdhhixaf/
Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 drivers/of/property.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 72cf12907de0..380df0861ab9 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1311,6 +1311,19 @@ static struct device_node *parse_prop_cells(struct device_node *np,
 	return sup_args.np;
 }
 
+static struct device_node *parse_nexus_prop(struct device_node *np,
+					    const char *prop_name, int index,
+					    const char *stem_name)
+{
+	struct of_phandle_args sup_args;
+
+	if (of_parse_phandle_with_args_map(np, prop_name, stem_name, index,
+					   &sup_args))
+		return NULL;
+
+	return sup_args.np;
+}
+
 #define DEFINE_SIMPLE_PROP(fname, name, cells)				  \
 static struct device_node *parse_##fname(struct device_node *np,	  \
 					const char *prop_name, int index) \
@@ -1361,6 +1374,15 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
 	return parse_suffix_prop_cells(np, prop_name, index, suffix, cells); \
 }
 
+#define DEFINE_SUFFIX_NEXUS_PROP(fname, suffix, stem)			     \
+static struct device_node *parse_##fname(struct device_node *np,	     \
+					const char *prop_name, int index)    \
+{									     \
+	if (!strends(prop_name, suffix))				     \
+		return NULL;						     \
+	return parse_nexus_prop(np, prop_name, index, stem);		     \
+}
+
 /**
  * struct supplier_bindings - Property parsing functions for suppliers
  *
@@ -1416,7 +1438,7 @@ DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
 DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
 DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
-DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
+DEFINE_SUFFIX_NEXUS_PROP(gpio, "-gpio", "gpio")
 
 static struct device_node *parse_pinctrl_n(struct device_node *np,
 					   const char *prop_name, int index)
@@ -1436,8 +1458,10 @@ static struct device_node *parse_gpios(struct device_node *np,
 	if (strends(prop_name, ",nr-gpios"))
 		return NULL;
 
-	return parse_suffix_prop_cells(np, prop_name, index, "-gpios",
-				       "#gpio-cells");
+	if (!strends(prop_name, "-gpios"))
+		return NULL;
+
+	return parse_nexus_prop(np, prop_name, index, "gpio");
 }
 
 static struct device_node *parse_iommu_maps(struct device_node *np,
@@ -1452,8 +1476,6 @@ static struct device_node *parse_iommu_maps(struct device_node *np,
 static struct device_node *parse_gpio_compat(struct device_node *np,
 					     const char *prop_name, int index)
 {
-	struct of_phandle_args sup_args;
-
 	if (strcmp(prop_name, "gpio") && strcmp(prop_name, "gpios"))
 		return NULL;
 
@@ -1464,11 +1486,7 @@ static struct device_node *parse_gpio_compat(struct device_node *np,
 	if (of_property_read_bool(np, "gpio-hog"))
 		return NULL;
 
-	if (of_parse_phandle_with_args(np, prop_name, "#gpio-cells", index,
-				       &sup_args))
-		return NULL;
-
-	return sup_args.np;
+	return parse_nexus_prop(np, prop_name, index, "gpio");
 }
 
 static struct device_node *parse_interrupts(struct device_node *np,

-- 
2.43.0

