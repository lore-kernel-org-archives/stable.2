Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DCC339714
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 04:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791432478; cv=none; b=VA95Gv8XE+VGJqEPM+bjUy5/6vsQP6nhBDWFkjYMvflCxFKGXq4UvlI8+WShV8iRZO6Rka+n97Iz89VBQJdikNZbDPzq8zfY7fioAm2FFbGwoT7rZtvdGeXibMyELZkDSMqS9UoYkk78MkMYLGyVeOy92vZFkQuWCqeVCZ2t+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791432478; c=relaxed/simple;
	bh=eN/CZ0g8dEhhAB4TCIZ6bYboNzAcetSZ5y4UbmprSTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVh2iL0AGUgCt6ZnKgOKAUiBc6FqpsgPWo+qmUPB/6SotR6Hw19IF3N5KR1SZQTQQMu2fSo3mo4T8+vffjppsLT5i7F11TAOcCG9qOOln0spfB9uoMdSDI+4tthp77RimsQUtNENUKb8/xqRzncIU2lFLiFfrhCLY2vPrcASQlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dwt7N5aq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dwt7N5aq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so47957155e9.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 21:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791432475; x=1792037275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8RXN0pRoDPRt/4/q4G7QWKtdi+MOFx+4+xgS3NP3upU=;
        b=Dwt7N5aqm5cYyDc+huAxA+bLXtiDg6jeXvEFkMg+ckSARoR0cYQeAG5KUuatz6Whia
         DviSzTI5DvX07Ci7/9M1oIBWOp5/+tvj5oKk/ghkCBwGZDMGlSVF0a2C0kgsxjJNUdO9
         M3nXtMPY4Nb62XKtRO0ewmUKyA5167h5X+QBwye1Q39eGPnDG7xtiX7ULXKd0rUB2us6
         OZ+3x8ckeZFfZzHDEF0xtEVHsyJKF2JOwN+QRZC1JQ1o+0E+j5LbZZUxB8kC93dJCHWI
         gZncDi/V3Q3u6jmCzMO1po58UHwtvhhq68zNa5iAzukzs5ijvtq3rGSXTAsHPkthPEBH
         M0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791432475; x=1792037275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8RXN0pRoDPRt/4/q4G7QWKtdi+MOFx+4+xgS3NP3upU=;
        b=FDCzeydu8CHP1Q0Gw59o7qok97F142j1tW1o+HyzTyTdh1PA93XVp3kQQp2bJCdCF0
         XiCX/1WUctGIxFJfy3lsjxa59FmX268XQuOneYi6+rjxP67Scvj5ckZdI0meewPsU+ND
         kHMI971g+mGI8Vl/lhf51WNYBnEHfhXEXdBTzxWiTLin3ZT0RCfVntGpco8+/DWxt3WC
         FrP5VRc3G3/wap/LNAAOgVyp1jhoXRsXrOemxrFtujX6kKfD/AtHbyr9iRgYM9WhwnJj
         QuNAbwToYqdeXXhSM17awzS6AObB48HgBKs3eWXd6wAFiyTiRWIkzdolhtjCLfERd/NP
         DBXg==
X-Forwarded-Encrypted: i=1; AKwUvBz3PpPs0xVCKzEKRGj7IQ08qpQLtQU8NhcMCuML0HkCOiPMRtASzHVk+YFzrr/vca7G0eE0NI4=@vger.kernel.org
X-Gm-Message-State: AFuF++lJijQ+6aY7k1jqcEPDZrJboPhqWp6Js449PFYlz91mFlo21dbj
	V9J91Df0f9X5iWsj4p4V2IQ7VdrS7yHqxzFoW0neh+IiWqZR4mV8G1cZ
X-Gm-Gg: AYBFou04DuBg9fvynBEVLm9eWHYxYFuhqpZeB8QzJcyoe90wIbF7oK41d1Da1gDzOb3
	1klzOElq/ns9uUuK5Ub/PszlX/bhbt6xh442DtcSXXXHKsNsjP+6cwyunro6UdQPLP53vWoZMec
	HfVif35/NoHR/B/tbN3Y0e+ztEZHjUxzaCDKHg+sNe0Wa4OfqteOo3P9GS9hlHFHGCcFj1tCXSQ
	vej+W/75CPIC1Bd+zl2wfv2NN1FjL9hoWnNCPmvihcpX2J3LV4BrWxVNN9Jt0bKPpx1+yq02yBm
	PsGer0wVTcIHCZXx4a8z2MrD/wDOeh5QSNXpm3fjfGIGx7JC1YyL6K/iKNd+nb/1FsDGmsHaDRc
	qUC2iHLA4cHCbHH8EfE+hESzGW8Zj0TFRyUYjgvE7EcSDjrZ6o/iWdkLiBQI07S9gutirpJ/dBM
	jkFlBT2zsj1TAdY/TgGc/9ZVUryW9eSF0X/uYkPpQuqNq7DhzhZBWEQw8t8KFE+z2ABUI=
X-Received: by 2002:a05:600c:c165:b0:49c:ffab:551f with SMTP id 5b1f17b1804b1-4a181b33928mr74752385e9.22.1791432475504;
        Wed, 07 Oct 2026 21:07:55 -0700 (PDT)
Received: from arch.local ([105.110.78.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a180310c9fsm91191145e9.4.2026.10.07.21.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 21:07:55 -0700 (PDT)
From: Akram Boulahia <akram02st@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	linux-pm@vger.kernel.org
Cc: Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org,
	Akram Boulahia <akram02st@gmail.com>,
	stable@vger.kernel.org,
	Marco Scardovi <scardracs@disroot.org>
Subject: [PATCH] cpufreq/amd-pstate: Don't fail active mode init on read-only auto_sel
Date: Thu,  8 Oct 2026 05:07:05 +0100
Message-ID: <20261008040705.10600-1-akram02st@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active
mode on shared memory systems"), shmem_init_perf() no longer returns
early in active mode and always calls cppc_set_auto_sel(), which was
needed for shared memory systems. However, on firmware where the
Autonomous Selection Enable entry of _CPC is a constant integer rather
than a register, that write fails with -EOPNOTSUPP. The error is
returned, every CPU fails to initialize, cpufreq_register_driver() finds
no policy and returns -ENODEV, and the kernel falls back to
acpi-cpufreq:

  amd_pstate: failed to set auto_sel, ret: -95
  amd_pstate: Failed to initialize CPU 0: -95
  ...
  amd_pstate: failed to register with return -19

This was seen on an ASUS ROG Zephyrus G14 (GA403UV, Ryzen 9 8945HS, BIOS
308). Its _CPC tables are revision 3 with the entry fixed at 1, and
cppc_get_auto_sel() reads back 1 on all CPUs.

If the write returns -EOPNOTSUPP while active mode is requested and
auto_sel already reads as enabled, which is what active mode needs, the
refused write is harmless and initialization can continue. Any other
failure, including a refusal where the current value does not match the
requested mode, is still returned as before.

With this change, amd-pstate-epp loads on all 16 CPUs of that machine
without warnings. amd_pstate=passive behaves as before: it still falls
back to acpi-cpufreq with the same -95 errors, because auto_sel stays at 1
and cannot be changed.

Tested on Linux 7.3.0-rc6-00037-g7b63ef2d55f2.

Fixes: 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems")
Cc: stable@vger.kernel.org
Cc: Marco Scardovi <scardracs@disroot.org>
Signed-off-by: Akram Boulahia <akram02st@gmail.com>
---
 drivers/cpufreq/amd-pstate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8bfd46d60843..05b496946d13 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -500,6 +500,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u64 numerator;
 	bool auto_sel;
+	bool want;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
@@ -518,14 +519,23 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->perf, perf);
 	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
 
+	want = (cppc_state != AMD_PSTATE_PASSIVE);
+
 	ret = cppc_get_auto_sel(cpudata->cpu, &auto_sel);
 	if (ret) {
 		pr_warn("failed to get auto_sel, ret: %d\n", ret);
 		return 0;
 	}
 
-	ret = cppc_set_auto_sel(cpudata->cpu,
-			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
+	ret = cppc_set_auto_sel(cpudata->cpu, want);
+
+	/*
+	 * Firmware may expose Autonomous Selection Enable as a read-only
+	 * constant. If it already matches what active mode needs, the
+	 * failed write is harmless.
+	 */
+	if (ret == -EOPNOTSUPP && want && auto_sel)
+		return 0;
 
 	if (ret)
 		pr_warn("failed to set auto_sel, ret: %d\n", ret);
-- 
2.56.0

