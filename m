Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5922D5432
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650625; cv=none; b=WAY/7bSoC1hcc/6FdfQRbpoEpSIOo6OwREGaURyghCkhir7n58kPZ677dDCfbCLJvPedKosLsQUTVf+59bN70Cpkg0ZNJSXFWJTubiJEd1/B31iMGcSued6CW0+Fe5gbij/k+TU06AvGnrZJbVl687Vjy3OFZ+up/4qRxOBJtw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650625; c=relaxed/simple;
	bh=hoIkw9VtvA47vMVJbFDjkPA5pbPO8TsazoHJPLOge6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JhIX0TzVtmIKQO2EB5B1LckIa/4oYxt/5bCupfsLBstBLRKYYJgmjF9rmD6C9RjPdnD2NpcA60Tbw1tAFUBXD3gHUO+7+v1PLPnyZICbCM6R1/UpLj1kV+VIF+O+2N26J8Gxrw9waAATCPvlsX4+6s3bSWANmWSG4d3jjucoRhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDj/UtxE; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDj/UtxE"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e6c4a867cso22993685a.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650622; x=1784255422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2A6lyd2jd7ZCM97ZM7yJgAgaHnmHNrVF3oV741yC5EI=;
        b=qDj/UtxEZlo3rDzPsjlyC6G5BIzW9s2vA/6yJOR+f/I3O/3JT3Phv09ZP0fvNb8ASS
         nqGtZKEtm+YUFC826PsKLUaduWBIicNTNQZYNypEYKDRTXA/ca2oQlxjcFI52zBJwbF3
         JF4yrHf+znJz85qf9ImctThbKIcqMfXbYh9g1TTDTnK9h760Dj+5kGEwWUg3CbRtn4ZU
         uGRCmeGmT7PeFzqw04ir/wO8+ryUl9rW95y8y+1jjnx3psom8I+IZOJgi9K0IME/3nE1
         ongBLwwL80AbxCaEvUvaJ9uo7bDsX+XShNRzk2facTPmWT7Pub7J1APesYVk4/WidU+n
         InfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650622; x=1784255422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2A6lyd2jd7ZCM97ZM7yJgAgaHnmHNrVF3oV741yC5EI=;
        b=Y1dCKT2fUFMMca/WgDB2Tg1pPPUMbwII/mLYxUiAbiVOBH9ljH+mqmfIq59MHRi/tz
         0VwASNkV9LDxQcD+DyphVGVLmmrrtXZrw2w84pfeaGNs7r6ANBy//PzL6d9idN3OduwJ
         qKVyf5FjETyHkRb8TCmO60cPmAE2JrUhdamaVTBCs/NzPwJyxEHf5sEwfRm5cBJPXz3a
         nMD8RHEuPzziy2wO01m7Zh4KIIhEVTydHytEooMst4rQhPHGs00yZI3xbIpWRYfKAuUJ
         coVhZz55NflzjDpTL23w8oaEujGM5UNfTFe4lfvZ/GCeVKS9zuP3Ij+PfE8Kptv0dKjL
         YvFA==
X-Forwarded-Encrypted: i=1; AHgh+Rqz65eK1vBRo7aA+OlHI84nZGner3yh5nWY/dyLwYXGl9nnFxXwQJ0Ram2O0kTMzSfVtx5vn1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTBT1BQVQ0/PvDW6e4yGUjqUi3UhX8qdu1NJx2/RLwi0/98f7
	YKQlXCPrCz8tizIBgwIJfZ/URqGW2Uc9n1P04bvFTNB7TOUpa8dbcO3l
X-Gm-Gg: AfdE7ckx1pcPfEoe8MaPuzdRrTH+zZ3a5p0pWxp2qAKjnjn5gYIRQ15z0SLt0xTr9jN
	3ZhvV5Lq1CkxFhzWHRChCs4kGQ9YlCFvZ8Pkco9gJcWjRVAa6EpDM+aPAvm+NW0RKx7j0djlupZ
	buTm6b5UY2Fcp6PJeC7Jmto5eHB5lmQBYK/dF+yidzGBMXjTn398f0Id0TTyu9N4qR7hA097YXO
	H+L1s68JzTq621KGOIpTmfz+4X3bz2a/NHdgnjTcZbQQpgn9ZMrq89NOZr74HWCdlp4+rHI5L7S
	hAZTHXbGNRNXjlo2Uk9BDiShKhsl1R2PrptawJhKJhn1azuERUVQg3eUixk0qTUN4XKaJbcYvYk
	YsZGegNJp/xFoG72dFuk48ueSA9AY5jgTFRKuMBN/qTtd06KdpE3z7iriHw/WHAwOrrzeqKh4IM
	KhotTreKowRSdtKwtBx3aPL3BI17EkS6tanxxOIR/dRd369V0K0A//ouqCyfGYUzsLpfwxCHDhW
	YLc9qGTMYzq+WGcv617oVLXWcvwMYrJ
X-Received: by 2002:a05:620a:270d:b0:92e:717f:e0b0 with SMTP id af79cd13be357-92ecf5b4811mr1052722885a.12.1783650622549;
        Thu, 09 Jul 2026 19:30:22 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9d9bsm88854685a.28.2026.07.09.19.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:30:21 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: kwilczynski@kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] nvmet-pci: validate endpoint queue IDs
Date: Thu,  9 Jul 2026 22:30:13 -0400
Message-ID: <20260710023015.3744082-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

A PCI root-complex host can crash an NVMe PCI endpoint target with
malformed queue IDs. The endpoint transport allocates its SQ/CQ arrays
using ctrl->nr_queues, which is capped by endpoint interrupt capacity,
but the common target admin validation only checks queue IDs against
subsys->max_qid. A host can therefore submit Create/Delete SQ/CQ commands
with qids that pass the common checks yet index past the smaller endpoint
transport arrays.

Patch 1 rejects queue IDs outside ctrl->nr_queues before the endpoint
SQ/CQ arrays are indexed. Patch 2 adds same-translation-unit KUnit/KASAN
coverage: a valid queue ID that must still be accepted and the
out-of-range Create/Delete SQ/CQ cases that must now be rejected.

Reproduced with the KUnit/KASAN test: the stock Create CQ path faults in
nvmet_pci_epf_create_cq() after nvmet_check_io_cqid() accepts qid 2 with
max_qid 8 and nr_queues 2; patched rejects the malformed cases while the
benign control still passes.

Cc: stable@vger.kernel.org

Michael Bommarito (2):
  nvmet-pci: validate queue IDs against endpoint queues
  nvmet-pci: add KUnit coverage for endpoint queue IDs

 drivers/nvme/target/Kconfig   |  11 +++
 drivers/nvme/target/pci-epf.c | 151 ++++++++++++++++++++++++++++++++--
 2 files changed, 157 insertions(+), 5 deletions(-)

--
2.53.0
