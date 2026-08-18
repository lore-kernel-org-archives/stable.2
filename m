Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F06381EB0
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787097203; cv=none; b=id7G+LZYvDnpSfp+MpOAb1Dq2QGxAhN6FAJpW7Ne0e5paJjOO7ftT7iz9eGAb1nmezV2zrzPFTC8Xf1NM2w2JGuXzyWgchRISCnIENnFElo8VbcfNgCfJdCR+Fd4a1+mbk9fKb+sVKs0VJhKzVIY7Mo23HO59WZDxFBQiqP5r5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787097203; c=relaxed/simple;
	bh=lSHEsIRib9siXBZ0/PV/c0AxkrP1+Nibueemuell8yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYnCpvbX4HLmFx9wjNzhLeRccybZGLEPycwWWGPOx9CmcwLUvFfiCfKK6uML0DgsVi+sTTRjfh3xiRwFi7adkn6XZkVjWzftpkz73i2SJ3BYFkLHjZtwdNYhTNN5Imf4qj3c/GXqG0CXJvmvGcrzxYkdLkrmZjfC8qZpnyIfRes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=O+SmRpVy; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="O+SmRpVy"
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F24983F0B5
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787097199;
	bh=14nD57vBDEhsz0A5DXNuyBynoXCz6QiaxnRUM+B2EAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=O+SmRpVyj7HO7ToRLCRBv+hMsMiztJMSqpe/K0j3MaWriRmukjOJosSw5H7dkA4BO
	 6D/Ls9XHHKGMO6IVU81MhWRAJt6TsTb6RQYsp6OjCIOQTXShXSLVcdv3iNG6LE5qxy
	 CBYvp8I388DVraOGUKZekQOgcNjuB45wuw48u2vnpGH+tCM9WvYAlrZPFiTC65XknY
	 ZvTyd5G6ms4VLnfsOGU0eZtf4Su2XJF0yPxhggJ/T2jHAdVmoWfCSM0Nr+Pj6jvC7J
	 InUFi2pt/ooa29tBOHW5HJHoRpVueQFTrG8TNh3kb60gud/44yrV6EHKyLMSOry0rV
	 iFhgGhV9WG2eO3gZHxtcp/wT61ndIM7+2BfCZuxvGfumOzXWW5E2FZaU06OkXrMY0K
	 NUA6WI6yRmg29uEEfjtdnPI8mHHTSIqF4eScMCLoKn1H+5/AKybuta/sciwESuvoee
	 K9XYP4lpiUB3MywEgAMBCSnPhYbxDlEqAGiyT1AEfnKhGdkD6Yf5mlCT6kOkx6m72Y
	 o8uUr7G0bxsbfuY7pZS2BfeHIWfx+4DeZLK/AN61YG0h7xj6mJZvK5kzNnI+l+HxWx
	 Yrp66pvORhTvUNP3TOcgAk/cH+QbNk5qF6OSJTgJG0ylNyfi0sQwCbs3BUALpI4wJ6
	 sWAnjfcjbX4TQYYuAuRric/U=
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66c4740d823so3843288d50.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787097199; x=1787701999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=14nD57vBDEhsz0A5DXNuyBynoXCz6QiaxnRUM+B2EAE=;
        b=GOjCb9nJB9STIXxd/xPsh2AsqdpNwj3/x9XTJcuBDNSsBGN52sTs1pQJMP0pMUx6hX
         up95dXN5BiAQD7ewi0Wn+lOJR9WLgwHgO3+Os7/yuOgfPqekX8eN8ky+ehg4Evq3xBfb
         4ES6Wk40QNyaWEAvf1TrH685ZhzLGbqbHgzPaDQJTdGLBmG4t6CBAz24Cm5L46Bjnx1c
         754qXxyx7mIe2Q7YALdhhjy8ikYTnRRQWL6O/jX1VQULLcWslT6OFWSM1bHDTQYISYHV
         YHkGGLggEyxosjPfTYy5LpXPTG2oZfB/2Zwfj+2z+o4keKqA90oPI3GioSFYoNu2re45
         H3mw==
X-Forwarded-Encrypted: i=1; AHgh+RqnK+QqhX6QaRH06kb/URj13klNATEDBMSTzK/0CFIFili5INL/SqV8BLMKnIOFg7T61ZbORg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1rvzOSBfrrYa346uqjafurHjK8X/qgFTN6qIXtbBDQi8ty3n
	irAuvT3s9fNgXBoQROopQeGRNzXcTFdzujYV/k9VE78730bXzFqvS2w3on2FnqQDVnnQzqiBrpf
	zplJfMqE7jRCxf/tucOy42IlENvz5E/71z4tkkdQV8QnTbDNTsHNu3h8JJoWAIp431xHNLRBIfA
	==
X-Gm-Gg: AR+sD13lKJt+xdEeIJrd6ys5hloxuf/I1FQ2262B47fopcbL5crID5CTWQC5JJgp7Wz
	1YqvJ0C+0f6HDcVqUQjXYPrakxkmwKykM23LD1XJ1cy4Ze6Ju+DHNjNjk7Ouxl83a6/8SJO8vhg
	33Qpi211wWAOIMAN1FDUnqZDCeGKUE/fVQBk+csIR8p7GrdIrHjIpLlOV55nRSxvBlE7EOFjT3h
	jJfnQN0600GRYh1XybM8XLcPDhAZ8khLEoCcqsFcv/IRsvfzWEiZPdCgBMu/w4WFHujtzMK7H+G
	ramem8wQc9R5J8DDsHbsv9F513n48X9PojEYQMIKZ+GXxsQn3FX30AZcabnes2nEP0l4AsotIgm
	hMv6+8GocyXPa/BA=
X-Received: by 2002:a53:b641:0:b0:662:ba96:9fa3 with SMTP id 956f58d0204a3-66ccb50eeaamr245658d50.3.1787097198826;
        Tue, 18 Aug 2026 16:53:18 -0700 (PDT)
X-Received: by 2002:a53:b641:0:b0:662:ba96:9fa3 with SMTP id 956f58d0204a3-66ccb50eeaamr245628d50.3.1787097197791;
        Tue, 18 Aug 2026 16:53:17 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4bc4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66ccb006fa6sm215034d50.7.2026.08.18.16.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 16:53:17 -0700 (PDT)
From: Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
To: rickey.castillo.valenzuela@canonical.com
Cc: Jordan Rhee <jordanrhee@google.com>,
	stable@vger.kernel.org,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [SRU][N:linux-gcp][PATCH 2/2] gve: fix zero-length skb frag with header-split
Date: Tue, 18 Aug 2026 17:53:07 -0600
Message-ID: <20260818235307.19435-3-rickey.castillo.valenzuela@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818235307.19435-1-rickey.castillo.valenzuela@canonical.com>
References: <20260818235307.19435-1-rickey.castillo.valenzuela@canonical.com>
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

