Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.130.202.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794981942;
	b=GNKWQPLU0i8bRaRlIyUiqgeo8HuEWb7XnD+n0uw9axwrGGgGZFps3GKEsWikoXRlXQAB
	 5Rlok5o9Jc7r5gqO9y4y/eLK07cUE8YWwgTBgY2aRk8vFwWYcJ3+b/AwQRBof/tLVqPsO
	 H8VE/zznDjQYSL8IM/4tu3GxaCBl8PLBGzdpk9tPe9T6Oc6ad9R6uxmy80ZKLTH7C4mUs
	 BldhLtgKoBzxCyzQRoVMfB8u13s32ekvHlt4OOKtL7uEHEsJ6/flxrik4A+4AK0eTfw52
	 5zCT5mIQy7ZuUX2a5x2T63fCFHPFUSI9CuC/YdXtpux78O6nOSI/KsLCabeVj3Onm0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794981942;
	h=DMARC-Filter:DKIM-Signature:Received:X-Iguazu-Qid:X-Iguazu-QSIG:
	 Received:From:To:Cc:Subject:Date:X-TSB-HOP2:Message-Id:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ETRLYfOnWdxJUU1SbgPiKArR5EJI6qKGiZLZtvU5VqI=;
	b=P+hfTzgn/yOXxbKKlo4YVEoG/ePjQFbBG+aiNabSDm4UQG6o4FOO8b0U7QZRLGpkIXqm
	 A+kin3XcVLN8KvMkYrsfOFMxFCptl+z5XgBXBabQ+OC9qwQLhsawGnUExmYwYpPPkuKoc
	 QrENkFLaT4IsAQxp1gdsUTwhU8jY0yEcfojk5pro/sOfxQwLg/0W1S/vO/v1VzOrkTTNf
	 qKMUdfeYydLsaHpuc2BIVG66MKEvmphnnVyH9/keBBAJXMW9qs0+zj901u3ggf0jPSZFH
	 bNk4hHwzTQFLGjIzrS/m7u4Hr8FZlFdS2vAnhnJ31omhL4GzRHvNUmZVtptzqI43Xnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.toshiba;
	spf=pass smtp.mailfrom=mail.toshiba;
	dkim=pass header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=uVrq+trF;
	arc=none smtp.remote-ip=210.130.202.135
Received: from mo-csw.securemx.jp (mo-csw1801.securemx.jp [210.130.202.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A069606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A069606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=uVrq+trF
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794981908;x=1796191508;bh=
	idAq0S6+iA989Drl4RGSf5QlcOyQHLtUesHiiW654B8=;b=uVrq+trF8Jnfgi4V7py7oG6HMOmNUo
	7xSUgHDaMJ3KxpJyfVXN0aFKRNuKv5LGW+Sq0APxQL9cER9celmb6hFiCaNbQsYa5NQiOC0Ghg3ae
	t5ZXDZ/qjgWWRU4a29k5aVpQLvnpzXkIFNKpl4sLd9U3nciYA9+0ipHWWj88IJuxCSm3ielljJ4vm
	p/2hHAapGPC4D6QIQO3UkhfSJZ2Bw+ykPngjeqTjTcnATc0DDgAxOOF3F23niOAbOYHkDaSjfSQuM
	b+7kQZvOj0YWsC++njY6t3bqDgtqAYuJYNCAuld7uDYokEG/KlCd9e2IXRb5lWOZwQl3VAtOB+dJp
	d/ug==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 6AI657xk1766218; Wed, 18 Nov 2026 15:05:07 +0900
X-Iguazu-Qid: 2yAbofA4kxsHIr6nLB
X-Iguazu-QSIG: v=2; s=1; t=1794981907; q=2yAbofA4kxsHIr6nLB; m=iMSpvHsr1jYoy2v+v16rB9VRp1AmvmJHNqGNyTd4yr0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jTrfq2rBQz1xnk; Wed, 18 Nov 2026 15:05:07 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        Kory Maincent <kory.maincent@bootlin.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 5.10.y] net: ravb: Fix missing rtnl lock in suspend/resume path
Date: Wed, 18 Nov 2026 15:04:52 +0900
X-TSB-HOP2: ON
Message-Id: <1794981892-14446-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kory Maincent <kory.maincent@bootlin.com>

commit 2c2ebb2b49573e5f8726112ad06b1dffc3c9ea03 upstream.

Fix the suspend/resume path by ensuring the rtnl lock is held where
required. Calls to ravb_open, ravb_close and wol operations must be
performed under the rtnl lock to prevent conflicts with ongoing ndo
operations.

Without this fix, the following warning is triggered:
[   39.032969] =============================
[   39.032983] WARNING: suspicious RCU usage
[   39.033019] -----------------------------
[   39.033033] drivers/net/phy/phy_device.c:2004 suspicious
rcu_dereference_protected() usage!
...
[   39.033597] stack backtrace:
[   39.033613] CPU: 0 UID: 0 PID: 174 Comm: python3 Not tainted
6.13.0-rc7-next-20250116-arm64-renesas-00002-g35245dfdc62c #7
[   39.033623] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   39.033628] Call trace:
[   39.033633]  show_stack+0x14/0x1c (C)
[   39.033652]  dump_stack_lvl+0xb4/0xc4
[   39.033664]  dump_stack+0x14/0x1c
[   39.033671]  lockdep_rcu_suspicious+0x16c/0x22c
[   39.033682]  phy_detach+0x160/0x190
[   39.033694]  phy_disconnect+0x40/0x54
[   39.033703]  ravb_close+0x6c/0x1cc
[   39.033714]  ravb_suspend+0x48/0x120
[   39.033721]  dpm_run_callback+0x4c/0x14c
[   39.033731]  device_suspend+0x11c/0x4dc
[   39.033740]  dpm_suspend+0xdc/0x214
[   39.033748]  dpm_suspend_start+0x48/0x60
[   39.033758]  suspend_devices_and_enter+0x124/0x574
[   39.033769]  pm_suspend+0x1ac/0x274
[   39.033778]  state_store+0x88/0x124
[   39.033788]  kobj_attr_store+0x14/0x24
[   39.033798]  sysfs_kf_write+0x48/0x6c
[   39.033808]  kernfs_fop_write_iter+0x118/0x1a8
[   39.033817]  vfs_write+0x27c/0x378
[   39.033825]  ksys_write+0x64/0xf4
[   39.033833]  __arm64_sys_write+0x18/0x20
[   39.033841]  invoke_syscall+0x44/0x104
[   39.033852]  el0_svc_common.constprop.0+0xb4/0xd4
[   39.033862]  do_el0_svc+0x18/0x20
[   39.033870]  el0_svc+0x3c/0xf0
[   39.033880]  el0t_64_sync_handler+0xc0/0xc4
[   39.033888]  el0t_64_sync+0x154/0x158
[   39.041274] ravb 11c30000.ethernet eth0: Link is Down

Reported-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Closes: https://lore.kernel.org/netdev/4c6419d8-c06b-495c-b987-d66c2e1ff848@tuxon.dev/
Fixes: 0184165b2f42 ("ravb: add sleep PM suspend/resume support")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[iwamatsu: Adjust context]
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/net/ethernet/renesas/ravb_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 3e131788a4a3..1e7ff7f9cd4d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2352,10 +2352,12 @@ static int __maybe_unused ravb_suspend(struct device *dev)
 
 	netif_device_detach(ndev);
 
+	rtnl_lock();
 	if (priv->wol_enabled)
 		ret = ravb_wol_setup(ndev);
 	else
 		ret = ravb_close(ndev);
+	rtnl_unlock();
 
 	return ret;
 }
@@ -2393,12 +2395,16 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	if (netif_running(ndev)) {
+		rtnl_lock();
 		if (priv->wol_enabled) {
 			ret = ravb_wol_restore(ndev);
-			if (ret)
+			if (ret) {
+				rtnl_unlock();
 				return ret;
+			}
 		}
 		ret = ravb_open(ndev);
+		rtnl_unlock();
 		if (ret < 0)
 			return ret;
 		ravb_set_rx_mode(ndev);
-- 
2.55.0


