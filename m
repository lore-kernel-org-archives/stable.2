Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28353A7F4C
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786399843; cv=none; b=I+Usmif1SW0salvH8rCI2ivqD1wycZTufg8oA0Rygh6nceXRCcz0QnpawMmjVsOuZPj/CTLLkWHILItDomXwPRYfIODSjw40MNu445gJE//veTPRU7dBOtjLLpoHzMAXnELgwxYTsEjGzMwibTrjaDJbD6hp7JQx71f65/O4WPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786399843; c=relaxed/simple;
	bh=+vyoAMTlwmEGbof4bMxmgk90RIXqVlKcKeRZlqjp1cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBwHbJDFg+8RPm2PbMwvaeCgzlJ8RFF4rIFIZG7eJBdsWRrLPjPSXLqN1QOOD9jMlxrHxF3qSQDuBOhWSqQPoPXNXThzpaXLWNvhBOR+n0sfTbhFLJJLFoAxjolwvr/SgIg8J9OqXWD5sk1pLcuKJ4QFq3Ej19MfDuGD28pzO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=OGP8BmVA; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="OGP8BmVA"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso3029191a91.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 15:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1786399841; x=1787004641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMn9iDYzK+mzxIlQbYoX1t508noteCegqfO7arIOGKg=;
        b=OGP8BmVAJGzyRO8M/zxWo5ohbf41WJXFwU70H7eMQxXovcMWr1hAfF6g8avV+WuB0i
         MvVDmyLv01NZeRR+S2TFquHl2TehU6PdyT6TzJj4XXXhDMkNGRuXJnEPIwB/+sr7wXVv
         llPg/ieZPvXIB70zAGs+BGpxPkiMiga1ETSKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786399841; x=1787004641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMn9iDYzK+mzxIlQbYoX1t508noteCegqfO7arIOGKg=;
        b=lBjn2bZrTsGG1EyD98/uuycZR2+MlpVyfKWzcxUFX5e/t8sKr7SquzH5V7Dyawri8F
         MXyNFKM4TZjVJES7bb3hm7jVX6JKzT68FDhNuFPpDJvoP5TnsOuRXsmRXUpRtgNE+7LB
         vrfVZYE1/oRYwlYstNjWyA8NcIVcaF8IquHIO5O5g/mV2KItdchYx/JEcvjp8jjoDEy/
         FULM5j7VMVr/OsGcLcNj1sNMhHddGzhISdYIe0BML8cKeHmPLCihhhPK8EQ84tYxys41
         joSfRL7niBreXHn/jIcjx0z+y0W27HzN4f/p1bDScl9gnNErPCE+7qUCaFKko1YhMnvj
         e7Iw==
X-Forwarded-Encrypted: i=1; AHgh+RoYonV1fcUupHhc/KCHxbtlcEE5PimCdmP5xghHNBa58TvtmNCDOdsOlArJY2vpUAGLIhFC9sA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlm1iwzI81PfEIS59kmOfAkYapFwW//a3nkGiDOVV00dlfZEs6
	t+bz0ZnljIekPQ9NMCL9ZlPRkxfWGi22Kb6xsH9jHRMd40s/31ReyNBOR88nj/VmLHI=
X-Gm-Gg: AR+sD11Ie4gHmEVb4mXYwp7AOKn2vXnQ/cwOCxitP7nGTqzmG1wVo+bQVr5iz1SHR7S
	GKle+DSF2GrJjObqdidyxPeWl+aE5kK7NjjLwzNJtFHIK7pjeg4OIbebcPainH8uyAJ/y3ZbILT
	1kUHdxXnqLHcuO9e8S0lMow5lh+X8yC9Bho97nYhAUezqA61sGY1L7CNIFHwSLJgNMFZQijAoqj
	j/m7krATZG0Uv59Xxa/aXORVf40vhidkibdfB2szBMJYtUca37/uivAPZAuUnnaBJBOuLJEHRMA
	5iOCuIXd9eevbBdy46m8ElA/J2V5WrSdxLx3wTSBT+hCINtLB9qUOK3mLFABf/lyylup4UWSc8w
	X8Gc6Hvr8ZhR0QgVHFWAw4e2KKo1c3ssertUoGbB7ipVCkZsz/ZWtWbDEzFnDvbzKrP22mS9Lhg
	Nog4qZcZuLPlTRuOSOFOsDkeJtok14ja5nay5IabMSqvCLEq3ARngcHOV5k7qDRjTlz8ICpAmut
	/rypQlIJi16E+P2Uh9MyEcYmjMUHtwkH4t1T0phG7JobOZt34iITDvLt9tYrbtK
X-Received: by 2002:a17:90b:1d47:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-39261f724admr30384368a91.1.1786399841085;
        Mon, 10 Aug 2026 15:10:41 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7b39bsm38509700c88.14.2026.08.10.15.10.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 15:10:40 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] ipvs: reject invalid states in connection template sync records
Date: Mon, 10 Aug 2026 15:10:34 -0700
Message-ID: <20260810221034.33751-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPVS sync receivers validate protocol states before creating or updating a
connection. For connection templates, however, they only log states outside
the template state range and still store the value in the connection.

A template can be returned by ordinary connection lookup. TCP and SCTP then
use the invalid state as an index into their transition tables.

Reject invalid template states in both sync protocol versions before
looking up or modifying a connection. The version 1 path handles both
IPv4 and IPv6 records.

Fixes: 275411430f89 ("ipvs: add assured state for conn templates")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Kyle Zeng <kylebot@openai.com>

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 93038ab..6f0c2a4 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1002,10 +1002,10 @@ static void ip_vs_process_message_v0(struct netns_ipvs *ipvs, const char *buffer
 					pp->name, state);
 				continue;
 			}
-		} else {
-			if (state >= IP_VS_CTPL_S_LAST)
-				IP_VS_DBG(7, "BACKUP v0, Invalid tpl state %u\n",
-					  state);
+		} else if (state >= IP_VS_CTPL_S_LAST) {
+			IP_VS_DBG(7, "BACKUP v0, Invalid tpl state %u\n",
+				  state);
+			continue;
 		}
 
 		ip_vs_conn_fill_param(ipvs, AF_INET, s->protocol,
@@ -1162,10 +1162,10 @@ static inline int ip_vs_proc_sync_conn(struct netns_ipvs *ipvs, __u8 *p, __u8 *m
 			retc = 40;
 			goto out;
 		}
-	} else {
-		if (state >= IP_VS_CTPL_S_LAST)
-			IP_VS_DBG(7, "BACKUP, Invalid tpl state %u\n",
-				  state);
+	} else if (state >= IP_VS_CTPL_S_LAST) {
+		IP_VS_DBG(7, "BACKUP, Invalid tpl state %u\n", state);
+		retc = 40;
+		goto out;
 	}
 	if (ip_vs_conn_fill_param_sync(ipvs, af, s, &param, pe_data,
 				       pe_data_len, pe_name, pe_name_len)) {
-- 
2.53.0

