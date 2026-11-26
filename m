Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682300;
	b=Fl/bazIo3wIsk6umTbJAgFhmujerODjGWBOO+gFjYYmVzmN6GHgsgFPraxe07H9Xebxx
	 qpslrB2FtK2ZhgNEHL78R0vIY/36RY/U9bXl0wCqINop9llEFzXbGGO6LqM9emXJv34qe
	 MFMLG3HykXnbu/t0PzZTYbrD45knOLG7lWlAZkZ/9/lzfR2MUIirk4f9EvQXUVd/1RG/+
	 7XCU7pwE+j7vDZ4wufuHeC5P+OROC4009sBwd69hIBlAdrHhMngVoftOIj2gmiUGV1Yn6
	 hqc3IND20cmTKKLcTE22GvoMKqTZtbAYKshgVA7V/idgaRyGI3ImH7+xFDztNhvbQsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fn8L5A34OqOZXMiN5h9TriZztWnWG14J3/PeOauC6Mo=;
	b=qhisd0E9RVqFD31tNH29HmFfIJeBajOdgIGk84diJruyQKaeEDWCeGUVRPrJ8idor412
	 pLRzInr2TSVyxqtrO2X18+Z0Lwud4nQnJwylYcv681LqpGjKYyyOqPg9AfLDowVKj7aFn
	 vJ6MGbCnV0CGUw/ihTAZeWmxZa+rBVLTKOICHdK4RdaCuEmBlgACp+8daQ4yqS/peBYoJ
	 aqYFChQ6yhzvKt2NfHEO4+ejaEdZ+mUpv36FmDLVpkuU53QMkJl2nA1sphyar7sZqryM4
	 xCZ8l1KZsIfInm6vXd/nYcaeonxpVZQbTs/UMb8Db5bnua4M2bpXgnk+BUzfv7vAoYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=luxonis.com;
	spf=pass smtp.mailfrom=luxonis.com;
	dkim=pass header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=ApDLdg3M;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E9606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 946E9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luxonis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luxonis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=ApDLdg3M
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49d05d51553so47498385e9.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 00:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=luxonis.com; s=google; t=1795682298; x=1796287098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fn8L5A34OqOZXMiN5h9TriZztWnWG14J3/PeOauC6Mo=;
        b=ApDLdg3MdRswDEI7SeBO2xKiJcqBl0rRT5U6lBsWE1J+T3HPXhJtZ00ThjSdzXlsaZ
         JcydvIqWYbIjexwKdV2b8h435oivEihEfqKiB7wAzXTJ3xxs3kjM2vjEW0Maz1L0QcaT
         p83gyjcDBKtXGaZOtFwaQTkQnD87qkeFimPcEUTJt6XaeGfipjY+RzTjlIXimPt01Ci7
         oOcLvDNMgV/5QcV6Xde8wXe8kUXrjI+LsLGJhXohkYD+7+44z8DeHDVSTVJ0Ye5FyAy/
         JnZfGTQI7f6y0WPgchwYikAQKiUMZjRW9x6mIBOMHAkR0vcaia/iWYJKXsMq2KKT6OHB
         /dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795682298; x=1796287098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fn8L5A34OqOZXMiN5h9TriZztWnWG14J3/PeOauC6Mo=;
        b=qMS0we0u2wuWEjQ2y49xnrXHuhD/F8hADklLyBdyuoQe0/J17xJS3x7pHl0lDO5pO3
         a7Jd6vEnNB3o16BWZijTKoFsAudvYVk9LfqyYydjpAFZjPMrEhdo86NlKiB840km4ajz
         +qQmWzUynHHeoEVh6WBJ1PskcyTvfp32wItMs+scR4aswFfItRFg/xpDYFP4hzIp+yUu
         rTKdG1XJtN19oujG49hOe5AhtizY2/GnzC2IEiMOaGWNn7f52v1b118MmlQKCDlm8Wwm
         L4S5prmCyFMgjZnRVes865e73Iuou0HLHfjFGcivWjJ0fDyIH5kORTZRoWUI47mxbzNm
         mquw==
X-Forwarded-Encrypted: i=1; AL+hErGENJcZBxx8hhIDtjYOrezstu3beYUDiwy0+UfdfJnlIhBotNES3dCs/v08UjIHZmyxhJOtmQ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MDicEHSbt2fsjov+dXggl0m5L/7y95tGc8eod2nVM0uSDE68i
	GdDHNVb9S+NGCXqrkWg2FDdxYsTRkXk1AnEkiW89cVp0loDMuW3oeEDYp0JvOi4U8kk=
X-Gm-Gg: AZFdTZfvK5gyFPs3tdZbpquHTlxwNZ+M6YxN0UY8uOdf/GII2ay+cwDxXspHzRxf20s
	q7KSRZ9YPiZhzx+kRKW/mobFlQClitx9iFNMcbhtUE7yTFrMDI48WTR+GE7L//HvP4LK0zyGXJC
	lIqqiQBtLwVli6g61KRvjMwCUVbGXndAZ5T4FXZzaa+AMDCQPmyfvq9aOOf6eNPydzeGcd2Z1wx
	RYuK2/zphUp9DzACNChmxOyiBSdrq5j6P3O8ke5/K2YiQxv3oHF78HsWq02BOTZMiYUo35pX525
	p6fQb9xrtQWh+xw6z4bbjHB31Ebix65UK4YnNtymPFzeF92QLSVj6T0nMGt1tU6etXl8GeiZM3k
	mO+kzvpLuqnicZtpPzd4DYhZAJ73PbP47wrXYIuu22XpJh5j5dvDvSXMMQKSA7pvD8bgqR4y1m7
	51xOadMkpyzUauiamIQXsTeneT4SbS4BkOz1yousAENpFSETdUDBZ0oxO2em/dVMg2JyXgBQ+H7
	9s7fmoaPR/07n0J1LUEKR2NS6WgBi7i04jVXEi6NJkgFBy5MjRl3ln3Pnyc6SrcJs484b5GYNb/
	IPBY008XqHM22q4A3i5m1UWNlUe64dN7QdP3LPAWSxAViO+y7BJ/nZZ/D0EnvBshDvX9GQ==
X-Received: by 2002:a05:600c:3b9e:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4bb88820687mr474456765e9.29.1795682297748;
        Thu, 26 Nov 2026 00:38:17 -0800 (PST)
Received: from JureBuildPC (46-150-36-237.static.telemach.net. [46.150.36.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865b1sm589984285e9.5.2026.11.26.00.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:38:17 -0800 (PST)
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
Subject: [PATCH net v3] r8169: clear RxOverflow before unmasking interrupts
Date: Thu, 26 Nov 2026 09:37:55 +0100
Message-ID: <20261126083755.1530514-1-jure.rebernik@luxonis.com>
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
(RxDescUnavail in the vendor driver) and stops receiving until
RxOverflow is cleared in IntrStatus, even after the driver has returned
the descriptors. Since commit 6994520a3328 ("r8169: disable interrupt
source RxOverflow") nothing may clear it:

 1. The ring fills. The chip completes the last frames (RxOK), then
    sets RxOverflow and stops receiving.
 2. rtl8169_interrupt() read IntrStatus before RxOverflow was set, so it
    clears only RxOK.
 3. NAPI empties the ring and unmasks the interrupts.
 4. The stopped receiver raises no new RxOK, and RxOverflow is not an
    interrupt source, so reception stays stopped until another event,
    such as TxOK, makes the handler clear all status bits.

This was observed on an RTL8125B (XID 641) on an arm64 Qualcomm QCS8550
with a 2.5 Gbit/s link, running v7.2.6 and receiving UDP at
1500 Mbit/s: reception stopped for seconds in most 30 s runs. During
stops in earlier runs, RxOverflow was set with all RX descriptors owned
by the NIC, and clearing only RxOverflow from user space restarted
reception. The order of steps 1 and 2 is inferred from that state.
Reproducing the stall needs no kernel change.

Clear RxOverflow in rtl8169_poll() whenever rtl_rx() stops at a
descriptor owned by the NIC, before napi_complete_done(). Clearing it
only when NAPI completes is not enough: with threaded busy polling NAPI
never completes and reception would stay stopped.

The clear runs on all chips that use rtl8169_poll(), that is all except
RTL8127 with more than one interrupt vector, but was tested only on
RTL8125B. Where RxOverflow is not set, the write has no effect.

Testing on v7.2.6 with two RTL8125B boards; a stall means reception
stopped for at least 1 s:

 - Inbound UDP at 1500 Mbit/s, switching between the old and the new
   behaviour on the same boot, 40 runs of 30 s each: old, 30 runs
   stalled and 11% of the datagrams were lost; new, no run stalled and
   0.012% were lost, almost all counted in rx_missed while the default
   256-entry ring was briefly full.
 - Threaded busy polling with the NAPI thread starved for 20 ms of every
   200 ms, inbound UDP at 800 and 1500 Mbit/s, 12 runs of 40 s each:
   old, no frame was received in any run; new, frames were received
   throughout.

On this tree the patch was only built. rtl8169_poll() and
rtl_ack_events() changed since v7.2 for multiple RX queues
(36af5aac9545, 5df447aee076), but the changed lines behave the same on
single-vector chips.

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
    v3:
    - Clear RxOverflow whenever rtl_rx() has returned all descriptors, not
      only when napi_complete_done() returns true, so that busy polling
      cannot keep reception stopped (Sashiko)
    - Say in the comment and the changelog that the clear runs on all
      single-vector chips but was tested only on RTL8125B (Sashiko)
    - Say how this tree differs from the tested v7.2 code (Sashiko)
    - Test both paths at 1500 Mbit/s, where the stall reproduces reliably,
      and busy polling with a starved NAPI thread
    - Dropped Jacob's Reviewed-by, as the code changed
    
    A build of this patch that counts the clears where RxOverflow was
    actually set: in 20 runs at 1500 Mbit/s without a stall, 269 were
    followed by NAPI completing and interrupts being re-enabled, and 320 by
    NAPI not completing yet because of deferred hard interrupts.
    
    With the RX ring raised to 1024 entries, which this patch does not do,
    no run stalled with this patch: at 800 Mbit/s the NIC dropped no frames
    in 60 runs on three boards, and at 1500 Mbit/s only 157 datagrams were
    lost in 20 runs on two boards. With busy polling and the starved thread
    it received about 69200 and 125100 frames/s at 800 and 1500 Mbit/s.
    
    Stable trees do not have the multi-queue rework, so backports need
    their context adapted; I can send those.
    
    v2: https://lore.kernel.org/netdev/20261121073652.410916-1-jure.rebernik@luxonis.com/
    v1: https://lore.kernel.org/netdev/20261101102720.702600-1-jure.rebernik@luxonis.com/

 drivers/net/ethernet/realtek/r8169_main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index f151ab681393..1da64c6e39e2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5670,8 +5670,17 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 	/* rtl8169_poll() is used only when there is a single RX ring. */
 	work_done = rtl_rx(dev, tp, &tp->rx_ring[0], budget, napi);
 
-	if (work_done < budget && napi_complete_done(napi, work_done))
-		rtl_irq_enable(tp);
+	if (work_done < budget) {
+		/* At least the RTL8125B stops receiving after running out of
+		 * RX descriptors until RxOverflow is cleared. All descriptors
+		 * are back with the chip now, so clear it, also when busy
+		 * polling keeps NAPI from completing.
+		 */
+		rtl_ack_events(tp, RxOverflow);
+
+		if (napi_complete_done(napi, work_done))
+			rtl_irq_enable(tp);
+	}
 
 	return work_done;
 }
-- 
2.56.0

