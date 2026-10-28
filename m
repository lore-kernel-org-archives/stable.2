Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197308;
	b=4p1iCHSavf6SpME2uRydZTlFXscYEuHK1Iwq1+XO3o7EXAieUMqjjHTbFNGnp2iQSUKm
	 L/GGyl8cVcmZuXxJRB416xletbrBb4AXoJKPmdCD7bubKEGSzJgqBEm0UMUmSA2V4ToAP
	 RUMmzsvAx6aUQowcgN3UzbbgelfIraeql5m9xXKk/OjyklqrfUg4810gryVvb+5uqD1zi
	 l9yUhwJoWbMNAr0Y0fRXV/ebsjv1h3Qi66X2qS1z1oWuH8x3iLaExGG5HdM8QMyQ0e2I1
	 2We7ErttSVMlZ0UYiN5AZLP+LmmHa38R6i9Wh+23XBHevQ8XPkagk7NSFLIkOTQYKqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jvqlznIRpcb2r5A+1FTqthWVZHsxJDeKaLsBSLtvHm8=;
	b=RaTdCBmpc055MojcX/FeBiLk+bbn6akJd7A0xJ8etHl9d5TwBVLw9ALTE62Fzglliu+N
	 y2MvEHFZfghaonI0Bt8Ad1X48ACLcYZI7zgHCpegE2mL1eriowg8bojg/GtD8hKH0fTu6
	 xpmgMEYhOZl0D7XYCmWMfE7M5aBAjz/bUbcuOi/Kin6506tnoVyijKSikhWbwiISqwSoB
	 s/if4C/40rHpAhiIZ/re27uCmXzFK9s1fT+7becx+oE7JyRjcPET8Am9MT5+tTpzw4nUS
	 6p9S8m7GkEkc+z8DSEdfsoOK7itq1WvssvA/HtnH3uvSCbNKck15CzgN80wlwE+pr3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jYDFN1gn;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74747606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74747606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jYDFN1gn
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so517486b3a.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197308; x=1793802108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvqlznIRpcb2r5A+1FTqthWVZHsxJDeKaLsBSLtvHm8=;
        b=jYDFN1gnQmqyKqhr+ZvFYypHYGS5CGWfK+IGEporq5BRKI79QFfQPwxrSI6sn79FMo
         NO5OBYMvH2hBAFmofJBmQZKPOTl/QGmZH3eWlx24JpmZxKYdfVx+VNXV07z1Yo9QqgN2
         7RUn/Nm1ftPgCKZkFpIyQLYuOC8et0CqmF+P49yzbn8qCmKlS3i1oZfe2HIx6K8qR3ao
         FTiVis+YTHzyBLz1++CfEyz80BOrOXOE4dgJZwfgDbowaAsgPzgqSPx9BwsO2Mw66ijJ
         kOEpn+3lIWTs+yuKxKXkhf/7N/EhRCmLsdeDMRn87H48PHQfF133PmrY1IZoAOFIbpFg
         uEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197308; x=1793802108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvqlznIRpcb2r5A+1FTqthWVZHsxJDeKaLsBSLtvHm8=;
        b=0frd69oYeazzpwLRQRY1E5/5re0b1Rpolev7f3/jxrUbl7WXYsar/IFBXTNMsnhJ4N
         iPEZdF0bhyqtyZyqJRqWzo9kACloTqFMsTIEG7uVsZoC7IRcgfMsx7FNUMHhDdFZtqPc
         LfelOL6VK46maK/mrOsF2/inACP/mUj6pVj1RY6CMZrjRe6QqBO2298ZyBPpmrNplLog
         JZK2/DBopehHhL5hYtSvtztsBsX75AbeVCUEsCBTtn4vfM82lji3TAaGatpCk65f2p/V
         rNa/dWbFWBwAIDTsPnNH2p/yg5woGPIa00kIait7D+aZSiNqMawbe0417DpoSrvHgWOs
         yy5w==
X-Forwarded-Encrypted: i=1; AKwUvBzqOtwNTwBvNVdPIBPMFEawA0crA9kpBnt/o01gE30+7oGS0v1C6URk+P3yHmNVjXdjQFKuy/0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJna1+W/Ur2adD4QxyDglzFjpZbv4Cuilbmv1j+OZ2SJ/8Ea7vT
	xlSgfPYZwty7DkOsYrLfRU1fL/oGZht9LoOUuzHn9FdX8K1NIP9X+RFfRduOIPThM8Y=
X-Gm-Gg: AYBFou0zG18jzH1MyVtHsXrilssFuZzf+auTN5uE4ibatK6D2NMknBHG+fC9S6Kddb7
	rJS9zfZbZs4LiNKNX0AnRJp+Pq5AGeSzwXHowFHUrjfuTZ0aK/XCbTjAUsqpcRJta2P91OreRzo
	b+XuaaJoiExnY/XDRZRE3vDvJiJZRVHrcZJWQHUbLVycMqQyOHOBTiTGnNDnxQ8QH4yb8yFBzNY
	et/U5OUgsUXI/HQkdeKlJD0+479B2twC+JxCC7JyuQw/6ONVoy5lae+sRDqhMpEa03khgSiBNqw
	Ieaes5RcJABh+EIYPjjRnCZoGW98Q8koZsnTXhsFpuz3o+hV4J83/KIovlmkZcnCKEQo6ye/UfB
	1a0jyWkyA5HS1JayE+BsdvMirtOaWEZmrEFJtm4UW71O4o/cDgksKfQZVQsZykhaZxeAx4pwKDJ
	VYaAr0jHiyG5NQZMXxc9KqFl2L3z7vgJMJizsxH9+oAtqlD/a7RMKNZNbrQ0TsZ7lMgFM8c//Ri
	DUPOdOlf46DXApzl7krB6USH2WdmLNi0rvyAnrNZ6TrdPTeHLlwwCvCusDsj+5IcOYn5NE4ySdL
	8mQb80RiUq9/Yq8vOBpM0pHtD8nS+oA3rIZsfo2XuNcyLFf/KPtVUtXFgNCnfh6JBZyu
X-Received: by 2002:a05:6a20:6a0c:b0:3e0:e400:3fd with SMTP id adf61e73a8af0-3e9023a4ca2mr2024572637.43.1793197307457;
        Wed, 28 Oct 2026 07:21:47 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a6cfc292sm1224768b3a.42.2026.10.28.07.21.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:21:47 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Gregory Greenman <gregory.greenman@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: restore dormant links when link updates fail
Date: Wed, 28 Oct 2026 22:21:23 +0800
Message-ID: <20261028142123.13072-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026152654.80697-1-enderaoelyther@gmail.com>
References: <20261026152654.80697-1-enderaoelyther@gmail.com>
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

A failed MLO link update can leave the interface with the requested
dormant-links bitmap instead of its previous one. This can disable active
links or trigger a bitmap warning during rollback.

The error path restores the old valid-links bitmap but passes the new
dormant_links argument to ieee80211_set_vif_links_bitmaps().

Save the old dormant bitmap before changing link state and use it when
restoring the old configuration.

LLM assistance was used to find the bug and review.

Fixes: 6d543b34dbcf ("wifi: mac80211: Support disabled links during association")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed on top of
the prerequisite patch. A QEMU guest forced duplicate-address rollback: the
old code cleared dormant and active links, while this change preserved
dormant=0x2 and active=0x1 without a warning. The driver-failure path was
not run. A reproducer is available on request.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

Depends on "wifi: mac80211: fix use-after-free when MLO link setup is
rolled back", Message-ID <20261026152654.80697-1-enderaoelyther@gmail.com>.

 net/mac80211/link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index fac5a8c22596..41c1ae52e097 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -290,6 +290,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 {
 	u16 old_links = sdata->vif.valid_links;
 	u16 old_active = sdata->vif.active_links;
+	u16 old_dormant = sdata->vif.dormant_links;
 	unsigned long add = new_links & ~old_links;
 	unsigned long rem = old_links & ~new_links;
 	unsigned long sta_rem = rem;
@@ -399,7 +400,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		/* restore config */
 		memcpy(sdata->link, old_data, sizeof(old_data));
 		memcpy(sdata->vif.link_conf, old, sizeof(old));
-		ieee80211_set_vif_links_bitmaps(sdata, old_links, dormant_links);
+		ieee80211_set_vif_links_bitmaps(sdata, old_links, old_dormant);
 		/* drain RCU readers before cancelling work they may queue */
 		synchronize_rcu();
 		for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {

base-commit: 25e73f1d6868c759c8eb56cad4e411692c5341b4
prerequisite-patch-id: f3df0cde74cce63ac37decd81c2613cdb13f49ff
-- 
2.56.0

