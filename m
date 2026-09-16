Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C23AEF55
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 02:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789527149; cv=none; b=cxrd2VcFCUYm11/jw2qY0YOPQrimA965mZvCK4oK3oByN6gNMqelAaXegUjc50rmDnMCmbELcHsNbygwsvdwIIhpjFbmrNrL46Qa3vBC2RWZOSXLuNBkT+wE1yI6y+bmF8aLoVJz5NZzzIEVsDSosbeFlrOSR4KbZVn0ReOvXNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789527149; c=relaxed/simple;
	bh=tX9M+W6f3YXesN8e9sqc2endp/ilgoluGKgnYvWZ2YA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNJBw7d8imjjvm2iHZX8lH60bBgxBAlgPAqt2LNfehq6BnnbiKErZSe+tW2RzWgu6KaS4uImOhzIqxbiNTqFobXEXLuMvdxyoRu1ilfC+kNmvfqJzvEd30Q0lFXP1fHnaIlsTwQzWn7iefOySi7cqtYYWxHukjeATeg0LvU5tBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUY8FHpt; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUY8FHpt"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a33c9cso464228b3a.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 19:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789527147; x=1790131947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4i5M/+Fcpjtf5aQ6npx1txWnbcVS6QYJviLzGTvfRwQ=;
        b=rUY8FHptKrMiwUG9/g2dcbDsRs5GN1MoJKfwS+ruKhBxsaplrnQUPoCL1VtRxbNJrk
         +axtsUUEMS+O01Oc3S1t5c2S4RoqEdV8QG++LdyCZUJtBBFUSCu1OK1TtTkvF7JxCRum
         VvJB4EeHxd0eJDKwLCBVmAsQb/H7alYhXyr4gQHjETbGTt30CLe41E6c63VzpDfolKWS
         3Eo4Oa6Uqc5tdR6uTpnImwCV5+9aVO+3ZzCIYHgNrTo4dUmgeuXKPM4hlUreThujHzhG
         Bqae+uC+FhITtVyndrG+FcixTDTi/B4YkK+VvwhKBk9oIbfyvETlSJwKDVpQjSPKCdb6
         CUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789527147; x=1790131947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4i5M/+Fcpjtf5aQ6npx1txWnbcVS6QYJviLzGTvfRwQ=;
        b=ZJCHOzUrm6h2nQJmWEIlrxGbruh85yEZ88yuU934NzN1PjCILEgYOJy7+HYwGrOONj
         BzbwDw/WhG2nzpfyDdHl75MAacU5IFL/30jHMm3z9MvFSk2fJ9J8N5RZrzJKG9UAsjNl
         Zcx0K/qvPeJI5f8v4E3uzlehkow0ruowRJx0Py5bIdGYnAsnPuDDyAjjVWN8JUf8xzQz
         Raf8s7eBvO1SUNj7xj5q4kSbSqvO1ttC5QYCAZgK64alTfbRK6PxRC15qYAggGMU4cJd
         kXMpE4v/MS96mzBjfa14BhLw2yfncIK+ORxFwIBNzpq8vD7RE+EciGSGt6aGUTxKcHW3
         Nk1g==
X-Forwarded-Encrypted: i=1; AKwUvBxXxyroY9CoLpqtIBXJJu+r7QPAOmNYlL+1bJfXv9X1g7DJBao593kR4mtmTxiDXzo7VWnbEhU=@vger.kernel.org
X-Gm-Message-State: AFuF++m6UjV1Hoj3dw6vjhlMmQ/Od4SONNWOyvNwpUEVkAxqpPVgY0Mh
	j9UauraM5HRO33FkEqLln1A8d6M4abgfTSPfNQs288a2tI1VKGeWoh9y
X-Gm-Gg: AYBFou0rR33T6Ydaxz+YfnxOgs+y+PC6Y399AKTsc7SuezLVIG883VqcIPUJ24Tu3dr
	i84kVamHdtqbYAM/746EYGPU250WSoXw/G4D8I5CtRteMlwaZX3Xa/wrQPkzkFO2mpJvc+JcuJd
	RsLEgm+4gDvDT0K3ANYqb8jd9lbIppX0Ya4JcQuypeNiYXSHJMiCjbrEBQmbyVZA22RbXS7ALBl
	dxpj3ERVdNx+uizmL1nnccot4/CSQhPYIkO09XeXLT+9FpzHSBiqMUZSQr4INtk2VVFXE5l8DKp
	LswR1IuUwd7MQsJ4+tJKrOoVoep4FubCoum7Ajj2063dju72J1yDmQEfcJ/RxhRgkvzzmnH84xV
	exb3bO5CqKFeqmgpNpDLqcN4paEJv1I7UYjg2k3U9DXH8vnJnLNgwN1wr/bF+8sACvyYhTX0ICx
	dbG1DnviNS2lof80/wEvYOVdRXb8vBWUdw38Bph+fKym+O9f3y7lteNQ==
X-Received: by 2002:a05:6a00:4613:b0:851:c2a6:172f with SMTP id d2e1a72fcca58-8723b87eadfmr1399876b3a.7.1789527146998;
        Tue, 15 Sep 2026 19:52:26 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8720172b126sm414532b3a.38.2026.09.15.19.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 19:52:26 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ganesh Goudar <ganeshgr@chelsio.com>,
	Arjun Vynipadath <arjun@chelsio.com>,
	Casey Leedom <leedom@chelsio.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] cxgb4: fix FW SGE queue cleanup on remove
Date: Wed, 16 Sep 2026 10:52:15 +0800
Message-ID: <20260916025215.2780658-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_one() allocates the FW SGE queues with setup_fw_sge_queues()
before registering the network devices.

The probe failure path releases these queues with
t4_free_sge_resources(). However, the normal removal path only calls
t4_free_sge_resources() through cxgb_down() when
CXGB4_FULL_INIT_DONE is set.

If the device is successfully probed and removed before it is fully
initialized, such as when none of its network interfaces has been
opened, CXGB4_FULL_INIT_DONE remains clear and the FW SGE queues are
left allocated.

Release any remaining FW SGE queues when removing an adapter which has
not completed full initialization.

This issue was found by manual code inspection.

Fixes: 843bd7db79c8 ("cxgb4: Setup FW queues before registering netdev")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 1ced6df6eac8..146419c66348 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -7116,6 +7116,9 @@ static void remove_one(struct pci_dev *pdev)
 
 		if (adapter->flags & CXGB4_FULL_INIT_DONE)
 			cxgb_down(adapter);
+		else if (adapter->sge.fw_evtq.desc ||
+			 adapter->sge.intrq.desc)
+			t4_free_sge_resources(adapter);
 
 		if (adapter->flags & CXGB4_USING_MSIX)
 			free_msix_info(adapter);
-- 
2.43.0

