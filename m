Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810281;
	b=NB8hCxU4Q3yobv5pUd9G/Qf+kKzvSe8FSV4mU9SMYpss5/yVEc/J16OPsJq59BP3pRoa
	 c/LnZUk3pLXVUw2gzPlQpgotC2Ftx1xGFQ4ldzzHnG7qdqfhzsJpol+aMpOY+M9IK3SQe
	 4YoDh7oGADWC1PoQZbmjkS+PdeojnjYl65iTA3A/AGmWQUKyIW3Ub/3n4KYDAIQIPzfxn
	 PPluezRIhMp1pN+jpGVRDrW9qazEB4x0gJca7AoRkm+JI8o0/HeEyMO4IilzYWmS6XlqZ
	 XKqPOCCzI/ouaD5IlIGMX8g4EPgbE0OHELj8DFcuMfMVQvS2xDSbDUhuMKuOGXyMNIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5J1bwSrn8oRKroKcTngKb1+QyB51InTUxOU/A0itlkg=;
	b=z3EdRR8lCtc+IomqDc0MqSUuhVHQEuxTJF7zi8Z4KwK2/HGVWFNvPlFlgiBqC/vmRJeF
	 Vrg1rzmLIiW/FyoDwMnq/X6WPRrsqYY/dG02sR86ER/zGc+T3e9WOtlHIEcJz2B7UrsVs
	 q3reHg1PgP8OM4y+/64b55SGXG6W2b4imHd5NWqjZ8QNW/g/NTxCrFGbLnN1eg3uIs1PR
	 IXjHBdI5/ilV539ZJtmcoJGh2OSHd+lmgeUV1krnFTKuKiAQK1mAaw3IbNWRZo2zac5A+
	 KQ8dzNQ0VvPvy4+nCCKIXqtVbXsFaCm7DSj5iqQRgomIdslWRtMLEmyjV1BfWhnuY5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5BAntfy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3C1606A321;
	Fri, 27 Nov 2026 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5BAntfy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB53B1F00893;
	Fri, 27 Nov 2026 20:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810280;
	bh=5J1bwSrn8oRKroKcTngKb1+QyB51InTUxOU/A0itlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y5BAntfy1aehQYk0PLAmNEM+07Mpz2BbvlQLHVYOd0j6Wh1SqR5uJdxm/wT76/zwu
	 EiHPmdD+8kJLaEBYKxbs1106cwfiSSKDb3eHYdHaDvawIPxzn6vTPlAOnWvMWzpX5s
	 NMivYIKVCtkVZ7ITBc0mV531O1qya0/0zLoyjWZ7uiDPFS+hfLVGztCE9qJ2yADW4n
	 jik/s7Id0TzoXaXTIpHKQ+OCwL+HTOV5YYLFArJzI6ohmcm7OAjTrJ7jOAiUm8+Jka
	 2xdnapns8NoNPNKkkpPluEDT0E4KSGOtqe2TucbDesJR0pOxxMXYgNvamFyva0SCz0
	 3ihR+ivRtHCZA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Elliot Tester <elliotctester@gmail.com>,
	Marko Friedemann <mfr@bmx-chemnitz.de>,
	Oliver Schwartz <Oliver.Schwartz@gmx.de>,
	Steven Toth <steve@toth.demon.co.uk>,
	Franz Lehner <franz@caos.at>,
	Ivan Hawkes <blackhawk@ivanhawkes.com>,
	Dominic Cerquetti <binary1230@yahoo.com>,
	Adam Buchbinder <adam.buchbinder@gmail.com>,
	Jan Kratochvil <honza@jikos.cz>,
	Christoph Fritz <chf.fritz@googlemail.com>,
	Pavel Rojtberg <rojtberg@gmail.com>,
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/10] Input: xpad - cancel presence work on xpad360w_start_input() failure
Date: Fri, 27 Nov 2026 20:09:57 +0000
Message-ID: <20261127201050.3532488-4-lee@kernel.org>
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

xpad360w_start_input() submits xpad->irq_in before sending the presence
inquiry.  If an incoming packet schedules xpad->work before
xpad_inquiry_pad_presence() fails, the error path kills the URB without
cancelling xpad->work, allowing xpad_presence_work() to run after
xpad_probe() frees xpad or leaving any input device registered by the
worker torn down improperly.

Cancel xpad->work synchronously after killing xpad->irq_in on error, and
run xpad_deinit_input() and xpad_stop_output() on probe failure in case
xpad_presence_work() already completed before cancellation.

Fixes: 09c8b00ae3e1 ("Input: xpad - handle "present" and "gone" correctly")
Closes: https://sashiko.dev/#/bug/linux-0c0def42-a340-45bb-860d-c99ba757f43b
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/joystick/xpad.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 86f4e756a7fc..ba0f5684f3d6 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1880,6 +1880,7 @@ static int xpad360w_start_input(struct usb_xpad *xpad)
 	error = xpad_inquiry_pad_presence(xpad);
 	if (error) {
 		usb_kill_urb(xpad->irq_in);
+		cancel_work_sync(&xpad->work);
 		return error;
 	}
 
@@ -2210,8 +2211,11 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		 * we're waiting for.
 		 */
 		error = xpad360w_start_input(xpad);
-		if (error)
+		if (error) {
+			xpad_deinit_input(xpad);
+			xpad_stop_output(xpad);
 			goto err_deinit_output;
+		}
 		/*
 		 * Wireless controllers require RESET_RESUME to work properly
 		 * after suspend. Ideally this quirk should be in usb core
-- 
2.56.1.839.g22a8290db9-goog

