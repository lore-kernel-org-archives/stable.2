Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999764;
	b=2gbWAL1lkBrifZJBF1Gvu4xIW5Z5OJMZK0LbbBl8LwKQgCGVszDJFgqj9lJtq6ZaDGUK
	 FkAUpz1A/0PWRaa5ErazVud9HxLMlmEBr4fKpafqZFwMxXGg+Sn8vz9tuCldd0ed8fknq
	 DrpY4VqDR7Ic4eD6ko4huzN1fsEnN/GGrmvhN81elaV4z3mREhhl2s3hLvRBt3IMbFtsW
	 1DxYlfPiZ2ZQViKQAeBnHgFrPLUIPVXOff++ehbQ2xnPE7yrltAT7FPwXPlUN85AsOyVh
	 1gy8JaSj6tB4YNBX6Pn3BBCcmMGDH4TPBzqBkj/LrwcKLqOVgo0kf2g0QHRebPy/2Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TNUJcoivapsKBW3NAQfMVs0W9NiOWzC1TnMHNTq8Zc0=;
	b=YlJMfc9fXzOxhHJwr3fW+2jbNomS+ScbbeJCYYcB4B2LX8l8qWF/Xm+z7KNMlpXFD1kp
	 /9aqiZbfuSdx2U7RqZ65tL4hR9TiityfzSDtfLCCz7Gs3N8CQXSv6uVWdCy79fD3VKf9l
	 IZqXS4sibN1JlwF8uXntMLPKYNzkLM3RRodz6RoKJ2zYbHJN4Zec06j30EKLtpFqYSrxq
	 p07Ar94FLwDgLouOnmOQBuROoVkYqlrazClWMxAr91JuxddJ8iBGT5tO48m5aaPTKYi9A
	 7BUAo6Vas9Orr7xE0FozgazHMxjqKNPt7uOz2oooXbAanS/2vgFqYIUC3cop4xXeKmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvz.org;
	spf=pass smtp.mailfrom=openvz.org;
	dkim=pass header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=YeVRGcrT;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C2E606A33B
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C2E606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=YeVRGcrT
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso652283f8f.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1794999763; x=1795604563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TNUJcoivapsKBW3NAQfMVs0W9NiOWzC1TnMHNTq8Zc0=;
        b=YeVRGcrT4o7IBVvHQ0a0pS8eJ8Eor2RgmVH+1CvPou+qBAZdLeY1ZvFzHDGKPBdDsW
         OX1tK0sV64OdX5Q4X1N1z52GEcapjjLk/QMVLiiiVv8ZgkhZRtAyNmEEmK4lcYO/MU+z
         5Yn8Xn26GFeUDfHtByujuMJAToZglDa8UNqtuTTFfl2r6XbIbuPhLnXk76PGxZQM/OfH
         yL1/s0FuyKLK2t6E+DXQd6zEi04AeKhm33Vlcarbf5GC2atWCLRyks/h/B+7qeqIdV7K
         Pu99eFDuzJviqcGy4wUnG0ZXt5qyQewrMi8vN88kkIdRvhhoGv9tm+AXqWMu1x/rDeXd
         klBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794999763; x=1795604563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TNUJcoivapsKBW3NAQfMVs0W9NiOWzC1TnMHNTq8Zc0=;
        b=lu0SRyyDfw04qkxKfMx/7iJBLuW2qClqS9s9o415AiuWg4aMXBv/6lfcruhkP5ud85
         VEnud4Jw8QP2y1J713tz8EDPcLO4+YCWNvLOBAmOGDHrTBCxsg4E9htbpUAV0YppsLw4
         F4ksvB0/p0ldXoXdjg/EvtpBCDmAPBuwYz/kklpDAH6DD5t3QyyXr6NorIiOaSbp4in0
         SKjiHn1Tu9KLFoHrHKkehNknQVlw1GUvIfPFHCUFDZFwtksTfWJH6hUSYRPl8dmkqnX4
         MH98/fwrr8vUlzjxApem9SE6Wnfts8GpWJFlqyhup2ZJ/T5eY2Z0WJVyvo269/Q3QU1P
         4s1A==
X-Forwarded-Encrypted: i=1; AL+hErEujek+WGHd5FUL+JVNujIPkcmHcNxxgyR19aqDqkyf6uKI1JYGovwiE8+V49VjEsUEtkCVTck=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WNANWPvF0weszeeTxIuuLitMWGbnOSNpJpjO9KBrXDVMSbPPy
	nR4LhtcemGEEkYChuwKkTFfjcgywpeKDAFP/+xcyFbNOyqBv7sIBEKAiUFeri6Yj4K7q++nhHOL
	NOYry
X-Gm-Gg: AZFdTZeU5OLf9yFZLOnANBdehwzwTwyEUlS2er9mJjTb/yJNJyMFOnmiBnX5dYzp268
	ylO+vkWICJ2KuYQe0BZenTce68XrcoDqwCV/lEzaL8skFh2Q7x0QLDd0k1K7SJqx27XBF652qpa
	vn2MfxVRtLs21F7aO6eM7MRNABavZZRsKPQVZKtzvvypwxJ5kHBS2GtB+kQLLEWC5rzQGvoWIkQ
	tmbW1b8OwxEWiTV+U9ZvhVNQUYMKbq2bf+Mixj13odMsej7AIXboQKY/zxKm+iW8amjgQfzWHXO
	PT7Mi1Qklp3K4/bYWiSCyhDgqhqfSDexJ2Vh9Ez/mRNMsvU8vC8+YQxHsOSZttoTLcTi8rMDrqq
	+bDNQidNsNMpOhj3LBXiJ+IuYmgbznqNwwYMfPAivO/2JLUy0toRD3s52ots5Yl5Calp0IUI2Lh
	KnDP7AU7hVfNJIN3gAzG3tQZIArNd+yXqtxV1ORRz4Xcmn4UE1eyKpa0lKDpwLx2G1r97Bgcgn+
	IyDQfZhx1flul0gV4qgg/Ud6EzzAxKPSjwA30Qmz4boFgxdra4YnIsH3dfOQ/oKqOl7qCLaNomT
	RnYkOZNmaKqOFVKvIP/Nv0HE1bmG
X-Received: by 2002:a05:6000:29ca:b0:493:2eb8:e7d2 with SMTP id ffacd0b85a97d-4a63a98b0d3mr3226899f8f.41.1794999762580;
        Wed, 18 Nov 2026 03:02:42 -0800 (PST)
Received: from artemis.sw.ru ([2a06:5b06:b600:300:8c09:3cc3:6efa:ac1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm3943277f8f.52.2026.11.18.03.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:02:42 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev
Cc: bmarzins@redhat.com,
	thornber@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	den@openvz.org
Subject: [PATCH 0/3] dm era: a metadata device that never comes back
Date: Wed, 18 Nov 2026 12:02:36 +0100
Message-ID: <20261118110239.2910290-1-den@openvz.org>
X-Mailer: git-send-email 2.55.0
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

We move running containers between machines without restarting them,
and their block volumes travel with them, so dm-era tells us which
blocks changed between copy passes.

About one move in three ended with the volume dead rather than moved:
the metadata broke, every commit after it failed, the target reported
"era Error", and the writes it tracked began to fail, which takes the
workload's filesystem read-only. Rebuilding the device recovers the
tracking, not the filesystem.

Three unrelated causes, all of which the kernel log blames on the
space map, which is the victim. Two need no bad luck: multipathd asks
every target that appears for its status, so one is asked exactly
while it resumes, and again while it suspends. The third is older and
wider - a transient read failure in the persistent-data library leaves
the space map short, and the next commit makes that permanent. dm-thin
and dm-cache reach it too, where it costs a transaction rather than
the device, because they can abort and dm-era cannot.

Each patch is reproduced on a kernel whose only modification is the
fix under test. Patch 3 must not be backported before patch 2, nor
before cca2c6aebe86, where the resize goes through the worker the two
would refuse.

Denis V. Lunev (3):
  dm persistent data: drop the original block only once it is copied
  dm era: refuse metadata rpcs once the target is suspended
  dm era: construct the target suspended

 drivers/md/dm-era-target.c                          | 10 +++++++++-
 drivers/md/persistent-data/dm-transaction-manager.c | 13 ++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.55.0

