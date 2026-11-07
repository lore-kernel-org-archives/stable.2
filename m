Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033457;
	b=E7Y9OT5uC3qkndhX7M0igAnz6fxULEmdHgtJDJcs1uWVqbYxJQ4iZGHjGIrAawj+G7ML
	 2ErAqCVGnKSacKca8HrOfdEzUrLvxlBAbCo3CqRPYGyyDRTiytjQh8BQYAjoe+J1D8Gnj
	 KiGHiEWy6n0iQRtav4Y0FATP3wXTZlyKESvM6GJcs9geu9YczdFN+533Uhjv+YtU6lFm+
	 vcmCXz0Az6/Xc0TxIvY9egHggkspn9mbiSGXgs2A+UZsaCXzg6A0clrriy23vEnj9tBbZ
	 dV5veFVvl3gqWOguSUysqjuiAYw5McdCbLfmvjFEAp0QMmeI6kMkEgDeog6IfETGkLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LHL2l3rOn22wCea5M4iQzvY4HHhth4DONcB31HGYom0=;
	b=sN4pyVAhU2+CF5qIHR6LsMItI+4P1RWYA75zNT4nBMZyEiOvc4sT1Ev/DHqEjazDjKcG
	 huAZP12koFy3Do2F+EcA38iIoLK5J1oclza2YAJrqTB0wJe2WZ+tz/1qxnk7+puJK5hO7
	 RBg7cSiMa8YiFn2YdKn8ZLck6z72Ekspi7dZOFpe24VfGpdN9jQPSWklcG5HeOi1hZd/S
	 xZ/W8wpfbhFHRMEQA+RjClJ548IWzZtYMXTwgawdiRSwAwKG3XkVj/Hda8ngmqnHe3OHl
	 rQbwxO6MV3FoeX/3UteEpiiQA2CoLSckobL+OguYxnA2LvBffBf2k0qPFg0Nop/WsUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fu7kgJQA;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1380606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 06:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1380606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fu7kgJQA
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ed1b9e8f43so5660575ad.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 22:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794033456; x=1794638256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LHL2l3rOn22wCea5M4iQzvY4HHhth4DONcB31HGYom0=;
        b=Fu7kgJQAT1614CBoJ/v0QNumGTnN/XUwli/MO4kPZrVn02UGb3hXhv0UJ8xGiIno5h
         VGMRKshITnOzwHw1He0nsL8KGGbk6zAuorEA2hAvA/EEyQzQWnaQ9bGh/Zos4PRJszvU
         pauSU4gZxBeZb5H9xjnRSiFhV7SBhoB4crHhtV2Am9bxSj2E96Vy1nkaAwfCgDk5RaWS
         ZcnWEJ0Rd0xVZhd81TTQvkGu2mwVAFtlXxC3QDhP0KnL3o5OQKENwpjJUH6n4/qtD0zu
         0yu7LrqB+xWnnKugjwas6+PvPI39yp5p88b3J8LeoIKVFH60Yvp14bi3LgZ/Cp6Ni84Q
         Id+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794033456; x=1794638256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LHL2l3rOn22wCea5M4iQzvY4HHhth4DONcB31HGYom0=;
        b=VEH4yQBj78Dtm1cCg8hRm8aFsbAMM7fsF19tk+QKTVn3HT1laT+IN+hfO5NOtMhRjU
         zSrlX1uQfSPVssV7R5lC49wUdHmpvl/tng1u8Rs5o0oh9u149V5nd9Gk5Md5JHsodsID
         DKzuZv3Uk+LWgchR6LoBMpCZ0zqovf8Y41qJ/+HK3R0MHo5Dp7nSt5WUEySsBzO2FyU1
         34CgqzpMy6UPzD+5n0ZCm2p8fybY++CsvctMeJ80Rve8JV2vHHlepH6X2JoDkMRWSuSq
         SgZiA5RSMNPNuXJziBBzFlJXRm4D6BirhwKQcYgjT0JxpYs5fVnmBaZZSuG/93KCn2jR
         6pVA==
X-Forwarded-Encrypted: i=1; AL+hErFpOOZ47IFbJ59FY1u4toCBmIM8lzk2/KyMmE6fRyKFyTd/DQ0g7Nu+zhIndo/IJdDsQkTBlOs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+K62A3V62JE+RalCXG+XUT3cdVDaV9eDhXk2rj4cztTrrqIfOP
	yfj9odaBWVjzPFcukou0rlkxAGEFADEtLFSi0n9Z0qAwxCKPvV5QM1NO
X-Gm-Gg: AYBFou0q6SjP/eYrDAaOhZ8mErXgBvi9iZsR1/TB/4qvNTPuwKknTgz/AYl2K5mramp
	x+vzk2xXuo8N6kqJ6CNrhDXxjqWSXFA++aUkf/K/TRZVKx+E4VOvXh/VkgX0ld9jTkTrMaJ0Zpq
	ZkR54pB4X+JCKj8qfTQ6WH+WGhb+lXj7OaQ+lQY41M8CB4dVWeJWHKFRDBoJ9G+92gFrGQwWajR
	IkZh2QVjtwYjWGAtFbIAmkgzJXpnI7bhCFp77kDJAjvPtSg4wzB1aYYA6/u7asNuAj5BVKubaR9
	eR8cNmGe+Yiy0wvCfIi8QewDPCzt+C8kFX8ONMYIMXCbw/apol8k6PlKMvQLe34RP88jyEHmJ9b
	kZxOFC+Wsh+et2dKpFmaQeCGlTT27I4YVPr3Kach1P5wVLyuiSttHmPSmmHFXxgqQPs5vi46nYA
	nykExQo7oWGo/WaRc1rmeAJMHHiWp7006CM1HCjTJZ4SlO44uJRZVyIDMox+0GCSaSPm6/ev8Y5
	Kl/sbIjZEd8qKXffWuE493gx2CvGMX6rvDu7Mx8O6EC/4iUwG+XAIc6uMHPblDGE1zOGzB7pPO0
	ElBibxwDbpgdgUy6AZ8wdTx/QWzKpAZcmN4gPY/PZ0YlBHyJ
X-Received: by 2002:a17:902:c403:b0:2ed:892:584b with SMTP id d9443c01a7336-2ed40c4950cmr61777055ad.32.1794033456039;
        Fri, 06 Nov 2026 22:37:36 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed477a9301sm11315185ad.23.2026.11.06.22.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:37:35 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: ti: icss-iep: fix deadlock when disabling PPS
Date: Sat,  7 Nov 2026 15:37:26 +0900
Message-ID: <20261107063726.3388730-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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
lockdep reports this as a possible circular locking dependency between
the work and ptp_clk_mutex.

Unlike a teardown path, the capture-compare IRQ is not disabled here, so
the race is reachable at runtime simply by toggling PPS off while the
hardware is generating CMP events.

Drain the work only after dropping ptp_clk_mutex. The hardware compare is
already disabled by icss_iep_perout_enable_hw() before the drain, so no new
work can be scheduled once the mutex is released.

Fixes: f18ad402cd8b ("net: ti: icss-iep: Enable compare events")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
---
 drivers/net/ethernet/ti/icssg/icss_iep.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index ec08589..6264061 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -579,6 +579,7 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 {
 	struct ptp_clock_request rq;
 	struct timespec64 ts;
+	bool drain_work = false;
 	int ret = 0;
 	u64 ns;
 
@@ -607,7 +608,7 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 	} else {
 		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
 		if (iep->cap_cmp_irq)
-			cancel_work_sync(&iep->work);
+			drain_work = true;
 	}
 
 	if (!ret)
@@ -616,6 +617,15 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 exit:
 	mutex_unlock(&iep->ptp_clk_mutex);
 
+	/*
+	 * Drain the capture-compare work only after dropping ptp_clk_mutex.
+	 * icss_iep_cap_cmp_work() acquires ptp_clk_mutex itself, so calling
+	 * cancel_work_sync() while the mutex is held deadlocks when a handler
+	 * instance is already running and waiting for that same mutex.
+	 */
+	if (drain_work)
+		cancel_work_sync(&iep->work);
+
 	return ret;
 }
 
-- 
2.43.0

