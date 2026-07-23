Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B9D363C64
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784777299; cv=none; b=m+7Pefd49UXU1x41mk3air/2qEunTeRXIFugCvHAF6Zwj27t+mjwpQSeV7PjkkoM+23ojMJLGgFxZFAM7eVTRkyo6sH3Kqd38aD/zcjnnixWbffbLULc83VzbmPJpe54wlPJtxPfk2Skhlj53jBlW4/jolbcoaL/pLfgwkCOnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784777299; c=relaxed/simple;
	bh=sdhxvo7B/ZpOCnMBhGBNFRimfFAigIMZ6Qr2obutEG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrWEf6q4kwvbjBnWAZqibZfAh7qBWm0nIyLkMM0az+SjHZNuHt+pQJWkl64lRQExzPTbhNU3QQ2R3cv0aCZYIUNwatulnyRoimvWE9nRIT6hHTfOv2QJVYgLDxxnjn+OG1w392ErugxtGLyKjJc9kUQVvh9NfMoMuk2uBu87O0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fknpjgUE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fknpjgUE"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cedda2ce6fso1548575ad.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 20:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784777294; x=1785382094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DHNwKqm3c1H0XvuQxYM3/7tpki/tKxwX9sSDYJq0L48=;
        b=fknpjgUEPQ1IHhcK5tB3lcQoerHj78uLAK2HOmW4Qry1mi/gt+8alecR3jJ8jJHZ/+
         qn5fVCGC9arx/btHCx6hjhF2Cd7OLB0ZzZYsqdCsYOgvy+3iyj11YCz+/eXyroGDutub
         EzALZXQKLs/ny0WOarEIeKvUqvoUzUT0QE6an4l7Fs1+DgG3pYTL7rKfwTD6AXCfBkLj
         kXd//G/N05T8QNex/egtmuD5f6qoNE8Ey7Rpe87tiTdYvNjrnUx5YLK7hxt6pdsAz5ah
         SUVFl+G3e5z6r7tnEf5H6exX7R1bP7heWrpoC3QvJNUHNW5OtOg9qfKH96/dI5Ta+3ME
         VedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784777294; x=1785382094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DHNwKqm3c1H0XvuQxYM3/7tpki/tKxwX9sSDYJq0L48=;
        b=Byg8gvWOc7zUPP1LS7Ofm7nCgRlpRusuo9gooEdGayM527p5ZpV5cHrZJhpw1C1F+U
         fmnTB5PY0newfc1o2WVAuyUe8hYQwUS92rva6FCgxgGGtG0010WXQWTEUV5fzOFd/Kmy
         0HPTXuqWuf5L23LbxVRB3vuy2+AFZa3Ehbf8VSt1yvCG3RE2Cr8D7EmbQTPur0pF89FS
         zhltQo79kr2R2ZR3IGunHE52QWnYmy3JeRv5bmtdnwoBDrazIHxbDDan9tfdnbsKglWB
         ZSxNHsYqsKIazoxudcH3vRAX5gtw2Hd3SnV9vq8u9irv6BLa3zhDhq4/LA9RUAo8xWM1
         m9Dg==
X-Forwarded-Encrypted: i=1; AHgh+RoHTX4oJ7kxNIFwxrPs0PWgvHzeMiu7o4qI0rVnjsU+c+Zbee3yscPXjcvjbfaeHaviC3LgZq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmZdJtMIlVGeox6OV+I9JGtRSA9wLIuC5QM/HhXPaGvFfY8s8E
	VR5lfHFGzJQWHEtxzRuobloSwS4qJwW4Asih7OOSgQIcK/MTtBsxyqXq
X-Gm-Gg: AR+sD10rhB4HLAYOc1geuN+w6TIREFaV0gY52wrz/3jMYBC6dip/mKGDc4CxeUgR0Q+
	wRadVpeR7ucZw6YGx2B8qU/i3I6kuGf8bZgCEC7ia9ftLRzeO+s5ZTn3rjT4u0VGM3yzNfRQZgG
	nR2oaejeybnEedovxJr0oIbJZwEH9aUcOO8jfoWcjA7AlGwg2y8t/1VE20zpPP7WDVrhvqP54YO
	dCt7pF8F/rLlbKJxThaXiAB3tiidZ3gCZshePdbdeb/dRXBox8M+kChpNX8/RyggNAr0ysyRQS0
	oWUX6+B0eZt1IJg/P9ciLoiOnAT4CYxFEKAkhcrxspjIJLRIlQfuzTAVWz5Q3e4giycbhNP7BLh
	cHwLWoI7iPVGtvugHCtC9LLuHToFPN0k+TaktQWJpVJnI+2ctdspusZvfgV0N02YVdS7eYG+tvm
	ja6bwqYXgL1zzkZMYZVPn4VGFUiPNi6OGB5M3Z1/bqSQDyuuljecc1n1mbQfDaGks=
X-Received: by 2002:a17:902:f605:b0:2cc:864b:539 with SMTP id d9443c01a7336-2cfa6a4395amr16049325ad.6.1784777293692;
        Wed, 22 Jul 2026 20:28:13 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd7157sm24538485ad.18.2026.07.22.20.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:28:13 -0700 (PDT)
From: Sangho Lee <kudo3228@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: jikos@kernel.org,
	alan@signal11.us,
	padovan@profusion.mobi,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kudo3228@gmail.com
Subject: [PATCH 1/2] Bluetooth: HIDP: reject frames without a transaction header
Date: Thu, 23 Jul 2026 12:28:06 +0900
Message-ID: <20260723032807.1616487-2-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723032807.1616487-1-kudo3228@gmail.com>
References: <20260723032807.1616487-1-kudo3228@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hidp_recv_ctrl_frame() and hidp_recv_intr_frame() read skb->data[0]
before checking that the L2CAP SDU contains a transaction header. A
connected HIDP peer can send an empty basic-mode SDU and make both paths
use an uninitialized byte from skb tailroom.

KMSAN reports the use in hidp_session_run(), with the uninitialized value
originating in __alloc_skb() through vhci_write(). The control path
produces two reports and the interrupt path produces one.

The byte can also be controlled by a malformed lower-layer packet. If an
HCI ACL packet contains an L2CAP PDU with a declared zero-length payload
followed by an extra 0x15 byte, l2cap_recv_acldata() reduces skb->len to
the declared PDU length before dispatch. The current HIDP path nevertheless
consumes the extra byte as HIDP_TRANS_HID_CONTROL |
HIDP_CTRL_VIRTUAL_CABLE_UNPLUG and terminates the HIDP session. With this
change, the same packet is discarded and a subsequent feature report
request succeeds.

Pull the transaction header with skb_pull_data() and discard frames that
do not contain it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Sangho Lee <kudo3228@gmail.com>
---
 net/bluetooth/hidp/core.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 0e24c5e2955e..194208d03d18 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -560,16 +560,18 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 static void hidp_recv_ctrl_frame(struct hidp_session *session,
 					struct sk_buff *skb)
 {
-	unsigned char hdr, type, param;
+	unsigned char type, param;
+	u8 *hdr;
 	int free_skb = 1;
 
 	BT_DBG("session %p skb %p len %u", session, skb, skb->len);
 
-	hdr = skb->data[0];
-	skb_pull(skb, 1);
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		goto free;
 
-	type = hdr & HIDP_HEADER_TRANS_MASK;
-	param = hdr & HIDP_HEADER_PARAM_MASK;
+	type = *hdr & HIDP_HEADER_TRANS_MASK;
+	param = *hdr & HIDP_HEADER_PARAM_MASK;
 
 	switch (type) {
 	case HIDP_TRANS_HANDSHAKE:
@@ -590,6 +592,7 @@ static void hidp_recv_ctrl_frame(struct hidp_session *session,
 		break;
 	}
 
+free:
 	if (free_skb)
 		kfree_skb(skb);
 }
@@ -597,14 +600,15 @@ static void hidp_recv_ctrl_frame(struct hidp_session *session,
 static void hidp_recv_intr_frame(struct hidp_session *session,
 				struct sk_buff *skb)
 {
-	unsigned char hdr;
+	u8 *hdr;
 
 	BT_DBG("session %p skb %p len %u", session, skb, skb->len);
 
-	hdr = skb->data[0];
-	skb_pull(skb, 1);
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		goto free;
 
-	if (hdr == (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
+	if (*hdr == (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
 		hidp_set_timer(session);
 
 		if (session->input)
@@ -616,9 +620,10 @@ static void hidp_recv_intr_frame(struct hidp_session *session,
 			BT_DBG("report len %d", skb->len);
 		}
 	} else {
-		BT_DBG("Unsupported protocol header 0x%02x", hdr);
+		BT_DBG("Unsupported protocol header 0x%02x", *hdr);
 	}
 
+free:
 	kfree_skb(skb);
 }
 
-- 
2.43.0

