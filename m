Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303317;
	b=It3ouEsWfVxhcYsyxUe7H5s7l40Kh8ohDUyaFFmi+1h41PCR5H0qzKH5iU0bUh75Ac/m
	 zMftQhw+I7airm56LYulLpXkwmIjyh2CnkGCWF2AHbFz/KG4sZ9sJsQMkY/TzbqkEF/78
	 rZD7Gr6xNU3e/FztBKoisiaUMXa51cWgLAFjEWRcQnegwH2m3+3Zt0W4xS+y5MtVhO7YK
	 bRKk+on/rlfngCZeNA39vCDez6dxctzbOtBeKPUL0KNqYShwb//RI8h72c/lJai8a0gua
	 9kbWmJDKD+3fJI9zjal/D6N4pGVQiCuTzwp5h69+hoDeh4TFRg7IP3L6ki6zadkiiQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303317;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=2vK9jGY6wUlxK3Pwv6AJs0AlbAtD/rancEeRRGYYpT8=;
	b=I3BkCuRMxFEL2rc1O/KuNzkmCuk9B53HD0hX5Gev4GIBEaoH4Hd3VwhiMnLc+5x/fTsW
	 zmghWpTYTs89yOALgPyHSubW5mhcTozpyJoA5Hpr3ztZM9PYRw9NlDAsRexQ2v9abfrva
	 AVHLwfM19Vh+ubXI6vA76rjWB1IHH7nQ1BKVOdDlRjnW0+jV/xTksuksppcvLD4EQ01Wu
	 ixqzbANuPQ5x6acvYv57t+NagvTstJj4iL8WUGo53rlHwy44P6Ogsxx9e5Bfoi9AYoQ2k
	 2KYXQ0q2kn4k+sLQiSBUrvS+YZss+gxUQChMdmerTXL2LMCDZ12+X8QcLivJ4UQU6TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDf9KVco;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10296606DA3A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDf9KVco
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47C91F008A1;
	Tue, 10 Nov 2026 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303316;
	bh=2vK9jGY6wUlxK3Pwv6AJs0AlbAtD/rancEeRRGYYpT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FDf9KVcoYum9TEMMsdtaD8+UvWlwsO10l7xoNv3yBa359aFRHgA2IYS4Fg4cgjx0I
	 ZG+NU6UUNTTpgd9SCuW7XVK/Lekyq0fqqgrht6bd+XXgAZu1aFg5FBLpubFS0ITW7P
	 t/xoggHchG80iZ1e+dXRrw7R4sS5oDlDwzvNY3y7VM/kClS951lmBhd2sRpSJr52rh
	 5fmLtauS1FyS+nAdOpabHZamhHvYYvBFh0k5tHk8trjphrbVUUJk+hJOJzay1TOsYa
	 Y6ugZ0iem+ipMuXb13wq6NNurB02cVn5bXAxd8Tr2SbRm4yl/N7hNNbx+tjBDE25RY
	 kIWUMRzxa2nQw==
From: Thomas Gleixner <tglx@kernel.org>
To: Sasha Levin <sashal@kernel.org>, 4ncienth@gmail.com, shawnq1@163.com,
 jstultz@google.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.18.y] timekeeping: Require permission to set auxiliary clocks
In-Reply-To: <20261107051357-failed-6.18-524d95c8a200@kernel.org>
References: <20261107051357-failed-6.18-524d95c8a200@kernel.org>
Date: Tue, 10 Nov 2026 10:35:13 +0100
Message-ID: <87tslpt4fi.ffs@fw13>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

From: Daehyeon Ko <4ncienth@gmail.com>

commit 524d95c8a2000cba6cb80a173d76cb746c561244 upstream.

The generic clock_settime() entry point delegates permission checks to
each clock-specific callback. aux_clock_set() does not perform one. Once
an administrator enables an auxiliary clock, any local process can
therefore change the global clock offset.

A test process running as UID and GID 65534 with no effective, permitted,
inheritable, or ambient capabilities set CLOCK_AUX0 successfully, and a
separate process observed the new value. The same process was denied by
clock_adjtime(). An AppArmor profile denying sys_time also blocked
CLOCK_REALTIME changes but did not see the auxiliary clock operation.

Call security_settime64() before mutating the auxiliary timekeeper. This
matches CLOCK_REALTIME's permission model, enforces initial-user-namespace
CAP_SYS_TIME, and gives LSMs the settime hook while preserving authorized
clock changes.

Fixes: 60ecc26ec5af ("timekeeping: Provide time setter for auxiliary clocks")
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: shaos <shawnq1@163.com>
Acked-by: John Stultz <jstultz@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261019080324.4147815-1-4ncienth@gmail.com
---
 kernel/time/timekeeping.c |    5 +++++
 1 file changed, 5 insertions(+)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/sched/loadavg.h>
 #include <linux/sched/clock.h>
+#include <linux/security.h>
 #include <linux/syscore_ops.h>
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
@@ -2936,11 +2937,15 @@ static int aux_clock_set(const clockid_t
 	struct tk_data *aux_tkd = aux_get_tk_data(id);
 	struct timekeeper *aux_tks;
 	ktime_t tnow, nsecs;
+	int ret;
 
 	if (!timespec64_valid_settod(tnew))
 		return -EINVAL;
 	if (!aux_tkd)
 		return -ENODEV;
+	ret = security_settime64(tnew, NULL);
+	if (ret)
+		return ret;
 
 	aux_tks = &aux_tkd->shadow_timekeeper;
 
