Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586573;
	b=Szau1kSXZKLHYxsA4l5wGC6XHOknA7Vw7HIFcbumJfZhioFZtNhOdyQo9nIwtq4Gz2HP
	 Q0dI0apOp6jbMEgmGZJ9t6/i+SxXWArhR2Ws2kKpxWApqXFQnCh2d9iWSSN89gVKJie8Q
	 ZtgDUto5lohp0v0eskqbLhscjM6OtR0Pm3yW/QiUu2bkU9VMKH0MAXSr/+CVvWRMYp1U/
	 3/BUOGFwfhd5fmAtwE6HqSm8Np79ZxCXwUeGUyEcvJf0mzlXbAiqH+o2DqGohofrloo3w
	 uUawl2ALV6h5S95I0epO8N2UgUsxtrN7p313Pyxy1PCUSZBYAxyC7z5MkfDjwd9mx6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oraj5/DBEjTdYiHJqe6PkDC0IxB+a0MZ66ytJCd3wwk=;
	b=dwf7cndYJWwOBJGcSutp8pjq0bUj/rV9slbBd3rlugpDVf54nYqway6O5DdNuRTdF4R1
	 JTOmVqyrJ1Wyv2XUiRy/Gp+ydFfYG+JRUoilxHkLqCOYf9MDzA0etCk7AjT4UzWAvC84Y
	 t7jWR78ml7oAW35nTDgw+qhl5eIBOL2Dy6GYOQdQdIsZGniMr8Qxqr1v6IxYgTExSD7X6
	 Mu2LoLYuRkga1ua1kAi7bT8iOV51PNTD9IR5w0R21OjBjEPbIwmw7c7rN85YW9M5c1t/u
	 bG+oKgWzffj2a8+wsCz9DO+qYyVtn5Y97R9UT0Sutx8NpzF8MEzbp+p0p9A01Opn0Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQ8lJ33v;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38219606A334
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 02:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38219606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQ8lJ33v
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso763971b3a.2
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 18:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793586572; x=1794191372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oraj5/DBEjTdYiHJqe6PkDC0IxB+a0MZ66ytJCd3wwk=;
        b=EQ8lJ33v7UtNQ/YwA2kxe3xxDCiwk80K412vJUCrTthmQsBrqkZSzWKZ9oKB2s7R9V
         teVYNZXd4NoqJpVQduLK70fSd3jCQUNBtNx0kNSUBPYyxzc9UbykHjjObkXy6QhnW9Aa
         FtzblfKdGoL4GIi71DsGkWXz0IUY5fC/SWrNCJm8CbI36SMWxaY0z1JOk1N2J6qEw36L
         Pp2Q0mzA7I43JL7lRiKpuMo2fFbjI4EHIj4WvhYUG7zfBO81vTkABTimOh4DUdfIIxMr
         8RiLDBoGePM/JR70Z/ywBjHMgBGGOeSxHw+pnERNhtFqIFmFbqX2m8HsucVbN0xoy/Py
         MhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793586572; x=1794191372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oraj5/DBEjTdYiHJqe6PkDC0IxB+a0MZ66ytJCd3wwk=;
        b=EsjphNQ28WlcUdBYh3V8goBXs2BOrRMSUmKZRwopWpVvlv+nieAhfxM950nQfoXmzH
         yU38FTJ/779m0uF7TntO2CEYlyTfcjuHTm8bnMJVAJ+sDsPsr62HfT3gJLMCUy3N4pmq
         PAQeH1rH4dVfUr3wJ5wYdsPbU3X/uSfdnYlkj17NpLFXZm/xH95XiHJW34+8GsaCQ08D
         mR0iCmVk/NdvTRC9SK7/eotfeDxIcIpdeZw3S3HTBWTEf9I/MaUGC5q18hK3U6VaiVlp
         hcQK8AEoCv9skv+y5kHG2vm0OcEy9QZUwU6oB/7A56Bm7kIZckliGQ4/k8/bUH0aPnMg
         yEjw==
X-Forwarded-Encrypted: i=1; AKwUvBxnz+o3Ms0SgCnV9zVK7zbRzWgtjSFx5UGJqqTJMZziz0xmPqpFxw+dXcpOHhV9GootyG7wPnY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnQ0+4yuQ4PFwqBLEVpA7Iu5NIYkVRaZ4umgV+9/M7Pkhzm8Tr
	l9O+P7EUEMlOI7vMtxxcVBjYB6BVwUrKsW7HsUI+2BTbcKpvd16sHCIw
X-Gm-Gg: AYBFou27ax09NKga7MH2+IzwrmuefLbD6hMDcUG8GcxbvFJRs7jIrSBDegcYlUu4VZv
	q/+/y36H2VUziMO4bCJARuUOKaUdstKLJ/KATZS0DgfyLi1e3aWtcrcqsexPHEdqits05rWrFbT
	DbUC8OQYR7Y5s89Nzxg2rdLcgAcTK69Mp+mkCi2K/UYpMs3X120MRVBZ+dgTAcvYCsIUejSbRr8
	rYUIZe2jwWhb8ZmTTE6KYiHaQk45jZTFwkwTvmhdyNWIpQYA5Zll+YKQD6aMPYkFkDrpB7CkcsQ
	60FCZ3Q+hdowMWjJ1S/ZPV8plnTHIyMoOa7yQqDDqHu4QtymMEBj32ms12KTdJyBWgQdor4wX8k
	hsfnWc+xdEeoauYiZgP1f5AlJ8kNecxPz5H5Dig9favddd8kopXPOXNbAQ29YDqlQmApGeSIuyY
	XI6ruwdhvYrmYjF/OWlS/D0BtDRs0kZfjFyXMGYJo+EC5zQwFkZQhL5quqNBcyP03kgNikkPu+b
	YpFsDlYiwDv9nEcdJniFrE+4OTdATxECwC83kacMY3wH84iCzlYxMXyVxOjlo2KdG0sPJeep2Xq
	f51hbML91q3ik/+RhPKw6YZtubH6KyEC0G/8Njst0KgDbpeThGD653wVGrZuHJbHdmqV
X-Received: by 2002:a05:6a21:7988:b0:3dd:85aa:452a with SMTP id adf61e73a8af0-3e928dc794cmr5954941637.37.1793586572482;
        Sun, 01 Nov 2026 18:29:32 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09814cb9sm2441382a12.24.2026.11.01.18.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:29:31 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	BeaCox <0xbeac@gmail.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH v2 1/2] mmc: dw_mmc: drain bh_work on host removal
Date: Mon,  2 Nov 2026 10:29:23 +0800
Message-ID: <20261102022924.51343-2-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102022924.51343-1-0xbeac@gmail.com>
References: <20261101063719.88570-1-0xbeac@gmail.com>
 <20261102022924.51343-1-0xbeac@gmail.com>
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

dw_mci_remove() does not drain bh_work before the driver core releases
the devm-managed host.  The interrupt handler, the fault-injection timer
and the DMA completion path can queue that work, and its callback
accesses the host and MMC request state.  A work item that is still
pending or running after remove returns dereferences freed memory.

This is not a regression from the tasklet-to-BH-workqueue conversion.
The tasklet that bh_work replaced was never killed in dw_mci_remove()
either, going back to the original driver.  Commit 921c87ba3893
("mmc: Convert from tasklet to BH workqueue") only replaced
tasklet_schedule() with queue_work().

After removing the MMC host and masking controller interrupts, drain
the interrupt handler and disable the work synchronously.  Disabling
the work also rejects later queue attempts, unlike cancellation alone.
Stop the fault-injection timer after the work callback has finished so
that it cannot rearm the timer after teardown has cancelled it.

Fixes: f95f3850f7a9 ("mmc: dw_mmc: Add Synopsys DesignWare mmc host driver")
Cc: stable@vger.kernel.org # 6.11+
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
 drivers/mmc/host/dw_mmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ff0b25d..5b47643 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3406,6 +3406,11 @@ void dw_mci_remove(struct dw_mci *host)
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
 
+	synchronize_irq(host->irq);
+	/* Stop the work before the timer that it can rearm. */
+	disable_work_sync(&host->bh_work);
+	dw_mci_stop_fault_timer(host);
+
 	/* disable clock to CIU */
 	mci_writel(host, CLKENA, 0);
 	mci_writel(host, CLKSRC, 0);
-- 
2.43.0

