Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124757C720
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973079; cv=none; b=EmzSQRNsYTLPBuQhFTfwHwjnAGKYzd7tSmmgl/mVUR8l3tNgSP+CcVIWihgkxw/flFU/5tYkuKwgm5X+pBOfviyMEXctapivYbhW6Bq31eQGCAXrsc2G9+XRnbPukgazmsrNJ2KukTGVduFE3Dut0vq4fkkfGuQMVcq9oyE9a+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973079; c=relaxed/simple;
	bh=RMKBqiUazUa/Jnsn7C123Y8W1MDzOBJbFbGrmWhQlDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCfqHmlF+otvMxhdcUEZ/5HdAJwYMc1brD2vpD8H/1Kf1EyE7FC94OhSNid2rbiOlaFS0N0P10lHn+wRdoW+IDNfUCZvOqSyDN9bxi6+jtB7rNS3lyqYxdA5n9B9JJK5nzOelgzxKF00OSewn+eJkb1ctrGjV4+f4mUxWF0umYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXiGjstO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXiGjstO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100C31F00893;
	Wed,  9 Sep 2026 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973077;
	bh=UqW2qKrTMv35mUHR8hOn1J6zwUoKAIm3KsntBPp1uUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KXiGjstOEB/IWFUevOYsTODGsHMzMGvWRxCgn60tK11IejYpcws32S9Eu93C9PGsW
	 /xeh0PyS7wU7OjhdnI0IbqKcq+Op0TA6PWlr0ogyFLqEC6YC2Jz3hfU+F/VB7mzOR0
	 N78Vk9sHFKcV/EXMTZ3ZMj60ID7uyvNFTiKV4GP/BxogwMAYX6s4SbYIdndFOQpCgf
	 rpyuJ9JA3WQwnphha5krXbSMgyO7MCvY6ioebXDozyfazeqDZ53IwlXANC9IoZMND5
	 pxrXfwAyBcEiKzkS6M+arIAc2kA6YgVk1t0xlw9Pw1P8b0DJA4hJt+vLQ/zbUnRDf6
	 /hQvHfNA3SN/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] workqueue: Add resource managed version of delayed work init
Date: Wed,  9 Sep 2026 12:57:53 -0400
Message-ID: <20260909165754.3145389-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090327-map-reptilian-66d3@gregkh>
References: <2026090327-map-reptilian-66d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

[ Upstream commit 0341ce5443949588e93581b49b934cdde2befbf8 ]

A few drivers which need a delayed work-queue must cancel work at driver
detach. Some of those implement remove() solely for this purpose. Help
drivers to avoid unnecessary remove and error-branch implementation by
adding managed verision of delayed work initialization. This will also
help drivers to avoid mixing manual and devm based unwinding when other
resources are handled by devm.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Link: https://lore.kernel.org/r/51769ea4668198deb798fe47fcfb5f5288d61586.1616506559.git.matti.vaittinen@fi.rohmeurope.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 9d34c9d660c3 ("power: supply: bq24257: fix use-after-free on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/devm-helpers.h | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 include/linux/devm-helpers.h

diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
new file mode 100644
index 0000000000000..f64e0c9f3763c
--- /dev/null
+++ b/include/linux/devm-helpers.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_DEVM_HELPERS_H
+#define __LINUX_DEVM_HELPERS_H
+
+/*
+ * Functions which do automatically cancel operations or release resources upon
+ * driver detach.
+ *
+ * These should be helpful to avoid mixing the manual and devm-based resource
+ * management which can be source of annoying, rarely occurring,
+ * hard-to-reproduce bugs.
+ *
+ * Please take into account that devm based cancellation may be performed some
+ * time after the remove() is ran.
+ *
+ * Thus mixing devm and manual resource management can easily cause problems
+ * when unwinding operations with dependencies. IRQ scheduling a work in a queue
+ * is typical example where IRQs are often devm-managed and WQs are manually
+ * cleaned at remove(). If IRQs are not manually freed at remove() (and this is
+ * often the case when we use devm for IRQs) we have a period of time after
+ * remove() - and before devm managed IRQs are freed - where new IRQ may fire
+ * and schedule a work item which won't be cancelled because remove() was
+ * already ran.
+ */
+
+#include <linux/device.h>
+#include <linux/workqueue.h>
+
+static inline void devm_delayed_work_drop(void *res)
+{
+	cancel_delayed_work_sync(res);
+}
+
+/**
+ * devm_delayed_work_autocancel - Resource-managed work allocation
+ * @dev: Device which lifetime work is bound to
+ * @pdata: work to be cancelled when driver is detached
+ *
+ * Initialize work which is automatically cancelled when driver is detached.
+ * A few drivers need delayed work which must be cancelled before driver
+ * is detached to avoid accessing removed resources.
+ * devm_delayed_work_autocancel() can be used to omit the explicit
+ * cancelleation when driver is detached.
+ */
+static inline int devm_delayed_work_autocancel(struct device *dev,
+					       struct delayed_work *w,
+					       work_func_t worker)
+{
+	INIT_DELAYED_WORK(w, worker);
+	return devm_add_action(dev, devm_delayed_work_drop, w);
+}
+
+#endif
-- 
2.53.0

