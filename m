Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794471814;
	b=4eI01/vtzZquLsInInUdf8hhJiXxj4wUD5AJyIHkl2DflMa8H3+sbZC7UiTRIoegurKW
	 9XYltWGYEuWUg3j+p0QmN1TQzVbNkn8Wi+ibNJP7F+Nc8W8zVc0xPB/dKXlmoE7OSi9Ae
	 FPqVF/rsypIqLnYTryLYzeenVSImDWTCqgfcXpgE6EbdOOow0gTKQ4bR9eJMEAvYCeU34
	 sWpvIhS5f35kDTeqpWAPwCb/h4u8EmFURpDoAmtv7PQ7+ISUkbceWr2rrqvUAGjQDBYtk
	 2qZdU+F3Rsi1N+G9dYmfZTKR57q1sV+JfY+3yxwVEg3ww6qi8C63w58SRcRStyiX0rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471814;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=u120nBzjSw85Ua4h2iZr2dC7vRzrh960a8a37kW/TOg=;
	b=Wsr7Y8ySzu4spPpZvFcsyVTrFcool3jd3HIGM7tNDDrRuTS3qpcYrMbcnUiDijxJ8Qve
	 9ol/0b0HUTt+1HR7S+/ZiNcbt4ds0RJ2/yGBM1qBI8rUOzIqoenCri0e8R/SjimQwM5yn
	 yBaNoTRmXjo3iA155P3y5m42XVbdemg8Pr35WpzvKlMKBAH3mlY1enigDbcxx57/6x0tT
	 8nQI4i3SBN2kWwP3joaGwTFVwyevPZ4lmKuQZ57i3Yi95SjwyDoryJnBQQEb6/BBIct3a
	 uY/XZNOuV6pHQYQvrrSq9iDudKiMv1WkDB0KcmturPm0odrRhB6Qr1nq19IYweKbhMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHuju1yo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01F606A8B1;
	Thu, 12 Nov 2026 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHuju1yo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794471814;
	b=B17NsFhy7xxMD9nOKAx46/g5NP3k5697f/lmpSCd7e5DkyfNIqEF1aHXq9sqWxUDYTvD
	 y70DF+xvaVIZ1CCoz+TJlEyZEBOVo3nS8lmP45yEN/6QWAfu6I5RE4gX41wAeKL0c5gQI
	 4Wd2Ldl5zzj4eiRynVmioBJqKhRF76hJYFG24g85nY7hytAgqizu/wNItqhlZkQa3uzyL
	 gAdc0+LdbmWjnRwTehEoSeE/B19wVo4iB+4dvi1PuKCf56C6BBTREM6DMXbKb20fTQf17
	 5ZBC+snIFRjzgrwnh2fsCH0/Du3DuFS7AIVj8nBHllMOxX6DN6fv9hheumPaOOcxP3w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794471814;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=u120nBzjSw85Ua4h2iZr2dC7vRzrh960a8a37kW/TOg=;
	b=XNiUTKlj+VcJG2TaY5g0vUTiT5FFaIWkueJPWxeXMEXdMwjzoxcR1YRRIDUMuKNTREiV
	 B5t0q/YjwyvrFiqFFuVbxK5kNMsQyXhRD/FyvG99rqB9nlpiQBv0pBp7bUGzDA6RQfbDI
	 ymuOrLj3mOcKxi5pyc4Hj9wRXX3JnJFdN4DmL3PRhymEf20gSJB0kPc0a8YKjqjpaZ6Jv
	 EUx9ZPU8FxUn3knGXFAy2CbL6qx4Xs30RzTcMm3iVV/j0JknvOk+KpoOOLn1gdBVyDK0o
	 SNUzvjSe0SF+HEnMf4w5Sw3nViQErN4rodxUYYMKBx8VgJAQQrc16/VQQwb+dnYyYPA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 50FE61F00AC7;
	Thu, 12 Nov 2026 08:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794471814;
	bh=u120nBzjSw85Ua4h2iZr2dC7vRzrh960a8a37kW/TOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fHuju1yofLcm+DkrzDe5jxxSB3FZtaZdhyu/vcxW+SntVc8byG/Zjz8SCkWcVw41O
	 DidKV9m6+7o9wXPOFt1mxLq/RIWbY81dTBcAkM+qb3grwddDi7RQsj3MbBnWyPQStY
	 YbbbmDX95sFFxAc3duMqNEOF3cC2UqZsQzsxqQJk4jteXSUzHYJvDFg+vdsC7uw69/
	 dTR4abeWqSKdqqlkPtsBlfwAlrhUJihxJhsT1ztu3Eu0Ev7b89Nh88ADc/07Cl6TyO
	 3aAZ4cGi8LvyBspy8IvF8+UtXSRjRZttRpPm/gccccWCY4FGI9X3hlmwgVkhFdKA3G
	 KMGOvawRFJjZw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D995349360;
	Thu, 12 Nov 2026 08:23:32 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:23:33 +0000
Subject: [PATCH v2 1/2] usb: typec: tcpm: Don't cut a pending state delay
 short on a re-queue
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
Message-Id: <20261112-tcpm-attach-reboot-v2-1-b4bc6ca83490@gmail.com>
References: <20261112-tcpm-attach-reboot-v2-0-b4bc6ca83490@gmail.com>
In-Reply-To: <20261112-tcpm-attach-reboot-v2-0-b4bc6ca83490@gmail.com>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794471812; l=2363;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=f9cETtbmuMeuYvGKqDaJesYJ7nf3lLCpDNSETJ6OO1Q=;
 b=8LeYYkVSV9H3DvqyT645JP9izzuqYaWIgQ1uDLbfjiBRX8POMf/uQ34dp9ygJq6VmUe61ARjI
 B8WrR2TZDkLClcHrFvxrxbeZrGee24mdnZzilLL+3t+VslFG/oqOok8
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

tcpm_state_machine_work() applies port->delayed_state as soon as it
runs, assuming it only runs when the state machine timer fired. The
work can also run because it was queued for another reason while it was
already running.

This happens at every port registration: tcpm_init() runs with the port
lock held and calls tcpm_set_state() twice with no delay (default state,
then PORT_RESET). The first call queues the work, which starts and
blocks on the lock; the second call queues it again. The first run
handles PORT_RESET and schedules PORT_RESET_WAIT_OFF after
PD_T_ERROR_RECOVERY; the second run then applies it at once. On an
Orange Pi 5 (FUSB302) the log shows the 100 ms ErrorRecovery taking
6 us:

  pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms
  state change PORT_RESET -> PORT_RESET_WAIT_OFF [delayed 100 ms]

so the "clean slate" that tcpm_init() asks for never happens.

If the delay has not expired yet, re-arm the timer for the time left
and return, as tcpm_send_queued_message() already does.

Fixes: 3ed8e1c2ac99 ("usb: typec: tcpm: Migrate workqueue to RT priority for processing events")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d721baef5210..0a19b7665555 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6569,6 +6569,18 @@ static void tcpm_state_machine_work(struct kthread_work *work)
 
 	/* If we were queued due to a delayed state change, update it now */
 	if (port->delayed_state) {
+		/*
+		 * The work may have been queued again for another reason
+		 * while it was running, for instance by tcpm_init() at port
+		 * registration, which sets two states in a row with the
+		 * port lock held. Do not cut a pending delay short; re-arm
+		 * the timer for the time that is left.
+		 */
+		if (ktime_after(port->delayed_runtime, ktime_get())) {
+			hrtimer_start(&port->state_machine_timer,
+				      port->delayed_runtime, HRTIMER_MODE_ABS);
+			goto done;
+		}
 		tcpm_log(port, "state change %s -> %s [delayed %ld ms]",
 			 tcpm_states[port->state],
 			 tcpm_states[port->delayed_state], port->delay_ms);

-- 
2.55.0


