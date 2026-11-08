Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794124091;
	b=OqDByJjTQ3NN4AOiFr6VM4zFeT33SVtss1YrH0MHW9OSwzRBCc4aZxyJuP4CXWQjQo+R
	 /Bd0uaPjKw50HokcuIBaynKqCKmpKdIESz3u+SMGaG9s/LZhZJHJ745vgLss8vy5QlAJD
	 k+KtsFyaCBNLC6rlhpIpNk+nVKZyJDAYzg4CgDveLz5Ce4CGhVNpIWwzWiTii7cbmchUh
	 8DhAJIg6vEyGalf++JNE4KHAUGgMVKwcIcJH7MDGX+jGiPesHaOEeuuJME1SUUqvLaVU/
	 4b6P/t4sAw/0FY4Op/Wz+8Fk/9XvBKSkty1XP0XEHhKEcnWP+My4qoR0ETIQXfqB50Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794124091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JKSjiFFNXoaRnbhFm/6WIkvX9c59tRmnSx3Vjc7t68U=;
	b=bTmneaKxjsqNQIpfYwbo8iPd00PSpUXZmzeHP49sKsARGpxrDMGIIxqVV0hDuju7Ymox
	 lpNLUQhwuNZ3U8wG0p02ln9tbFm5EO2gy95ZS2cuHDX7vNY2XtZ5R9L/dEIU/GTI9VD3z
	 T5zYpEvrZUi+zvdtDtkiZLcbE7yARK6+cNhiZjr/UoM7VZJrFRty7UmGktG+oemdGWqR6
	 /ckPBXl+EarFHjlPXZCdI8ZXlPYpdj9TNw/QXW69lPZc5IlPo3nN5FBvwkGPCnvobdW9n
	 li2QwONhZSAnAFwEhHMpqouqyImGYiWOf6sDrPKYFxNIOCShTACVkdH0A0psubTenwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0tMJity;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C17606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 07:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9C17606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0tMJity
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1093570eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 23:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794124090; x=1794728890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JKSjiFFNXoaRnbhFm/6WIkvX9c59tRmnSx3Vjc7t68U=;
        b=M0tMJityayCM/igtdIf9nBzhrM3HlJ/aJ/7XwK/aldu8s1aOBzsOCkKK0GXqc3yMgr
         1lCuKnQ5ZTWPHUm8/LrhEcYHG4JtpY1A5QiLGQ17ASWhwRfqfUxLhA9KUooswmsEjHGc
         VH2VCgapOb2jV/CN1Xaw1TRWayzyHGpPuQNKNJem/R60wsQWcJa6Lng24AAyCe32czO9
         sLzcgoz8cwxUBE9tKfmtqK+HcI26vQjnLSkendoyYTO7wmMZ5WXznN/cNfg/HeuvXDXX
         WT45b8W8nLWitPX0REKLKIKiu2VXIRDKIhkuglUq6B4Z0uH9/cRui10LYgA01jVaIfmg
         2Ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794124090; x=1794728890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JKSjiFFNXoaRnbhFm/6WIkvX9c59tRmnSx3Vjc7t68U=;
        b=Uj5WyyxBTM3Bjv7c41oGGMh3d1rEAs6OwbkGbiFO47OZNd1+fA689a5ufNYhKCNZ6k
         aeLLw/t+AJ+WV+07GomPY5gY3Dy6fPwX4XtBXMA5mp8V9mj9uWujrKaXsG3OePJ6SkIV
         zA4qEW4RJAPdKiPLV3wV0rVe76koBzJgDUpm87TnuW4fTntZ6IPLYNi3tA09Ky+lzYE6
         x7/S6vW7s6lz01l+G8pT951g4DaSx7YTvbnsoZpYf8YTGRLwH76wdoujj5dBRKtmwgXz
         IiHGI0blYCIRAV5opiiX7hqZ+r6Zd/Wf5Y6x4WghzIlx/BJrk8YLszNgtFVsf9NTV/S2
         qRsQ==
X-Forwarded-Encrypted: i=1; AL+hErHBoG3qeNY+76SRHkNoue+EJ+xMeG2cnfQrgKxCdcCMGcHeLzyBWRZrqmuWlqHqIsy1F6oYAng=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cahu9IANQ0be4vJdZ0sAGpbEgNrhNLF02PvaImeIdWzRVHczo
	z6+xm9fYIeL2epW6TasH0bEeQp4rtJdGQ4qhpRsH/YwBU7/K3AB40o05MF+9Wqzg
X-Gm-Gg: AYBFou1nUwRPnH6m5Hyd7a3Juwh/phmiaTp76m/rt214U/zY3To/xpROEDmepAphLS+
	i7Ok/25LV0wDIO7FFVvE4V/MKGnAh9uNfE6o7CXagFEegWo/aYXWXyE2WnkTL3N6NVgsdrByMym
	D2RLs0Y1y4F4lbpct849hvkS4AEWg3l7ZHQeaQRMKUv1RzFAISbGC2NdpniNepWGdjjnlCHGnrJ
	+fABi9VwKqzyASlJKe1OFclaQpoVp0c/EzMi0lqnTfETqNOeZbb8f6MjYyxoyVVA2vi4GGqlRAQ
	O1+dc5/Xr6oxdNfkpyOaoJoQmDpIkqFc7Nb9Q+wy9flh9wiQejKKF0iXOg4bssL+8q/zNoA0tKf
	1UP7yf6OMOwaJyrlW4bHUifBBmfZeMKiViB6vUB9q8LXG2PvYSe3lRfrxW8IxQ5BoiwyY6WAkpE
	YBUrLEVlDciEFXtl+KYJrlcgFSxezh3BcllCoCzebixU+/V8oPQldBCGS9isM3L6xqRbFhLxkpe
	jwTTWEw7fE+j2LqXyFKa5Pqgky1qjUIGVx4CcjcFvHNJKVeZo6NF5CxjgTlWSfpQOmQzVeUMaIn
	i/RN39cBqbYnTjB+loCj6FYX+/iS98Zx12iKS1McR5VIWFRW
X-Received: by 2002:a05:693c:65c6:b0:36e:53bc:4681 with SMTP id 5a478bee46e88-372569fae2emr2198944eec.37.1794124089700;
        Sat, 07 Nov 2026 23:48:09 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726561851esm3795527eec.4.2026.11.07.23.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 23:48:09 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH net v2] net: ti: icss-iep: fix deadlock when disabling PPS
Date: Sun,  8 Nov 2026 16:47:33 +0900
Message-ID: <20261108074733.248784-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107063726.3388730-1-hj351016@gmail.com>
References: <20261107063726.3388730-1-hj351016@gmail.com>
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

From: Hyunjung Ko <hj351016@gmail.com>

icss_iep_pps_enable() holds iep->ptp_clk_mutex across the whole function.
When PPS is being disabled it calls cancel_work_sync(&iep->work) while that
mutex is still held.

The work handler, icss_iep_cap_cmp_work(), acquires iep->ptp_clk_mutex at
its start. The capture-compare IRQ (icss_iep_cap_cmp_irq) schedules this
work on every CMP1 event while PPS is enabled, so a handler instance can be
running when userspace disables PPS. In that case cancel_work_sync() blocks
waiting for the handler to finish while holding ptp_clk_mutex, and the
handler blocks trying to acquire the same ptp_clk_mutex -> deadlock.
lockdep would report this as a possible circular locking dependency
between the work and ptp_clk_mutex.

Unlike a teardown path, the capture-compare IRQ is not disabled here, so
the race is reachable at runtime simply by toggling PPS off while the
hardware is generating CMP events.

Drain the work only after dropping ptp_clk_mutex, so the disable path no
longer waits for the handler while holding the lock the handler needs.

Dropping the mutex before the drain means a work item that was already
queued (or an IRQ latched just before the compare was disabled) can still
run icss_iep_cap_cmp_work() after PPS/perout has been turned off. Guard the
handler so it returns early, under the mutex, when neither pps_enabled nor
perout_enabled is set, instead of re-arming CMP1 and emitting a stale PPS
event once the event source is gone.

This was found by a static analysis tool -- an in-house shape/pattern
checker that flags cancel_work_sync() calls made while holding a lock the
cancelled work's handler also acquires -- and confirmed by manual review
of the PPS enable/disable path. It was not tested on real hardware: I do
not have a TI ICSSG/PRU (AM65x-family) device, so the deadlock and the
late-work window are established by code inspection rather than an observed
lockdep or KASAN trace.

Fixes: f18ad402cd8b ("net: ti: icss-iep: Enable compare events")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
v2:
 - Guard icss_iep_cap_cmp_work() to return early, under ptp_clk_mutex, when
   PPS/perout is disabled, so a work item that runs after the mutex is
   dropped no longer re-arms the compare or emits a stale PPS event
   (addresses the late-work windows raised in review of v1).
 - Soften "lockdep reports" -> "lockdep would report" (not an observed
   trace).
 - Record discovery (static analysis + manual inspection) and that the
   change was not tested on real hardware in the commit message, as
   requested by the netdev commit-message bot.

v1: https://lore.kernel.org/netdev/20261107063726.3388730-1-hj351016@gmail.com/
 drivers/net/ethernet/ti/icssg/icss_iep.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index ec08589..3b2a88c 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -534,6 +534,17 @@ static void icss_iep_cap_cmp_work(struct work_struct *work)
 
 	mutex_lock(&iep->ptp_clk_mutex);
 
+	/*
+	 * PPS/perout may have been disabled (and the compare hardware
+	 * cleared) while this work was queued or waiting for the mutex.
+	 * Bail out rather than re-arm CMP1 and emit a stale PPS event once
+	 * the event source is gone.
+	 */
+	if (!iep->pps_enabled && !iep->perout_enabled) {
+		mutex_unlock(&iep->ptp_clk_mutex);
+		return;
+	}
+
 	ns = readl(iep->base + reg_offs[ICSS_IEP_CMP1_REG0]);
 	if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT) {
 		val = readl(iep->base + reg_offs[ICSS_IEP_CMP1_REG1]);
@@ -579,6 +590,7 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 {
 	struct ptp_clock_request rq;
 	struct timespec64 ts;
+	bool drain_work = false;
 	int ret = 0;
 	u64 ns;
 
@@ -607,7 +619,7 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 	} else {
 		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
 		if (iep->cap_cmp_irq)
-			cancel_work_sync(&iep->work);
+			drain_work = true;
 	}
 
 	if (!ret)
@@ -616,6 +628,15 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 exit:
 	mutex_unlock(&iep->ptp_clk_mutex);
 
+	/*
+	 * Drain the capture-compare work only after dropping ptp_clk_mutex.
+	 * icss_iep_cap_cmp_work() takes ptp_clk_mutex itself, so cancelling it
+	 * under the mutex deadlocks against a handler instance already running
+	 * and waiting for that same mutex.
+	 */
+	if (drain_work)
+		cancel_work_sync(&iep->work);
+
 	return ret;
 }
 
-- 
2.43.0

