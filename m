Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636663;
	b=R5dYHO1X7pgCFp1bPbb9A/o2UME6XjS9hqORVmrLTrH0ZJd4Lcsd8Bf/0K0nIsRkFFOT
	 6BcefLf36VSUsNFSNUTOJI7nBhLOm66Ka/ck73mUevaSrXvgxBp0QJG0zr7J+wevLbn5t
	 vq2kxX/OwprSSnPkblL9LyPntQ/cASYP9JXohRJFHIzgioqNwA9WcYta1SYjTrIt7EriK
	 JGy9Jd47T+EKL83jl9LKF7QolDfgP9nhV9hZpkz2wK6CUIE/xT8EtqfaGs5knaINelyBj
	 Tc3BkcRwuegFlyU6vfe7UC4dtbFtQkSPtzRMW4xdi+YuZinfNjgUpviEpUTLH3D+HOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z1Ch7toSay5RAO59Zv8Z5BnunRVmaYyzvcole42LG4w=;
	b=DO3insYLf4wsH7hYbdDOtzgP5OdnDhDq6nEn55RRn8xpH2032so5n2uCSwfw14x6qomq
	 p8LIrCNILcMDvyM9aqw257FxkJEPdb49fjeQrAFHBqei5IjnNmzjnRRKzrKrUWmlSpONa
	 m35YhOKj1GLq9p+Nxs+rtTW7HVyoltikPd4O/uvTTKa1eV3BB5aNXFaBl2KvnPHOZdPlv
	 056eDdyDT4R14Mm8TELhzwTKCioXNh/ATQ8N2O3uCBJ88gFWWObhrCL9suKoaamXV5Tkg
	 v6mLpjZ80C0D84qxeQdFJgX2JGaPfbIURhrjKkwJcgsnGkqMbJa6YAqd2IqcoWJoVHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=gLTfcdye;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B9606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E10B9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=gLTfcdye
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-386bd881d39so5353080eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795636662; x=1796241462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z1Ch7toSay5RAO59Zv8Z5BnunRVmaYyzvcole42LG4w=;
        b=gLTfcdyeliU/SIidmo2Q2PGx6AFjKRsUwtBbq3c9NxKgDz42m+T4bgGqZ+DyDy15la
         KRvi57AXHY44tFkHqpqhRS9xSgEhEERs1/HsqhKHlfJYr2uPa5zshTkMlT3RKIkM3Eo0
         1CIKE41Eiubwc3L6p9mKeTth3O6RWXBnDjzS8XzyNFFP7jAxJuNbqkgSZO114T9vIU4n
         tR8H6XGjr8Ob//tNrYCJ0CETIvvzvl0vFELkU+x2b6RBCKj/CTgYLjr65iXQpE0iybzX
         DlhomEGjt3jgxOuL6OsCCm6m8TBXaEAlIN0CVUBzfP0ca7itmKNpx0NlA4pmlHxJ9SpA
         bJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795636662; x=1796241462;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z1Ch7toSay5RAO59Zv8Z5BnunRVmaYyzvcole42LG4w=;
        b=i4C1FFjUyVheI6xI4+EzZ+19WWigAL7CyxAPc0+St946/fm1ieXzeZJho8sEyQkuGi
         nM+xzrFQulYsU8ZTQAC9g4wIXSopuhudv/gmUYwOVl/ET184s3OCZPMWjrgNnTtNBhDM
         5oDMKDaKm2JmcJXKVDm4MUptXV+VnCNJWe/esAVikY3eyA6pNYyOCIVe1HUCFfk0wFIF
         +VQSEVzcYYUo5YYk8rwgbcBjd4hcMNXsDukLIv2nzyqyFmQepSCN2POueFZ85kgcPBRv
         bo4wzLodjzZDFM6wDj5TJd6QrsMpp/q22L9D7MhGP+KB60+mnN385qsgKlNXhfSrhTZJ
         NRzw==
X-Gm-Message-State: APuU4Z+6hJ8FUxhfTz1ZV6nQ9wVblq5tHSKCtQBTkgc8GQJgEQQ26XPP
	ybJ3LBvRWhK90ZHIrPx28fHnkqyBXJKlNsCFY074RhF77hUwSPY/gadsC5ly0BudEBIZM+Jcyuh
	Y1w/ZVNs=
X-Gm-Gg: AZFdTZfy4LyfSVUJgAOxMGdNOc7MKvOMz/FdqhvURltgdfSlZjoWgVfSVDA5PA6B8Yj
	SH8rJ+ORqPr/9q5ZHURUOvlTgpXuG1yQ9M6Zwvqcv/PwXy7nAUTftvrNn+ky870a/l5KZegk1Vj
	C/SVhb1YCXDz3bZq4ne3OUXTXSSjwWyNX/xU7PgDNib80A2wo38j04NxCAvCZ7fNbMiv17eg1zH
	Vp/lxZH+/S7Xjx+hrXqH7w4qVxtTK//bHv4mjfp316iMaD5+27i2MMW6zhFt8KVDPM2MlHcXW6T
	bLU851S3rW20N0uy7CK4X7u7BI5eOWhy7L31II/Qg2qgMYGKySvl5kT/hWDqeYhyASDU4KbsnQY
	MoIKKuLLbqNPi4JaU4LOSIGiBxRrwE+xgtesSsFuB9OUOmN+lZgungZxrEAI9KZgTQPhWlD6T5J
	j0GyjNZIBJfa/wTzusE/fibhZrW/V2DziBXMEf/L9LgyNYrNLBQtOjWAWFKz107w5SX3nca1W7g
	n87aRm3bvOoqzk2apR6cQILgPc/p+lbgsSy4fI0J0/u+DDaBEjIqIc4wzLm8g2HD0Qaa2fOJYRa
	k5vnSfViaDqro2oG4qUF6p0DlGhYCRA2F91jqpdq2fe36OGUomUTXChthtZ6KaDoHuJIAf0EGS1
	reGxlprySD1/lEQ6WHUgP0k7hjA==
X-Received: by 2002:a05:7300:8811:b0:386:d86d:d445 with SMTP id 5a478bee46e88-386d86dd49amr1569803eec.36.1795636661951;
        Wed, 25 Nov 2026 11:57:41 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm59596522eec.14.2026.11.25.11.57.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 11:57:41 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH 6.18.y 1/5] net: init shinfo->gso_segs from qdisc_pkt_len_init()
Date: Wed, 25 Nov 2026 14:57:31 -0500
Message-ID: <20261125195735.57472-2-artem@trailofbits.com>
In-Reply-To: <20261125195735.57472-1-artem@trailofbits.com>
References: <20261125195735.57472-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Nov 2025 08:32:44 +0000

[ Upstream commit be1b70ab21cbe8f8bb8ecf39eb34880882252773 ]

Qdisc use shinfo->gso_segs for their pkts stats in bstats_update(),
but this field needs to be initialized for SKB_GSO_DODGY users.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20251121083256.674562-3-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e4216b78a1a4..97a6ea8fcede 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4126,7 +4126,7 @@ EXPORT_SYMBOL_GPL(validate_xmit_skb_list);
 
 static void qdisc_pkt_len_init(struct sk_buff *skb)
 {
-	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
 
 	qdisc_skb_cb(skb)->pkt_len = skb->len;
 
@@ -4167,6 +4167,7 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
 			if (payload <= 0)
 				return;
 			gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
+			shinfo->gso_segs = gso_segs;
 		}
 		qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
 	}
