Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231568;
	b=Dx1kMCMW/Y0VtkiDP52EsYepBK4TNKdu302HUE6qK/+TzNIwnfzr5f21l7Njgqqw1+iH
	 afJhZEgebMcq/MSGmkGawhpljQAJpzcxMTxvzzNt5fIeUy1wtGRD9fBBTwYFV3A1CzWrL
	 oZGdwv3eb3UfQRwmKr2mAnemESQ3veg3k9DDuKAMrMNZxlSiK1Hp988Jb/x5pr/mhH0T0
	 5jhQ4foA4gdpZEAxVkrKGDXrVFsE3Ah0jRj5qHs8cHmQ7dXjgvgfIhDeTEtFt9X/prRew
	 exCtOb9ZDyG+nbPPpSqZKZn/A4kam/+0/w1ysRKVdJ3SMMUGuAVtrrhxi+g01U71BlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231568;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6OxGqeZGQgYIaYKxNc4x8wUyXus7j/CxsCVkZjhPgos=;
	b=25AI1WOoBi6pf5jOxILjNma/TnxixXDcZ6gyniFYpFgSlyN/4TK5dyYNzYRnSlpOLO26
	 kuYwiA9O12mQkm3QLjdmwUyC8OkRTLe4QK68xEQ2rcZrjRcrUrOONUtFLJxQkLWfJ0ruS
	 PwfzQ1VJ0+Q+z9cx9tZLecmJN1Yl9jn0/6Uzd82kBR2UpyDMcmEQfyML5tcykmt74xdnm
	 yD/YK2QxVYFP9x0Wsy/9YSR7BPb43lVak2UO578IruhFQmIHCeNZ6675+cbSIHWkNegAv
	 ViPOJZeysTZf7X/q3Z9Msv/fWdFgVquc9z4Kg/wyQ5QgqlNHUEp6M+KvQufsQsX6aBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuWVjgMK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C4606D80F;
	Mon,  9 Nov 2026 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuWVjgMK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963521F00901;
	Mon,  9 Nov 2026 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231568;
	bh=6OxGqeZGQgYIaYKxNc4x8wUyXus7j/CxsCVkZjhPgos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WuWVjgMK7YDzAP15K7GkO9q6aipZWxlA4vS2HJxJS/SlWRj1ICDSWZHXltxW802cG
	 rCEHIOzholtijKSZCvmoJ5fsof4Vf1r8x79A3tJ0BvSI+z0tj/dqaP++6d8/rQwKZh
	 GoEtw8v65jQTM1aXQzGFF9c4XiXtPYgfdy6GDyvaQSjimEBhDm9gRa/V5hsljhpIci
	 44IW0BQ3Wlpf+FVphRCFQ1gJiN7CeRplXNI8B8erDtUkPsJWJN0S52jLupeUBDPQuK
	 I/Nz+mkSV+IHko1aNQMGxvoS3U9Z9Y4xGIw4S6i2828RliNOR3dc0q8hbcYBX2adKY
	 Slx3RZREEcCPw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Ping Cheng <ping.cheng@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v5.10 5/5] HID: wacom: Setup SW_MUTE_DEVICE according to the order of input registration
Date: Mon,  9 Nov 2026 13:39:06 +0000
Message-ID: <20261109133911.3026622-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109133911.3026622-1-lee@kernel.org>
References: <20261109133911.3026622-1-lee@kernel.org>
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

From: Ping Cheng <ping.cheng@wacom.com>

[ Upstream commit 97ce491bcef2d231b8d51cee8e579183319a5ba4 ]

The refactored SW_MUTE_DEVICE code assumed that stylus will be
the first regiestered input. In reality, touch can be registered
before stylus, such as the Wacom Cintiq Pro 13 and 16.

This patch covers both touch-first and stylus-first cases.

Cc: stable@vger.kernel.org
Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/wacom_wac.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 4c7ad9dc543e..0301f345a024 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3882,10 +3882,18 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
 	if (features->type == HID_GENERIC) {
 		hid_dbg(hdev, "generic touch setup\n");
-		if (wacom_wac->has_mute_touch_switch ||
-		    (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch))) {
+
+		/*
+		 * This is to setup the touch switch for those devices that report
+		 * pen interface first. The setup can only be done here since this
+		 * routine is only called once. When we are here, the shared
+		 * has_mute_touch_switch has been set by the pad.
+
+		 * There are two ways of reporting inputs from firmware: stylus first
+		 * or touch first. This path covers the stylus input first case.
+		 */
+		if (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch)) {
 			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
-			wacom_wac->has_mute_touch_switch = true;
 		}
 		/* setup has already been done */
 		return 0;
@@ -4307,7 +4315,26 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case INTUOSHT3_BT:
+		break;
+
 	case HID_GENERIC:
+		if (wacom_wac->shared) {
+			/*
+			 * The setup of touch switch capability can only be done
+			 * here for those devices, such as Cintiq Pro 13 and 16,
+			 * that have touch input registered before stylus and pad
+			 * inputs.
+			 *
+			 * There are two ways of reporting inputs from firmware:
+			 * stylus first or touch first. This path covers the touch
+			 * input first case.
+			 */
+			if (wacom_wac->has_mute_touch_switch &&
+			    wacom_wac->shared->touch_input) {
+				input_set_capability(wacom_wac->shared->touch_input,
+				    EV_SW, SW_MUTE_DEVICE);
+			}
+		}
 		break;
 
 	default:
-- 
2.56.0.506.g506a7eabc5-goog

