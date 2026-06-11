Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839383624BC
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159327; cv=none; b=fTinanpa74MiwPbi95mg+7r/htaIPPjC5T61Pu3SKDCg//Kqb6n6MvokDQiRKGNTDMuRia+HcgydxH7S7bO8gzLd3ZIdvdTWGRDRvIjCOZNZ+5CCe41huptW8C6/75XswRTYkJA9/PXYGJtcw4CeOj1A4nJPgsNz5bdeny8MPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159327; c=relaxed/simple;
	bh=OoelfBjirpw9i5/nYFRVXtU1s8vRlWtNC7c2OJ/Xcy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ele6kjxNLm3Hhw8evsjzGgEFX8f11jMjNNT0h+3cw3lPWxuMPS+JT6daF/pPs5uusGJbxK16KcyXpMuIbZAsFQY1Cir2x658KfSP+7hyBjJ+j5sGduH46q/jzafMR2U5S3tv2ao5uIYxra8kojGqJSsdnvuHNUa0jBgeO+SHBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m83IAv2U; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m83IAv2U"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c379e8ffso52414005ad.3
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 23:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781159324; x=1781764124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcjSCvdX7V7R5w3yb2h9bVTz3y2HJ7/ux+fWYyG6vVk=;
        b=m83IAv2Uy1PwbWpelTHT8+XCon/4hW2aB4XZJdCuoz2oYouMJME8fXgiaZqF5oWR0E
         IMe13KD9+PJU2juy49NiQx+YuedNAht5KQZineLefRA9Lageaa87d7WDXlZsJSxfVG3v
         V7xckKdkAWnyU0bh2gm4sBP6p4IXNX9X8xUkONp3NPwsZ7d58pqEljZ2hQOvFhgk7wif
         9gPznjd3N/Ccuwk+BCSCnRj4Tv7bqUn+9ZfAEftBBh1Z/9fzZGeUo1VR/4IXuuOW5uW3
         vEFaP3Dm6NtqQb66tGrO8yAdCaZohnsSwuMrw5ujlkWP4+YFkwfd959e3JehG7zlv3B1
         cb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159324; x=1781764124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RcjSCvdX7V7R5w3yb2h9bVTz3y2HJ7/ux+fWYyG6vVk=;
        b=oXDi8N9LjkqZxT8JNTBJK3N55m8mJlKeXsyu5yTUnkt1FUJiJc0O3p3PyQaV7lxmtc
         3zJX57hOJdONkijn0JTRLjDTqByayFaqTBQFsVQMwxx6bN0mUV7nCaceGVC2zknCmSu4
         tel8ZN5p9/d8tg6yl7NV2hUXW3SaBhzxszVyP+7z/pVlJ0YyY0aAlmwCjkf0hVrxyNw0
         DNBKAkWKimgWzq+JjYnFuWvVd0EkZ2Rh39NdU9YAy2cP6ZkjhyxQI/YGFeRUUmwLx/nM
         LpgmZ58DQZ84kXBk9FI2bOcY5jbzKocpdkanylnJeLT3M4MS9BHd878jeNOfY/ERsy2/
         QF6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9RcQGVVozbqhG4Z0VIyo666a7xlG8SS3Zo5C9DdZ2ghDbOiCqNfBZ4fSRcgfyIXcZZfbR4r4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE5r3doHgzWbzXBNVT0O28GCopJGXUc6shdiUKzpxWqSvcZlXN
	WO7V9uhSrnPDCcyh0tn8bShN2O2V+IE7nVtGyAmrpaeLctM2tySwfyFd
X-Gm-Gg: Acq92OGkK1tTO/USZN4KMxE0L7QWpzAyAJBEqN3ZR13QSoFqodPCPVdI1nD2GQ8vhDk
	Kp1/AEx2Y3U61u2s2SFEy8MmIGJxWubyJkr2KHK1vkF8VACtX9WdMuVdw9oYeqTxbHPzPe5hvAZ
	7VDpX+AmGc2BBJ66c+GykFATC7P8RUDhVM1NsORMu0I3Z8kffc23inNhDciFSJVcCIB8ut3Uomg
	637Y4vbeYH/efLThIHxcnTM8R2mX5LCUdCjg4IufmjiDndkCFCAFoCkXjlKB6ws5Qj7AFp4dgZL
	4mS/PKN0F2qHpqYX9y4NlRMI0YHwClR56rXyo8Vin32yLhMyLk7li8hJW43VYEKkhRRnkbVaPmQ
	2G6gV+fRd/svUmAEwBbENmBY7DzhnZqc+gaKl+uR3q23M6BAjWBWh8nLrWOQiacU76mCDfbBj++
	cWACRkFr8UiRqJP4QWh86mHtGp6A3i0e6InAU5f6dmvHVwxXweL4Aj4m1AFxE=
X-Received: by 2002:a17:903:3586:b0:2c0:c3ac:4af3 with SMTP id d9443c01a7336-2c2f229d856mr17512785ad.15.1781159323849;
        Wed, 10 Jun 2026 23:28:43 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm282891565ad.1.2026.06.10.23.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:28:43 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5 7/7] xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 11 Jun 2026 14:28:14 +0800
Message-Id: <20260611062814.2528793-8-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrmi_changelink() operates on at most two netns, dev_net(dev) and the
interface link netns xi->net. They differ once the device is created in
or moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in xi->net can rewrite an interface that
lives in xi->net.

Gate xfrmi_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/xfrm/xfrm_interface_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 330a05286a56..688306bf62c5 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -869,6 +869,9 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct net *net = xi->net;
 	struct xfrm_if_parms p = {};
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	xfrmi_netlink_parms(data, &p);
 	if (!p.if_id) {
 		NL_SET_ERR_MSG(extack, "if_id must be non zero");
-- 
2.34.1

