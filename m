Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794160920;
	b=bxg7Iw5sKKs+60enRwYIOXfRXLdTZQ0Tbmj0wtTHbSYkihfN3Kyjan6ksayElcbF/Vm0
	 o+g5hP88scuCkN3atAdY5qJXNkfOphX924j4YZaQZxLsaJCwGvIyP4Wzf8MmRbqaZkUOx
	 zckcndcqxs1/9a6qVWNx58x2SvduAi5YolZS6Qudi0sm8UAQZFwZzXs4Tv7OmGo99Za1I
	 Bb0l8e0dy53uA7qiaebZM/UYiL8FDCO5GbY8KCFgpXsMTAU1es3Bcqrajyu51exc6eMy0
	 MItmwtgKFQ1lTYotpeMluifc/Ygorj6+0exAyY0Dz27i09F2vp16fK3NgmofTFrRh6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794160920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AryQU7CqG24/r+NiOYec3B/lZ+GdRJNknAEAX2AGwNI=;
	b=ufuLv5fClotYJXgN7DOZuw/9YQPOPzyTnFrfO1uiSFsvTp6R1JUjSdZUPxmujzzEYvbJ
	 5xcy6Kc0mwWu28iClhTdb+Kedk3R0UikxX8bQqU5kXSszWSIT705pMkifS0BT10VNJ9+/
	 44FRgrbhwgdyDX/ZuThWAAyWWe2nUYK+r7uIqIBa2crCFzMHEIZLVvB9Y+GijgEolxwtR
	 2wKHiSW9WZ957B+Ri5zv3A2XwZf2lzYW/F3SJ0dcfS3bwDSU1w2fvlSPC4vMB8fIu6Qks
	 QM2xU+cEIAPrQis3iHau6HeVSv4K7Zzm54K6N+ZoHz+4BPITXBhxM2H799P3Qq44wrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ctrdQGuK;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B27606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 18:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2B27606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ctrdQGuK
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36f6295304dso200462eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 10:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794160919; x=1794765719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AryQU7CqG24/r+NiOYec3B/lZ+GdRJNknAEAX2AGwNI=;
        b=ctrdQGuKBIDYxv+Pr5fuEd9lWvvp/+ykFKPPW6jyc51ty42U/81eMwrhyGbHajr0pB
         /ECkIFQr2fzCw8v2m/8Pv8MGfPc25QEQUpZtGgfdzsdLKukCpoj83UjukbPrdjOS6Fs7
         GvJsgbS6fNHA20ITNDawIdpcFbAYmXdDUwpbSCez3CeRPaXBZP2pAKyBGIDK7QoQ5uHM
         XSWTh9qXlTSFjpsUjoDuLvi02LjObwJ0vwHN6ZlpH4fSZlA3Y1V7yWSvkq6clZzgok/l
         Wcq8YUgg8Fk2Nt6SxJJ3KA5Q+nNc+dWTVXkKrtEGlMeey95GAYFtcRfZrxRoXlISLJRe
         zzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794160919; x=1794765719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AryQU7CqG24/r+NiOYec3B/lZ+GdRJNknAEAX2AGwNI=;
        b=mBmrb38Ze/c+14xRN2vbrXJJsSgmV6hnnC8wywplH/4FsDATvtWMYb9zf60VILuyWC
         DXsZlaBSHXTzrvqToculba5AaZ5H0KPFKpTOkni5n0h6KgiTAWgZiL+B1eqSa2EmE1ut
         I52HeWkV6WKmbFEa8M0DJHv+FChfPECJYBJ3+1QOgf+ECznAwm5upfHVs2l4aoQ3An76
         4bHigzi2H+wVXBboW0mNbgL2Wn4bidrqxlPXOCFgP/QgKTfupLlQlHH3E1N9WRZ1wI/h
         9B+V95laXPK+R1XhyuG499jo6tL/Zsi5KyIf6ZW4MXSDokQM1SIunZLRJkNlJ+/HldBy
         8b5w==
X-Forwarded-Encrypted: i=1; AL+hErEdSnsl0yGO8iCszgcGKRGVfdKOg4zhQZN08inuMmD7mlQzbuQw/JTFvEiMzKDMxy/s3bLxxm4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TOAgjdWbM+TJyvv3MTETqJrlaI+fMxfbHnb5xchdBT7BzyJPp
	C+32EON53DeWbjbcyZhL4EYrVpLyYTYoWVWF3uPs0LQJFpSzT44s2ZERuszBEndm
X-Gm-Gg: AYBFou2fmiy6C5qBsmbGYDVBZsE0m8UmrOQetT/Dg22JraqfxZtxG7h/OCJn9rbx05k
	maa/DvkMA6e7U8qBEfZnaYZx7/c+ddqZrsNwiXrxlok7WT9nj/LkqZxB4CB7kr3LyL/LSfMVTJe
	dm4+8/f1qvZEtkWAueFfJAD1Z59AkLIntvLX6bjYL9yqoSeOMxiInQF26tYc+YyLeiTZV/zSGo4
	5djdvf/nwk2dzTqJft0s8hWm05JDsLmiF3hwAP7QiSCFW8mwMbWKaCYmUswyH0pRTdYoI3UDcyh
	hWFfQeQuetBujU6aWCdbzrj7oRif86nlLS8bkCzPW9D0fUc8uWxZHsz+fOxeTiZ2P3uxEdupOi8
	dWiQAw1hm/zd6ulUtSOzZt2dxz1Jy3yQufrN9Acuy3BRCbs7vLrSAaNPeRPMt1cGJjkV8JLE818
	j4S01yQgA/RPfB7xnXw9v622R9Y8C6EI5aKZvEQY3ngy0jsYY5NMHuR8+ItpIwR27HOTqRKngqv
	yUzxBCsTJtUYKKqDYHA9hA0AMNgRRCslaPUvemcY/MSCG7QF5bQKRKN7WP4U1gjts8fMIewC+XC
	i7l1YpsIkVMfT0E44eiA+AShu7pp2/dEMvDTWzb+2TKh5culI542kbXj86qO5vH2wnh00g==
X-Received: by 2002:a05:7300:c3a5:b0:373:5561:8d06 with SMTP id 5a478bee46e88-37355618d75mr936629eec.37.1794160918896;
        Sun, 08 Nov 2026 10:01:58 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d60absm7072856eec.26.2026.11.08.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:01:57 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] ata: libahci: delete the SW activity blink timer on port stop
Date: Mon,  9 Nov 2026 03:01:34 +0900
Message-ID: <20261108180134.734111-1-hj351016@gmail.com>
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
callback re-arms itself while the LED is blinking. The timer lives in
struct ahci_em_priv inside the port's ahci_port_priv, which is allocated
with devm_kzalloc() and freed when the port is torn down.

ahci_port_stop() never deletes this timer - nothing in libahci does - so
when the SW activity LED is in use and the AHCI port is stopped (driver
unbind / module unload) while the blink timer is still pending,
ahci_sw_activity_blink() runs after ahci_port_priv has been freed and
dereferences the freed ahci_em_priv (use-after-free).

Shut the timer down in ahci_port_stop() for every link's em_priv before
the port private data is released. Because the callback re-arms itself,
use timer_shutdown_sync() so a concurrent re-arm cannot resurrect it.
em_priv entries without an armed timer are zero-initialised, for which
timer_shutdown_sync() is a no-op.

Not tested on real hardware (needs an AHCI controller with SGPIO
enclosure management and the software activity LED enabled).

Fixes: 365cfa1ed5a3 ("ahci: Move generic code into libahci")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/ata/libahci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 001a6f5..873645c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2605,9 +2605,23 @@ static void ahci_port_stop(struct ata_port *ap)
 {
 	const char *emsg = NULL;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *host_mmio = hpriv->mmio;
+	struct ata_link *link;
+	struct ahci_em_priv *emp;
 	int rc;
 
+	/*
+	 * The SW activity LED blink timer (emp->timer) is armed from the I/O
+	 * path and re-arms itself; shut it down before the devm-allocated
+	 * ahci_port_priv it lives in is freed, or it can fire against freed
+	 * memory.  timer_shutdown_sync() also stops the self re-arm.
+	 */
+	ata_for_each_link(link, ap, EDGE) {
+		emp = &pp->em_priv[link->pmp];
+		timer_shutdown_sync(&emp->timer);
+	}
+
 	/* de-initialize port */
 	rc = ahci_deinit_port(ap, &emsg);
 	if (rc)
-- 
2.43.0

