Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1321631D757
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504310; cv=none; b=bYXoeoRzw7NC2O3iBPiCu/5REhnISg+RryYTbfAuxZ+NTdZAFvSH2ta8X0fqoYxyyzTab5hL64kMaDBF7cNXVdLGJjAAn1Z95QD7wit5zWbF8XLvdQY6AI7eZNtXs1v8dOjlCltMyfH1xasDgl8w9ykAcpsws/Npr0mDtM3lqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504310; c=relaxed/simple;
	bh=CVbqU4UILT9UypWpoyKDhcODHHiU/Kbm9lMPZMnNndw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/RUFg+XtX+w3+ByqM5pFof6IBrfgOdJsLdbZbwXwrtwMZ/sw9TJKRuUa8r10IBJyb0Yu0JUotRnjiopb5WEs/j6381VZDMw57lZHUe39Qa96zapRIsrwMG8HcHk3f5Wg1zR1c/b7Lq4+6QpecU78o2FvRNIHBBeBbhPwMtP2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NL6XuYfI; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NL6XuYfI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783504248;
	bh=Usj/jiy/roQQGOhAo6uZe0x+er6esvQI96bpSt+Q0tg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=NL6XuYfIkENfEQbTSqHFbyS3SCB/ay/p2fxvl9QMMXi6ci13q9ZFN0W1dkJ9YZjRT
	 nt4p+Gqd4cKd2Crx99bS2L6T+6cMqxEDh5oNEHeRxf2yPRs0pP1SKd23MbYtM7wVLM
	 wF7a/R4s2Xwe4yZ0rS0hiow3H9wJc26Zvqim1MDg=
X-QQ-mid: zesmtpgz3t1783504229t74fc9ed0
X-QQ-Originating-IP: zSk7BJ732ogX0z2QYf6a5ZP4zTmHd8jlxE1x3PAitYw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 17:50:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18296009099605312639
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 11/11] team: fix header_ops type confusion with non-Ethernet ports
Date: Wed,  8 Jul 2026 17:47:23 +0800
Message-Id: <20260708094710.27047-12-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260708094710.27047-1-guanwentao@uniontech.com>
References: <20260708094710.27047-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OcIiaahx2ZjKBjNnEqMqiyYQiABoGQzkSoBgBCWYTe/fo/iYIA9NICmj
	hYfYRmldf+IX2ZCZ+T4QaVBOvyjzXeSDW3C8CBqJ5mip4uLteGUCEJD8uwXBnn454AyCZxu
	JNVl1cor9xzVW8h6HSOKVIMr6VUDPJlu43yxfbgJSxb6svJtOuGxKjgDvHpBJTvtEmeDTS7
	I3eGTCLIIRAxLiCccDuyGcCH9jeGxm9V8/LZKehkJgcKIaVDHK/3jWyKjSxpEplZ0ABFvXD
	3RlHMxjIGCQxfGa3lUTPAnewkvgWQB8Z7cL2MeKTtb//OCMnEFBohJhl3WZw1gH2aQjGfOZ
	Pm09qWMfQFRUb7nd+CKOqA0unDS3lTEd4y9jHe+psAct1W+kv15lXueQid9pQZsn7VcNDbb
	guY1RKsVbdM01ZbJCx3TvgQdkf9YOjIDAXeM6WV3oHEsjBtcg1Zj3/q2JZ7NgandePckQKB
	qefgZSsNMpIr35DRNRV3FurWfrV6V0/BapyAgUz3TK4o3mWzSEIoNWZFtdm8i3GYVDLXmUc
	XSboWKbmvLEy5VGXzC2hxOgkugkSi6iurI4YJs3++eIPi27CCGY9K15zVBP2AyhdOnI5MGI
	/9CV21YG9csD8uq1m5LP4XDnWCP/dSueJV5+StJ0Ic7A/cCnjiPtckZ9ODfdsgKArwqCeK9
	l0JlgY1bvCCpKvOyho8LDJ8IY1kLd0lEjsB5mp5Ig5WlHa91OjT/BwTJT5owHZqrxim0AUX
	Tjl1+d+YoF7vtZBK2wihP6c6jubPr2LV8mgdCo+3zK074vH+uo4jixXCv7j/KNKtjkoS+o9
	+8XHn35q1DZi/OVtYqT+ahMi7Y8cacFaEhXKp/bXWScAWllIyxwCUi1iy0WHH59BT1soe5x
	sOaMvBTPpZ9ZDBU0NU5u9CFJKonidueA8uCRfo6hiImi741q7LiqBNUebfkl3fIc1ADTklY
	VmIjAwqG8QGZIzYR5CSYkDZ5vQzB2CNkXwS/ffm/TI2kExMcSydH3k/rF4na8krzdsw8ohj
	dBOHqwD0v6UpjX1xm137E36FrLV8cssOrxiv4foT2UTp1BRGFgaHbIze5j2GpsMi2z/Ox0i
	ruhds4UNLMCTxktqm84z8EIO2nfR3QL/O3mR0OxWT1WpdV2UdK8yg18kVS7n/13JvVfF7qe
	x5NAYTAm2K7QyhU=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Similar to commit 950803f72547 ("bonding: fix type confusion in
bond_setup_by_slave()") team has the same class of header_ops type
confusion.

For non-Ethernet ports, team_setup_by_port() copies port_dev->header_ops
directly. When the team device later calls dev_hard_header() or
dev_parse_header(), these callbacks can run with the team net_device
instead of the real lower device, so netdev_priv(dev) is interpreted as
the wrong private type and can crash.

The syzbot report shows a crash in bond_header_create(), but the root
cause is in team: the topology is gre -> bond -> team, and team calls
the inherited header_ops with its own net_device instead of the lower
device, so bond_header_create() receives a team device and interprets
netdev_priv() as bonding private data, causing a type confusion crash.

Fix this by introducing team header_ops wrappers for create/parse,
selecting a team port under RCU, and calling the lower device callbacks
with port->dev, so each callback always sees the correct net_device
context.

Also pass the selected lower device to the lower parse callback, so
recursion is bounded in stacked non-Ethernet topologies and parse
callbacks always run with the correct device context.

Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Reported-by: syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69b46af7.050a0220.36eb34.000e.GAE@google.com/T/
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Link: https://patch.msgid.link/20260320072139.134249-2-jiayuan.chen@linux.dev
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit 425000dbf17373a4ab8be9428f5dc055ef870a56)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/net/team/team_core.c | 65 +++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 5cd1807e11f79..a4bf020cf8e7c 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2128,6 +2128,68 @@ static const struct ethtool_ops team_ethtool_ops = {
  * rt netlink interface
  ***********************/
 
+/* For tx path we need a linkup && enabled port and for parse any port
+ * suffices.
+ */
+static struct team_port *team_header_port_get_rcu(struct team *team,
+						  bool txable)
+{
+	struct team_port *port;
+
+	list_for_each_entry_rcu(port, &team->port_list, list) {
+		if (!txable || team_port_txable(port))
+			return port;
+	}
+
+	return NULL;
+}
+
+static int team_header_create(struct sk_buff *skb, struct net_device *team_dev,
+			      unsigned short type, const void *daddr,
+			      const void *saddr, unsigned int len)
+{
+	struct team *team = netdev_priv(team_dev);
+	const struct header_ops *port_ops;
+	struct team_port *port;
+	int ret = 0;
+
+	rcu_read_lock();
+	port = team_header_port_get_rcu(team, true);
+	if (port) {
+		port_ops = READ_ONCE(port->dev->header_ops);
+		if (port_ops && port_ops->create)
+			ret = port_ops->create(skb, port->dev,
+					       type, daddr, saddr, len);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static int team_header_parse(const struct sk_buff *skb,
+			     const struct net_device *team_dev,
+			     unsigned char *haddr)
+{
+	struct team *team = netdev_priv(team_dev);
+	const struct header_ops *port_ops;
+	struct team_port *port;
+	int ret = 0;
+
+	rcu_read_lock();
+	port = team_header_port_get_rcu(team, false);
+	if (port) {
+		port_ops = READ_ONCE(port->dev->header_ops);
+		if (port_ops && port_ops->parse)
+			ret = port_ops->parse(skb, port->dev, haddr);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static const struct header_ops team_header_ops = {
+	.create		= team_header_create,
+	.parse		= team_header_parse,
+};
+
 static void team_setup_by_port(struct net_device *dev,
 			       struct net_device *port_dev)
 {
@@ -2136,7 +2198,8 @@ static void team_setup_by_port(struct net_device *dev,
 	if (port_dev->type == ARPHRD_ETHER)
 		dev->header_ops	= team->header_ops_cache;
 	else
-		dev->header_ops	= port_dev->header_ops;
+		dev->header_ops	= port_dev->header_ops ?
+				  &team_header_ops : NULL;
 	dev->type = port_dev->type;
 	dev->hard_header_len = port_dev->hard_header_len;
 	dev->needed_headroom = port_dev->needed_headroom;
-- 
2.30.2

