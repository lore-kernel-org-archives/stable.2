Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3D3C07A
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 01:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635361; cv=none; b=UlM4eB472YkRXeXkppWAUDbILBtai410+jats2XKX5J2990qABQQhyAy+Py8irQYQ+iGeBaHmMoMEiDWwisuWTDOuhK2k1969CgMZeWRoaF/WbgCKWJRxPqJj0xzNGvjQ0kUn+bWz9vaFJ3pTg//T9fFiaczN6KYBt+M5LvAYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635361; c=relaxed/simple;
	bh=leHeqADwhrqZNCBr1gQzVdvHpiJaKGlONHAkC7E2IFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=micfBSG3y1vbY5+iKzLa9lnH8tkl+ZtgWECzBRseYn1hxjy3Y0e/EC+qPKB9VppMoxByAPpG3XqcU5XWHszrk39O2T/ZyWBJZRXTjAjH2Dze5rM/aX3cbGWt5cE3rHnE/zhZGcMS37Zl5ieQykNuiLJ2Ua61w/XfxB0nZq7nIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDNh7SZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDNh7SZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E081F00ACA;
	Sun,  2 Aug 2026 01:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785635360;
	bh=0wgttA3P2CiKhmwayCzmbgJ6HvgNV8FmlyPPhu91sRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IDNh7SZMQ2veqO5BHkKVGcxJwQUFFQjTVRwsKfr9QLkVpRl3sCi9NsLLKsuhcAJCs
	 iNATgtXdG1wwq0cgKuYSfIAEH5i3QX0q3cdnoW3pk4nSNuZZJGnY0krjG9PvkWbKTu
	 /LvE8DjHf9Bm9Q87LdFArYWIASD0xzeIbjtDbvlnNfzpThDqeAIG4ibnJfIyAKn4Bm
	 II4WT/mafDilLSTY5p6XJM/i8THyIt8eOiHk7tXSQUdGC4h6YZIXUbw6Ob7Tds1S2c
	 bLodnBTHU//tQHWbqPz0C2hawnkKJ0CGK7yOUILgyAZOGiWo/TH6odxnX/PndafayK
	 6QjJQj0/ssVIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] drm/xe: Stub out new pagefault layer
Date: Sat,  1 Aug 2026 21:49:13 -0400
Message-ID: <20260802014916.504747-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802014916.504747-1-sashal@kernel.org>
References: <2026072945-jaybird-vaguely-739f@gregkh>
 <20260802014916.504747-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit 620a09fb0bddf387f418663478b48ca4ba62b6d6 ]

Stub out the new page fault layer and add kernel documentation. This is
intended as a replacement for the GT page fault layer, enabling multiple
producers to hook into a shared page fault consumer interface.

v2:
 - Fix kernel doc typo (checkpatch)
 - Remove comment around GT (Stuart)
 - Add explaination around reclaim (Francois)
 - Add comment around u8 vs enum (Francois)
 - Include engine instance (Stuart)
v3:
 - Fix XE_PAGEFAULT_TYPE_ATOMIC_ACCESS_VIOLATION kernel doc (Stuart)

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Tested-by: Francois Dugast <francois.dugast@intel.com>
Link: https://patch.msgid.link/20251031165416.2871503-2-matthew.brost@intel.com
Stable-dep-of: 6384271ac1ac ("drm/xe/pt: Reset current_op in xe_pt_update_ops_init()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/Makefile             |   1 +
 drivers/gpu/drm/xe/xe_pagefault.c       |  65 +++++++++++
 drivers/gpu/drm/xe/xe_pagefault.h       |  19 ++++
 drivers/gpu/drm/xe/xe_pagefault_types.h | 136 ++++++++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_pagefault.c
 create mode 100644 drivers/gpu/drm/xe/xe_pagefault.h
 create mode 100644 drivers/gpu/drm/xe/xe_pagefault_types.h

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index ee52b751623f..c5fc8cc71149 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -94,6 +94,7 @@ xe-y += xe_bb.o \
 	xe_nvm.o \
 	xe_oa.o \
 	xe_observation.o \
+	xe_pagefault.o \
 	xe_pat.o \
 	xe_pci.o \
 	xe_pcode.o \
diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
new file mode 100644
index 000000000000..d509a80cb1f3
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2025 Intel Corporation
+ */
+
+#include "xe_pagefault.h"
+#include "xe_pagefault_types.h"
+
+/**
+ * DOC: Xe page faults
+ *
+ * Xe page faults are handled in two layers. The producer layer interacts with
+ * hardware or firmware to receive and parse faults into struct xe_pagefault,
+ * then forwards them to the consumer. The consumer layer services the faults
+ * (e.g., memory migration, page table updates) and acknowledges the result back
+ * to the producer, which then forwards the results to the hardware or firmware.
+ * The consumer uses a page fault queue sized to absorb all potential faults and
+ * a multi-threaded worker to process them. Multiple producers are supported,
+ * with a single shared consumer.
+ *
+ * xe_pagefault.c implements the consumer layer.
+ */
+
+/**
+ * xe_pagefault_init() - Page fault init
+ * @xe: xe device instance
+ *
+ * Initialize Xe page fault state. Must be done after reading fuses.
+ *
+ * Return: 0 on Success, errno on failure
+ */
+int xe_pagefault_init(struct xe_device *xe)
+{
+	/* TODO - implement */
+	return 0;
+}
+
+/**
+ * xe_pagefault_reset() - Page fault reset for a GT
+ * @xe: xe device instance
+ * @gt: GT being reset
+ *
+ * Reset the Xe page fault state for a GT; that is, squash any pending faults on
+ * the GT.
+ */
+void xe_pagefault_reset(struct xe_device *xe, struct xe_gt *gt)
+{
+	/* TODO - implement */
+}
+
+/**
+ * xe_pagefault_handler() - Page fault handler
+ * @xe: xe device instance
+ * @pf: Page fault
+ *
+ * Sink the page fault to a queue (i.e., a memory buffer) and queue a worker to
+ * service it. Safe to be called from IRQ or process context. Reclaim safe.
+ *
+ * Return: 0 on success, errno on failure
+ */
+int xe_pagefault_handler(struct xe_device *xe, struct xe_pagefault *pf)
+{
+	/* TODO - implement */
+	return 0;
+}
diff --git a/drivers/gpu/drm/xe/xe_pagefault.h b/drivers/gpu/drm/xe/xe_pagefault.h
new file mode 100644
index 000000000000..bd0cdf9ed37f
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_pagefault.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2025 Intel Corporation
+ */
+
+#ifndef _XE_PAGEFAULT_H_
+#define _XE_PAGEFAULT_H_
+
+struct xe_device;
+struct xe_gt;
+struct xe_pagefault;
+
+int xe_pagefault_init(struct xe_device *xe);
+
+void xe_pagefault_reset(struct xe_device *xe, struct xe_gt *gt);
+
+int xe_pagefault_handler(struct xe_device *xe, struct xe_pagefault *pf);
+
+#endif
diff --git a/drivers/gpu/drm/xe/xe_pagefault_types.h b/drivers/gpu/drm/xe/xe_pagefault_types.h
new file mode 100644
index 000000000000..d3b516407d60
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_pagefault_types.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2025 Intel Corporation
+ */
+
+#ifndef _XE_PAGEFAULT_TYPES_H_
+#define _XE_PAGEFAULT_TYPES_H_
+
+#include <linux/workqueue.h>
+
+struct xe_gt;
+struct xe_pagefault;
+
+/** enum xe_pagefault_access_type - Xe page fault access type */
+enum xe_pagefault_access_type {
+	/** @XE_PAGEFAULT_ACCESS_TYPE_READ: Read access type */
+	XE_PAGEFAULT_ACCESS_TYPE_READ	= 0,
+	/** @XE_PAGEFAULT_ACCESS_TYPE_WRITE: Write access type */
+	XE_PAGEFAULT_ACCESS_TYPE_WRITE	= 1,
+	/** @XE_PAGEFAULT_ACCESS_TYPE_ATOMIC: Atomic access type */
+	XE_PAGEFAULT_ACCESS_TYPE_ATOMIC	= 2,
+};
+
+/** enum xe_pagefault_type - Xe page fault type */
+enum xe_pagefault_type {
+	/** @XE_PAGEFAULT_TYPE_NOT_PRESENT: Not present */
+	XE_PAGEFAULT_TYPE_NOT_PRESENT			= 0,
+	/** @XE_PAGEFAULT_TYPE_WRITE_ACCESS_VIOLATION: Write access violation */
+	XE_PAGEFAULT_TYPE_WRITE_ACCESS_VIOLATION	= 1,
+	/** @XE_PAGEFAULT_TYPE_ATOMIC_ACCESS_VIOLATION: Atomic access violation */
+	XE_PAGEFAULT_TYPE_ATOMIC_ACCESS_VIOLATION	= 2,
+};
+
+/** struct xe_pagefault_ops - Xe pagefault ops (producer) */
+struct xe_pagefault_ops {
+	/**
+	 * @ack_fault: Ack fault
+	 * @pf: Page fault
+	 * @err: Error state of fault
+	 *
+	 * Page fault producer receives acknowledgment from the consumer and
+	 * sends the result to the HW/FW interface.
+	 */
+	void (*ack_fault)(struct xe_pagefault *pf, int err);
+};
+
+/**
+ * struct xe_pagefault - Xe page fault
+ *
+ * Generic page fault structure for communication between producer and consumer.
+ * Carefully sized to be 64 bytes. Upon a device page fault, the producer
+ * populates this structure, and the consumer copies it into the page-fault
+ * queue for deferred handling.
+ */
+struct xe_pagefault {
+	/**
+	 * @gt: GT of fault
+	 */
+	struct xe_gt *gt;
+	/**
+	 * @consumer: State for the software handling the fault. Populated by
+	 * the producer and may be modified by the consumer to communicate
+	 * information back to the producer upon fault acknowledgment.
+	 */
+	struct {
+		/** @consumer.page_addr: address of page fault */
+		u64 page_addr;
+		/** @consumer.asid: address space ID */
+		u32 asid;
+		/**
+		 * @consumer.access_type: access type, u8 rather than enum to
+		 * keep size compact
+		 */
+		u8 access_type;
+		/**
+		 * @consumer.fault_type: fault type, u8 rather than enum to
+		 * keep size compact
+		 */
+		u8 fault_type;
+#define XE_PAGEFAULT_LEVEL_NACK		0xff	/* Producer indicates nack fault */
+		/** @consumer.fault_level: fault level */
+		u8 fault_level;
+		/** @consumer.engine_class: engine class */
+		u8 engine_class;
+		/** @consumer.engine_instance: engine instance */
+		u8 engine_instance;
+		/** consumer.reserved: reserved bits for future expansion */
+		u8 reserved[7];
+	} consumer;
+	/**
+	 * @producer: State for the producer (i.e., HW/FW interface). Populated
+	 * by the producer and should not be modified—or even inspected—by the
+	 * consumer, except for calling operations.
+	 */
+	struct {
+		/** @producer.private: private pointer */
+		void *private;
+		/** @producer.ops: operations */
+		const struct xe_pagefault_ops *ops;
+#define XE_PAGEFAULT_PRODUCER_MSG_LEN_DW	4
+		/**
+		 * @producer.msg: page fault message, used by producer in fault
+		 * acknowledgment to formulate response to HW/FW interface.
+		 * Included in the page-fault message because the producer
+		 * typically receives the fault in a context where memory cannot
+		 * be allocated (e.g., atomic context or the reclaim path).
+		 */
+		u32 msg[XE_PAGEFAULT_PRODUCER_MSG_LEN_DW];
+	} producer;
+};
+
+/**
+ * struct xe_pagefault_queue: Xe pagefault queue (consumer)
+ *
+ * Used to capture all device page faults for deferred processing. Size this
+ * queue to absorb the device’s worst-case number of outstanding faults.
+ */
+struct xe_pagefault_queue {
+	/**
+	 * @data: Data in queue containing struct xe_pagefault, protected by
+	 * @lock
+	 */
+	void *data;
+	/** @size: Size of queue in bytes */
+	u32 size;
+	/** @head: Head pointer in bytes, moved by producer, protected by @lock */
+	u32 head;
+	/** @tail: Tail pointer in bytes, moved by consumer, protected by @lock */
+	u32 tail;
+	/** @lock: protects page fault queue */
+	spinlock_t lock;
+	/** @worker: to process page faults */
+	struct work_struct worker;
+};
+
+#endif
-- 
2.53.0

