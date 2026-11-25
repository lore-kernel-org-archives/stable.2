Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621673;
	b=ebNbRSb+SQUTJ7XJDwQVZryMCQa0bNEZXtf0yn90vfSa38+TseAnDXtvGhqWLaXsN+3T
	 S+h1eEhZue+ePI4NJoCpZtWdkx2Q2H4uc270i5mkBJsz7HSuN1MU07fK1hq3Vt3pGdx1B
	 +yKs1Zu84SwY1k4zokjceLZRjTPxzf4q+UYAyK0VdCxFF01Mk3L6bO8BmXRVa4SY2ArfX
	 /7LtLNbLh/xTM8D4S837LikcvM7O6YtYPextgNv48G1fHmb8DIB9ezsDqFV0i5tSnzCB9
	 jF7ZpJ6Ch1apZY4wb5izVXdh2ooNRwfOt1p9Asc6h+o8W+NYdaZRnKsUFJk3eMY0IDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621673;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TAPOs8VLo+w1eQz72VyyceN5GRJMCKwBWiE+B8c0gNA=;
	b=sNlCk6/XWcbdyQ7ZRxLSAxr130sAA3rrYYvlKMElEs0lJbmlG+3OrDIki5ZY/EmTcy7y
	 k6HThYT0EH4yf1nCkTFLt+3P+FW25OtGc9rRgFzRW40Yr5SR1dIWIQWTw79w5YzOC0+xK
	 Guw6YK8/IYGkfikz4M4/E4VzHx1m5Y6xfHxVU5/Tyv1077eiQBMr9CSMqCCfyTdXeUxij
	 Jo39zAal3iQFa6wCN9D5HIYzFfgDiu5nVBjYjrrSME6CgdOSIhmQx0Tlp50QKv3ehy+jG
	 qCUP5cEcCmvkJQakKb/QzNpXEIUQv7g1pWbcKC+FZxpUTGmGSBbfCUTeef7TO311PoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJtDJaCq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EBF606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJtDJaCq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F361F000C6;
	Wed, 25 Nov 2026 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621672;
	bh=TAPOs8VLo+w1eQz72VyyceN5GRJMCKwBWiE+B8c0gNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NJtDJaCq5wfM/A7wOxedm+D57j54J6iFJC65v5NdkOMMLTUU6fjyZAXUWMU2XUQ2m
	 SI4c1S0RoyGnRZUnUcQxSTiLdXsnyI+9Fp9L0JnzAA1xPHV6TfvBMNkaZh5/MNC6fl
	 EEXxG4W3Lp6HQdk3nGvPQldZ8TA7x3GH+ySCXnlV+WURohAJUxySzLIjPKWI9R+F0g
	 I7fTHcHTDY4coFFrbaMO07qOLwkKb2XXQ6rqiMKFSnwwkgIhvHEszo7dy2EATXNzPl
	 R1qhuBDV3NLakocQdYCAZtVNoCfHvd8eK6sQLsfXPhyt2jD+jtyWC5vX+IT/E9Z80C
	 9z5NSHGxaD+/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ankit Garg <nktgrg@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Joshua Washington <joshwash@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] gve: Default to max_rx_buffer_size for DQO if device supported
Date: Wed, 25 Nov 2026 10:47:46 -0500
Message-ID: <20261125154711.373322-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112542-scrunch-president-9d95@gregkh>
References: <2026112542-scrunch-president-9d95@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankit Garg <nktgrg@google.com>

[ Upstream commit 09a81a0f4fb7346f80a7340f725aedccff8ef8e4 ]

Change the driver's default behavior to prefer the largest available RX
buffer length supported by the device for DQO format, rather than always
using the hardcoded 2K default.

Previously, the driver would initialize with
`GVE_DEFAULT_RX_BUFFER_SIZE` (2K), even if the device advertised support
for a larger length (e.g., 4K).

Performance observations:
- With LRO disabled, we observed >10% improvement in RX single stream
throughput when MTU >=2048.
- With LRO enabled, we observed >10% improvement in RX single stream
throughput when MTU >=1460.
- No regressions were observed.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Link: https://patch.msgid.link/20251106192746.243525-5-joshwash@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: edc9a730ad3c ("gve: Block invalid ring sizes when device options are 0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 367a9f0e89b5c..f27b9501e3be6 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -987,6 +987,10 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 		dev_info(&priv->pdev->dev,
 			 "BUFFER SIZES device option enabled with max_rx_buffer_size of %u, header_buf_size of %u.\n",
 			 priv->max_rx_buffer_size, priv->header_buf_size);
+		if (gve_is_dqo(priv) &&
+		    priv->max_rx_buffer_size > GVE_DEFAULT_RX_BUFFER_SIZE)
+			priv->rx_cfg.packet_buffer_size =
+				priv->max_rx_buffer_size;
 	}
 
 	/* Read and store ring size ranges given by device */
-- 
2.53.0

