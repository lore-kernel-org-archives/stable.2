Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795246631;
	b=0IWs5V6G27TW06Tl2t7mMfLfStWM2M4sW11Ltb1TIhziDBAOVvr/gHFCNDdxMzdspU1K
	 /Eu79RpeDKdCXa+no6pc3cDGSjqx3hF3A/cYEHi+ieTJGymhT5ZyrMWsPBIQlPtvKI8zI
	 xuXZ683fZvJzDG7By3K6EhI+bnrqZoljtgWqY1OzjjBReT5TjSO4QosgawUTd2w6kB9RM
	 ZvIQlUyibeuKRok74JM1rlegAXUVpvEHH2O+60NgEg6a1LugQRZGM7p/uIiK5qNozyMOG
	 ECEgG13MZQsDngpF/1uUOg85WTU0J5Tflevk3YOJimhTtXUlYkE5OaG7TDArORK/xNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795246631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oKJbFsXVmFySjrD7iPV/I2lv8ymeZ/7zHMMUw+Z1AIk=;
	b=2cGYP15Uso+2i2i1EXJ6yRu1bOjsYlQvxyT73Qz7q3bfikqXCIiSAd7OxX2Uj9YC1//2
	 qjosx7ZQG2pl/rlnE4kCMKiojnC0mGhtRM00QUi0wtxpI87miiE9Pumr9eSBo33Bf11AG
	 b1w/hQfMO+XL8leeO7zS5afkMQB9Ixb/G08stjjz5ehyPsOhJ8ZVSrJKBdTjQ12r98lK1
	 6zb0aqYSIeAHkYcnWqs9LnTQVhMi3jFNNxzp9oZVYR0WlMLI34UMNSaW8JtZ/Lij0plbq
	 eh10lwYFkqrSzIdUl5Mw6KtSYr5bWV6X/4qIYwBNZkdIreyco1hOD/cR/kV377ItZHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=luxonis.com;
	spf=pass smtp.mailfrom=luxonis.com;
	dkim=pass header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=Kc9Ib98R;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164FA606A325
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 07:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 164FA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luxonis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luxonis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=Kc9Ib98R
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e09aa5264so880536f8f.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=luxonis.com; s=google; t=1795246629; x=1795851429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oKJbFsXVmFySjrD7iPV/I2lv8ymeZ/7zHMMUw+Z1AIk=;
        b=Kc9Ib98RxwddyjrGkiLXxpmVqLPSynnLxtQ1LjdjQFRMM3prBT1tjJ1xxZx5fR1+lm
         5mUEZt0AZ9XNhWQrIUj63WGkpsMuDsdJCO9HPeWg5N+muf+NvvLiww2zTY8s/vij88f/
         EqbtOUzCsx7kmD++xYp7iQiUwO2L2W7/IiUYE2nqeQDNtE2Dwuj8FLr/exoP0CgMBhXv
         RmsaXnmDwt9U9jYZivSrbeosy//TqgnWgV1vqn+95NDHKZIESF6yXA/m8mWy74C8722q
         s/+peetHzFRt+DTUkpv8PMKyRQW5aPzfkqwfA6pk6rWh3ZGlVmh3qxSRGL9JPKqE9y/P
         N7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795246629; x=1795851429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKJbFsXVmFySjrD7iPV/I2lv8ymeZ/7zHMMUw+Z1AIk=;
        b=sBgrd+PzwL3A0+Bm6UdXZCimysgqV88fugCa4NILTVc6TtcllnKuI1Wu00UV5//JEH
         c8RZnv42Z0C/pvP+7JR/d9mQ+ecAjVIokI4Ikx25HanpwzP+hdFP0wZ43etnvShpQxXc
         l3e6fdrDClRlaXOHGEVgd/onkArP4kFEjCg2e/I0ZP+9FxIto3UvvWGVJPitjTKo0jlC
         1wnfHpCXUs5DYHlBGEq/pnhfzAkhAZVi1O9sDcAiU3wMp67+IV6FSEUKCMFwQF48nDI5
         hFit05AeeVj4+diEmMZt0ImcG0Q3DG15BHvnhhTgwMPJjcL02Vb94LMQTgQt1cAUr/Ld
         mx3g==
X-Forwarded-Encrypted: i=1; AL+hErH7/OIcM7OPPG2gBaHaVVR9zh4nW83/EIYe+6Asloq/JH5B4A2cTIHg1VKaFupkZfTVm4EPYSE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oC2G6ywPplR6zlHyrp4PI3/LqPSuAdxPJAT5Dkq0+zinoWBLd
	xpVMXC4X/DS4lazaj6veXry2+0jHYtpFbrXE9Aa9+DqC7dBsb+uC/wjWbZRDKsRxEuw=
X-Gm-Gg: AZFdTZdG+ytUfIgwGJBMOb5cyLbZ82kYNRbgOr3ixf+qeQJwtPTgLlZGgEpkOQhHfzE
	N7w81RJS7bEUBVEMVxjtD7InTo+xOpki3H395JNl8eehv8jzqFGYmHM382pSGwKvj9i1DS/fMIu
	7jcMSwOJHxykIVhp+w3MKKa4MUOtAjVbD7+DS7qTra9TyENYBQhhEbHNyZuSrS5+uhBVXKX0ZAA
	ytK5V/sOy7KUho9bIbmmtACw08KLQMGDkDMojpD+QFmHSs/xHxa7DlTSjpeO3I4xQvqkBC07LHY
	D665NZEnYtc3LiYF64WtTS6WeLOt69jZMf8mBD1fYXULyGOjQwBNbXrBsNZyTvSHVraO1qhW25V
	Uv1TVlbm+QuB98ltHVYryoA28zdBB3Vc5FUFSIDFv3lWD02zyYooaqS5U0o9I2dDyALnagt6j06
	bX6onha28RQ/diJj4I+Kd54r9Tz26/dfrBEuH2AQJyepehDuN0w1e3cSHnCq4BzaE1UlgdES61e
	vm3uxEGMocij0DorrA0rEoCqQC+DpQ1D2wdWfEsDsw/oHrAYYHABP3S2pBGrxV8PfkvEJYtECKN
	d/Neyp9wcfkj5nDK/tD8rqYtrodH55pG2zhpMHs68Fbl9UDBawv0KsH5zK+wnGCuJWA/gg==
X-Received: by 2002:a05:6000:2602:b0:48a:f404:695e with SMTP id ffacd0b85a97d-4abb5518f07mr11610591f8f.50.1795246629309;
        Fri, 20 Nov 2026 23:37:09 -0800 (PST)
Received: from JureBuildPC (46-150-36-237.static.telemach.net. [46.150.36.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f281sm9508933f8f.22.2026.11.20.23.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:37:09 -0800 (PST)
From: Jure Rebernik <jure.rebernik@luxonis.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-kernel@vger.kernel.org,
	Jure Rebernik <jure.rebernik@luxonis.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] r8169: clear RxOverflow before unmasking interrupts
Date: Sat, 21 Nov 2026 08:36:52 +0100
Message-ID: <20261121073652.410916-1-jure.rebernik@luxonis.com>
X-Mailer: git-send-email 2.56.0
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

When the RTL8125B runs out of RX descriptors it sets RxOverflow
(RxDescUnavail in the vendor driver) and stops receiving. It does not
start again when the driver returns descriptors to it, only when
RxOverflow is cleared in IntrStatus. Since commit 6994520a3328 ("r8169:
disable interrupt source RxOverflow") nothing may clear it:

 1. The ring fills. The chip completes the last frames (RxOK), then
    sets RxOverflow and stops receiving.
 2. rtl8169_interrupt() read IntrStatus before RxOverflow was set, so it
    clears only RxOK.
 3. NAPI empties the ring and unmasks the interrupts.
 4. The stopped receiver raises no new RxOK, and RxOverflow is not an
    interrupt source. Reception stays stopped, and every frame is
    counted in rx_missed, until another event such as TxOK makes the
    handler clear all status bits.

This was observed on a machine in real use: an RTL8125B (XID 641) on the
PCIe bus of an arm64 Qualcomm QCS8550, running v7.2.6 and receiving UDP
at 800 Mbit/s while sending nothing. Reception stopped for seconds and
a single transmitted packet restarted it. During each stop, a debugfs
dump added to a test build of the driver showed IntrMask 0x2f,
IntrStatus 0x50, NAPI idle and all 256 RX descriptors owned by the NIC,
and writing only RxOverflow to IntrStatus from user space, through the
sysfs PCI resource mapping and with nothing transmitted, restarted
reception in 17 of 17 stops. The order of steps 1 and 2 is inferred
from that state, not traced. Reproducing the stall itself needs no
kernel modification.

Clear RxOverflow in rtl8169_poll() once NAPI has emptied the ring, right
before unmasking. This restarts reception without making the "ring
empty" condition an interrupt source again.

Testing, on v7.2.6 with an RTL8125B and inbound UDP at 800 Mbit/s in
30 s runs:

 - A test build with a module parameter that switches between the old
   and the new behaviour on the same boot, 75 runs each:

     old: 9 runs lost more than 1000 datagrams, 1041366 lost in total
     new: no run lost more than 1000 datagrams, 846 lost in total and
          at most 184 in one run

   The 846 equal the NIC's rx_missed count over those runs. The NIC
   dropped them while the default 256-entry RX ring was briefly full;
   reception did not stop.

 - This patch as written, without the module parameter: no run of 20
   lost more than 1000 datagrams (166 lost in total due to the default
   256-entry RX ring). With the unchanged driver on the same day, 3 of
   10 runs did (237264 lost in total).

On this tree the patch was only built, not run; rtl8169_poll() is the
same here as in v7.2.

The investigation was done with an AI coding assistant (Claude Code):
it wrote the HIL test scripts, the debugfs instrumentation and the
register tools used above, proposed this change and drafted this
changelog. I reviewed the change and the evidence, and the test
results above come from runs on our hardware.

Fixes: 6994520a3328 ("r8169: disable interrupt source RxOverflow")
Cc: stable@vger.kernel.org
Signed-off-by: Jure Rebernik <jure.rebernik@luxonis.com>
---

Notes:
    v2:
    - Clear RxOverflow in rtl8169_poll() instead of making it an interrupt
      source again, as there should be no "ring empty" interrupt (Jakub)
    - Describe the race step by step
    - Same-boot A/B test results
    
    Keeping the v1 approach also fixes the stall: with RxOverflow in the
    unconditional init of tp->irq_mask, as Jakub suggested for v1, 0 of 76
    runs lost more than 1000 datagrams against 5 of 76 with the old mask.
    I can send that version instead if it is preferred.
    
    With the RX ring raised to 1024 entries, which this patch does not do,
    and v1 or v2 of this fix, 20 runs on two boards lost no datagrams at
    all.
    
    The patch changes only rtl8169_poll(), the single-vector path that
    RTL8125B uses. The multi-vector path added for RTL8127 after v7.3 has
    its own poll handlers and is not changed.
    
    v1: https://lore.kernel.org/netdev/20261101102720.702600-1-jure.rebernik@luxonis.com/

 drivers/net/ethernet/realtek/r8169_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index f151ab681393..99b0a410f58e 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5670,8 +5670,14 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 	/* rtl8169_poll() is used only when there is a single RX ring. */
 	work_done = rtl_rx(dev, tp, &tp->rx_ring[0], budget, napi);
 
-	if (work_done < budget && napi_complete_done(napi, work_done))
+	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		/* After running out of RX descriptors the chip does not
+		 * receive again until RxOverflow is cleared. The ring is
+		 * empty now, so clear it before unmasking.
+		 */
+		rtl_ack_events(tp, RxOverflow);
 		rtl_irq_enable(tp);
+	}
 
 	return work_done;
 }
-- 
2.39.5

