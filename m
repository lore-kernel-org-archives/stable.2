Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FE51E0E14
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786275554; cv=none; b=betP6cQ6gYNZYhxk6eKW3BVA7fbXcPdS/brO92Q+d4qhr3U158g8ICbUplxemr8aqbceAOaWdcYX0MIkptO7bGYWhSr33M2o1OPYW/RU+ZpWaOdxrxVX/9qXolv6iR7rXAVnsNS67qFt8BIj/z1fLyB0PQK908Xb2EmHotYbufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786275554; c=relaxed/simple;
	bh=jtm6uRE6GFaKFBHgeeNQthW+2GwvrpWO0wG3hE1Yz6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J+dMsU97xTTI8zwagcGczUvNRfBcYR0FwA2r+tyjyTNBALnTNlyJl0nzdB0pWmNBtgYWa1RTQLdtAXx+3+lkiZEqe0nwOoxWMgI/SaH77TZGCc6IEqMS/wtsb1FgtpTm5ieE/MnmGJm/radUHv2pTpVbH28iEWL9O7FpwSa2fxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOyFfNEV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOyFfNEV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so11237545ad.1
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786275552; x=1786880352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mQcTqHAmm1C+bfv7HrU27CCamDvlQ/9miXQRbWE9I1M=;
        b=LOyFfNEVmN8eNMos8asQ2D1nMKiSolONm9VXgwKnAOfPkAz28Hz5nTDRRh2y2BMxDB
         7VegvJCISYhgY403GB8QfOaD+kVY2kgAzGd43C93yBArPSl5clxnPGNMBSzk1AccOqV6
         bzthmxApb7J0kyKXwFIc2/tGLzBC7lmf+4srDSKHbNlDw1tibsLksNocb3s7Wkk8264d
         wzhtt1xzzBdZZL3MXlNfOgHF+T9XXUuF7k8F1bAJDh+8m832CYllM11l0rN3bDwAfct8
         rP9bMBJVHLQlvfehUlRsy0qXWy6EdZgtvuuOvPKAGT7QZ0H7ScJu5zmOhYXNJvFsKek0
         IR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786275552; x=1786880352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mQcTqHAmm1C+bfv7HrU27CCamDvlQ/9miXQRbWE9I1M=;
        b=BSd8rMkLWxkybPTi9iBQs8G4OwjB9nzI37d8RAOyIO/4u5yk7VQKGC0lHrAwQROr2g
         Co3SMaLGlzyBkBvqgXaOvHdlwTNYN1Fy1H54nY0+bpboPhkw/V6dUctm3L63Nqq3VW4R
         zDweOmiu3OKDF6h3g1L+SkCZYvj+ljWetqzye1Pyl8sClcuTnVKYtzD4VLfLirWJLhE6
         Sgik+btIdNZLbbRa++KSjTaRfKkjAUQKhdFSIJo4jcaQA6NrN+HkqFhNJ5DrhnWfwplu
         MgHz34iUPlCLtkUuoGQ+rZj5ZYQ+7lnphrgY6cPFR8sFUsqf7qBuY9IZeguaBItVYGrf
         t4Qg==
X-Forwarded-Encrypted: i=1; AHgh+RpgU5nQiJpcS0MJfmZbGKbigY158Pp9jvQyvhwSDlO6YcLQoZ3MOyckLM/buTyrdermLIYmMdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQRHX4u/bYLFEsMt86dabWrdeTX9nakA+T+diXi57Dfi+PPjcX
	bEyXAJbH0jvxaoTf8EFa0nere1RqrVd2NZ4PS8KWZLAGfdHf5RJkrgog3CwBcA==
X-Gm-Gg: AR+sD13l5URvJmbSSbDnGPDP6ZeuLA0MaR9vVuKllsaVctGCgxNF/VNbwwBCTSl71fD
	bccGVMU4WqJhOBbmW+7HJR75ioXebmVuZfAsyotr13Y2//ffum6NhASHbpzwcBc6V5DSDA+JHbe
	WHMk51m+bFL/UsflVcnMemOXiW20H5rnb4ZIcwpZJolc5igbfYJzNLwZ7Zx5JF3+KfDga8j1jqn
	slUIY8t8+0VpUIlySi28FvlQTEA6730tvD9VTTkrqG+Bvcu/qXdUHJOZa5+jYfUxqBmwy+Mldpr
	L065tFUlj4FhZBIXpfb4JWGYpbt3zqIzBW2vWrUq38ICO+nCivkQVxCU3gl8E0KEqKK1ccBO61v
	SUyKr0rpg7ZdGPthbvZPBHSN/KVUclQEZm0Fr1ST4HdwKGPSKe1IgxiN/9PvH0x+8IysQ2B1I+A
	nN3N4ilZ1QjD+/DPnGgW1JdlBekOxk4tj7aJkc0qWvlCi2E6W4uCXPl4eW9+hqbCCsyhciX41DX
	3Qq7urWsGWFsYEJXN/k7qGZ
X-Received: by 2002:a05:6a20:4309:b0:3c4:48da:8102 with SMTP id adf61e73a8af0-3cbce930129mr13010733637.29.1786275552116;
        Sun, 09 Aug 2026 04:39:12 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7ad29sm24599408c88.13.2026.08.09.04.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 04:39:11 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: mac80211_hwsim: send config events to the radio's net namespace
Date: Sun,  9 Aug 2026 19:39:08 +0800
Message-Id: <20260809113908.2218030-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hwsim_mcast_config_msg() sends config notifications. Its info == NULL
path uses genlmsg_multicast(), which delivers to init_net only. That
path runs on an asynchronous radio destroy, from remove_user_radios() on
a closed socket or hwsim_exit_net() on teardown.

hwsim is per-namespace, and a radio records its namespace in wiphy_net()
of its wiphy. A radio in a non-initial namespace therefore has its
DEL_RADIO sent to init_net, with its id and name. An unprivileged
listener there receives it, since the config group has no flags and
needs no capability to join. The radio's own namespace is never told.

Send to the radio's namespace with genlmsg_multicast_netns(), using
wiphy_net() of its wiphy, the net the GET and DUMP filters already use.

I found this with a static check for multicast that ignores the object's
namespace. I reproduced it in a qemu VM as an unprivileged user, with no
hardware and no kernel changes. A process creates a radio in its own
namespace and exits. An init_net listener receives the DEL_RADIO before
the patch, and nothing after it.

hwsim is a test driver, so the leaked metadata is low value. The fix
still matters, since the radio's own namespace should hear about it.

Fixes: 100cb9ff40e0 ("mac80211_hwsim: Allow managing radios from non-initial namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 75caa97becc8d..4a68cae25b7db 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -4372,15 +4372,15 @@ struct hwsim_new_radio_params {
 	bool background_radar;
 };
 
-static void hwsim_mcast_config_msg(struct sk_buff *mcast_skb,
+static void hwsim_mcast_config_msg(struct sk_buff *mcast_skb, struct net *net,
 				   struct genl_info *info)
 {
 	if (info)
 		genl_notify(&hwsim_genl_family, mcast_skb, info,
 			    HWSIM_MCGRP_CONFIG, GFP_KERNEL);
 	else
-		genlmsg_multicast(&hwsim_genl_family, mcast_skb, 0,
-				  HWSIM_MCGRP_CONFIG, GFP_KERNEL);
+		genlmsg_multicast_netns(&hwsim_genl_family, net, mcast_skb, 0,
+					HWSIM_MCGRP_CONFIG, GFP_KERNEL);
 }
 
 static int append_radio_msg(struct sk_buff *skb, int id,
@@ -4464,7 +4464,8 @@ static int append_radio_msg(struct sk_buff *skb, int id,
 	return 0;
 }
 
-static void hwsim_mcast_new_radio(int id, struct genl_info *info,
+static void hwsim_mcast_new_radio(int id, struct net *net,
+				  struct genl_info *info,
 				  struct hwsim_new_radio_params *param)
 {
 	struct sk_buff *mcast_skb;
@@ -4484,7 +4485,7 @@ static void hwsim_mcast_new_radio(int id, struct genl_info *info,
 
 	genlmsg_end(mcast_skb, data);
 
-	hwsim_mcast_config_msg(mcast_skb, info);
+	hwsim_mcast_config_msg(mcast_skb, net, info);
 	return;
 
 out_err:
@@ -6165,7 +6166,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	hwsim_radios_generation++;
 	spin_unlock_bh(&hwsim_radio_lock);
 
-	hwsim_mcast_new_radio(idx, info, param);
+	hwsim_mcast_new_radio(idx, wiphy_net(data->hw->wiphy), info, param);
 
 	return idx;
 
@@ -6183,7 +6184,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 }
 
 static void hwsim_mcast_del_radio(int id, const char *hwname,
-				  struct genl_info *info)
+				  struct net *net, struct genl_info *info)
 {
 	struct sk_buff *skb;
 	void *data;
@@ -6209,7 +6210,7 @@ static void hwsim_mcast_del_radio(int id, const char *hwname,
 
 	genlmsg_end(skb, data);
 
-	hwsim_mcast_config_msg(skb, info);
+	hwsim_mcast_config_msg(skb, net, info);
 
 	return;
 
@@ -6221,7 +6222,7 @@ static void mac80211_hwsim_del_radio(struct mac80211_hwsim_data *data,
 				     const char *hwname,
 				     struct genl_info *info)
 {
-	hwsim_mcast_del_radio(data->idx, hwname, info);
+	hwsim_mcast_del_radio(data->idx, hwname, wiphy_net(data->hw->wiphy), info);
 	debugfs_remove_recursive(data->debugfs);
 	ieee80211_unregister_hw(data->hw);
 	device_release_driver(data->dev);
