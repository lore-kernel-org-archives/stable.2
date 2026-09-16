Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21C191F94
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 03:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529079; cv=none; b=KgjPI1CqAkTv4R3SXcjOH8bBqmutDLid+qpVYlppDtl3/qHeLufQvhR+kE6/tnhxCBXumtdC1iN6t2Qk4LcDNFXL1s+ueDwEu+F2cFU60/NhMh3b+Q0IHLDyq5WkNu18Sz0QR5hgMTQXNsD3e0zFmgLRj0qO0DfN0BM/m5qqYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529079; c=relaxed/simple;
	bh=iDthSQqefFrOLg0kDxpCSPIAK7dnv2RUYvXiwlkwsRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mggc3N2zAJfSlbOQggLBRIIHk0MHJ6SbzRff2j9eluK4fbEuyonygR+hraji5XCWRdn9oHcHAYE8gKEcIvww+3UOVJAsqZClyKJcbBPIyws8Znx21Ug+EVgbfSdk0LhjAW7VXDixwcETC3GARsJJ6ZMBME6OnFJnsJFzec0gDVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pwsvjzma; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwsvjzma"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso420495a12.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 20:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789529077; x=1790133877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hewLRE41ZIFiAVylPPAMUN536cPkfHAC1jqHJ9IalwI=;
        b=PwsvjzmabTVUzalQ2cu2esCbIhvgN7baFnMCGdxz8R9HspexJDJaPZTl0zZLaB1ymE
         1z3erk0KGJyRLR+Vu2iZPETmHfqxJiEvCGXZ5L60fje75hxM4IFKo3kI8CAAX7Z4IhJP
         75DPW5VT5+wZ7Z5aDCUo+C/n/EsIHuYVAaC/ktoaQ6PET7Xdfl/KmBeyoVsnwwYg8Esa
         +vNqUNdDeTMlHKsIGXQ6uER8wEHuDv70yjjwAoCjyDH4p1SABDOrdwCqJ4iLZuRceaV+
         rpJvSYGBbJNwlJddcfnUTA+yTPHmMeoj3Zc3XW5SX/thYB2cngk+D63TJKv8TUx0CUgS
         Q5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789529077; x=1790133877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hewLRE41ZIFiAVylPPAMUN536cPkfHAC1jqHJ9IalwI=;
        b=yRo7l8OuahVOR1aKbX+MgW0G5MFJPAgYpntJwlbPD5JtCAn7GnknyPUH5iWCsDy+FK
         nnEJOiZAXvMxO4/3x5koAE/vPlqikZHvFhka0IRQHaW67/vOsbKqXOm0CydKfgdY7NY3
         MaMRO0uL9Su/0KHs9FlZ+fEIoKrT1SHmITxJIodKlmNj9DeJ6mmLaHmhLhpy+woeq8UV
         KFBqbYGnpssyNqGbQcKJaqxwXNRGaPOOi9nPC7n8QuajK+Amq3M/P8KWETKUAnCYfx/p
         Ix6FYu1oSxGXnj6s6W9kIYMlPJc2JzDvuxyKPCshi7wbtkOaPLaEFKwV9N4VeWdNXC9L
         q0Zw==
X-Forwarded-Encrypted: i=1; AKwUvBwwsGn6cVV0doKB2zOq4DLb52/60BRRs5OR4SXS/+lqqcQM/xB3hvJXgjgMqtaFhECufSdIFRw=@vger.kernel.org
X-Gm-Message-State: AFuF++mJJy+Dz2xxHTQjwXBczhBX437queb+UECRv5gFdMYC/PxSYBd9
	hY560hLPh6ZB/01uGJqnv4J+tjYJZfcsgilsm8q8bRq9FxZbmMjPZ40q
X-Gm-Gg: AYBFou3kd0mG9rbfx+TRydYnGbQYG124lVnyquGPGpe/VXNiM364ndkS/CkMRDgycXZ
	kWB3UyEsqxviuBQa+hucbajP7h3ASuAv2nN7CKWGD9tng6ORQdShLeHAQUD2ZbtF8etn+OZvkiS
	mVTyuDui16ssDkd96TPDh180SHY0Ve/sLOwDTXLZZtymAm+mgJfIaBqipxZZ/MCryalfyEv9yYA
	Ym9/lDolQS78RRLftEiysCMDm9YY2bqyUd2U9XzFDFsMsp9MmgZEN9aJNqgELskyHZLhheM8m8M
	wg00diWKKHF37RAtGj0Up/Y847rsl0xlhV4S1clNtOnzjiNi5yQK3nWyRY00MUbNT9ncFEcjK+A
	SUoTHCZksSLijxVeM1Q070QwNmr4CKOJ9yjtVEvN0mVPOuJHsDcigT98piOoCPqgsMLQc1ANA3E
	CTImCOxSD+g+28L0UryULrvoNxc2v4C0ZIXJYWq8rKCP1rWFxGKtEjyozfP1gIyG1C
X-Received: by 2002:a17:90b:390e:b0:39e:53a:c8d4 with SMTP id 98e67ed59e1d1-39e1e424a7dmr2098764a91.12.1789529077349;
        Tue, 15 Sep 2026 20:24:37 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bb234c3sm1772473a91.6.2026.09.15.20.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:24:36 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Fan Gong <gongfan1@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gur Stavi <gur.stavi@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: hinic3: unregister event callback on remove
Date: Wed, 16 Sep 2026 11:24:27 +0800
Message-ID: <20260916032427.2899987-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hinic3_nic_probe() registers the NIC event callback with
hinic3_adev_event_register(). All probe failure paths unregister the
callback before returning.

The normal removal path, however, tears down and frees the NIC device
without calling hinic3_adev_event_unregister(), leaving the auxiliary
device event callback pointing to hinic3_nic_event().

If an event is delivered after the NIC private data has been released,
the callback may dereference the freed nic_dev and netdev objects.

Unregister the NIC event callback before starting the device teardown.

This issue was found by manual code inspection.

Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 0a888fe4c975..42e2ad179a9f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -499,6 +499,8 @@ static void hinic3_nic_remove(struct auxiliary_device *adev)
 	if (!hinic3_support_nic(nic_dev->hwdev))
 		return;
 
+	hinic3_adev_event_unregister(adev);
+
 	netdev = nic_dev->netdev;
 	unregister_netdev(netdev);
 
-- 
2.43.0

