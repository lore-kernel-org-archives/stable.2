Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773850;
	b=oVwAmvTU3v61go4d4looXzCIJjK/37zgDuUQD0L9vu/j0cOVaEcjGQXVAOI2G4M+93Pf
	 PuKM54nA3tUCOV3pPaivMRFVmsVYCuEX0QiRIDpiU68vcRDZXkfXjA7ea8YTVwpF0pUON
	 JgNoQ3DFRtRvM6VtSnVhmX2zqw2ut9iKEUGXNJtrUHAniEn4SjBXj75U5GqrL2c1jHNxK
	 7ZFYiuBv/1KpbeB0vOIsDPP3w8BhNgVzaahTLR/wsK4HChAMBARpJRgGz09IBwTCAuEhI
	 FsZNBJmGrjonkgvzkOilpPRrSSfvxcBffghzie534G7U+/Mwndmex+3m684e+7iM58A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer;
	bh=Mw7VJYnNekK0b04jd3U00XO5v3TzXJogPpVwvYNW6MM=;
	b=X0G74Gqod+QVpVsHWBE+X8VE6I1YGjnhhp31Mct+uv+X5q72J2qc/60QN1+2tzwH0NEJ
	 6XygPNMDQW93Efk4OTWmWcc9UcyP7q4s0hukWd7BM8TZZ8E27q8hA1qY+boYlMElv6s0r
	 /+MTsI/5Pfrxpw49OMULYAIQ6iXOMi7EiwcTWLL7KBifqGQfbt9Dj9QsIFQCbggdwD9Cv
	 IHNEhModgXAElFIyAsmqLp4A+WiyIPXZ0Wl3N8njM366vAqd0jlpZCHQU7MWq7da9BgRF
	 sqpJH5I+EIwE7owigafkMhmdIvEWQo+yxC78uk5gcs5rdf00IFpG9MNC00g5x6cDCtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ge4DWC8p;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F09E606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 06:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F09E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ge4DWC8p
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b1ce85287aso363017c88.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 22:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773849; x=1794378649; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mw7VJYnNekK0b04jd3U00XO5v3TzXJogPpVwvYNW6MM=;
        b=Ge4DWC8p50yuM6BE+AoH2DbZIelL+VUSCXwsaeYpNMsz+PTDS5TIsx+Ou5S/TgXiVh
         6D1P5MbAyNcBV/bo2HUR2y0Z2ydBXauksnTzGC4WhxPaQnLcKMmyBGjQ5ZioZiZwuNHj
         4fTdv6uegGxFf6rKf1KgtgcPTKrMsqB+91iNX0TORH+nTrFBoxsWLGRnTqWPh66cEMIY
         VcewTJ3nBkopOLEfJa5O66Jd0tDdAcIpxqQdbD76B+5sST3paZaHiMlMNqZRRXjreAcs
         6NsKlfG57u+AzUzzqLvdXv74xIlgnbYpc7EgvHfRGjn2ILvxfoD23xNW0LCUBbnwwMgW
         zk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773849; x=1794378649;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mw7VJYnNekK0b04jd3U00XO5v3TzXJogPpVwvYNW6MM=;
        b=WfJeoICtBqFnibpcD5k90Xe4a2PpeIbLhTxvLUVeO6dSO6zr549/YMgvtTN/QnMwu0
         c/Ewh/R82HbhD3fF7Ao8RVL8t+NgKwTI4vZ1HJea8JmJ9avnPAxUNPzLBhjLoBVilu+2
         ccn7GrlZqUO4iUVDCrlCcYZurkSPqSiR9xIesYAnONUoVsWifqpTA1GhU85Ymu48Ho5u
         49SmjFO5fY60fTJRMoaQDHlx07eD+S/rEM4hy/61FQvtCqnEjtbbuffF2HDGqORkyd/+
         zIFx3giqcX7ypt99ibKlGQXzDQHjhfkqy8qiNWxRbRMLa8yzqjm1joecdRiH+ofvXtR/
         jz9g==
X-Forwarded-Encrypted: i=1; AKwUvBwdzCVQCPLfO8VgtJHP3PEBdiMb/Ari0CA+lulKM1G1gDP28phQw01pCiMGTQMFTy85K2S0xxw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gZjObr2J7MEQ56jALo1hP9K233Of+ajHKkknUtA+f71FwVaJR
	9xgl0oshDSG5dW7uhtVJ6fPKZ1NdoOMyzErV9IDSzssoPdHEppxLk74a
X-Gm-Gg: AYBFou0DFX60V34EDGf4SZ9Z1jQa7YPWz1Zu1cHhqNf863RRE6a2zsi7R9uS++8vg8b
	bXSG5YfZPQRlR0dgIaGD9RH/tJtuP0V5Ekw5xJbYoC90Z5vxN7CXeCY6e59ctFGfPmIrtZO98qB
	KB0MEJ4NJIJpgOR9ZuPfNySmLzigumCLmXMX4oqK2Rl3zNhs2VOEcvim5K7NqDegr4yqHfBMD27
	Ulr88TYC3w+NXahhfKLIyomgffovU7ksqTJjCk8yN1Bz1AYtms0vIN0HuS2HiH57c+8XE2+aenp
	nkLNSZRm4ggP+Zzkhg1BlbZHDhJUQoDRwSg4ZVo6HhnBe2R0ualHaFQKCI1oJBC4q66rLSpaUm2
	kzSfMRp7lSBp5NU8K5laUHj7IXXDj41hQRm0K1MVjOKXU6SAhSiwAbkXYV6HsR324378Pstq9Sx
	mJhpMmywNd6KfgnauxlBkcHqjOmwzk5Zq4UVpvHCaUnq0w2LuOa1SPcO5vg5YBFUv9osibKbmaW
	JtO6PeN0Al+xhDRsFDQmrGZF+k1HkS82NbbKn2vFRqO0PHLhPcfZFHbH3hy9qpClZVHJq05Wp7X
	+M0gGUCk/fxZLc1efhdVbSdF
X-Received: by 2002:a05:7022:158a:b0:185:869a:8c64 with SMTP id a92af1059eb24-1ac56ca0239mr24721522c88.1.1793773849198;
        Tue, 03 Nov 2026 22:30:49 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c65194sm4454290c88.19.2026.11.03.22.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:30:48 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH v2 0/2] nvme: fix removing namespaces under SRCU readers
Date: Wed, 04 Nov 2026 01:30:38 -0500
Message-Id: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA7R6moC/3WNywrCMBBFf6XM2pEmwT5c+R/SRZqO7YBJJLFBK
 fl3Y8Gly3PgnrtBpMAU4VxtEChxZO8KyEMFZtFuJuSpMMhaNkLUEsd1RpcsYSDrE6GLGINZsVd
 Tp9uT7kcxQlk/At34tZevQ+GF49OH936UxNf+mupvMwkUSFL1dddOjdLmMlvN96PxFoac8wcuk
 0/JvgAAAA==
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

nvme_remove_namespaces() splices the namespace list with
list_splice_init_rcu() and synchronize_rcu(), but the list is read
under SRCU. A reader still on the last namespace can then walk onto the
on-stack list head, which KASAN reports as a stack-out-of-bounds read.

Patch 1 adds list_splice_init_srcu() for lists read under SRCU, and
patch 2 uses it in nvme. Both are needed for the fix.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Add list_splice_init_srcu() instead of open-coding the splice in nvme
- Put it in srcu.h, as rculist.h doesn't include srcu.h
- Update the numbers from a new run, median of 3 runs per boot

v1: https://lore.kernel.org/r/20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com

---
Qiliang Yuan (2):
      srcu: Add list_splice_init_srcu()
      nvme: wait for SRCU readers before splicing the namespace list

 drivers/nvme/host/core.c |  3 +--
 include/linux/srcu.h     | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-bug-nvme-remove-ns-srcu-93d8a75a9b1b

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

