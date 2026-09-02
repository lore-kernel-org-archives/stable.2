Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5B47ACF8
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349354; cv=none; b=plugYHjuEjVAta9DATFAPuWa87eVPYPCAzml/aHh65DCnYQJM3Dsuk6I+JmyhOJLGsR+JjoXdUCekyInfxMcoIksq4R4jtNclihMVoij4+AbtK+8lOUraaBW3WyAlcohttM+EPqpkiHlhNt3ey105bL3tZScxzrq332sIk9K3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349354; c=relaxed/simple;
	bh=NfyudVlM1yxKj5OTCD08HZwEQLKw64XdIbJ0S9NfQl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUgd7GAZ0ESXTkJjxhfXDw5FDfHwVbzOxWwfXUY0irTE8smnjLIAabYgK63Dgk69gDP6QLMv6XdCa17pZ91To7m4lCNfowpM2fvl+GSJUICCg0CkNqW0VRLx/+Bbxwdy4yEWxwUGIh8TuSUXfA9CGGuAySLEBsakDWIOWNsJfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5jz9n29; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5jz9n29"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so9787375e9.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 04:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788349348; x=1788954148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XyxU90qE2pDTOzsNo7+C4R6hGdb1tidiljFavckLhOQ=;
        b=K5jz9n29INtUEqSS97sa3DSNz0S+sH9cInbVshmil0CJISCe23pU1Bqa24wrEwqNMS
         8Pqp3FGKaZDtBpeutCkOwwtKp1N3VTwi1ySWYyn0mkX5es8udaV342fh7XdknDV7AX+y
         pKhjGPf6/ZD7DlGtMoV0tkLdTl1XP0zd+fjfP5NKhpwG9jqnqGSzp6enD6qVCdMbGg7P
         SoyIqiaNT/65fHl2K1xH2m9+3s8+5lEZp3g4bOhkK3Qlnhgt2vNcblCfJE0tTOWmCoMQ
         2ngms8q61LXHyVxaL+yAd5yAl16j5W28NLiBWm0iWQpMHspDb/Aoc63rWcyDbpYVVPhL
         Cxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788349348; x=1788954148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XyxU90qE2pDTOzsNo7+C4R6hGdb1tidiljFavckLhOQ=;
        b=bCJ2hSxkwnFVMIFW45rR8+7cYW/UdU+97MAFuHNRnNBKUWI74VCkphORrsiAAS1ps/
         zuNVRk6TkSM5kn0mkDl1WrM/GT338nz4pzsi0zouyO4/nyhnKv3oMfuRJDbztDsr1bb3
         FADMj9hWJi4KBgzN1OTPKHCyEgQpraRRa5FDBpZCrweAgQm0E1ibvL4AuDdMc8qWZsHu
         TMjl1zqKEYtee172Hy2JbcOl5atLwIJL6bCxD4RjunSMXc2t4qS+nDNluAFNIN/x5M4Y
         UsNSd0opLyt6bNEp/3dNfEZTUXNDkfKjImEXAFZMiQFksdMGp/tGUErsm0EbPT77g3IS
         a2yA==
X-Forwarded-Encrypted: i=1; AHgh+RoQ48hlnk7m0j94WQmW0IzEEMmwlw+chABCEbMlcIfuVqWvVgPTOUHPU7+B0H6n91C7/QI/Urk=@vger.kernel.org
X-Gm-Message-State: AFuF++lEz8+eCdfBopy3Sq5Vv1yrBda/TBe2fFrv+n1F4BoNSWpgzliT
	8b67iLvuLVjorBErUKb3aNLL/kN8/sy+mBkd6te10boGTxlP2oh+7Vmc
X-Gm-Gg: AR+sD111aCuprs/JTqX59K0MM2pi1jdS64/2vRhuetIogHPZG0lpqq7sfe8ba/89tJ8
	TbdwJNadGjZ3Lbb3hAymRv4G6wT8Ukv5ZQiS6M8OeTzCVqrWvTATL9Oz4vPKKTlfhJwYZ7X47mB
	xIFJYS/2wY6Nkkx2dKOLeB5MWgUEwoZPZPztp7R025zHmAXGjV2WGZ/aWlE2Ip61/sDxbu+X1bz
	UzzVq+M5IC2f1mXIfRMpzhoDTPAXe65Kmy92KkrPZZvWlO9WSVYzgqNf+/HQDwxuCWJOfWZS3r0
	hVnngTGvKOMHjZfjTyNv0tAwhA0jxhZJXxOtWeDy8xbT/iNUkznvNPtHN3ykQ+iB51h7v1XjNJp
	w9fl11mD+yaiLBHFbtEez9aLeLPKnIV0i8SZ+FUyh0aonJ31Mp4+ZS3HriXhwk95FAJQhbVDDHD
	cBxAEyuh5io3gy2eWtHCKM46ay+POUGVr+TUwLvOFPPmWrCyx7DDYcSkzvE+q5+yNNDpK9hSvsj
	vqtjWWdx+RgF/Bck0Vpl1JBHAUeSzgYXRdtd2qOSNlvysHaNTjkYwVIOymj5l0=
X-Received: by 2002:a05:600c:4e86:b0:49a:77c1:d246 with SMTP id 5b1f17b1804b1-49ce5852589mr70729315e9.15.1788349347944;
        Wed, 02 Sep 2026 04:42:27 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5952560sm40390935e9.3.2026.09.02.04.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 04:42:27 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Wed, 02 Sep 2026 13:41:40 +0200
Subject: [PATCH RFC 2/2] of: property: fw_devlink: Follow PWM nexus maps
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-fw-devlink-nexus-ready-v1-2-68fe1996e78a@toradex.com>
References: <20260902-fw-devlink-nexus-ready-v1-0-68fe1996e78a@toradex.com>
In-Reply-To: <20260902-fw-devlink-nexus-ready-v1-0-68fe1996e78a@toradex.com>
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
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

PWM consumers use of_parse_phandle_with_args_map() to resolve specifiers
through pwm-map properties. fw_devlink instead parses the pwms property as
a direct phandle reference, so it records the nexus node as the supplier
rather than the mapped PWM provider.

A nexus is a translation node, not the PWM provider, and need not be
populated as a device. The resulting fwnode link can therefore remain
unresolved and indefinitely defer the consumer while
device_links_check_suppliers() waits for the nexus.

Use the map-aware parser for pwms so fw_devlink resolves the same provider
as the PWM consumer API. Direct PWM references continue to work because the
map-aware parser returns the original provider when no pwm-map property is
present.

Add OF unittest coverage for mapped and direct PWM suppliers.

Fixes: e71e46a6f19c ("pwm: Add support for pwm nexus dt bindings")
Reported-by: Leonardo Costa <leonardo.costa@toradex.com>
Link: https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jbauradujrre@gc5nbdhhixaf/
Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 drivers/of/property.c                       | 11 ++++++++++-
 drivers/of/unittest-data/tests-phandle.dtsi | 16 ++++++++++++++++
 drivers/of/unittest.c                       |  4 ++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 380df0861ab9..d5e89beb17f9 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1331,6 +1331,15 @@ static struct device_node *parse_##fname(struct device_node *np,	  \
 	return parse_prop_cells(np, prop_name, index, name, cells);	  \
 }
 
+#define DEFINE_SIMPLE_NEXUS_PROP(fname, name, stem)			  \
+static struct device_node *parse_##fname(struct device_node *np,	  \
+					const char *prop_name, int index) \
+{									  \
+	if (strcmp(prop_name, name))					  \
+		return NULL;						  \
+	return parse_nexus_prop(np, prop_name, index, stem);		  \
+}
+
 /**
  * parse_suffix_prop_cells - Suffix property parsing function for suppliers
  *
@@ -1426,7 +1435,6 @@ DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
 DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", "#nvmem-cell-cells")
 DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
 DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
-DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
 DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
 DEFINE_SIMPLE_PROP(leds, "leds", NULL)
 DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
@@ -1438,6 +1446,7 @@ DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
 DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
 DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
+DEFINE_SIMPLE_NEXUS_PROP(pwms, "pwms", "pwm")
 DEFINE_SUFFIX_NEXUS_PROP(gpio, "-gpio", "gpio")
 
 static struct device_node *parse_pinctrl_n(struct device_node *np,
diff --git a/drivers/of/unittest-data/tests-phandle.dtsi b/drivers/of/unittest-data/tests-phandle.dtsi
index 163ef07be16d..7cb3e19554b6 100644
--- a/drivers/of/unittest-data/tests-phandle.dtsi
+++ b/drivers/of/unittest-data/tests-phandle.dtsi
@@ -85,11 +85,19 @@ gpio_provider: gpio-controller {
 					#gpio-cells = <2>;
 				};
 
+				pwm_provider: pwm-controller {
+					#pwm-cells = <3>;
+				};
+
 				test_nexus: nexus {
 					#gpio-cells = <2>;
+					#pwm-cells = <3>;
 					gpio-map = <0 0 &gpio_provider 1 0>;
 					gpio-map-mask = <0xffffffff 0>;
 					gpio-map-pass-thru = <0 0xffffffff>;
+					pwm-map = <0 0 0 &pwm_provider 1 0 0>;
+					pwm-map-mask = <0xffffffff 0 0>;
+					pwm-map-pass-thru = <0 0xffffffff 0xffffffff>;
 				};
 
 				gpio-compat-consumer {
@@ -111,6 +119,14 @@ gpio-direct-consumer {
 				gpio-singular-consumer {
 					test-gpio = <&test_nexus 0 0>;
 				};
+
+				pwm-consumer {
+					pwms = <&test_nexus 0 1000 0>;
+				};
+
+				pwm-direct-consumer {
+					pwms = <&pwm_provider 1 1000 0>;
+				};
 			};
 		};
 	};
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 487f3b629a73..508ebc7581c8 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -759,6 +759,7 @@ static void __init of_unittest_fw_devlink_supplier(struct device_node *tests,
 static void __init of_unittest_fw_devlink(void)
 {
 	const char *gpio_supplier = "gpio-controller";
+	const char *pwm_supplier = "pwm-controller";
 	struct device_node *tests;
 
 	tests = of_find_node_by_path("/testcase-data/phandle-tests/fw-devlink-tests");
@@ -773,6 +774,9 @@ static void __init of_unittest_fw_devlink(void)
 	of_unittest_fw_devlink_supplier(tests, "gpio-direct-consumer", gpio_supplier);
 	of_unittest_fw_devlink_supplier(tests, "gpio-singular-consumer", gpio_supplier);
 
+	of_unittest_fw_devlink_supplier(tests, "pwm-consumer", pwm_supplier);
+	of_unittest_fw_devlink_supplier(tests, "pwm-direct-consumer", pwm_supplier);
+
 	of_node_put(tests);
 }
 

-- 
2.43.0

