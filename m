Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965AF3921F1
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197010; cv=none; b=Jd0eKYK3SAN18y0VW82tHZaoFcLl1vx5M2KuI2Y3L+NMYvZvn9/ADeysx1LAKsa2voJ55NmdspKysizEHTcwZcvJBCpchlyGegWB2wH3CeKHEzQ7jCXkEEqBYkoMJiAQ2MqtpTB+tEC7a+F3hwnJ2c2acihUbyzTnw1JstMSkns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197010; c=relaxed/simple;
	bh=hwdcxQZyp1DiMpjzaka9N2DHGUC+C3QJjPD7Z9vvutk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UPMCC0fmFe/+3hEUierWPEb/zm74F/mU91q3OsIahbhuar8sKogG/UErQKQ8WiHbw+cInllxK3rWmAplEgkImukhiW+JQy4IvjnmJci3D6fzRV5gRBKbaqkhIMyoZmXoUZwojYgleIgFdeCTX6SBItIZJccdTkcP4/TT1rRMjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PBUsv3iF; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PBUsv3iF"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2c0aa420401so32386515ad.3
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 23:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782197009; x=1782801809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fy4aFh7UcrzBTSJogToF7QAZLN083cdJaTVBVx/OKCs=;
        b=KVZmUua78q6A1ugPkdVcwlFibAAMLM7O9venhrISXFI55GVAIZrwldXbAbk8eM7BAq
         SrAt0jjcPDci6Zzlsc9cVff9RjRHHWP60okWhZ6fKnTqg736MKAN7LDqZ/GJTPmaEgqR
         Z+EYkYOKHEEhM2eImcCc53xXnsFD2BMBHbkbF6iKkJpT6u0go7Q780yB3Fw2MUSV809M
         juPX5IMyyoHXHxptb3kHvEA+8BlXdbhPesoFfFZdUV3rU4DtbDDzYVncgRpBtlpvCstZ
         co5K/fUQOCgwOBZ7lXzKfNaeSVL8ow/VXG7iwV+AzGpDO0kYrFi5kDw0fZYx+ahQ5JI4
         5vpw==
X-Gm-Message-State: AOJu0Yz3hJ/r/4bJlnxg/GM+aSQO06Fc8PjBpuaTvNv4/97qvPtZQL0y
	tw18N+b/FWWU8I1Wcx1c2Q/ADqLfWARU/PXWtxk91KXM00RQA4Gzn0hqYGg043pvHsVKhkP4BGQ
	w5EfphyZSBrX9MfCkLalducCIgsvlXdlpLzGjUuxA+OUc27pJ1BUO3QDI8TTdv/I7T2SmppL/wZ
	rhX5pUgAIux2vpjH2HLoYcrpoeNvGn19f8Xj1WFC8tsMOhxsUcOE0gWnZdv+r14I66Dn+gdt7W0
	YKWIQmTv+8ohbA=
X-Gm-Gg: AfdE7cmEAOvORJGQ/Cwxihpmlz+T/tWslcJZk8bTBCTbArCWkxuVSJIz1lJYf5AFkJs
	FiWX6HNDJ5to4iDMWRZUiBew6/lXRDjce8OMg6RZJfY4BNwaQKto6v7DWvvO0Mum92FjfKCjV/G
	5TIYausrpsFsquW73ZYebvb0pTRRcZPPdAAvIeOXmW91s/fjjTMLeYMDg8ceU8o2NT1lzFUe1/+
	k93AamZEqDBvAK7bNEHv7PAu/ix7rVWXE/BWnAsinBjd7aJbooT6aEQHsoGbnG5FnhAnVIHg37o
	ORX2SqNgD5MYlsUiAwyS+mF3pur3ufmXFoBk4c2c/8/z5aQbU2F7/rvViY2MZWLRaT/3xXeDv6C
	BCWnKvMYRSP+JfoMYhIrlGntPd4pJUaWfGIkBAEjw+L1JEI3/uXtwUv3mQ9YfeW9ASt2cEXTLWG
	+LdLVAcAr1/AGrSx72zq0lci71fbNeofvs9T+PQTvlm5C5lAjr8w==
X-Received: by 2002:a17:902:e54d:b0:2c6:b38b:e75d with SMTP id d9443c01a7336-2c7c7693e00mr18760295ad.20.1782197008672;
        Mon, 22 Jun 2026 23:43:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c745913dc3sm7649355ad.38.2026.06.22.23.43.28
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2026 23:43:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1384427c3efso6769410c88.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 23:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782197007; x=1782801807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fy4aFh7UcrzBTSJogToF7QAZLN083cdJaTVBVx/OKCs=;
        b=PBUsv3iFQzf3S16YaoJvUl7nxLpID7JZ9ISmn2WvvFZh+EBUUVUpEIzpcmA1zD5Msu
         yJOGoFNuNknIZKcfa3L+VJd7gPym/NDiWS7Z4MOxQN9evuTOw+7ozPFU1mRFMnwGAE+n
         u2fnAvTrdUufJVeCfIChacn4jkY2L+dHBFmYY=
X-Received: by 2002:a05:7022:69d:b0:138:267:af4a with SMTP id a92af1059eb24-139c5cdad1bmr1260136c88.8.1782197006920;
        Mon, 22 Jun 2026 23:43:26 -0700 (PDT)
X-Received: by 2002:a05:7022:69d:b0:138:267:af4a with SMTP id a92af1059eb24-139c5cdad1bmr1260089c88.8.1782197006208;
        Mon, 22 Jun 2026 23:43:26 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adcb7aabsm13598321c88.5.2026.06.22.23.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:43:25 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Yiming Qian <yimingqian591@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v2 v6.6-v6.1] netfilter: nf_tables: always walk all pending catchall elements
Date: Mon, 22 Jun 2026 23:14:04 -0700
Message-Id: <20260623061404.1288986-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 7cb9a23d7ae40a702577d3d8bacb7026f04ac2a9 ]

During transaction processing we might have more than one catchall element:
1 live catchall element and 1 pending element that is coming as part of the
new batch.

If the map holding the catchall elements is also going away, its
required to toggle all catchall elements and not just the first viable
candidate.

Otherwise, we get:
 WARNING: ./include/net/netfilter/nf_tables.h:1281 at nft_data_release+0xb7/0xe0 [nf_tables], CPU#2: nft/1404
 RIP: 0010:nft_data_release+0xb7/0xe0 [nf_tables]
 [..]
 __nft_set_elem_destroy+0x106/0x380 [nf_tables]
 nf_tables_abort_release+0x348/0x8d0 [nf_tables]
 nf_tables_abort+0xcf2/0x3ac0 [nf_tables]
 nfnetlink_rcv_batch+0x9c9/0x20e0 [..]

Fixes: 628bd3e49cba ("netfilter: nf_tables: drop map element references from preparation phase")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Shivani: Modified to apply on v6.6.y-v6.1.y ]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 net/netfilter/nf_tables_api.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 201e2cc04539..3de8895bb991 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -627,7 +627,6 @@ static void nft_map_catchall_deactivate(const struct nft_ctx *ctx,
 		elem.priv = catchall->elem;
 		nft_set_elem_change_active(ctx->net, set, ext);
 		nft_setelem_data_deactivate(ctx->net, set, &elem);
-		break;
 	}
 }
 
@@ -5243,7 +5242,6 @@ static void nft_map_catchall_activate(const struct nft_ctx *ctx,
 		nft_clear(ctx->net, ext);
 		elem.priv = catchall->elem;
 		nft_setelem_data_activate(ctx->net, set, &elem);
-		break;
 	}
 }
 
-- 
2.25.1

