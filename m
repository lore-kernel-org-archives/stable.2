Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799306;
	b=kxd4T/b1o7olY5m/ImSjl5hdiJnx/gVGkhV4fe2polf8zDLsC03BB0Qw1PFeN6wvPhhY
	 iOPUhj5fvJg1PxmsKJVDa9FKtiRxmssIpXqF6Q7heBHlBA4UHCw6JhkzRUeGInlN3Hw+m
	 MXdFOhouUrp1sZIGdu9kKneBa0kBMeZ5fNOoaxvZCVulABMW/gTMNTFCFaH7R9p2Zcj6t
	 YNKX2o/finqUCi6L4LLS0LoNIX61fwevpgqPjvGRN0WL0OPCqjoTMEoYmCeVdpIajROfE
	 A64mK02F9xPRQblSneoSX3ka/LAJ7e4q0QUrxJVyUT15G8K/RXSBHowyh4kvShlzfDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799306;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=A6xCdeRrPPACKNA4/dV8f448D0tf5ckvTXEBU1C/alE=;
	b=eJ1mVDJUPaIl0mVLe1XMSONek2wQWjliLc1qUJQIwSQrQbtsOQ2dRA8rAlJ6TcJlkI0D
	 5T4WqNpM+P2046h2Y44ZpxgxoLvuf7BAaRgYtcbuTypxIUMtdKxbrll126IZUkXEk1Ne3
	 R6JOcK42x6n/PuFazu9pn2zCyShH0GMmVqVpAYKE3DpCRsikMDwzGl6qqZg/u+uP1aDi/
	 IUwlOxsA80RXKIobfE1aWr0K7V8jdWMg0ouRZFLkeiH+RaS3ZTLVjTHDr5LmA2OeXtKO6
	 Gj0qsYyw/Y52Ocu2jo91fipqKgBfejOItqn/tfOJ9WnSP1pIH8EfRwiBPBdOOd9hDlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Di51hm+O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF4606A323;
	Fri, 27 Nov 2026 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Di51hm+O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A131F00897;
	Fri, 27 Nov 2026 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799305;
	bh=A6xCdeRrPPACKNA4/dV8f448D0tf5ckvTXEBU1C/alE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Di51hm+OUIZKgXfjFVsJqFf7NZZpkTUoyNHJNU0e4aYZOwTzH+xNkscAQ+GSJj4UH
	 fmhKs3XZAgncAklvlw7HO0UIO8eRH+ogQpudNXYr5ly+k4yIDuAdSRcMFyTR429NfS
	 JhYFVhc1+LPmpdCS/fjO3iyke5Dg5OB08vzry4b+tFYPfnyGc4YlzyNScJlCmUW1cN
	 C1jhTfHvUPu+Iorhwxikxx5s0Zu0NnchqqT9U7781yy04nR0jaFhOxkGmVKwh64iOQ
	 tDqLCmVLrScohNesVj4ZmdapJYvovVs4JfXwEwzhsUmVSTRDML82+ooRg6bx8BItOd
	 sg6fp6IWpABNQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	=?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 10/10] HID: playstation: Cancel DualSense output worker on create failure
Date: Fri, 27 Nov 2026 17:06:28 +0000
Message-ID: <20261127170712.3163443-11-lee@kernel.org>
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

dualsense_create() schedules ds->output_worker via
dualsense_set_lightbar() before registering player LEDs and assigning a
player ID.  If either step fails, the error path returns without
cancelling ds->output_worker, leaving queued or running work accessing
ds after devres frees it in hid_device_probe().

Call dualsense_remove() in the dualsense_create() error path to disable
further scheduling and cancel ds->output_worker synchronously.

Fixes: 949aaccda019 ("HID: playstation: add DualSense player LED support.")
Fixes: 182934a1e93b ("HID: playstation: stop DualSense output work on remove.")
Closes: https://sashiko.dev/#/bug/linux-b657d8df-afc1-429c-9bf5-b2583501dedd
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - No changes.

 drivers/hid/hid-playstation.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 24e448076e35..9650bbe233dc 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -1906,6 +1906,7 @@ static struct ps_device *dualsense_create(struct hid_device *hdev)
 	return &ds->base;
 
 err:
+	dualsense_remove(ps_dev);
 	ps_devices_list_remove(ps_dev);
 	return ERR_PTR(ret);
 }
-- 
2.56.1.839.g22a8290db9-goog

