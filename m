Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799247;
	b=vI3sv4zBR/SSuKRlg9O3/SusGvFtKTMIVou3+VWB715GRqKmprkL+gsPYOLv7rx0+hxT
	 TGfCALCPPaE2269FxRqsBh8SiIza0WddDITfa/5+oSt/59Fa7HlSfqDs1jynwKfTJp5nP
	 7wv8a0UrZIJmAMg3da1cPmDxGql+1UV4iUjsJWD+RtySqghSA+UEeTINiGrSJ1cHPfuSx
	 H/+EASuYquxhJmIvFfAl11TrSxn5ABeOJa081MGZNRzo9wPT9qBbiJhvI9ioo+wRBqlNs
	 ocThR3IzPOQN52JlANEyQ+M7OGagl3Tv5zRxuM24aIr+N8Jsm10yDpXYTVe409zrPVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799247;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CXIc47Qux/3TwjIv8LzXAGM/gdWG+E0IGY6ODRZyeXA=;
	b=GJrQ/iXoA7LUhl3FxtG6F0eOV3bFxuiwvCqPCb9sv4cSvmX/wBA+BQWqHX9OmeUeWeDX
	 08crlEAm5uPL/43U7KQjPTq+R43cGeKAkOgQTBIDQYC/pXv1Gpuo1NWPZiVLEZQdh8A3J
	 jMmoIqsarjWLj98eK6DqUZK/35mCA1JnY0/oHyf8ZXz3t67zRefBeYlfpDUlH/dfJjDvv
	 iFBD/o9E63RTia5jTpPIsyVzLTfkVWI0rJT397DFCglk0K0CMVwebqwIZuNVfmMK068wT
	 KPvdiP7R4wJkV8L8lLefErVe8eERvMljapilpwEBsgr9DRJWkN6deaXZhZ8Z68TG89w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJ7r8N40;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D197606A682;
	Fri, 27 Nov 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJ7r8N40
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094111F00924;
	Fri, 27 Nov 2026 17:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799246;
	bh=CXIc47Qux/3TwjIv8LzXAGM/gdWG+E0IGY6ODRZyeXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KJ7r8N40VC05hnuIUW/YE6CU9ncfYP22uXPtS/TJZVYwLlouc5ow9UM2xCKu8y0Ft
	 JOnLAu9U0jy11/lZaa1K68/jnN1r6xWt+FfOwSG2Js9yzFz5rm61ze7wN59/Qagftl
	 vcWdKEIb0a5nKsCqk/DWmHKdm0vREh+4YRtbjKQr6QdYAkP29KMkdCyMNelcdAYQi1
	 Q3xxKQKHmx4FGNXjzQID5woEuvNtOsvQheKvjQMAWwXg6BUt7qOEf/tA9D/AvC86kb
	 xCwj1/mIG9jfVT85cSXYxzDP2DFXv/ZKqCAhn2kGSBEooAD3Iv5AO70lfeQhxfiey2
	 ouaCFA1MoQd0w==
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
Subject: [PATCH v2 01/10] HID: core: Protect hid->inputs traversal in hid_check_keys_pressed()
Date: Fri, 27 Nov 2026 17:06:19 +0000
Message-ID: <20261127170712.3163443-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127170712.3163443-1-lee@kernel.org>
References: <20261127170712.3163443-1-lee@kernel.org>
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
v1 => v2:
 - No changes.

 drivers/hid/hid-core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 64ac7606927c..938ad3fe6a74 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -3217,18 +3217,26 @@ EXPORT_SYMBOL_GPL(hid_unregister_driver);
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
2.56.1.839.g22a8290db9-goog

