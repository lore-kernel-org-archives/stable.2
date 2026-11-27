Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810273;
	b=OZVQcBnRFyfVSS4pKlCKEbFBcjN2RD5+FTrwFERmEzSsEMYv/ERReEqBeGJp/KjRmjW7
	 6EL2JgjKD5LXnHI5Vgt0bLY7Oo2h0GuNtT7ABM2Cn0kdDJ0GRL8qDUDXxbssxWuQ1N1Lo
	 EJ+PdAuiL7U9Jke6h0hL9Dnta5QY/YeayuhvEOZJ2mHRjfvPb8bjmeLhCTZfHz992zeT+
	 E46pJHoKZtI/TUTmGqxfyA/sMxn6oW0ce2ZfnaXMnEm5ejxl/Yu+WO4IC9lqIkINHvzxy
	 Nd1Lw3qeYglCHk1/wZyq+3/WR3tpiNGVd+LyhaUcEbXFrmn1AdB1ELDnDUV/ZZSNmsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810273;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=byh85l20LzfyPdnbAvy3741zsXvBS2eJ0xsenwUMCy0=;
	b=q9OVhdYFdt+OMt7Fc5RVM4PYKOXy4bT4QG59djBHrartn+mazGUDURcUoILzXacvfFAr
	 NPFglQxBLOaiCg7ZwRhDtcNb4XuhXuB/TVhSQkS55W8vI4WxNL27pFki2tTzaHO9bHi1+
	 NCpRQKqVDbwjOaM2Z/aliOIBVq5nsfMjwIwp1NE1ZBa85QsDYkcFN19OXxsWnzaxGWBki
	 s8fhCCkk+miZpoYcCOPPKrAg1EAxfodYYa8IcwPK6Q4PWZtHyWuwZbfTCEnwvEz7Bhkaz
	 2xKfP8d8i+ytU+ol/fkpCV9vB6ZwcXsK/7Htj2LTWejOjIXcSCh+7VDCGq8uPKHXLsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcN0UBeb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ABB606A31C;
	Fri, 27 Nov 2026 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcN0UBeb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC2B1F00898;
	Fri, 27 Nov 2026 20:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810273;
	bh=byh85l20LzfyPdnbAvy3741zsXvBS2eJ0xsenwUMCy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OcN0UBebr67qvf0Wu48VwJZ6L3vJJ4mpjPBDUoDOWvVHN11mF4P6BwhK5mcRWPHmX
	 /BnIlXFY6K7Q61LE83itqVtWdoHGX7aWebPfUyvbSt4OPVlZVkqxI3Sm2jVlB1jWng
	 n8C7KPNQBbHeKp71HzzvAEmrHLpINg0a8w6Y3JhxxMcxYoHSkZhpojvPZkvKHScSbL
	 0zbgU2KN5Kim2A68OtUOuBGtyGsan87GDcKOFDHBMLRjJNYjY80hacLbnwl/NfwmkI
	 sUu9W8o+Pu+ufZ4uMQ15ebJbchZDkOZY+5HkAc62JrK7gj+p3hFf7LcvmrbDT4S+V+
	 0gRXkC+2g+NLw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vojtech Pavlik <vojtech@ucw.cz>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/10] Input: adi - validate axis and button counts in adi_id_decode()
Date: Fri, 27 Nov 2026 20:09:56 +0000
Message-ID: <20261127201050.3532488-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127201050.3532488-1-lee@kernel.org>
References: <20261127201050.3532488-1-lee@kernel.org>
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

adi_id_decode() decodes axis, hat, and button counts from the device ID
packet without checking for underflow when computing 10-bit axes or
subtracting 4 pad buttons on ThunderPad Digital and WingMan GamePad
devices, and without checking that the total axis and button counts fit
within the static adi_abs and adi_key tables.  Malformed ID packets can
therefore underflow these fields and cause out-of-bounds reads from
adi->abs and adi->key in adi_init_input(), adi_init_center(), and
adi_read().

Reject packets that would underflow axes10 or buttons, and verify that
the decoded axis and button counts fit within the corresponding
adi_abs and adi_key table sizes.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Closes: https://sashiko.dev/#/bug/linux-92046c21-e0a8-4274-a502-20ca723131b1
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/joystick/adi.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
index cfd585f89c2c..1db1dfa0ae14 100644
--- a/drivers/input/joystick/adi.c
+++ b/drivers/input/joystick/adi.c
@@ -70,9 +70,27 @@ static short adi_cm2_key[] =	{ BTN_1, BTN_2, BTN_3, BTN_4, BTN_5, BTN_6, BTN_7,
 static char* adi_abs[] = { adi_wmi_abs, adi_wmgpe_abs, adi_wmf_abs, adi_cm2_abs, adi_wmi_abs, adi_wmf_abs,
 			   adi_wmgpe_abs, adi_wmed3d_abs, adi_wmgpe_abs, adi_wmgpe_abs, adi_wmi_abs };
 
+static const int adi_abs_len[] = {
+	ARRAY_SIZE(adi_wmi_abs), ARRAY_SIZE(adi_wmgpe_abs),
+	ARRAY_SIZE(adi_wmf_abs), ARRAY_SIZE(adi_cm2_abs),
+	ARRAY_SIZE(adi_wmi_abs), ARRAY_SIZE(adi_wmf_abs),
+	ARRAY_SIZE(adi_wmgpe_abs), ARRAY_SIZE(adi_wmed3d_abs),
+	ARRAY_SIZE(adi_wmgpe_abs), ARRAY_SIZE(adi_wmgpe_abs),
+	ARRAY_SIZE(adi_wmi_abs)
+};
+
 static short* adi_key[] = { adi_wmi_key, adi_wmgpe_key, adi_cm2_key, adi_cm2_key, adi_wmi_key, adi_cm2_key,
 			    adi_wmgpe_key, adi_wmed3d_key, adi_wmgpe_key, adi_wmgpe_key, adi_wmi_key };
 
+static const int adi_key_len[] = {
+	ARRAY_SIZE(adi_wmi_key), ARRAY_SIZE(adi_wmgpe_key),
+	ARRAY_SIZE(adi_cm2_key), ARRAY_SIZE(adi_cm2_key),
+	ARRAY_SIZE(adi_wmi_key), ARRAY_SIZE(adi_cm2_key),
+	ARRAY_SIZE(adi_wmgpe_key), ARRAY_SIZE(adi_wmed3d_key),
+	ARRAY_SIZE(adi_wmgpe_key), ARRAY_SIZE(adi_wmgpe_key),
+	ARRAY_SIZE(adi_wmi_key)
+};
+
 /*
  * Hat to axis conversion arrays.
  */
@@ -351,6 +369,10 @@ static void adi_id_decode(struct adi *adi, struct adi_port *port)
 	i = adi_get_bits(adi, 4);
 
 	if (t & ADI_FLAG_10BIT) {
+		if (i > adi->axes8) {
+			adi->length = 0;
+			return;
+		}
 		adi->axes10 = adi->axes8 - i;
 		adi->axes8 = i;
 	}
@@ -370,10 +392,18 @@ static void adi_id_decode(struct adi *adi, struct adi_port *port)
 
 	switch (adi->id) {
 		case ADI_ID_TPD:
+			if (adi->buttons < 4) {
+				adi->length = 0;
+				return;
+			}
 			adi->pad = 4;
 			adi->buttons -= 4;
 			break;
 		case ADI_ID_WGP:
+			if (adi->buttons < 4) {
+				adi->length = 0;
+				return;
+			}
 			adi->pad = 0;
 			adi->buttons -= 4;
 			break;
@@ -381,6 +411,13 @@ static void adi_id_decode(struct adi *adi, struct adi_port *port)
 			adi->pad = -1;
 			break;
 	}
+
+	t = adi->id < ADI_ID_MAX ? adi->id : ADI_ID_MAX;
+	if (adi->axes10 + adi->axes8 + (adi->hats + (adi->pad != -1)) * 2 >
+	    adi_abs_len[t] || adi->buttons > adi_key_len[t]) {
+		adi->length = 0;
+		return;
+	}
 }
 
 static int adi_init_input(struct adi *adi, struct adi_port *port, int half)
-- 
2.56.1.839.g22a8290db9-goog

