Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25846F48D;
	Sun,  4 Oct 2026 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791145941; cv=none; b=D3vFFWJsaaIbpe2ZGY4C+IZlPrMmtT7aSjLEUOGmLuq2+4n3lqzUIv2U+aqeclfxMjruq9FXvr/Bo1oZY6pKUZzCeAE0y3Te+cu+h69fOsqRWWBmTCzDdKIV/zes1DOifYHTSNbmKQ64W5NY8Xe1TBzdu2IOcbNSoJ0fWV9UaUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791145941; c=relaxed/simple;
	bh=oIzCA0Ouk7T109u03t6jw/xCJYMvbOFK80sJbAbO0EE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kjzuf3zaelzN+k07JvHHo/veaVMxwiqVMQJPESad24a01bnOGOQAJJEc/2QHQ8zmXvDyPS+t17H4B2j60k9yidG9l9qQt5SAT0TWsnMv+igG3hv9333UBOkUizwgpih7bklTuvNnYbpbom5Oe1vbS1AfDzUvVvTXMUJvnafvGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=MWFTrdwZ; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="MWFTrdwZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=p+iesSfsDsR+tdcNJWQ0YJUQsl3KCeOY72NG0wBFil4=; b=MWFTrdwZnU9c0JUEmu3X2R4Ya2
	3SrsWre6H7veF0oY08o2tZcqqa+/cvC+P9ckC3CFSlqOzmcrXsoVziWogGITXVIdqt0zlrLLbuPla
	pqeW9bWVpIQ/Xud3GMV26WdbWfBafQKGUJUxZRu0oPR5AWZu47QGeXlaTvMQqoeMrhaMnpKfxTj8k
	rGjM8MrXP4NddkZZSt1/XDY5snnoA+9HipcTruArqUlzAbDqDsoxEnlDUSybNak4ZtvW5id1Cpi4V
	i8FO4wUPRCTlNuRSWbs6kqiXbq5+xM9arwscROzul4Vue7osUlt1BuZYx/WT/h9PniBg4/F7rcw6I
	bffOjKgA==;
Received: from [151.115.150.205] (port=57118 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xDSsT-00000006qBz-023y;
	Sun, 04 Oct 2026 22:32:09 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: qualcomm: rmnet: require real-netns admin for bridging
Date: Sun,  4 Oct 2026 20:31:50 +0000
Message-ID: <20261004203149.3042491-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

An rmnet device keeps its link to the real device when moved to another
network namespace. The bridge callbacks change the real port, but rtnetlink
only checks CAP_NET_ADMIN in the slave device's namespace.

Require CAP_NET_ADMIN in the real device's namespace before adding or
removing a bridge. Use the slave device's namespace for the comparison,
since that is the namespace rtnetlink authorized.

Fixes: 60d58f971c10 ("net: qualcomm: rmnet: Implement bridge mode")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---

Changes in v2, after Subash Abhinov's review:
- Add the teardown check and use slave_dev for both capability checks.

v1: https://lore.kernel.org/all/20260821202845.4053530-2-Jeremy.Jean@oss.cyber.gouv.fr/

 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index bed6f63facf2..62d7acb13e0c 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -441,6 +441,13 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 	struct rmnet_port *port, *slave_port;
 	int err;
 
+	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(slave_dev),
+	 * but bridge mode below controls real_dev, which may live in another
+	 * netns.
+	 */
+	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
+		return -EPERM;
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	/* If there is more than one rmnet dev attached, its probably being
@@ -489,7 +496,18 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 int rmnet_del_bridge(struct net_device *rmnet_dev,
 		     struct net_device *slave_dev)
 {
-	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
+	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
+	struct net_device *real_dev = priv->real_dev;
+	struct rmnet_port *port;
+
+	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(slave_dev),
+	 * but bridge teardown also updates real_dev, which may live in another
+	 * netns.
+	 */
+	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
+		return -EPERM;
+
+	port = rmnet_get_port_rtnl(slave_dev);
 
 	rmnet_unregister_bridge(port);
 
