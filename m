Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4423B19BB
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245329; cv=none; b=inHHmUDOjN17CiFzJJw9/J616Rp/YJSGCNT6VssWJNiU4yghMAKh6GT6NKNz6k4h1GKW6FI6+13fbj4VmcYzXR24xP4K5XOkrqh8t93wJ+rB/1uuKmz5iDprZD9URqYdABtR6samV0OCCk/3DmcS+mBrVxFZnHuQJDu62L3m/6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245329; c=relaxed/simple;
	bh=OAPZdRWyQy4q2zNyz4kGEhF+go9N3BGWG6beizQuBmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5BpmkLO6EfpsN/isELxeLf0DXGiAOIyWLJQ+fhKJdEzDXH6T8FF2TeAHPNTJN9IvQ9lCI7fZruCa+W/pb5UAbAgytC3J2gniLcPdAkmj25TnWx46IG9wdvHlr+vLEjBvnyIP88udS9+TgVfMT7aPsGJvBMr48nY9+q6KbbqZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2M5XMVD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2M5XMVD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso20231655e9.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785245326; x=1785850126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jpQekUlMBXKHH4ypTl4Zdo+4HRaR5MNGsxg/blhT7gI=;
        b=Q2M5XMVDuL//EMCoFPxRYH7zYAMuOHm9N0wNFFocdrR9KVMiTxGZkJ4pDORnxsPlJK
         bok1OSMOUi3SDqM+ETPqAYCISgEcjhg25MhYaOKJcvgQ/ON/NrciynJx9bdK1arcbS6M
         4lxJTztypHC1HtV6K4QYwP247p+a9VzbEqezgi7ocb84vXPS8iYidIZiAeuzBhGzRGqr
         78mFuJdeclGXdDAssu5V+McUXqOn82XjGvMaJRojnOobJLKEls6OLNifuj3BFCHY2Im9
         3QAfatBHtKC6wpOZRjtU1f33ow48pepxz5OjXF9s8oNVdJofvfvN6fEk1OijDLKFGTGH
         CpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785245326; x=1785850126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jpQekUlMBXKHH4ypTl4Zdo+4HRaR5MNGsxg/blhT7gI=;
        b=Jx+9dVFBPuUBmThj0lUKB4qdnVCfq9m/g7fAehOmoXksTdh80H2qJD0I9FQffA0Ws6
         Us3/8GOmPIBjFkjHbjFeCUItYQwfuoz2xJC2EEBOKK92881ZlghSpXf4nMgzMMfFQNXn
         QKLmJ+hEEOmjz4zZTfupKe4Qs+/fimAWI3rwCycPANuJc5rVS50Ej2/BDayHFLYUgYWz
         RentHfSTN7yT+SNU+Cw5xXaJomf6kAk3vUrzt/VFq0YHO8iMT38unGz+kPDeQrWdN6Eu
         ummxMDhIYZeTriADo5hK60xE9MS3zosm/SzzZ1o+2XeY2k4X/8TRbBf+HhmoCFnusr4m
         VL0w==
X-Forwarded-Encrypted: i=1; AHgh+Rqiz7xAfWAfSto/Jl0c+fPSNeEx2Y0hFccbvRVozxu9S3hIHgFS+JghKrwJ6MJ0Lc1XyF8lbwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyvdje9zVxa5dgpwdwVISWyFGocMhONW3C7TAd6t4K3RIo1riL
	p4hVGZdiTIlcNfpHWQvciaj4KO8B4gxWTC+Kg2Gaij02pj4hZ2dhHyQD
X-Gm-Gg: AR+sD11iClAXDQ/lcLjn6kvK9of/iZZZI/V7ZbQ2cCMtZHNJSAXzfAFa+PhquYjqiEA
	7zLnK1+l/8nMd9TeRjGpZkqIVCCyDW0cXjlxdGchBQgDf0Oe9aoBleIdxTbZJHhSoqC+fPiFFnB
	iO1n5BBNRI2w9fe8+L0CwotUE0v4qKbzMSPTCqhppeRSkBbQwkKxOtTEGQOn7obeW/bvHiOWHjN
	Kp90+eEOWe2MJhHo5Jf+L2c7wf4pad2xhap0Iw7YYkjEJQWDBBrCsmhJM2cW6BupVYsz/QUhYxW
	LjUerf9M0NSvJ5wLGdSoV5mDYmSRaf5rBfDgyhzhvM/4xJTnNZ7LV6nJFU1G/GeTwXIgIuXK6oS
	WZvzEotD7tp1m+ayppTKqY8AXELNc0lcOw4RRzsz31DneBIEtwIeGXzoS3GueZvmAmCQ46OTmbq
	bAymPzpyFrzKgX0oWQOCJb8u3ZpbTjRn4VF7WtUJcG0o5ejMm4cib9VgQ=
X-Received: by 2002:a05:600c:19c8:b0:495:4b00:1bab with SMTP id 5b1f17b1804b1-496c6565e12mr28399355e9.21.1785245326303;
        Tue, 28 Jul 2026 06:28:46 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9b8b67sm359163395e9.4.2026.07.28.06.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 06:28:45 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: david@ixit.cz,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH net v3] nfc: nci: fix use of uninitialized memory in NFC-DEP general bytes
Date: Tue, 28 Jul 2026 18:28:36 +0500
Message-ID: <20260728132836.41868-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_store_general_bytes_nfc_dep() derives the length of the NFC-DEP
general bytes by subtracting the fixed general-bytes offset from the ATR
length:

  atr_res_len - NFC_ATR_RES_GT_OFFSET   (poll, offset 15)
  atr_req_len - NFC_ATR_REQ_GT_OFFSET   (listen, offset 14)

It never checks that the ATR is at least that long. When a
RF_INTF_ACTIVATED_NTF reports an ATR shorter than the offset the
subtraction is negative; because min_t() casts its arguments to __u8 the
negative value becomes large and is then capped at
NFC_ATR_RES_GB_MAXSIZE / NFC_ATR_REQ_GB_MAXSIZE. remote_gb_len is thus
set to up to 47/48 even though only atr_res_len/atr_req_len bytes of the
on-stack atr_res/atr_req buffer were copied from the packet, and the
following memcpy() reads the uninitialized remainder into
ndev->remote_gb.

Skip storing the general bytes when the ATR is shorter than the
general-bytes offset. remote_gb_len is already zeroed unconditionally
at the top of the function by commit 9c328f54741b ("net: nfc: nci: Add
parameter validation for packet data"), so the short-ATR case needs no
separate zeroing here anymore, unlike in the v2 posted upstream.

Fixes: a99903ec4566 ("NFC: NCI: Handle Target mode activation")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
v3: Rebased onto current net.git for-next, requested by David
    Heidelberg. The function moved and gained an unconditional
    "remote_gb_len = 0" at entry (from commit 9c328f54741b, landed
    after v2 was posted), which made v2's explicit zeroing inside the
    short-ATR branch redundant, so this version drops it and only adds
    the missing length checks.
v2: Also zero remote_gb_len explicitly in the short-ATR branch so a
    stale value from a previous activation doesn't survive into the
    new session.

 net/nfc/nci/ntf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb8653..e0555c90d657 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -631,6 +631,9 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
+		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
+		    NFC_ATR_RES_GT_OFFSET)
+			break;
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.poll_nfc_dep.atr_res_len
 						- NFC_ATR_RES_GT_OFFSET),
@@ -643,6 +646,9 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
+		if (ntf->activation_params.listen_nfc_dep.atr_req_len <
+		    NFC_ATR_REQ_GT_OFFSET)
+			break;
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.listen_nfc_dep.atr_req_len
 						- NFC_ATR_REQ_GT_OFFSET),
-- 
2.55.0

