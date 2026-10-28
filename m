Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197333;
	b=sNwS7Ppw2Ug5fuJI2bjc9VTNmoVX8vEJaxxrmXep1iYw68T/jhFICSx6bMYFqiNaipEn
	 2wp5UWNNVTPO4VA12wIylNZGxS1hE4oC13eprBdNapvi5Ok96KKdLg5AWdALpoqnH22jh
	 YfvpoleXyDdVokRwlrMOixYEL63CdRkza8ssqzuiGWXWMQaHyPFr1g+I8U7oCPev9sGnG
	 o/h///C6UQCfhZypSSfrfSasP90J9BQRKdAEgcr4yyUavI/CtV2zSlR8DKBDNEIJ/xcfF
	 HH825oWYR8xBSLZ2k+qfRFoi8vYHtr29gdgtcs9H69QdCdLeWiEODVswiq2OZPoxnKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gqJ0WlZJEjY1WtT7hIbPxHW5FniZwK8mIH2WvTpStXU=;
	b=F9DEGKAf53JJPrY2/Jx2QBZh/0g9LAQw5BmlXQ7AL7hilEUgwZTw1Y0O/uE5ON4oEMAu
	 Q/uoyY+RGpU2+XlPvgCxfhOkhQEShDOVCCh1DIs+dgNpnBxvEN9N0myRWIGbOMHuwWwgP
	 Ji+boDDWZcBag0MX7QeSXNrwaRgDfTJJlsoXc544i7ewReRSWlUhdsO45aXJFLrIvHgF8
	 eN+c9cobbhjsHHiim9y0jaNxhmgabHyADZ/eC3lQn6umjkIsjkU6dXWtdE0Tjmpj8eAi/
	 W1fhqp/FinBcnBK5f5ss7/4A/FCXpABAn2Ho1o1L7cs/iSJXgRs1ZytIJbcA9Eb08ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zGN7imdB;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ADE606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4ADE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zGN7imdB
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso454977a12.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197332; x=1793802132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gqJ0WlZJEjY1WtT7hIbPxHW5FniZwK8mIH2WvTpStXU=;
        b=zGN7imdB9l7Z90ZT96iLtDTKw947mg/cpOB45lxUfEVaDUFTM15+26LDyBrTG8G/N4
         XdVAT1Gs/9WdN8gWJ+tJhsk83hT4Z2zuFu5GxOpwxbEEv8vai3TPJ77IJDNnqhYiOGEm
         WfREZDMWnLsKTdRZwPndWNaF36kJQW4qMKwndesuARyGbx/qSejFAi2ia7Mqo2+2ABKI
         Q2aZbDqsQflidZ2Q5vMYfILZBubAtIBuouRLnYoVZm8n7CbgZe0V2JUrjwTOMREL9zFh
         kHuJfmhVMhFC169xRuIhdGd/JPQFGpG72OrE7XC0fvWEMuvDwaIKlkDODQjzWxs6FmK/
         vqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197332; x=1793802132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gqJ0WlZJEjY1WtT7hIbPxHW5FniZwK8mIH2WvTpStXU=;
        b=NdzfN7/mABIBKHa/gW4wxolYp2o1FnqjT8y5i/xsJPseuBjPx9Nat60eMYVKzuwF6f
         /k0yBu5/LPbUyjAGmRUb3nwUQ93hauSYOAu8ueDrhWXvEkLgsEitmi5Ti1lYKo9EJEBm
         VxsUz4fb0wypEVqO6lGIsKtnoFQu0sVDXTubaxYuXJzdC6pvtZjDAx974Lg3Gxmu/ccB
         wssyEWRSoCc12VYjrZQtU0Zc1LrOWEkPLU4HhvSylrh/X4fBlsDFJ3NbWq2i+GN3dr+y
         CgxZzaJYA7uK65TvRirSrDiYDaNazZgNumo+lZL+mKVLOrVb4YajxlSr7ooS+TTnwcR6
         jucg==
X-Forwarded-Encrypted: i=1; AKwUvBzVrQx5qWzr5APzKhBHpk2JxSzZWfXStdfTwhlr5B6qhZjJlqQ2nxynNViu2Qzx5KekKQhKAQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRXNAaeGf5T6qUnWfBUvbuCYRcJnhVk9EfCRSmzID7fGC8zXw+
	n69NW3It5YKhf9M2HGmGB3N1/ZVG6u/sBDLuN2RTBqbaNCuN4oxhE6z1
X-Gm-Gg: AYBFou07x820SWEEWbDXt2EYAFPze58gxy0mD6KY4gbJlScWhAVGj4/GGZV2GCx+V0S
	o8SWQRcZwfQ2u9oIKV4PxVEIt+YZKAjdfUVFBsgznX2mlgDpvJJCCr64VW0HpmGLQ/Evkg0QTBW
	2EpXsbUxDHQV/P2SoF6aRkTh3Wa8Afkg30YcyWrrBONQN3fudISd0tgW7GMvgL7c2GFIwW4vdND
	F7JsKwCa/o4kSOUu57IuT0IX40kxdDw4/4rlPVndQ0xpSEiJGo9O7+6iPylGSeW/mt58NVZIcDk
	c/j1atputluK8eKI7yP6FusWcrAk6Gher8WlUbx3KdG86vAzeFSR8S1VT5TbBwzmyxiJkYCFXI2
	2tn4MBP4fTV3BhVc3QX8+ICx7iv89SEgZ+2+2MP/Ltf+4zFmhmLHVS4SsfisiVT/Air/8//sMKK
	IJhftjYLhPtUJ77IwXR6IC7bCNdGp6/HpZYb8pdJJOplDek+42304qCah7w7ta8KMbkeha4c57t
	AeM74PL6od1xdoMlD2t/BEWaDqzFydrwLvJ/G5hx5rKkZFGi7KS1qygH8WumAEeAOS5z7ZG4ZVs
	xUmWLZyANe5448m4DNTI5//42pb3dI6PtGpythmwpKtIIJSNMTpzycrpzD2/C8iTJ1t2qVQOb8a
	3vYjBxdDWrFOmpA==
X-Received: by 2002:a05:6a21:4784:b0:3e2:26fc:2e06 with SMTP id adf61e73a8af0-3e9023072ffmr1926419637.26.1793197331584;
        Wed, 28 Oct 2026 07:22:11 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a7b786b4sm1271966b3a.57.2026.10.28.07.22.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:22:11 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Felix Fietkau <nbd@nbd.name>,
	Ryder Lee <ryder.lee@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: preserve mesh A-MSDU lengths when adding mesh headers
Date: Wed, 28 Oct 2026 22:21:49 +0800
Message-ID: <20261028142149.13834-1-enderaoelyther@gmail.com>
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

A malformed mesh A-MSDU subframe with a declared payload length near
65535 bytes can pass validation against a much shorter aggregate.

ieee80211_amsdu_subframe_length() adds the mesh control length to the
declared length in a u16, and ieee80211_is_valid_amsdu() stores the
result in a u16 local. The sum therefore wraps before either walker
compares it with the remaining aggregate length. The decomposer then
splits and delivers the malformed aggregate instead of rejecting it.

Keep the computed length in unsigned int in both the helper and the
validator so oversized subframes cannot wrap.

LLM assistance was used to find the bug and review.

Fixes: 6e4c0d0460bd ("wifi: mac80211: add a workaround for receiving non-standard mesh A-MSDU")
Fixes: fe4a6d2db3ba ("wifi: mac80211: implement support for yet another mesh A-MSDU format")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. A QEMU
guest using the real validator and decomposer accepted both malformed
mesh formats and emitted two frames before the change; both formats were
rejected and no frames were emitted after it. No KASAN report is expected
or claimed.
A reproducer is available on request.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 net/wireless/util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index f2464d2ce0d5..c510fc62d819 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -822,12 +822,12 @@ __ieee80211_amsdu_copy(struct sk_buff *skb, unsigned int hlen,
 	return frame;
 }
 
-static u16
+static unsigned int
 ieee80211_amsdu_subframe_length(void *field, u8 mesh_flags, u8 hdr_type)
 {
 	__le16 *field_le = field;
 	__be16 *field_be = field;
-	u16 len;
+	unsigned int len;
 
 	if (hdr_type >= 2)
 		len = le16_to_cpu(*field_le);
@@ -849,7 +849,7 @@ bool ieee80211_is_valid_amsdu(struct sk_buff *skb, u8 mesh_hdr)
 		    __be16 len;
 		    u8 mesh_flags;
 		} hdr;
-		u16 len;
+		unsigned int len;
 
 		if (sizeof(hdr) > remaining)
 			return false;

base-commit: 25e73f1d6868c759c8eb56cad4e411692c5341b4
-- 
2.56.0

