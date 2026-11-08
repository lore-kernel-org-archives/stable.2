Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794154781;
	b=yHKOj+PojCDcnLWhA+wdsCyuohpbYJcUczd36cCw0kxbCH8i6qQzSf3SAINDpZHO3rNe
	 KuqFKE7SPmW3rO06oBNGAmkoTQufU8NVpjbkL0Fzt2w/Ms5V8WJcVouljNNdRMal3THSw
	 S1s43h2HU+ZDyT1uxwaILRWhn52LiRcZ6dQV5I5pr6yTH/cbnPRnp/gM8+cmmS6fRXsJO
	 hWVYXNr0+4I/jrg9iMh1gMcLKRS/weR5opPRryIBe75BiYKntNBH00ipzTSvbzxHaffFY
	 VNY/tt8wb6aPxP7sxTAgq59d/cUbob6zV3m1MRI0OPOPuhtdra/thvGn8xuekj7CXqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154781;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+LhL81flwND2BRsvUeYL75EMKURLG+Fr8UdO/SlqNFo=;
	b=EOwY8c8gFf7ZSQD7xNkwZ4yMtFKg54gOZHRYMg58FHozUTcOAvagp167SKvkh/d+Zyvb
	 R5o37ARJMjrIihE11oI3sTuLee05wWTWEatlwctsCxt43AcFW9VMAkUHu9OTfCiV8R9uS
	 9/JlNdjBCO4sLK7EXDzHDCtCFF9DLh7JgFTxgpr2/GbWt/dKdjr9G4TKXAWi0k6WR7qJg
	 KQtPTE7MaDsxB9FiWkfzK2ZGb7Qbjdp4y3Rl7LYPvL59hYjHCuhtq7eKbb5u2RG19Xey8
	 HcdpT52uC7UzlFIPplaiELhyq6iwf4PgEA5heNx0reKb4uO/WyM+JmxVkDwridAEDcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F95C606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 16:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F95C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so1990105e9.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 08:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154780; x=1794759580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+LhL81flwND2BRsvUeYL75EMKURLG+Fr8UdO/SlqNFo=;
        b=itnHq/xeYa1u2VXZuBRVOR0M5/VNk1JKJv6E66ezAGogZW1y9oyXvrulRgnDj+OMzR
         faWflDPJ1Q3y+pOkpcSYDgii/n9I77EWpT5F9qqeYWkIRQ5FblDkl2Lsig56aIaH1BRy
         iwjtS4H+ZgpuDCQ+pf/upilcxJVcv1ggZ3K26S7IgUxXLFEk5Q5JWSBOkMjZwAAjkPgY
         PZqNenRcXososQpUgVN21zL+o49vFkhl0PuDf9BwcQLTZ0LJUgu3PAgyxlmxxlR1DtF3
         svkT/NTah+JWlN4PEN+jLs/ItPbMop+iK4eqa956jwG4Iqv9JgSnZ49Ehm25L32igE9Y
         lY9A==
X-Gm-Message-State: APuU4Z89ChDwY36I0dXceueR/Y4N+LEPLanh0sgL5OBBGqMrNGU59uTz
	Xxudg4CUAadAVChST8pwR08zmcACLIdfNsR0x6CSU/eyyaZesq9j+PVRR3aUQ6N5oUlRBLVEEcR
	BttoX2mmQOw==
X-Gm-Gg: AYBFou15OlAiW3yYOwva+q5QB91CChqsbhJa1/+/P4qLVu25wBnd4u1ucBj+WDxtN8t
	7+7VLVIVviAQZ88BtFrnFf8STcl7B3xxDMmnmF/SeZyVoHABSlCxXqPScmFIPuC/Y6auG+4Oe/g
	ESQiVwBunrLCx1RLO698GmNmOYpSW1orRK79O2GwL0q+O27wO4+61eWMSBLx6pwMRVdpPvEs0bn
	otLPWvqeYaOhvgXNPOWHf+cCI4IUpZBew99L5OZ0U3Jabw8DMkB76Ed/btRQHOJBkGsReqmpn8w
	zCkaePLYYvNuGv25vty2enSVJG8X9iQEdbpfbXeJSkJtQqSlDLkrQ4iFrKaIk84hj/0MILwY6c+
	OvBUoHzy2FwYGFi8n2jqSPb5NvjUmP2OfL0G8HwsUVlYKXlU+BTUFDdLHPCyeLQ3dk/6b+KHnV/
	qQql3s/weenj0ou8oIQ2FuUoJei1DEiB3Lc5xe1ghrDYsl8Q9QCgZhHiCGci5mXQlfeEvPO4Ar2
	7KpFLcFXrRCM93Tpot9tZHqNwoiKNXBMsggMIIfdTBsaumtmnI8Cyd3xvOoo+JyV2M0bf/io2lv
	zLKfC3lYR9eBmL+jPeG8BbDDMQ==
X-Received: by 2002:a05:600c:6209:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4b9633cf792mr32161015e9.16.1794154779716;
        Sun, 08 Nov 2026 08:19:39 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:e93f:179f:cb30:5c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cb772e1sm189535415e9.0.2026.11.08.08.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:19:39 -0800 (PST)
From: Christian Schmidbauer <opensource@grische.xyz>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Christian Schmidbauer <opensource@grische.xyz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Breno Leitao <leitao@debian.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Guillaume Nault <gnault@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y 1/3] net: get stats64 if device if driver is configured
Date: Sun,  8 Nov 2026 17:19:35 +0100
Message-ID: <dac4a31ac43f87c2076908879bd180995769ad6e.1794153876.git.opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1794153876.git.opensource@grische.xyz>
References: <20260812091127.1349673-4-sashal@kernel.org> <20260925180809.603571-1-opensource@grische.xyz> <2026-09-26-daily-reply-0002-re-vxlan-dstats-6-6-reader-and-tx-side@kernel.org> <cover.1794153876.git.opensource@grische.xyz>
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

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 3e2f544dd8a33b2f650b32920b9bef103da2a7cd ]

If the network driver is relying in the net core to do stats allocation,
then we want to dev_get_tstats64() instead of netdev_stats_to_stats64(),
since there are per-cpu stats that needs to be taken in consideration.

This will also simplify the drivers in regard to statistics. Once the
driver sets NETDEV_PCPU_STAT_TSTATS, it doesn't not need to allocate the
stacks, neither it needs to set `.ndo_get_stats64 = dev_get_tstats64`
for the generic stats collection function anymore.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 94b601bc4f85 ("net: core: Implement dstats-type stats collections")
Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index f9436563a2e8..f55b7e5ea3a6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10784,6 +10784,8 @@ struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
 		ops->ndo_get_stats64(dev, storage);
 	} else if (ops->ndo_get_stats) {
 		netdev_stats_to_stats64(storage, ops->ndo_get_stats(dev));
+	} else if (dev->pcpu_stat_type == NETDEV_PCPU_STAT_TSTATS) {
+		dev_get_tstats64(dev, storage);
 	} else {
 		netdev_stats_to_stats64(storage, &dev->stats);
 	}
-- 
2.54.0

