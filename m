Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0F3385D78
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229191; cv=none; b=GAVkil/TI0k5piLhPs8qMgbzHT6g6bRZ3nxdMS6sIBys3xamq1s3Adg2Rs19BTkhdKhx5+wRtpaNfJas1EuHJg1eUuk4z7ACh0pDTwP7K/h3aj1lzBMQo2pjEBOhwYGVq1VGiwfv4qjur2mdOwxYPoDWQ5i6lIDlelwKMaHkGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229191; c=relaxed/simple;
	bh=bw/Hn+UMQEx0Cx722UrgrW6/M+aioEYjE+kaPglieno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBWmM8rudDCH/H5nbjbPfC7D5u7TVPJGjpAI2xakiBJW5Uef5IWkW09ZV4SEmcJFA2S3ofbKjqNpS1X8Zs1bI3pzPfzAENMmBKGkTX8o/Ic53ftvsclw9q4wN/uHpUFgCgpFrwXg4syLryDOCnvatkFc3zhPSU+/RazWAGocBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RPBZ5sEO; arc=none smtp.client-ip=91.218.175.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RPBZ5sEO"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bw/Hn+UMQEx0Cx722UrgrW6/M+aioEYjE+kaPglieno=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790229188; v=1; x=1790833988;
 b=RPBZ5sEOiSSEx/SgSb7cxV8pYtY9cwNFWNm0S3CZyoxw4Zln3REvsXS4iaA4jUzTusRoBxVc
 zxVy9Xy1/vwDMU3k/jHYTIaK/QrRzvMdyirZ8Y1c6kOkUVG8pMDzNHV8vdFBgs3OZ+xgfF7IV26
 UVcNJsBjBSo2lHFnw7xbDii0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4cd6387a20f1d873;
	Thu, 24 Sep 2026 05:53:08 +0000
X-Mizu-Trace-ID: 4cd6387a20f1d873
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	horms@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@linux.intel.com,
	linux-kernel@vger.kernel.org,
	xuanqiang.luo@kylinos.cn,
	stable@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v2] pfcp: fix socket lifetime on netdevice registration failure
Date: Thu, 24 Sep 2026 13:52:52 +0800
Message-ID: <20260924055252.33488-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

pfcp_newlink() creates the UDP socket before register_netdevice().
If registration fails after pfcp_dev_init() succeeds, the core calls
pfcp_dev_uninit(), which releases the socket and clears pfcp->sk.
The newlink error path then releases it again, causing a NULL pointer
dereference. This was observed with failslab fault injection:

  FAULT_INJECTION: forcing a failure.
  kobject: kobject_add_internal failed for pfcp0 (error: -12 parent: net)
  BUG: KASAN: null-ptr-deref in udp_tunnel_sock_release+0x1c/0x50
  Read of size 8 at addr 0000000000000120 by task ip/1037
  Call trace:
   show_stack+0x18/0x24 (C)
   dump_stack_lvl+0x78/0x90
   print_report+0x468/0x5cc
   kasan_report+0xa4/0xf0
   __asan_load8+0x7c/0xd0
   udp_tunnel_sock_release+0x1c/0x50
   pfcp_newlink+0x128/0x184
   rtnl_newlink+0x848/0xe44
   rtnetlink_rcv_msg+0x468/0x514
   netlink_rcv_skb+0xc0/0x1f0
   rtnetlink_rcv+0x18/0x24
   netlink_unicast+0x4b8/0x558
   netlink_sendmsg+0x2b8/0x584
   ...

Return from pfcp_del_sock() if pfcp->sk is NULL.

Fixes: 76c8764ef36a5 ("pfcp: add PFCP module")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
Changes:
v2:
  - Use a NULL check in pfcp_del_sock() as the minimal fix for net and
    stable. (Simon Horman.)

v1: https://lore.kernel.org/all/20260918123158.5631-1-xuanqiang.luo@linux.dev/

 drivers/net/pfcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index e1cca779d2ecc..3ecd43cafdf03 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -105,6 +105,9 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 static void pfcp_del_sock(struct pfcp_dev *pfcp)
 {
+	if (!pfcp->sk)
+		return;
+
 	udp_tunnel_sock_release(pfcp->sk);
 	pfcp->sk = NULL;
 }

base-commit: 90c2e97ff8245092039ab7ab7492b34427412c9b
-- 
2.43.0

