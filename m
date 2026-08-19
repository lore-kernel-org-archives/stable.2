Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C2519F115
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787098555; cv=none; b=l0anJ5+jRD4K8VgYXG3+NNTj1UEUe9KV4jsERxrlxRMI8kywKI/xjyx9lTJb4sJAdoaUXKKyxC8zdehVR3yz4GFyFJwA5jSTY8H2dqMWuq8D3ivmrREGdb0Wv7nZ1sjWJCNSbVw4HVgtaJN7i7tjgaKFvySvuXHlcrLB8nHOP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787098555; c=relaxed/simple;
	bh=lSHEsIRib9siXBZ0/PV/c0AxkrP1+Nibueemuell8yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mC/vEGpscb51UGI4qhXqi3kMQCHQiF3AYQ+XjJM+bn39KE80NPXGG2pLs3Gdz5CoGYqbckbfutDAZ08ogVV2pBJRV7sQ8YSiCRfDknRMtESsYU78lcGgmdf0XhKmmf7kciQzEWtstS+LOh0StRAO08iHhd69pKvsYZuDXtRMT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ce0Pn2AM; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ce0Pn2AM"
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 305DE3F301
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 00:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787098551;
	bh=14nD57vBDEhsz0A5DXNuyBynoXCz6QiaxnRUM+B2EAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Ce0Pn2AM7D3fTzMQT+w7RfL9zGpB3f04LRTHjhTrXUZyWettl3f2OGkcy8Y4GreXk
	 4M7vQfROxr2Iz43hHw96BNSJQ+6Hg/eLVtU8BIA1CttJHCv6PweSY4iM35GZ6ucF8G
	 k2RQtkIAWcWpUAm0a7HtIZmTn1kGMHf6fJX3/WBcYKsBDzBKJAb6kjMXcfDr07cEuw
	 +fe/iuE0ipeSQBG5qO2JhNhm39KEy0xUv38As9QvdrB4GUF2wJ/F4Lah9tzykqysNm
	 xMKqUZFux3Aquac8/0WQi6bVP32FhgOR2NrpxUyNVL4Tewo3/mNVxXpG8WdldD5hwr
	 XZkrdEYOVujrQJ/sEVrneMmojvzZLTis2YKZFDjC0KnV1MaRimScoxVUsFmSBA27HG
	 /RJWyyP88PYYOrWA8uZpYXMlEyo7u6SPgZ0aLrXCvl72tFW8OaT6pYYjYtR3W0mbyp
	 I42jwOHkzgMMYVmhzxsNHXA59nr0K4KjX+S3x0gTh7Z2jpHZ8YL3pzQLd6/OCwPFQR
	 Hijox1X58R8glMX8F9+JK/lMSpm+3pKtoErDtZYTJOmht03nJsZ7JUtni2TTO+lQZV
	 6sFk4H19TyBu+AWnAOlpXe1pl4ER60VfQ+e1Uu4y7Fou35Yr9PTToEqMZJnppIiTFt
	 MugikJl/9fx3Z4IKn4LqyZmI=
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b19ce23e5cso398698b6e.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 17:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787098550; x=1787703350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=14nD57vBDEhsz0A5DXNuyBynoXCz6QiaxnRUM+B2EAE=;
        b=smZOBI1Obp+4+mznb9pfNxlBMBhmQ75KReyddPAHoJLKmkMu7a4hkIargy7ff87dGN
         6UjAqH0mAjqxtDu9pxvGv0AWq5+KZY+m4M5mNNCxurdirRH6w7PxRDUdhwrkvBSoFEyU
         ivIsgD3idjCjQQajCixQILQypfoPcvAN4+1z4uHaThHF1Nt8DvN6zi5e6lGOaSToDuMf
         iquQWUcFEiIquxi2C3yhrJ5NiYXH1hWGE+DBc7jbhSbetWUDDJpEmvlx3QFjpw09T9Ok
         7O4o6ZX90RNOQBoLST3DJu3iAc+PiNibA+VK0XaOXapwBg3egBz+FAFeDEG40Aj0PrML
         Dm8w==
X-Forwarded-Encrypted: i=1; AHgh+RpVIpcjNwDTLqxFhTYh8FZFHCm16LOBi+PMovZAVtzx9l94Ot7jF2Km6ucjZJ7xofuCH0YJb80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQlE8dI7C1wTKHpSCZTP/6mn0uGv4cObaF0OoeAM2h3cJaPCiR
	a58YsetJAPbOipi148Jxo1JLlZO/SENEZXYnwMdqKUKFbrMZzfY48uB5nXIC5MX7NxOrRoYyCrO
	9XfFqfAtk9HBvKCzMrJucG5N+ZE7odAWNkm1LXA6KHFPoaMfvDmY2HptnQAFRuZRGQF6dFYLvZg
	==
X-Gm-Gg: AR+sD12ML9/DaeAIDmCwWGDzm+jFpFgdKznAopfKdHChDkoa7AADKGJopYg2UB7hBxy
	Mofl8pTd4xgw7mMeue4TwWrSErSPlDIT9Hc9z9XXztALDnf32Vbtm8x9BikEu9KQYFPBmYHwKS+
	gsFDGke3Wbx4GwftLU9voEF+ZavwuMxh9VB4AMOrYXui5+6OrRdtzdk+FNBdvVEf/IiBczxdS2F
	rbq6a5PkGwNVFH2kW9gmHjCU4BLFWr87F8byvsv9hr7a+E87jw7ZlaVDEyn1MzSuyyyV146g1W/
	xtmuB9qn03LDLgT03HY3Sx7LhMtJ7ExMrwpMjulCB1JpQijAP2W6d02JP7DM9Zn5rDjz5i5e25s
	CdQbiX+hNmUKx6c0V2M1qkApsxn4=
X-Received: by 2002:a05:6808:3306:b0:496:e0:a46b with SMTP id 5614622812f47-4b2bc883003mr495913b6e.3.1787098549936;
        Tue, 18 Aug 2026 17:15:49 -0700 (PDT)
X-Received: by 2002:a05:6808:3306:b0:496:e0:a46b with SMTP id 5614622812f47-4b2bc883003mr495869b6e.3.1787098549551;
        Tue, 18 Aug 2026 17:15:49 -0700 (PDT)
Received: from localhost ([189.163.105.101])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b296129e2fsm4587224b6e.17.2026.08.18.17.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 17:15:49 -0700 (PDT)
From: Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
To: kernel-team@lists.ubuntu.com
Cc: Jordan Rhee <jordanrhee@google.com>,
	stable@vger.kernel.org,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
Subject: [SRU][N:linux-gcp][PATCH 2/2] gve: fix zero-length skb frag with header-split
Date: Tue, 18 Aug 2026 18:15:32 -0600
Message-ID: <20260819001532.21315-3-rickey.castillo.valenzuela@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819001532.21315-1-rickey.castillo.valenzuela@canonical.com>
References: <20260819001532.21315-1-rickey.castillo.valenzuela@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jordan Rhee <jordanrhee@google.com>

BugLink: https://bugs.launchpad.net/bugs/2153950

When header split is enabled and a header-only packet is
received such as a pure TCP ACK, GVE will indicate an
RX SKB with a zero-length fragment. If this SKB is then
hairpinned and sent back out, the GVE TX path will emit
a zero-length descriptor. Hardware considers this
an illegal descriptor and stops the queue, causing a
TX timeout and interface reset.

Fix it by not adding the zero-length skb frag.

Cc: stable@vger.kernel.org
Fixes: 5e37d8254e7f ("gve: Add header split data path")
Suggested-by: Praveen Kaligineedi <pkaligineedi@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Link: https://patch.msgid.link/20260807224315.234152-2-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(backported from commit 6bf14575c65569dcded90ef78afb8a6d57323f04)
[rickey.castillo: Fixed conflict because there are some missing commits
 that added gve_free_buffer() which is needed to apply this commit
 clean]
Signed-off-by: Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index e6decc0e7a30..51b0dfd9c6ec 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -811,6 +811,11 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		rx->rx_hsplit_unsplit_pkt += unsplit;
 		rx->rx_hsplit_bytes += hdr_len;
 		u64_stats_update_end(&rx->statss);
+
+		if (!buf_len) {
+			gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
+			return 0;
+		}
 	}
 
 	/* Sync the portion of dma buffer for CPU to read. */
-- 
2.53.0

