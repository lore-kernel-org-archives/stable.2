Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749F13F8EA7
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490272; cv=none; b=YFBL0/Ar8kFj+DO48lIXbMofmGKnNbh1qau4BAdS7B1TbzW/wlcj6VUebBIWzQuoExer2leK4tMDTjIZ7pK20IvfBivAiBiNzaKMWx5K1ywZbPOlPIEM9iiO58/m5qIfcbvBDY8u1nwZVcx/1yVl55V7EMk3evNNJyYpKRPPdsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490272; c=relaxed/simple;
	bh=nscHcO2mv1RC0CFABqFtx1lNVPm0Y2VLBw0sdr9GxQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViAfpctB7Lj/mkM7AByB2/TnX2fLuBe56aMkD8UjPCimJ+3aL8FzBM9di9Fs+k6oHXF6zupsTC/Pn1nrWOZh1IA2QL1ibCngc9S7NCDMKxgsSrbaXgSbx2fpESp8IYiOa25DiqheanLe+O0lzDDFEgIWGh4ECHqfQ2mpxRCQF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=AmtpQMSe; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="AmtpQMSe"
Received: by dvalin.narfation.org (Postfix) id 0DD5E203E0;
	Fri, 26 Jun 2026 16:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6X76J9ILUI0cuRYh2lQBIS4v93nn5M/LQrV9XpFFk8=;
	b=AmtpQMSeo8qQVtlCFBtO66c+gndtvON6jjkRVfnm6BKznewmzuy2nenMtTOgV1ACdYGM+r
	EJIzzZ30VWdsT2QYdrLt1QCYhDmrFBBsGpof6zvre8rrxfnqYzSLwfkNgCmQrP1/i2rswY
	CuflLowQWyvGqo8n8v5Y/D7Udb8Bn+M=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.15 10/25] batman-adv: prevent ELP transmission interval underflow
Date: Fri, 26 Jun 2026 18:10:49 +0200
Message-ID: <20260626161105.124113-11-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161105.124113-1-sven@narfation.org>
References: <20260626161105.124113-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 5e50d4b8ae3ea622122d3c6a38d7f6fe68dfddca upstream.

batadv_v_elp_start_timer() enqeues a delayed work. The time when it starts
is randomly chosen between (elp_interval - BATADV_JITTER) and
(elp_interval + BATADV_JITTER). The configured elp_interval must therefore
be larger or equal to BATADV_JITTER to avoid that it causes an underflow of
the unsigned integer. If this would happen, then a "fast" ELP interval
would turn into a "day long" delay.

At the same time, it must not be larger than the maximum value the variable
can store.

Cc: stable@kernel.org
Fixes: a10800829040 ("batman-adv: Add elp_interval hardif genl configuration")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index bbd6ecf1678c9..9dee1889e2f39 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -941,7 +941,13 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 
 	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
+		u32 elp_interval;
+
 		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
+		elp_interval = nla_get_u32(attr);
+
+		elp_interval = min_t(u32, elp_interval, INT_MAX);
+		elp_interval = max_t(u32, elp_interval, BATADV_JITTER);
 
 		atomic_set(&hard_iface->bat_v.elp_interval, nla_get_u32(attr));
 	}
-- 
2.47.3

