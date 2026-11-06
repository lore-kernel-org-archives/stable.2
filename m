Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969255;
	b=z7TXf9CeTnq0tsZx3N7EtATwr/LEqE2XmvZsGgrkooTNf4T7pt4IEyl4YKzUSNTR8a48
	 1qlU6Ty7i5wuAjUjif/5CZ6AZV6CkSh/7OjSiYnLPR3Fi05Mya15w/AibU1UvWMbjkBwy
	 usA7ANJDynYRZ9KfM4yIIoiAft4W9jjFOdMx1pF1veGplITxQKtB3eDdS0fKk2DA3HgjQ
	 0QiQ9xYYjVBIQ33n4QotUSxVFqmUBDOQdCGpjJg3Z4k7C1TNYkQfk1szsG6SfRS+T7ZcM
	 jmBRuz/3r84ch5J+SAQIZ/kmuhBxZkYz93jjZToIusuCe9kcZDKeT6pRcd0j1YOpCrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jbz4ViRXJQJmGQTHmz/n4fB3e11Y7YXX3ix7TPBKr/Q=;
	b=2d6OE5O/bB1W3WMAH8k8hynHtqOAdbwtpGCJ5bOUYwHkOwEsMYYfMUuzOfuCLUxSMkHL
	 uYp5+IIa5yJcfjBYRpCYvHXEm3sXH5Gn0Nvu+BXBPk8bQa6VgNEYYjtRN/dhTQENuurJo
	 nL1o798WOFT98D/wXk5QJaxJ7KTayckj3/nkZH8EWQcGoIHwyhDHNNOa4HKuYUh6Rgkbh
	 FNPXOd5RQlyBmTufHtmRPjgGwydRYyPNBJ0kOb+u7h4i2prYrp6EIWDv98hlFklpAYH2o
	 lEJ2GzKZVbcXCy0Ml9MkyY6HVCoiNZRwWKohunOluNoQxjEqgD6xBIHPrwIMaLTj+/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYE8JxpC;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35714606A33C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35714606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYE8JxpC
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-370231dbf90so193528eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969254; x=1794574054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jbz4ViRXJQJmGQTHmz/n4fB3e11Y7YXX3ix7TPBKr/Q=;
        b=GYE8JxpC/XsGkeI4sBpOQ6DJvE77JIlVnRsWlvafhf3pFfJET9MlXd8nPF2d5DgUP+
         30WS2GXdlDp5aokJ22hMIPfJsRLfyGU0uIcm0w+YRP3oBnt0PJjqL0VfCVv6cMUmRwdc
         1cnijDYPjmej/v5Qh8w8xNAlXKNpPqzt0UALSXJ2Wij/wThr1iZrHgNX2RsIv6YvstCf
         65nNWEzTdciPyY6MSNg6KVCUPq/yYaxwVJrQ3Twvabjqwr7fcYH0ABw6WLAInNcndsbv
         lGmqZIkfUzo/vmfc90H6TitpSeBrfZGWZ0O+q+qM7jL8CdR5Sf6dX3kw+KbaUpskv2MQ
         wnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969254; x=1794574054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jbz4ViRXJQJmGQTHmz/n4fB3e11Y7YXX3ix7TPBKr/Q=;
        b=CCSJ/lZ1i4esaXTpYzJKNocQ2m443eHQZskaWNFnEnP2PkzEJUETU4t1hKvOISscuO
         KOYi+rpMky1R6+8ZZ2paNNx0g+2/tyH7n69/IUcKMQ9fLLV1HLy2rnU9wXvX57KPSfAY
         Fd3O759Leod5jDLrcCIkvW9MWSu/ugpBXCbCDmRc3ZvQvRVjxEoHKeoD+QCBbwDAcOyV
         8n3sg94zJBT3jp+W2y2DDMb9xvJZHY2zpT4hB3g5fpqX+S0XlYa9RiP1E7mxBzFrq1lh
         BLU1c6KBhDodkWgIlYaq1DMsM+WE/dQVFS1gRPrzhWv1lCmx3J+9HxMZYX5LN3ahm4lC
         5MOQ==
X-Forwarded-Encrypted: i=1; AL+hErGbAfInoVNEKQMdsBrN9rQRMOLpdR2PCU9qGS1U1q7lFst7FP8u42lSj1a/ku3qFLpsOBWoWKQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IV6Z6ZgPOKS8Od+tqA5J2gghtdh/JS83wO3InAKnVkXK2q/N6
	U0w27gjuUXI5X2ZsUHKJB5Zx/KD+3xitKILDowuu9uZhQNWwswpSNYtz
X-Gm-Gg: AYBFou0/qu61sp+8fvZcYwOcWocYFF8UBnh3cV/fWQn8X/OG+2fX3m3FEuanegaxNLD
	u7/4zipcSbqCID/F4GHmEVP3pM6S0H3PYs80ihSansR7ZI9SJ+v1vIPaIB/QqjqWDBXMK+ov3TO
	laIQo9fEmWuDhm+U4PmGFz8fL3AzGb77TyLEs1HHUDydm8xHIPDjFqg+1cRI5MEXIknF1kKbetn
	rwxyDjYzTxAjXaA7QyixpZCImC5w4EoPR9wgLoek+DewHOKrHZVQoNB1eWElU1JWTr9OXpFt1ZC
	/ycNNyVe6SFb6yGTp3+LQzaj0gtDM1VLECUr7HahJfdL4fDYPYZ59jiSg/imv4dSM1TrDYHpEcm
	JvwxKuIGvWhu5ZUruOA4VsLVRobMd4EsC/NZ0X9OdwBW+5eIWxopT+ES73pxA2ZglY8l3/ZESRK
	ZAPj6b0w+PtJmlmGmSI3SqrG2yKKPZXsR4sfRxBwxrdhvfdhPg+HxUr/B4tDFk+hqqzT+VcOy+H
	MLbp6hGPw892qkH5fiuII1tW2SfneqGw6PmwWiC2B2kUvPrTITdGhf8Stxa8mu+oOZci2nMPd5o
	OnKT0RXjLgbuoS2nUOMOC3rF4tE/Kcr3zebUWeEO0tBNL7XLbNSBxABzeP91j25XjDcw/9qjguW
	+a0ZmY9d0z8l6LMRi3gWrlhYsEmnprbb6sFrJZA==
X-Received: by 2002:a05:7300:ea18:b0:36a:12c4:8bdd with SMTP id 5a478bee46e88-36f7554337amr3612023eec.21.1793969254337;
        Fri, 06 Nov 2026 04:47:34 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa30138fesm6844272eec.0.2026.11.06.04.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:47:33 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: davem@davemloft.net
Cc: edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	n05ec@lzu.edu.cn,
	ylong030@ucr.edu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	dennylin0707@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net] vlan: prevent cross-netns MII register writes
Date: Fri,  6 Nov 2026 12:46:39 +0000
Message-ID: <20261106124639.12584-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

vlan_dev_ioctl() forwards SIOCSMIIREG to the underlying real
device without checking whether the VLAN device and real device
belong to the same network namespace.

A VLAN device can be moved into another network namespace while
its real device remains in the host namespace. This allows a
process with the required privileges in the VLAN device's
namespace to modify PHY registers on the host's real device.

Reject SIOCSMIIREG when the two devices belong to different
network namespaces. Preserve MII reads across namespaces and
allow MII writes when both devices belong to the same namespace.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 net/8021q/vlan_dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index bca0a3693636..0d0904103302 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -416,9 +416,12 @@ static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	ifrr.ifr_ifru = ifr->ifr_ifru;
 
 	switch (cmd) {
+	case SIOCSMIIREG:
+		if (!net_eq(dev_net(dev), dev_net(real_dev)))
+			break;
+		fallthrough;
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
-	case SIOCSMIIREG:
 		err = dev_eth_ioctl(real_dev, &ifrr, cmd);
 		break;
 	}
-- 
2.43.0

