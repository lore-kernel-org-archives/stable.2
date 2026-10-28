Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197052;
	b=nIikc/Tc/uDEpwRHCnnzxJqjAWASWvzyHzFKL6nMhmXJQgAvbU47eD4cVrnphGC47AOM
	 rbq2icJCli2nJ2rg9BiOhIb9QpWydpZWuX2AylGrcXXvuLYjRO5RauYtZkcoZ9vVQAlFN
	 +WTc9Y5dLn24Ntj3aNRthBX1hvg+w3au5XNh3nm6328V1yYt0eg8h0i37aDQOk+lHGBeR
	 13M6SbwLQMLLc/ef5MjZ3evj7Eyoi3CFqozglOb/wURrIdlYu2xjp4I3yHH5bl6C9cVkN
	 QNMNttU8GiPSL2skwljRbHi9bgGtVbzgD+ITaCj7jfcZ0UmWwa76G58FZZ7SWpigciQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=400J3GHcIQLYwc1sIdmefx5I/Bqi2GbTm1mkxszhp6A=;
	b=xzxGDM2pN6A3wIiQQ8RKKhWccS8eUbgMdkd1hAKb1Pf7Q7za/2t4Mz4DRmvSJPHcfA2m
	 oykQ8G7CapRN0u5czed/Li2t7/Fgu/I31P85226ju/cmycMfj/En21Bm7AajVHuv++ADF
	 //qOxzWaDx5qsADR3px0I+vZCvwAmml3R8rFhR1uDAgpv0QT4zlp9Wfin24M/F2fVzeUw
	 UsD5pyAZnRmD6Blow4t9OK9gvaMXm6oE7j+Wc/eaT3M2Fu4XU87Dc+H/zH/RIyCH8O+GN
	 1yIrcZuneQO4kJ9meLrJ7s5CeFCv4E+rEvxL6yMgtUVpZaSC/etOfMZwSTBtwfTWJCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXYDhQyP;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211C6606A322
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 211C6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXYDhQyP
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e5fb79ce82so6780345ad.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197050; x=1793801850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=400J3GHcIQLYwc1sIdmefx5I/Bqi2GbTm1mkxszhp6A=;
        b=DXYDhQyPBdB+66SGq5pe4HNqA7llbQQiVEhcYQMMEPtK6oNXB6ldbDG10MbPNB7CNO
         aVArXI/j0nIa9vUh9PwsdlfIrqAkdy/c6HfY0v7X5QrV+HLrjycExkRtiaEfxEGrVUKY
         NtBkwW5x2i0mCLvIHwZWzqaRklYkVabxm4ix1PZ6eaY99yJVEOdFoyCFmVPqzumzSz7F
         MvWLFuJ0Ndl+UfThsEwJLtrxMxRjMF6MPJ8WCdNVsA38Fu+0Yh1DxPfZNeYJMgMFpC+3
         pybBmYTrNyTcAGj1zaZqUS/nmWKXmPKTG3tNAQecnDch2OdIxy63hjn3eHArAlqwTwAv
         3bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197050; x=1793801850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=400J3GHcIQLYwc1sIdmefx5I/Bqi2GbTm1mkxszhp6A=;
        b=vdp4TpWjVGAwCDmNmtvWPO91Sm3Dq+NI08zh+hCE+yJH6D2mVj+eX2k668qfHWfkhz
         wbO/cnB+PFbDfJzUylak0fUm9OeNbwrJewaPh5krKkP5iXVxYYL8Mz9xNl3uA4iEXgeQ
         gjiaWCNumAPaRBKFt7K5ovd9jeYhWrF5F8Rdzb2Yf42OK5I7Zhf3IhDuTT9Zq5lGJUzM
         tY//++9byscJsqDxW0DJcL3ABN364C0BB/Q/P86zES9SZNeTtZHCZTKdEKz+PBhJs1Al
         4kQKpH/x5hk4MXLzogSJM1ebMYiz+8NsEq7fXiMw1Pr8kR/21szfMrjz+UEfVm9mbdDZ
         /O5A==
X-Forwarded-Encrypted: i=1; AKwUvBwwTu01Wy+7HrDta/PJ7NJiNIzZvnJnMW5WFIxCpn5k0HEj3N5tQBbX4FilGCDy4oSEAsgvGIs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLg/9qxfk8lUXyoRhPCskJfA6FhGy4b/3Lxy+yOGu9H+v0wkTUd
	fnw4UpvSMpuLQi8Yg2rydnRwOTR/TmcffefeigUDBxbrDr3HPgoAmglw
X-Gm-Gg: AYBFou1t3RbVrxD1ieKLQPNbXdYuiVFdNgmdtFThToJc7ts8EqL0mEHCYxZ7Eo0Q87x
	BNM/Ht8kAoXd6zuRsknFEz3y2OGBhgvUbQKD2FSnlumUupW1iz3AMWa8bw6hW29ieXdEU4kDJ8A
	njkHOftgOpcjf7dh0tR9kbwx3gCt6JjFPu2A8yVWdrYeEBfQh2yZVBYZpx5/dZcQGRzUuZdCRvS
	08MpE1NKIhMoB1oPK9806aJ7LPx3Glu4hLsj0kio5purywoG82+HJPCQAmwkG4WUjUGbGAnFjnH
	E3SNAk8QOTYNY8ux7WkS6xCOvQmBiC+eCQSbnUu9ZiXStybb/crMAxuqfSybyQCUIySHhrkuWse
	KaLn7ysyvSX+P0erMJHQWJhiOed5JRo+/3H8ydOvpyPYTiQdksgKuTUQU3V8sS1gHgymqnWeiAK
	dum9TTc3MWRpwLijrQGpKJXuZ4hikTM+c6bLB7Z5qn3nkSMvvdFJXBoPaZTQgIz9gqCRLGswt4u
	DN7T+5bOO7uhQxonUqxyFEyDx32YBil7cD0bmL1OVIQkLMfeHv+ilKahHU/0JVOOhB+wTXlMoCL
	z4P2p9M5PMIJWAT0Hj/kT9/A1rcuxKTKDLt+WNcIZs8CmsMEIjz4f6NMSAdaBgUUc5pH
X-Received: by 2002:a17:903:2447:b0:2ea:71a7:7f21 with SMTP id d9443c01a7336-2eb002e2967mr23279075ad.13.1793197050082;
        Wed, 28 Oct 2026 07:17:30 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b76dafsm22396935ad.18.2026.10.28.07.17.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:17:29 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: drain link readers before stopping removed links
Date: Wed, 28 Oct 2026 22:17:08 +0800
Message-ID: <20261028141708.5532-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removing an MLO link can leave work queued on its link container after
the container is freed.

ieee80211_tear_down_links() stops each link before the RCU grace period.
A reader that fetched the link earlier can therefore queue work after
ieee80211_link_stop() has canceled it. ieee80211_request_smps() and
ieee80211_csa_finish() can both reach this window.

Record each removed link while removing its keys and debugfs state. Wait
for RCU readers, then stop the recorded links so cancellation includes
work queued by those readers. Free the detached keys after the grace
period as before.

LLM assistance was used to find the bug and review.

Fixes: efe9c2bfd1a8 ("wifi: mac80211: isolate driver from inactive links")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. In a QEMU KASAN
guest on the declared base, a built-in test reader held link 1 under RCU
while ieee80211_vif_set_links() removed it. Each of three boots reported
22 unique use-after-free reports before the change and none after it,
with no lockdep report. A reproducer is available on request.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

If "wifi: mac80211: free keys asynchronously" lands first, the key-list
context will need refreshing; the RCU wait remains necessary for link
readers:
https://lore.kernel.org/r/20261026125145.68153c510dfe.Ieaf95b8e1336f07866f54d174f699c6aa079d9b8@changeid

 net/mac80211/link.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 931950a10508..41c7dfc49a24 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -191,6 +191,7 @@ struct link_container {
 static void ieee80211_tear_down_links(struct ieee80211_sub_if_data *sdata,
 				      struct link_container **links, u16 mask)
 {
+	struct ieee80211_link_data *stop[IEEE80211_MLD_MAX_NUM_LINKS] = {};
 	struct ieee80211_link_data *link;
 	LIST_HEAD(keys);
 	unsigned int link_id;
@@ -205,11 +206,16 @@ static void ieee80211_tear_down_links(struct ieee80211_sub_if_data *sdata,
 			continue;
 		ieee80211_remove_link_keys(link, &keys);
 		ieee80211_link_debugfs_remove(link);
-		ieee80211_link_stop(link);
+		stop[link_id] = link;
 	}
 
+	/* drain RCU readers before cancelling work they may queue */
 	synchronize_rcu();
 
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
+		if (stop[link_id])
+			ieee80211_link_stop(stop[link_id]);
+
 	ieee80211_free_key_list(sdata->local, &keys);
 }
 

base-commit: 25e73f1d6868c759c8eb56cad4e411692c5341b4
-- 
2.56.0

