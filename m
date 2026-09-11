Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A783DEFFE
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093861; cv=none; b=rL64YucKs5BKMedJ02RpmLXXygcv/ECLK00CCMozPlUQvZdan08VX0CwOpPliZV4gchivhAyVeB1SgEW38ZRAclOI+wQe3bvhbpSfyLg8gMXsAENeFBVsjS6nngdbhwOauAGfZe0kJFVkU3f7UVMnYUlaRGkM5zmno95X9oLwSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093861; c=relaxed/simple;
	bh=BgbwV1ZHGeMc9LF81Rw+S0LCA9ASZx8WQ9AqhkffMNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfB78Cv71l7nkI9yZbDQQYc3jimuv16qW0HzO3O6PHzuXgRNooJYPI/KLEGcdKujBNIZ7LKGxpN7eM6t6lfDPM11uNSUKbHHyJ6BlM35rh2Hr6tcvZ9g8DE8K91jUPBrMbfZfo6HzVxC8llrSrPjZLkfSF33Ht6zQacIJUSJKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYh3Z5wP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYh3Z5wP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DD51F000FF;
	Fri, 11 Sep 2026 02:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093859;
	bh=lmzb6xGI7jcOOdXgB8PX1bps2cQGiY8eYAeMBYKD5CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nYh3Z5wPrQKEITwAmpoNpot/rUBUGfmKQfYCWLXL86UCzCZVhBiTA1+h0WFL38I8M
	 /8/7K4OoULVO1Wm3CsRYaQKfHOHzL3vW1lCnjjec7/C3IxkpQKKb6gAswAElSy1TxB
	 6GrWmNyAJheU+MPef9bPpKEKb4IRgDKORdoWbYriUwBXfWDbykwcrKbqr3uergb/ev
	 KC0TL/YN+dWzJtk7/wIMYkSbiy47ECNUtXX5769edkgow3Xge4Dpn21Ci/bnTFn+cU
	 tMd0VjZr6N0a9FXmMrw5RpzVOdGym2qSbsWHFQSzCcxNBQbF/3MENI2wTkVNQiw1Dh
	 cl93tT8K8XmbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] PM: runtime: Wrapper macros for ACQUIRE()/ACQUIRE_ERR()
Date: Thu, 10 Sep 2026 22:30:56 -0400
Message-ID: <20260911023057.75546-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090902-spruce-sleeve-2bcf@gregkh>
References: <2026090902-spruce-sleeve-2bcf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit ef8057b07c72a817537856b98d6e7493b9404eaf ]

Add wrapper macros for ACQUIRE()/ACQUIRE_ERR() and runtime PM
usage counter guards introduced recently: pm_runtime_active_try,
pm_runtime_active_auto_try, pm_runtime_active_try_enabled, and
pm_runtime_active_auto_try_enabled.

The new macros should be more straightforward to use.

For example, they can be used for rewriting a piece of code like below:

        ACQUIRE(pm_runtime_active_try, pm)(dev);
        if ((ret = ACQUIRE_ERR(pm_runtime_active_try, &pm)))
                return ret;

in the following way:

        PM_RUNTIME_ACQUIRE(dev, pm);
        if ((ret = PM_RUNTIME_ACQUIRE_ERR(&pm)))
                return ret;

If the original code does not care about the specific error code
returned when attepmting to resume the device:

        ACQUIRE(pm_runtime_active_try, pm)(dev);
        if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
                return -ENXIO;

it may be changed like this:

        PM_RUNTIME_ACQUIRE(dev, pm);
        if (PM_RUNTIME_ACQUIRE_ERR(&pm))
                return -ENXIO;

Link: https://lore.kernel.org/linux-pm/5068916.31r3eYUQgx@rafael.j.wysocki/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/3400866.aeNJFYEL58@rafael.j.wysocki
Stable-dep-of: d378fceaafd7 ("iio: light: apds9306: fix PM reference leak in apds9306_read_data()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pm_runtime.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 0b436e15f4cd6..911d7a4d32c15 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -637,6 +637,30 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try,
 DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
 		  pm_runtime_resume_and_get(_T), _RET == 0)
 
+/* ACQUIRE() wrapper macros for the guards defined above. */
+
+#define PM_RUNTIME_ACQUIRE(_dev, _var)			\
+	ACQUIRE(pm_runtime_active_try, _var)(_dev)
+
+#define PM_RUNTIME_ACQUIRE_AUTOSUSPEND(_dev, _var)	\
+	ACQUIRE(pm_runtime_active_auto_try, _var)(_dev)
+
+#define PM_RUNTIME_ACQUIRE_IF_ENABLED(_dev, _var)	\
+	ACQUIRE(pm_runtime_active_try_enabled, _var)(_dev)
+
+#define PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(_dev, _var)	\
+	ACQUIRE(pm_runtime_active_auto_try_enabled, _var)(_dev)
+
+/*
+ * ACQUIRE_ERR() wrapper macro for guard pm_runtime_active.
+ *
+ * Always check PM_RUNTIME_ACQUIRE_ERR() after using one of the
+ * PM_RUNTIME_ACQUIRE*() macros defined above (yes, it can be used with
+ * any of them) and if it is nonzero, avoid accessing the given device.
+ */
+#define PM_RUNTIME_ACQUIRE_ERR(_var_ptr)	\
+	ACQUIRE_ERR(pm_runtime_active, _var_ptr)
+
 /**
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
  * @dev: Target device.
-- 
2.53.0

