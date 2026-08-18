Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8F38657D
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787097148; cv=none; b=Cg4ypWejPgRVRkrgTb8BLtFqju5qwTfMxRi5A4aHSN9VdTgOMt26wtnfKtkQsKxbEU2z6oqV6ibs2oVIwghMoin+OUNyGpZbHIr5dQ9ahRLZKHSbM7IEB89OQtBzQeXXal+jI5fC8lq87aRpHSzr05unaUQtfHZcjDOn755P25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787097148; c=relaxed/simple;
	bh=lSHEsIRib9siXBZ0/PV/c0AxkrP1+Nibueemuell8yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTLwgdT03sDJNhINXjnYJsDppI9x3dyqOPJHyhY5m1EKgAeMPNHJCHvJ30LeTtoiUWAWfFj3DcPqznmaNxGCBkay7Ccb8CltqOb4SDu/1nC7nZJJGn6RYnNcAW6q410qRkO29dWPmXUSv2RCTrfuTCj5EV7nRd/W8qjDweY3XvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=SyqPTTq1; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="SyqPTTq1"
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 466C43F1BB
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787097143;
	bh=14nD57vBDEhsz0A5DXNuyBynoXCz6QiaxnRUM+B2EAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=SyqPTTq1CRlKRswLPknM9ZDhUIpoSkBqyS/enRzj7FFN3h6V7T1h60e5wGbGTibvJ
	 tTe4hhuSm9sUXr0j0FuWH+e4Cw1QO0GoAkrVzl2z2boIa70//lZNiivQeK10VpBbYp
	 F/eMxVeBkQSz6SP4ohVc8Ka54qMRnK+qHofkVKnlTJdHrBVg2v0b7DAkS9aWVWo135
	 DAcjEyTaOc+EnJMjiBunIEj3DFypH8SeUsDsH5iRwgcfSZhsy4wheLcPINMg/b4xfo
	 JNPMzqWgX1Tv7eM8uzZdaemJERjmT/yOW8BGz+xb95mBpXxwc1q+L9L1C5kiKu/gRr
	 /EJKwP7BdLGN1y0TJWP/Y0Z18IMy+yy0lcj7r3b6uZAsT/gCAP1xq9tmIGaHfqypJL
	 wLYtirzAHOTLbqnXDWYLy1nOT71QqCas61eqxLyvGF7XpZxAphS4pLXbCck8z1pMfu
	 B0UMqtn3Cr8iC1cfvGYopgB42hGUhK01C+tWRWa4Qrsa48qhqfLmKEKKkEtuGLHWs5
	 RIlDR0mrgq2AH/AWeA/IL2dSxa/fSTuIpJsBdjYV8+HbGxYJdd/2rPTlm1SLHtDBLR
	 aR918QmT3br9u0JswmXs7xnSvnmGVBw7WK3cw+i2DJN3mK572U4QE34hZm/vwdFoLu
	 WZy1pFhNyG6flVTH4DGG6od0=
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e735bcceaso9645167b3.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787097142; x=1787701942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=14nD57vBDEhsz0A5DXNuyBynoXCz6QiaxnRUM+B2EAE=;
        b=ki7u3iz4dz2ElfoRjxPo9pHKplb+g/HROcHMAJXq9my0RjO3g5JDp7BBna6FGA7/wW
         oGhP1R5gimWAD6s0kavKFbEumF9aTK7aZ1QKKviyZUo0uXAwcGaG/u/8+cz8SXvjH5pC
         BHPqZ7Q4zJy2APjTPBXYpVb2pUOivMVj7YVn5QZyxtnA7UTlXZbNfATUlzTSoejXTT6U
         RskFi6bUrvuY1QvkdGtNgr0CQ5U4VQkwxgI+ehwg30lhrYQe69uclFCYLduxak5J4JIv
         T+mDzFF2+hNBV8P5x/katbjO4e8vVclxpWzpid94ih/kQjxK3zG3TP9jU41BLQTmwTVD
         ZiXg==
X-Forwarded-Encrypted: i=1; AHgh+Rrc28PmthA1OW6W6jqWZI4AmZg21RBCmeqb8j5V2XvuyFlzR/q4HrPmgc1lva6ZWi0REc3ZyZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9pAVUJ+H08E2nRbf1Zj4Hyhi0EWdEcVW2TWU1/uyiP9MQmD9c
	87lFYcBYpux5jUuxxaUhc3OFzOlWO1RJ90iL3kMsRrEM2IQG2apBneiS+0ammDLe8jVUT5pLwYj
	UjL9ivCA5tJt8RrEfw0WT6e8HQifLQhAgfKAlyLLn4yy7QNi3t1tux1Ilm9XV5iPqzU48+f4Abw
	==
X-Gm-Gg: AR+sD10AQUKCe1cVL8/sFifUw53Nha1VXUocFL6MvLx8S4L2bpoUOPpAoyMSo22G1J0
	ak/jfaH/98AiAPvwEkNVODX0blnAuBwiwoMi8kkapWm867SoGwfIly1IEMRZI7h3OkQQWUTgZY4
	iTLtb1z3qTtMupYbKniDadY1zfXxtih0cE5DJp0s9uit9zGfuXgyegjGOqOgXyGGQAShAn3Cg/F
	ARbyiRh1mIYxX41DxZ/kyh5KOfQ8opbQfBqOi4jNWW67QH6T7j05Y0LER9bVRPbkjRucmzof1yN
	psUs7ebdY9gN/x0CtJhdAFv9igyXqEAUgBSV0GjFgw6syiM7ykugUAoi+enRLXKxgzcUFH4wy/T
	8Vkk4UIWs9j98fr0=
X-Received: by 2002:a05:690c:e3e1:b0:812:a680:e10d with SMTP id 00721157ae682-844de4baa70mr4745147b3.12.1787097141989;
        Tue, 18 Aug 2026 16:52:21 -0700 (PDT)
X-Received: by 2002:a05:690c:e3e1:b0:812:a680:e10d with SMTP id 00721157ae682-844de4baa70mr4744267b3.12.1787097140224;
        Tue, 18 Aug 2026 16:52:20 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4bc4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-845184cbe7bsm798027b3.35.2026.08.18.16.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 16:52:19 -0700 (PDT)
From: Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
To: rickey.castillo.valenzuela@canonical.com
Cc: Jordan Rhee <jordanrhee@google.com>,
	stable@vger.kernel.org,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [SRU][N:linux-gcp][PATCH 2/2] gve: fix zero-length skb frag with header-split
Date: Tue, 18 Aug 2026 17:52:10 -0600
Message-ID: <20260818235210.19330-3-rickey.castillo.valenzuela@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818235210.19330-1-rickey.castillo.valenzuela@canonical.com>
References: <20260818235210.19330-1-rickey.castillo.valenzuela@canonical.com>
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

