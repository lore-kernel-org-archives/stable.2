Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A492E3DB62B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508627; cv=none; b=V1N9oQtNguimamXHk3xgNIVeMDPo+/lgSeh+LEGSrCI/fiV28SndKf8KZPNCa1hqT7NYhYL/cZSvZosF8Qaam/CBvCN2i4GWrvOWRg/bwuCszfC4eHlgpbDJLD5+qlKmjkmjxSPHClEPzj2TAxNARNdHDdZXr7gDoJnnEoUnaI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508627; c=relaxed/simple;
	bh=aVDnSf0y+hMXWr8hLybg6AD3WaQCpewMz60QImDAXo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jS2Do0YvfBe9FwPp6BZFmn9jx+u/qAiQGSwZeJYvegET5FrvUVRZFoVeiySycCgiTJxhX/42RpojY32pNLKlRdFVBWTxShT5P3TpdWaFX1OKVV0arZ1Q+G/TX/OT03JyJAaNzadRkbtSrAv+gKWdSXph7yxQQeJgpBdTLg/hxEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amfyVfZy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amfyVfZy"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d590f4c291so1768335ad.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 00:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788508626; x=1789113426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jWQHmm7FHocENum1rYYpf4ViVc4iq1jYrch0jAvV5fM=;
        b=amfyVfZy/wGOpn8p40yB65QgXV0kAEAn1iPbjWRERHkGEpYVPRxeCzWM4ceL2UbDvN
         K6Y8zgW5xLn1sDMI/GtAgKFT18bTmtutXjL5B48CagAeGpc7qpcUgCgjiPduFAeFTPeU
         hP8cg0kxrDVAOri6YXGGl+aYJoAVRC0OJHlKY+x1i9+wlSM52tORn56n0Ojl7olu135f
         jtzzRN/3HrVfPR99HbfbGl0+l4EVDLvwEvt0YgNovz+pXufqqyxxH6Tubt8EmRD+X1MY
         IvJA7pyFkVJFMkN4di5aPOR7s7yHxMkIOV6nzuU8WFu9z8/8HIZQJTdPHQbB4vYzhZIC
         6tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508626; x=1789113426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jWQHmm7FHocENum1rYYpf4ViVc4iq1jYrch0jAvV5fM=;
        b=UlV33mEr4oix7aOQzKBywdn1oZJwv0mBmgpxfEzlJVuCI1VqDlDmuz5jV1fQ7RGihw
         rycw2CHQ3mCVsABurSAtVj1R7eOZKzzENaRsP/XcfzK9dODkQV9iL04KIRC3thg6DwRH
         Ym2GzCOig3cL7Wgjn/Lv0OnmS3aGASrmNdV7qHpcZmxqku5ghsgFq/CzeJuBj8STUHCZ
         lv0cMeMs0fVrprYY2givhCssyPXT0n3oZ/q/xfzyue+e4+NCROEufnBoe7Muy118Ul39
         DhkNLoGHDTCbDkf2CmkiH5ghnzu46FssrnXPvkrXYx2GGMkFqUfJYsJfr1sRaj+wlxQC
         eJcw==
X-Forwarded-Encrypted: i=1; AKwUvBx58s33H2R5MF7XwvmIR4HP/UMraiNgKjOmfJODh5onZSXWcaHzt2iSmCjTyYAbpI9NJMNL/bs=@vger.kernel.org
X-Gm-Message-State: AFuF++llFFb8lpEIjWbm3t9cfSHS7d+92MUjrddTpkw9wAtnTChJP/co
	04nDdc9+D1ngszzox4mY20mSV0cwyWpqkfazQmXL86oinA1ok4V0vAwB
X-Gm-Gg: AYBFou0G2l97QW2mCfvgrb4KQTAglQVs038XA79VBXinueS5tfChD1Vwyfp+PYk5c3m
	FXIUj0kC0ZuvlY/5fbyoe7IMcrSu7qNJvOy90+42wPnLh4KcrjI2Be+c1UkAC+7je3WhM6P1coX
	lQ9onhoo0yWRHUfNTa7dc5We54qSHYgqALNNPAvod3Bm/n6Nh2iZqU13v/bXhsF2b2ypbXln2V+
	zllp3gTVaQiCLPUQKRORmY/7xwfspoEtZ5tXg6elJ6z9UxUIlCdMYdBJ1CCxsKH5nb9j45mD9Ec
	alv7JMwe0DY84T1lEDaGvJHco2M9DZNuKqwfo4aM0Z3MxPwSi8tl3DPgfc5RGDNKFYWpSMd6GHX
	DLEizB3+Q+y/a4FZohS9/jKYEe4j9Jz6L+jVnlcLYV+rg3wPNvXjlxVcMLkwr2/NO0ZnbVCtkKm
	TXu3Z62+uGyqTDI58L+laL8xCtWS6BsE96bPt9NYr/n5GU3BAB1cOiFPuungyZ7K73PjeISh7FB
	SVjJvOgYavkbw==
X-Received: by 2002:a17:90a:ec85:b0:398:bad2:c10 with SMTP id 98e67ed59e1d1-39b26301360mr4300158a91.6.1788508625750;
        Fri, 04 Sep 2026 00:57:05 -0700 (PDT)
Received: from fedora (45.62.127.193.16clouds.com. [45.62.127.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b261549f3sm3139517a91.16.2026.09.04.00.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:57:05 -0700 (PDT)
From: Frank Zhang <rmxpzlb@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] rust: rcpufreq_dt: add module alias
Date: Fri,  4 Sep 2026 15:56:35 +0800
Message-ID: <20260904075635.14840-1-rmxpzlb@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing `platform:cpufreq-dt` module alias so that the driver
can be automatically loaded when the platform device is registered.

Fixes: 06149d8f2216 ("cpufreq: Add Rust-based cpufreq-dt driver")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 10106fa13095..32a508d82f68 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -219,4 +219,5 @@ fn probe<'bound>(
     authors: ["Viresh Kumar <viresh.kumar@linaro.org>"],
     description: "Generic CPUFreq DT driver",
     license: "GPL v2",
+    alias: ["platform:cpufreq-dt"],
 }
-- 
2.55.0

