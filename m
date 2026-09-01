Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F724562BF
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250489; cv=none; b=qLaXtDvnvpmopC4J+A8hl0QzU4voFmOvPZnaQJoB2nhaI5twznomsn7uONLDMPP7F89BHSEsiFBI7I/GdZUjpxohOreXVGl1dvtnRM6RYPXdtFe+uFcO3ZQDjkLsrif5MexUFGMJvw2H8VG/XyARPi3i0auwfoBHo5r1fcFgaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250489; c=relaxed/simple;
	bh=hbydSP65WtHqP4eOKMyby1FqEmByMIfk6XKz9NEIeXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwYYJ0C8I1HOks7puD4myqNWZeubx51w3jy0yfs3TBXT4Pa7LYHf2VhI7/CZD2h0EF6u82I0GhnmV7j8N3mk5bs0ErEOkYcRQ/7zdEPb+wsJIocg64a1xr7JIMUP4WEI8lO6X91bAjURL7sNDxDVmPoqVZQZVvWinzi6xnAcYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcRyselv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcRyselv"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso6318235e9.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 01:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788250486; x=1788855286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wOcY9/1/vy5nZUTSXmW4rjU1UUb5AfBngzqbqLKER/E=;
        b=AcRyselvsX0r49TWCz/lmmgoOm0YRgwBEb4VFl5wzf84mqG2krXRtsCrDlXzpnctca
         0CBfZccsDF/+GiS/Z//ipWBL+SNHDL75Go7TR5Yha1GEfkXxXxOF3WtR4+/hHubu7vZP
         wY+4i+9RleOW0V6YGcQEkF4VwGIwBEc2CfysQI0B1/6v6Oum7/+mqHDcoa6HcHh2RRFT
         duNcaYAWem0Qwq54HTTD19N9UYQbNVroWE0JaSh5NCeFRx+ZbylZ4p9kbJArI1q3Nplz
         MR4cjJorCIZyLHNKRYBPrLfUh4oGelWR44Jcsfcjn1z/y9wrLxwGx9mwK05BsFApCASP
         0+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788250486; x=1788855286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wOcY9/1/vy5nZUTSXmW4rjU1UUb5AfBngzqbqLKER/E=;
        b=Gl3c5X5fiV5kD/xNkVl/2v5cRRg5TO+JAxXdkam5d3INL6EetMDVN0apG9Kf6Me7HC
         rpwfyb5E454pWVAcgb6dotu+aN9XmuoEAOqQjAnJ5mf2AnJkA2ybSghkG4IktRAO3jMX
         CFT49itgQJ1bvKp4jrtnMTl4QQR6lHci27iTIGygTSGdaj0yMAzIKiBA9qg2UT4vNdvM
         uI0ag0/ZBihzT0opR2gEqQyfqFtgf4myZDBfjjJvMTOY8uZvsH4+6OXaOc141jTmTvE/
         E9+T4kLGsErlZydGNfDQEOhaDIMopc0jkaBSQfMenOTY9C57FCByR35mshG9UCl8Ev4m
         5w2w==
X-Forwarded-Encrypted: i=1; AHgh+Rqd6DnNftjS6WRb9pEoZMijNZWJxwv5a/VDCW0be8m+zFfOf1oJ45Eh7/el8m2fj56rOXj2uMg=@vger.kernel.org
X-Gm-Message-State: AFuF++mnctTQ7mXPCk4NMzhQj/kk0M7qalrQ5zkM9ZKo9TD0QbyrRrlH
	V7Ymj+hjcUUqrkTHGLQyrEjNa7Gy33vlZq90IA7Tt8PtLj0+uSHJ2pmK
X-Gm-Gg: AR+sD113x0OyCnCaStgX3dhbApu9HWdg0V8L18MZp8uXwCX9dqAUnlsLXJljGHO9+ph
	lfdE0aTvYa0L0pqeHHvPLEPYFmt7A2OBWTBrMJn++d7zHJ9nnoJbyIv30lpQrCsTxpEbryzpkit
	uQPtdmWDWtZ+lwAjqPLwJ2hMuOt4LAuiVHHoxSKu0GlHLcDexVi/A9n27S5kLdj5m1MuvVJU1AS
	zcRvgqiaajgCa8jIyvokz70E3sxks5Sx59IjxluSG2oLdLCyQHQoiwh43z9kfQxey68knGj2jUC
	gvTYs4IIaEmB4udFeA1qTSG2JCaU+q6+sTnzGRpxv3hTXnARU9VewzZKh1EqOBFmsFlgnYN3hEK
	HZaNPItRgQM3GVzkp+V14uFB0e0k7f3nvvjMeqIO8gKV+DV4yTqQ1aYZK1yp6EGx9O5WFQRbcfc
	40CW+M/0WfYKm/kWdwVzphVDyeOiWh6gpp4u1nwupM7HQPxGYI5GuEfhaGciUahHRyv3nUUfbiZ
	66+5Iv7
X-Received: by 2002:a05:600c:4704:b0:493:cefc:d113 with SMTP id 5b1f17b1804b1-49b91c2d8femr486502995e9.5.1788250485957;
        Tue, 01 Sep 2026 01:14:45 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.113.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9266be71sm722413855e9.2.2026.09.01.01.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:14:45 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sean.tranchetti@oss.qualcomm.com,
	horms@kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
Date: Tue,  1 Sep 2026 11:14:41 +0300
Message-ID: <20260901081441.632-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An rmnet device may be created with its real device in a different
netns than the rmnet device itself (rmnet_newlink() resolves it in
link_net), and the rtnl config paths below only check CAP_NET_ADMIN
against dev_net(dev), while mutating rmnet port state attached to the
real device:

- rmnet_changelink() rewrites the endpoint mux table and
  port->data_format and, via rmnet_vnd_update_dev_mtu(), can shrink the
  MTU of the rmnet endpoint netdevs.
- rmnet_add_bridge() and rmnet_del_bridge(), reachable via
  ndo_add_slave/ndo_del_slave through RTM_SETLINK IFLA_MASTER, flip
  port->rmnet_mode and port->bridge_ep on the real device's port; with
  bridge_ep pointing at a caller-owned device, rmnet_rx_handler() then
  forwards real-device ingress frames to it.

A caller privileged only in the rmnet device's netns can therefore
rewrite the shared cellular data-path state owned by another netns, and
steer its ingress traffic.

Gate all three with rtnl_dev_link_net_capable(), matching the "require
CAP_NET_ADMIN in the device netns for changelink" series (vxlan/geneve,
CVE-2026-68432).

Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates to existing devices")
Fixes: 60d58f971c1077 ("net: qualcomm: rmnet: Implement bridge mode")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---
v4:
- use the netdev comment style, per Subash Abhinav Kasiviswanathan
v3:
- cover rmnet_add_bridge() and rmnet_del_bridge() with the same gate;
  they mutate the same real-device port state via ndo_add_slave/
  ndo_del_slave and have no capability check of their own
- correct the impact wording: rmnet_vnd_update_dev_mtu() only reads
  real_dev->mtu; the MTU store lands on the rmnet endpoint netdevs via
  rmnet_vnd_change_mtu(), not on the real device
v2:
- drop Reported-by: (implied for the author), per Jakub Kicinski
---
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 78d4df55740a1..73bd5419cb136 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -312,6 +312,13 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!rmnet_is_real_dev_registered(real_dev))
 		return -ENODEV;
 
+	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but the port state mutated below is attached to real_dev, which
+	 * may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev)))
+		return -EPERM;
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	if (data[IFLA_RMNET_MUX_ID]) {
@@ -440,6 +447,13 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 	struct rmnet_port *port, *slave_port;
 	int err;
 
+	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but the port state mutated below is attached to real_dev, which
+	 * may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
+		return -EPERM;
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	/* If there is more than one rmnet dev attached, its probably being
@@ -488,7 +502,18 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 int rmnet_del_bridge(struct net_device *rmnet_dev,
 		     struct net_device *slave_dev)
 {
-	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
+	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
+	struct net_device *real_dev = priv->real_dev;
+	struct rmnet_port *port;
+
+	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but rmnet_unregister_bridge() below clears the bridge state of
+	 * the real device's port, which may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
+		return -EPERM;
+
+	port = rmnet_get_port_rtnl(slave_dev);
 
 	rmnet_unregister_bridge(port);
 
-- 
2.53.0

