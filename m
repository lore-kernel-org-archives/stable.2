Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197283;
	b=A0Bipm0kqR8VNgpUVf6M+QDCcnxUV9qmc3R40CyJ4mD9lagi2ItezHG5GSkq9gaFpc59
	 Ga8K0QcaW5L6ztkWNlEeLR802Tl9IYeYwya3DskvdSKblWaheJXi7Bvl7Sj9zRvP2ZIce
	 O7m2v9ORSNhLTMUxOPUdSIEWEGL9GDarQtuoYEIxec3lkrVmRLH0V+UE/vLg0phQvjhpf
	 46x8/mmBKJXwdDIwVoU/C0qcy8XU8eY5WBzOTc/H26HLFTunvMzYzu6aNc920MIikjcs+
	 aSmovWdoYMoTuOt8FW7aoJ7TFAGflDxFS7YhkzkukN5k5gYSgaON+HAr/Xfaz2eB0rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iVPlVEgXcfYnc5ByflI8cqyqM/yX51vQqKw2Q7ZDD9M=;
	b=Ksp91Okq6cXaAyuRVPyyjYZmAKyGXhSldGGC7dZ+rUOC4P0mXnpXMVPdpAc/KgqL0aNS
	 pZ5SHnMMjik/FTV3Z7BtZvyXddN8pEGcIFhxLThuyiNAIfW5ZoywWuDxJM03n3TEWzdG6
	 UQ4DKxMv/fEjzsWsJ1r55YxWq5W8C5DniAlgWsbbWonhrpoLRyJ4E8Do0kuI3Fl/rOQNU
	 Bq1wG6KGgPh1WiU9jCfdOp/iC2MENJBs7kaqv5ChNwA3Nw4QVOZQ95Cus90iDVZz4sPLI
	 N9ihFb1Navds0p8SYAmdq1JgSyBGVhgd2kVaRAQ7A3QpttJVhzQNQi2RdN+kgn90/GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nYBYvAxt;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF06606A32A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FF06606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nYBYvAxt
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a07078200fso552216b3a.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197283; x=1793802083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iVPlVEgXcfYnc5ByflI8cqyqM/yX51vQqKw2Q7ZDD9M=;
        b=nYBYvAxtQdanTSZ59b3PuIx5c1SuFOrfLYb/dMQsaq2CcGQPSP4C9zAeW4zoAHwNoV
         mtctK+YdQfGnsgomBssdpL879SI8U7T5Mpks8tY65xwxOcNZVnLN4sm6OhrAFsRiVqLw
         QfWKKdVWlPhis9AmPbqx2cxTLMQz+un+WFfQRwHziCrjbc3DHatMD2Ol52+CwaqFuIgD
         U6Y3mSS6mFXb7RmAiBvnSenuyWjgRMjy2/hFMg/u3crczo3+kQ1tdSs6hUrnLfe8aRUL
         Coo/jQYoOZK6GJ/ykBjSlTz5OCjHAXGB962VAGGlWfAWS8q/H6YZgHFJM8bnmZYqtF01
         9BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197283; x=1793802083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iVPlVEgXcfYnc5ByflI8cqyqM/yX51vQqKw2Q7ZDD9M=;
        b=p2yeqE4Za98XmAqmyV8NQ4BpTgang71bO0u+iFhQPZAu38lvE1d9NKuHgJPyFOtP2N
         ljzCLyv+OVHhXqqEloYOCBE0/hloVIOCRCUI1yRF0wA3p57o6A8BKLZ/PFycndKT2XUr
         emOdV9En/mVFEJcT3R/Z18JIvK6Guq4Yx2i2Q3Te2qf4wGR71rE0iMVMkd9SE9yagtI+
         gZjpFyJ8avr52BKwLubTWSDGoW0aXrso219BEE8QuKdqXih6PIj3963O7pyJHHMB7stz
         51GGXxurnxZDHIspLwNCslONENleq9PhtqDYPTJYZc2+lE+Hq4lxqJ4UjzPN2xNkRqSv
         7gsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzctkNxZSdQfRxCmtNjQ461ubFyjl/NKpUxA4CRcmCtNOmRAXkXqar2TiaxplQoTLbHF1KUgg=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4huPM58BU/iwxg5LTeFaPZIlABkR5RdW2iwMzOg8X16w/j3D4
	zZQslG4pJ5xBhD+WVyzwKHCiZd6R2DHYCkRU6u+T5TeVHKQ7bvnKWQ0r
X-Gm-Gg: AYBFou3+U2+DLSNhiOvmCRimX1AUcfXUN9jl/hxKgDwGq94/UH8bJ8fYxV91TubiasF
	UM5bpGRQ/sNmSJdZyR6OKFyB8XIYHFXbMpFWwUGervpiOTU0p4WheOkSgKba6moGRr7lGEDyYN6
	lEUO+zS4VMuJQo/ndwqWrkO6tiHfGOBBShX7lZTAwZiJJnOzCgJY1WJ6nPzNVVTtfJe2d9Z/sBj
	0mvyNet/7WJjakKzKA9LVHtPDtnhlDqR2/rYA/AvI+40Y1fHTDpyS3QQke9akjpNwJyVRnZudwy
	thR1J7+uzBZ4FrwiXAsn1u96H9nQccVAcSEfBnDP4Jyo4OMUN3EHT7tpjQncBIdeAzZnO0xKmVT
	9JBA6lkQKVrTCjph8CR6NeYuP6CG/aQm17HmZbEysEct6DoNKteDXL+nuSOFje+yace5hY4j7mS
	ISpydOXeNXwqOFI+vszdu3/jcQYJoHugpqMPHJsoHQvQpSnNR5Y7I/vToyyBSySyZPm609E05HZ
	4a3NY2tIWLqAv0KBO/7Sfz3djXjkq/4nPQi4f4aJOBRw/W8T4rDO7g46cXz8yCIvrcIBzy1xlNh
	bCI+4idrXgYGHFDnjUkYOuPzA68Z9+h15ryU6v4IL/sI1DAUeFnJSOG6z5uI7vIc+VxW
X-Received: by 2002:a05:6a00:3d48:b0:84e:909:ac03 with SMTP id d2e1a72fcca58-8a6e72dc627mr1999640b3a.10.1793197282428;
        Wed, 28 Oct 2026 07:21:22 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6dbfd4d9asm968825b3a.9.2026.10.28.07.21.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:21:22 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>,
	Sven Eckelmann <sven@narfation.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: recheck injected headers after removing FCS
Date: Wed, 28 Oct 2026 22:21:01 +0800
Message-ID: <20261028142101.11994-1-enderaoelyther@gmail.com>
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

Injecting a short frame with IEEE80211_RADIOTAP_F_FCS on a monitor
interface can pass a truncated 802.11 header to transmit handlers.

ieee80211_monitor_start_xmit() validates the linear 802.11 header before
parsing radiotap. Radiotap parsing then removes the four-byte FCS without
rechecking the remaining header length. Software encryption can subtract
the larger header length and pass the resulting negative length as an
unsigned size.

Recheck the required linear header length after pulling the radiotap
header and before handing the frame to the transmit path. Require at
least addr1, which the transmit path reads even for extension frames
whose header is shorter.

LLM assistance was used to find the bug and review.

Fixes: bddc0c411a45 ("mac80211: Fix NULL ptr deref for injected rate info")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. In a QEMU KASAN
guest on the declared base, six truncated data and QoS-data injections
with the FCS flag reached transmit before the change and were dropped
after it. Injections that keep a full header, including 10-byte ACK and
extension frames, were unchanged. KASAN reported nothing in either
kernel, as expected for a length check. A reproducer is available on
request.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 net/mac80211/tx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 32f94761cf32..f2772b1736f0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2511,6 +2511,12 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 	/* remove the injection radiotap header */
 	skb_pull(skb, len_rthdr);
 
+	/* FCS removal may have shortened the 802.11 header. */
+	hdrlen = max_t(int, hdrlen,
+		       offsetofend(struct ieee80211_hdr, addr1));
+	if (skb_headlen(skb) < hdrlen)
+		goto fail_rcu;
+
 	ieee80211_xmit(sdata, NULL, skb);
 	rcu_read_unlock();
 

base-commit: 25e73f1d6868c759c8eb56cad4e411692c5341b4
-- 
2.56.0

