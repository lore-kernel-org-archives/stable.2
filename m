Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449114;
	b=ypOj3jH2KC76WVIvfohlkccZJ6bxF3+XuT/3/q1DXC8lycibDJ0+sQF/evNKxiG45hFh
	 erC19XKi1ZhNbowpOCzObmubyUY1p7DQAsVdK27cg7uSr/LXRT61s89m17FVG5KWrcqIg
	 3EJVTjoZtmhd5P3Y46Ce7+qD2p4rlHbexjflLY8Pc1437TWOTmsswt8R+CiLxQ2Socx4c
	 wM9i6F+WWPHNG7oUjhNQJZ6qqMQA+4yZ7Tnn2uhQZRkl4gblJrFPWRyoXtBtSpma4lRW1
	 2lI655LDR/L7OWvFmBwtazJnjGC90tpKCCEuubYtDwMSR9vQUu1mXngi2EhIgYgFCAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449114;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/7YEJEibkMr/DIKYIsCbTKCb82JpTQgzfQSJwCdLDA0=;
	b=GspTUnZoky8znzkzzEjqj92ltGHuBgBSjpq7Xyx5bN3Y2eco38pCLluzqtPKYIlFJT0n
	 lS0rSF4WXn8LjN3WoMSy0zIc7elPrrAtKtN38oiY1KxfjtAPO5FpSTwi+uKoOoiR0qRaL
	 dVA1NQBAdrPa1m9Z/UAjqJq2lEvlmSQMwUWkmwp8npKVvCNTsIOyjyyuWdq1UfE2hvBxi
	 0+fuNhX0H7oBO0bR8aygXvRXHm6k/FaeHSTAomyizvMTWrRsQFwjqVW8js9gJSstwhu+h
	 7beyKk/gCft+X+rnDem3ZerqDZ6TDdjv07aH1wp+h6IJnl70j7xB6rdroIVVxMM3wnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SKsHmyrB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7E0606A31A;
	Mon, 23 Nov 2026 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SKsHmyrB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC181F000D0;
	Mon, 23 Nov 2026 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449114;
	bh=/7YEJEibkMr/DIKYIsCbTKCb82JpTQgzfQSJwCdLDA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SKsHmyrBCGkwn1Eg+dBt5WqP7N0SxC0BvceW0RCbyxqOI8oSwFwTi/4E7nZOjmike
	 ho8dcPhPbgB1JwTb7S9okBXZQFMnD3vCnnMXCGLRS63PMU+wTm10EN0d8anHWhVA6g
	 Y/e9JekIKUIut8gyTFjVBUvgVeWk/ddQbzJMzCb5NVuMm8YKP80zB7ZDNQhaswKpdG
	 o3cTmjftp7vQKNrxhKhxym9udvBh65Xg6NXudfY0oxW+HC5rBPy+Fi1lfHI7c/8QMT
	 RIOdZEKk7lTE8KAIp5/4c98oo8h6tXA9PbbeSpS2m6P+TFzrXccRCQpw7mhMmR8gHm
	 dbpmgMsc6n2Fg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Michael Haboustak <mike-@cinci.rr.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/10] HID: core: Protect hid->inputs traversal in hid_check_keys_pressed()
Date: Mon, 23 Nov 2026 15:50:45 +0000
Message-ID: <20261123155138.2907049-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123155138.2907049-1-lee@kernel.org>
References: <20261123155138.2907049-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hid_check_keys_pressed() is invoked from USB HID interrupt URB
completion in softirq context without holding hid->driver_input_lock.
During driver unbind or device removal, hid_device_remove() holds
hid->driver_input_lock and calls hid_hw_stop() -> hid_disconnect() ->
hidinput_disconnect(), which unlinks and frees hid_input entries from
hid->inputs before hid->claimed clears HID_CLAIMED_INPUT and before the
low-level transport stops interrupt URBs when another user such as
hidraw keeps the device open, leading to a use-after-free.

Guard hid_check_keys_pressed() with down_trylock() on
hid->driver_input_lock, matching __hid_input_report().

Fixes: c4c259bcc27c ("HID: consolidate connect and disconnect into core code")
Closes: https://sashiko.dev/#/bug/linux-bf47a448-239f-4b68-ac24-60b8b6baf724
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b4fd482d39d2..03511cddd44f 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -3216,18 +3216,26 @@ EXPORT_SYMBOL_GPL(hid_unregister_driver);
 int hid_check_keys_pressed(struct hid_device *hid)
 {
 	struct hid_input *hidinput;
+	int ret = 0;
 	int i;
 
+	if (down_trylock(&hid->driver_input_lock))
+		return 0;
+
 	if (!(hid->claimed & HID_CLAIMED_INPUT))
-		return 0;
+		goto out;
 
 	list_for_each_entry(hidinput, &hid->inputs, list) {
 		for (i = 0; i < BITS_TO_LONGS(KEY_MAX); i++)
-			if (hidinput->input->key[i])
-				return 1;
+			if (hidinput->input->key[i]) {
+				ret = 1;
+				goto out;
+			}
 	}
 
-	return 0;
+out:
+	up(&hid->driver_input_lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(hid_check_keys_pressed);
 
-- 
2.56.1.750.gf70dc682cf-goog

