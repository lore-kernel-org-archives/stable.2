Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084451357E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804866; cv=none; b=MQb7jC5URpxhvXxUELPuD64hIsz3Zuzt4wZzbNTX8T3L+Y4hFgO3EN69IPp3TRZc5eqNdD5u6CxnL1g3ChLmWMK1DiYsdZ2n3AXmuMXCbyKQVcGiiOmCWxlacuWPOuYmuVHgx8CcDIANm1Mbr7silyv6/25ncVkf5yisKfHMEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804866; c=relaxed/simple;
	bh=3Yu3IkCZbSo9RNlOXRScWTtHidQBLUVTZg24zE+kHKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WTK7K5G1HB/D6FPFx902bekhmfHWVzM8urUWpLhXqd4OdGRQTgsTg3NHIiLVLTRuXnvVJJr8lym9LAbIkxtykzTD2LRTWqobvo2FVHgmOYue7hsOm1AwJZdt8D1kVkhc4oHW82nTalqWp8CUSZaFUKqTCCyjHN1OPOSni9UFtNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ta8HeOGv; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ta8HeOGv"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2df375fb9b2so61216075ad.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790804864; x=1791409664; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gh40TVa6IvM/Fh6GhOPih6pz2RWuBxxGlDlIZav33u4=;
        b=Ta8HeOGvwDM6359ilxpMbSZygAiauDL1adbBVc8oI+NqOP/e2Sfn91FaaBOCi/JBwx
         L6ciZQ9qmvVU+7o525uVK4XUJ5t+AqA34rUx8y53PLZDW4x1rph4thTVwZOAjZuanU/Y
         fkVLRZv4hDxzy8fgGmSbW7jGBNt3zBN/jOmdMr4sI2Q7W/UHr4fjc33UPitO2PG9XKDP
         eNIdtgsbzCzNG0GCaQ31+rErhOWP28UWpcvienWOK90ZP5xntg3SDIPCMXzuFMZAFXlb
         aywkMaL/sJ/4q+bSGqpOKQeshiUfAjBUewDFWpLCYeYzpS7mIPuhakfYw9pHRtYXRlgJ
         /KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790804864; x=1791409664;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gh40TVa6IvM/Fh6GhOPih6pz2RWuBxxGlDlIZav33u4=;
        b=2MG7X1N0wanOKWiqZv4egGf496Zvi0H/Mqw/G1qfX0WfzOq1CwF3XE4HvVMH1ZjFXF
         ueRarW+zJOVI6GMq0ngJ9y51D4S5Mh8B9O8LzULdOEkSgFk0bLjaV2Ae3IzyeGq9sbWX
         JZoFT4HWEfvUC3cTbie0swdghAjV8jyPuV8uib8brJncqbbyBwihuIFUCMU4RNyp7XN+
         EGt/i71KuglZGcFDduHlk+c/WERZzYnVY9EatSKSsDK4/inl/tUaACfRfHF6qIeADX/f
         bbtdjbb0ImdP8Um8JgKI0XHYCbsN3QDeSXTXJfwFyL+Cx3MXZ5V/+tM5ZZgfyu9KjgnQ
         nfZQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2+6UCpUMRP9t3E81bSrn2irHRERH8sXHVVt9+X24AsD7M+Ruugro9AgsXc7GDR+ewc/EerkI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQsTWMQmKoz02RoMShNEIyHjWXKuC3qOumok9/RXmINGj8ITyd
	mgi8+CSImisCpUCYSrsgKLRwJO7mU5l4ANY0FvD9vC3X0PLH1fdgG83ifuAnBkSGh0XLmNnUzYR
	TWuRD5OTaZr66Jg==
X-Received: from plsc13.prod.google.com ([2002:a17:902:b68d:b0:2df:4aa4:16d0])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3c43:b0:2e2:d989:c273 with SMTP id d9443c01a7336-2e2e4b96b3cmr23197395ad.53.1790804863483;
 Wed, 30 Sep 2026 14:47:43 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:47:34 -0700
In-Reply-To: <20260930214735.3288780-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930214735.3288780-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930214735.3288780-3-joshwash@google.com>
Subject: [PATCH net v3 2/3] gve: fix XSK buffer leak on error descriptor
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

When the error bit is set in the RX completion descriptor, the buf_state
and its attached buffer should be freed. In the case of AF_XDP ZC, the
XSK buffer was not freed, leading to a leak.

Fixes: c1fffc5d66a7 ("gve: implement DQO RX datapath and control path for AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Tim Hostetler <thostet@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index a2c4a08ce68d..82ed5e48b00a 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -842,7 +842,12 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 
 	if (unlikely(compl_desc->rx_error)) {
-		gve_free_buffer(rx, buf_state);
+		if (buf_state->xsk_buff) {
+			xsk_buff_free(buf_state->xsk_buff);
+			gve_free_buf_state(rx, buf_state);
+		} else {
+			gve_free_buffer(rx, buf_state);
+		}
 		return -EINVAL;
 	}
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

