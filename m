Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E5B1C5F13
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439309; cv=none; b=E1wrjzlyj8AydVNpgnY8LvO7mMxapsWP+r8kcbwF4PU9XlqH9eAQfKgxSfJG/NEsiC8YVS+cvcRjGk52WY4y5ElH4l2SKH3hViaNhDJykF1msJraTd375b2xyPD0MtFFjSA9GpUaBHLD5v91cEavXnmQVNHeuuIIZEvYu57SSN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439309; c=relaxed/simple;
	bh=hCG1aonoDqL3VPxWXb5AJsXu8sZsT0Fdbgr3773Yh84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1ROdfNrtGBBW3DMqY+1xu4AkROvxg5t3//mgpEcmjwL12lCa8zWhoDkysNPZELpdoPQIxQbEvVom26ITL2Vc6QMQLtahGnhofs6EHw7DdKT/DZdeyuYtfDX8AmxEZCkB+BzNeRGYjgldtP/7Wse3paYQ2FUI4c/rP4v4sTrUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de; spf=pass smtp.mailfrom=swine.de; dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b=hVwR5JA/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swine.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b="hVwR5JA/"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so18745975e9.1
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 15:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swine.de; s=google; t=1787439306; x=1788044106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IhHei1VKoqJ0zzoYbfccvAVZfX3h3oItEz3B+qvlJrI=;
        b=hVwR5JA/oZclbfD7teot8/7cPg/dRcJf+2y4m7LRPnj3/C0xhDAb8St1TxrNOpu+uG
         zFB6A7O75RliKWXIHPURt1OdU5b4ksGaLllHomoZtL2vlvFJBK1uwpKooCaHyo20tMzm
         YVxN0nHBCUJdhAFuEQGKrUmLB0UMa82dfPV3fI94sHK0qt4D3qWR7g6KPQDo5EbfpKQP
         FSDxh/mlJ+T9Fv3Q/OFdz8Iog7/5criErgt8GDBChw6FVzRLYOlDmKIhrcIHvsOW8D/M
         sGueRKZwK55x19BEedDIY8bhr+ihON/rSvB4LupkUokbwr9ffrhG6fy18ZMP2LHZe95O
         kigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787439306; x=1788044106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IhHei1VKoqJ0zzoYbfccvAVZfX3h3oItEz3B+qvlJrI=;
        b=LdhiArh6xFawMlss0hVR7Z1D3DC4VSpsfVoQMYyj5CuIInQ66MOgd3Tuse0A2jPlym
         um3ZENfW1CvFizi9CaquXY6jMogypg5QKYViNXUfZV1PBv8fRKuayW5ocU6b6liswRGP
         eoo+/6ewrQoNqys7ogy6ZtYazL9LBPM1poADHx/s52Dq4gXaMw7rQo89r/WPFsC2GXPn
         GaaGJDhUrJdPZ0u8L5mBl1HlB6dcu0BRjhH5umJOjTEY0R0v+zoegslYOtS56/fP7bbr
         YsGaxWQ6qXmmTVph2H7wlMvCzPPlppcs2d++icyh/DP+0zzXFAsblx+7v8f2GWjIYOla
         O7wg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7PTUPiUvrdkXDV2vvd1ca+0ADH1tU36Y5XUMBGZYE9a6sqCw/yxF/WP8y+S1Ss/+Yt8/gC6c=@vger.kernel.org
X-Gm-Message-State: AFuF++lZFXmZvWvDkC6UA7PA77g99KjDBiFAUX83eEgyFYnFB7o9bRzD
	J5gI1mCy1LV96dGvRTDJ2RnlB3DyTtHDAvFM3NIG0s/SyzslsV9rs1nevw7I92dvbfw=
X-Gm-Gg: AR+sD10PyX6KVhxni3ouK3j3VaCUq/XtM/Kr9UIltyI/n24Vkn/1IOQtgD+7gveYGT3
	gsPSaAdC2FmXk4u2cKpwK38HiOR31hEc3zoEZiHwm8NjyD4fN04so030I0NKorWz3PoFCuQCPNy
	jF+a4HLIbD7olk9hvl7Jrv8KL17wzvyovZOiIsykeziZgp9WDe2Ix2U2PzV64QhnYexHkGqD47w
	0jHkDs8la6eMliDTvC9v3j7b709z2UCwrMTi7SBz7dEoua/wXmF3NCWbbVkuA9gYXCmnV53UTa7
	0Z97QrXM8GbaRBVGraoeiXN23yo1hy/C5omu4OYRi5JugB7eFp6IeIUOhISKYyqX918gr5lmKWC
	0pQX0WdmNul7QgWYJTc8FWRZg1m7ehdtIy0oCxOJL2n1A82HlpQCfd6C8mfEaqj056VBbcGVk7C
	I68pSzC9FcG+plLNwDssQcNwLFa78KjMWqnbwAccZusZnC3dvFYnDAwe8CRys1EFvhmowH72ZXi
	jpsg8l8lIt130w=
X-Received: by 2002:a05:600c:4688:b0:499:5f80:83ac with SMTP id 5b1f17b1804b1-499b91ad940mr124259265e9.7.1787439305687;
        Sat, 22 Aug 2026 15:55:05 -0700 (PDT)
Received: from christian-gtr9.tailscale.swine.de ([2a02:6b67:d11b:4200:385d:79ca:2b97:1169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9ba5139sm41376435e9.2.2026.08.22.15.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 15:55:04 -0700 (PDT)
From: Christian Simon <simon@swine.de>
To: bpf@vger.kernel.org
Cc: Christian Simon <simon@swine.de>,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	tj@kernel.org,
	yonghong.song@linux.dev,
	stable@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	olsajiri@gmail.com
Subject: [PATCH bpf v3 0/2] disable private stack for sleepable programs
Date: Sat, 22 Aug 2026 23:54:42 +0100
Message-ID: <20260822225444.2774461-1-simon@swine.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A JITed BPF program can use one private stack per program and CPU.
Sleepable programs can be preempted, allowing another task to run the
same program on the same CPU. The second invocation then reuses and can
overwrite the first invocation's private stack.

This patch series disables private stacks for sleepable programs and
adds a selftest covering that stack corruption.

---
Changes in v3:
- Target sleepable only.
- Add the powerpc Fixes tag.
- Split fix and selftests

v2: https://lore.kernel.org/bpf/20260818203234.1142913-1-simon@swine.de/

Christian Simon (2):
  bpf: disable private stack for sleepable programs
  selftests/bpf: verify preemptible uprobes avoid private stack

 kernel/bpf/verifier.c                         |   9 +
 .../bpf/prog_tests/uprobe_sleepable_stack.c   | 165 ++++++++++++++++++
 .../bpf/progs/uprobe_sleepable_stack.c        |  89 ++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_sleepable_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_sleepable_stack.c


base-commit: 75b0a6db4300e4c2c9e97a0848deaa7acfb42fb7
-- 
2.54.0

