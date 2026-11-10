Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307851;
	b=0dKOmtUuJ/ORSRBpJhm5nTWZK4ZgFRBnInod7nLeMv+URKk/0BaAmpKe46uhQ6IRaWzH
	 Sa2+CND3ts8dMcFKCo1s0hO/jslHv4VUETY3LgxG8hnNWe9Coj5FF+drtqfhX8PUkJnWc
	 /D8IuIx0s7yUsAaG3fuHTYbyXNsg53lVdyEc36alvsmPWnaorry8cjdizl54aEGwCu6z/
	 qZdDjHgID7EM6zS6ZZ5JzytSEuGmJ37zo5Do/YYJ9/8B4UX8aN4X6E69r7XSZuy614kIG
	 fU9yVv2C3RXRMRQlsy6EoRZ02UOQLmG7tYzqIiBSk/gj3l4/C3Dvf3jxs9igatUsjNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AnDWGbanVCtYqiunIfMsBWStugmAURIRo8wUmU6j1tA=;
	b=UZOwG2Z+DzfDSpDZJHJKijGV05hPJSQD5jPo7/y+hjBwnmj9SPcfOudFffXo1Z9k3p4F
	 XUTL4/m9MUyKdZ/sYWEQyLIhEXMoEnSVW+NaIpY+ST7vP1k7yT3SjpOAur9wE52NWk/ui
	 5p+/qPjh05b5jgNy4yZig8p6ejgpkhBIMR2aS3suzyuU8u0FjCgug7w5V2H1pXtQ/hV10
	 dQqg3cpmDv1/p/LiG2RdrxxRUYE83di9jYYR5Jovcau3k4RIpKwiy3gDaylImEt+dzcye
	 vWzh99RLooaliNV6EKW2WLltTCEfvug81+UWxLIe9Eh8qBtwUgKslT3958qMb3OjsQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7oOBOLJ;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDB7D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7oOBOLJ
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-170135e43c7so2830017c88.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794307850; x=1794912650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AnDWGbanVCtYqiunIfMsBWStugmAURIRo8wUmU6j1tA=;
        b=S7oOBOLJgkm5j3tpXKpiwJK8P5y+iQiS8q2DMIqq1hbNqUzm3Dk9Nt3P44CdaCrFnC
         NP1lvXmBMlAZLOlnIfUtw/GDGqi+w1LuNye8okF2f3p0ztePm1n0Pwhdry4x7bQ5Qk+k
         L/mhIwUJT75aXGy9Cr82QMvFE7QF9OzoYoCmNt1uqiJ/VtTHPbqHCYey1HDMra8+WsKY
         UTT9n9segkNKlcyfDUmqglN0a3BdUI3nlcSbj2+zZqkBoF+pZ+kXkeGvqIFaqOyoFaQZ
         rMQlfgtW9dZc07qCWSy+dKhp138PASsfNg8ulKkUOytLlUrqKw6VzftrgIOyvWwqE2Bu
         2HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794307850; x=1794912650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AnDWGbanVCtYqiunIfMsBWStugmAURIRo8wUmU6j1tA=;
        b=hgB6P/pJCAbzuAKG8OyS6+Nj5szK2+lYyFUQyK0g4dA9xr9KcB1K740OA7FsT77OGY
         JGBedxuJYG/i6Y7Cox7CRfWGeTOw+gXg1UElTnr6VTr9Wrki5sR8Lw/mtKB5lnevFtx+
         HiNeRsQgtM3+0kA1aWvE3XpgvCtappmHSLKk3cRPaVx305T5G4p+dtHZfze2ifh+Zm9j
         GgbqoIaRjo8qoDfCoQjiEfKjNkVx6xsF2f9VFg12WP1kIenFJtG3srsoSduwrmxgntOB
         8hPS4VrevSNfsJXmatql52/o1zLAUds4HoF4gUjV1vcqqtacXkgWWaTPIHE6h4NFBq9K
         hhHA==
X-Forwarded-Encrypted: i=1; AL+hErHbK76EUwqFbtYVzXo71iaG0CfvZmmoVtD9CkB7eF8baQm7+k/QQmCDJ2LRjZMs89wCqSL/UFw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nd/iyM5ujBwOQkzX8+Vs4aZKNUiHE6SMRR/oQZIag4cxKjUer
	/Jojy1G7g1XMYGMtCTsyxnwQikt7E+wZVvynwrbMopUKnHcKl6chgvbCt+ZWa+ZF
X-Gm-Gg: AYBFou1f76CDE+q4MDp0tJhxDYP4O5Y39zJh1Qv7NL+zaYo/PlMmK7hNUOwlHbH4jbB
	lhjOqrlKYn7M+wMmcZaCcKQEvryAK+pfXh3xe3tbHwHnayA47lsLILTI7OgYBoEUfC/woAUxPys
	yZRaT7l0CeE9uPjHakUOJ2mlEkAWSO2EpVXEGHCJRuFozvanMkk48YN8LYoS5WdBcg4d48WRtis
	4zJJTEyBD03dd9YLVWsHpW9Oc5R5d1pWhiKozZ383mQaSaJR0KAZNYtvo8mnlQ7/U5T8B3Lj8ma
	FRlTgZtcTKGOj4FR+C5BWsSk0H19Vrph5ohXarwRw+syb/mIOsueD64XkZGLU2ZHKFmUSLvtx8+
	VV+mvw7wECvw08dsUYvcDpEFqf36hfBa84Q4Z6VBTcO+UL1xPHpVSHE0F8h819ZCBAD2/i04zDV
	alw+Qq55sxBoj1/6dq8UoaaFmUKGXZb5IAM2GnhlOixmeP+HCLIG9ZneqxzVK6+6maH6z/X+2db
	vAcsSKiLYZlpwMNbF+0Lff1M2XkODvlIBB3/zu/yIuiDRLcEcR/5L4WTlY5qJ7TfAY12nhw0SPr
	lusf/QaMTIzoLVDZWxEL8rrqJZuWipKduczoVpOGht9sWX7tsdbUAR0E2+jcrnJG0pa8WQ==
X-Received: by 2002:a05:701a:815a:20b0:190:b2de:1549 with SMTP id a92af1059eb24-1b3b5e6524dmr3147999c88.1.1794307849889;
        Tue, 10 Nov 2026 02:50:49 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2ff3bsm7899356c88.11.2026.11.10.02.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:50:49 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v4] ata: libahci: delete the SW activity blink timer on port stop
Date: Tue, 10 Nov 2026 19:50:40 +0900
Message-ID: <20261110105040.2483806-1-hj351016@gmail.com>
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

Shut the timers down in ahci_port_stop() before the port private data is
released. Iterate every em_priv slot and skip the ones that
ahci_init_sw_activity() never set up (emp->timer.function is NULL), so a
timer armed on a fan-out link whose port multiplier was detached before
port stop is not missed. Because the callback re-arms itself, use
timer_shutdown_sync() so a concurrent re-arm cannot resurrect it.

Not tested on real hardware (needs an AHCI controller with SGPIO
enclosure management and the software activity LED enabled).

Fixes: 18f7ba4c2f4b ("libata/ahci: enclosure management support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
Changes in v4:
- Iterate all pp->em_priv[] slots instead of the current links, so a blink
  timer armed on a fan-out link whose PMP was detached before port stop
  (e.g. by sata_pmp_detach() on failed EH recovery) is still shut down
  (Sashiko AI review). This drops the now-redundant ATA_FLAG_SW_ACTIVITY
  gate, since the emp->timer.function check already skips unset-up slots.
- Correct the Fixes tag to the commit that introduced emp->timer
  (Sashiko AI review).

Changes in v3:
- Shorten the code comment (Niklas Cassel).

Changes in v2:
- Gate the shutdown loop and skip em_priv slots whose timer was never set
  up (Sashiko AI review); superseded by the all-slots iteration in v4.

v3: https://lore.kernel.org/linux-ide/20261110090303.2415681-1-hj351016@gmail.com/

 drivers/ata/libahci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 001a6f5..6d73c7f 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2605,8 +2605,23 @@ static void ahci_port_stop(struct ata_port *ap)
 {
 	const char *emsg = NULL;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *host_mmio = hpriv->mmio;
+	struct ahci_em_priv *emp;
 	int rc;
+	int i;
+
+	/*
+	 * Stop the SW activity blink timers before devres frees pp, skipping
+	 * the slots that ahci_init_sw_activity() never set up.  Iterate all
+	 * em_priv slots rather than the current links, so a timer armed on a
+	 * fan-out link whose PMP was detached before port stop is not missed.
+	 */
+	for (i = 0; i < EM_MAX_SLOTS; i++) {
+		emp = &pp->em_priv[i];
+		if (emp->timer.function)
+			timer_shutdown_sync(&emp->timer);
+	}

 	/* de-initialize port */
 	rc = ahci_deinit_port(ap, &emsg);
--
2.43.0
