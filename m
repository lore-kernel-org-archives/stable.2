Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CB409265
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665863; cv=none; b=QAwihB9axWZdBy7L+KmY3W+BnkcjOodvqQAuERwroAqkLUtOzptNszaZFO50AsEhQH5sk7GFSC7CkSNgeTnP2svCH6Ap1PMD9srlb0fFxDrci57jwBmvVPVfHyMP312sjhmKH6/gQOEcEfTuZKpg79AqgMODx7SsIJH0gFW4syM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665863; c=relaxed/simple;
	bh=c4etVXU9KVvWXnZ2tOh1OmoBS1yBXEWVCGk5dP2gXjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBIG6zM1aHqt9/qxotBRFTFu6g8RTRmQtsSmgNwZTSBPk5EwmupX85rHfBo8XJwnWU4/JSn3A0ZfHhNeVnA8EfclddZ+KYk19vWMSTmYpxbbUIlPevi7HwCy5w+EMF2JdHyQaxSDUhBYaAlZZjgPqX/oS58cH4C1kzmk+/JS5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manus.ai; spf=pass smtp.mailfrom=manus.ai; dkim=pass (2048-bit key) header.d=manus-ai.20251104.gappssmtp.com header.i=@manus-ai.20251104.gappssmtp.com header.b=gIMWhHwN; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manus.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manus-ai.20251104.gappssmtp.com header.i=@manus-ai.20251104.gappssmtp.com header.b="gIMWhHwN"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb4d532e65so2655212a34.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manus-ai.20251104.gappssmtp.com; s=20251104; t=1787665860; x=1788270660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xSIgAOeBEvTO06U9QeOYGma3JENSo1h5usyjFLprsbk=;
        b=gIMWhHwNWJ/AuUaXrajUQL2t5BvnuSXirPrYEDoZD6W8kHe77jaFFgQ9Cyc683ifBZ
         kWoik416j/kZdAUw68vioYntMLChTJeri4Yqg1AC4Rj9PMYCiNvnJnxuFSqjYs9QyQYa
         cudqs2eNOW70iPT42RHOQ8f226l9fxC2n4J16Bpd1Qlp2S7cs9g0SAlPINAeQ6KL7DIq
         yocEdvfW+AgQHsEQkoF93BZ5XL58gLUWW1ScMFzm7XFqKrh6n/njYzXF7hrwC3BwvFsU
         r7DbY6qHt0E4IYzM73GBWmxSDrXo+9xM6DBFhwho9GX8OmgkKu9irF3s1/S8cFeTkIww
         hoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787665860; x=1788270660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xSIgAOeBEvTO06U9QeOYGma3JENSo1h5usyjFLprsbk=;
        b=fOC388f7kmD1EcXhyzyOChUxfRlv49mldvd8fPPFqnRdqNIn2EQAxbtNjNTnbYUw1p
         r2QBGnVD3EQhVAchjiOKJQr6Y3TqwK4ecL5OW8l6ZuSySxgqxK8LFOQmlYe62fneFFR1
         QST4+bS0hLNzjK47NTKFeAWihQwOGE5XN8SWyBkQjZ2zAN+fDBJM0pwulYhC+NCtCyDx
         ocjBrlWPyH4bDTkN4+4QuBEA9EcS9WwfEpZL2klkO4l3zV/6ftvltEGkDV36xpXKR714
         nMhpOyqIbgGl0SZD7MUUIGvhpu6/1+kHj/veIDDZGGx9B47rdhPqOTtnTTunMAAnA+ks
         s8kA==
X-Forwarded-Encrypted: i=1; AHgh+RpZSsClkfydTFonR9jYCZWXTCwxkwJTaKahdGcB4kIU3PBI/l+XqbLiNY0gJDXoZyLgnFr7bdE=@vger.kernel.org
X-Gm-Message-State: AFuF++l2nm+Kv2jyMaYah151RU8jRjw7pWaB2v2ByNsqR/3T+eazYdVO
	TPSYUmz9pOXLDWcNvS6xyWb/Yr4Qzze66glm2jORH4heauRMXQ7Ai5iyaSuB7sBrwe8=
X-Gm-Gg: AR+sD12a9VJxsgLaDIn56VTgsLOvR68pEeYky57BeaZjiLRddHt43GUgd1RYBZfRbIZ
	74e5uMm28vYrSkZrXAZnMNtIgz5z82NubYSi+Cx9FzoD28vy+4PYX3AbGrOnJPW+v9WSFFHLszY
	PgFJ5m3lgoRyBe2/tlo/GS9vdZXwL67Me0FMBWQbIgc1VFvH30j+vNzqE5+wnx5HO3xA3DCFeYe
	/9zrileHDJhLT5ooU6/jw/lFzWkxvH5bMe8vfT/S54s5x11ihvIj+7v/Y3KVVz5UGoFW4rNpCl7
	ugXF+l/KFqbFzoPFTRFyqtgX29U68n0HqJbB6JqdS8DJvbUk8Wnkd+jsoycySMGgQEM/BNAOo9i
	QYcsYivfQhy6tRYX6Act4kk6o1iEZ5PRRT03/uP745d+MtecK+cE/SZ6/ohWPCC6wjWF/YLEosD
	9sebieE9bEFoUVp192mKxUxN7lKVt7Gk4Z8IjPj51jdX0sMLqkg6pJrm+4TwrND4SqE7urzvZZ/
	Q==
X-Received: by 2002:a05:6820:60b:b0:6b1:430f:1bd3 with SMTP id 006d021491bc7-6b16b1bef04mr22789789eaf.7.1787665860541;
        Tue, 25 Aug 2026 06:51:00 -0700 (PDT)
Received: from localhost.localdomain ([104.30.178.117])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b17cc2c70dsm6285813eaf.13.2026.08.25.06.50.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 06:51:00 -0700 (PDT)
From: Zhichen Wang <wangzhichen@manus.ai>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org,
	Zhichen Wang <wangzhichen@manus.ai>,
	stable@vger.kernel.org
Subject: [PATCH] virt: vmgenid: set driver_data before registering notification handlers
Date: Tue, 25 Aug 2026 21:50:54 +0800
Message-ID: <20260825135054.54883-1-wangzhichen@manus.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both probe paths register their notification handler before assigning
driver_data, which the handler dereferences.

In the devicetree path, the notification IRQ can fire as soon as
devm_request_irq() registers the handler: the interrupt may already be
pending at probe time, for example when a VMM injects the
generation-changed notification while restoring a guest from a snapshot
that was taken before the driver had probed (Firecracker does exactly
this on snapshot restore). The IRQ is also requested with IRQF_SHARED,
so another device sharing the line can trigger the handler just as
early. The handler then calls vmgenid_notify(), which dereferences the
still-NULL driver_data and panics:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.38+ #1 PREEMPT(none)
  Hardware name: linux,dummy-virt (DT)
  pc : vmgenid_notify.isra.0+0x24/0x8c
  lr : vmgenid_of_irq_handler+0x14/0x34
  Call trace:
   vmgenid_notify.isra.0+0x24/0x8c (P)
   vmgenid_of_irq_handler+0x14/0x34
   __handle_irq_event_percpu+0x44/0x1bc
   handle_irq_event+0x4c/0xb4
   handle_fasteoi_irq+0xf8/0x1f8

The ACPI path has the same ordering problem: the handler is installed
with acpi_install_notify_handler() before driver_data is assigned.
ACPI notifications are dispatched asynchronously from a workqueue, so
the window is narrow, but a notification arriving between the two calls
hits the same NULL dereference.

Assign driver_data before registering the handlers. The state is fully
initialized at that point, so the handlers are safe to run. Should
registration fail, the probe error path leaves no dangling pointer
behind: the driver core clears driver_data in device_unbind_cleanup().

Fixes: 7b1bcd6b50a6 ("virt: vmgenid: add support for devicetree bindings")
Fixes: e07606713a90 ("virt: vmgenid: change implementation to use a platform driver")
Cc: stable@vger.kernel.org
Signed-off-by: Zhichen Wang <wangzhichen@manus.ai>
---
Verified on Firecracker v1.14 (aarch64, devicetree) with a snapshot
taken before the vmgenid driver had probed, so the injected
notification IRQ is pending when the restored guest reaches probe:
the unpatched kernel panics with the trace above, while the patched
kernel handles the pending IRQ as soon as devm_request_irq()
registers the handler (/proc/interrupts shows the vmgenid IRQ count
at 1) and boot completes normally. The ACPI path change is
compile-tested; the window there is analogous but much harder to hit.

 drivers/virt/vmgenid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index 66135eac3..92d9779c9 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -82,6 +82,8 @@ static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
 	}
 	setup_vmgenid_state(state, virt_addr);
 
+	dev->driver_data = state;
+
 	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
 					     vmgenid_acpi_handler, dev);
 	if (ACPI_FAILURE(status)) {
@@ -89,7 +91,6 @@ static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
 		goto out;
 	}
 
-	dev->driver_data = state;
 out:
 	ACPI_FREE(parsed.pointer);
 	return ret;
@@ -123,12 +124,13 @@ static int vmgenid_add_of(struct platform_device *pdev,
 	if (ret < 0)
 		return ret;
 
+	pdev->dev.driver_data = state;
+
 	ret = devm_request_irq(&pdev->dev, ret, vmgenid_of_irq_handler,
 			       IRQF_SHARED, "vmgenid", &pdev->dev);
 	if (ret < 0)
 		return ret;
 
-	pdev->dev.driver_data = state;
 	return 0;
 }
 

base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
-- 
2.47.3

