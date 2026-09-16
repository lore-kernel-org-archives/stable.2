Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E73B14C6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789527628; cv=none; b=ZgPGcmx3A+kWdv8xnbKv/DNdXnNi+Z+B2sXvHJP7wyNycdLZubGS0R+T2XNy0TopZxeLdmoAE62+e4tyrky8F/m4U/1FsNtfD5wR0qaFBBEA0RoyZ7IaPAW/BVMHnEe31WqVvnk9lvNUTHGNFvYP+ZskfMfU6mQAiGHxY6clxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789527628; c=relaxed/simple;
	bh=RmS+xdgWocibZMZYCA84W4qaV1yXYkVlLzdVkYyMD5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvPyO9GxNAetwHfChRNmKnFMArLWHI2z6Bugaye6tSNXKNwYMZHt74Tg+roG/jX0xWjWS5fyquv0nyJW2iuznfMbpTyx2jrcUjgRc5rp9xmO7NDOG3CgMO6+MObnVcTJ+QJ43cY0G8/jsUz8ayz/+MLMNAuQ94HHX8S4efeN7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRO2IsBn; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRO2IsBn"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-398cb5615deso417042a91.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 20:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789527626; x=1790132426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jVvxgQIw7AeCLmLEQiDzAuJvlTjekJJ3lxgJZwxjO7I=;
        b=FRO2IsBn7A5sw6+At3iy+Hv7iM5Q4dItUOzD5FevIWXH8KmHuHGdQYHMV7GQqvw3DO
         ox2z1ZWb7RptCWNdtp8A5pwufxwYaXiRuJgTRXL92CXSgzwne4nJQsFZDPhhYtGhXIRo
         gde1t+ip/ntDSFyB6zfqyoO2lAX52ee0X/2TsKywty9vDPYjbke7tUk6J5od2AMQwCs1
         grTjra0u+oqLEYU4tCyVeGZP8L1axqBWuuoft1h+4o553wUfkmIcnIp0QjWGaTOE6GRU
         WSWDlbypD/k7O/eozwyePZ401UmR3ek5TPhQEuZjWVaAmrjeRFOoia4FLyxpXZbEXlkw
         IZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789527626; x=1790132426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jVvxgQIw7AeCLmLEQiDzAuJvlTjekJJ3lxgJZwxjO7I=;
        b=fCt0WcYjQyiVGFK24uCXzFos2YV088Bc5hSlgWEi6RUD4MraHjVl3C3XyDU6BQjIuf
         NCL4RSqIcQ+QQTZ0BdhcuXdm9dFu2rhI9/JVWXrUE1s5AQkRptdCW20IylSPADRlUNqo
         tsTMnCMb7C0ph4ODOQ4fjxe+OR6Hm3kAipbomPvq4YsAd8h3APHQ/B6WLR3ROCF4rFuP
         IzagM0T0Y06G3m8cDattb0Qa6kyj9TWYKBF1MAvUEDMHQLagvxFmC75kJu9/kir58O3m
         CQwiFHF3J1HX/+RjfI+MxBQHNolGi0KE7LxvVZp/EXX1KHqw6TXmySrvMjDCxd7S7HlE
         xg0A==
X-Forwarded-Encrypted: i=1; AKwUvByvBZRN4Tsn+2/5Cap8xjeWK0aAoeB7v8MdDnxBwibtptzifI3yAlUPsWwsvi+YKVC5rP7wxSI=@vger.kernel.org
X-Gm-Message-State: AFuF++miT7OPcDUHoHxdHg7oNrm8w5kMRDi6rE92oo/y7/EEPMu/zctR
	mKL6bJt/W3/Ait9iP/LIoatdUiFZZA1jdECDapnlqd76u5nZe8NKC+b0
X-Gm-Gg: AYBFou01KYPTDfJvwhtox21XabyEs+Qv/g5M7kJJkhy4c1g+G7Nj9ZzR3/nSXR09ALW
	DigV0F6upF2BobnmaIJyVQhms46nw+EO3xX8DUgDUAYa2lROKhsQpGk4op0dl94cOYH6AwW/fhK
	jzI4zV/2DIM+fwgOrtry7oS4yAPD3woeQbY7vHV+EGMYkQllJRmwHmz/vR0a3bDKZbAzXgFcrKt
	kjB9maFDhDVdMeRH3H9QD7y4sjguc2/wBTCXvn1F8U9qCo+pCe0XUv+UXN+6JUQ0yi5klZ3apV9
	eCrWTsaqnzX+D8sgF+QaodLHKRgWkVfssTjoiGu/XQ8kLjrmzuWXDZKOiW2rNW7xvRXt2PhEs69
	MekDQqLUB7bR8vWQPRj3uYJBO2LLjt3T4+uAAyIj0Q2qjqBo6Zr7E2B22/OzuLtQ37zx767Huwh
	SFSJrHFiGIQIJhMimayT4SGaViZgDQaFopjiVUCB0P/BC5lq5kupAmkQ==
X-Received: by 2002:a17:90b:4fcf:b0:398:b1eb:136c with SMTP id 98e67ed59e1d1-39e1e2f3dedmr2184461a91.9.1789527625769;
        Tue, 15 Sep 2026 20:00:25 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395caccf1sm2428257c88.2.2026.09.15.20.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:00:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Yangbo Lu <yangbo.lu@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: dpaa2: ptp: fix device node reference leak on remove
Date: Wed, 16 Sep 2026 11:00:15 +0800
Message-ID: <20260916030015.2818545-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dpaa2_ptp_probe() gets a referenced device node with
of_find_compatible_node() and stores it in dev->of_node.

The probe failure paths release this reference with of_node_put().
However, after a successful probe, dpaa2_ptp_remove() tears down the
PTP and MC resources without dropping the device node reference.

Release dev->of_node during driver removal and clear the pointer after
dropping the reference.

This issue was found by manual code inspection.

Fixes: d346c9e86d86 ("dpaa2-ptp: reuse ptp_qoriq driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
index 4497e3c0456d..440319a1e775 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
@@ -232,6 +232,8 @@ static void dpaa2_ptp_remove(struct fsl_mc_device *mc_dev)
 	fsl_mc_free_irqs(mc_dev);
 	dprtc_close(mc_dev->mc_io, 0, mc_dev->mc_handle);
 	fsl_mc_portal_free(mc_dev->mc_io);
+	of_node_put(dev->of_node);
+	dev->of_node = NULL;
 }
 
 static const struct fsl_mc_device_id dpaa2_ptp_match_id_table[] = {
-- 
2.43.0

