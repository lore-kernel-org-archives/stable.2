Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6D46D555
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349351; cv=none; b=tw+pL/8xh+P82wIMh1PrSvrHmpgkKFOiZ8BjMB3v1ufKEtD4eYxR6KoOWVToyd337MQ4pAH2lWqj6qpXKkZIrs9BErO6/mlnCgaf3q3vL3kYcOxYum1cES73sYTwBB7gYRFHrP2WZ6C3/+5/L84mZCyp6OpoTL+t05PNeZCAiMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349351; c=relaxed/simple;
	bh=0YfZ6I8/xNI370aVrOszFzEznLcSoEqSHveLG9FC+Xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ScFhzygfOiFGCL7yYJkpj3X/AHFNBSnytpN2/+/abFuYtCVa4ArqYbGEIIdkATS4kUq85c3pc+nhCjm+hmTb5TzRRJaJbynIuSzhgRvjTql8PXRF3P/II8t64bYq1T0r9YALySVaUbEg1GQfeGn6sx3lLPd/TWakgbBh7bRTSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b82Tp/lX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b82Tp/lX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b8be0409fso6674265e9.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788349347; x=1788954147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tNaIMy3FNUffxv5Y47n7ZPK6WMtaZg+3IuJCsW/mzGY=;
        b=b82Tp/lXgLcznDS/HjsGDU9Ko3ygh7w+HD6ig7ZkW3bSxsxEC5an7kiqeMe5fCAuJk
         JDLO3Nc22yKib636FvVlsvCINHY21o9Lbgkjj2EvCdc6U6rnEEhbCoB881DotVDXQs9c
         vju5q+98sWloz6OnU7WdCdgfICUK5Mx89s7y1dERG3dt7JQCzMCt3ge/uoaRz0BJlhVw
         NINOyzqZRQbexTYKtVfzgqbFEBEAzJzQuNkg5IrfPMFPx2jGLil0h3H7KR9wbwYAjWtz
         0+uEiXvz04WsF91rPrdCsG2JfdImmIWq4X82yf42sylNx1osT8hewEbbc0vHcc7qRZEi
         cq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788349347; x=1788954147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tNaIMy3FNUffxv5Y47n7ZPK6WMtaZg+3IuJCsW/mzGY=;
        b=fNXkF2P5JKa4TarZhYmqyb01o9HheK/esV9wDaDmAya3evPlm5ptpn+QwASptC3qTP
         UeXNeitlw34b/0kGfLLLTFbB2r8K9DiquUDvWsuxtZBc79N/pVxhTaIkZ3W7zyLC0B/h
         VFSz2uvzyTgu4RodyFMohW1JwHXXDUmIr0fC9inX+6st2mOPYp5cfA5d5LyfnySMlQDH
         fOyQVxxYst92mRrCTSN/zygw359kOFFU/N2VLaTx1PEmrauT5h+BHVUxGydGOYCldiXk
         mu5iuxSLjVSdX4oE/GFBDjCVC5LdZdQWnt23DQ4dTmwKN81ATZmorRtfXnBGPn8LZIN1
         srLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrsa0tPIoOrUa4368eKQrne5x0svi5XSFH3eMuATd2TWGZJ6IWvd+Td9aRy+8pFHEf3Bc+FWbQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l0m7yh0YtOHHJwfQ4b6Z4hJJVhc+T9dvDwH29UZSmBXAY06/8w
	VGh46dfMmzhD4r8oEDo0+BGiOnYfB1jGPYwpi512QEPxyXuLNxBy7gxJ
X-Gm-Gg: AR+sD13w8aOtwl2LAyIsJXZgto9CYY4OT8kRlqDWt5W5m6r8J2mfTZYzUJsh1y9soVR
	zE8MdhIVEDfcUZTztEqqmKrLScdajKEtyn9iPnsiB7XreKVI3mMqqfz9rbmnDfgC7d76K8wOOdt
	nda3bPBFDM9U6Kv3c81ZRen8C/CWIYsMGeVqrz+LJ2m0lUR9fTjjUo1sB38Lvqne0t7kY7Pmk0H
	KH6anRHI599MU+Dvda4UNBgxN4a5hfkEWZ5N9chI1BXKVn2BXaNF29JNvI6ikH5LE5PidKJblyP
	fs8KcqApTZdjQJ9/bNbYXStIwXz7WWWrzfIQ7QvOQhU1LLZcn1bwATdfIC3G+N1hSusRzLSl/Sj
	TuaAuaO7vEfxdwZXNwjnAyrquylmAEQuvP/pOdeyjBBSQgarg7XzoaENfGOirwpjJXth8oM+vdi
	BdDcjCJl5BnducBbF5QQdFmPRwmAheeIF+ds/aAvdbIZiaBL9h1PJCeV3oacxcOgwGxS7CiFF7x
	uUTx6C7z5Db7epHlLPxjgaHfw1SJac7iK5iWcwlFQytSJ5M1qb4C6xtgGVNWmA=
X-Received: by 2002:a05:600c:3f08:b0:49c:e1ed:26b1 with SMTP id 5b1f17b1804b1-49ce5850cefmr77892325e9.16.1788349346888;
        Wed, 02 Sep 2026 04:42:26 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5952560sm40390935e9.3.2026.09.02.04.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 04:42:26 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Wed, 02 Sep 2026 13:41:39 +0200
Subject: [PATCH RFC 1/2] of: property: fw_devlink: Follow GPIO nexus maps
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-fw-devlink-nexus-ready-v1-1-68fe1996e78a@toradex.com>
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

GPIO consumers use of_parse_phandle_with_args_map() to resolve specifiers
through gpio-map properties. fw_devlink instead parses GPIO properties as
direct phandle references, so it records the nexus node as the supplier
rather than the mapped GPIO provider.

A nexus is a translation node, not the GPIO provider, and need not be
populated as a device. The resulting fwnode link can therefore remain
unresolved and indefinitely defer the consumer while
device_links_check_suppliers() waits for the nexus.

Use the map-aware parser for all supported GPIO property spellings. This
makes fw_devlink resolve the same provider as the GPIO consumer API. Direct
GPIO references continue to work because the map-aware parser returns the
original provider when no gpio-map property is present.

Add OF unittest coverage for mapped and direct GPIO suppliers, including
the deprecated singular and unprefixed property spellings.

Fixes: 7f00be96f125 ("of: property: Add device link support for interrupt-parent, dmas and -gpio(s)")
Reported-by: Leonardo Costa <leonardo.costa@toradex.com>
Link: https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jbauradujrre@gc5nbdhhixaf/
Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 drivers/of/property.c                       | 38 +++++++++++-----
 drivers/of/unittest-data/tests-phandle.dtsi | 33 ++++++++++++++
 drivers/of/unittest.c                       | 67 +++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+), 10 deletions(-)

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
diff --git a/drivers/of/unittest-data/tests-phandle.dtsi b/drivers/of/unittest-data/tests-phandle.dtsi
index 554a996b2ef1..163ef07be16d 100644
--- a/drivers/of/unittest-data/tests-phandle.dtsi
+++ b/drivers/of/unittest-data/tests-phandle.dtsi
@@ -79,6 +79,39 @@ consumer-b {
 				phandle-list-bad-args = <&provider2 1 0>,
 							<&provider4 0>;
 			};
+
+			fw-devlink-tests {
+				gpio_provider: gpio-controller {
+					#gpio-cells = <2>;
+				};
+
+				test_nexus: nexus {
+					#gpio-cells = <2>;
+					gpio-map = <0 0 &gpio_provider 1 0>;
+					gpio-map-mask = <0xffffffff 0>;
+					gpio-map-pass-thru = <0 0xffffffff>;
+				};
+
+				gpio-compat-consumer {
+					gpios = <&test_nexus 0 0>;
+				};
+
+				gpio-compat-singular-consumer {
+					gpio = <&test_nexus 0 0>;
+				};
+
+				gpio-consumer {
+					test-gpios = <&test_nexus 0 0>;
+				};
+
+				gpio-direct-consumer {
+					test-gpios = <&gpio_provider 1 0>;
+				};
+
+				gpio-singular-consumer {
+					test-gpio = <&test_nexus 0 0>;
+				};
+			};
 		};
 	};
 };
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e255f54f4d76..487f3b629a73 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -10,6 +10,7 @@
 #include <linux/dma-direct.h> /* to test phys_to_dma/dma_to_phys */
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/fwnode.h>
 #include <linux/hashtable.h>
 #include <linux/libfdt.h>
 #include <linux/of.h>
@@ -710,6 +711,71 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	}
 }
 
+static void __init of_unittest_fw_devlink_supplier(struct device_node *tests,
+						   const char *consumer_name,
+						   const char *supplier_name)
+{
+	struct device_node *consumer, *supplier;
+	struct fwnode_handle *consumer_fwnode;
+	struct fwnode_link *link;
+	unsigned int link_count = 0;
+	bool found = false;
+	int rc;
+
+	consumer = of_get_child_by_name(tests, consumer_name);
+	supplier = of_get_child_by_name(tests, supplier_name);
+	if (!consumer || !supplier) {
+		pr_err("missing consumer %s or supplier %s\n", consumer_name, supplier_name);
+		goto put_nodes;
+	}
+
+	consumer_fwnode = of_fwnode_handle(consumer);
+	fwnode_links_purge(consumer_fwnode);
+	rc = fwnode_call_int_op(consumer_fwnode, add_links);
+	if (unittest(!rc, "failed to add links for %pOF: %d\n", consumer, rc))
+		goto purge_links;
+
+	/*
+	 * fwnode_link_lock is private to the driver core. These test nodes are
+	 * isolated and no one should modify their links now, so it is safe to
+	 * inspect the supplier list without the lock here.
+	 */
+	list_for_each_entry(link, &consumer_fwnode->suppliers, c_hook) {
+		link_count++;
+		if (link->supplier == of_fwnode_handle(supplier))
+			found = true;
+	}
+
+	unittest(link_count == 1, "%pOF has %u suppliers, expected 1\n", consumer, link_count);
+	unittest(found, "%pOF is not linked to supplier %pOF\n", consumer, supplier);
+
+purge_links:
+	fwnode_links_purge(consumer_fwnode);
+put_nodes:
+	of_node_put(consumer);
+	of_node_put(supplier);
+}
+
+static void __init of_unittest_fw_devlink(void)
+{
+	const char *gpio_supplier = "gpio-controller";
+	struct device_node *tests;
+
+	tests = of_find_node_by_path("/testcase-data/phandle-tests/fw-devlink-tests");
+	if (!tests) {
+		pr_err("missing fw_devlink test data\n");
+		return;
+	}
+
+	of_unittest_fw_devlink_supplier(tests, "gpio-compat-consumer", gpio_supplier);
+	of_unittest_fw_devlink_supplier(tests, "gpio-compat-singular-consumer", gpio_supplier);
+	of_unittest_fw_devlink_supplier(tests, "gpio-consumer", gpio_supplier);
+	of_unittest_fw_devlink_supplier(tests, "gpio-direct-consumer", gpio_supplier);
+	of_unittest_fw_devlink_supplier(tests, "gpio-singular-consumer", gpio_supplier);
+
+	of_node_put(tests);
+}
+
 static void __init of_unittest_property_string(void)
 {
 	const char *strings[4];
@@ -4533,6 +4599,7 @@ static int __init of_unittest(void)
 	of_unittest_dynamic();
 	of_unittest_parse_phandle_with_args();
 	of_unittest_parse_phandle_with_args_map();
+	of_unittest_fw_devlink();
 	of_unittest_printf();
 	of_unittest_property_string();
 	of_unittest_property_copy();

-- 
2.43.0

