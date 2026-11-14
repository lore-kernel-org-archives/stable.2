Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794644425;
	b=bBEg++ADVvRVEyUndzede+HXgmZENrmLDvY2G1uDxxJ56ICjGJNYsdh2rXH9ZJUYOPAl
	 2uwWNR72lwo5YLPp70B8IRkNEdFBF7+Esz3JDMMBmMht6WC4qhkDMKwJFxMEUPfGIclr9
	 BBiUlIHVWnRkuvlX6wFMnzlY50IshMCUFV5k735k1/tUrnOY9Lqi1QoKiurdJ/2NJeLwb
	 AP/t4iiYUBr8KppwCYu1dN+TOedERS6YoPX0pzW8TkWvpPWrr7V9jlmAyroQ7TF9sdMRK
	 FWmWkARQ+VWQ4/vk98XzWlP9JI63LDp1M/rqyS+T9XaSltfnRcbShqaq/bv1eCKv70w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794644425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P7gyRMTycBiU+K9V2+iRGyig/k7M3DfU55SoQH+FP34=;
	b=LYdGt6sCZh6GwaR0s1yK3ptBTnTBxfxvboqwj/AkJojP0Oyo8JR+jEG5d4kt15L9Aat6
	 0qMt4/WrbsvjR0GkLALogxfzHSh+WwzW5G3+8CCWlAFiQJsP2iEQkD7jVaiuOuRJ2DW8m
	 whe6R4ekQTlbXFQ7Dzgi+BHcLzQcJ3okpme5eZ8zQqbjTWl+vOd1qlSWI87JQV/fwO819
	 qP29tmSGEuRZ2wqlFZ9dof2UBxlSBqmDrZSazNJGY5xAeIz7syaw0wUAM8Jphrkc8QRBW
	 mLMjlRohBHH4vzd49r2+LTXyG7onSnhORzYzoYT0ep3zbiP3epW1SmI8/pofoQaJ/lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YXwsV58F;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFF7606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AFF7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YXwsV58F
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b50438451fso35564c88.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 00:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794644424; x=1795249224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P7gyRMTycBiU+K9V2+iRGyig/k7M3DfU55SoQH+FP34=;
        b=YXwsV58F5OCe5nykTsBpkgiAusI2SV1WeNZE59WQiM0ekPKwTITeqvXyO2oPM7bh/u
         gxcPOvQ2pdMBWaUwbIp54Stp0jNOt5vtoaIcpmKh1XgYp4B/J0boCKwBUIcsBlRkrQjk
         TS9G0TllG3CwG1z5H9n6kUG9wnfD7g0DCYQqPkEwS7iCWJ/+xz0gwDH8OjIFVq79azNU
         8McCN7o0lbXj/wtQBArYdJyyzJcB+FBZz43vRPufVihMkJFQBDuzY2vPrFVPOgXKLsV6
         ldvFm2PXAiulRlJKMlUDI5oRMD2n5uTweVpJzG1QGr5p7pG2fy6WTJqDRsgb8H5Gaq/P
         ZtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794644424; x=1795249224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7gyRMTycBiU+K9V2+iRGyig/k7M3DfU55SoQH+FP34=;
        b=I1CRHOLiZa1/IcCP/ftQoqBWx0cqJuk8NfGArhyh6aUS2b1ywPE9Am0CoxjWDkOw42
         O0Js819quPPHmoFaWddUd5PkR7DBUKVcTRNrmJgLe1jdCw8tUULOmtMImU50h1168Lph
         n6cOtSqYpEmH1IbVd/xi51FD8ucA6v0gIzIl0TuqOS0YP4AeO6jLJao5L4xJoa15saYf
         eUrChQQab1TbSy/FAdjmIUDu3V/NurcB9YU7qWSDRGsZ1huiNI8Qk/NsPIFn3CP6x5ul
         eSurAtmOMpDlWwkj2M+KYdiexyc3VWQ+pQHHza3JC8ecrtmaG8112At3wBOVJbGM+oRX
         rJ0g==
X-Forwarded-Encrypted: i=1; AL+hErFefAGYItZDye2FLHS7rbjLZQoHGyw1FkJ6Z+utzQoaBD/BEvmPu94qMs6PRuGVPEk9aIj5RjM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NyPrMCBKaQNmHjjjQ+OpST04my1R7yac+QF0jNFu4I0hc6Yzi
	DeGQSvdRQNRxEfgZlGTytqWK/0YUge4/xWR0g+U2+JcIUrY4ey/Pxyh1
X-Gm-Gg: AYBFou19XTx/7Xhjli4mrgjpcRDLB6CF8KllymfWy734iIQhttMY9ZypQ43sVLLV3zw
	5r2W5cV745hvf4O9UY4qeCh7sjAssjVk5nBs/q5DYj42ddthk9t+CR6t+z75xitNb5kxytAEQHj
	nx53MfRPVGarwogItG3ZrdrJ5d4294L5jbGmIhNtiujUCk0dZfh1tyD3zIzl7v8AM5apf0iUrcs
	K9AuaSWwk9ZjbZ294f4u0zNH5VExHrO6IJ3HrGQkhl5+jmMEGkJglrC0XK4hueTxcdG4sJoA+aO
	8O1HuAFaYrrnZSw9gwiWMA7kOig/6Lh/fVhz+onPb12wPISOmcl2QO9sFjPW58pVBplzdN4JvqW
	Yn8mbDRfTkaJjmGrnQjGmqSxn8Ja9fC1M9yqZcHyhzZaJXR6VBzx0Q8GdA8lHusmJo77da6AUJO
	WpCmFl3KjlwcrIXcsHNFfs7ZqRmo/S0xPFbELrD2mGsp5QwExf1KCl45/+0iGk/UkyLUoC+XDry
	hDOm/uoeerT5Xa8W9+C6GB1zwk+eZBo+VVVMuezyMtUxfq1RO6iJX6aktY4ZPh7kWvyE8QE+W61
	F/9rugocrA+oDffjVQUgVCZDxlnrElgU5add7cFE8/VkfSZkF7/1kQkw5iYqcAmG+MtMtbKbKHf
	ISqx3d6PB51Qp6CfsBAYUsOPSWQ==
X-Received: by 2002:a05:7023:88b:b0:16b:4f52:a08 with SMTP id a92af1059eb24-1b502fe08aemr8181038c88.0.1794644424293;
        Sat, 14 Nov 2026 00:20:24 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm19524043c88.9.2026.11.14.00.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 00:20:23 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/4] drm/panfrost: Fix jobs that outlive their JM context
Date: Sat, 14 Nov 2026 17:20:12 +0900
Message-ID: <20261114082016.2454-1-arpe1618@gmail.com>
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

These fix how jobs are handled when their JM context is destroyed,
explicitly or because the file is closed, and the error path of JM
context creation.

Patch 1 makes a job hold a reference to its MMU context. Patch 2 makes
panfrost_jm_ctx_destroy() find the jobs of the context again: it looks
them up by job->base.entity, which the scheduler clears when it pops a
job. Patch 3 stops a job that is queued after its context was
destroyed. Patch 4 keeps panfrost_jm_ctx_create() from destroying
entities that it never initialized when it fails.

Changes in v2:
- New patch 2, and new patch 4 for a related issue, both reported by
  Sashiko on v1.
- Patches 1 and 3: changelogs updated, as panfrost_jm_ctx_destroy() did
  not actually stop any job before patch 2.

v1: https://lore.kernel.org/r/20261114062637.2447-1-arpe1618@gmail.com

Jiwoo Kim (4):
  drm/panfrost: Hold a reference to the MMU context of a job
  drm/panfrost: Find the jobs of a destroyed JM context by their context
  drm/panfrost: Stop a job queued after its JM context was destroyed
  drm/panfrost: Don't destroy uninitialized entities of a new JM context

 drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
 drivers/gpu/drm/panfrost/panfrost_job.c | 91 +++++++++++++++++--------
 2 files changed, 62 insertions(+), 31 deletions(-)


base-commit: d48ea86919434695da12d280dccab72b094397e1
-- 
2.43.0

