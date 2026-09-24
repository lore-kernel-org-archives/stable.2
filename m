Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48E9388379
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229916; cv=none; b=StaeGy/42rv4178UICxtRr3X+V5UN3gMZhBiewxJHgbFN1ZyfWpWgDRSUg8hKOln1QvZOEc4OfNkjJEMnfqEI4WgaxjqiWEHVaYfEMdPkazUUtAVUUNr8YHX0Bp9WSsah5yPkw6deGlZgxcR9BgxUPnVatr/wlTRb+UU94qVUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229916; c=relaxed/simple;
	bh=YNsGz40uB3rQxxoQAz6jYyo5Ac4k6Kj/guxINFRcYZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IweOgJss5MTTvtbEQLojeCDaVHTU7xO3miuWq7jc84nufE2Xy+gGtuTA61zFMprARpRfWGgV9DyY0r1u55xWbjqC28B43mnkR+XZDSPvNfYUjzo30okjUwqFaA6OzRaMDaBU9Fp0UEI1anng3XsUITo+ZArV0jA7kXsqKDWTHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fknZPUYq; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fknZPUYq"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8692a856865so762617b3a.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 23:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790229914; x=1790834714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZtLuNBtR7lmflm5rOBXtrqceyU4LeVfNJGPJ3jSN4+s=;
        b=fknZPUYq4tyJkqngPbV6ZorvQ3e6dtH5WOvkJSqAEjaOZ9pPG1eurniw1sb3F+sg4h
         RuVz8e3G7sf6VDEXaAUoVGKG7oiD6sLpXBZIDJvqZwJovaNdNh3SsqyCqRLBVgjPHC9V
         qp4y1o5GJqA5sJG8YgkaosGaijcPt7FyxIecJCKICs253JZEuBVtpVszsb/Gnbj8sSxk
         jLO2UfJahUtfRmTidw0UGW4e1QZAHz50JUoM9aOlo6sZ5UdHWcumZstJY+ZDgpdegFSH
         16cMtntz5VKMd7MwvhLMYY7QAQVR3fvJ/A60SzvPX53V3sLDEwDab8JWjkhhwsvA9UCI
         kltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790229914; x=1790834714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZtLuNBtR7lmflm5rOBXtrqceyU4LeVfNJGPJ3jSN4+s=;
        b=s0rfEpOreYzpNtakGc36UIhJwst0aIlfbHFuwqicg2mOCl1r4r93JVNpXz15qngcgO
         7HLDE04y4RRuq9nBxbhrbjVGBj2J1B4UhafHNot1nhWOkW5CbV+3tg1PCSZ+kMobEIPZ
         jqdnmOnb/nN4RVtqIwztTwVoopkCNFVles6yh1a1eoKSHKSWtYEt/sGPsjR5roKtSpUy
         Ho19niF6w8fUCFuYyHUVIdaAP/W3g3dCYO5VHClqt0zRxndnxD0HcgDcr5UDDHQpbBH9
         WmqNavp4ibSyGahdIhhWvcDAR9cjegSlQWiWGTN8iZr+jQum0D97jVynARmB6HoAF8iA
         27mw==
X-Forwarded-Encrypted: i=1; AKwUvBxlxE861qZbzhCE4ooOyyqmqq6qMBLWL55GA1jjmOqbRkclpOEnoV8IuQaOM6/l9SStqqx3mx0=@vger.kernel.org
X-Gm-Message-State: AFuF++kHOFodRxKuQjG5P6TDw+hmZSoZCwjpImYx2eHA/IECG83oZSCR
	yXcQ2QfnTJ4xK92tUmpW6ntumy4DNYlkVxQrfIhauV3L6HKtoeve6PB4
X-Gm-Gg: AYBFou1nVUhxNyu/SPFyiMWQe+dS01y1SBjw+7p+cHuj2lxvE/tsqoEndMMlV2lRqBT
	MYujVvht433Vnw2+aHrDnEU0gGFPSj0OoJCV44kOXP8i4wyvWFh/cnaSzAqOK4wMHye5RSIRPlX
	DS1wscMZwrswwUfpe6zdmfmGQZmG36XDUBHgFqR+ddEIJ8m/DUcahIkGPp5U/pdYahutJoM6BHO
	Rd/78RwkedP0KimVD+0+S8Qh5EndGwwKwlxe2E5RNH3nYzfxjUkRngpA1+F/s5nkHYYeKcRD5yV
	YMyaks97SyWgVbtKu9k/ZLHwNPE+A1Vtk+1itTu8f6Vinxsz3aTrf3QN9Ampa5EUzZTwf2M21l2
	wTG5k1lbsJaCjidmAwaQ4LzTTQ0/yLmqt3eaiVE5WyABv9aJqhKmTXPfd3kbmXB4rwUo1vjeFPx
	bSloHilETxiRBkdO5ChalStPzIo3+xow/rx4EiUG2Z6SYMVTaaBZLMYdk5NfqFCUz9/wF906OA6
	MP2OOIiPWz0shi5RpKma5OoxkEtyiZ3B4oWV9jM4Ov6vlc9b4RSgNBR2dEZGvTo/ue8gjb+dFp+
	z1UeLKUYhA==
X-Received: by 2002:a05:6a21:1343:b0:3dd:a197:cf28 with SMTP id adf61e73a8af0-3de0e91d392mr1498468637.76.1790229913967;
        Wed, 23 Sep 2026 23:05:13 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f2228a2sm2056710a12.4.2026.09.23.23.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:05:13 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4 1/3] serial: 8250: hold hash_mutex across IRQ chain linking in serial_link_irq_chain()
Date: Thu, 24 Sep 2026 06:04:44 +0000
Message-ID: <20260924060511.2364717-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924060511.2364717-1-benquike@gmail.com>
References: <20260924060511.2364717-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In serial_link_irq_chain(), serial_get_or_create_irq_info() acquires and
releases hash_mutex before returning struct irq_info *i to the caller.
Before serial_link_irq_chain() links the port into i->head, a concurrent
serial_unlink_irq_chain() on the same shared IRQ line can observe a
single-port i->head under hash_mutex, remove i from irq_lists, and
kfree(i), causing a use-after-free when serial_link_irq_chain() accesses
i->lock and i->head. In addition, if request_irq() fails at the end of
serial_link_irq_chain(), serial_do_unlink(i, up) calls hlist_del(&i->node)
and kfree(i) without holding hash_mutex.

Move guard(mutex)(&hash_mutex) from serial_get_or_create_irq_info() to its
sole caller serial_link_irq_chain() so that hash_mutex is held across the
lookup/allocation of struct irq_info, the insertion into i->head, and any
error-path serial_do_unlink() cleanup.

Tested in QEMU against Linux 7.3.0-rc3 by configuring /dev/ttyS1 and
/dev/ttyS2 to share IRQ 3 with ASYNC_SHARE_IRQ via TIOCSSERIAL and
concurrently opening and closing both ports from two threads in a tight
loop with KASAN enabled, verifying 0 KASAN faults or warnings.

Fixes: 25db8ad5c567 ("serial, 8250: remove NR_IRQ usage")
Fixes: 99fc860fae83 ("serial: 8250: extract serial_get_or_create_irq_info()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v4:
- No changes.

Changes in v3:
- No changes.

Changes in v2:
- Split the 8250_core.c and serial_core.c fixes into a 3-patch series,
  add Cc: stable@vger.kernel.org, and document how the patch was tested,
  as requested by Greg Kroah-Hartman.

 drivers/tty/serial/8250/8250_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index b875d394796f..0bc810f285a4 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -134,8 +134,6 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
-
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
 			return i;
@@ -156,6 +154,8 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 	struct irq_info *i;
 	int ret;
 
+	guard(mutex)(&hash_mutex);
+
 	i = serial_get_or_create_irq_info(up);
 	if (IS_ERR(i))
 		return PTR_ERR(i);
