Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DFB521219
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804864; cv=none; b=JusXmYE31riDQ0eIl/dZAmMSzOLYGi60/ZRSVdxV/TO3sfaNG8UMtS9W0mSSGMaEIwnWByi0lXFDbN0iTGUp7FSWsF/HXR5z7CO7cNlmpRyKqybItWjVAss4eT5yL/J0DW1xnfMSayJluYOFZMmxiOyGioy/Uk0ddd3lNBoA6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804864; c=relaxed/simple;
	bh=3RSdV5bBhWRULyl6uKfnW1LG/ffeWbw+PgurKVAIkeI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O7CBMyUUcS4Yfs3vKNZpZ+tkKf1NYsLJ6IGpPaYG5RHMC7idLpgrq4DQWLd5jLYUEOO8ldF2KXzszkmp/DXXPVrziWXyVqvCA7jbRgLHfmZPn0/ZfhB1WCcCPBeIGibT1EHhOfB3/3ghP71Pdts5POp6mNFgvptD1hFnFn8QBjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3IXNbi2; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3IXNbi2"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2df8d1e91c9so86086245ad.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790804863; x=1791409663; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OXsSMFeS4wLeCuWu6IbDBclh7ggI9zoXvgi6QeCApjg=;
        b=K3IXNbi22Chsfq9FHM/J0rx9cHrpfRflGM6gnXYeoGYGmfCYln5ZzG/NfBcFdXdyhZ
         hWDChGty6sfXCNwTPMqrrtmHRHDFTFPORK+NbvSgiyP7ZNQUtE+MTCEVdlfbiuUV3J3a
         6Qmrr0yB+2VdYDshFwDAafm26cic9znfEcSyHjGeBFR1UPKXt29zsxedUgjRaJYlDblF
         nDYxpOeX6B9WbAnFOX3646zl9uZbukQRWogNU6qZBc2vNrWq1v4gPPLwQST0yCHPzmX/
         ZMiggwTMqNdBAmfuX9kt5wthWJAkpkGKGW/wRoLgImz6ed6JtR3ynvl+6hvt4eGkIT5P
         VNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790804863; x=1791409663;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXsSMFeS4wLeCuWu6IbDBclh7ggI9zoXvgi6QeCApjg=;
        b=NwV7IRamvowu7f3otb4wBnSCzLqc8Wjhh+A363LFll2ms1LrqmIyANb2h71Ao8Ck2R
         oKba5vVBaU2E29DgR29+aHMn1rfT85bd1R1vIA5UU9Lkp6qIU9hU2AeB20Se1kYRiAUR
         L5ER/MJ0x+VCM8VSZ3zm+wuCJKbrNSzQwyAw2A2oNmi8XoA1omza/5TqOtF7Xr8/qSGe
         NkOAHmuognKTraeYPO6BAMA+i+FDgL1kyDcRoBkdREk1Te/gFUrAiGLqIuGC244DODRM
         nMifaWXbLlmpSklKB/lVzi+R1MpkGiGTOYhlCkob2JjIKwyh6PgxzuR5kWsC4RKPi6eU
         mXBA==
X-Forwarded-Encrypted: i=1; AKwUvBy9yWejIadc/wgUuaYXefFsQPIBGDXnRhfZG1BMJRL5XSjtRkws8jolIGX6AtYGKLPpMJergns=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEBnOOb3LP0LcEpK+uoniJqwzu0jxIUXoKXWyPj1vUyY7vPpIA
	tCbzp+xfILxDkFVKl9Bnvx4AbeDsfQjEFTG/tKTZuU6Ym3vjPIZ7Eb+7yILFcE3Rhcsxlt72Mry
	HNUqYWmEq97Ur1Q==
X-Received: from plyt22.prod.google.com ([2002:a17:902:d216:b0:2e1:33de:ada4])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f684:b0:2e3:913:31a9 with SMTP id d9443c01a7336-2e30913f27emr449105ad.34.1790804861617;
 Wed, 30 Sep 2026 14:47:41 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:47:33 -0700
In-Reply-To: <20260930214735.3288780-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930214735.3288780-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930214735.3288780-2-joshwash@google.com>
Subject: [PATCH net v3 1/3] gve: fix XSK buffer leak when rings are stopped
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

GVE does not free XSK buffers when resetting ring state as a part of
stopping queues. This causes all XSK buffers which are posted to the
NIC to be leaked.

Free XSK buffers attached to an allocated buf_state when stopping rings.

Fixes: c1fffc5d66a7 ("gve: implement DQO RX datapath and control path for AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Reviewed-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 5cf242b28557..a2c4a08ce68d 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -113,6 +113,12 @@ static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
 				gve_free_to_page_pool(rx, bs, false);
 			else
 				gve_free_qpl_page_dqo(bs);
+
+			if (gve_buf_state_is_allocated(rx, bs) &&
+			    bs->xsk_buff) {
+				xsk_buff_free(bs->xsk_buff);
+				bs->xsk_buff = NULL;
+			}
 		}
 	}
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

