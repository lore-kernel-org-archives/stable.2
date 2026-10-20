Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501227;
	b=evpt3IcpeBSOIP9XTeu25jcm7CfF7cvaOzit9WmFUtjZRkOGIVXjUmcKdoAQN37fA+Mi
	 JiID0eQoEnAAIMwxM6SZGj0eYHxXmcLQiNPyLLx2jUA79OQt9O9y6VgiEuXz8oFDwcvfp
	 NkY4MsK2mLp+gsNPnM/YbE1FlvaOvWiLHqClxBfk/8i7jVtR08kcLQ/k5RUgiMyqz33sP
	 si0L7ZtpLpKHWsZeYIl5bzfZwR+SF03XzpBAE0H2lvoDGZIcayftVRIpGUvG+ZUlfluXS
	 DzsmeHNRWkoD2hIWJBz4dG6Qf4cuDY+P5/etXLD9HxQY8Uq2VYFiMve56Gb9H552Ftg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=QCVq48Hz4LWuB9OejIcWVFo10GsQgpT90RAtohh2YF8=;
	b=xoOV6MujwzTGcW9nrSbKiGfTPaPpj59RL7hJcQwxm2lnmHdfBxY4U+iaDNCpkwB0bbzM
	 hyWSxShMvMPNil2k4lbt1ajwJzC5eqyenh2E5spKDtP9T0qMUwVDFdGuLzo0oEGVl4fJV
	 8NZ37l8iAfk7LPyxe3qQfu+ye2PJxOP1JJFpffUn+EMOdwk1t8ta3amAMFRXZj7SupWiX
	 xDLrpaYHswZQhgBX4Niika8E+y39XGZrINpS7vAJUfnaXNaSQowdV+xrwSN2ND5ODyuG+
	 TLvzUtCLE8FDheVuFMrCvdxjhk8E1AaZhCdqVDk/IABHy+vmOsqPcfVgtI1UVnaLJUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ou3lAhYX;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42D60A3834
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED42D60A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ou3lAhYX
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso486549f8f.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792501225; x=1793106025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QCVq48Hz4LWuB9OejIcWVFo10GsQgpT90RAtohh2YF8=;
        b=ou3lAhYXfr1/j4oQcWn4lcxmFC2fRwECqiBFa15n/+ItE2kULX3IyewYF4VAU/XBNa
         agICyytnveBnQdZlLGNxF+mAP9Dvdw1PLZbMOcxWTfx6p55vqzBSx4TwBEMz+ucjNqRP
         rtEamXPCpH9Fbrsl6t1cr0wDEfT+lzhDKSKaeVQFjXO/7tJEkVW/7pzKJkzCeYoEVogI
         9OYBe7le3Qw8uPChl5GbrmO+7F8/wn1O11gANpi2Q84ck3Kca9n4vQqtAXwcC3/9lEOy
         Uazm3kSlfM8OR0ymWeowO8VC4lNoqtWbjSFRc32wEMm8dtcfQeX1tLpebvBscyR8zipQ
         BABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501225; x=1793106025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCVq48Hz4LWuB9OejIcWVFo10GsQgpT90RAtohh2YF8=;
        b=d4zrQQa/lFpgBNIIONwwEco/12uWmPvIvXMQzZ2m2vXXMjdyZHHPvbeu8/rcsJ4DpM
         XColVoXNkRap1CKLAp6D9W2BMTOrTNyPXl8ZFkRgq0NKxj7S1Jtinn/IUldypgP7+208
         ckNe6qUbhLBsTwEE2v0aR33hsUaEv94c5vo393zE61Vya0b45qXCvtapox49hsX9VGwT
         AegFq6rfGzLr3skHdzl/bmOQI6XYO6KHjJD5dw/QO1/wiJZBPYgFV9DQqFnMX7gMhnln
         uX4HbdUqqdBydoOKubKZz8hz20h7axyzB+wtZSQmgCkEG4PRH8TEOqd2cNdrbF+X0cng
         U0VQ==
X-Forwarded-Encrypted: i=1; AKwUvBxh8npl+XBpVtlIhYe+Y2Mo6u5DhAjqy9gekbqQmem/MUhXi5lCGuf8tOGSiXSKlutFbankYRk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkmNL6yo8UBfw3e6/gyQlYbXRFuU9RDNlvV4RJzkvLhpnvFDFG
	zcDuMl10iXWNj0ucTY0VdkNANcTkuer7kKeTcg0VBAalAEeyClOM94pV
X-Gm-Gg: AYBFou3GfGYOb1t0fW7Fx2s2LaNzCg7ornx1FNs48Fx8Wx4LRKTZ+dc60wjgZMfYE+h
	6xGPnb3nhz/E00YBv2Ndbb+R4719fwmdWyXkc1Jl4DxqoBHj0FFwGIWzdk1KeaYnSqmS6kE3gzS
	pc74kzn1A/z3gyUURpe/4LhEk4etZGbSrGpMo8K4YYMQJD2CnncFnwcTvAhzf7rt/K8p7AULP1k
	2hHIa0N47IvJ8R3Txr8CXULAdPsCk4Kb3sskE4uDgdAnyaVb3zju8Piesl7zHGU8/coeu1WrWYy
	/6eEaQ4m0KE/Scb9taYsxit7NTJmiEl9NcyNIJMJpfrcoBaw+mBV4MV+9jAhmWg8y0s0y0SKGcj
	ItFAdtVQuqbXuM+E8zD4LgG/LSxfCEguf5b7g7CcR1585tKQehvG43IN2U68p1MlYvilLhnVDml
	Xx5ke7lj8B8SAeNOKToneCFCwq5LB12nJwkLRx0PcJW9kiixFRoYU2A+4WUXSpyGDvbgUCds1yn
	XfOfpib1q2Ew+iGnH1wsk28Xp/nSFxRQ+DZsQZ/rKAbnGrCOjoqRsuh3xVqKA7T5TEdZ9PMScw=
X-Received: by 2002:a05:600c:255:b0:4a1:e478:7878 with SMTP id 5b1f17b1804b1-4a1fa092b29mr12610135e9.18.1792501224980;
        Tue, 20 Oct 2026 06:00:24 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e91sm6114754f8f.54.2026.10.20.06.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:00:24 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Tue, 20 Oct 2026 15:00:16 +0200
Subject: [PATCH v3 5/8] of: property: fw_devlink: Follow PWM nexus maps
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-fw-devlink-nexus-ready-v3-5-fd6f1c17e16d@toradex.com>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
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
 Leonardo Costa <leonardo.costa@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

PWM consumers use of_parse_phandle_with_args_map() to resolve specifiers
through pwm-map properties. fw_devlink instead parses the pwms property
as a direct phandle reference, so it records the nexus node as the
supplier rather than the mapped PWM provider.

A nexus is a translation node, not the PWM provider, and need not be
populated as a device. The resulting fwnode link can therefore remain
unresolved and indefinitely defer the consumer while
device_links_check_suppliers() waits for the nexus.

Use the map-aware parser for pwms so fw_devlink resolves the same
provider as the PWM consumer API. Direct PWM references continue to work
because the map-aware parser returns the original provider when no
pwm-map property is present.

Fixes: e71e46a6f19c ("pwm: Add support for pwm nexus dt bindings")
Reported-by: Leonardo Costa <leonardo.costa@toradex.com>
Link: https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jbauradujrre@gc5nbdhhixaf/
Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
Cc: stable@vger.kernel.org
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 drivers/of/property.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 99381c07848d..53301cdac6a9 100644
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
@@ -1426,7 +1435,7 @@ DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
 DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", "#nvmem-cell-cells")
 DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
 DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
-DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
+DEFINE_SIMPLE_NEXUS_PROP(pwms, "pwms", "pwm")
 DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
 DEFINE_SIMPLE_PROP(leds, "leds", NULL)
 DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)

-- 
2.43.0

