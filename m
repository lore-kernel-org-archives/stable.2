Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548473E3170
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751366; cv=none; b=d5J7dbH3rqCSLtCPooIMjq49sdh80s/gJPsX3okD+r3wtFIx2CVukdM4rsL5qzInowSI02DE4umFc3oS5FJh+1k3I0PqQyHRGjv1cbk/sz4AS+9e6xJnukzuMP5thT3m6z01WcyRFQiH4cMOH4KJ0CNSQijxpPIHXLn9h5f5RtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751366; c=relaxed/simple;
	bh=i5raLJ/viRB4jfYcj0wFvVQznmGjwyiH+SUbX8pRp8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mbotkapb2EbcHpi3sf+URk3dllllMZSHDJ3EH12ZK2NAcPW6W/FZ3ZyCu9JBqG6RPYkVgiSXWn2rGlJf2Rpaw8ANZ7bVz8hagUUZ66RgskgNeP+5XFLJIqwNMznUsWOXn9ms/kZbd2xMReNZpNAytAtzmOFCCCfwbhBbYGmJzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6mrx4fn; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6mrx4fn"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cacd6d37edso22512885ad.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 16:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786751358; x=1787356158; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7djAafJOLBuE+bXbQTtDxXCPhwnYez80KiMRMTkFHt4=;
        b=p6mrx4fnHojiNdphcYhOL1pN3SK3a2BR+qXr+ynr9+jIS+E/5Lhp1IVi67MNm2AzE+
         unPSkS+O5JbFV536ggTX0fFNDsceiaGM57CD8+qsH3BOitfPPHzF/zIS+Oe//JKWHYGZ
         tgIlS8aRhAx6D+1+PmIE+pj/+mG+hyOawuWRkXlQTjCcTbeR7JwzmfNBGN5oemaKp8nB
         FFArPu+nCYHZ4i9ZbOkgdawHVtfcCf22yiTjd1zU+EitSAQrY23TEpJ+cTiiuXjkkFZO
         SnoTLO29VqgWx0v4Y8oPSQeG4s8bG93En7UdgwssXSg1wsvQqZ5s9UZ+n5u/h/Tw/7JS
         dqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751358; x=1787356158;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7djAafJOLBuE+bXbQTtDxXCPhwnYez80KiMRMTkFHt4=;
        b=mxKDfIzEwaUp3l8bh2PzP9wejmXuN7ssl5tpypouUgLnBJFsF91Gnx3ehWpDP2X4wi
         rrQ2TyoG3ezz7euqk3SZL+WR3SQ9gX/7HuHtpkT4xVT3g0NP/Bux9BUyf7LcNdhB706S
         GeXm0tN6/xJ3iVZFwl3Hzsu3giiVw9U2779bnUkiMYusCU/Uh7DsMmBUZvJwNIaqg+4n
         H8pClkqDUzVmJOFlGWn4EMVSH8ng32/SGNmm7Puv9Ii9gk8oQK2dhEjMO4DNe7mij7qe
         Uy9xO7QulzirQ2NIv6tdve+QZ9cPRdgq+/l7XKl+blLSs+anr++24oW9w7kb1pi8XA28
         cQ8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqr5FqQ/1iagu859n7UZOyGhpvoj1euOSv4fl7RFDSWUg183qMpSqLEvMiz4+/k2jNJZ/J8Eto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfcN5iGoa0nirHD3FrxeW78PwKsfGBb4xtHw5D0+RBHcGmzHGd
	CJcsPkRAF7Th5MMKHYqJg8zTZMHNt82xBBcylDDxVdcZuPpJZtCAwRbithUvmxZwXDGfiLDaFjI
	RQwOT5TnvXdwDSA==
X-Received: from plnt11.prod.google.com ([2002:a17:903:196b:b0:2c9:a5a0:a677])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f689:b0:2c9:fa31:84f9 with SMTP id d9443c01a7336-2d3b0cdc256mr101631195ad.5.1786751357477;
 Fri, 14 Aug 2026 16:49:17 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:42 -0700
In-Reply-To: <20260814234845.773189-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814234845.773189-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814234845.773189-4-joshwash@google.com>
Subject: [PATCH net 3/6] gve: fix XSK buffer leak on error descriptor
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>, 
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
index 2c1ce23d1550..811db42d05c6 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -845,7 +845,12 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
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
2.55.0.691.gc56d675ccc-goog

