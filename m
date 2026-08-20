Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381533876A1
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251301; cv=none; b=J+SEcaaVjl/D5w/bj6JO3G0sp93r9Bw6EmvazjZOc0Y2VD/sZpa5eroB/+f/ycSeESJfICJ7TApSb5GR0RU2fYkQfGYT0ch6UyHOJUKmqnqU440zxHPWSUN/6YzkdG2YobNxlib9g+jzFmLm9+lpAxNLH2EYNF7WA+RSBRXdiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251301; c=relaxed/simple;
	bh=tNLgd/FfC4f53hgSjcu9ATEmRr5XYCTKBn1ygO83kDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkWnzKBmrIahie6SvM8DMhPI8ohMRw1/eYC/LMIV8wUnUAhM4PEtK3tSA7X2aF1SOlY+W4tmLxTV14TgVF+aizolRmft5wWTxMLqosQEk0ks/bH8htby5+hW4oFEkh7Db/NxDhvzWbd4Oc6JFga1br6J4MRcp5HT7oNxTtwagmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=VgfZFLLY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="VgfZFLLY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so3269995ad.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787251299; x=1787856099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QbbEA8njahnpZFXoKuwhGp1hqSSP84JqOYyTbSBwwxs=;
        b=VgfZFLLY8YiGUuaxsyeBoZIjhLzQkUj5MPGgUIl+EBkc/pj1xB/VFmDCC+j7E1ruUS
         BIqHcesTGHldg6IDJ3ZxLKltgB1KYP+YJSnWVnOVKWIrA30ec2SiGXETRUQr0zos2gbX
         rrmozKjZkdU6IVo5OX4rRo++qqnpq44534Y60+Gfvf/NBXlqSGuTBNYisUBHoqouh9xl
         Ug7ObTa9EPI+k6kSi1IpsHpSXwa35SEmP574CA3OwdmHQZjA3vo3BV80X1OTzl4HYooc
         VkzG/+X9TWjumlHH+SjX7sD9RV2IIe6wDq3+xeB7aggK+459Ijk9UeNmUq2AO28zONQM
         1yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251299; x=1787856099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QbbEA8njahnpZFXoKuwhGp1hqSSP84JqOYyTbSBwwxs=;
        b=UWiJlsSDZuqgQDNNih4bYJ6P1xgq8YqbA4XSGsVy5Ilai2AlCqi2b7Bn/55gNnZBma
         YwcS+9ZW/ywj3EXONK42sseLUO1Bf0neOFeDYjt61i8XDVc5PBCyu/ZXlyVPfy0GP+Bf
         V16qHHz7kGWBxJyOOwhSrGibc8R9SuqcsDJnFfr07E3SE4D5dOLHh8A+Yj4I/xHwIySf
         LUaiK3COr5h1TvmWDiGudjVwULga2SYNzqPeZaxrO8yd842N2OGn3dUEJQvqG70vQXJ8
         0wJ7NvaShSsDLyOhSI+7A33ye06/5aqF3ay4SolTXutug9yIKKQ5zNMtXxZBuEPfO7w+
         YZEw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/U1k8cPy4OlILSYp1uRH5g2iCs7kJkMXtADLwdc8HybiSC6fnFbArHKlwcXFoyRyP+dS+zPE=@vger.kernel.org
X-Gm-Message-State: AFuF++nq3B1pzfSvUzuLHMrD+Rkc2RIdzOWwsbnsZCzj4j8Lnil4rE5M
	6YswE2dQq/3eY3qMATHM4KHj1THLWwb0yTrcaa95KzIl0rLrRrE8qSpXIeLO420AOr4n
X-Gm-Gg: AR+sD11HH2zUJEYeMPhfYG29Nf2OTvbkNQJTGU6hlm/legGFcYWXpKOajjPRvZTXsHy
	zTWB01PoW0eqOW3epRog0HZKHLLngKCzfIISe7CY4nLK7eANQBypKqTEr4mt9XrNy3qMf9U4sW0
	tlE/bOJt5iOZZSFzLtbOVA3h8vN5KAE6xw9vMYeRYm48zaTh400SJ2gmSshZMCUm0WdQOjDu8zq
	8MlaSr6Jiq1kxnafomf3LayTHCfMQypnZKdHi3Yj4Kqo4tGwzldhEQQvlsxaCn8gvxl1OpT9DAQ
	3o4fVitw1CR0oOgFqxD+U2c1wMUSB167uC4jWPPHYM0JsuVwtHg81/Kvs8OwKeekytOOIXBkAF/
	Njbr4Tk1EQ/aC5cNPDq3gbuA5JqNVGiThdpGXn5M4ljM2bj4IbS0B0fxkgbQbEBtGDtj/+P5Uo+
	u2csav1yIAlwhlUMOV1ld163Sw8KKTXCSF46RX5fMDmIENvES+UAvy1OzmbhtEbO1o2QfmqDeRl
	9EM1UZjPXH+DAs=
X-Received: by 2002:a17:90a:ec8e:b0:38e:659b:f366 with SMTP id 98e67ed59e1d1-395c2f2d9d1mr1256800a91.0.1787251299357;
        Thu, 20 Aug 2026 11:41:39 -0700 (PDT)
Received: from gmail.com ([115.192.250.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c46b88e9sm20142a91.7.2026.08.20.11.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:41:37 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v2 1/1] net: l2tp: do not propagate multicast notification errors
Date: Thu, 20 Aug 2026 18:40:28 +0000
Message-ID: <54f48e812ca0424c47ffdb9a8182180921f7e6b2.1787247008.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787247008.git.zihanx@nebusec.ai>
References: <cover.1787247008.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tunnel create, tunnel modify, session create, and session modify
netlink handlers send multicast notifications through helpers that can fail
while allocating or encoding a message, or while multicasting it.

For tunnel and session create/modify, a notification is sent after the live
operation has completed. Returning a best-effort notification error as the
command result can therefore report failure for an operation that already
committed and can cause callers to retry and accumulate live objects.

Keep sending notifications for listener visibility, but do not propagate
their best-effort status as the command result. This also keeps the tunnel
modify command consistent with the other notification-only paths.

Fixes: 33f72e6f0c67 ("l2tp : multicast notification to the registered listeners")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - Extend best-effort notification handling to tunnel_modify.
  - Follow the existing bare-call style instead of explicit (void) casts.
  - Document the observed ENOBUFS and committed-state reproduction.
  - v1 Link: https://lore.kernel.org/all/cover.1786962220.git.zihanx@nebusec.ai/
 net/l2tp/l2tp_netlink.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 59457c0c1..fbdd3d055 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -248,8 +248,8 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *skb, struct genl_info *info
 		kfree(tunnel);
 		goto out;
 	}
-	ret = l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
-				 L2TP_CMD_TUNNEL_CREATE);
+	l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
+			   L2TP_CMD_TUNNEL_CREATE);
 	l2tp_tunnel_put(tunnel);
 
 out:
@@ -305,8 +305,8 @@ static int l2tp_nl_cmd_tunnel_modify(struct sk_buff *skb, struct genl_info *info
 		goto out;
 	}
 
-	ret = l2tp_tunnel_notify(&l2tp_nl_family, info,
-				 tunnel, L2TP_CMD_TUNNEL_MODIFY);
+	l2tp_tunnel_notify(&l2tp_nl_family, info,
+			   tunnel, L2TP_CMD_TUNNEL_MODIFY);
 
 	l2tp_tunnel_put(tunnel);
 
@@ -645,8 +645,8 @@ static int l2tp_nl_cmd_session_create(struct sk_buff *skb, struct genl_info *inf
 		session = l2tp_session_get(net, tunnel->sock, tunnel->version,
 					   tunnel_id, session_id);
 		if (session) {
-			ret = l2tp_session_notify(&l2tp_nl_family, info, session,
-						  L2TP_CMD_SESSION_CREATE);
+			l2tp_session_notify(&l2tp_nl_family, info, session,
+					    L2TP_CMD_SESSION_CREATE);
 			l2tp_session_put(session);
 		}
 	}
@@ -710,8 +710,8 @@ static int l2tp_nl_cmd_session_modify(struct sk_buff *skb, struct genl_info *inf
 	if (info->attrs[L2TP_ATTR_RECV_TIMEOUT])
 		session->reorder_timeout = nla_get_msecs(info->attrs[L2TP_ATTR_RECV_TIMEOUT]);
 
-	ret = l2tp_session_notify(&l2tp_nl_family, info,
-				  session, L2TP_CMD_SESSION_MODIFY);
+	l2tp_session_notify(&l2tp_nl_family, info,
+			    session, L2TP_CMD_SESSION_MODIFY);
 
 	l2tp_session_put(session);
 
-- 
2.43.0

