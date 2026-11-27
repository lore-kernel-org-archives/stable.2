Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806598;
	b=lzNdoZc3HnsDQiDBYbwHfdQbq3tq4n3pp+yu/nWyBwGdaCrwd59dBlu7mWrokfuldn1x
	 GyclD21/OqoWrGZTVGa0MrwYpANXXPWi3/wWumP6iIymUyA/FNw0b2w0kIZ+cm6vnr3yy
	 06NC29swaF5PmBDRhFv96HlXhG555Z5itRJG3bl4tRJkX+Kjw8lkccIczrSzULimdggUN
	 82CUnAk81sUSdIjNRu2QnelLFcSyAM9pSoTxGbCY/VyLiyIkiVK+ob4Mux14mnWXionPs
	 h7DTzmVfhyyDGrbYJdGwvc1Rxnnnd5W9HdtYz1Oq3R59BJObU/JEjl9Wri1Z9GQFCug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=U0mDUtMC+UWGZUbp+/6kngYQYdcHCcyFlHG1lR13jwk=;
	b=x/7l22dQ1QvnqNEc90wrnWNSZ1g68LS7ka6OtXe3Mqy1X4/KlRXISWWwnSN9ouJVdYRO
	 +v4qcX4MuwUtRvddCs4uVVs+00Lny26Arsc7twXZM5duaMvTGhI85mXqO6d3gxzOPvlXI
	 +vAte8zT5v5cTyMWYPhtx7gQhJtiqmwUBVL8lVPhejpaFcsfdmcTvWhQhX0LDJKbnoc7y
	 ZcBARJjgmYmfaUHZ8nYJirf+55u01FjE2kucGsEcsVoQrpr40/FBeEj7rz1dyR3/245ih
	 F90XWA3/1ktKktgzbKN7cCZaH2Jh743VcGho2X+bPu2nCOhQ7uVPfJAXoGQ2V6eX/0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t1IeGCRZ;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353C4606A324
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 19:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 353C4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t1IeGCRZ
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c5127c7abd5so1286944066b.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795806597; x=1796411397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U0mDUtMC+UWGZUbp+/6kngYQYdcHCcyFlHG1lR13jwk=;
        b=t1IeGCRZ/lvgaOLnwNNmsq9E3E1xueXDnAYLXr3+EurSjEscFyEs2gqVIggnq+Z958
         B8f1/UN6PbxLTVQEjgGK2N1xqr/AQSU99qs6UvT9rBD7VjKbzUA/jGHs/hs0GhbC0Dsj
         ek0gaok5GZNKll1aM7IrpHYay2ELOEE5YzGO9pKfVDkt1nWr264eDXPMWS2FQY7yqvsk
         mZvHe/yqaW7qD+s19/FCHOsATOIl0JSVMiOAs2TVgECrSiD+B7o5rhV39VodsXOofsYi
         40WhxVCWZ0YmechQxer0l+QWYQJl3/Y3Iv6/kIatP6ddHTUQousOlyG8de29NuDy9cg0
         PGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806597; x=1796411397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U0mDUtMC+UWGZUbp+/6kngYQYdcHCcyFlHG1lR13jwk=;
        b=Xmixc2ZGjlV5CgtLzshrJI+EH0KK+5KgifeojgE8+g+zxRtWGbwCgGPirvDeNFVlWW
         H5KvW5qty9jeq/8+Mvxk68oFadbhku7XmOCJ1VwF6aCVAGLU/hqJOW0etpSTZMFRXZT4
         cnT/nZob8mHjkQSr4K89n9Tdc9nY8W0XCD6miv7VjkY523JqYy2dlcAUa2tDEIPQz0uF
         wWK0IBmZkLdndza8kNkbsi9fYdq0TRc8QcFwvsgpM8eMchQM12PsWnLTT7/JGMbTuhkX
         SMHGZlizYjkI+mPVv2APn5cD54N2aizkkQI7I9nYfeT1LzUP5gp3RxXqf907/yVRbAVy
         H2Hg==
X-Forwarded-Encrypted: i=1; AL+hErFf6pCDSAqAxSgHSVm/8eJgNoY/zK/P9PlxmZyE8dy6C50tljTbah6PMC4SDKOyZkZF6o3aFtk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/y7ExvagOgM5qS/ocU8Q2HPAXiir0PHzBIAYcxeJN+k7C3ISXX
	FtJbDUc19xzkPSWi2ik8QfKkr1d1YZ3482MwtspHQqD+66FOW6ta3fnWjBZFSoWjsow=
X-Gm-Gg: AZFdTZcnBNO5hiFOISMNoWlhyp7nhuygCnotzOHdhme1hNsdJ4RllAkBtN+2U1UW4Ou
	E39zxvb18sIn0meM/qfuGRF1mAfCvk5cfSAqAAVydVPlxA0ugPcFQIwM0TKbLVR273oEkuGHzIT
	B287g4xhOWAYnX0n5jsE5pd/h7zwT0z9H2a4W4WmU25XrXMRGgKzIJfZgUzqHDHDjBGfJHr4hPm
	jXs67eYPYzPQBtzJ4CBed1NeQF1GvbC545etij0oc/mHgDWvioRgsgt1Tpf6Pc8hN/IPlqrB9JS
	aelh0XBXEf3D3ghBcS77/ZCC+5jg4Hqog3GHT/vBzEmLAPv+kJr+w0drLRnREgEw9PYKdRl34bs
	Lj81dFhNTJ0CjrVno1PzgSSq+fMfoe+AAvMHxJcz+pfIX/sc7nWVzxFeeDJrOGhxBcgDN+9ji9Y
	dlnXhDvaU9Wng5j1E6e/fydQGdVO6MS0AOLrTolKOU6carw6BRUb39fIavHiPHEFIDuft3Kpfbe
	4fB0jAy043Pe97UCsNYCsLXjurApUsBZLE8miPYh4gJOEO1ZC9PbyFF+FzMix3+kcArc1aRxkPi
	kdj0InijiBvIE8QNOFhJfzl9zgdZhRhCZiVyMj2EKQc/45nV0hfeBterQ9yioGDvvjBsH/qESC+
	tSR3aHxG82hsHKxxHFg==
X-Received: by 2002:a17:907:a890:b0:c50:9432:b7e3 with SMTP id a640c23a62f3a-c513aace654mr2369091766b.42.1795806596623;
        Fri, 27 Nov 2026 11:09:56 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm909175266b.69.2026.11.27.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:09:56 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Nov 2026 19:09:54 +0000
Subject: [PATCH 3/6] power: supply: max77759: disable AUTOIBUS for
 CHGIN_ILIM
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261127-max77759-charger-fixes-v1-3-b364a0862d72@linaro.org>
References: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
In-Reply-To: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Programming CHGIN_ILIM in CHG_CNFG_09 leaves hardware automatic input
current limit selection (AUTOIBUS) in whatever state earlier firmware
left it, so the programmed input current limit depends on bootloader
setup. On Pixel 6 the bootloader already leaves CHG_CNFG_09 at 0xbb
with bit 7 set, so there is no behavioural change on the only in-tree
board, but boards whose firmware leaves AUTOIBUS enabled are not
guaranteed to honour CHGIN_ILIM.

set_input_current_limit() updates only CHGIN_ILIM (bits [6:0]) in
CHG_CNFG_09 and never sets bit 7 (NO_AUTOIBUS).

Define MAX77759_CHGR_REG_CHG_CNFG_09_NO_AUTOIBUS (BIT(7)) and set it
together with CHGIN_ILIM whenever programming the input current limit.

Fixes: 70d7dd27f6dc ("power: supply: max77759: add charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max77759_charger.c | 5 ++++-
 include/linux/mfd/max77759.h            | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
index 6876ae0a8188..49ab1766cc5d 100644
--- a/drivers/power/supply/max77759_charger.c
+++ b/drivers/power/supply/max77759_charger.c
@@ -355,8 +355,11 @@ static int set_input_current_limit(struct max77759_charger *chg, int ilim_ua)
 	linear_range_get_selector_within(chgin_ilim_ranges, ilim_ua, &regval);
 
 	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_09,
+				  MAX77759_CHGR_REG_CHG_CNFG_09_NO_AUTOIBUS |
 				  MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM,
-				  regval);
+				  MAX77759_CHGR_REG_CHG_CNFG_09_NO_AUTOIBUS |
+				  FIELD_PREP(MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM,
+					     regval));
 }
 
 static const enum power_supply_property max77759_charger_props[] = {
diff --git a/include/linux/mfd/max77759.h b/include/linux/mfd/max77759.h
index 7c0b13219d51..79d248df4c9f 100644
--- a/include/linux/mfd/max77759.h
+++ b/include/linux/mfd/max77759.h
@@ -102,6 +102,7 @@
 #define MAX77759_CHGR_REG_CHG_CNFG_07                  0xc0
 #define MAX77759_CHGR_REG_CHG_CNFG_08                  0xc1
 #define MAX77759_CHGR_REG_CHG_CNFG_09                  0xc2
+#define   MAX77759_CHGR_REG_CHG_CNFG_09_NO_AUTOIBUS    BIT(7)
 #define   MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM     GENMASK(6, 0)
 #define MAX77759_CHGR_REG_CHG_CNFG_10                  0xc3
 #define MAX77759_CHGR_REG_CHG_CNFG_11                  0xc4

-- 
2.56.1.839.g22a8290db9-goog

