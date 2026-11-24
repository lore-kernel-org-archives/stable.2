Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795480539;
	b=TQyxyXSUg6j36YoU/WwfxVGLzNjW+PbmgLCyX2o27T1robuHkC1qnMLfrETMCXzCmwV0
	 Up5ALswKgbH9F3xPw+YI40XaOmKxjhC7J45xv5Kvj2wgnpVnBsJaWPQDGSBG0P5+UrHNw
	 n3ozeTBNBeuCuyuFdOPGWfJkkiHoXUea3uURF0mADYgioYz03BZFZgvIsjTjCCLOKou+n
	 uIZzKSRunnXbSQ9RANMh67bJpvScG7IBwA4FBNlNaqYTU24V5PLc8zfhqcMyxE3/Ah+FC
	 d4wT7uhbaPnzl+2YiaYLBXyATfo+KjQbLd7wGo2WVFmSwzfilpDRbHO2px/YdcPFNCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795480539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cEtlzbFffNbXEfnRfrfQt3jwhoK6waIbjHPV7EqbNas=;
	b=UCBKCdb35+vdgxohkF8QqRH1yxiK3cOMFpYI5EZvwBnR0fTaryPpV93nji2O9pLCXEqb
	 A2iBK3lapZb/UuWrKogcrKkevnTTLeI62YO7PmWF2jlz1jnJ2LRDuek7eZgSTv/JaNx8H
	 J+hJ2VOebb2dMNtBo1JVzlHqtG/gZeKQ3LFLYIKdZFh2Alpe2FntIFQ2gp7dlotW9woei
	 ZHAqcoNIoaJhYRZTOuoD8xIqhcVuqh8nFt8faSWQZ1NwaVB7eynG02LOSPS2GcWkMMy8+
	 26Xk7TcdpnBC/c94xhji2CPE5gVsP0vvcxYT/xQGJXAiFe8nyJLexkyoaUPKf8iGNgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=ANJWtQn0;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAE606A333
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDEAE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=ANJWtQn0
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so1872244b3a.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795480538; x=1796085338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEtlzbFffNbXEfnRfrfQt3jwhoK6waIbjHPV7EqbNas=;
        b=ANJWtQn07idnhIuzVfW3nPlfg6xJ5aMg8KP5bLevx3ryF2EWMf5Y2C2WnH6ulnyDwL
         eyV0Rx92s0RCZMZDUL2ElO3Uo4+YC/BngcH6FawYWA+xrCOfKO9bKLQ9mOYbWuLJdHpf
         HRKvwqw581M4r2LNr72lq0FbnDg2OG/qqKnD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795480538; x=1796085338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cEtlzbFffNbXEfnRfrfQt3jwhoK6waIbjHPV7EqbNas=;
        b=fORF1qpm6LURZDbnTrNbSvDg8kdOOtVPzY2xmhpoq6d5OPsOfDKFwZJAILoxVzEwnP
         yiD+/Ooy9uD+J4G12+iWnKP+ovB/arrJSfEOKhTZhO9XT4wCLWSu9mdhMZMag05TA6kj
         98C0vN5Mmmv/tQ+HswutmpS4faaJSiMbHIx3GsiivI5yOWWI5R5hhJVgvRA20uC+foQd
         FqAuY3sV/QPmbJpLKzFL2iFGktj0QvZ8ogAjgRzIZYNKhegDCcQY5BPl2WMO7t1SV27C
         q5qvGTdky525djkW4WN3onJe4WLgWo8Mi6E6BQhaW28I2c6uchgVmI4HUdMoxrlU+mIF
         f1oA==
X-Forwarded-Encrypted: i=1; AL+hErGZM/L8aj7YqfXXjVWJ0H/ArhF5vt3MG9BkIgNFY0404f4v3Ke4Ru4bK136F1kudcys6wusgPA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7uqQaV250UBfsUjTqHeCt98DlherbHBhmQEb09/qao4LEVl1+
	lWjYNp7kEQ8mEKhcK7RUQLICjib3FtcZp7qQ6T7jBEsrU+nzgxxHgZKFRWuGxov75FQ=
X-Gm-Gg: AZFdTZe7KZj2THZ5ONryYsqIrgUsEmbo9dU9ESVMuScDlktqfkYJg0RdNYmaFVhYoNO
	DiD9fLrvEq0bxHuShkJ+Hqbbu1W4qxPdfaeeu6pX887Rc8rbcWL2u610Vraw277tFChOzEv89dT
	B9F/1v07dP9vDzDS/inn/obZuOKW0yn5z6lnpSQZIoKbxqBfcwqhHuQhTXZf/zfxOlu/W7QiWvV
	fU3K2IA2RH5QrB7beUbhZg8Pix0VN0QNnQNsU9X9FSyCXCMr9QIq/aeVKiEu8EZAEGgXSY+LH8+
	CQyPhFwxuJmzjpRHFtaceoPJOdQZRFuk6qeco0wus1bMUVnwxUc+QYnLuZzj5U7LoItzKSkM/90
	o1NXaklC5Eyo2+eVQpojrGtTpwWKBwtRVzaUF9uecy/YVWxrVrmmguno9Rf31Xi/T8VfKgPA3l8
	vV9gb9OS3P2G/SBpRywGw5rcr3lOIPVuZZncH/5lwlwEitf2+p7Bqx/uowrB6tB1bl6vSXb/8Iu
	DQiTr/1/7h3vCgnt7o16RHvSMU816Qgp4su/AeCSGq+7oINtMXmAHDgUKyr4lDgLyajJsXXUTG+
	aFAueHMMUWKdVsRFU1ALl+lbFUJHh3LYEvHmgWTO1bBOgX5dCZH3Ty9QLqRSxDpO+OBmGZRnfny
	McQTIMeTdSlqjVPM+CjLnf4fFVJhQL7EeNEzfL0OYh3yhmbhChk6JJ3QpVw4fMY9h
X-Received: by 2002:a05:6a21:9188:b0:3eb:abb7:f92c with SMTP id adf61e73a8af0-4014cb3eed2mr11300988637.22.1795480538338;
        Mon, 23 Nov 2026 16:35:38 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc8829sm6076667a12.8.2026.11.23.16.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 16:35:37 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>,
	Piyus Kedia <piyus@iiitd.ac.in>,
	stable@vger.kernel.org
Subject: [PATCH wireless 1/2] wifi: mac80211: do not copy the mesh RSN IE twice into the beacon
Date: Tue, 24 Nov 2026 06:05:25 +0530
Message-Id: <20261124003526.78471-2-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124003526.78471-1-piyus@iiitd.ac.in>
References: <20261124003526.78471-1-piyus@iiitd.ac.in>
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

ieee80211_mesh_build_beacon() budgets the user's extra IE blob once:

	tail_len = ... +
		   ifmsh->ie_len;

	bcn = kzalloc(sizeof(*bcn) + head_len + tail_len, GFP_KERNEL);

but two of the builders that fill the tail draw from that blob.
mesh_add_vendor_ies() emits everything from the first vendor IE to the
end of it:

	offset = ieee80211_ie_split_vendor(ifmsh->ie, ifmsh->ie_len, 0);

	if (offset < ifmsh->ie_len) {
		len = ifmsh->ie_len - offset;
		data = ifmsh->ie + offset;
		...
		skb_put_data(skb, data, len);

while mesh_add_rsn_ie() searches the whole blob:

	data = cfg80211_find_ie(WLAN_EID_RSN, ifmsh->ie, ifmsh->ie_len);

A blob that begins with a vendor IE therefore has its RSN IE emitted
twice - once inside the verbatim vendor range, once on its own - and the
tail copy runs past the allocation:

  BUG: KASAN: slab-out-of-bounds in ieee80211_mesh_build_beacon+0xe3f
  Write of size 479 at addr ffff88805ca1887b by task syz-executor
   __asan_memcpy
   ieee80211_mesh_build_beacon          net/mac80211/mesh.c:1110
   ieee80211_start_mesh                 net/mac80211/mesh.c:1187
   ieee80211_join_mesh                  net/mac80211/cfg.c:3330
   rdev_join_mesh
   __cfg80211_join_mesh                 net/wireless/mesh.c:214
   nl80211_join_mesh                    net/wireless/nl80211.c:15399

One NL80211_CMD_JOIN_MESH carrying such an NL80211_ATTR_IE is enough.

Confine the RSN search to the non-vendor part of the blob, so the two
builders cover disjoint ranges and their total cannot exceed the single
ifmsh->ie_len the beacon was sized with.  The blob reaches us having passed
validate_ie_attr(), which walks the element chain and requires it to end
exactly at the end of the attribute, so the split returns an element
boundary that is not past ifmsh->ie_len.

An RSN IE placed behind a vendor IE is still emitted, as part of that
verbatim vendor range; nothing that a well-formed configuration sends is
dropped.

How this was found: by AI-driven fuzzing built on top of syzkaller.  Its
analysis was checked by hand against the code, the fault was reproduced on
net.git main under KASAN, and the patched kernel is clean on the same
reproducer with ordinary secure-mesh beacons unaffected.

Fixes: 2b5e19677592 ("mac80211: cache mesh beacon")
Cc: stable@vger.kernel.org
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
 net/mac80211/mesh.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 8f8814125375..eb54bd98f282 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -379,12 +379,19 @@ int mesh_add_rsn_ie(struct ieee80211_sub_if_data *sdata, struct sk_buff *skb)
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	u8 len = 0;
 	const u8 *data;
+	size_t prefix;
 
 	if (!ifmsh->ie || !ifmsh->ie_len)
 		return 0;
 
-	/* find RSN IE */
-	data = cfg80211_find_ie(WLAN_EID_RSN, ifmsh->ie, ifmsh->ie_len);
+	/* Find the RSN IE in the non-vendor part of the blob only.  Everything
+	 * from the first vendor IE onwards is emitted verbatim by
+	 * mesh_add_vendor_ies(), and ieee80211_mesh_build_beacon() budgets
+	 * ifmsh->ie_len once for both of them, so an RSN IE sitting behind a
+	 * vendor IE would be copied twice and overrun the beacon's tail.
+	 */
+	prefix = ieee80211_ie_split_vendor(ifmsh->ie, ifmsh->ie_len, 0);
+	data = cfg80211_find_ie(WLAN_EID_RSN, ifmsh->ie, prefix);
 	if (!data)
 		return 0;
 
-- 
2.34.1

