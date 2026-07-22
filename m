Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE54749F8
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740726; cv=none; b=hZtUhJCAqk8UrhyAsEdrTCDyb8slnaemJ4wUi6y6g3NUNWmakBi7kepmCCMcV29R/t7LXowLHXM6SUshYtwRkm7uDFlpFFjpxnUZrvhpkzM6Wi+dopiPjKKm98IJGcXThQGnUaP+4mFbTqHPsSWvHbeWoTSww/y+J3qarzZjbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740726; c=relaxed/simple;
	bh=cdxRSieBisfFr5FX5xnyrYTHsugWro9SEov6ZIA36qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWnmUXLiB1Ch1Yp4qZdApslt8Hlt264m5HI7jOUWst+pD+S2eywrmo2mB4j/YezrJkoeuKqTlKJa6vjwRnQvltBjWQc+7OaJ1+WFP+TBLCC1P1cKE48VNKXoCCNH/Se5fQ52T86daN0DwBWPuHYjtL+TF1yEc8nWRNc4rFhpQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzgPcwgv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzgPcwgv"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f502ff678so1768f8f.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784740721; x=1785345521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BqxPzTHo4F6RITjff4xFH6QwEdtq0VyFnyAnj9pOhVQ=;
        b=KzgPcwgvZaup9SertoK4l/MgqNA1KVtYVQUW7bICsWpo5cFbFXSWdYydHsc3J+W88P
         qUaD4aqygZFKyu3z/vfRVxRIZd9mmx0Tp9jQcV4B7ibLrhQhp5ZurU4fx13UtdOTsAA0
         XidGAIxnSkdI0FoejWwgqHvMOLx6gEHs2hKa8mzCPrIpqxnx9wQ8wqgcw3Jxq5QDhakf
         Akb69G5Ul69SYbr1Eh8fn2jqTpzD5C5jycaucSHQzgarivDqyvItAIMSt3dIkQ4H7wPl
         qqJPP6NX/r2RSnaEShb/nLRwwLpVKAjwy1xDzumOFvdf6YQi1KvVTdQi3tkbSV8Vdf/4
         cflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784740721; x=1785345521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BqxPzTHo4F6RITjff4xFH6QwEdtq0VyFnyAnj9pOhVQ=;
        b=FvMq2up510WrNNvseBsNRiLzDBG848PJO7i8LYY8r7NE3H5fLBMl72FSXSGTmres5Y
         QCXlvCiRFvQ50NDtS1HoBQoWKhZPur6wsMuep7lw6poCvoShne1aYlEKuB9USJFWwyut
         IYIZQMWttpCtCwW9a06zRAMJ8Rh6lcZ0yxEY2gNGOVv9FyLD3IXsv1dRIRTCayJv/h+s
         kAygA8r5Z55MqfzUT9QaLIr7SjBrksW5BAAwbcRAiIpmCGFhRBD+cGSa+SmQlDXFtSZV
         PrpHP9/DfRjxzpv+xqcMaFJaGTbsuEglodxO4Ki/cme+TGRpNp0d1uLFpJ1rU1BVZ02C
         C1aw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7IU/8vZidDQkDpSN4vZoxA532IhlPwaCcruMdy8NlB7GNHhPOEEZ+5sCXjeUb/ictzjrSgd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyjOOUNWm+Oci75P6l01A86FlxxL4UO06e6BgPfMv/0VRpbNo
	ulPXXIU7yXyE5qRj9n8AGirsNMS/aR2w7UbPqlb/fKIr6n4+2mGhcTqH
X-Gm-Gg: AR+sD13btck+s47c6AROPAd5wQX7p57+XL02zkV6BtBcj0dFtOfmC1RqxNrMPYkqwtB
	SqMJ82lD3vjGwOnBIWDsEFnoFMNcPnV9gJFTV2SY1AvDbRmFkoqpzzfTTx0nGYsxTxMJX4+A8US
	1jGihMPf8F/As1j2vFJkmtx/XSH+jJIXUpc7+XDed7CI4tboh+tBtNj60k6A0KRvfd1ko5zcZsj
	yIaYMMGOpD9+q5BgEXseBMpOvnRj1BOd6CIZf1UBpkM0d4ZqJL9oof2IT0PBiVBS+2paCqNRDGi
	RkwefNSbrL0dThjKLeqZWkqCh0sBWn1+q30SxA9IRZw2xQMTUEx5e0eKpmWTXNVuUcux6SdkQQC
	P+uxh1G3au73ZRMUQDcNZo8D+bPponW3ljh9EJI/c+42mkSRZgmCgL+jN3XnOz6EXjtoe8n3iY2
	rUrT2KL2LgA1WCYh15/t0PnIU3DDq0V3jXxnhYrIL1SxN9nlPNl2vhuMgaQPMgT4KvlzFWBi2h1
	23znrfbBcT4fCvFTa7o+aFwVefR/tvExo62Tg==
X-Received: by 2002:a05:600c:1d1a:b0:493:e536:7bcf with SMTP id 5b1f17b1804b1-4956b012531mr29669095e9.7.1784740720971;
        Wed, 22 Jul 2026 10:18:40 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-078-051-150-230.78.51.pool.telefonica.de. [78.51.150.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a634cf9sm92427615e9.9.2026.07.22.10.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 10:18:40 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	qingfang.deng@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/4] net: hsr: shrink seqnr_lock to sequence counter updates
Date: Wed, 22 Jul 2026 19:18:34 +0200
Message-ID: <20260722171836.196-3-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722171836.196-1-xiexinet@gmail.com>
References: <20260722171836.196-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsr->seqnr_lock is currently held across entire hsr_forward_skb()
calls: master TX (hsr_dev_xmit()), interlink RX (hsr_handle_frame()),
and both supervision frame builders hold it while frames are built,
classified, duplicated and forwarded on every port. The only state
that actually needs the lock is the sequence counters themselves
(hsr->sequence_nr / hsr->sup_sequence_nr).

Shrink the locking to the individual counter updates:
handle_std_frame() now takes the lock around its sequence number
allocation (replacing the lockdep assertion), the master TX and
interlink RX paths drop their outer lock, and the supervision
builders release the lock right after updating their counter instead
of holding it across frame construction and forwarding.

Sequence numbers remain unique and monotonically allocated per
counter; concurrent inputs may now interleave allocations, which is
fine as the output paths were already concurrent.

This is a prerequisite for unfolding GSO super-packets at the forward
entry: segmentation with its dozens of GFP_ATOMIC allocations must
not run with BH disabled under the global sequence lock.

The locking being narrowed here was introduced by 06afd2c31d33
("hsr: Synchronize sending frames to have always incremented outgoing
seq nr."), briefly removed by b3c9e65eb227 ("net: hsr: remove
seqnr_lock") and reinstated for the interlink RX path by 430d67bdcb04
("net: hsr: Use the seqnr lock for frames received via interlink
port.") after a syzbot lockdep report. All sequence counter updates
remain protected; only the forwarding work moves out of the critical
section.

Cc: stable@vger.kernel.org
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c  | 15 ++++-----------
 net/hsr/hsr_forward.c |  3 ++-
 net/hsr/hsr_slave.c   | 11 +----------
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5555b71ab..3fd1762d8 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -232,9 +232,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb->dev = master->dev;
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);
-		spin_lock_bh(&hsr->seqnr_lock);
 		hsr_forward_skb(skb, master);
-		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
 		dev_core_stats_tx_dropped_inc(dev);
 		dev_kfree_skb_any(skb);
@@ -335,6 +333,7 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 		hsr_stag->sequence_nr = htons(hsr->sequence_nr);
 		hsr->sequence_nr++;
 	}
+	spin_unlock_bh(&hsr->seqnr_lock);
 
 	hsr_stag->tlv.HSR_TLV_type = type;
 	/* HSRv0 has 6 unused bytes after the MAC */
@@ -356,14 +355,10 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
 	}
 
-	if (skb_put_padto(skb, ETH_ZLEN)) {
-		spin_unlock_bh(&hsr->seqnr_lock);
+	if (skb_put_padto(skb, ETH_ZLEN))
 		return;
-	}
 
 	hsr_forward_skb(skb, port);
-	spin_unlock_bh(&hsr->seqnr_lock);
-	return;
 }
 
 static void send_prp_supervision_frame(struct hsr_port *master,
@@ -390,6 +385,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	spin_lock_bh(&hsr->seqnr_lock);
 	hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
 	hsr->sup_sequence_nr++;
+	spin_unlock_bh(&hsr->seqnr_lock);
 	hsr_stag->tlv.HSR_TLV_type = PRP_TLV_LIFE_CHECK_DD;
 	hsr_stag->tlv.HSR_TLV_length = sizeof(struct hsr_sup_payload);
 
@@ -397,13 +393,10 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
 	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
 
-	if (skb_put_padto(skb, ETH_ZLEN)) {
-		spin_unlock_bh(&hsr->seqnr_lock);
+	if (skb_put_padto(skb, ETH_ZLEN))
 		return;
-	}
 
 	hsr_forward_skb(skb, master);
-	spin_unlock_bh(&hsr->seqnr_lock);
 }
 
 /* Announce (supervision frame) timer function
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0774981a6..8e4158a9b 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -621,9 +621,10 @@ static void handle_std_frame(struct sk_buff *skb,
 	if (port->type == HSR_PT_MASTER ||
 	    port->type == HSR_PT_INTERLINK) {
 		/* Sequence nr for the master/interlink node */
-		lockdep_assert_held(&hsr->seqnr_lock);
+		spin_lock_bh(&hsr->seqnr_lock);
 		frame->sequence_nr = hsr->sequence_nr;
 		hsr->sequence_nr++;
+		spin_unlock_bh(&hsr->seqnr_lock);
 	}
 }
 
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index cefbbfbd5..c7fd021f0 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -73,16 +73,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 	}
 	skb_reset_mac_len(skb);
 
-	/* Only the frames received over the interlink port will assign a
-	 * sequence number and require synchronisation vs other sender.
-	 */
-	if (port->type == HSR_PT_INTERLINK) {
-		spin_lock_bh(&hsr->seqnr_lock);
-		hsr_forward_skb(skb, port);
-		spin_unlock_bh(&hsr->seqnr_lock);
-	} else {
-		hsr_forward_skb(skb, port);
-	}
+	hsr_forward_skb(skb, port);
 
 finish_consume:
 	return RX_HANDLER_CONSUMED;
-- 
2.43.0

