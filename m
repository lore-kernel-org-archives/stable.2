Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794307146;
	b=jYT1e0iqnthGclnx/68FpuSTxP7ofD+U6txoD0luDbKuUJ8G3FHjOQIkrl859ZgB7bPa
	 4gJs6LASr6UH7BfF2u59wXh+viFaQVHM3PEdmtleFQ5OldlEjLBFLG3+YHLbRuWkxf2Oj
	 xLp3pkYjUgL8cpptHsvqKktKD/B3rM/VmqM9wSg2avGxHriWqG7GKbbIyEFSxnL+ii3IU
	 dHAqATWCr15h/LjbrJ6dTkm9QNiGn1GxyjVmpoIQL0fX+SJXIMvJ2AcTbypYsKUNTCXfa
	 3e0h9/XSUxEdOIxP/rK/kYFaylZpQPKnnIKq50RHn+T9yG7opMj7FttGk3tMSUIvAYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307146;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=u120nBzjSw85Ua4h2iZr2dC7vRzrh960a8a37kW/TOg=;
	b=hllguORHHyRrVlrXP95wmHlyzKXK8FkeSet2jdzxJ29TL/BjOfHiQVlCqxeHBVdHJWyt
	 lwFUlmRAyOt5XwBxZcmw92Ng7qacOGABTQrLSzd2kzLuIoVy4fHqvL9Rngbjy54pBfdcE
	 vKlVv7UOuC5L/wpGA1gxuVq5axWYXZzrJed5F3jDWZsdnXb0r4ByRLZWcgxeK67Nq+x49
	 lAgUSbOMRZy2lBPiXDcjTmLqhJE57/M/zTOain6SZgY/rCgnIIgZp+51ozJEYFAsFzQo8
	 rT9M3SfdZgycA6JnqVXpNbdw/20Ck9x4ARG9cq7XNLQbdFiuAHMxlBnyK7ODF7IDJjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LR6/L0Ll";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C9606A321;
	Tue, 10 Nov 2026 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LR6/L0Ll
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794307145;
	b=QwjuGWFFLm4q2/Idtsbnv2YOhs5FVfI4FJ7Ytj7Wbn9V6tAwVNFHrDXEjop+2Iv3dclx
	 /o2BvnJnJEhPdHL9f3+GnNmuxWHYcRNAYK0/QvmvHfP4C5jYMJd496hGChFKuvcW4H/m+
	 i4LhCpYLeAiMyACBLMCfSjT4fxW9YOLhRU8Cz2/VRjlfpQe54QmCCeLtMIWVCegltULFA
	 6m1VH0+ECxXfnpbDiKgTLlzOGhd55t2sz6Zy1uh0ic1KuVIXo/Fbgtdovw0dizP6AEZRX
	 A7qnVorosIUj+VQ5Goz/rl1BKbeztflbtCYJhx/Ut2G7ykfTx+XNvU0eVoLA8EYE2wQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794307145;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=u120nBzjSw85Ua4h2iZr2dC7vRzrh960a8a37kW/TOg=;
	b=JdWhi2wil+tjQe6TR+7j0MBZ4mmcfSmhz7syvSjt7ZCpTZPgAIvCBqQPRQNj2jPNeYkK
	 2kuiAjGn+m7ihyAwaUUKZsxJ2OdZbUqm6llMgIOhOXIQq98+C03vIGnkvr50KOYnUgFxI
	 c2E1ez0ZG5HYUOpio2/4BrVgqIXBSRPTX7Oww+eSd1jaT9KSj8nuifDDCmk2N8AUfB74O
	 yS4L5DGbqmmJcDBGUfxvqfwfl8LapuB8GmZzW0+incm/Q34mJq+YQUC22w3h+jiFZf/FE
	 RLESi7X8XP9NfvKAH1d8YsiPBk+geXm21/1/HcMQpzITFPCECmcMNl+zU/9Xjl792Zg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C54981F008AB;
	Tue, 10 Nov 2026 10:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307145;
	bh=u120nBzjSw85Ua4h2iZr2dC7vRzrh960a8a37kW/TOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LR6/L0LlSRZ6ct/+XZf7FawaPk4QMss/KOQeuov3Hb5VnXIpGau2DtTAZ6nteQoPo
	 G2dKGjEi0KGmPXo4dzD0iXxZ0lK3IrnWu9YeAcAAeeoPOradl8Cj+k8Wei4vNdgj5A
	 tq9NmSi1A2450PQZOdubEVLshicDRMVNwJiwYouYSennhrTfkO/hvY6+oq/hvugJkC
	 3qdZHZ5TPDzVaHwLb9WGXnkoszsm+CQzEosF4Dwa3HJIMLWTtJ7t/sfQI8BsWfru9k
	 pfQcUBzPYSm6gEALdISqE5umBQCNVj61AM9N8jGepQ0IEwut8W4SzXSEKiROx0jUeQ
	 04uDv1QPYfEXg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3E35048AF3;
	Tue, 10 Nov 2026 10:39:04 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 10:39:04 +0000
Subject: [PATCH 1/3] usb: typec: tcpm: Don't cut a pending state delay
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
Message-Id: <20261110-tcpm-attach-reboot-v1-1-7657cc1e2dca@gmail.com>
References: <20261110-tcpm-attach-reboot-v1-0-7657cc1e2dca@gmail.com>
In-Reply-To: <20261110-tcpm-attach-reboot-v1-0-7657cc1e2dca@gmail.com>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Arun Iyengar <aiyengar1990@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794307143; l=2363;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=f9cETtbmuMeuYvGKqDaJesYJ7nf3lLCpDNSETJ6OO1Q=;
 b=pFqVEKwOdwLR7mjXQTBH67eOjWQUk60Y4/7F27il8EHZKBd8oglAEuo/CHYM+JOtKvlZnKWlf
 1ULxeKeRqrYBM2mYkZteQjBG3Ebe/QNqKpt1rikjzo7iA/TlROf/XRk
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


