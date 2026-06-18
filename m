Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2364C1A680F
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773431; cv=none; b=AC0d/ixyJDf2FG9xQfoPH6LtM1egiF+yfLCS/zKGc6IRbpxi/A47bxNg1d5NTy2OIHkW34LWdUX6gsQMjhpxU+9cpAdstL5pSRoMjRRbV/D5k7YRZAjsgDLwwldRFMuldP0gQi3WKB5ZsDgvE2u4JtHpyS+pWlaElgFoJLcuJTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773431; c=relaxed/simple;
	bh=pDfYODN8eSb3Osdiy8pGUbcCjj+Vd5hRyuhJN7tkHGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l+ehOR+LTCFJd3yO1LwHmBlap8wTN/YyhrJ9goCp2LfegQKaXsWrNdASt61NlBn0gX22CkDWveNSqPMT5KZZuvELvtRVuAjTkYlzgIjr9MwU6eB0QPEj1NvAxWXkiYQHaN4WePBFOybLb4vLw3M82wOs4ntQftNp1CbPHeqMqNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Dr/Ydqrn; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Dr/Ydqrn"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-37c5b9d42efso970058a91.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 02:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781773429; x=1782378229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpNixvCXNM3odqaYWueSGP2Z43EAIlNiUuWGIkEd9i8=;
        b=R+VYEvPgF/cdJQ4c1d4fgvSWifi874intzLRe6y3wE1XLMvCotyglOSYYL4vubz8AV
         HZWBsNERCly9cGQyvYEwjiUYwXkevTrm2V69aXP90fhiVyIQ+x1kPDHKgr680oXJOb5W
         zTpRCJSgBUa3+xV66WaPpskVZ+h9DMBQJ0YX0CNaT6nyGAVfOkTopWLtPpwCyapiVun+
         vv/SxLdaXYNeXsdU4jST9+gUpLDAhRFnP7aW82jZ2tjQTLEeT0/XkSyJhxsjGV7mRjk1
         8KjpZSRFLrCjQwUEX9Tr3T5gdQ1/n5e0SxeLrGCZRveJ2o1cJatXAQmD47As4dYLWJt7
         sY4Q==
X-Gm-Message-State: AOJu0Yw7S1zxhxk/eb2eJZPFUm8mvNcb9q9426VfxQiYS4dEsKLP90/u
	3PCQQkdb8/0wMuXVXksCXK1qVHHEniStSGBX/YpGG7nlqGLgj76MH2krHr8zhfT+WTO6czschOX
	mWrSlxjE1g1LRcrp/UqkJqd80fjUzRwd/87OXoTe5M9vc5P1cLLI4kf7ATtvljie7fQPDoBC4yp
	pXlrkChrIGZgLzrNRcGmHXH9Aq0BKOFPmZYp/DfjmgQQigkpgwJVOnBimUEgTyI0r+Cx4B49xj7
	tU61eeh5T8XI+msPQ==
X-Gm-Gg: AfdE7cmq0DNDKe1DlT3mtPsRTgp5RFlPXmC4op98/dC7Die9OfXTb+YXgL1nsCPPkgG
	Q+8sktzUUUtG5LbQDybG/0NzXtIZIzzxD3A8K7ahGZMcz8+EHbb+HoEdXdCWEsP3HkSm4IBQdqB
	4tvUiVlPx4hbEMVFp7Qf/UuDSUExSmh7F9cv6rKl2VR+lwyxhQvyLZ0elcUrs/4zKow60mMohLi
	9Y9HUoJ6Xbyj2hE6Nbuez7QM7nI/SX7NNBBk8gZpXFqI5kFVdrsvoAFGoA7BAK63qO66IRktYrg
	PTfVDH+z6vNFoVOxZYId960NG90iIbeuFrOa4MBBhQ31AoOtyaFS4+HCUpKnbIbgvsFvdTkGM/K
	oNHfIjeTSozUMJmyOms3NN0X042W1pyj3+QHhY2JfcC7iZynzKntKItZffUG6qbXtEhOl25ek5B
	0L1N9GcpHnGOV+WkI0JsfOk8U6e2Lmq3IL/WLhV+K1hJFL41JFs56i
X-Received: by 2002:a17:903:458f:b0:2c6:829b:b0c2 with SMTP id d9443c01a7336-2c6de51bea1mr27529165ad.11.1781773429290;
        Thu, 18 Jun 2026 02:03:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c42c5336d5sm16061345ad.0.2026.06.18.02.03.49
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2026 02:03:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51956be1f44so33616181cf.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 02:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781773428; x=1782378228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QpNixvCXNM3odqaYWueSGP2Z43EAIlNiUuWGIkEd9i8=;
        b=Dr/Ydqrnwbh4TDAFnHL3FK7c9/Rv/ES8ODcuQahihVpAlAZWYGJb3gyzyybRI8NjpO
         YBBOLM/1Gt6yBlv/pDpl6C8fnEnql4CCMW5USxOQU4nFITglkckgSy3hqJkJscqf7MYj
         rlnjuWlh4EKQsZ6SmByMvOUMijYrOV5j4x3YQ=
X-Received: by 2002:a05:622a:22a4:b0:517:5ed7:d28f with SMTP id d75a77b69052e-519c4de0e85mr37505931cf.25.1781773427916;
        Thu, 18 Jun 2026 02:03:47 -0700 (PDT)
X-Received: by 2002:a05:622a:22a4:b0:517:5ed7:d28f with SMTP id d75a77b69052e-519c4de0e85mr37505371cf.25.1781773427211;
        Thu, 18 Jun 2026 02:03:47 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61eaf4sm191285561cf.4.2026.06.18.02.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 02:03:46 -0700 (PDT)
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
Subject: [PATCH v6.6-v6.1] netfilter: nf_tables: always walk all pending catchall elements
Date: Thu, 18 Jun 2026 01:34:38 -0700
Message-Id: <20260618083438.1269242-1-shivani.agarwal@broadcom.com>
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
index 196ac4e76..0581f6479 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -620,7 +620,6 @@ static void nft_map_catchall_deactivate(const struct nft_ctx *ctx,
 
 		elem.priv = catchall->elem;
 		nft_setelem_data_deactivate(ctx->net, set, &elem);
-		break;
 	}
 }
 
@@ -5241,7 +5240,6 @@ static void nft_map_catchall_activate(const struct nft_ctx *ctx,
 
 		elem.priv = catchall->elem;
 		nft_setelem_data_activate(ctx->net, set, &elem);
-		break;
 	}
 }
 
-- 
2.53.0

