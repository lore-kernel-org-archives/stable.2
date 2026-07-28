Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4C42FCDF
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240681; cv=none; b=D66kg6R8uP8HXJGINM5xmkEkojfONmHO+ZMd992bh9Ybp2Q4LjWKlqA+hQYe3Ha46eUiK306YJTT6Gvlcal0VXYFnjGyI/8Nmn3l6mpC23JF4S2UH0QpLNNnMKaMLJ1VUoTW89Ubma7ZM2koDVkFhovM5KFRMrSjs9AYA7mBlio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240681; c=relaxed/simple;
	bh=PyFm6IReYBg1THXaXLm4DqSrxy4wTK7TUT6CDBOV5Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCCVSR8xAbYLXG0cdYkANfI10p85L1V6g6qlD+90UsqFgBHDDCk25jx5bc+7H+UbujOVReW4e7GcpKV2RdqfcZJCTVl6RI/jnHAt434lGGWl6nuDtPXPsq1CupjYUkkAWtSAd2LL1mC+yPpaTs8cwPy9sxU8YA1t/4HpyJ3zEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2zJrjyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2zJrjyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAA61F00A3D;
	Tue, 28 Jul 2026 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785240679;
	bh=ghuphc54DuyJ0SRC2B3/c7k0zTSFneeIGv319symQpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c2zJrjydh6MwYV6IZQ751ZHPkOk8q88rqs/qqI9lNSVV07hSkLrQun5bFfPno9+k2
	 9B0LbjMPnS9qgYCrpOigSx4tQgcJHzVk35I50ssMRG78n8lw4FihDh5PY668WpFszn
	 6HNxShRqFR6xwvEGUTt2KIpdhVfITZQ60na1pZ5URDYOIOdJOMAblBrdNITAz6Nf4S
	 skSNcyj6UegkqLZ43wWHw7Yq1I4TQDGy9vptisQOmOrUG5XCEOA/vTZBPwAX5u9cHg
	 FZa0mlmF7rgzluUSigcojLEigDDDvy0l9M4rYlA1HFBJtUtOGaiFZNXgKu6l6mriD2
	 uOt0NguWDIQ8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] net: ipip: require CAP_NET_ADMIN in the device netns for changelink
Date: Tue, 28 Jul 2026 08:11:16 -0400
Message-ID: <20260728121116.3703252-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728121116.3703252-1-sashal@kernel.org>
References: <2026072005-sabotage-stylized-6dae@gregkh>
 <20260728121116.3703252-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maoyi Xie <maoyixie.tju@gmail.com>

[ Upstream commit 8211a26324667980a463c069469a818e71207e02 ]

ipip_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate ipip_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 6c742e714d8c ("ipip: add x-netns support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260612085941.3158249-3-maoyixie.tju@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index ae4bd3a3ef8156..d22d8e5f4abc1b 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -478,6 +478,9 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
-- 
2.53.0

