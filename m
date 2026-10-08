Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A245E4D5969
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470961; cv=none; b=F9vABvTloLvG/1q5vPd6/tB+mLa6gTwsef6W4hno3BR4EaTSsv843nF/kEA2+o31JVxVFdIRJ1YvigHRJNLBa90RxSMJWNV7DRUHWPgRlUbRXQs7ZbuUGt94vczjpxEbsu2NjhbC4PuQNOKF10fLg4113HDNyDfxTupwwSYfEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470961; c=relaxed/simple;
	bh=Z4KM6it7J4sJFNp5ElHidaQWReJi6gu8FtZQWjz+lZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTMLH1wSfok/ojMlwZSMddYaDtKL1A16TOdWBBi0sn7SWHjx129j1wg988hXViGzaIed+LrjYpJz9reeByGCKPscRUWL2qBkeExinexFyHbzn+si3LEl9NPn3ppLRCxSEkQZ9tBD1xjkkgyTm1DCC3CypgMvLm5farnj0HrAV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUCkjUT3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUCkjUT3"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8f4so1475905a12.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791470949; x=1792075749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OzeqoCgVrB5t7K0uEMyihnfZQe0JdhUNQX8JWUB88Jg=;
        b=VUCkjUT3oaGoP1SaGhqG2aP99Aw6yh3nyHVmo5Nklr1DL8QkqoQbmtoP6EzGwi8iQG
         39oYxHqorIu3GXodkH/QdeRT38O868BHLJLD/8owhWTk57tMLuJ/NMa38NIjfeosmZxU
         +bviWoqV67XSkwMBjZV08BHShh4TZpfUWwfhjrPmugCKqGRjnNurtpFSiUp7NhX7GKVE
         DOTLYAxnx9di+/5XvvnokTCfLgdwER7rhSqP63q0TpzeEyxIbvDFx2ZaUWD6OznD75mt
         yayDGENS8UEM9gKXzUGO3VEhb9KXIaWsb+xNAUUEKIhynTqISThAsGttpno5czl7fGTx
         VbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791470949; x=1792075749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OzeqoCgVrB5t7K0uEMyihnfZQe0JdhUNQX8JWUB88Jg=;
        b=L+MJDqJFjvdkeI1dpq9FHP24RB9gvlxcpBK8hbTvF4yzhl/FjoclKYCsWrmRMcJVWy
         FPBAAC6VP71s0rj9za6Roa/sNlmNtsU+oo/MC2CWcFgnA27ZO3Bzt/xh2kGyvDw5Uq/t
         WU+/+0HGT1fDTCu8EpI3m0oYwANFNEff43Al6S5NoD+6pWOQeMUKk7QQDGy81cDTjlDM
         CFwGwGqvi+DykrmNNUbuia4T09UQzl24KrvCxKd3oyAqPg6ET6CzjyjTIeO0JsHMlydk
         7Y31xc6eu5G/0Ae837zMYhozIrtYSSeAL+obYKDuSCc81wPexn4Zho47r3vOSw2pFERS
         YAvA==
X-Forwarded-Encrypted: i=1; AKwUvBx0kp90eCmu48A2wItce1uK62olnMZyC8yS7mQa53XN31Uyw3WsCqtQmrw9gED11I66/ZKJOeo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHvJwE9qHQS1apQhlIK8EZ+k3/hHS7iPL4yZklQ1W2KyFZAqN6
	v2Wp4U3eFavnsWYZnxeWDjo+9Ft1QIHBQ86xLHC1SpllYfCfQXXCftA1
X-Gm-Gg: AYBFou017CebpO7HKcRwYpX9zKn2kSyqgh/8YoFxJZLZcVlkWkqHg5K5OtOVFBfVy6w
	Ex0KVBgBf6UBNfqMvo7TUwtEVA+ZRbfYZeYDVcQOq/r4Rs4hQV4AT5az54DOsdV5YkS9zMzulcn
	6cx1vLncuU5h62hZiS9VUnFogoFw9E8sGEo2Ed4uZAK0SC04ElegaJ2FRDTa11//LOsOBWjaY0a
	lMBZF0vtcNjeTbxmeX+pv7JEVEy+fn59tUtA7a2ZBOWTtRGlYIszPI+ImBYlT1KWMXgz+fD3WaR
	rZEBXX/OYyvoTAlfv2EMxNeyP+cf9oTPlD3UMBnRfCqM6Tz0RTXsHl2HTcsznd3Lcr41593Io6R
	fCyoJRumcjAc/aKbjSiehtTzmVsu5kSWLi9PJUX8986GD+jD3byc7eY0ENIGdLAOkmoJX8K9vqw
	QhZibwMiJbpC53Q+8n7iwpJp0BCOV7/yGSbv3O6Z1rGPptiSXwIrvRegPlkg==
X-Received: by 2002:a17:90b:5887:b0:3a0:c276:1ec2 with SMTP id 98e67ed59e1d1-3a8a0a90ac8mr3703287a91.19.1791470944853;
        Thu, 08 Oct 2026 07:49:04 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45b:16d2::246:b6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab16a4db33sm660176a91.1.2026.10.08.07.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:49:04 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: driver-core@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+863936f50214e843ae0c@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v2] driver core: bind a device with a preset driver even without autoprobe
Date: Thu,  8 Oct 2026 21:48:59 +0700
Message-ID: <20261008144859.25548-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008003431.145352-1-ngocthang2710.1999@gmail.com>
References: <20261008003431.145352-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb_driver_claim_interface() may claim an interface that is not yet
registered, in which case it only sets dev->driver and relies on the
later device_add() to bind it via __device_attach().  With the bus
drivers_autoprobe disabled, device_initial_probe() skips the attach, so
the device is registered with dev->driver set but never added to the
driver's klist.

Releasing such a device (from usb_driver_release_interface() or from
sysfs unbind) makes __device_release_driver() call klist_remove() on an
unattached node and dereference a NULL klist:

  KASAN: null-ptr-deref in range [0x58-0x5f]
  RIP: klist_put+0x4d/0x1d0
   klist_remove+0x14c/0x2e0
   device_release_driver_internal+0x4fb/0x620
   usb_driver_release_interface+0x10e/0x190
   cdc_ncm_unbind+0x2ac/0x350
   usbnet_disconnect+0x1e2/0x300
   usb_unbind_interface+0x1dd/0x9e0

Autoprobe only governs matching drivers to devices; a device that
already has a driver needs no matching, just the bind that was promised
at claim time.  Do not skip that bind.

Reported-by: syzbot+863936f50214e843ae0c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=863936f50214e843ae0c
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
v2: Sashiko pointed out that v1 only closed one entry point: a sysfs
unbind of the claimed-but-unbound data interface would still reach
klist_remove() on an unattached node.  Fix the state itself instead:
bind the device when a driver was preset, as claim promised.  v1 was
"USB: core: don't release an unbound claimed interface via the driver
core" (device_is_bound() in usb_driver_release_interface()), dropped.

Tested with the syzbot C reproducer in QEMU (KASAN, dummy_hcd).  The
race that leaves the interface unbound is rare, so to make it
deterministic I temporarily made device_initial_probe() behave as if
autoprobe were off whenever dev->driver is set: the unpatched logic
oopses 3/3, with this patch 0/4.  The plain patched kernel, without
the hack, shows no oops either.

 drivers/base/dd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f6525a7ee8c5..137bf1dea333 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1149,7 +1149,8 @@ void device_initial_probe(struct device *dev)
 	if (!sp)
 		return;
 
-	if (sp->drivers_autoprobe)
+	/* a device with a preset driver must still be bound */
+	if (sp->drivers_autoprobe || dev->driver)
 		__device_attach(dev, true);
 
 	subsys_put(sp);
-- 
2.43.0

