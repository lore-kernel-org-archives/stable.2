Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C65226B0
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915937; cv=none; b=frn46bw3s9hNsGu741bLx2SfU6XTlsZ8tI334N1in8DbBd7yDutcvip3dA59bCEloKqATeCJcMX8s7lPjYqSjfnmegZ6MZLsX5JaivT+AmW7eN9V1XyNCKJvVYmCGS6OjWelSudd1iDIO1Cll+jB2v+P35eR+j+iYF+VSbIFKNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915937; c=relaxed/simple;
	bh=AlG/JZ6VJ7vRBe6rEuyNKsPV58OQf13xQXX8THhv3as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IHbkM6SHa6VBm7IR1k1PBDiPjcMGJeq6xL9blxzEWn6FvB300xmZSxiPxboJRhh+eYdAcYC/gUR5IsKGw2JSb6aPY3p1WThJiREj3wfhWMXxPf27khCyuzftooeiISYNp+3eWtKpgY1FSO4alwiikj8MdixfOuZ9v5UHEDk0j30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=XfKxXSOV; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="XfKxXSOV"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53394bffe0fso2364071cf.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791915933; x=1792520733; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KFCW1M7qXicNkXoNFz0UEyrqo2R7uteq2KxnBN5zNno=;
        b=XfKxXSOVc7prQSLwXIwVuBllKsr2o2KQVK+/5VGkjEGQUESSOJm7ulPM0O1qUImVtg
         pBDtueQJqRTmJaCCmF/k/7j99w8fqNMWKvB1wY2WjCRX/bgD1kEADEc8sPQ83szyru7v
         6bleLCzgm70RqzOKVRy3L3ROa9YALXiVr/O+/g/gmK1UgAue2d3rjnVcmVwg3ry5m4L9
         AsLHg/uELfVFqYNORwI4LY3Ri0q/+lEAmxARzKhjpeXLQjdA0L4+87ZCbh5xvLUgpcN5
         xrigD953YYYvAP4jx0ylU1Hc6vhuoJmcqnAA2MnLx1qLldw6l/aA2LjDJPhq1n0l/TQq
         qpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791915933; x=1792520733;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KFCW1M7qXicNkXoNFz0UEyrqo2R7uteq2KxnBN5zNno=;
        b=A3YaePKnxV+PGbxKb9M6GwfuVcO19TansvodY8vNhopvP6284sHKJI89UGxCK78Pzn
         PjFmiHhPFsPbRJHrjrj8RIbOmLWN6tgg1SHvjoOBGFc05+gvUkNP2SHR8ZEmTBYcmPQQ
         D3T4KWfYaO9AwuBq6lb0TuMC0R2Ga01RpMKoFOIvmP+8Z7PvVvutWA4PttPbYE1iel8+
         uw+zdKqMIZTqGEshpFGPGtgEbmfyDHMjfurfX4OzeFgpYsXjvkaqhLhF2egdTYvnCrrz
         /qAJB6SHO/riPEq8hFriYaatTSIL/pTsPOiUuf45qCDpLdXTWUjakIA2UCBqISWlpjdQ
         VSGw==
X-Forwarded-Encrypted: i=1; AKwUvBxiFdqkEMbNjFfSTWdDLq2r9lADYfnpD8XdnPSPVBvv1VisuukgXh1WuRclfvayEpgAk5EZTCo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJL0YYdc8+DOVMRJinVC22Ki9UcwePS20L3gVRpiCNs4VhiVSpa
	Jix7ITBOXCPT4x6Yg9BHoo6Qdn2ipSmXdt9amyHVPA91+LOh2XPHZFwJVQl2utI5iAg=
X-Gm-Gg: AYBFou1lRYkkk8MNEgnXkjlsxuo9Bm7maPIaHKH4suxyseMN8zGKGHyaxu2UuLK9GNC
	OS/yMoIPFn+oZbFK2xeBx3ScaQfbbKarY7o52PvKp8z73Bsk4RSDXfo0j7zmfJw5oiGhmg9Ldf8
	Bqgrp7jBCNgCKLH+ouzPkC9eR/wKlNegRhScykqgaXeUPKnkXB81RaC9af4zfjRc9Yn0rqBB5lT
	95lkuwjnnAAVhTs6MdxhOaztZP7S6MhFMWK5Q/3PiP0dB9U3jifejyNg1dwuOXTlW9OisdqaQuS
	c/mMBK6lmy+qc/bk3t7Dh05wubO8fpGHH5CuFbf9xbOTp+K4JYtgK6sIPlX4myot1GIhyrA5fjN
	/tpIVvcjBlvgaeSB/QKKUz7ELrHiA12R9V7Rg03rEgcX9uYY4gH9yF5WYbUbsS1CrRzXInV/uba
	QHsyswf9Wy5v1kegtUeU35Ry/evHGuYpLjCG81BhzchhTuURIGOr3z5BhXI1IjGh+iIcBxLanHh
	8TNPHTyDTMfX1s=
X-Received: by 2002:a05:622a:4e04:b0:535:a5f7:d59b with SMTP id d75a77b69052e-535a5f7de55mr186236721cf.42.1791915932663;
        Tue, 13 Oct 2026 11:25:32 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b76eea2sm107276361cf.18.2026.10.13.11.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:25:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 13 Oct 2026 18:25:06 +0000
Subject: [PATCH net] net: axienet: don't advance the TX ring head before
 the descriptor is ready
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-axienet-dmaengine-ring-head-v1-1-7add24e74477@toxicpanda.com>
X-B4-Tracking: v=1; b=H4sIAIF3zmoC/32NSw7CMAxEr1J5jdUvH3EVxMJOTGsEpkoKqlT17
 iRlz3KeZuYtECWoRDgXCwT5aNSXpVDvCnADWS+oPmVoquZQV3WL3CHNKiYT+ieJ9WqCQa3HQci
 jc55P0pLj4x7SyRjkpvMmuEAawfUH45vv4qZ8nWtMUZADmRsyeowld+UG/8hgXb//dwa/wAAAA
 A==
X-Change-ID: 20261013-b4-axienet-dmaengine-ring-head-ccdb8e3acb75
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791915929; l=2932;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=AlG/JZ6VJ7vRBe6rEuyNKsPV58OQf13xQXX8THhv3as=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBomUl/RFNb7o7hd3lkq0GvyegzlXY0C4reO22XN+8hGLGwHC9ittbqyynjfwdMXd/zfN9u1sJL
 GMd7gDVRTMgE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

axienet_start_xmit_dmaengine() bumps lp->tx_ring_head before
skb_to_sgvec(), dma_map_sg() and device_prep_slave_sg(), and none of
their error paths undo it.  The skb is freed and nothing is submitted,
but the slot stays claimed.  axienet_dma_tx_cb() walks tx_ring_tail
once per completion, so the next completion lands on the abandoned slot
and dereferences whatever skb pointer is left there: NULL if the slot
was never used or was already completed, or a stale skb that gets
consumed a second time.  Every completion after that is accounted
against the wrong slot.

dma_map_sg() and device_prep_slave_sg() can fail at runtime, and so can
skb_to_sgvec() on a malformed skb.  Only advance tx_ring_head once
those have succeeded.  The completion callback can't run before
dmaengine_submit(), so claiming the slot just before that is fine.

dmaengine_submit() itself can also fail on xilinx_dma after a channel
error, and its return isn't checked either.  That's a separate problem
and isn't changed here.

This was found by the Sashiko AI review of the skbuff BUG_ON() series.

Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Compile-tested only, I don't have the hardware.  The bug is in the error
paths, which are easy to see from the diff: every goto after the old
increment returns without submitting anything.

Thanks,
Josef
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 09443623a3e2..a5800409e45a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -929,7 +929,6 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 	if (!skbuf_dma)
 		goto xmit_error_drop_skb;
 
-	lp->tx_ring_head++;
 	sg_init_table(skbuf_dma->sgl, sg_len);
 	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
 	if (ret < 0)
@@ -965,6 +964,10 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 	skbuf_dma->sg_len = sg_len;
 	dma_tx_desc->callback_param = lp;
 	dma_tx_desc->callback_result = axienet_dma_tx_cb;
+	/* Claim the ring slot only after the steps above that can fail.  The
+	 * completion callback can't run before dmaengine_submit().
+	 */
+	lp->tx_ring_head++;
 	txq = skb_get_tx_queue(lp->ndev, skb);
 	netdev_tx_sent_queue(txq, skb->len);
 	netif_txq_maybe_stop(txq, CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),

---
base-commit: 8bf659bd54e1f00e34cf5244b1d289c506fa47c0
change-id: 20261013-b4-axienet-dmaengine-ring-head-ccdb8e3acb75

