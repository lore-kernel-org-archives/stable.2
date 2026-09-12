Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C245839022B
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242964; cv=none; b=fXk+JWC0vtDrtqUoePtOfRySOupzK4orcWrvMYFCOgfrZNOuED4Zimb1PeWwY+hrygPDUGnyvQ9pkPhJp4sHyU6q354N+7oXHhDe+WGZBCCEtPvuWuR/UhagsGrlQWJbxBjQrRdBR/1gwNOoyGpno8fjMo6Px8RQKPJ2lBfBfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242964; c=relaxed/simple;
	bh=ydcLswhKfW/cDtNkOWt8BaQY/wFqG2LFzkg1wf5qWnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iLFE9yUdHQYzZ2H6blY3EA0PK/mJfBfaxtDhF/4XSVWlrErWjO8k51fmLzKxzybF0yc6aRflHzan7C7VA8Uh49NgR2J2oXEY2NaJdxVtBkYaNtK0/p/9yVA6Ql1wLhoUnbQjHGoQDRDO3Dn7eHq2NGnasUh826BjV9L569Dk2AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXPnXHyq; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXPnXHyq"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so5785235e9.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789242959; x=1789847759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YxuvUQU/wvk/5tAU7GY5bOYjzHhQjt27KLZg5QIEMsc=;
        b=OXPnXHyqT8TSd6WHO1Sh+BRX6B5gnM0LoQ3fTaQi60uoI3Z+pS3oHpKNFeQctabaCD
         jPjw9ydOVI9x1mzRh5dyNCrtGJPUbt4e1bUdXz9Lar+4LEGvt5tdFQCStMU0rNp01SvP
         D0R4+/jZ0mQ/RLikXSU9BFrKI0a0zDNPCN/Klbl2oncgzcuvMCqqMoO4YI8QUX6/W0Hn
         Kku3ETDBEUjYhFbr2c6fFJHIP8lOHwRIkKH8iEgCNX0349JEK8tFgVlAIhqO3Itxiicw
         0p48WH/KRM6sykqU47xIPE0w/ySTwaQlpvjeoZOEGvk3PDDAcucb0N+aNlOIhjUq+tnf
         JCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789242959; x=1789847759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YxuvUQU/wvk/5tAU7GY5bOYjzHhQjt27KLZg5QIEMsc=;
        b=qw1lNzdtrLHB7LaHIeNKRO+tI7oCvxl2NuA1JUnrGwouv4k3b/FT0l2MSNvs7cWL4y
         7+Bq5wpAREcHNXr/Tux0MgjFRE2TOJRUl7PWvX/c6cU9oNq+LwmggZylx4lZjdR+wEkv
         HVYsHNS5zHltcK07g/jlIRbaSWdgWSAPVSu8nTAYKJbLGivC1Ovsn4zoQBFo1lDNnfk4
         P7d7WOEsAALX2GqlY7BWlEjPq7oxr2IY0svBrE80MfH4r0MGt1/k8Xt4ikLcAhlyNTe3
         Eaj5VWaA82rZEYt9+ple+vrqlMgDsSS5eFNULAV7rqhsMIMTDwic1w3NeS+LG5qMTOZh
         g2BA==
X-Forwarded-Encrypted: i=1; AKwUvBxcpOxSlYRuMzW9azGY8D9aOQVLGjYZCI5YT1YM9RYf9MNxOygBOZ9Ay1JMXfp5EN5lfuZ9tPE=@vger.kernel.org
X-Gm-Message-State: AFuF++m5cGo91LfnmCqCKbsQllCnJqvTuatOk1V8XZkEAY5uLRFUzI63
	LUjRgE4CfWICRYpT6TJ5k8O0mQFVafI911nJ+znT74eDGPYSB1wl4ozH
X-Gm-Gg: AYBFou20CABZkT9+yiOxEhlWht2y4a769SgXSToM3aPD3xfjigHZ2ij40dJxplvZzNx
	68on/rREnJFkDg872ZrDbrK5EXG1HBaKY0NDzJ3mlmUoLA3V3zwYDooBHDLqygVKi2+6I3buCbg
	CLQzWCQ7gjrGH4MtVgr9ww4ib13cH7bngU8ACoW19V+TzXjKmEstiCHy+AqT+H/XD4tfoeM0amX
	EWnyoe2mEm7IVIClrmS+RGPPXAMbz9Lmk8Ed3A5NcDjSPwyoiBaaTtlqKaAB+esNowZOnjLoAn3
	DfGVYsJFqBu6FUze2OVaio1b72Xn6rDq2UnmdBFiga9Ba4jxazcewHtCIOkwOzG/MvpZocj86au
	HOmyXBGGHRmOLua0wwxY82Y6edVUODRsRPvcE+6rSp8QgtNHHVaajBzxY1iFQMAIioyTISyoEFk
	1OoqClc6+7hZQnhNdCrX4J8zqB/akqsVcRyoKQynoEHSv+mSKrSLXLuwOHlG6ruyc2y8lShEf8d
	hWUh7ZmRw2eSsbu3kElAI6m0GLdlLDV76qoPGbRqyOPD0afD5aQtGXzoisOGq3lOhnSi6D0XbNQ
	hrp/PFAT1v3VN3xBPmSQo6OpE8R7KwPe0YqsElcnHzua5ndlJpqrYjwN5JMqqIE4Yq02PQYG4oL
	0pKpNBsn2W5KJwry/JA==
X-Received: by 2002:a05:600c:5249:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-49e6caa782cmr34402295e9.5.1789242958359;
        Sat, 12 Sep 2026 12:55:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm267089045e9.14.2026.09.12.12.55.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 12:55:58 -0700 (PDT)
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
Subject: [PATCH 0/4] ARM: allocate the cacheinfo early to fix the PREEMPT_RT boot warning
Date: Sat, 12 Sep 2026 21:55:48 +0200
Message-Id: <20260912195552.76673-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves ARM cacheinfo allocation to the boot CPU to avoid
sleeping-lock warnings during PREEMPT_RT secondary-CPU startup. It is
based on 5225b8eec4c9 (7.3-rc2 plus one day).

Patches 1-3 prepare for early allocation: bound cache-leaf writes,
include external caches in the allocation size, and guard CLIDR reads
on older CPUs. Patch 4 enables early allocation. Please take all four
patches together for stable.

Tested on QEMU virt (Cortex-A15), vexpress-a9 (Cortex-A9 with PL310),
and realview-eb-mpcore (ARM11 MPCore) with PREEMPT_RT, plus non-RT
virt and vexpress-a9 builds. Cache sysfs output is unchanged for the
normal platform DTs, and CPU hotplug passes where supported. Additional
checks cover DT leaf undercounting with KASAN and ARM11 DT cache
descriptions.

The full series also passes on a Raspberry Pi 400 with a 32-bit
PREEMPT_RT 7.2.6-rc1 kernel: the boot warning is absent and all 12 cache
sysfs entries match the baseline. CPU hotplug is unavailable there.

The series applies unchanged to 7.2.6-rc1 and v6.18.

Karl Mehltretter (4):
  ARM: cacheinfo: avoid out-of-bounds write in populate_cache_leaves()
  ARM: cacheinfo: count external caches in early_cache_level()
  ARM: cacheinfo: guard the CLIDR read in populate_cache_leaves()
  ARM: topology: allocate the cacheinfo early on the boot CPU

 arch/arm/kernel/cacheinfo.c | 49 +++++++++++++++++++------------------
 arch/arm/kernel/topology.c  | 13 ++++++++++
 2 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.53.0

