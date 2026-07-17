Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E192EF67A
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317514; cv=none; b=ORvK/yAFGEmT2KbBJdO/AYgqjhRERvnfrM37QwBjifc9wibWpq0idd0onpPLi6519oTkHxu5WjvWLI01K1ZH0F4YBdx9N+uZpb8BRxtuHdeIPNjZnFK1GPoSJvsuWE7k2xwB/VJwh41xBJJH1RX56scx4ctgG3I7gV0UIJfYLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317514; c=relaxed/simple;
	bh=RxkvEXDx8KlyCHd2+X+HZ/CkG1k2fbI1E4IJ9wEZVew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uN5vWKtMvUcpest61zNhWhkYQsCTHHwrDjOqfqFi1FWueV0WYsKC6PEJ89jL/5CEKKqddEAUNvGIozKO2kbqvB4qIvQ/dlfqhrQyBT1gLZWkuigFoOfjzqCJ1MGvv95E278ZXb4NPA+Ch0Fe+dNaguxg39edfRoml5dP78UyBNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtRcqkAs; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtRcqkAs"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51bfad59921so71116071cf.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784317512; x=1784922312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=40Iwwbwi3zfzgUmW087PtCRLpD5oHv9m7czWAQxS6Q0=;
        b=AtRcqkAscq9IJlcXd6onOKWeR6ZsfZf02iDmtSlNGJtV1pgonpzHcTAI9JMxN+gti1
         2dzLx2zksI3oaj0V/lJDY30K50FxU1TDMv4Pqwh9GHN3Nfx6B+lZN7RTCORX+YP6VjJT
         cAZTmTb22fDsySjJoosrG7w8rf92yrtpK03fmNgrPR591VtiMm+Q5AI93xis5H+h0hcn
         6Vw9+TY8SKyQrUg0YzH4hh83lO+r2i+umE4sr2jh110cgDfF7YyaxLhiAhspkRNFRwlx
         Jo7NX1xS5VRuV4upfXRcGQkzKp7GUjxrWhJFxwPqaa6Q0ZxN1Sjh4nIvm6v7yBok67Yb
         N3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784317512; x=1784922312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=40Iwwbwi3zfzgUmW087PtCRLpD5oHv9m7czWAQxS6Q0=;
        b=Rb9geKXGqPRppCdy8E5Lfki1CkwamnggCG1UKTXb8LZMNMk2KlptiC0XCVjcDWljEe
         wIsye5sKEhQu2P2G+1cO/ph4ashRqaxKT9pTEwme8ar2rhKi9hv5TQ5pHfF6nyfU7R1+
         KboKAgJn1oLfVKPDdVHRrtPSSSRl1kZ0PyATGTogCNHegGueteMCrRJJxC2xom/bwDmE
         lZhqgZsFV59HcBQsc/9iipMk7Brpj//lA0DQKprQzrVB9jMWpB7RCbYmujVjQEip3e7M
         Yve6EmWEemkt/u+dPi8A95AbhXoEv9EDmhWsiDQm2Qk0oV/jyGv8K3cRjwjAuqrZQ6qA
         Zbeg==
X-Forwarded-Encrypted: i=1; AHgh+RqKQgPia2NGaw0Sm/3xsaxI6NRk8YYx+t6RlBeS7yjOMYqbZEueXdPNoFLP6VTEmDBbm214Jqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCYUnY2L0whliTZINBzg3KgfGrHvqZQVzGoPHzr5F4ZgExf/7x
	SUS2rGSk5piQP4GBdrFZJKIfKbC8ZhLFHsS7dpK/z2eXTWwfTqu6XI61
X-Gm-Gg: AfdE7ck+Ln84BqR4DbkmFpH6P3myM8b6Pcs1/dUPpxbO+jL/lO45eD/hpfuAfwxLXZe
	93tp3E2OJYYyWm14le/Wec//IoAqiwBEnhkiMXyCDTi6GNa5iEq2N4Wu+S8kpv5QiFAToLai7TX
	pcjHsIf8/jm0b+WNK+ApcbStEyxIfUBwj8zldpayJNCzcS1LSJE14lolpd4siFFC37OjFmSQG2l
	zH9oFxSvgPNRnDRkPPpBFO/kyDKA3ak/pYnQ06r2q/4QmCqPhIQkdjrrp7fp/shR9dOjwDguD3c
	8VM7K6YVHdkhxRWrRlQQRDnnI3AFx4qMsx5Dy13gRKr0F+dguZE3w0VGUkMLb96d1s6cE1nwqR0
	Fv7abDZ5EY7/tPSAE9BZkTv/FGBgRIt9sJ3osABIEflDq60XIPTAXNJqQVIVnm9fP8jXQDVpCzw
	xQa9RYo21m6hu2mgAQK2BowXjnVfOh1ys=
X-Received: by 2002:a05:622a:1:b0:517:6b9c:58e4 with SMTP id d75a77b69052e-5213e28ff1fmr41926781cf.51.1784317511770;
        Fri, 17 Jul 2026 12:45:11 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f5fb88esm19766811cf.21.2026.07.17.12.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:45:11 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	elic@nvidia.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: flow_offload: clean up indirect flow block on bind failure
Date: Fri, 17 Jul 2026 15:44:55 -0400
Message-ID: <20260717194455.1734974-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flow_indr_dev_setup_offload() records FLOW_BLOCK_BIND requests in
flow_indir_dev_list before it calls registered indirect providers. When no
registered provider binds the block, it returns -EOPNOTSUPP. The replay
entry is left behind.

One affected path is nftables netdev offload. A netdev base chain on a
device without ndo_setup_tc can take the indirect path if an indirect
provider is registered. If none of the registered providers binds the
block, the operation fails with -EOPNOTSUPP.

The failed NEWCHAIN transaction can then abort and free the nft_base_chain,
while the replay entry still points at that basechain and its flow_block
cb_list. If another provider is registered later, the stale entry is
replayed, potentially passing freed data to the provider callback or
splicing callback entries into freed memory.

Use the return value of indir_dev_add() only to track ownership of the
replay entry. Preserve the existing behavior of not propagating -EEXIST
or -ENOMEM. If this invocation inserted an entry, remove it again when
the bind fails.

Fixes: 74fc4f828769 ("net: Fix offloading indirect devices dependency on qdisc order creation")

Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 net/core/flow_offload.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index 5071d7fe6ce2..5fbb1ae4679d 100644
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -606,15 +606,20 @@ int flow_indr_dev_setup_offload(struct net_device *dev,	struct Qdisc *sch,
 				void (*cleanup)(struct flow_block_cb *block_cb))
 {
 	struct flow_indr_dev *this;
+	bool replay_added = false;
 	u32 count = 0;
 	int err;
 
 	mutex_lock(&flow_indr_block_lock);
 	if (bo) {
-		if (bo->command == FLOW_BLOCK_BIND)
-			indir_dev_add(data, dev, sch, type, cleanup, bo);
-		else if (bo->command == FLOW_BLOCK_UNBIND)
+		if (bo->command == FLOW_BLOCK_BIND) {
+			int add_err;
+
+			add_err = indir_dev_add(data, dev, sch, type, cleanup, bo);
+			replay_added = add_err == 0;
+		} else if (bo->command == FLOW_BLOCK_UNBIND) {
 			indir_dev_remove(data);
+		}
 	}
 
 	list_for_each_entry(this, &flow_block_indr_dev_list, list) {
@@ -623,9 +628,17 @@ int flow_indr_dev_setup_offload(struct net_device *dev,	struct Qdisc *sch,
 			count++;
 	}
 
+	if (bo && list_empty(&bo->cb_list)) {
+		if (replay_added)
+			indir_dev_remove(data);
+		err = -EOPNOTSUPP;
+	} else {
+		err = count;
+	}
+
 	mutex_unlock(&flow_indr_block_lock);
 
-	return (bo && list_empty(&bo->cb_list)) ? -EOPNOTSUPP : count;
+	return err;
 }
 EXPORT_SYMBOL(flow_indr_dev_setup_offload);
 
-- 
2.43.0

