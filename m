Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454A318B9B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970429; cv=none; b=Llr5VWefe5S1DVXkWJNQamxA8c8TbKH8TeT3+u3DyYCgz9nu4aFtTjtAZk3nVHb7CSZBFxYtFhF0GriNL2EBwXlBpBCpnURCqUrcpFHMC2QyzvteEL0Rlh7mTQ5gzN0VOvr6b2ap3GdJ0KZ1ItlgpVIGu1L58mSzTmMT//+79Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970429; c=relaxed/simple;
	bh=02+JiU6Y5fZuqUtj+5rjMFYK+DHyYaQSZA1fayM6koA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GiD+kg0vIrcpzno+onau46b9x3UNkgj5Etj6vP192bE254BwRM2o4HdKsdin7SFmev+KKODR/75GgN13TJpyCr3nKRuzh+NERhCugpdrGJ9V+Ur0SAfV6sMKNIgVfrHJ2SsY/PFTmcOJYHt8ikYgyJ8/GPQnPUTsLcSouehFD+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJzYmdyw; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJzYmdyw"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so12530045e9.1
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 23:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789970425; x=1790575225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JbepAso+XoZVkbrUUQwUCzv4bigxo9mSvnxXnLcpRMk=;
        b=jJzYmdyw/YwoBmYH4VGolOr1qwwI6iGTePA8LbOlYWbIQqMYY3gzmVtX4QtkZhpE+a
         WWKyekbqndMmMlJlYElo0gAOhIKopQGK17ATjGAuiGPKTWlbVpekc/3bLwFjIMR+9cs5
         iIvNXNVtLnj1YhczZ0llFF7Gh0gJXcHpIVbSoAx4qbYh463GIOPxYgaht/wqD88lDXPj
         7Kkp97CsYEmxhb4GetMnSihfyIV4Z4AcBkY3qJumkQ08VLI9KA44T5cREjmnXOCin0k5
         w3ZwkxsoglQKaI86CIUuCEP1fjpepoK6A+R8q1WKKGVtVKJsAUgesbTYSNRtt+1kRv29
         1OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789970425; x=1790575225;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JbepAso+XoZVkbrUUQwUCzv4bigxo9mSvnxXnLcpRMk=;
        b=svGePxFhU+xVXuWbc/BEZR8ZP8fnK14Wo92hRpjGOGyzh+KpuFgLzI3UTc3ajZac7Q
         8+V4Ybg9lJ4fNFv7lXhG/bH4HMY0qjReldRs8LwAkZBSuJuEx5ypCezAfQU+H2faf9rF
         OZgZMY3tXGOwA5Rq8S5SjEaFdsb+/mRWUfMazydZG3NwIPHq9rzv01Mf3Lcyc0WeGHce
         Eap6LtmPRKpDbBLRoeWZCwrsgICqrGEsjEjHF8K6ijIT+AQolFl+LfcrDPULb+49Ofj9
         NgkIzZeiitoWtxg1MuJISeXVSff/jMiw/en0pVxEmwFpH15Ju4WFUb07IchVk+VF0cWS
         feBw==
X-Forwarded-Encrypted: i=1; AKwUvBzZfWIRcbosBTIYxAo7jN2hLu2p/JKSyac736WgjIheyzm50X4gIHtGObmlAw/KLIX4/iOxSWc=@vger.kernel.org
X-Gm-Message-State: AFuF++kBypCQSJ9fpJwzIdQ2NeDEPElcIB4vrYI9QiIwuL9uNgg6bmqg
	LgT4KA34T3LQSeycQ19eupDR66HujGwuu7rK32dXoXpM4X7zOzPCbvp2
X-Gm-Gg: AYBFou1U/0X7rHdW4RyIc6pXpGKmK6mgUvuYVK3HszClDgO/zsPuoEOjrfjqvH6FFOE
	PL14lGQyghf4Cb73bncT5sVIa4/lrxupLuFv801gYBMTnLwBbojAAGRJ8SjAPzKC5edTP8fHC7N
	XRP0JL0GE6b57vShDryLC6rafNN2zSt5og86/txjnXimacwO7/2x6YU6GdLs6J2Tf6eFLcZMBpl
	YTWWgfPTiMcm9l3hnO/AF6W6SBB93+h8/nW7hQd0QBLe6fXtsnEQMZ9uuJn4yXenxZxVzbd2PSd
	IIWA52EDNyn3MepK7M01MLCtrVW3iWmIoe3ppFDqu+WFATdOr7eTFvdup9Lh1L6P6OFUvxHsQGQ
	zlZ8iYPfkp5tw7sVWpBYFwOUuCSQbwYUBX12BaKxc5PNc+MyHuBZkxwEwwsNwGfpz40zxVWURES
	kiNfH+PCpv2LESR2xTALVJAL52YvVwdSZS/iSUcyeuIiSmWFsO+l926NwCdOqCqENzYD5Y/qs4G
	JwPdYYJ41JRhfrmG/iIuVr5OecDlPj6vh1FxjgKhHAxrQ5ToYi9+yVCb43yBnWSz5dqHAuolCqB
	6L/vsSBAIIsBtgwhwIe2Xlix5a7IH71V75ukCf3EtVTv+RCsiCCCLqKFHSJanwVXZTW7Dmw7qw=
	=
X-Received: by 2002:a05:600c:1382:b0:49d:174e:2a1e with SMTP id 5b1f17b1804b1-49fc574f42bmr125925475e9.19.1789970424498;
        Sun, 20 Sep 2026 23:00:24 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8e9-c501-f941-243b-87f6-e5a2.310.pool.telefonica.de. [2a02:3100:a8e9:c501:f941:243b:87f6:e5a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd1149e0sm198706585e9.13.2026.09.20.23.00.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 23:00:24 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Radu Rendec <rrendec@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] ARM: cacheinfo: avoid out-of-bounds write in populate_cache_leaves()
Date: Mon, 21 Sep 2026 08:00:10 +0200
Message-Id: <20260921-arm-cacheinfo-v2-5892c4531ad9-1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com> <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com> <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

populate_cache_leaves() advances its bounds-checking index once per
cache level, but split instruction/data caches consume two entries.
CLIDR-based allocation supplies enough entries. Early allocation from
the device tree can supply fewer and expose an out-of-bounds write.

Count each written leaf and stop before a split level that does not
fit. This prepares ARM for DT-based early allocation and matches
commit 875d742cf532 ("arm64: cacheinfo: Avoid out-of-bounds write to
cacheinfo array").

Fixes: a9ff94477836 ("ARM: 9433/2: implement cacheinfo support")
Cc: stable@vger.kernel.org
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20260912195552.76673-2-kmehltretter@gmail.com/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Fresh full-series rc1 retest: three builds and seven QEMU boot/CPU
hotplug checks passed; see the v2 cover for the matrix.

The detailed testing below was performed for v1, before this rebase.

The overrun was reproduced with KASAN on QEMU virt, cortex-a15, using
a device tree whose cpu nodes carry only d-cache-size, so one leaf.
With patch 4 alone the boot reports a slab-out-of-bounds write in
populate_cache_leaves(). With this patch the boot is clean.

 arch/arm/kernel/cacheinfo.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/cacheinfo.c b/arch/arm/kernel/cacheinfo.c
index e1469b641780..860eeb03cfe5 100644
--- a/arch/arm/kernel/cacheinfo.c
+++ b/arch/arm/kernel/cacheinfo.c
@@ -151,7 +151,7 @@ int populate_cache_leaves(unsigned int cpu)
 	unsigned int level, idx;
 	enum cache_type type;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+	struct cacheinfo *infos = this_cpu_ci->info_list;
 	unsigned int arch = cpu_architecture();
 
 	/* CLIDR is not present before ARMv7/v7m */
@@ -159,13 +159,15 @@ int populate_cache_leaves(unsigned int cpu)
 		return -EOPNOTSUPP;
 
 	for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
-	     idx < this_cpu_ci->num_leaves; idx++, level++) {
+	     idx < this_cpu_ci->num_leaves; level++) {
 		type = get_cache_type(level);
 		if (type == CACHE_TYPE_SEPARATE) {
-			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
-			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
+			if (idx + 1 >= this_cpu_ci->num_leaves)
+				break;
+			ci_leaf_init(&infos[idx++], CACHE_TYPE_DATA, level);
+			ci_leaf_init(&infos[idx++], CACHE_TYPE_INST, level);
 		} else {
-			ci_leaf_init(this_leaf++, type, level);
+			ci_leaf_init(&infos[idx++], type, level);
 		}
 	}
 

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
