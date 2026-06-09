Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92649218E
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023012; cv=none; b=ec1S0psjFz3NZvMwXPSRWKH8Uz7TpTxTCJo8KJCakvzdcukTCx/7PVdDINbvo0h1nUdkp170mLsb6ArVYCed/cLqE5r4uM4pyqh25fDJDIyyh30WIz/P1OoseVMVYrI6EKIG1Ng0ukgPbSxr3MewrxZfTl/mDvYwUVh0YLyBwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023012; c=relaxed/simple;
	bh=OGLH7jXzbsIii2mYqUyRub3wuJrPU46nL/mOrml4hmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NSmimF5ezJUrqjVmVBPm0m3braDt1tOutzTZEdSNl3IbFxk4OZrwHixz3/6iIYRIETYqhL7SLoTNNdhXtj3SBdfNZZsDgJiXz6JAd1FOAt00O301q5bGY5vjX3Kk8E6sSi6bo5i6WOffT12i3wfPrn77jjketHRpo068TQapAUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AesH0hlr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AesH0hlr"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490c1915793so39216295e9.2
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023009; x=1781627809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jw5k2pr2Uxq2pN8ORiGv1jSaTS+XZ+Vd2/C3ba/TNc=;
        b=AesH0hlrNI4zuNY7MldHwTG7877NnkNAZROvw162aPqOqaVVFA1rLFvghGU0TDOC03
         9Oz4HseUfeqETnGyxY1C4uak+1jgawJtkB62iKxoB+zHScI1Q/hcoN+Twso4VuLwXXMV
         7Cq+t9U4Xr9JYLcn7TetbDFKG+ReiIYvvTwLtp1ViTloejjXWrZSpefYm8k4izUbzk1s
         omS835SlP8HXnosRDyHu94p19HalLfCtJ33sQPV0HQiszvrutnlrAaBBDerUUTeDtaio
         AeSzEQpZDzg9Qu3AuTQrK9H8CRuJjepAXfsNJOlnPa3hfQPVCJpacN7QcRGfS8RdczEv
         /oJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023009; x=1781627809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Jw5k2pr2Uxq2pN8ORiGv1jSaTS+XZ+Vd2/C3ba/TNc=;
        b=Zk0+lvrz06n8uW54uJxG3LNOzqVX/eAW0C83Zp0T1Ok3bfscTmkpKmTVZQVdm8kAlw
         otL8mXlutR+gArla6rQVmr/qzGLfIXYfsH097yWVrfHF5Y6rjfU4xBd0WgLvNxYGpgMR
         31t6cK8Umpr//OllDiaFY45QWJYDK4BX/p+MeBm6VMvIDUkOw3eqZ8fDstvmgwsQtBz2
         +ssjalwo3U6G9jkWNFXCLaf3Fx8wYMEhdhCllHWXMYeIGKC7nSg02gLOqWGCfL3RreZh
         tYdRL8z1Abf2QLy/bN2gCby9kfUvxRZKYqcfJ9VylSMJW9m2ZzgKDLfd/8JN/eA8rPkS
         AtCw==
X-Forwarded-Encrypted: i=1; AFNElJ8IYflXWYKPefAD+qrxMCy/5Yw034khOsRkbtd9M1GNWc+zA7mcYhF7BbvBXhSsf4NUU5+JBdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gBvO7PaFF/DpT6h6fIRVJn4sAH1s7oGGuHLOI55JbWdQzM/e
	j7GB3GsyqbFtts4UzEEXPB4QS7nGOVIeIUoUM5se0jqbebB/lc3ZcPDY
X-Gm-Gg: Acq92OFwXXEaSOF2CYKHJNgY4SOraY4oWm6Z5XKUHPpgdatPfUAYojhoW8jVI5dzut4
	uDETQmNZ11hrDmO20Z9uxSBT2nFjLWnVfe8NvhCtcXiiOO2Z9LO4QPsJ5pBRBI7TOWAf9DP2BR5
	GEwfA1SvNubBZp48K3Hsf3lvXgJdiEkdNKvHpV5kUQHNJz0PYKVsVbTqvNE8iqMKyOlO5kSRosJ
	PQn4TyfcMGs+2p1NkEpnRC2JYpmXg15ZOPixY2cxkBuAOnd/7kLdHOYTAHsQ9oq+PBM7NXxHJVf
	Zk2BHnh6SNA/LsvEB2wqpQhki2kH/Q87B24RjA5rv/hBrb3polsLev+NKojGtgudGwtqkafYdez
	lNMgaGUEsjFL0BwxRtfsCGbFjux/6L3jplg3wqrZbcMwWZJb2/wff3hxhJ5Qh1c0L5VCGeS+QW2
	sXLyebXmV+VunUgdyttz8MEsg+tuoI78AW0lNdJZUuOF8SpWg+w3OM0R22O67hVQJOAwVkYdNH5
	IE6sQwspw==
X-Received: by 2002:a05:600c:34cb:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490c25afa03mr337809275e9.7.1781023008696;
        Tue, 09 Jun 2026 09:36:48 -0700 (PDT)
Received: from manta01.. (host-85-36-215-182.business.telecomitalia.it. [85.36.215.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b06sm449114015e9.3.2026.06.09.09.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:36:48 -0700 (PDT)
From: Davide Ornaghi <d.ornaghi97@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	coreteam@netfilter.org,
	Davide Ornaghi <d.ornaghi97@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] netfilter: nft_meta_bridge: fix stale stack leak via IIFHWADDR register
Date: Tue,  9 Jun 2026 18:32:15 +0200
Message-Id: <20260609163215.1102215-3-d.ornaghi97@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609163215.1102215-1-d.ornaghi97@gmail.com>
References: <20260609163215.1102215-1-d.ornaghi97@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NFT_META_BRI_IIFHWADDR declares its destination register with
len = ETH_ALEN (6 bytes), which the register-init tracking rounds up to
two 32-bit registers (8 bytes). nft_meta_bridge_get_eval() then does
memcpy(dest, br_dev->dev_addr, ETH_ALEN), writing only 6 bytes and
leaving the upper 2 bytes of the second register as uninitialised
nft_do_chain() stack. A downstream load of that register span leaks
those stale bytes to userspace.

Zero the second register before the memcpy so the full declared span is
written.

Fixes: cbd2257dc96e ("netfilter: nft_meta_bridge: introduce NFT_META_BRI_IIFHWADDR support")
Cc: stable@vger.kernel.org
Signed-off-by: Davide Ornaghi <d.ornaghi97@gmail.com>
---
 net/bridge/netfilter/nft_meta_bridge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index 7763e78abb..219c406802 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -64,6 +64,8 @@ static void nft_meta_bridge_get_eval(const struct nft_expr *expr,
 		if (!br_dev)
 			goto err;
 
+		/* ETH_ALEN (6) is shorter than the destination register span (8) */
+		dest[1] = 0;
 		memcpy(dest, br_dev->dev_addr, ETH_ALEN);
 		return;
 	default:
-- 
2.34.1

