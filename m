Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635941;
	b=VYRBVaOOEGFb1QKG6QQesGwmbfaFEtPT9dpCYZDTRT6ohKak44UQ23IQ/mx9VzBvRJG4
	 Ou5HCZxgklycH3XFf8riRcBT2sRY7wuYcwx9zVpWfaJOYox3iJ72bSYOiD2L3YU5nYNu/
	 xA6VnEInzgCK/GUL0WsDlZBKU/0/jFCiTjw8Dfai3/kjwv0fRTrP5ryd53tyIPIfM0Sm9
	 +A5ZFPzctedisC9WsPzMWryFLTmIwngd9XsLbzQguir0WWd0UCRC/McdIgSuCEUrbptJW
	 eQ9I3sbd/XhNLgek9ov2gOaYCvuf1Jt/kMuoqzYz1U4/I8u2wuzEAKCNx3c+5XuaGyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qYMiEl4prLrhTMVTCqOTVK1hbgx73L0LBDH5JakCX64=;
	b=McLLx/ZEKFUH4ihwYmKdnZnFNJW+lUJRjYExSlgaiXhKsHD4XwHOD0woxuqGm4Fqm9At
	 YmOQ/lO2VK+AowFxsVLXCoVOEM+ASwkwV+iPiRt5HBpf58CaqFnwdZm7UQ+SLj9rViatl
	 LIUyyIsEdvytEWBCPROXn+clcs9Gn7qNtu5F/n4hz/oQGOzrbKAeD5nr5HdIhJeoFpOf7
	 mYUUU7XHMUGuSFaH1Lmgx86iUM/8fCbHGRUmAOD65Dp1+Fnxjc9omkv5FHVjQT0b7XMmd
	 oUgvWtxh6FLgPYW5MhDYkIgIVsN5B6eMOWKCw9afazLfbUFXVC8Qd2h0vvo880H2vqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=E9jKsogg;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A7606A334
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 639A7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=E9jKsogg
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso3622271eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795635940; x=1796240740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qYMiEl4prLrhTMVTCqOTVK1hbgx73L0LBDH5JakCX64=;
        b=E9jKsoggl5+jurP4/z2bnMDrC7/mS1yM/RrRID07bx/faTnjq06T4uaTTJewmZu/kS
         pJQxsqXk3VlgXjz4mNnMWzitOIHiofsmC+YBYroATqQnCGAG6KNkbvse4UyIzzYcI745
         F1XyBSSr7mETmmH6bxlCnHfS61MoC4+BnOs8zJ7XOBYwcGtUROcWGjnWzry9DTaUa8fO
         2RTnsZWidzHOmuxOdhHDUGUVEH5V8B1BmAdtlfDknx8TvpC1ewcSKcdantGFFcANVqm3
         px+yrY66nMjLqUB6y3xKWNrCSSbozy18YQcAHBWaa0MPg3E5yVFJVk7M+4noMrrJ3kmF
         7avQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795635940; x=1796240740;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYMiEl4prLrhTMVTCqOTVK1hbgx73L0LBDH5JakCX64=;
        b=VaDWSwZGtYqf/57NfkTBuVzP/2xul7+CJwqKKNhew2NRWuJqW2VKWo7AhNw9gpKfH7
         sGo/om7dOM90Ox/AWzgIGJL1gknIXoHHvNtReHCf/8leAiKF6/sRK1xfvqRGVQiea/5g
         2w2BjOAvniQZWd2U6q21ruN6/kAWmFf6kJYCymM8ccYX3vz9eEAm0fSbPhIoAWNIq1vk
         KnGgplYuksrSuLyLN0EUjpuwMmsCzH4kWpOZ2W2plXkUYcRMIukIG6JWiq+f0644pMiK
         mpSwimdLq2O26c6XRBWWZvymr/A0n+oyhZgZ/wuMDgFAR79zhlwS9GjkEY+x1j7NhANg
         L4QA==
X-Gm-Message-State: APuU4Z8JE120Y/uRTpukaQ1IJuX6FSU2lQQCXp6/XbLKXizYBmzm1ewS
	j8NZfgK1/mjBXaj46L/ActOjJ3hC49oJAf66uoG++4RxRQYExm/r1E9eVKstvcwck1DAKEeBclz
	duskyU5Q=
X-Gm-Gg: AZFdTZfuiyI75A0Kdu88Y1yuIFdkJNPdxgLIzGe361MMZ3cPjrlPf5UXlh5tQcrMrCq
	VMB9nBKxQCfgAXBDSIykjFgUBslb5iSAy4I6tOJXZ2duK7KxURHznMi5kLKMH36vWCrY8aAsUc4
	5O9bFU5UAekNZwwukNktWuaV85nkJJhiDGlXIMmH7mSadACN8nqAW8FMrFstaNXIt3nwMLpT25Z
	F73QvUkLXmhC+q3iX1NPaVGwJDf4vlM90VzYy6zrdftm9S3es4KD+fLG079U7efhM6msD5XWt2k
	9MrM4rZQPukU2gM1rJbICIJAachXgdlUbfx2IjXPJDu+gYYUjjoOfR9Jc7YGGJlRrVN6/UG9wJr
	Pk0BdwNStRR2lXqVyMnNsKFVTTWGT7vcQMxNfJV6tCg+eI3RpCo1HNonjegBvgyaGtPx5ncecMn
	Zzf3L2fEaPC/SqJrA7xdVYqe4gtRC632p/xEsyY4UzkxDXb/dlTnbKjXj1VQun/+w0Idmwd/zwZ
	uMxmdutbBy0wfd3TPjtC6rIbzlyVOAjhwMaR+JNFMv75CqVQXXh6JkT3gJx9HKZj0RnsL2v8lIX
	n+vwJOTEH238hHtgP09Ptub5yq5mpGJZbRcRaGsBsR3j81CObW6zxDAMlFUIh4pC58ZBoiMcUzR
	PoyzkCZjmFNLzuZRtaIqe3N1E0A==
X-Received: by 2002:a05:693c:8209:b0:36a:4a68:84e5 with SMTP id 5a478bee46e88-3856f14bcfbmr20687156eec.8.1795635940432;
        Wed, 25 Nov 2026 11:45:40 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386d605c894sm3737730eec.2.2026.11.25.11.45.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 11:45:39 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: bird@lzu.edu.cn,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	n05ec@lzu.edu.cn,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tomapufckgml@gmail.com,
	yifanwucs@gmail.com,
	ylong030@ucr.edu,
	yuantan098@gmail.com
Subject: [PATCH 6.18.y 2/2] 8021q: delete cleared egress QoS mappings
Date: Wed, 25 Nov 2026 14:45:34 -0500
Message-ID: <20261125194534.52951-3-artem@trailofbits.com>
In-Reply-To: <20261125194534.52951-1-artem@trailofbits.com>
References: <2026050408-ideology-liftoff-aa01@gregkh>
 <20261125194534.52951-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Longxuan Yu <ylong030@ucr.edu>
Date: Mon, 20 Apr 2026 11:18:46 +0800

[ Upstream commit 7dddc74af369478ba7f9bc136d0fc1dc4570cb66 ]

vlan_dev_set_egress_priority() currently keeps cleared egress
priority mappings in the hash as tombstones. Repeated set/clear cycles
with distinct skb priorities therefore accumulate mapping nodes until
device teardown and leak memory.

Delete mappings when vlan_prio is cleared instead of keeping tombstones.
Now that the egress mapping lists are RCU protected, the node can be
unlinked safely and freed after a grace period.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Longxuan Yu <ylong030@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Link: https://patch.msgid.link/ecfa6f6ce2467a42647ff4c5221238ae85b79a59.1776647968.git.yuantan098@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

[ Backport to 6.18.y: context adjusted in vlan_dev_set_egress_priority();
  6.18.y predates the kmalloc_obj() conversion. No functional change
  from upstream. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
 net/8021q/vlan_dev.c     | 20 ++++++++++++++------
 net/8021q/vlan_netlink.c |  4 ----
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index f86f6b770609..5b4ac6c127f0 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -208,26 +208,34 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
 				 u32 skb_prio, u16 vlan_prio)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
+	struct vlan_priority_tci_mapping __rcu **mpp;
 	struct vlan_priority_tci_mapping *mp;
 	struct vlan_priority_tci_mapping *np;
 	u32 bucket = skb_prio & 0xF;
 	u32 vlan_qos = (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
 
 	/* See if a priority mapping exists.. */
-	mp = rtnl_dereference(vlan->egress_priority_map[bucket]);
+	mpp = &vlan->egress_priority_map[bucket];
+	mp = rtnl_dereference(*mpp);
 	while (mp) {
 		if (mp->priority == skb_prio) {
-			if (mp->vlan_qos && !vlan_qos)
+			if (!vlan_qos) {
+				rcu_assign_pointer(*mpp, rtnl_dereference(mp->next));
 				vlan->nr_egress_mappings--;
-			else if (!mp->vlan_qos && vlan_qos)
-				vlan->nr_egress_mappings++;
-			WRITE_ONCE(mp->vlan_qos, vlan_qos);
+				kfree_rcu(mp, rcu);
+			} else {
+				WRITE_ONCE(mp->vlan_qos, vlan_qos);
+			}
 			return 0;
 		}
-		mp = rtnl_dereference(mp->next);
+		mpp = &mp->next;
+		mp = rtnl_dereference(*mpp);
 	}
 
 	/* Create a new mapping then. */
+	if (!vlan_qos)
+		return 0;
+
 	np = kmalloc(sizeof(struct vlan_priority_tci_mapping), GFP_KERNEL);
 	if (!np)
 		return -ENOBUFS;
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index a5b16833e2ce..368d53ca7d87 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -263,10 +263,6 @@ static int vlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 			for (pm = rcu_dereference_rtnl(vlan->egress_priority_map[i]); pm;
 			     pm = rcu_dereference_rtnl(pm->next)) {
 				u16 vlan_qos = READ_ONCE(pm->vlan_qos);
-
-				if (!vlan_qos)
-					continue;
-
 				m.from = pm->priority;
 				m.to   = (vlan_qos >> 13) & 0x7;
 				if (nla_put(skb, IFLA_VLAN_QOS_MAPPING,
