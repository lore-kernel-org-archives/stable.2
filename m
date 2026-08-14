Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DF93EFFDB
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751358; cv=none; b=q9JJ5TPqGSsJYyvI5tJTqMTgdYRHKPsvtXp2lEOwOupek7gdctvYBkQQS6o8TigNvRhvPynCwNauKlQQqQhxiiAjiAVzctM49xXj6UUucYsrfRYl/7fk3TRES0WYYeqlYbWZ44AK7Bd6mofZQtwN7MKKKko6BJI2rBe8mk/8hAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751358; c=relaxed/simple;
	bh=Vrq8TFknVqZqc/8JOPgG7PDUWg3gpVhuozznIWgm30E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W7zm/yeADNXP6tyMTsONK4RQ7Z4eUNVY2b4D1sUYxogH0HG41lhBoUclavHq3wPqB0xFgeLlyRMse1he8DzhgpbcX0iz2tdG964ce/Uj+/4k8g3ga5DTbM6W4vNphZq3l24D+ofEqIVyWtMG8J8OiNHFjH6fEWdXsBlMewSs+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GnTkp0nP; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GnTkp0nP"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484b9fb055so3134366b3a.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 16:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786751356; x=1787356156; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mrN2/9T5gE9eG4RGKPE/4WL0YOiYDGqFenhtgUxLKRo=;
        b=GnTkp0nPfxFYd7XT+TOl1JxkQZtAvFJbjy+LkqinG3KEWrfKxPcSeLUy5RuaY6uVNV
         oHfsgoLGNYYGtNc1754SnyobyjEXWIo74IDZLoXatblUCNJa32syuASyBi1L5jKg/fRU
         zxq8T5Ik2QCvPFZ4l7QNhAuoFxNwlIv1hxlj2LlGlrnLLGkmtJ46n6747aVFrizNBGdq
         gwZZ0JhXRDtkLDcaWp3aPiRiTddr0KTuXiENg4VKeO59InAw4dg5e9aqnLIt4LrAGdf/
         HUfS4On6Pu5YYU4J4F0spaQ64voa+4j5DgyGogjKfRkZfIVjfMgV4R2WxTwlxuFcnH0u
         JFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751356; x=1787356156;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mrN2/9T5gE9eG4RGKPE/4WL0YOiYDGqFenhtgUxLKRo=;
        b=segvXsExJVllk2aKNu8hgYiBPWVdQcdIeT4/wWQz8R2/Fzyv+ROsS1vjFM4D5pwjvX
         5Mkd1m6SOjaVJDVLG6gB2XygvSQesAZA1xph0k6v7o4ZKR+1SkhxbgmNQJ3XgT5pCV/B
         cJcIKl+KU55TJsb4rT3CzXX/cnpnLis+4IRRwJnCjwW1u/QMyqCc9w9ufaryXoJZxtTK
         NMcdWh7qDBIM0QOJTgEJP4tBHPcKWNkJtXHlqqphVABLaG01CDRdi4qyFxmqSSgBrby4
         Z/3MP9bvjQ5zif0XmIn5yOTOXRHm8HXO3z7KDkxDOj1CutQ/ifff+lR3VfxPVPaOgqBM
         gBZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqeWQoYy8LcXQjb7Y4MYFljzgFCBloI1Dzx0i0wQJo6Ut5Jy7fvRfCv8z4N3Ak+7zI7+nLtkRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymjCCrRfm6ETa9l2NqtZX0Bd7snQNHZIx5BTSwm6lpkQYn7Fn1
	ucLw5MNjBzJ76oQuB6OUqSXTAPyu+laVYzG0zA5lmLZmEF5fmSHwjnKPxPHHbwxM62ptwjrTH0C
	Q+j52VyzQ3Svq8A==
X-Received: from pfuu5.prod.google.com ([2002:a05:6a00:6f85:b0:848:4e44:7f19])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:850:b0:84e:5e4:b9a2 with SMTP id d2e1a72fcca58-84fde31a0bdmr8848385b3a.36.1786751355562;
 Fri, 14 Aug 2026 16:49:15 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:41 -0700
In-Reply-To: <20260814234845.773189-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814234845.773189-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814234845.773189-3-joshwash@google.com>
Subject: [PATCH net 2/6] gve: fix XSK buffer leak when rings are stopped
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
index db38bc645296..2c1ce23d1550 100644
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
2.55.0.691.gc56d675ccc-goog

