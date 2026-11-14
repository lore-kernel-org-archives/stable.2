Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794644354;
	b=xothzDppiFUJgRYbYKJZtx0J6JBw5daMitRQMINEdqQEO2Ld+RcfN/6ooRExpQb9J9dC
	 Sx1XjPpJPXssSGUaox/t5TT8mJuF974a9FsMDaZmpKQ0SEpie82KyNk1EHeIRdatjeJf2
	 KocN8iFDLkfYJ3h5bOXYEsA8p3OT++3HcXUSfJaXh1uGvg4x9oix0EcOnysVsCsKHtYCb
	 OAlyH7sJuf/coCAlkw8aZURYiORCBXKnrWt4GAw3ho3YEn/SuYP7ql3YsaZZeqB1/4VIx
	 x0c2wpI4iosSv9LX9QJfVmV+BsEEdEmBgBgH7xt6QlNMnhyIfF8Uz7NiNzcfhflthOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794644354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pyx07GG+cQ7r4tHVzwwWnT6ylPidCzpSMdub9ploOvw=;
	b=Pq1yN3yowilcvZgH1SLivr87jVnXI7iwrFqGVLdN0oKxUTIJzLPVEc+TCpjN50sEbJFP
	 LgsETb2mnKyY4DIBoDWzoYO5YrPSwRXwitCncZV6vRP0Ulw6zuHmPTmSoM96O46ubu1Ls
	 O5jkNdxg5SO2ckqCGZc0IDXaG74olPl6ldrBTLgYi9nZu8Pl6lq4Dlk4LLYS6cALBJDXK
	 FPiWGJqTo127+aBLoj0R10wqEwhknCbqYxhV6VWhm8oNv1qh69pdBcfDLuqYQHhaKaCN6
	 nFytFrJ/YmsiUgDbBwcAhi9Z6Zckp0Oxs0o2LlWXp3yd6qcixcOgf6PywTHI2OIr/rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aSrq/QuJ";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888AC606A330
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 888AC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aSrq/QuJ
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36ca32a0faeso191979eec.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 00:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794644354; x=1795249154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pyx07GG+cQ7r4tHVzwwWnT6ylPidCzpSMdub9ploOvw=;
        b=aSrq/QuJ4Cupok7CN67Na0nW7sMjYue8p431hqYgT0HK11ejjJ4f5VH06C57XJmqFS
         wgyCW3GLkthJFxM0pjzRWR2EevJMOcIu4GlLNLOPvC0M4NcXUBoUQ0OAkjUD1Zsy7AI+
         P5OHmLOu32LXdmNgSU3WXDHv9rsv+pdk5UTeQuBkkVm/aHzjyMuQlN8BGEbqYOXPVNsR
         86fGOQ62s8fDmzE256a2/DonL69m15pJ0ggww4TbYpod+h57UGT4cPU2YjN+j36GYhHd
         V6AKOzmoYONuaUywHzmcxE220kLbyWKGFimE3yOeC6ToJPLDXWSOWH140FojDc3Xl190
         UjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794644354; x=1795249154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pyx07GG+cQ7r4tHVzwwWnT6ylPidCzpSMdub9ploOvw=;
        b=GiVTOlbPolDlxSE6a8WvS9tW7nL4NCA6RPVKG1slWxjgAZvyhdk6d3dDzSLLsnUIWN
         0g+A7XbqEGFvZ8g8RQLJS6F8nT0ELSOrfRbHLqt81KJF6qUnCmhnKQ6HLNiavQGnvAyV
         dwKsnf9PAngURzvHoo4Ta8UDYg7kXm4FrVI0tJGoPxrH+nwhV9Y/jgoa6ysVDLibnY3y
         7JsBiFq5BxNP63yL3SM9RS/THJuGLvPoPGt6ZdZ/e/xkwmogULSCW47NvOoTEtGNZPB/
         seJjN5pw8u/Fnd5ZaOGEMb9QrOaY+tlPQuGQH14Htt89aEPIOEpWMLKLgjOq8PvaV42t
         Q2ew==
X-Forwarded-Encrypted: i=1; AL+hErHeCSqwPgPGw9KuiJ8ViUmKsiC2D9pZ3AQ2qsX9Qcuzz9OnK/X0qzRftqGkhFeKYaxvkmDP1Xk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OqfG0lHV46lb4S9H38frhUSM46Rqp8F8e5DJsja5XaI+7CihZ
	Kcwmwbixf5UMbH158awS/v3aJUgPMzsM/tKuVccG8+HY4/ZjypMWzOg/
X-Gm-Gg: AYBFou3DlOcpW6yNIlf/hsbamdD5Clk/lDIF/qEIqIVfGBHMtkXcxRXGTwuU/KEmCup
	A16wnf+154/GDXjzE32mN/IoWCHT7NG40AjCY2QTa8bAnomr0uNCoAfmB8EiHB93uBYAR5WrnO7
	v/P28PC/9IPjvrK6B4AROeVPSAXCGAWJziZTBP3tTWB9Izis7fSPvJAra4kR5sJHTtJ6wIg2PT3
	IMyvIQF0A1ba5ZS0/NhqWCU7/k+Of217d7N/diLGCdoqWPIziJSaahSxZyJeW1goS8gkJYHdCQ+
	ikAW4NhLaMMibdJYV38UkSBtLF0w48K3atA9zAHfu+qj0FAEk0nFLry4ML2/TRgtEfLEQVixtXv
	Mqp2gtzU8SSDaGlP0956V0mINFcbszaU/m7T80tg2Wuo0UhHA19OxutKBWwVTYVrDpr6tx/6gfF
	ZWfjIbO77fFgdNpVztaceHR6N8pOjilw7AY4FwKCOKj77nEzhUbOAK89qelAbKh4vGHaA0o5AnI
	UbSVKhqTM+X0aNQIf6B1a805tmFmg5BpRvCbDgtzq63ARhFAEJJYlddWiz4qxyxS+bUhdNgBAZP
	yxMZf4olYMRhj1CR7AC1PvwVI14XnyrZzw0Pp4gfRKPb2oaXHkeRE37YxlhoDNgbnXSYz+hQ37B
	/yYnizggKN7jCvFO5+rwHexOg
X-Received: by 2002:a05:693c:83cf:20b0:376:6ba5:6090 with SMTP id 5a478bee46e88-37964e03109mr8926328eec.1.1794644353569;
        Sat, 14 Nov 2026 00:19:13 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm14008333eec.3.2026.11.14.00.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 00:19:13 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Antonino Maniscalco <antomani103@gmail.com>,
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
Subject: [PATCH v2 0/3] drm/msm: Fix VM_BIND job, queue and entity lifetimes
Date: Sat, 14 Nov 2026 17:18:59 +0900
Message-ID: <20261114081902.1669-1-arpe1618@gmail.com>
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

Patch 1 makes a VM_BIND job that is freed without having run apply its
queued unmaps before it drops the references that keep the unmapped
pages alive, release its BO pins, and mark the VM unusable, as the VM
no longer matches its pgtables. Patch 2 destroys the VM_BIND entity
when its queue is closed, instead of on the final put, which can come
after the VM's scheduler has been torn down. Patch 3 puts the queue
last in msm_vma_job_free(), as the queue may hold the last reference to
the VM.

Changes in v2:
- New patch 1, for an issue that Sashiko reported on v1 patch 1, which
  that patch makes easier to hit.
- Patch 2: changelog refers to patch 1.

v1: https://lore.kernel.org/r/20261114062541.2001-1-arpe1618@gmail.com

Jiwoo Kim (3):
  drm/msm: Release the pins and ops of a VM_BIND job that never ran
  drm/msm: Destroy the VM_BIND entity when its queue is closed
  drm/msm: Put the VM_BIND queue last in msm_vma_job_free()

 drivers/gpu/drm/msm/msm_gem_vma.c     | 77 +++++++++++++++++++++------
 drivers/gpu/drm/msm/msm_gpu.h         |  6 +++
 drivers/gpu/drm/msm/msm_submitqueue.c | 50 ++++++++++++-----
 3 files changed, 102 insertions(+), 31 deletions(-)


base-commit: 1e59855738454b14021b64115f0090eafc7526ae
-- 
2.43.0

