Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E5457E61
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106344; cv=none; b=Mb7z0LhkJ6Y4/s3G1kGRf0agzV6U15kT7ZmsiM++7xN4R5GLWyGZRtcF8DGTqQP4RMGTGRPrxEFWQToviaoAfl5+AqoETL0NbyyYOUpixwnPYnvapmyxP8CiIAETozYOmIpKVyR8sdzEyl0j4YANion6Im8JHPq/1yLaeLYIn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106344; c=relaxed/simple;
	bh=UljtQ9XO6rbJkLCDeJXSzP2hU8m8OSu/SUn/z/6iVUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Akf2yDfHlLjvjkTj/sqwZTflQHOwNT09R+3ZQblBx7Mcdsybg5z/8U0YFv50uE1xwdrTrOUVmARhRFfckCcVpdQ63hbq3ulKLS/edy/Q3pyCTpVgceSQtzwujl954yPwt0rf2zxp1c7QWcT7OJwLR3rAFnLYitSkoSnKyEeRrDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vDKzk+Jz; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vDKzk+Jz"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so402139a91.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790106342; x=1790711142; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWYEebvN53sOkHrhhlwZSz3/5d2DYKttJmC/W8rasEc=;
        b=vDKzk+JzBBTn6rAfjEqBMyPU2CXYQYNh/ugXqd8cMGmLPm1jN30z9cZYqEM9IJcpo8
         Hu8D7nZ3GFr85WwKsQXfhIBDDfr02V3PqsXNM2xnqbJzJcq6EsO5SOfLOjclN3dRO0Gi
         7morU4+CIzeCDD++Ned6Oj19jkgZQCYAX2JmICR/KjYYQFtskRSyjGIUbqh9Q00TypkD
         +pbPYJr52TPfLqP08nwLIWflBMDl2rECoIxmMbCH7tLq53NMvs0xKjdO1xIhArLftL/m
         wUQQUKwcAqQgN3KaIWzWKR33FZjfXECy6w8/f6JfrFwHQB3ofm7Z5PMtncbC6lphsT0U
         jOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106342; x=1790711142;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWYEebvN53sOkHrhhlwZSz3/5d2DYKttJmC/W8rasEc=;
        b=Tk2s3zVjo3umuJi4+whpZLfl4nikm8OJBRI8ODHaN7A+ogeywhmfDL+YIb+AKALOph
         LWulp/2Du1tq3JzUQEon39qRbchv1BCkd17b3zeYGCgp+R+XutoMm0RPz5QQsV65zn+6
         y/JvC6Y0Am3YPWPnqhRnLI0K8uwM+ScZPmHj2w9FqpVU5jo9adk6425FI4RbJkJdHnl4
         FABQ6LTOPdu9U7DozrQOSJa+pKRYEGlm2qgMdrVAL3874ytag4wsxGt05xC0X2ibfxDv
         83IU22m8eIs2YT1KrmcLXP5hbRGeVR+C2byjMpwND4Fv+GyIxcnNTnWq9g/Th4IKPHw4
         3yew==
X-Forwarded-Encrypted: i=1; AKwUvBwjYwG2g1FSZ76R3ulVYth18KYTWAkWfHHe05lh2D3PzyJbXQjrLINmu6dfBv9ZibMYkUjbhus=@vger.kernel.org
X-Gm-Message-State: AFuF++m5gd/aW6/S5wVRVEnyivj7q2Q5CmS+sqIetobqu/L6C2ZMH2IO
	jt0Tb79phg27lMa9rFS4ukUhzro2tz1sr1/S4wwgaWnPVEHA20J7EDC8pxP8LgKWGo5Ap47tpGU
	StsUITVrHwrn8GQ==
X-Received: from pgde21.prod.google.com ([2002:a05:6a02:315:b0:cc2:1a89:e586])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2fce:b0:39e:6c68:c77b with SMTP id 98e67ed59e1d1-3a07e6b5895mr430876a91.49.1790106342068;
 Tue, 22 Sep 2026 12:45:42 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:45:26 -0700
In-Reply-To: <20260922194533.631387-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922194533.631387-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922194533.631387-3-joshwash@google.com>
Subject: [PATCH net v2 2/9] gve: fix XSK buffer leak when rings are stopped
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
index c3f4a76b0fac..3a88b7e98b16 100644
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
2.55.0.1082.g2b9226bbc0-goog

