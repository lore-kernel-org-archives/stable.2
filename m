Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665944;
	b=NzhZHI1hK78Ahy065Oerhtl4OBvUEH+NJmLq+LBJtuJobXtrYteNMKoQElS7noAg9vPU
	 nXX9G+JeasiGrOGNCGfbLxuMuanG1Kbw5uTXdEJqlaCGOnW8X+k467loX7PGjDwn6wm5F
	 T97g8mD3nWtc0e0jw4ohrTcW4Dvm/vOTn21daj++kffTthd9nK6q7IGXilYqV6FfwkjCW
	 cZ8qFezb0snqmCF09y3rWm4fcsjPxIYi9OTusHR3AWTBp1BeGuOx+QfqLxZnzx2Hpf02y
	 oFZ2Tndd4UhMDIJJVQjx2mjEUkC0QAeYqiiVtxxhgBf+nP5TqN1ktMCeMdt4OXrn7bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=994O5G9ZxUQ8jqNBdTBnXMOuXg5Iwc5e9f/ldhdma60=;
	b=x5diMVa7i+ZCtr/cJvj0+aKBqacR74R6lkZAIu6NXE4tSStbM49FTW5QLGR9APh9ELch
	 kS2cC9v6HbXB6pVbdjc73JM9LhJH1F5C/odsZjdK28gcaarsaiktUF63cxz1e2BX8fo4/
	 zURIRWLiO0WnHDDPWzrRxzOlCUbm+HOIYGedsOplMcMF4x+hMM43Vv68y1xvf1763OgZd
	 AUwTP8dLNq2JEghKyMHHL0uc7eyb+k2DxGUU2WC4/Ha5pj+nozGvXVM4HejbEzu03S7RA
	 qQ87sIjyRVv+Qx3jeYfMGWk77gxeus3wMyH6S+1GQwmkLuqqZ17I11I5AplXjC5Tmsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="U/UIVKlY";
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14688606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 14:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14688606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U/UIVKlY
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3719e3cb82bso228725eec.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794665943; x=1795270743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=994O5G9ZxUQ8jqNBdTBnXMOuXg5Iwc5e9f/ldhdma60=;
        b=U/UIVKlYNtUJHaFeYSNk1Squ9DtUOMUNBXdocSmtTNj3Rh8h2BTlPE023tj183unzW
         6rk73stKj5FvDnaZsppNJ9tBZS7Gx8wAgNd0R7kTSE4yXgLBYi/4V8IZP1vINPyc0Ixk
         byUHLZUWhxbwe5kOoRV6Hh0Jon41ww9LO97285jbq0ZSNshA8tYyd7HNDyi1spBFf5x7
         c5XrIarqjsLqUU8nU7V5Xz26PL1+5FrLzjRD55NgdkwW3IgFGkVc8DTedWn9Vx66GYr8
         F96fSBLB9mekI/6Q7p6I3gzZCo/VgzyqGat0jF4onF4ELPVN2nuzwIn6YaNE9g+05VcD
         GiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794665943; x=1795270743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=994O5G9ZxUQ8jqNBdTBnXMOuXg5Iwc5e9f/ldhdma60=;
        b=oLbr9750b8VP+JjQc/s9gKVGg1jdXHV0uuP74k+Hv2Jh2JKz9i9lGIx4M1GlFoW8pj
         xz4ItDWfIdYIhzPzyxtyg28CeOPBROjnnGeXVnCOJWsaKGi0Jc9NHmCYx7gNp5DFM491
         CxljdwwpsShnEk80MukXAzWGtWuya7nun4fWRvVssYWsTsLfFPZiEKZVd4jAfSLrYkpe
         lFF/ufN7oDhh859aONNpsUTdtbFQd4CdtcruILhUNjUySgwE4TRiLUisXZejpajsQpLG
         +hCsBExf3hyq6iVC76kLqnKk8d1vntUy40+UFwGWagR7OAJ/5AorJc12bYAW2AXXvaO6
         s53g==
X-Forwarded-Encrypted: i=1; AL+hErGDBv3F8rSlvFVxAg5xFeTqgVXYhjbirp6A06Bv9/kV1sK9+D/92NO+k0ECdS/02/tNtqm96KI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bBHbKOcTn8VgqoduwjjI/eenwXn3ooSTckBwNT9MkBuVpXmXL
	CMvD3aMP1SZa50fJk7RAm356/M5KTQbOT5eLTfkDWoWx+xoCIouNrcbw
X-Gm-Gg: AYBFou3ParGG7mVO5zZclqtXTC9is5zXKxKcIaoZ/Koh5aUzTdDWmnNAP3IrJcJex6K
	W8ZHBZQu0UTExcXym2+sKvElCrKtOjMYYVDDsZ4XPiqwmMukPPV+zeyquJBWFQN8lgq05WuVHq9
	a9PWAlVMyNXdp2njuwa4MoxewhZboZUCIriCEJgkUJPjzUB1NZxH2IuhZwGkdtLecy3DcHrB7AH
	UZ6yq2+XljD5daTYOJhGpp4F8xWMxtonC3DRg5cQmwHPYXMjzVUH//cUgqHSZhHRgvsY938suUN
	AANZ1BDuiiR8h5kMbQFfFMdzwaEAl9/PqtO5Sl7ASURnOV2VyOkJOpPwCT5luwz9jqGt00d4Txd
	Ff1Y5VvXCiWhNknv5SdEtNsF7k9gVUPYTvWxMwstcBNdyBfq6Leb7iaukNb8NdUMF/kB63SWf+j
	CR4avjdWC20W3a+UguRpWq97/EvrdAqhWpMp41r0/upQV2U5UX7bZqo3jWVTQwIKY9rtGqLihge
	wkWXjU6glsE1st5xwUA4IySkBIjnWOnZm/xMfkUCff90mj9e7iV+e9cmS5LYaG+Yg/eLMiENv52
	qWFtO41n/I4W5uDMkyAD8X8VuqVzwQrME2ifF6PmlcG+2pJ6muUzO0mi54mKw2qahfVamIWEb05
	tvJM=
X-Received: by 2002:a05:7022:158e:b0:183:d275:cf76 with SMTP id a92af1059eb24-1b5030dcb27mr9272048c88.2.1794665942684;
        Sat, 14 Nov 2026 06:19:02 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm14745032c88.13.2026.11.14.06.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 06:19:02 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Anna Maniscalco <anna.maniscalco2000@gmail.com>,
	Julius Bairaktaris <julius@bairaktaris.de>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 0/3] drm/msm: Fix VM_BIND job, queue and entity lifetimes
Date: Sat, 14 Nov 2026 23:18:48 +0900
Message-ID: <20261114141851.134290-1-arpe1618@gmail.com>
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

These fix what happens to VM_BIND jobs, queues and entities when the
file or a VM_BIND queue is closed while jobs are still pending.

Patch 1 makes a VM_BIND job that the scheduler kills before it runs
apply its queued unmaps before it drops the references that keep the
unmapped pages alive, release its BO pins, and mark the VM unusable,
as the VM no longer matches its pgtables. Patch 2 destroys the VM_BIND
entity when its queue is closed, instead of on the final put, which can
come after the VM's scheduler has been torn down. Patch 3 puts the
queue last when a job is freed, as the queue may hold the last
reference to the VM.

Changes in v3:
- Patch 1: only apply the queued ops of a job that the scheduler frees
  after killing it, once its dependencies and the previous job of its
  entity are done. The error path of msm_ioctl_vm_bind() frees the job
  right away, so v2 could apply its unmaps too early and out of order
  (Sashiko). That path is left as it is in mainline, and the title now
  says which jobs the patch is about.
- Patch 3: rebased on patch 1, title adjusted.

Changes in v2:
- New patch 1, for an issue that Sashiko reported on v1 patch 1, which
  that patch makes easier to hit.
- Patch 2: changelog refers to patch 1.

v2: https://lore.kernel.org/r/20261114081902.1669-1-arpe1618@gmail.com
v1: https://lore.kernel.org/r/20261114062541.2001-1-arpe1618@gmail.com

Jiwoo Kim (3):
  drm/msm: Release the pins and ops of a killed VM_BIND job
  drm/msm: Destroy the VM_BIND entity when its queue is closed
  drm/msm: Put the VM_BIND queue last when freeing a VM_BIND job

 drivers/gpu/drm/msm/msm_gem_vma.c     | 99 +++++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_gpu.h         |  6 ++
 drivers/gpu/drm/msm/msm_submitqueue.c | 50 ++++++++++----
 3 files changed, 128 insertions(+), 27 deletions(-)


base-commit: 1e59855738454b14021b64115f0090eafc7526ae
-- 
2.43.0

