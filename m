Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587384;
	b=wwe5eH1vzhoC4oy+ARggW9W0Qvh32V5Kkm55gnnAwomJGxrjJFcRtCPv7ClQ/7W5HfB1
	 MarXyHKH8whCOqNo+B3DZ77O06akxogVOUg+RX+yZEfO9wRWHmg/8Wodm1FcYHy38R+na
	 39ArNdg+KIFHkaRwZpbH+D2nM5u50h+mtA83Pdtc0YIIIC0D8ZVGqqqWY1yS3ZjBGXTc9
	 61e98GnEjKom405flYAgdcbx9S0wpHrsyKiWy2VIcsZBDo4Lm7ygOyzxCyLyIFt4XwYxg
	 ZS7i7lWNekJR4RjiK3jdKVjrwIxsuPhPXl7c5PLHugmhT0EMg5cInVgSgjzOHZMeboA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Me8wiQ0HJEeNW8ibwQsvd7QQqaIgXxWtjrcDHkoHDvM=;
	b=Xa+2TdpHnmRfzBXgKg5tb7nlhGcm7kFZ/sQt9cCAOKklEg/LtX7nu6ao8qXxVHRK8BEd
	 /FMrdYq+oTnf0DPlGQtl8KC1Hs3hbLxdNRLH8du04vzdeOQhjRrXpWMS4CfB7oeV78CM9
	 zh0wcgCglKqrw72ffD7jTdUXiIgBiRljn82Wcfbg/Xbs/DJRqE/AYGLpjrnpB1n8XQJLb
	 9u/n0TeUBTFePyCGqro0qtByljaXrd/Y71XgbgpPsE4MuLviUHnxXMAzxXJKXT/gHKyhT
	 E6ywQn7tqHpQbSTMKzWrKXtIfImIrpfA3EKr9UKNJx7UmUVi7ud8XqgIdyUxiJU4qMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTdFEwCA;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F80606A887
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94F80606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTdFEwCA
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-372cba0ecf9so130393eec.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587384; x=1795192184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Me8wiQ0HJEeNW8ibwQsvd7QQqaIgXxWtjrcDHkoHDvM=;
        b=GTdFEwCAPipzok1XWTvM0HFdyLLsLDsftiLYc4ltMg5wFLRGab+iaHpPwZcwt+G4jZ
         nKHSCO6UdEPSSmY0KBVbdjndyc6Fe1bEhMVTw+b4DrUVxJOFK/bH8sM7dq0Cbsw3qqfU
         mdlUhrStPxP7LVeoR2exSfgEZCLun3zg00mv393zCXmQmnCjts3QBNaTqIcKQsNaSPdd
         vcOcvzYfQNGVVlOw3Qhcf6OKz+yjyH1QTGzwix1hr7beq3JQ+QKc3M+c8Cu9lmlUSHTc
         g9tQsJgwKIdCWoH1qckK8frZMvgxVQllWuo4cY5hAvCCnTiPcy0NgGzPXSzbb23RrRS4
         vhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587384; x=1795192184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Me8wiQ0HJEeNW8ibwQsvd7QQqaIgXxWtjrcDHkoHDvM=;
        b=18Fl9ItQQ6NrjQoZ9T8SS2spnjEvkbcRN3YKVxwSu96ZEx6+BGvTNpitrcZBX+iJIz
         UTEL4+RdCvhabMzMMarv6JBKJvzuZbNScL0q+gKkMXmKTGwxKeZOYMpd5ejTLsVCoomI
         yDBj6jiUxh3s2H79eq5BN7til26Fqa2yfLuDizA5tSomrQ/vCAeGQnRYH4utvT55uIiC
         +GFsuIRqOvJ36dSaYlHfe//rofIxStcBEOFBpYxZidioFj7PsmIo7Ax0l//TJ5YnT28t
         B8nH+FZwGA4GvVLxWmRU/xpyIPx1z/EHL4iQxEaI40rW1u1kNvsJBFfL3Y75vots/hBZ
         qRLg==
X-Forwarded-Encrypted: i=1; AL+hErGm+aG21HDHjfHab2aq+3+sUJ9HrZEeXsiZ/vgl7YBUSaEI9E5k1UMX85NPL1H7G+DUTKqGqUE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/g10U3T3YzpNmBCw2kP0YiTb07yHxdCCmu6CMEc5EqagUZyxke
	X3NZcPFaaFPwKz+54CjWMXTLamwdPNB0Qxx0IJ7k68YSCY2hCEBu1TdJ9DMHZCACgXk=
X-Gm-Gg: AYBFou1tN2fgF1YHvACX+7zRYTpVsUBWuugrh20iuJRe1LkyzjLkQTIuOEsNc3G8hJP
	degUKpS/UH75TXG4CFiIjL7A+hhu/VpfffLIU1u90rJ3wygkLQk7diWljZjkSBpdTd0Hqxvhj80
	jp/2etm+AUK7QPWjoxpXCM5PmXok53/Y6p2zAzN9fpz+IdiUSwXEyb8Wd2OIjw+hXnSJGQ+hYTq
	5uimf6ZuH8OqjTkgRRepFiTwGZqPqAPwPSFWDxTXuPSukb9m7Z1juuWvt/TKd01x8m0cWfRN3pe
	YCsv/kYLb4LlphEJpvCr+/mbhoiiI1HFWIeHRa5vsjF92AvXEdK/6U6B+1ZIWvRFtsckGQwkHsv
	S9H0dWNdjqDRt7MCl3UAKCNebZvv7yP/lvvw5OoXrYm/06UGeurwFApumMRuWE877pNh62KTWT+
	q47v4THEpQ/YKvsIREJx3SmIbKdgYqJtuGJav/NvdWzGb2KDBkGOMig4iRx/wAtTv2OWdm4beN3
	II75PmgrShJXwRQj6FiQ7biJy/ZsMoOEtjGSKsHRTUb4A2XE2kpNWX8knadothVBtu3c9ymOTR+
	tQUrvFMcMBcyEmGuA8+XAOPI2+Im8Qw+/UGzGZInQ7RAklkRaYlCJiTTzK2a9hIgS/w6QK0cKXb
	CMEg=
X-Received: by 2002:a05:701b:290a:b0:127:def:dd72 with SMTP id a92af1059eb24-1b5030f8a7dmr3833998c88.2.1794587383353;
        Fri, 13 Nov 2026 08:29:43 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm11835849c88.9.2026.11.13.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:29:42 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiwoo Kim <arpe1618@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel: ethosu: Fix use-after-free of the active perfmon
Date: Sat, 14 Nov 2026 01:29:31 +0900
Message-ID: <20261113162930.15751631-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ethosu_perfmon_start() stores the perfmon in perfmon_state.active
without taking a reference, and nothing stops the counters when the job
that started them completes: the perfmon stays active until a later job
runs with a different perfmon or none, GET_VALUES or CLEAR_GLOBAL stops
it, or it is destroyed. Meanwhile it is only kept alive by the
references held by the file's perfmon xarray, the global perfmon and
the jobs using it.

If userspace destroys a perfmon while a job using it is still queued,
ethosu_perfmon_delete() can only stop it if it happens to be active at
that point, and the queued job makes it active when it runs. When the
last such job is released, the perfmon is freed, but
perfmon_state.active still points to it. The next job's
ethosu_switch_perfmon() then passes it to ethosu_perfmon_stop_locked(),
which reads ncounters and updates values[] of the freed perfmon.

Make perfmon_state.active hold its own reference: take it in
ethosu_perfmon_start() and drop it in ethosu_perfmon_stop_locked() when
the perfmon stops being active. As a perfmon can now be kept alive by
perfmon_state.active alone, also drop that reference when the DRM
device is released. The counters are still left running after a job
completes, as before.

The problem was found through AI-assisted source code review. The fix
is compile-tested only and there is no reproducer, as I don't have
Ethos-U hardware.

Fixes: 17cdb54644e7 ("accel: ethosu: Add performance counter support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---

Notes:
    This keeps the counters running after the job that started them
    completes, as the driver does today, and only fixes the lifetime of the
    active perfmon. v3d instead stops the job's perfmon when the job
    completes; I can do that instead if you prefer, but it would also stop
    the idle and cycle counters at that point.
    
    It applies to drm-misc-fixes, and on top of v4 of "accel: ethosu:
    Another batch of fixes".

 drivers/accel/ethosu/ethosu_drv.c     | 20 ++++++++++++++++++++
 drivers/accel/ethosu/ethosu_perfmon.c | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 4a24bbd2bb..b6778196c9 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -341,6 +341,21 @@ static int ethosu_init(struct ethosu_device *ethosudev)
 	return 0;
 }
 
+static void ethosu_put_active_perfmon(struct drm_device *ddev, void *res)
+{
+	struct ethosu_device *ethosudev = to_ethosu_device(ddev);
+	struct ethosu_perfmon *perfmon = ethosudev->perfmon_state.active;
+
+	/*
+	 * A perfmon left active holds a reference, see ethosu_perfmon_start().
+	 * This runs at the final drm_dev_put(), possibly long after unbind,
+	 * when no job or file can use the perfmon any more: just drop the
+	 * reference, without touching the hardware.
+	 */
+	ethosudev->perfmon_state.active = NULL;
+	ethosu_perfmon_put(perfmon);
+}
+
 static int ethosu_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -367,6 +382,11 @@ static int ethosu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = drmm_add_action_or_reset(&ethosudev->base,
+				       ethosu_put_active_perfmon, NULL);
+	if (ret)
+		return ret;
+
 	ret = ethosu_job_init(ethosudev);
 	if (ret)
 		return ret;
diff --git a/drivers/accel/ethosu/ethosu_perfmon.c b/drivers/accel/ethosu/ethosu_perfmon.c
index 26f625374f..69c0967f87 100644
--- a/drivers/accel/ethosu/ethosu_perfmon.c
+++ b/drivers/accel/ethosu/ethosu_perfmon.c
@@ -54,9 +54,20 @@ void ethosu_perfmon_start(struct ethosu_device *ethosu, struct ethosu_perfmon *p
 	writel_relaxed(mask, ethosu->pmu_regs + NPU_REG_PMCNTENSET);
 	writel_relaxed(PMCR_CNT_EN | PMCR_EVENT_CNT_RST | PMCR_CYCLE_CNT_RST,
 		ethosu->pmu_regs + NPU_REG_PMCR);
+
+	/*
+	 * The counters keep running after the job that started them
+	 * completes, so the perfmon can stay active after that job and its
+	 * handle are gone. Hold a reference for as long as it is active.
+	 */
+	ethosu_perfmon_get(perfmon);
 	ethosu->perfmon_state.active = perfmon;
 }
 
+/*
+ * Stops @perfmon if it is the active perfmon. This drops the reference
+ * held by perfmon_state.active, which can free @perfmon.
+ */
 void ethosu_perfmon_stop_locked(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon,
 				bool capture)
 {
@@ -73,6 +84,7 @@ void ethosu_perfmon_stop_locked(struct ethosu_device *ethosu, struct ethosu_perf
 
 	if (!pm_runtime_get_if_active(ethosu->base.dev)) {
 		ethosu->perfmon_state.active = NULL;
+		ethosu_perfmon_put(perfmon);
 		return;
 	}
 
@@ -94,6 +106,9 @@ void ethosu_perfmon_stop_locked(struct ethosu_device *ethosu, struct ethosu_perf
 	ethosu->perfmon_state.active = NULL;
 
 	pm_runtime_put(ethosu->base.dev);
+
+	/* Drop the reference taken by ethosu_perfmon_start(). */
+	ethosu_perfmon_put(perfmon);
 }
 
 void ethosu_perfmon_stop(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon,

base-commit: bafda823590ddf7031ecb765d673572fae7ab44a
-- 
2.43.0

