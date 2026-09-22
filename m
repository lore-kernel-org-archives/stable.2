Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1C4A68A9
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106349; cv=none; b=OITR1SECxb2brLOhAbIMA7gLqckeES39URwYOBvOeEk1iK/PEkA+d7wWgSEXNMX3X35JjsOk1LCUiG5Yfoiv4rIBERoBFyHQ/V61TA8xJ6bZJlBNy9ULkoe3bU5g6lJTsyz52xYgxkgOV52ZvBCIjhdQKgXKOHw2qV8SDWLZo10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106349; c=relaxed/simple;
	bh=phK9UGM82Su0/Yft5H1gsYRLHi1zGw1yM7fKl/AmyEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n/2OrJhMYwwT4ijMjIR/j0sc7+laBXNkk2DVgJiucVwmdDvyK/kzJE78TInbpIqlQ2Kf7TEWXD89/vsRY0S7iyecq46kO/6xdz5C7bDqsLURKmxGKlJNxBc/oFyXJ5ihvszouVANEuu2adIcUd01UPbVeQjGvo5tnLPqPj+N3AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXCwaLJK; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXCwaLJK"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8633c0d7353so221692b3a.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790106344; x=1790711144; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EcTqMP1GOUb8ln7imudpJQ6C9nwPlePs3BJaEQbnd4o=;
        b=gXCwaLJKDI0BJ/rH10BhZzCHomuw0AG71/rrOZ8UJk1OwYuBq8Fm/JcFvEIE88LYDn
         LN/rYMycTfW4U9X1UF0+amzqlpgifPto6qSF1NXiLOsGn1gt1UgIDZT/3WqBG0l6nUoB
         A9LkVT/m0ayb/llsObTBluxWuckZwpm/i/oBkqdnuSIXeEpBrxRJIrueRUAgh2CVpHCB
         1dIz+gpMIuAxvmvYsixt2oAzhsQCGjOlR8S7iqMwYIUl1tu68BRLZBIg3hDZsozPhTuH
         tOlaA2Kj8lR7UjqDa5kFNmKic/XV4POFIdMDrSlZRv1oWvjOmAvLh96CCZUKD5Ou9AQR
         mX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106344; x=1790711144;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EcTqMP1GOUb8ln7imudpJQ6C9nwPlePs3BJaEQbnd4o=;
        b=lD0yYrMFmq5Td4EUAcnv7kGSJd3rYRx6UiOZTwMUsbdr115xUYxx27TJaXKUkqVbso
         fiSoozy0Mq1jnv7WNUPfEGQLTjeTvjZ07QK4gR+8LdocIaZ7lsQ8C+5Uc/D501msNsHL
         dTudcvFzHmqTZ4+ZTWdxKmTN+Wyc9f67fLejhQHjxdPik9rxAGZMMHhmIureUA/FjyQV
         dhviUfE8h9Atcqn6VqkH44G1mm28On+CxDu2DljedpcALzzdFNq6/VXBb6h3sbyklEnh
         ul6HUnY/tN+P7B0vicbIFgh04kxrMspATa+soo5bkYb3YTdGlLR2oprEBEqV6ENjmI0w
         ioqA==
X-Forwarded-Encrypted: i=1; AKwUvByeGDgnthaRPLO6foSpJIK0fsGD9UcSQJlA34IQ0J+Lon0a49hV7KoAJv5Uoovi+OVwQxvfVW0=@vger.kernel.org
X-Gm-Message-State: AFuF++nu45vSNwkQTwHZNSe9NnnAZPQhNnl+yCXS6o1j+Hu2Kwx/vR6o
	kc8ScIXEGfY2FVEPKI4pK/YMm2+ENhrZAFTY0I3IFEig+3ZAsRi97vzPGCJyBYgsQm0yuAjWs+c
	tofTbgX8lhqRE6A==
X-Received: from pgvi12.prod.google.com ([2002:a65:61ac:0:b0:cc5:1183:79da])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:8217:b0:3dd:a197:7359 with SMTP id adf61e73a8af0-3ddf8287ef8mr500782637.50.1790106343974;
 Tue, 22 Sep 2026 12:45:43 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:45:27 -0700
In-Reply-To: <20260922194533.631387-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922194533.631387-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922194533.631387-4-joshwash@google.com>
Subject: [PATCH net v2 3/9] gve: fix XSK buffer leak on error descriptor
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, 
	Eddie Phillips <eddiephillips@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
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
index 3a88b7e98b16..c1e97e11ff35 100644
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
2.55.0.1082.g2b9226bbc0-goog

