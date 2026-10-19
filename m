Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057937F006
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397017; cv=none; b=c2o7Griq16WKEazYX6NJ3g2E8JXldQafbMuaVBwaqeBpsMsNXu+62VxX2QirAJSBUUNss2bthrU70lGjAGk1rYlW3O+2IQWLL3LCJLg6bglgVVnYBryrg0xK044iJ/VAmDH+eaT+4m8rqUFko44srD1DDPR2LpUSJ6m4U1/5D/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397017; c=relaxed/simple;
	bh=aw2cbkeDGxmi0cabLfsJE8HWZuwrnmmFim3fvULxBWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MS9+N2KID9OIT4sj6fAdPMO315Ng5A0TkXI/JqYp3pQTOjYMAfBTvMtndG7kMu+r9WYH0zz8/VieF4PQnmyLj2VkLdJ4LZlquBt3WVhGkloz8R0NR0be62p1yX75yFbiDkF9pRSnjN/gY5YWpuXnnal00U6NOjOPJ56QJ8D0RyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhEdYII7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhEdYII7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8ad5b31c7so9134755ad.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 01:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792397016; x=1793001816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dbb1rTYm5o2K2VvHFfmHTxZkdAMnXyYRbYQis0wichc=;
        b=PhEdYII7Hd3AAmL0x2cO0py3pBRGFQRsMPIt7cC3AtexOCu3QQ6VNVpdaCCgc0EDHI
         kRvbOdOzKTfDwHk65BMTuDNub+j+slhLgfBHKDwa+WieCU6E8ECj68mk2CK3vGmAfke3
         8VEZlIDW/A7/8rYXKxSFZsfRjStO2lAP7/dmeWQ0AzP//DH2k8s0O0CHUjc1YIr0+eg9
         PTrfU1nBhbBx+ZFsxhBUu7abMbmCaIFYAY8HI7uVGVTjGBdZM/oo0zi3VAbulULwD+Pu
         4ONwB4BX8A3ttaQClcIORQJnsyx3nxer/DB7vwdB1D8oIsW/M6PiT5pa+0zUC1rxAHVM
         8AbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792397016; x=1793001816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dbb1rTYm5o2K2VvHFfmHTxZkdAMnXyYRbYQis0wichc=;
        b=qcqzhPy7eFq9DD9I8rShvMStFO9DwsJlz2nXp5JyF72sYIEBVeRTb5zIHhhoHnK4yx
         lqoxq4sgMto39sUwJV1sPt1Ffc+YaYybcRJ2tery5O+q1XJV3h55PaWloiBw+vlhbShm
         j1iC/iIzVYIjzzovY3IUDalyZL/9//LUP5amZhSFB+AxWdemZ15YXsEy2t8z1dAYh/zv
         J+s7ofxDfeIvhfQJun4qgPxXK6/H5y5k9nZYeggmT1T1gdO05NlycB7cVmUdqDzm1dxN
         st0ZFYrao0IRthg29A+l6byEmmZKrAbfuTfhVetQrvkYbNckpem79wSKEGC5GwoMhTdp
         y3dQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5J4Zkc87F+XzXkHio6v3NSpgv2jU0nycSHWibYa7t/RAsW098WE8/RHi3cAPJBSvicm75TyU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBsFI8S0kYRb3Oow/Zed9mM2oax1VcNIjClwxRkri8JSdSC2gR
	hHODyyMmy6YwJaN0ohY6biajSjMe6xjgdYi0hz0OlaT8rLYq/9h89VZ7
X-Gm-Gg: AYBFou1NWYCG/6PZeeDou62NZptUieNrT0sJFsxv9XMXrZc0HXdjCRX8PNGh96os+mg
	Xe9hWGNeEI7l2CYU4m46h0DiW5kSo/mCYiWUeABxR3zrckrQ+xLESJvIplcfqZvDsIUY3MSK3Z3
	uKdokXkoVRPf9kUoKQwBlz4kpwn97VtIPGZDhDdemY+z7JPYZ09F8+/ms4XQDFeVAxGneMwQtrA
	UGrPpecMNSjsFkkr1Bi1m7R9SW1GKk6powE4i5WSzZKmcD44pmYH52FZ66c3vMbSL72QAqjvWHL
	UcM23ktI6coCXqvudkWrVHvvvhOAgNhQHznA/G/pBRkD+6vgIbziFWbP+sNc4yiAZE6QBDRZ0vn
	3CHJqDUWV6T6tXg3sGvfjiTfmAmABD/n6VtQYBXulTZr+kHTHDNE5r1L2w7e5+hKZ2+4tEHAArp
	GrbYllxmTXNu7fQkwGG3hGMJpqEQU9HoxPh8RKYgjZHi/phc8eylPpvQV7elxP+sXULmnVZN5u6
	H9Lvkfxa5Q=
X-Received: by 2002:a17:902:ce81:b0:2e5:334f:f47e with SMTP id d9443c01a7336-2e9a69ea07fmr60652995ad.21.1792397015823;
        Mon, 19 Oct 2026 01:03:35 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804ce8sm34375805ad.26.2026.10.19.01.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:03:34 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] timekeeping: Require permission to set auxiliary clocks
Date: Mon, 19 Oct 2026 17:03:24 +0900
Message-ID: <20261019080324.4147815-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
AI assistance was used for source analysis, reproducer development, and
validation. The submitter reviewed the resulting change before signing it.

 kernel/time/timekeeping.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ea2e6e55f37bf..1b342825bd8f1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -14,6 +14,7 @@
 #include <linux/random.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/loadavg.h>
+#include <linux/security.h>
 #include <linux/static_key.h>
 #include <linux/stop_machine.h>
 #include <linux/syscore_ops.h>
@@ -3215,11 +3216,15 @@ static int aux_clock_set(const clockid_t id, const struct timespec64 *tnew)
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
 

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.55.0

