Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562303;
	b=NuYA0QOfZLK0kOHezb12dyDAoTmZ590pC2ddRHgSUhAQXHK4moO8vGk3ThlbdeJMJfyg
	 p3XN9wbt9PUXmYHdJ6i8+HthHIsxlfOnacQ1GcVzCfmDEyiJptVZb9AalwLH9GVsjZJT5
	 omFHJGCKxLaOwfp4ouvI2Q3wgbGd9/FDExQJeAkqGRW8CukUZiE0zp0ZcpLcycNS0/KIe
	 EEURu/dXRG85aTHONHLjMeTCz0XZPOjcMEAXjzobLOXaIfagRLAzPORH559E2jL+eoTI2
	 vDqRAf9rlNSPbuHnDGDwj46Rw3cre0qqH3hsAhQ5xEYRnsbKbjUcAvibKcenD9mRU1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JSPW10Pj7mWYrcYQV491CeBQq8pVVNVHWtKBSkpxQdY=;
	b=V3wZzCPs8wDht6EUuBIVbUyV/rAHyKc7EErjYpOK4mqy9vWUQQM8sGf1Nf7egt7wwsZp
	 +2rOJ7iJxzQjssL5y2YPhXAjxFYeavcuB0Loj9AcVro5yN73mpitnrWgZu3B5sS6DjCQq
	 gpaX2BGimoa5gD4X7SVvJPyVRztL/DGWMwV+zf92YcZBBJ6VSsz/QHR2xkfjD+2OJZ3Id
	 pY5RUQWaZdPTA8iZf7Wws1VwFpQfVXXlibu6v13kpQkE2PMsX3/cJnFk8nKq+rn1vlukT
	 k+ZyU5tE88ghF5twKjawpbhTV/1pVDAyMs1OyU2tYFabwtFud3rxzBorskKyBNZshaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SI0ND5xy;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C79606A32E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C79606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SI0ND5xy
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4b467581b98so49767715e9.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795562301; x=1796167101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JSPW10Pj7mWYrcYQV491CeBQq8pVVNVHWtKBSkpxQdY=;
        b=SI0ND5xybHzRNkTlF7R69RrtN0WhAy6NS3Dqdmm282zxlySUryxFPjZeqOA4ldnWb5
         FH5OmdYtPtrzSV66UbadG8hPTKejk4ztYaXVtXsnANibRwzyjV5hK4KeIQHNVBbQvaJ8
         M8ZqJzEZ1LjwxzAt1FAa0FRaRwWF14rRR9WAxrdJJVo4Gowm/qAmWnKjuBGVOjlJqv+r
         P3OyJS9FfRtChwteYvHKD12yKaZklv9pTtspU31NsUjDGL5LRdbPPsQVglSLOr1fWF+6
         hIMCrU4rXEasa62orHeuZTrLDr7L1PNS8HdrlgyGxv64YzXyfuvVxBW4ZKB3h+qA0NDk
         zg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795562301; x=1796167101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JSPW10Pj7mWYrcYQV491CeBQq8pVVNVHWtKBSkpxQdY=;
        b=ZQNHJYvG/AJm1RY+6VVlq0i23/9ZFNMKpyZHvddunoea7kcpRsfozZNU9FJRQkdM35
         2lMBdijJTNkeCcOU/okwOQARNp8wDlZNaSKR623/TUjmz2750IkiSsQ/aHnH27Rhp6tm
         Yh61YlgDwcGdMtgUw7WHA8DfrRGMCuA8DvyMtGoKO1bfEq7tXPnzR+9yI5wfFi7li41c
         oye27/wdmzlTxSnNdKJaHdvE4RS8SITAu8KJM3I2gQjqcM9pWesxWr1gRXQpPBRFjMBo
         PGM+kepOEGLJ6ntoD2R0qm+ogSgLpfyBrC8VMA11sPwzXFOFGFqTXPli8xon5UfIerMw
         Ky7A==
X-Forwarded-Encrypted: i=1; AL+hErFFi/PL4NyVbztdzC1MXLInJZMtR5RQmFmtrc+OsiPsPbBKyz/enalwuRAeb/39ndi3jsC1trs=@vger.kernel.org
X-Gm-Message-State: APuU4Z88jTi5sfc0b0qO3dfIgUf/C3Lnp7JwNcHbH869HjkPd2YhqKfU
	MmBIWerjiywFGRx9VMfm2C4DIJMFfJ2bOyv2mE/XcVyR5cxUMnT8znPq
X-Gm-Gg: AZFdTZflAhPtkpkrd1cl2DnxCUkZScSR3FK6QEJSZ0Lo/Ceuv88ozZE7iYqrn0ICM5G
	acyNLTbal3UkK6Ngb2EicnrYYnMwedcs8s8ICrztn7pTTP9/ZTXEb1DQSxMcbaB6GDKt7B9lLgS
	MdmM0IkUCJeYJYO+DDD4EGwAoP5MGTtEVqxXAYIDQfW4vIw8Fx/566G4BU7zwf43ReK9bY0VQht
	0tL0dMVSrCDEX9puoDmuqodGOt1xjAhdiQZzOjUS6oSe+Y32Hpv0OwDbBKnnLGuhZ3+r3a1lpZX
	c1yqdAyzMFlPBirqt2XctuOhD/I5HmbTH4MNeGUTdyhLz4xt/kN0af6gyIXFvFiG4hN9RCSfk9r
	t/QcqugIAjh0DGsfUQ/UjO648RwOxaxlbzZNRhXPxJH+9GRuZG0WeJxIFhj+R9noHI050DktziE
	t/SYGNtXYlFBHhwbyTXMZ7J3yBQn5gjleypLRYlGUtLoF2TdVipBG9Ys8aIcerymwGb8BAIOd6A
	pTgFy79NahSxHT1J0aKays568YOOOT7fY0/RRs5YCgypoaF7FTmrbSAFE2anxTk2B5U+YyRSV4o
	gl1vHbB9b/baWzEuGtwXzYU+lde+FhTmNL31xMkk5lm9zfDo8I3VG3bVfhfVuWyqGDW3CELj
X-Received: by 2002:a05:600c:64c8:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4bb887e2380mr303656325e9.4.1795562301128;
        Tue, 24 Nov 2026 15:18:21 -0800 (PST)
Received: from localhost-live.home.vlan10 (053d9243.dynamic.tele-ag.de. [5.61.146.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm554400825e9.11.2026.11.24.15.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 15:18:20 -0800 (PST)
From: Joshua Covington <joshuacov@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <masneyb@kernel.org>
Cc: Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	linux-clk@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Joshua Covington <joshuacov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] clk: allow a clk_hw to be registered again after unregistering it
Date: Tue, 24 Nov 2026 23:17:49 +0000
Message-ID: <20261124231751.83938-2-joshuacov@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124231751.83938-1-joshuacov@gmail.com>
References: <20261124231751.83938-1-joshuacov@gmail.com>
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

__clk_register() sets hw->init to NULL, and clk_unregister() leaves
hw->core and hw->clk pointing to the clk_core and clk it is about to
release. A driver with statically allocated clk_hw structures can
therefore not register them again, e.g. when its device is unbound and
bound again. The second registration has no init data and oopses. A
clk_parent_data.hw reference to such a clk_hw also resolves to the
freed clk_core of the previous registration.

Keep the init pointer in the clk_core, and put it back into the clk_hw
when the registration fails and when the clock is unregistered. Init
data on the stack of the registering function is gone by the time the
clock is unregistered, so leave hw->init NULL in that case. This has to
be checked at registration, as object_is_on_stack() only looks at the
stack of the current task. Also clear hw->core and hw->clk on
unregistration, so that a reference to an unregistered clk_hw is
treated as an orphan.

Fixes: 0214f33c4e0e ("clk: Overwrite clk_hw::init with NULL during clk_register()")
Link: https://lore.kernel.org/all/179545567027.246915.947299820828330388.b4-review@b4/
Cc: stable@vger.kernel.org
Co-developed-by: Brian Masney <masneyb@kernel.org>
Signed-off-by: Brian Masney <masneyb@kernel.org>
Signed-off-by: Joshua Covington <joshuacov@gmail.com>
---
 drivers/clk/clk.c            | 23 +++++++++++++++++++++++
 include/linux/clk-provider.h |  5 ++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 4d2cc86bfb..c19ae1812c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -70,6 +71,9 @@ struct clk_parent_map {
  * @ops:               Pointer to hardware-specific operations for this clk.
  * @hw:                Pointer for traversing from a struct clk to its
  *                     corresponding hardware-specific structure.
+ * @hw_init:           Init data of @hw, put back into @hw when the
+ *                     registration fails or the clk is unregistered. NULL
+ *                     if the init data was on the stack.
  * @owner:             Kernel module owning this clk (for reference counting).
  * @dev:               Device associated with this clk (optional)
  * @rpm_node:          Node for runtime power management list management.
@@ -119,6 +123,7 @@ struct clk_core {
 	const char		*name;
 	const struct clk_ops	*ops;
 	struct clk_hw		*hw;
+	const struct clk_init_data *hw_init;
 	struct module		*owner;
 	struct device		*dev;
 	struct hlist_node	rpm_node;
@@ -4457,6 +4462,8 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 	if (dev && dev->driver)
 		core->owner = dev->driver->owner;
 	core->hw = hw;
+	/* Stack init data is gone once the registering function returns. */
+	core->hw_init = object_is_on_stack(init) ? NULL : init;
 	core->flags = init->flags;
 	core->num_parents = init->num_parents;
 	core->min_rate = 0;
@@ -4505,6 +4512,9 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 		pr_err("%pOF: error %pe: failed to register clk '%s' (%pS)\n",
 		       np, ERR_PTR(ret), init->name, hw);
 	}
+
+	hw->init = init;
+
 	return ERR_PTR(ret);
 }
 
@@ -4656,11 +4666,16 @@ static void clk_core_evict_parent_cache(struct clk_core *core)
 /**
  * clk_unregister - unregister a currently registered clock
  * @clk: clock to unregister
+ *
+ * The clk_hw of @clk is returned to its state before registration, so
+ * that it can be registered again. Until then, a clk_parent_data.hw
+ * reference to it is treated as an orphan.
  */
 void clk_unregister(struct clk *clk)
 {
 	unsigned long flags;
 	const struct clk_ops *ops;
+	struct clk_hw *hw;
 
 	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
 		return;
@@ -4709,6 +4724,14 @@ void clk_unregister(struct clk *clk)
 	if (clk->core->protect_count)
 		pr_warn("%s: unregistering protected clock: %s\n",
 					__func__, clk->core->name);
+
+	hw = clk->core->hw;
+	if (!WARN_ON(hw->core != clk->core || hw->clk != clk)) {
+		hw->core = NULL;
+		hw->init = clk->core->hw_init;
+		hw->clk = NULL;
+	}
+
 	clk_prepare_unlock();
 
 	kref_put(&clk->core->ref, __clk_release);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index a355d1ee51..026efed876 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -359,7 +359,10 @@ struct clk_init_data {
  *
  * @init: pointer to struct clk_init_data that contains the init data shared
  * with the common clock framework. This pointer will be set to NULL once
- * a clk_register() variant is called on this clk_hw pointer.
+ * a clk_register() variant is called on this clk_hw pointer. It is restored
+ * if registration fails, and when the clock is unregistered unless the init
+ * data was on the stack of the registering function. The clk_hw can then be
+ * registered again as long as the init data it points to is still valid.
  */
 struct clk_hw {
 	struct clk_core *core;
-- 
2.56.0

