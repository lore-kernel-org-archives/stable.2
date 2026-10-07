Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2344657E0
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791395578; cv=none; b=IBsrCJHKWFcRwZ15jAzLlv8M4ve1pKYUqYmD0M/+RL5lJKLzeGTCrOjbj0+ZbPFU9caD5vk00zdNa7iBUvu3vqmZjvAhlxLpg3RqP+QsSfZ3ZIPcBkSePhnzV5d5lh3LEjntkjhtzbdQZe8THt+OvzpKR1US/cPKnXCl5Ly8580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791395578; c=relaxed/simple;
	bh=uhtxMQ0fKAbNPofLk84gSjQ9sJxGeJ5klNaWx5ma9IY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EJkm0xI1vzwd4kgI8KRT8CZP21RjCzxGI1pkFU1Uj2SafFryYG3eU5hLN2SqCSKRbsXrGm4CZylmpeA6imRl0qcEVLvW//0cv6qSLCBzAjUZEAdht+oFDZpROtEAX1OvM2c1mWa9Q0BGd2iJBm1EK4EAsupTe69UjiyMnoa4VM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=WNuV+NxG; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="WNuV+NxG"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5339381b46eso18135771cf.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791395575; x=1792000375; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d3zIfpdGBSQTp6Jg+3lyricoE8je8WFz2Mt+j1XHJNY=;
        b=WNuV+NxGTGt88QZ7mzjmoYdepj5/F/qfIa6lLZFPJ7LM8IvPfRyb6mIvqQATvqlhyu
         23u3ozWxdZ2OzgindQmBzP4+HYWK8Ko2bQTHmP+ownSH8fmHIi0cMzBilZWW5nvrkLpT
         ILcelfz5qp4iyIg7CPoDwCAkhtK6ftECHJQlF/iNjAjVEw2dpZqf+qH9gO+Gdk6InN9g
         gAqbXY8agAYJQWTXXAqcMZchSDuxaARzH7QVd8yeK+B3qOieyKP3SldevyOvf4YubKZM
         0WYCmY+Q8J1diw99Dod6xIeqgBPLohtWroBBCG8rgYyPB1DbkOxZsQCDTwMk7WMSSser
         owxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791395575; x=1792000375;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=d3zIfpdGBSQTp6Jg+3lyricoE8je8WFz2Mt+j1XHJNY=;
        b=egkmp+ZuGZM0lcRvvYoGdsuKnprwNMuGUFbQGxUcM1lHxtP6TQgbsCFOWivyif9yiC
         M2lndpr+OY43tO509fOIJ/dSQK9Bn7tsMCiSKF2e7ElNHwyQbxUzKk1BAN7unaXxT697
         mcn0iFHWn2e5qFsqUmIG3PLRy3AfuhDGkNzVcc9BtlG4KL451H61PbpdBviebcBuS88r
         RiP/I1io1xnLGB79NAJyRmAvqYXtxYkHtin1TLVoPCle35HijvsYOhopUjWhJPOLuv5x
         4DgCyDIuYyPNv5Dl1fGuTcKfU9VST9mnlX3H49FBkz7sK4hpKGpiWEd+coPR6d42/miS
         na/w==
X-Forwarded-Encrypted: i=1; AKwUvBy+Jyd17WGGDVp53MiFcqHJ5vTBnNBKRgpMwUIBvqv4jUPZYG/n4jMkwlO577tspcTwp9srN7c=@vger.kernel.org
X-Gm-Message-State: AFuF++mNIxQ5/KvmLi+8FM5qIYyf5s8YULgSmAQOl7mmRppXL+XWlasH
	MhnuvKAhNs/A/dVEh2gBPIhg1xL21J2aaunIP2Pzg59ky6BVOjpjnztn7uxyf0O0VM54QPjKQBG
	f+zYY/tA=
X-Gm-Gg: AYBFou3Qqp47OEUOLxLJngXGv3M64euTT96PcmbdeC3oA+ZvZMNIEnjYErSgSMybMZu
	iEhoLHvMmIXaFn8d/HIGjPkjEyU+OmoYRz4j3uecj87TxIkfPUT6V+QSisLgmeG0EyTfpCQQfuk
	C7lpF3kguuvsRfkdQ76WL426wikSsAb4b8BoL4Wpb+lcuLfoWju0iekRVRjg0OxJ5dMUgRyQW+u
	Vx8fFdh45f+U4ckOMZ5iH2PSTfAFDgJe8Tpdqt+G1lvgxk6RS0LzvSP6sl3c6Y+Gmt4/rPxfsLU
	eD4p/qhVcWazv/cLkIfAAynoSdUmlQL0JzRfif6UlD6aRemouGz9JXMC31fcx2I4eqF27ZS9zUS
	MaQLWmYjePcOPTvbrrYXJYMX57uVu0GBPeQjO4JfxOtw5f7KJox4WxqKMOVGovFhzTuIxxkNo/a
	s5VE6uUluupzyozGm3ERPqZyfUWBZTbnrtqc05jizCIHcX+Y8uZr5SiFoseCKUp2Byqt2wmLChx
	Q66LcjOr/Ngjh1GQwIzdRpgZg==
X-Received: by 2002:a05:622a:17c6:b0:535:1b18:202 with SMTP id d75a77b69052e-5357563d9f8mr47366621cf.16.1791395575210;
        Wed, 07 Oct 2026 10:52:55 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357211719csm25028491cf.16.2026.10.07.10.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:52:54 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:52:29 +0000
Subject: [PATCH] aoe: pull in the headers each received packet type reads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-aoe-short-packets-v1-1-db5155f7bb9c@toxicpanda.com>
X-B4-Tracking: v=1; b=H4sIANyGxmoC/2WMQQ6CMBBFr0Jm7YQCFZGrGBdtGWzVlKZTjQnh7
 ra4dPle/n8rMEVHDGO1QqS3Y7f4DM2hAmOVvxG6KTO0ou0bIXrUEtVCyHaJCYMyD0qMc0enqTs
 OYpBnyNcQaXafPXu5/phf+k4mlVZZaMWEOipvbFHPUGtZ7/KvDtv2BY7wDHinAAAA
X-Change-ID: 20261006-b4-aoe-short-packets-f3e7d3580849
To: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791395563; l=2933;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=uhtxMQ0fKAbNPofLk84gSjQ9sJxGeJ5klNaWx5ma9IY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QICch1SptbjdEqliDJi5bIfqQFjyvXfuQRQghFUUBpL14qU7EZUB++3LF5qv0bdlru6xEHz9eLY
 I9yG4e82eIAA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

aoenet_rcv() only pulls the AoE and ATA headers into the skb head when
the packet is long enough to hold both.  A shorter packet goes through
unpulled, and aoenet_rcv() reads the AoE header from it anyway.  CFG
responses go on to aoecmd_cfg_rsp(), which reads the config header
after it, and ATA responses get queued for ktiocomplete(), which
skb_pull()s both headers.  Ethernet pads frames to 60 bytes, so this
mostly takes a virtual link, but nothing stops a short frame from
getting here.

Pull the AoE header up front and drop the packet if it isn't there,
then pull the ATA or config header in the switch arm that hands the
packet on, so each path gets the headers it reads.  This also replaces
the open-coded __pskb_pull_tail() with pskb_may_pull().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Tested by sending AoE responses at a veth pair.  Without this patch a
26 byte CFG response and a 20 byte frame cut off inside the AoE header
each created an aoe device from bytes past the end of the packet.  With
it they're dropped, and a normal CFG response still creates the
device and gets an ATA identify back.

Thanks,
Josef
---
 drivers/block/aoe/aoenet.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 66e617664c14..cd7c735bb43b 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -131,9 +131,7 @@ static int
 aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt, struct net_device *orig_dev)
 {
 	struct aoe_hdr *h;
-	struct aoe_atahdr *ah;
 	u32 n;
-	int sn;
 
 	if (dev_net(ifp) != &init_net)
 		goto exit;
@@ -144,12 +142,8 @@ aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt,
 	if (!is_aoe_netif(ifp))
 		goto exit;
 	skb_push(skb, ETH_HLEN);	/* (1) */
-	sn = sizeof(*h) + sizeof(*ah);
-	if (skb->len >= sn) {
-		sn -= skb_headlen(skb);
-		if (sn > 0 && !__pskb_pull_tail(skb, sn))
-			goto exit;
-	}
+	if (!pskb_may_pull(skb, sizeof(*h)))
+		goto exit;
 	h = (struct aoe_hdr *) skb->data;
 	n = get_unaligned_be32(&h->tag);
 	if ((h->verfl & AOEFL_RSP) == 0 || (n & 1<<31))
@@ -171,10 +165,14 @@ aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt,
 
 	switch (h->cmd) {
 	case AOECMD_ATA:
+		if (!pskb_may_pull(skb, sizeof(*h) + sizeof(struct aoe_atahdr)))
+			goto exit;
 		/* ata_rsp may keep skb for later processing or give it back */
 		skb = aoecmd_ata_rsp(skb);
 		break;
 	case AOECMD_CFG:
+		if (!pskb_may_pull(skb, sizeof(*h) + sizeof(struct aoe_cfghdr)))
+			goto exit;
 		aoecmd_cfg_rsp(skb);
 		break;
 	default:

---
base-commit: a3b346d7b1730db9900bb9e17f5bb8ea27e6ae2c
change-id: 20261006-b4-aoe-short-packets-f3e7d3580849

