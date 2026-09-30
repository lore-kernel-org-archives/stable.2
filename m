Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002F7343D85
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731213; cv=none; b=Wt9htIzRyveSEs88TSU7eRKdO7GvGkc4ix/zztAKCemnDqZeasn5sfi+oxT/5mj4O9oEqvllP3cq9sSxFglZJdz9V4p9QKQDLSv2wVzs6Gt+LKyHVsxpxaQCgd6BXDqRjCadQug/TQbHHRGy364pz62jlwYadlMPmfrw5q6yGrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731213; c=relaxed/simple;
	bh=6O0/gQWr8CMM6YC3EtCb31ij+2zDA8f+Giwd84OPrI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQZGQOE10748VNFh9JK4PF0fHzxFvUPH6Mpsbrk9EXg6THScZEVrQ7NaThWklVPQJu+8ip8tRmC5Fk2t0MtNSKBkevXX3gfcSvR9NCFpETqW3V2qyDMsN5pLAgm8tgG8aKysEfTSzYhLCOw0xiIDpVH4bCp5GyIDy8cmkO0q028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=BPhwQNzA; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="BPhwQNzA"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c4a0870d2so458833eec.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790731210; x=1791336010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vx4TXLQ87S+/MzmZk1xLXQn49g2Rf+shwH4S2Wt8hiU=;
        b=BPhwQNzADGcApQXigmKT7FqZeRSr7J/5Kqbd8daOkV4hT8cgYTQ31t8JvdUl+uIda5
         /Jv6p91n9brW0WCbTE8vq920afvXtPa7XeJW1/nQbBpaWwz+mQGTbmtPAj3Nqq04eQI6
         Zr87kCGi5VsDYMtZ4p03X06ckQlT00koQN6Tq7ycbn+OX9RkbPEia9++uh7UWZXwwmBv
         1qxFsY2SOsf+hxU7Zvq+967H6WJ80lXpB97R2hPdvBOcjAyQ0zVt+NwnVi9fL9MfiKv7
         yyADQywKHtHrto3SljiFLlqqW02wf6oTj+tzA9ZBaT21SCqsV0E43/uqVtdnCCyjccHD
         5oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790731210; x=1791336010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vx4TXLQ87S+/MzmZk1xLXQn49g2Rf+shwH4S2Wt8hiU=;
        b=thI54+FTomnyiXa9lJv1qcbHWoxU2qr71Kh/qdewnt/U3Oo6iKwaWT3jBkkBL6UUox
         de90G58KHYcr7dtim/G9S6aWC0EnOoqqCML2m8VWLT4OXd/QIpr7oVf2wpTLYP3uYNoM
         1aPCs+wUpQniJcuw78+HId0HBJ2fVjEb6N0+Kj+kjM+3SDCjgHcdn5SUuKnWCsV4hHyP
         BMSpv8gJqiqYZk82Q5mehsXUZ3rKFSnHHL99Mvefei2ZsOwBjzviyx4XgrpL3nAMPg0o
         qcbeGkY3g1AFo0O3MKxqk5GAJwfZBluf1vD9zqyDyZL8wPy6gUuI9ZzPRftMz6cOYIGl
         10Bg==
X-Gm-Message-State: AFq9FYIs/jqe6aw0o8I7VS3SMKjVeuKDJBs5iarqxNq1wkK439oLspfN
	xLrpRRANJjyeTHnwV/cI0piM/HDv9w2i+1G17e6eXLrxwujmgO2Z2T9e8vt7xB40S+vpkkfV9P8
	0kJe5yEw=
X-Gm-Gg: AYBFou2SMstYlLusyUXHxNMSV3AnN8iwBUBSSOJS4dx7/73GohhPOzAv0IoMLSZz6Qx
	esMB5xMOZrHaBNRM1Zo5EP+5HjLj8cNN78XTW7jOcC9osuuRZD98yjdKbcOKUFzCGBK0YMQqmG4
	m7P3AxblS9RocU8JQWOLfusT+3mv/BqPcJZ+FJ6Gv5M0kv1lOE0YNDRnviDpX+SQaQpRULMBsJO
	8Tj+VBmFMfMkBHMKX4pTUDJkipR2BuG1O4SCw2eTBW6gLUaHJQCXA4vAOChLDA0OdbAavo9J+iO
	k8kyFWcdHXn61W3hf/tQjMDRX1sy72Wvd5vSJPZ3cIEIPzN7VMOOq2yXYt6j4gxOA83Irhy+g1b
	dw+uvMizNDuysV0Z3S89xRQu/hgZQvEITXVo6DTDl5M1D4Ni6qv2e0CBbCBT9z5p7IhyCR0WSSw
	uWimkMIJe/OPMxAs+99eZw/Yf3gvouy6K2NVw0LwC2wAc9/658M0Z7Cq5rOq0lNzGlJz09EA+xL
	pbpFTLSjf/+Uzqh4wraMAhCKHmCpRusKZzjIFgcG1aMDi/LVso1bTakBrLKBUzwpmLKFi0=
X-Received: by 2002:a05:693c:6392:20b0:33b:fc17:e786 with SMTP id 5a478bee46e88-34cdc6bb167mr13827eec.16.1790731209392;
        Tue, 29 Sep 2026 18:20:09 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c350c0d63sm2498855eec.3.2026.09.29.18.20.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 18:20:08 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 6.6.y] ethtool: fail closed if we can't get max channel used in indirection tables
Date: Tue, 29 Sep 2026 21:20:01 -0400
Message-ID: <20260930012003.95556-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 2899d58462ba868287d6ff3acad3675e7adf934f ]

Commit 0d1b7d6c9274 ("bnxt: fix crashes when reducing ring count with
active RSS contexts") proves that allowing indirection table to contain
channels with out of bounds IDs may lead to crashes. Currently the
max channel check in the core gets skipped if driver can't fetch
the indirection table or when we can't allocate memory.

Both of those conditions should be extremely rare but if they do
happen we should try to be safe and fail the channel change.

[ Backport to 6.6.y: mapped the newer rxfh-parameter callback to the
  older raw indirection-table callback. ]

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20240710174043.754664-2-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and net maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-46834. It aborts a channel reduction when the
core cannot prove RSS table entries remain valid.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-46834
Upstream: 2899d58462ba868287d6ff3acad3675e7adf934f

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 net/ethtool/channels.c |  6 ++----
 net/ethtool/common.c   | 22 +++++++++++++---------
 net/ethtool/common.h   |  2 +-
 net/ethtool/ioctl.c    |  4 +---
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
index 7b4bbd674bae77..cee188da54f85f 100644
--- a/net/ethtool/channels.c
+++ b/net/ethtool/channels.c
@@ -171,11 +171,9 @@ ethnl_set_channels(struct ethnl_req_info *req_info, struct genl_info *info)
 	 */
 	if (ethtool_get_max_rxnfc_channel(dev, &max_rxnfc_in_use))
 		max_rxnfc_in_use = 0;
-	if (!netif_is_rxfh_configured(dev) ||
-	    ethtool_get_max_rxfh_channel(dev, &max_rxfh_in_use))
-		max_rxfh_in_use = 0;
+	max_rxfh_in_use = ethtool_get_max_rxfh_channel(dev);
 	if (channels.combined_count + channels.rx_count <= max_rxfh_in_use) {
-		GENL_SET_ERR_MSG(info, "requested channel counts are too low for existing indirection table settings");
+		GENL_SET_ERR_MSG_FMT(info, "requested channel counts are too low for existing indirection table (%d)", max_rxfh_in_use);
 		return -EINVAL;
 	}
 	if (channels.combined_count + channels.rx_count <= max_rxnfc_in_use) {
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index f5598c5f50de9b..30fa329fec05d6 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -587,35 +587,39 @@ int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max)
 	return err;
 }
 
-int ethtool_get_max_rxfh_channel(struct net_device *dev, u32 *max)
+u32 ethtool_get_max_rxfh_channel(struct net_device *dev)
 {
-	u32 dev_size, current_max = 0;
+	u32 dev_size, current_max;
 	u32 *indir;
 	int ret;
 
+	if (!netif_is_rxfh_configured(dev))
+		return 0;
+
 	if (!dev->ethtool_ops->get_rxfh_indir_size ||
 	    !dev->ethtool_ops->get_rxfh)
-		return -EOPNOTSUPP;
+		return 0;
 	dev_size = dev->ethtool_ops->get_rxfh_indir_size(dev);
 	if (dev_size == 0)
-		return -EOPNOTSUPP;
+		return 0;
 
 	indir = kcalloc(dev_size, sizeof(indir[0]), GFP_USER);
 	if (!indir)
-		return -ENOMEM;
+		return U32_MAX;
 
 	ret = dev->ethtool_ops->get_rxfh(dev, indir, NULL, NULL);
-	if (ret)
+	if (ret) {
+		current_max = U32_MAX;
 		goto out;
+	}
 
+	current_max = 0;
 	while (dev_size--)
 		current_max = max(current_max, indir[dev_size]);
 
-	*max = current_max;
-
 out:
 	kfree(indir);
-	return ret;
+	return current_max;
 }
 
 int ethtool_check_ops(const struct ethtool_ops *ops)
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 28b8aaaf9bcb3c..b55705a9ad5aa0 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -42,7 +42,7 @@ int __ethtool_get_link(struct net_device *dev);
 bool convert_legacy_settings_to_link_ksettings(
 	struct ethtool_link_ksettings *link_ksettings,
 	const struct ethtool_cmd *legacy_settings);
-int ethtool_get_max_rxfh_channel(struct net_device *dev, u32 *max);
+u32 ethtool_get_max_rxfh_channel(struct net_device *dev);
 int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max);
 int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index eaeb514b7e5f6b..8eaf786eb0c7fd 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1847,9 +1847,7 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 	 * indirection table/rxnfc settings */
 	if (ethtool_get_max_rxnfc_channel(dev, &max_rxnfc_in_use))
 		max_rxnfc_in_use = 0;
-	if (!netif_is_rxfh_configured(dev) ||
-	    ethtool_get_max_rxfh_channel(dev, &max_rxfh_in_use))
-		max_rxfh_in_use = 0;
+	max_rxfh_in_use = ethtool_get_max_rxfh_channel(dev);
 	if (channels.combined_count + channels.rx_count <=
 	    max_t(u64, max_rxnfc_in_use, max_rxfh_in_use))
 		return -EINVAL;
-- 
2.39.5
