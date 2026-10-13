Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A84ACC62
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884336; cv=none; b=k+jU83TnvcqxGfPlZ97gbunYVdFa12nVOgywh6Ih/7Zh0DVJfnftpRR0hYILWcyKg4s5BHWNYSlhpNNu6271EoW0U4WTu9gbl6yJ910donsBAOg30025FVUV971XFd6wvjerkbHTWfvgr90+nL3ehtnnCOhTTp0yKKKWHAtvvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884336; c=relaxed/simple;
	bh=o6HUE10H1YERCIUZ49Hiq7FpqVhuWZ5YpNrDRxcMaXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PiqYYX+WTr157ttUAvaHEOTBtoKYIj8CGvE0cJy5Q6Lf2OHi1f7kghPRZwD7Bwn92hHHWg9hbmW9YbnBvoCSRdqzelut/W/CtvAUDhZbdqin9ejrWZMEivRDk+wgqt2vlCl2uDZReiPhEKVQ+JoxrJwPOxfZG5+tsDRD/Zw5EgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dgc4J0cp; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dgc4J0cp"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a8041a532eso2080688a91.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791884335; x=1792489135; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gmsyojCkmz4iyPbOn24wHnILIhwtPqWT8FUpLIAGx4=;
        b=Dgc4J0cpHA4ojDov457WbnNknpsxtq+a8JMM8Rf4iicDjqzfYRRQAIAAeJSFAV9+i5
         v2/1X5iJzZyB1p8JB5ds+mwo3+dS2V2jEAscxfJFMvW0AsTghNh+7BV0BpdKW4skFoA5
         qG837LQGuKZFtUSn2+sWjLb8jLGaQg2q20mOnT9UIRDI2EhIOOqvCP192LkK1Ld0Ol3o
         kBI7+hWEDOIRZZtwqRZHJbnl3A5eOdm+kAlgcVr+HSENzmfnuPi6mu9zChS9ba5Lc95L
         DpbI8tkXfSamPqlHb+x6QKhqx4UY8hrYnWMeg9L4F2yfmepwF8r/4bdW+C7XBc89VxPW
         Q/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791884335; x=1792489135;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+gmsyojCkmz4iyPbOn24wHnILIhwtPqWT8FUpLIAGx4=;
        b=BxP5Jt3U2zt9A87nn/wq8d1i9MwlXDpCrjSgDdUtWNMMS+pXdsnuIlHzFy5KBqm+K/
         8daiIOlJnQ/zM+uGn9uroQlu7mwdSgYc0fDupkQp87Yd5gTU1f76Q+kawXnxZhND22Yw
         xo32pvQhN5Pon1HzwH2vHilDxeGp+kX8YiJaAZLKgUDc8PzJbM5TfJCYc0tdunbKDJgL
         5HdtoHBDXYHBttAPlyuaX5GNQK2XpkRI3b6U9bNKW5w1erFhZtk+MifHRKT/Fq3oH1ws
         0MzinWbM8Zmm8WmnuQcpsGpxyI2AUGwyAIZQBOC85dMF8pOVdtux1HpxTt9rW5I6RBzA
         PWag==
X-Gm-Message-State: AFq9FYIl4JqJd1Al88DwFhQgAKVYhoA2meKFXJARmjk8i5EM7sePiozI
	GTugbw/vIkpGeiXGzg5KzBqf7SWcmfVxpTRW9DZWf9d1USmG45lNnqfO73OqqF9LogEh7Rd2bNJ
	8+Ci66oaCp1HBIr2TBw==
X-Received: from pgby5-n1.prod.google.com ([2002:a05:6a02:6505:10b0:cc7:cad8:ada5])
 (user=treapking job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c10:b0:3ab:1601:e5d5 with SMTP id 98e67ed59e1d1-3ab3a8e9bebmr7035137a91.45.1791884334406;
 Tue, 13 Oct 2026 02:38:54 -0700 (PDT)
Date: Tue, 13 Oct 2026 02:38:34 -0700
In-Reply-To: <20261013093836.1269134-1-treapking@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013093836.1269134-1-treapking@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013093836.1269134-4-treapking@google.com>
Subject: [PATCH net v3 3/5] gve: Block invalid ring sizes when device options
 are 0
From: Pin-yen Lin <treapking@google.com>
To: treapking@google.com
Cc: stable@vger.kernel.org, Joshua Washington <joshwash@google.com>, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"

On older device versions, minimum ring sizes in the device option are
reported as 0. The driver imports these 0 values, allowing userspace
(`ethtool -G`) to request invalidly small ring sizes.

This issue was discovered and actually triggered by the
drivers/net/ring_reconfig.py selftest (ringparam test case). Halving the
ring size down to 1 triggered a kernel NULL pointer dereference in
gve_tx_alloc_rings_dqo():

  BUG: kernel NULL pointer dereference, address: 0000000000000002
  RIP: 0010:gve_tx_alloc_rings_dqo+0x1c4/0x510 [gve]
  Call Trace:
   <TASK>
   gve_queues_mem_alloc+0x29/0xa0 [gve]
   gve_adjust_config+0x1b/0x140 [gve]
   gve_set_ringparam+0x1f4/0x250 [gve]
   ethnl_set_rings+0x260/0x440
   ...

Fix this by falling back to the driver's default minimum ring sizes
(GVE_DEFAULT_MIN_RX_RING_SIZE and GVE_DEFAULT_MIN_TX_RING_SIZE) whenever
the device option reports minimum ring sizes as 0.

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: ed4fb326947d ("gve: add support to read ring size ranges from the device")
Signed-off-by: Pin-yen Lin <treapking@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
---

Changes in v3:
- Retitled and refined the commit message

 drivers/net/ethernet/google/gve/gve_adminq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index f05f4895f4c7..5e2f91b63335 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -189,7 +189,9 @@ void gve_parse_device_option(struct gve_priv *priv,
 		*dev_op_modify_ring = (void *)(option + 1);
 
 		/* device has not provided min ring size */
-		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
+		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) == 0 ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) == 0)
 			priv->default_min_ring_size = true;
 		break;
 	case GVE_DEV_OPT_ID_FLOW_STEERING:
-- 
2.56.0.385.gd3acb90ef8-goog

