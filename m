Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741459;
	b=Z09969rYUo9mOiTAeoBxiHqyt0hfk5UtgC4UyB8/LV55JXhPJL99Eils/mLh+qYctmKr
	 aj2e/heC/5M6d6ms4rHyUw8dNjzbFn6u2soh/l3VwX4y/tHsWpoUoeqIE28MpMuoAI2j9
	 J7bA4rt7+uuCkaxpD5nqmQj8c8m3WirqSZqVuQyT6xQRZPFj7YpA4TuyX4uDn/rHkLyx8
	 fXV8cS8BzHSyiXFv3IejX2D40FwnA0L1TqEKaXyD79cqfmbAa323JmFet0CW9xJSphB+Y
	 86z9SeJahffDuIPZftjVzgYHz2VURkaAnlWFfHPBGPKIQ/sBRH0VAwYPFzYoU/VNKOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741459;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2iPUQpArd++dAugymdCYR9QxCbrAkyiSI3kkgK73EZ4=;
	b=T0BmkwVVArQruOJkQT07KbeonzjYBvUeVaZu3RPYrZgPre67UDtlhFIN/SAPZTOSPG75
	 8HM4G18cn7zNRws2Kf364QvC4s5r/Cswxxgz1phMM4Q0iF2ni8xTBbx/QzVWTs/jZsQ16
	 MAZzX5KJOzBMb7apEflUC/ijNlkrql5HNB9RHK2P/DmChNnhGSjxISf/nBvIFjgLOyQlO
	 yDEsr2iYq9C6/d5EelMx6/7IUwFbl2DrPOSZqLX7SNKltDbByZCoAVQfZtSYdmRME9blv
	 L8ymQl0L7jsTYh282o5TWGCa/wivn5rXIscJtTq+Q30+m8lgNvHld90YtRCly3xN+Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E/4FEwyR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B1606A335;
	Tue,  3 Nov 2026 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/4FEwyR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8076D1F000C1;
	Tue,  3 Nov 2026 21:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741459;
	bh=2iPUQpArd++dAugymdCYR9QxCbrAkyiSI3kkgK73EZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E/4FEwyROxGxiyBu8w0XrcG89uXdv+/puOwytwSgG8SZb7kIc53yF8d4xNVamS/u1
	 ewWSmhdeOv4jBvaeLyt/fxk5VmVBG4yfnAyG7vF9yOWiqIXAgWSnXDLx198oNe2hZ2
	 VD4biYvQK+Fsv2ltDmRW0FedH+/nTCP+UixjiBrb5qRbp89Bu6C9gWQTu9A6FaVAia
	 /EPcaDCg3UM7Z6R2ep/280347rxn9C63ZTy8Y2rwIX8aFQIfy2epofN8WOjCJYRZk3
	 +NSi6afi/H7sN3YeGMEUfVGlphztpgM6FWSLj4hdjM42qdfeMDJxnNyZ1uHiAQFPsp
	 m0T791mx9lLew==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	James Tai <james.tai@realtek.com>,
	Yu-Chun Lin <eleanor.lin@realtek.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.com>,
	Linus Walleij <linusw@kernel.org>,
	Tzuyi Chang <tychang@realtek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-realtek-soc@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/10] pinctrl: realtek: Initialise omitted offset fields to NA in config macros
Date: Tue,  3 Nov 2026 21:29:12 +0000
Message-ID: <20261103213002.1673560-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103213002.1673560-1-lee@kernel.org>
References: <20261103213002.1673560-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Realtek pinctrl driver uses NA (0xffffffff) as the sentinel for
unsupported pin configuration features.  However, RTK_PIN_CONFIG omits
input_volt_offset, slew_rate_offset, and hvil_offset, and
RTK_PIN_CONFIG_V2 omits slew_rate_offset and hvil_offset.  Because C99
designated initialisers zero-initialise omitted members, those fields
default to 0 instead of NA, causing rtd_pconf_parse_conf() to treat
unsupported features as valid at bit offset base_bit + 0 and corrupt
adjacent register bits.

Explicitly initialise the omitted offset fields to NA in RTK_PIN_CONFIG
and RTK_PIN_CONFIG_V2.

Fixes: dcc9334435b0 ("pinctrl: realtek: add support for slew rate, input voltage and high VIL")
Fixes: e309dbd523b8 ("pinctrl: realtek: add rtd1625 pinctrl driver")
Closes: https://sashiko.dev/#/bug/linux-fbd0bf54-6dba-4652-9418-270b11fb6d8b
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/realtek/pinctrl-rtd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/realtek/pinctrl-rtd.h b/drivers/pinctrl/realtek/pinctrl-rtd.h
index 77c30ea76443..86db54ea3ce8 100644
--- a/drivers/pinctrl/realtek/pinctrl-rtd.h
+++ b/drivers/pinctrl/realtek/pinctrl-rtd.h
@@ -96,6 +96,9 @@ struct rtd_pin_reg_list {
 		.smt_offset = _smt_off, \
 		.power_offset = _pow_off, \
 		.curr_type = _curr_type, \
+		.input_volt_offset = NA, \
+		.slew_rate_offset = NA, \
+		.hvil_offset = NA, \
 	}
 
 #define RTK_PIN_CONFIG_V2(_name, _reg_off, _base_bit, _pud_en_off, \
@@ -112,6 +115,8 @@ struct rtd_pin_reg_list {
 		.power_offset = _pow_off, \
 		.input_volt_offset = _input_volt_off, \
 		.curr_type = _curr_type, \
+		.slew_rate_offset = NA, \
+		.hvil_offset = NA, \
 	}
 
 #define RTK_PIN_CONFIG_I2C(_name, _reg_off, _base_bit, _pud_en_off, \
-- 
2.56.0.385.gac671c819a-goog

