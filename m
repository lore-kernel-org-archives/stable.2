Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216267;
	b=ajTH1vocilF7nSmv0gRQP7g+gXxWytbbwZijwF7Jas5qYZcv6+xv1NaY2LgD6uU7pcN2
	 yvrVHHUPrR4IDjYoJrQniqGbo/Czmqe/EQk9LD8V+wVxyDpHOEahO3/IoYkLu12QFGEif
	 ownQkrV/1b2gDJDBVWoigqbde83h2ZUZ2avIdnv+44RKF1sykepXqkG+WdoAlOm8lsiTr
	 IJjEZAWqhCIJV7m5R/MXVFr40j/BWKT3EHZSZNmyYvhfNWHNvOZBUTpd5q2ebz6rLkwwY
	 FrZuQ/cHXJug5W05g8olVAB70d3NCSNoFfc1xOBocdpKbPrS89Zi/gqpNXlpGUV5CwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pFI37l3u8zC3Prxu9gp+hh5bUJYQTYSaiZYyT2P9tY4=;
	b=LL/OFszdZv8cQbuEi+4LI2zl4frefPhI5TSs92AeJvTRTEuYAOJoOYcrLWeFVeiQ0McW
	 AA2oK0yIqXliSfaNufz8wPOCdplFvnTVhHAESUl/Cvygo4YSiN+3HjrofijYlEOETZ9Ro
	 3JYaF9+ID2DgcCaq9rfghMkJrTBpiA8G5TjTt1O7KhYuFk6yx3yNDbd+TjorUMF9bSXA2
	 wnyHlsdNAAryzQISJ8xkE3o8qmJN3RU7yZ7H1blx/6gOHGtf3MEbrz5SUrLdk1vPcDEEa
	 3baUvDn1evuWSnPoTv3Pn8PYqgDP1lFq/d8o79TblSid6W265I2M3/4uoZA5uu7lbhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=POwcUWJh;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233D606D80B
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A233D606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=POwcUWJh
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3704d30b84fso835248eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794216266; x=1794821066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pFI37l3u8zC3Prxu9gp+hh5bUJYQTYSaiZYyT2P9tY4=;
        b=POwcUWJhRVGKOBm2//Q1aL9FvlAg6++8vRHkx0fa2yyCmHy6ZxAwrj0WBAbCm4ATvs
         Vvhnl8SFPff03A1WgWrhUVReAP4tNVxYDP4MXUnxJp/m7HUHgA8QTPiBN9Fjt71a70Ft
         GAeemBEg9qCGyv8Zkfp66bw4czK5SBDcuTKQfnjOfzY42PRIqZmlBIzMBDzEJ7Ohdmty
         vTbPHSDo89ppM/4YI2qPV7csX4Sw+JIv7A8/DZId3wtAKHfIR6Dg5OUNh+julFhPkB62
         M6IHbgB8VBlTjt+x/b/BGWEyStdYR2bIfGuIFvOqIrnSXGKusgqxt0rF/ob3zV+dLCCB
         s59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794216266; x=1794821066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pFI37l3u8zC3Prxu9gp+hh5bUJYQTYSaiZYyT2P9tY4=;
        b=x6PcFHGpPWXiljO0Oj4hqNeeiHxV4q34J+1TbJ20QrQ3pgCxqMCXyY71x9ER1j/NRt
         /jseR6OR+QDg4dvtWgMNs2TPdGYTbmZEF9VZ/Yl+vZK2MNtvy2MS51OcRmr+Ow09Y8Oj
         5pd1obS4XDZp9+mYGNEC0U/g8vfRAqw15yRiNUKWkwESjLqMfS+1hsV9i3FlA07KifEj
         kjLqGZvN9Px3EkyySKXSWKkPA2CmZgWI1M11JS4p7k0lDv/Q5XBAggGalYDj0Vmd4Nvp
         TYLP4uozRq6w9nzDZkbyRL0B/qrRZllLUjSbuXhDOAow4lBnjVsHdGKUxREKAUCH30FW
         2Sig==
X-Forwarded-Encrypted: i=1; AL+hErEQDUWOAkGGtMRHLHyde+SXtmRpFyDFzj6Sxtc2W/uQ0pjT8dj4GFu/prEX/hncfkyjkh0eH8E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RLQ1+jAqslfaJ0E+7b0Q9iTjgHmZ8bCIB6WueSPUd0719JwCy
	27DubtI6K+mWhu4z5vgRguZIyLtqemYRttZh3m2m6wPwajHr010NUimQ
X-Gm-Gg: AYBFou3/NSd3RFLdqeXmVzimHuBI2mf9+8jhiQBfKOAf49dMBb0bRCNC5FACLwcoSDl
	Ph4Kf2X/MHp+V4gao904eRZPTppvDp7qbTCRwsyVKFuSQ6hpG34TNB1YufkKrMZoSMo/zD7DkrC
	OikjXvEp/yYENH9LiJZMeIo8d02oUPN4/2JNydnPCFjqjP7CN1zh9g0S+5fUO5vi9UrAniKnMnM
	kSNeit2tn/jxBniRrrMpUYDfjmpLKuHMRNDNpv8OqPHgUBxMZZOzg5tpke7or+W6G1kPesUOzhY
	0/Gj2AKbtVF/IzAhIx3a58BXLBelXKKsZ4M9sU5OOmivvjkf2v/VwoZSkYQ1HzCgSnYcTZjtp1K
	Or79VDZRMp7wJ+S6z/94llmSKn7to8bbKb5td/oll6av8vt6OdjE+ucC/Vk+8wS3eq34R73RHwj
	ook1Vorm8Pt4bNTWUiPg1clSSBQerDXx7rDBIFN0y5SBG0qOHy1o1h2krGzqmFv1vurMd0y5tm1
	kj8c/XxpdBZFodiGW1nwD7It3ehbHpw+Y6R53w4HmauP0q8EmLEnYr1ucJCZkyV1NBONI3r3Myv
	P1xPiWN6+/xBX6UHPD0vWgTDkH9INrV3+gHGlcIn7y1A7PHo
X-Received: by 2002:a05:7301:1885:b0:36e:d060:8bad with SMTP id 5a478bee46e88-3725b06f63dmr6559413eec.5.1794216265687;
        Mon, 09 Nov 2026 01:24:25 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265c0701csm11989483eec.13.2026.11.09.01.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:24:25 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2] ata: libahci: delete the SW activity blink timer on port stop
Date: Mon,  9 Nov 2026 18:24:15 +0900
Message-ID: <20261109092415.1436149-1-hj351016@gmail.com>
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

The software activity LED support arms a per-EM-port timer (emp->timer,
ahci_sw_activity_blink) from ahci_sw_activity() on I/O, and the timer
callback re-arms itself while the LED is blinking. emp->timer lives in
struct ahci_em_priv inside the port's ahci_port_priv, which is allocated
with devm_kzalloc() and freed when the port is torn down.

ahci_port_stop() never deletes this timer, so when the SW activity LED is
in use and the port is stopped (driver unbind / module unload) while the
blink timer is pending, ahci_sw_activity_blink() runs after
ahci_port_priv has been freed and dereferences the freed ahci_em_priv
(use-after-free).

Shut the timer down in ahci_port_stop() before the port private data is
released; timer_shutdown_sync() also stops the self re-arm. The timers are
only set up (ahci_init_sw_activity()) when ATA_FLAG_SW_ACTIVITY is set, so
gate on that flag and skip slots whose timer was never initialised --
timer_shutdown_sync() on an uninitialised timer trips the debug-object and
lockdep checks. Sweep all EM_MAX_SLOTS em_priv slots rather than the
current links, so a detached Port Multiplier's fan-out timer is not missed.

Not tested on real hardware (needs an AHCI controller with SGPIO
enclosure management and the software activity LED enabled).

Fixes: 18f7ba4c2f4b ("libata/ahci: enclosure management support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
Changes in v2 (thanks to the Sashiko AI review):
 - gate the shutdown loop on ATA_FLAG_SW_ACTIVITY and skip slots whose
   timer was never set up (emp->timer.function == NULL): calling
   timer_shutdown_sync() on an uninitialised timer trips the debug-object
   and lockdep checks
 - sweep all EM_MAX_SLOTS em_priv slots instead of the current links, so a
   detached Port Multiplier's fan-out timer is not missed
 - correct the Fixes: tag to 18f7ba4c2f4b (which introduced emp->timer and
   ahci_sw_activity_blink) instead of the later code-move commit
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 001a6f5e4172..3f6844acb413 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2605,9 +2605,32 @@ static void ahci_port_stop(struct ata_port *ap)
 {
 	const char *emsg = NULL;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *host_mmio = hpriv->mmio;
 	int rc;
 
+	/*
+	 * The SW activity LED blink timer (emp->timer) is armed from the I/O
+	 * path and re-arms itself, and the ahci_em_priv it lives in is part of
+	 * the devm-allocated ahci_port_priv; shut it down before that is freed
+	 * or it can fire against freed memory.  Only slots whose timer was set
+	 * up by ahci_init_sw_activity() may be touched -- timer_shutdown_sync()
+	 * on a never-initialised timer trips the debug-object/lockdep checks --
+	 * and all EM_MAX_SLOTS slots are swept, not just the current links, so a
+	 * detached Port Multiplier's fan-out timer is not missed.
+	 * timer_shutdown_sync() also stops the self re-arm.
+	 */
+	if (ap->flags & ATA_FLAG_SW_ACTIVITY) {
+		int i;
+
+		for (i = 0; i < EM_MAX_SLOTS; i++) {
+			struct ahci_em_priv *emp = &pp->em_priv[i];
+
+			if (emp->timer.function)
+				timer_shutdown_sync(&emp->timer);
+		}
+	}
+
 	/* de-initialize port */
 	rc = ahci_deinit_port(ap, &emsg);
 	if (rc)
-- 
2.43.0

