Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE9B3B3899
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 06:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638238; cv=none; b=JzQeO4ZwDZafHAklrf3RQ88bAirmHcbbUy0CdIexmUzph6jfHm+Rzi6ZiWxe2MZq3GhPoWFRtqCGR52uXGaxrB+AgsgQRU4r1cbClMB5uuxYkw69K9PPq8CzLOIpj0+D/BsiKUR3TpmYHNHjxsmKMnPL6RoL/V6Dma8rCeITom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638238; c=relaxed/simple;
	bh=u3K+pqwlQxfkUG5TAz57N41CJMhsQtXMuS2/ucfBYcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eS0AobqVzLY8mTHtQNwj8R2BZsm6Es/B++eopw/mzQX3QwFpzc/nZusEL5/UdSn4rhVtQKmOdOdk5XhP+dtPKZa43i9vEhCOx8XPjjRp1AUijqPszBomGAhNosGb/b+1pN0i1seTmCNidUKlZTxJiV3Xyq7dkew3VsycdsnreCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aup/bh8X; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aup/bh8X"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d5335cf904so33797285ad.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787638236; x=1788243036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ND0GiXjyOiahUAdjcPXqRI8sK+8IdeZXOpNWsXBTPXI=;
        b=Aup/bh8XpSUl4f1JT4G4KXRHwna+vUgxKcbIQ7/ty0SkVH/YuarvS/QcjmqPLSE0XB
         8EDQWHQ7qEAuS7iISk1zWfT71/32bPGL7o0zJy05QoghjVb4IzZnRGCWv1AQ76INe9Dv
         BoILzsmOh8L/97Gq5PsilW5aumqhjkuO+Phhu+XAakyFYky11a3p/8Z5c57+6OiT973S
         haqMowk/Bwd027n/2xy451PZ8LALU1P5zPakr4OWIRGmWX2HpMNrPt2AZqpog5VMMVeN
         kOt2qNVGBn8ej8h2pHJp4TNIKxyUT3MHiqv4wGG0kSbwLE38K8fjW7kz7pfTuyAz7oEg
         4T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787638236; x=1788243036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ND0GiXjyOiahUAdjcPXqRI8sK+8IdeZXOpNWsXBTPXI=;
        b=a+lcgwQevcQ7pCc/l1Z571z9YoIuMXqNf5gcBwQKrgE2xJN0ZPOga0ZZ7RyQkW/VTn
         VSn6Hp+KK8e/DC0KecJgeL+x/MSj2cLc1uMYQzQ5PoHrsHo+i9sdq+SV/rD9n8g2Me02
         Z+E8hlleG6xb9Bpu0QNisq021z6bF1oUdxRB1Q3BqaNIQ4kw2ZFUNt1wBlk0Y0+MmNBU
         D+UF15wi5Kb1PWLbrP6OpFVpa9ScodqHkmEPPedqO9m8uKlT6saNtmPGiycJNIdAtPxo
         +TjJQW2qS8xitejdMqq922dV18qpkdRJeuBTqj9MXmiYCfld98ujwKtWmoTY67LW3Lhk
         94vw==
X-Forwarded-Encrypted: i=1; AHgh+RopUjcCIBRpJC0AP5Nj6Lbvm6uoDxrl4keTMVUaGiiTStrSMwi7zRMN6qjqmrjdEEQcUB61F7o=@vger.kernel.org
X-Gm-Message-State: AFuF++lQJxpacuVUGEQuM/zxrAsdn/6KULF9u08RQrsoukgX19rwP9zd
	lf9sb60wTCR2IxjBhfjRRm7RJSsmNh6WaTSM/wr0FCBg4tNeGhNat5BPyzCCNIAa4eo=
X-Gm-Gg: AR+sD12pz/SRGX7EnK8nD9ZlKdxyHeFcBf8K1cu4gRceHMWDCnphtpplufNCrUJxP0G
	z605JK2IPHxxpo53kvN/XcTnHIbn/F1/m2HC5xA4gfyKaY0eW3q8HaJlKHhvFJDYiX7veyZpwJy
	lzam3Z6BZ4aVK4Po6tl65tef2FXeMW5N8fD865+42Iz7VBOVXKtEUFvmM0BOmWjrJslZv9InGTj
	ywIYP3s2c5QC1KP2n2Mw87p/3E1jC56RrzOkcSU+uXI+HdKt85r7Yf9Z95cBpGk5BKmnxhU5wem
	foUBMDuIkH7qX1qCiJQOkN+oMhHO1Xk2E2A7v5zAVZwDl1p6IlKwTmoylUtK6qOjE+sWwtHhif7
	27bpRi3EQBuWS+mwzkuA8tD8rehI6bPDoYpwMyxqFm2GyvePoogeYZ/faRwC/X9bQCgeboks64t
	Z0gcSKLi8ve86vu/ua9tZkSvlWpkNIjgmddHcelDwZE31IfqTDTtGJwEqhfRiQ1qnYhixOg/Aax
	Fzl1vTDXt+UqiYynLsymUeDKDncMKDC/FAb/kEcEaIVMj2FwY8O2mfS1YM2GspnBC1ncAYs6Os5
	qxfSvhabKKE9Yq9ufjAHq5iw
X-Received: by 2002:a17:902:fc4f:b0:2d5:e9d5:8ae with SMTP id d9443c01a7336-2d64adf7719mr543533055ad.5.1787638235784;
        Mon, 24 Aug 2026 23:10:35 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676408147sm23954825ad.0.2026.08.24.23.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 23:10:34 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wei Jie Law <98lawweijie@gmail.com>,
	Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
Date: Tue, 25 Aug 2026 14:10:26 +0800
Message-ID: <20260825061027.105062-2-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825061027.105062-1-98lawweijie@gmail.com>
References: <20260825061027.105062-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

rmi_read_pdt_entry() takes the interrupt source count straight out of the
Page Description Table entry the device supplies:

	entry->interrupt_source_count = buf[4] & RMI_PDT_INT_SOURCE_COUNT_MASK;

RMI_PDT_INT_SOURCE_COUNT_MASK is 0x07, so the value can be 7, and
rmi_create_function() copies it verbatim into fn->num_of_irqs.  But
struct rmi_function declares

	int irq[RMI_FN_MAX_IRQS];

with RMI_FN_MAX_IRQS == 6, and both rmi_create_function_irq() and
rmi_unregister_function() index that array up to fn->num_of_irqs.  A
device declaring 7 interrupt sources for a function that has a handler --
F01 always does -- makes the driver write irq[6], which is the storage of
the following member, unsigned int irq_pos.  The function's position in
the interrupt bitmap then holds a Linux virq number, and that value feeds
set_bit(fn->irq_pos, ...) in rmi_f11_probe()/rmi_f12_probe() and the
irq_dispose_mapping() loop on teardown.

UBSAN reports every store in the loop body and the read on the unregister
path:

  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:183:10
  index 6 is out of range for type 'int [6]'
  Workqueue: events uhid_device_add_worker
   dump_stack_lvl+0x64/0x80
   __ubsan_handle_out_of_bounds+0xc8/0x100
   rmi_function_probe+0x1c1/0x210 [rmi_core]
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:186:28
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:187:35
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:189:32
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:191:54
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:282:30

Size the array to match the three bit field that feeds it.  Clamping
num_of_irqs instead would silently drop an interrupt source a device is
allowed to declare, and would desynchronise irq_pos for every function
created after it.

Reproduced with an emulated RMI4 device that publishes a single F01 PDT
entry with interrupt_source_count = 7, driven over /dev/uhid and again
over dummy_hcd plus raw-gadget, on v6.12.69 and v6.12.105 with
CONFIG_UBSAN_BOUNDS=y.  No reports after this change, and the same device
now probes normally.

Fixes: 24d28e4f1271 ("Input: synaptics-rmi4 - convert irq distribution to irq_domain")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
 drivers/input/rmi4/rmi_bus.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 90122df21f74..faf2ebb00d52 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -12,10 +12,13 @@
 struct rmi_device;
 
 /*
- * The interrupt source count in the function descriptor can represent up to
- * 6 interrupt sources in the normal manner.
+ * The interrupt source count in the function descriptor is a three bit field
+ * (RMI_PDT_INT_SOURCE_COUNT_MASK), so a device can legitimately declare up to
+ * 7 interrupt sources for a single function.  irq[] must be able to hold all
+ * of them: rmi_create_function_irq() and rmi_unregister_function() both walk
+ * it up to fn->num_of_irqs.
  */
-#define RMI_FN_MAX_IRQS	6
+#define RMI_FN_MAX_IRQS	7
 
 /**
  * struct rmi_function - represents the implementation of an RMI4
-- 
2.43.0

