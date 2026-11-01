Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793528865;
	b=ITRO+5QtpfXWw+6OjYzvL9sGrkkdmO7bYd8jQB8NMWyhtu10ubhIDXiutG/2Mt5ygiP/
	 jYgPb/u5rurAHYdIP9gsOtAPdCLk6k5/1hRypYWFfCBebgqhlBXZqPVl+lCZZ+3H8kM9R
	 n+aKIIFOdl+7TwSFKNWSTUJUXpnLpqk0ZxXohJ1vSuyQZtdcNh2EgYKdcxHUGRtpnvo+u
	 Y+fsa+uCwUYCywl+eZQ5HwI6BxcrvbbvlSkW3PxBU4Smz4TiQd1fGTEkeTkZS82oz0pNE
	 Bt+5PJVGazpgUT7lp8n337T7a+Ja2+k4iY3YaNHZNkstv9YZDeVr747Vgy7SdrEC6sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793528865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GAbxTLtn8KLNWZOq5PdgC059WvyP0mvclyC7teVViSU=;
	b=SEtvOgA/Hgkt1/i+WWn59bSxWhFJfgzPJ5NTndkYkVeivJ7YYwQf/SpTuau/Az9yBHaN
	 ErL+DR+YE4uXZG5IkGjdoyBiWMjeJ6wFiwIXLcZfUm5BrzAM+5jIdh8wmcp0LJHVOxNAr
	 pW2DzHbA6uywkkoMBPBpDwZdLw5LYXuIRv2Td8tK79EXANMv+OwJmzzl1XeB0lAeYEJ8Q
	 G6wyjjdvO1ChqPE02eq2cIKAT2yJF75thl0PeEge2DCFL828WHyon47xVUzneztHnCaXZ
	 QGi+c5P18HVL/1VXT+V5DaOu7ZUdwqTkR9GtX/d2lWBUtMkv33O3/eDDoMw2m+yeHAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=luxonis.com;
	spf=pass smtp.mailfrom=luxonis.com;
	dkim=pass header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=QwTr8sUv;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF2606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 10:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DDF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luxonis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luxonis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=QwTr8sUv
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e47347279so1169266f8f.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 02:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=luxonis.com; s=google; t=1793528863; x=1794133663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GAbxTLtn8KLNWZOq5PdgC059WvyP0mvclyC7teVViSU=;
        b=QwTr8sUv/KGodkbL1m2zWyQ3JuqhHoYSM4qSetyyOTxnNv2im5wD3XXg3GAg8BJz9s
         12ykLdCsjW/71rZYQTVdeCkwweBxODh9VoLAo4VSoKvm2BZ0xSo5i0NHP8gf3kguLn79
         AXoNVZHpJTbErtL1kC6iENjo2pqZXXW13IlW4gQKsrSkPSlkIT1xprLFPFMU1TLXYF3L
         8tTZNnAlfWkaix5mBzqDdKcuRRvx0VQ+V6abrAI+Tm/s5Eae7UjZx4HDhd92Oq8EIMNM
         bUUD9+76Tbi7oTN/6KbVsuIkzil6O6aoP5e435fWlnhSEc6avM6xEgR/uLV6pPpRXA7L
         tOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793528863; x=1794133663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GAbxTLtn8KLNWZOq5PdgC059WvyP0mvclyC7teVViSU=;
        b=MV6hnrYoDEGMX1Qd0AR5ZvBontEiithdhycg5rQofLnkxecICqEKseUHJ5taRPyQCP
         yt9DlAfoQyU+HHvB2tKWSLke+Y12cjuBashkP6IKTIwPyOR3a/9BF5LY4gC1DS8b6u8K
         5ZWyRR1oOpCBIaACkp6yUmFTRLNVJTemdwMTld8OoyJqeTxpxm5zs925eI49Lo81+ul0
         L7PmkLWpnvLmLHc5nPnI54y/7ive1aWROMQXl8wWIZXpNeH8tzsP9KCQ/sclDAIS6V4H
         1TJ7ZeiOLbugwa728RZrYL4FAo9zZN7tG9+lDq9BzazB/B6D7EdkD5SaUpf1vgqw+06I
         FMcg==
X-Forwarded-Encrypted: i=1; AKwUvBzh9qrrWLzSzS+ctuyjjKa4pTAu42i5belpV8jQC+JrT58zKkfGl+ohejP2l3vtxq29sn+duuw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Lvuwo6gGuaSgrljBSwAHvVSi3bFruJ4QB7qJFU+2wdWxT4Bbg
	JgduBtCd3agYOHRqytv+tR0bsSVCGLUdcSoeO6eJMdCfD34zry1zHwmYQpur13CG+J8=
X-Gm-Gg: AYBFou3VzpXGum0yLyfPqCSQiXBvkRvSChOyddCa9SYYFwCpv2HKInlEe7q08o5sGCW
	HI558pRC3H8RqsBD0cehqqNJLznk5dxj9XImP1PZRQCyHNRbfR0a0ePhdH8DyWLsqqNi+3e0L1B
	63J3x4KyDL9kM+5eZvOxBN6fKUFGRLye3CohsgK59FriJFetE+pN4r9up4KjRgqpckkG3KZmxMr
	ZmTWxIN58I0N3rKjNQ+aBeKdIpWgQ/3NQvlYEgpuAOkOquG9rMXjlhO3LKwf5LHWEjXRBht2Sgv
	DToGomzwpCr3STVi5wcKsADhycq/JbL+K29t/80yFpvkN2fQBUGZIzu6MUn5e5kCtfQuJDiPdep
	EosuQ1E7maThfPvUQXOC5GXSCKQU2k0rd/HWyPR1SdnAjUKGFSVwikokB8cmsv7oEwZ4M7lCqJ8
	QYdRKHp2N31Qzv6eEc+WIJOd9k/h5iptBflOh55+2eP+DBuHb4GjUrtBmjPYO/mVXXJxxf+iBFK
	CKcl1zbUgxPsCX6T//UYCYcv5igZ9lEhJcTCPmpyOINpYmkFTEs3G8Fnn5nVBzQJ3au/kVb739s
	EDiFp7nJxQ/8R3imJ9HqhlgTggpmvYSeHRZynV/VBXNd+KWIiW8l0pm8zr8ns5D9NMc+Lt4=
X-Received: by 2002:a05:6000:4909:b0:48e:7eeb:4634 with SMTP id ffacd0b85a97d-48e7eeb466emr5258359f8f.49.1793528862631;
        Sun, 01 Nov 2026 02:27:42 -0800 (PST)
Received: from JureBuildPC (46-150-36-237.static.telemach.net. [46.150.36.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80306sm14521191f8f.33.2026.11.01.02.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:27:42 -0800 (PST)
From: Jure Rebernik <jure.rebernik@luxonis.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jure Rebernik <jure.rebernik@luxonis.com>
Subject: [PATCH net] r8169: enable the RxOverflow interrupt again
Date: Sun,  1 Nov 2026 11:27:20 +0100
Message-ID: <20261101102720.702600-1-jure.rebernik@luxonis.com>
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

Commit 6994520a3328 ("r8169: disable interrupt source RxOverflow")
removed RxOverflow (RxDescUnavail in the vendor driver) from the
interrupt mask on the grounds that NAPI is scheduled anyway when the
chip runs out of RX descriptors. On RTL8125B that does not hold.

When the RTL8125B runs out of RX descriptors it sets RxOverflow and
stops receiving. It does not start again when the driver returns
descriptors to it, only when RxOverflow is cleared in IntrStatus.
rtl8169_interrupt() clears only the bits it read on entry. If the ring
fills while NAPI runs with the interrupt mask cleared, RxOverflow is
set after that read and stays set: NAPI empties the ring, unmasks the
interrupts and completes, the stopped receiver raises no RxOK, and
RxOverflow is no longer an interrupt source. Reception stays stopped,
and every frame is counted in rx_missed, until another event such as
TxOK makes the handler clear all status bits.

This was observed on a machine in real use: an RTL8125B (XID 641) on
the PCIe bus of an arm64 Qualcomm QCS8550, running v7.2.6. With UDP
at 800 Mbit/s inbound and nothing sent by the host, reception stopped
for seconds in 13 of 20 30 s runs, losing 5% to 31% of the datagrams,
and a single transmitted packet restarted it. To confirm the cause,
a debugfs dump added to a test build of the driver showed, during each
stop, IntrMask 0x2f, IntrStatus 0x50, NAPI idle and all 256 RX
descriptors owned by the NIC. Writing only RxOverflow to IntrStatus
from user space, through the sysfs PCI resource mapping and with
nothing transmitted, restarted reception in 17 of 17 stops.
Reproducing the stall itself needs no kernel modification.

With this change backported to v7.2.6, 0 of 20 runs stopped and the
worst run lost 0.03%, on two RTL8125B boards. It was build-tested,
not run, on this tree, where the single-vector path RTL8125B uses
is the same as in v7.2. The multi-vector mapping used by RTL8127 is
not changed and was not tested.

Restore the mask of the chips that had RxOverflow before that commit.
Only RTL8125B was tested.

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
    This restores RxOverflow for every chip that had it before 6994520a3328,
    but I could only test RTL8125B. If you prefer, I can send a v2 that sets
    it for the RTL8125 family only (rtl_is_8125()).

 drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index cd4ebc654dd0..62709160d354 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6086,7 +6086,9 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
 
 		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
-			tp->irq_mask |= SYSErr | RxFIFOOver;
+			tp->irq_mask |= SYSErr | RxOverflow | RxFIFOOver;
+		else
+			tp->irq_mask |= RxOverflow;
 	}
 }
 
-- 
2.39.5

