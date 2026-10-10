Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D602ECE86
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791613856; cv=none; b=deGzyx0BZFwEZtdAdPw1FZS8qtVo/+9rv5JC5fsSOyXj63hCidQSAP8tw0GqwWsVDJdIMuZZBavIAHVPjamQJzhT2vGDa3RCi6zQc0onGUgedvFho9u4+QBdgbJOh3y8wDjWJ35emPo1iaRW3Ul4umQPWoQ+NXkzSblpyxxNifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791613856; c=relaxed/simple;
	bh=UU9e/DIEZIoiwv6BQyhSYSDdVEcIQaOzjBs1CU/yQjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1MW4xirV6tgoCqfb22At9MZDeWliO2AySkeRJgWFtTjhM35FWHDKG52o4Yego5fst2d/65SRww5L4GI2dHdw4ABzJLs+XAqsWcVsGIlKRWcZPl4/GnMyaplBSQlapX8HW8XdEhXut7VTkZy6rukK1yaK7xPpK0oKS1db6xuR7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pH3kI7BF; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pH3kI7BF"
Received: by mail-oo2-f5.google.com with SMTP id 006d021491bc7-6df36d0b4e1so115848eaf.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 23:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791613853; x=1792218653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2I0Ul8sPqzlVU5TVserEHspod34j/pr1dNRLi4dN0Ck=;
        b=pH3kI7BFeVA5H+GYQg8ysrhbUtIzrHJX1PbHbS4EFoSc2Lr3KKuxHX5+Qs432mKTVu
         zV6VgvHnABIlQoC2zrGMkL08j0AHvJwmDf2znz5CwLTsU5fqdNNM+YHx8ukl3THN+yiP
         LeFnugd3zVNcObeOgQsjJAeK1Oq6+TMCB59qUZJLjijHz0MbCRsROOmc+P3udQFKos81
         dZDeuxbltJh35bxDpff4puLluI3/ihEnrTAPdtzAWUpw+Y8aTKSE751nXM0+/57ofuYd
         Ue8HeT7QL7DwU2/JfWVuCeWJ3fdgGsCMreuUVJcOXYU7ghOSohrKTD3/H8mmbH32hAYS
         FiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791613853; x=1792218653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2I0Ul8sPqzlVU5TVserEHspod34j/pr1dNRLi4dN0Ck=;
        b=xHVzmbkkEJG1WZ0kM3F7W4EWK1VnOad9eGutXR+tmS3VofSoUH6fyGrcQ2s9UgVBOX
         osmdj8Z8pRgUvnJqNDewpQL05OuGLWzuz0RgfNEcpxhoxh0CCMLg3zpIPtTijDA6Sc7m
         18+0SaEh89oj/EHqHcgts9Is9vLYgyf3lA7Z3egT7FGm+kpWLJxZUJFJ/VBKWa0s2Wsu
         JuKJb2EUzT/DXQpTpHPwl+NDMUuL7QbvsLx++T1bdIu4y3HCrjzZ7zlCCHNeHe1S28y/
         NpCRZIcUNAjn66bIh4WPeI1fb1RqWAj/rOFzS9INyWRJ0OYXLRhaMPe3KV33bxe17Lgm
         tf1w==
X-Forwarded-Encrypted: i=1; AKwUvBwpNZIOZ15Ba7IXhYkjwF8lC9Wrg9qHG2msjkRLsTtQZA3ktS1H25BwKCgK/yg+eP4omOvlFF0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/sPdIHxQfHbp9Z57Qfcn0fohkFZ2oPCbTQLY6s4dNRre40DFb
	IRduD49Jh4Ba8ri8tfMkXDfk+0OH3JoY5T7dfTmvbLcWdyQ1qkK6QmU0
X-Gm-Gg: AYBFou14l9q3srTUaQiOfEtLm4a7hH2bL68lsBlyvKTNVPd7q43rTEtOTOFN3Hn2VUv
	t1diM3dXh3449X6QfAKFoVVxIYIan3m3GUMPyHO2slGWWJr/iD3yIXv9pCzdDxH3Rd3Ppqa+hqu
	SvqV6dJGbAbpcntx/HGWCXYSl/DtvqS0m57rgCL80psVA00qniZt7PVutvM0EBxN1AqSQxy9imt
	sE+LY3NaM5ODc8xn16leopWJE8m3bA6NjMeRZcWdVzO8dP/AE0ReC2D37rZzI0zLEpDDIeAXC8a
	rdGycX0RlDZUgFa5bM3PnrgfcFkIofXuGAMNAfEVHt04MCIdiavgX31bgopDDkN7TXnGa7z7zwg
	i4/CVOQAKvGSOMkUNCo54xXnNOuubaSZiHZ7oe7Ae10wbAv9ybr+iyOM/s7Y2N2MlHvcHeWDlba
	w0ufjk5mVI4OizC81MP22PvGvOMWL3ocMDSS6MmwskFY2iGAZz1E1pFxcFINRtnxxDBjqSaeFwo
	+zcd10BHH0Cv9W3zpWNHDMz7EPEaPO3NLvhvYtmIpzMtEbt
X-Received: by 2002:a05:6820:16ac:b0:6be:354a:1cec with SMTP id 006d021491bc7-6ef0d333abdmr2941085eaf.27.1791613852696;
        Fri, 09 Oct 2026 23:30:52 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.38])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a328da8sm3999286a34.24.2026.10.09.23.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:30:51 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] macvlan: require lower-netns admin for IFLA_MACVLAN_FLAGS
Date: Sat, 10 Oct 2026 14:29:44 +0800
Message-ID: <20261010062944.2671656-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5b782a811e73 ("macvlan: require lower-netns admin for shared
port settings") added a rtnl_dev_link_net_capable() guard to
macvlan_changelink(), but only covered IFLA_MACVLAN_BC_QUEUE_LEN and
IFLA_MACVLAN_BC_CUTOFF.  The IFLA_MACVLAN_FLAGS branch performs the
same class of cross-namespace operation: in passthru mode, toggling
MACVLAN_FLAG_NOPROMISC calls dev_set_promiscuity() on the lower
device, which lives in the parent netns.

A macvlan device can be moved into a child netns owned by a child
userns; root inside that child namespace (no CAP_NET_ADMIN in the
lower device's namespace) can then flip the parent namespace
lowerdev's promiscuity counter at will.

Extend the existing guard to IFLA_MACVLAN_FLAGS.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: df8ef8f3aaa6 ("macvlan: add FDB bridge ops and macvlan flags")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/macvlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index afad90b9222a2..d30cffddb1e1b 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1641,7 +1641,8 @@ static int macvlan_changelink(struct net_device *dev,
 	int ret;
 
 	if (data &&
-	    (data[IFLA_MACVLAN_BC_QUEUE_LEN] || data[IFLA_MACVLAN_BC_CUTOFF]) &&
+	    (data[IFLA_MACVLAN_BC_QUEUE_LEN] || data[IFLA_MACVLAN_BC_CUTOFF] ||
+	     data[IFLA_MACVLAN_FLAGS]) &&
 	    !rtnl_dev_link_net_capable(dev, dev_net(vlan->lowerdev))) {
 		NL_SET_ERR_MSG(extack,
 			       "Changing shared macvlan port settings requires CAP_NET_ADMIN in the lower device network namespace");
-- 
2.43.7

