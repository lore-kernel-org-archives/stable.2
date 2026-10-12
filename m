Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D94F797D
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840899; cv=none; b=FYY2SAL14OLuL0e3X8XhVCHWmBD9qgmAuYZOPB7xEu+TmG+LKQDBWI0+mHnc9QzwWatedoMaOzlFCvLT6qYNEe1aeDhYPFasxAjxs5i0XJsizv+eTghQhNx2Ql3F9F+mG0/+XQi5D4bzdLQJk+zk3CVMsY4H/ZjOs75VN6GAe/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840899; c=relaxed/simple;
	bh=FptRiqaGi3InBQk1PmFB1hmKZSWoZEvsEU+wSvjNPOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aw/bFqzo9pfcL3warSLsghq+J7tx/tojIHto5mPVVRS+GKqLRMSnvUkdbd/L/s3grsVQgOflMzE7TEManV9ps2j9sGyEkXo2Hm68PzM2lKWcb1jik0kBznIytgsrjSuRrmqsxhss+kuDLvVZNP99oTCR1k8nte65DzFlMdfQjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSoCiBqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSoCiBqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BEA1F008A2;
	Mon, 12 Oct 2026 21:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791840892;
	bh=3JCEhOIdBEddpXJQAXTd5PdhqcyMWEPNA+q5Oe8IYhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JSoCiBqTnMOGtZFLVO7c85TG+Rb2fhhOawwxX8wCNlcE5Pp8TnbZ3lvjn9GxbaO2h
	 14V5zzOtO19D/xXGafMarFMI6JSkV2CVfdJ0JWQ4cxdgd85DMJf0Syj4KHcangzZi3
	 4FL1+2Ex2cqaM2dLQa952vU3EM9MJ9UNGHW5qmH4vaWNM5BpUVIr2j6nfZ3dW4SpQr
	 dP3JsQ1G0TUMF0u/jWqeHbR6w2Q3N2p2Kc+ZXtR0VX4POt3V/gGm+RQkItxuvVI4+B
	 JT4mjDTvgWXgthn1bpI3lAq/XscVK/5O2j3pGNMRk+40ZP9f2rf1FkPDUASj5cSY3o
	 GmGUIsRpFBO8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michele Dionisio <michele.dionisio@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: brcmfmac: fix P2P device removal race in brcmf_detach()
Date: Mon, 12 Oct 2026 17:34:51 -0400
Message-ID: <20261012213354.1591669-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101201-engraved-bullwhip-60cc@gregkh>
References: <2026101201-engraved-bullwhip-60cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michele Dionisio <michele.dionisio@gmail.com>

[ Upstream commit 08a3f02fea636e97a7422d1512f76dacdb5b0887 ]

When the driver is removed while the user space process that created
the P2P device (e.g. wpa_supplicant) is still exiting, the P2P device
interface is removed twice and the kernel crashes.

The two paths are:

 - wpa_supplicant, on exit, sends NL80211_CMD_DEL_INTERFACE for the P2P
   device. nl80211_del_interface() holds RTNL and the wiphy mutex and
   calls brcmf_p2p_del_vif(), which disables discovery and waits up to
   1.5 s for BRCMF_E_IF_DEL. Then it calls brcmf_remove_interface(),
   which unregisters the wdev and frees the vif and the ifp.

 - brcmf_detach() sets the bus down, so BRCMF_E_IF_DEL never arrives,
   and calls brcmf_remove_interface(ifp, false) for the same ifp.
   brcmf_p2p_ifp_removed() reads ifp->vif and then blocks on
   rtnl_lock(). When brcmf_p2p_del_vif() releases RTNL, it calls
   cfg80211_unregister_wdev() on the wdev that was already unregistered
   and freed.

The second list_del_rcu() of wdev->list faults on LIST_POISON2:

  brcmfmac: brcmf_p2p_del_vif delete P2P vif
  brcmfmac: brcmf_p2p_deinit_discovery enter
  brcmfmac: brcmf_p2p_del_vif P2P: GO_NEG_PHASE status cleared
  brcmfmac: brcmf_detach Enter
  brcmfmac: brcmf_bus_change_state 1 -> 0
  brcmfmac: brcmf_remove_interface Enter, bsscfgidx=1, ifidx=0
  brcmfmac: brcmf_del_if Enter, bsscfgidx=1, ifidx=0
  brcmfmac: brcmf_p2p_ifp_removed P2P: device interface removed
  [1.5 s later, brcmf_p2p_del_vif() timed out]
  brcmfmac: brcmf_remove_interface Enter, bsscfgidx=1, ifidx=0
  brcmfmac: brcmf_del_if Enter, bsscfgidx=1, ifidx=0
  brcmfmac: brcmf_p2p_ifp_removed P2P: device interface removed
  Unable to handle kernel paging request at virtual address dead000000000122
  Internal error: Oops: 96000044 [#1] PREEMPT_RT SMP
  pc : _cfg80211_unregister_wdev+0x6c/0x264 [cfg80211]
  Call trace:
   _cfg80211_unregister_wdev+0x6c/0x264 [cfg80211]
   cfg80211_unregister_wdev+0x10/0x1c [cfg80211]
   brcmf_p2p_ifp_removed+0x84/0xb0 [brcmfmac]
   brcmf_remove_interface+0x1f4/0x254 [brcmfmac]
   brcmf_detach+0x88/0x180 [brcmfmac]
   brcmf_sdio_remove+0x90/0x7b0 [brcmfmac]
   brcmf_sdiod_remove+0x20/0xa0 [brcmfmac]
   brcmf_ops_sdio_remove+0xbc/0x12c [brcmfmac]
   sdio_bus_remove+0x38/0x144
   device_release_driver_internal+0x1e8/0x2c0
   device_release_driver+0x14/0x20
   brcmf_sdio_bus_remove+0x2c/0x40 [brcmfmac]
   brcmf_fwvid_unregister_vendor+0xd8/0x170 [brcmfmac]
   __exit_compat+0x18/0x418 [brcmfmac_cyw]
   __arm64_sys_delete_module+0x1ac/0x244

The log was taken with debug=0x406 on an i.MX 8M Plus board with a
CYW55513 (Sona IF513) on SDIO. The driver is the Ezurio backport of
brcmfmac from v6.18.22 on a 5.4-rt kernel. The code involved is the same
in mainline.

To reproduce:

  1. Start wpa_supplicant on wlan0 and let it associate. It creates the
     P2P device (iw dev shows "type P2P-device").
  2. Stop wpa_supplicant and remove the driver without waiting for
     wpa_supplicant to exit:

       kill $(pidof wpa_supplicant)
       rmmod brcmfmac_cyw brcmfmac

The crash is reproducible on that board.

For the interface without a netdev (the P2P device), take RTNL and the
wiphy mutex in brcmf_detach() before reading iflist, and remove it with
locked=true. If brcmf_p2p_del_vif() runs first, brcmf_detach() finds the
slot empty. If brcmf_detach() runs first, nl80211 does not find the wdev
any more. The interfaces with a netdev are removed as before, because
brcmf_del_if() takes RTNL on its own for the primary interface.

Fixes: 9831bcb987df ("brcmfmac: Deleting of p2p device is leaking memory.")
Cc: stable@vger.kernel.org
Assisted-by: claude-opus-5-5
Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260924123027.4122909-2-michele.dionisio@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ sashal: Removed unavailable wiphy_lock() and wiphy_unlock() calls to rely solely on RTNL locking. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../broadcom/brcm80211/brcmfmac/core.c        | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index b763495317f6c..309799d9ca433 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1476,8 +1476,29 @@ void brcmf_detach(struct device *dev)
 	brcmf_bus_change_state(bus_if, BRCMF_BUS_DOWN);
 	/* make sure primary interface removed last */
 	for (i = BRCMF_MAX_IFS - 1; i > -1; i--) {
-		if (drvr->iflist[i])
-			brcmf_remove_interface(drvr->iflist[i], false);
+		struct brcmf_if *ifp = drvr->iflist[i];
+
+		if (!ifp)
+			continue;
+
+		if (ifp->ndev) {
+			brcmf_remove_interface(ifp, false);
+			continue;
+		}
+
+		/* The P2P device interface has no netdev. Its removal can
+		 * race with NL80211_CMD_DEL_INTERFACE issued by a user space
+		 * process that is exiting (e.g. wpa_supplicant), which ends
+		 * in brcmf_p2p_del_vif() under RTNL. If
+		 * both paths remove the interface, the wdev is unregistered
+		 * twice and the vif is used after being freed. Take the same
+		 * lock and re-read iflist, so only one path removes it.
+		 */
+		rtnl_lock();
+		ifp = drvr->iflist[i];
+		if (ifp)
+			brcmf_remove_interface(ifp, true);
+		rtnl_unlock();
 	}
 	brcmf_bus_stop(drvr->bus_if);
 
-- 
2.53.0

