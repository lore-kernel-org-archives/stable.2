Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BD4E1C81
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646202; cv=none; b=E+ZdHUM5fx3ehoB4XCa0cIIfN6XGvp+4Qt0aRF5qshEunCDEDgIszVX37LZ0l4sjHSQq5Wup8Jm3Su8c/Wn+yCw9QRGxWd2kt5/ABCgJoj7rmR7T9uO6dloHQpIxZvGxDwoz/hPqiHAo0rdzhU6R9S6brIt+hJeZ6cKzESLIOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646202; c=relaxed/simple;
	bh=vblgVjmKLjnqZGvPgkCntjtx/0R17wWvdDbLZshFLYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=og2hJ5pUr6klCQPjL0radIsWoV9vlm4xp6iz21JWbXeHm2G7ATW9SbsbOcRTdGL076is4M8R8I+MMfWsqhiyNYINm3hGYFDdUkxsMssNRfCOtH7elDejiObxTFNZE71dDXtIAmUohb6c0/MeGc3QA5qZjAV2HEanlYjiXipgVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSXS0aWi; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSXS0aWi"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso7019955e9.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789646169; x=1790250969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sfSAIiiQdgel4feb27tEimyHftJdnHXovDfE5MDcETc=;
        b=YSXS0aWib9djmCbcYduOElRmbUr2+dvSU9vfgRCkf3c058OJK7T6dm4s37P9KufrXp
         Js/sOP5MAPmuCpjRJgqSLmC1LVmsaWyfLufBKXoui9uH4qVL3s58k6/Fs4YRPt8hns+e
         R4CEJ+BnuXW4TguU1oXGN/x5moUmGpezGd51ZK8rGKlfYxYZhj2vXjvruVzIK0dwMBHz
         ZtNgIhdAdZl3A7peeMIIkivZUbKPShnkHfl0molCteJQ1hux6XAjDcCEcgl1cRZoBxsK
         A54Jaqxh0kI09z/xSRXXVH37qvARQS9EoyVadTGK0fZt6xkHDRnKACGd0toWrkAKf0pi
         60Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789646169; x=1790250969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sfSAIiiQdgel4feb27tEimyHftJdnHXovDfE5MDcETc=;
        b=qHlITuCRRCdlPxL0FPe/PPUHxw7dfD8oxv4RsojZn6ezlav+fjX6VqLWu7ca53wO2B
         O7gaufaMyHJKFts9i9KpPU9w0K7aEBJKl2gGa6Xm3GwoZWbu7xEj+E+bSSm7ZysOR6dk
         zcJqPmzYBmySL9mW6daEKXsnCNH7IxW6l0sYVQFhSfyIu2rxdE9rwIh/4U9nRpwdcJDB
         lLB6FEn8MpenEXsmJHd3mP9vWhKVM2hy5VEyds+q1YomFh0HpRc+CosDZXVr572+MNma
         oF6M8N/kdd30IqMTTXhyrCxwajN+U6PrvN1j2IEoyG2f9hmILT08QpruVB0cXmmC3BRo
         eTQA==
X-Forwarded-Encrypted: i=1; AKwUvBylt6vtO1ezTJtN5ncL054dXDwww+BROg4sfLIpcBLBof086SObzq++QJlFb2bUJaAJPlj2ifk=@vger.kernel.org
X-Gm-Message-State: AFuF++ne+RdKllqdk16rGrNVJAFccfRe7MJVQ4atcHiYdBURFW5pWUh/
	H01BYhOa7rIVFNA22u1WOXKiaTx1Ic6Wpgo4p5KaPKezsm7hTdPW9Vq1
X-Gm-Gg: AYBFou2cyr8tbSrk1m8ptwfA+kf0uKvQ7nEv5PZYe24g72j35/GOAv4nXh3WCmxvanF
	20nwpjSVZCG+VIu6q4+5i3eEs8AmXQCq1G7MB44hxsWL4N0dQRw9V/PoKBS+mOeE390PzNu04TS
	QeHd7KfhOFIlE/9nO7IXTIWzM4NIHibgfPn7ivT86wmlio+VzD4lFv3RN35+Fw5FvhAwa1/lT52
	ziQbA1vwgOwbBZ+ei3GC/deBeCM4JmGmWs+gRhqolaq1JXWoFTwCwSuA9Tepgkc60ctJFNirapI
	gv1FNIXLdEZZoC2hDf3+gn1dcLLV7xRbyVa2IWywGvBOq+cpIUo3h/FVlQDGPsdAbMvMcBMj+Bu
	fVwvFam4FS2vPp9vgan53oIS/hCqy794AiuZW/4FiEehGW0Gt21QZmbtH/eWEulJjI/4ty4WaDD
	fO8HBspmqPCzl1LHdhKGMDrfXR4pUfsLaUcvdY6HytXRWRv93IqE84oOhgMbJvgjr/l8T1pQnGA
	e7f6Zmo8vyR0xRzhd7qqHWpibsZ5dcdhiS1Asgd7wXoCDPO
X-Received: by 2002:a05:600c:8b35:b0:49e:6861:50f7 with SMTP id 5b1f17b1804b1-49eac4626c0mr70270685e9.5.1789646169088;
        Thu, 17 Sep 2026 04:56:09 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1ce79csm79913185e9.0.2026.09.17.04.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:56:08 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/mlx5e: fix swapped IPv6 IPsec policy masks
Date: Thu, 17 Sep 2026 13:55:42 +0200
Message-ID: <20260917115542.177675-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv6 XFRM policies may use different source and destination prefix
lengths. mlx5e_ipsec_policy_mask() builds the corresponding masks
independently, but setup_fte_addr6() installs each mask in the opposite
address field.

When the prefix lengths differ, this makes the source match use the
destination prefix and the destination match use the source prefix. The
resulting hardware rule can both miss traffic covered by the policy and
match traffic outside it.

Install each mask in its corresponding match field.

Fixes: ca7992f52c2c ("net/mlx5e: Properly match IPsec subnet addresses")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 329608c59313b..8ffa8068e90ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1564,14 +1564,14 @@ static void setup_fte_addr6(struct mlx5_flow_spec *spec,
 		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
 				    outer_headers.src_ipv4_src_ipv6.ipv6_layout.ipv6), saddr, 16);
 		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
-				    outer_headers.src_ipv4_src_ipv6.ipv6_layout.ipv6), dmask, 16);
+				    outer_headers.src_ipv4_src_ipv6.ipv6_layout.ipv6), smask, 16);
 	}
 
 	if (!addr6_all_zero(daddr)) {
 		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
 				    outer_headers.dst_ipv4_dst_ipv6.ipv6_layout.ipv6), daddr, 16);
 		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
-				    outer_headers.dst_ipv4_dst_ipv6.ipv6_layout.ipv6), smask, 16);
+				    outer_headers.dst_ipv4_dst_ipv6.ipv6_layout.ipv6), dmask, 16);
 	}
 }
 
-- 
2.53.0

