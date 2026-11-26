Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795684772;
	b=FhLgC/fxxR/k1UZ7jAv6RuleaU9Na/bo5NiWgX5t3KvD6FD3Z4w6RIMt70bWsE+fglon
	 ILCKyNOkzeFNDDnvOsSUC1w7PyarAfNGfmz9EuqL67FkeCkVHyhr4aRDgNa7Vys5nKAHU
	 xE/aeQLGs/0cravgNusWXwlUfIVYs10HBxTLVadpD+pXKHWUdcwoRtK8t8ss2uzLbjuww
	 Ht5ySCVVwUf9c0ZC5rNtQfXzB/SiTtWhBpURmRzq4/D+OnvYi+s/EPu+l3t5lFbjtgBEF
	 /XS/VCVtuPDs7EX/+6M+yx4Rte3ozt2/e+llin2wsznDVWIoU29B8gieCaVI2p+M2Sw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684772;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BgqmPKQt2pcjWsHCNtlC2lqlDJ2DgPLCKEYkpi6oCWQ=;
	b=pg2WMNHgX5igH/qpmVnfAUK1c62/bIkoZQHfLSVoAdOlnqo5RGASLvIsjc7WqeVbYwET
	 U16aGgLICHA3g4v/h8XpNvjdm3wUiB7IYddPubpgWUHx1HuPgtYmWKePkZABNb4xk9Vle
	 i4XmGrwek4qiQeQTcnd/LmAMtuKMBOjJ3b2bjz8J8mGPfvzdUclZhNP2atrlNBUe9RHIz
	 ye+7yPnwAPxjxYY/2G5BDdi9m3OzaDb30ZiDNBU33pId1V+YSwMzBIml6HyHnns+9E+nL
	 yIrOLUtdLOGZDMXVatNKWoEyzGOVAgBzKoF7c0Bu1qwK+qRdyo9OOnX/HFS7z81mmgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FbW8//O1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B1606A68F;
	Thu, 26 Nov 2026 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbW8//O1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795684771;
	b=xLYJ5vA5gBUF2XhxTk802cmtwk4Dwx13LcU0m3+fItvr+AOcWoD0thz8y+tMtNtqympA
	 S92Um8nKS+V+hn8k3mKx8mDWEr8IAtqLNuAeGeOXrbeQKqxGkXnBfBZMYZGQwDQppoy41
	 l/uL4YPTnMggDHvZn7+IBdBh7CBt66wuv+uhEE4emyp7gBteoY0n8ebqx4nUkQ2rn/+sa
	 CAnE+do1vwPmwh0JubQNl8AcWCppwd477sb1mdC7pVHR/DnNvitQmu+A7zrchzTRlJmnw
	 7vEOA12rG4BtYGVswRE4232ZMYMQhAGR92fzXxRY414jmeKFscGyhiLtiqEL8qQqnOA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795684771;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BgqmPKQt2pcjWsHCNtlC2lqlDJ2DgPLCKEYkpi6oCWQ=;
	b=C2YFvo0nmF6SmuOuRuU2nQnSMCb2n+Z/x4a5HGCnPBf+YnycgLnmOSHxEWGYwJFRRzca
	 Q98YbGVIxy2oJosjR2t0aW6jO2pX1bQZUM7/CdnXxFAY8sSkoluy7Q0N03u/dBk/ou9Iq
	 0RQ1v2Ykxc1QB9SqAlWUsPR0oc/53J1rDC5OsW3MN329XbrYECCZDZgpxnf7PKZbDDYSs
	 XxXX5LRfOY89Yk13m7kSmWnFV3Iej77kopcAAKyfGGRMNigP22YBONMxYDCYM9374hrfh
	 LxlJJBFSHR5Lkolj861UOQiqN8pQ0cLIOxjTomK8+mrF7AqvDWze2/GnDsQ9NwcLO4Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 52D1E1F000CA;
	Thu, 26 Nov 2026 09:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795684771;
	bh=BgqmPKQt2pcjWsHCNtlC2lqlDJ2DgPLCKEYkpi6oCWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FbW8//O1r/grszICQ5opCCs562urhdrn0mHJ1KpgTNlI8en5Erkyr/IGQmV+KJOOt
	 n2ZkffMK8JhScSHHaEa9KWdCyYk6BVT2nC0enqj+IkQ3H4+pOgcuMapPi6EEk7wPKl
	 VxTQ0N1/N2BT/5QifKJUdRRxDB7lRfXTAD8z5uQ3rBT4Ls2mZCK1SOaM6aF4Om4/dv
	 7vQ0NTZJRfNkYdUV2wtW4U626EAvxwI2acwQnqYUFt6tH3yuxyNMQnF27hUBdcWY+/
	 PaV1HwHaFIFN0fIuHFoaus7NKbPtujikx8I8s373a5OEfsuIjGOPMgCJJW37C9FBUH
	 0uWEEekAJAmQQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CAFA64D31E;
	Thu, 26 Nov 2026 09:19:20 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 09:19:21 +0000
Subject: [PATCH v3 1/2] usb: typec: tcpm: Don't cut a pending state delay
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
Message-Id: <20261126-tcpm-attach-reboot-v3-1-1c97dfa5024a@gmail.com>
References: <20261126-tcpm-attach-reboot-v3-0-1c97dfa5024a@gmail.com>
In-Reply-To: <20261126-tcpm-attach-reboot-v3-0-1c97dfa5024a@gmail.com>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795684760; l=1142;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=uRI6n9WLfQFTf9uBDH1fL/OJxtYBcAOG2OjFxQdaQts=;
 b=NkH4qJkT+AMAaxrPOBGiovFNH7jct+8g2JzBVxp56LysuMRjGVe6wqtQDrdB3gYHC+HthIXhX
 fIfiEMAHuY+BzLLqF9C9SEpY6HUIdHNf9pgWvc1do5Wt+2S7rO4QaAg
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

A re-queue while the work runs applies a pending delayed state at once
(the 100 ms ErrorRecovery took 6 us). Re-arm the timer for the time left.

Fixes: 3ed8e1c2ac99 ("usb: typec: tcpm: Migrate workqueue to RT priority for processing events")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 51e5c72799f2..565073b4ca93 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6572,6 +6572,11 @@ static void tcpm_state_machine_work(struct kthread_work *work)
 
 	/* If we were queued due to a delayed state change, update it now */
 	if (port->delayed_state) {
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


