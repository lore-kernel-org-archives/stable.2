Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BBF3368B0
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787096562; cv=none; b=tZWus6oaiLr9I2x3N4YEbfQFho5neDoZr9yUIa4BXTEcglXiRjc5Vtl7CbhVW6wlLw+tUCQMnTq00bUFBZVlu7IrWxmzZosg4Wb+hnld1g6Qlsjv/Y6cLrWU6MTwTpX49TmKAaNSLf4XKgeoaQ0mtF+HprGu32U+8pXXp2HVjEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787096562; c=relaxed/simple;
	bh=lSHEsIRib9siXBZ0/PV/c0AxkrP1+Nibueemuell8yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViuGXgQ8xwIFxqxTkodXaAguSi9YHTzVRwetiZDLdImjJ2Gf6wJZCjISkg8kHASbIujkThZRroibCeApjec7fQl3GMaSLhv2tG3zO5RIos3qwyQZ6vhUbmS8BHcRdO48pa3Wd7DxRhLcFGCK85czUxan+TJ1RMvlTCHiVp8FnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=r8portc0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="r8portc0"
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3A3223FBD7
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787096558;
	bh=14nD57vBDEhsz0A5DXNuyBynoXCz6QiaxnRUM+B2EAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=r8portc0lenV9MnXH+1yL1loPmqjLNT+Vuio/FgZJ9z1SjRAgSJjP5u6M/kBlyv6x
	 nfHiR8MQfyhLXJXTVc4/A7yJR9K9DY8/DDuxzO6cqboUphVTtuFqDzM+R7V1DkKA7H
	 SpEsxmN/kPOUe1cjbLustH0I5QYLcohDAkCmGM+WgLe/tIsSaS2uAinsbWou7CnAlM
	 bJJJAVJolAWDga9EwxR6H+x31tOG7+PC+1VDqHZY/lW/kczDlgKKxkWQHGDkUpBrAq
	 QbY8divty3y0+mJAxOC/b9GzdiU5TvmkVbeW+7Pz4TzNi9iiWTngbC83DmLIGXmFnk
	 BpfCuTnI9DYoCwNxJCPxon5IGEY8zbBN6DkI7yxGTKeZKLgZvs75pZmvyTIFCAAHfk
	 3Znm3hnjI+dINjM+hlmaK5c+UuqOu58SRknlH7pV5Z2G1i2Ew0SshfhqumVsO+1Y4j
	 ZWkVNBRd80P4HvaoMKJw2F66PvzlEsJ6WdiUlW+Tg5LQb/NKHxJKguDvCfMxBctoss
	 NcUxMzMBpJ9fsJwEx1DkES2mPdTQO1GR64uKzJuCS9ijrsu8oXQLd032oeIfcgFC/4
	 OMVbSSLdjf13Ep79QUe6QGBtZThH/vYnevwVILVo6ArnZ9zt+XZ9SgGs46GJRiRLvc
	 jfpEBjBo0e37ZVnRDX2pzz6E=
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66c9a74e47dso779496d50.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787096557; x=1787701357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=14nD57vBDEhsz0A5DXNuyBynoXCz6QiaxnRUM+B2EAE=;
        b=L4kg49/2x+GVqBfgdGP6zOOcTH9ymtgrqP9vrvc6PHNawqVahP+ddj8lqYMqTFwOcb
         I/bDJHK2YKNiEcKM/tuaqY27w8KG2rWnJQjso/lq20m9MF9kr+emXG4gUlaRJnDsHLew
         IYafwboeVHV3IFU1FEYnQIWUdheSdpsoEv7Sv3n8ZivPZJWKaXQXEMU6f3OJNx8UmKWY
         wPEDbXOXvNelvTKHh2HaosOHGjiAZfnJHpbAMX2R9f1XtHQ+ASNIk0B14Wfoj3C63PtQ
         QxEipN33bB/9xvYfCc+x3JMuysY1siKF240/owf01rxKkkN2tCT97QClt1086kUnmQvM
         aoUw==
X-Forwarded-Encrypted: i=1; AHgh+RoN2r2NTwufg5Mf7gHJeQ2nw2A3IHCx3NTxlWkFfhqCCdkcQTjUal4o9ITK33pLcKs85HGQdJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZOhdfBr1IBsiTMMQesZE2SOr7/dlObbxq8VL4pjpKAZF/B0Vp
	OUfHC1ooms/ztTaK8LQJPnrK1ri18KxsuSAMGW0D5cEE61m95Yuy9TF9dwSfPHn0ulpTgZkLnD/
	4indE0fVuhF1QW1gOeYf366XcDtmY/kd1BjZgcU9nHvMMMZm2iNTPlmd6rafmYB6Io5GLIOWkKg
	==
X-Gm-Gg: AR+sD13mPNNvLi/x9pDAICo1XNYvX2PeAKu25jpIIA8r1OOpOQi465jGjhaYGJnL4+7
	MissnjnRdV62uW4oBAdJh9yai8ImZEmUhdOXK2CxcPXxqjf10+esXEmVda6zOgE+dQqNA7QxjtO
	1mEPd9QPv1THLjAyZKN7NsTEmVua+jw3FNZYbOulZl+vPfZ/UEqWnZ+ccyhJa51NcBjSt3GXr7y
	PoWv7cQOUdLj8Wv2wte5nTIYFpdvwaR3VBvoRFFw1wV9X0pm617j2CXUOPQlBcdHhdh0yTT+ldQ
	gQqR2JueGuaRCc1jofxoZqEqkr1W6XycCX7GAUL3z73a0U+blUofjhlSOUh0Yl0LAvk9jDmsbKZ
	oiXXnMIk+mnq6XqA=
X-Received: by 2002:a53:acd9:0:20b0:664:c5f8:e342 with SMTP id 956f58d0204a3-66ccb4c37a2mr237296d50.3.1787096557068;
        Tue, 18 Aug 2026 16:42:37 -0700 (PDT)
X-Received: by 2002:a53:acd9:0:20b0:664:c5f8:e342 with SMTP id 956f58d0204a3-66ccb4c37a2mr237257d50.3.1787096555644;
        Tue, 18 Aug 2026 16:42:35 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4bc4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66ccb144b05sm183805d50.12.2026.08.18.16.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 16:42:35 -0700 (PDT)
From: Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
To: rickey.castillo.valenzuela@canonical.com
Cc: Jordan Rhee <jordanrhee@google.com>,
	stable@vger.kernel.org,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [SRU][N:linux-gcp 2/2] gve: fix zero-length skb frag with header-split
Date: Tue, 18 Aug 2026 17:42:26 -0600
Message-ID: <20260818234226.18814-3-rickey.castillo.valenzuela@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818234226.18814-1-rickey.castillo.valenzuela@canonical.com>
References: <20260818234226.18814-1-rickey.castillo.valenzuela@canonical.com>
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

