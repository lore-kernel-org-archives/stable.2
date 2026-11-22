Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795317119;
	b=1LFzR9fx5p/nz05iK67RmHUzIO80qKeQhOD7hJPCMrFzfR2Lk2SOZnZTXHaXr30sYeDY
	 m5+KncONdkmXmDWz50h4rSv69vG4tWHwdMfz+M+XebxyOvKAR72rz53NS9Rq8/ZHzjcjW
	 mzsetAklgaSn9wfufAZCM8fIV5biIubjSbjSQOpGJq6xw0C755TFnEVFjSYyWGlLShHqu
	 2uEM0zLO30iqDp0anibAB5X8963zjWlsDTeqx0XkEmTMczYe3L6woI+/ZckhJhzhLLjB/
	 pIqEBjptZQ4OWWu/YGwlpOOJAkruxCDQpRc+IpDHO6UY4yDWOPvs5f6noyQIDhUvtOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795317119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IpHMT1aKbS0JPzBe96t3VbdCaL72EU/yPMiajZoaSaQ=;
	b=t6MBYOiYTGqTRVGLVcSjBG58hxcnjdzHnVF2eWzphmI7aFvcfxlXPK4W5rFkHoHY/CVv
	 UxEPxgUe6hGlxUJ/OSK3k9/tf874ZBUBkZ//ZUyzjE3PtLo2BD0XyQhHIzmJxdu++I3y8
	 fto6UVqMM+kVrK/qWBvwybHFQyr3X8KcL3JTX3Gwl71CikyDqupEY2642lWozanieSBbY
	 ZLbcMeV+MJxyYZ6K+M95c0bXzkNQO1DfauGXBeUPRKjPD4181YSAQZi8Rurix7EMxg0XQ
	 TBRO7dFdvk+T9Zp5hbKJGI9B0VTINRmJStimzJZdUtjoF8Chf2q7fBJa6DL34t9l5Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hSDAloHo;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41E0606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D41E0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hSDAloHo
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso835167a12.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 19:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1795317118; x=1795921918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IpHMT1aKbS0JPzBe96t3VbdCaL72EU/yPMiajZoaSaQ=;
        b=hSDAloHoQXy/vUV0vWuehSwUTVKUbdpK/TM4bU3pCoTq0K8b7RBHC0xs3JW5AOEpuN
         2RqxGtrLkWi/mHsvgtuNI8ruwMR2hcqmRyKXDVYNeeCF3ChE08UUREQC2yjuaRRlPZAC
         mZjZ4mVIQR22fwQ5HtBk8Eaboj7FeguYkNWPSZMEcrwg4JkqEP9qwnLy2soQNqqPNLky
         Olu5Z8RSCOm/PFofQgRT2ZUNuTeAFCXV9cMjoasepfkH7H/Yse6aT+VWBMTmS9qEjDET
         syMFYOcyboZj6I0005C2lUMJKz9Auk9SVoBnuy/EcmQPHzP9ugLnsiXtDwNdfVsRYheT
         GXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795317118; x=1795921918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IpHMT1aKbS0JPzBe96t3VbdCaL72EU/yPMiajZoaSaQ=;
        b=mWczI/KoJNLS6OtuESUfEpt9WYsndDmQqQwCPHI8IdklUlBlRQWnLTRFgwQBKqGhP1
         LNn5ICwaDvaqox6tlkFqEcJTB1GAbsH7aYzk1ZXJ9WoaYrp9XheTiJE2+Ryomu8w8xgV
         uHPVGus8f7GpBrqWQEYhX2BtrIXouhxneAjrSbqqxZRp+UeVGS6KG4CoQJQ0mygiDp7p
         CsnTv8lWFZOhIZN/SObSM1Ob7kN0ZBnUhgCDbXMdieHYaSwfdtzePMpjdBphCXaBq2bT
         7QV5daaCC44Wsqp0o3SIPmDBwVcAXMEgT+9rGwR5cV6W6Z8tHK0dyzgU2vk/FCWIlfR1
         byVQ==
X-Forwarded-Encrypted: i=1; AL+hErFehVHmz8Z/O5oWW08dpS1y6VXtGvUQvB9xj8fYenfc8tVXcLA13pH4ZXEqNSKBL7F6NZpQua0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sbwVhKkH07GLrREK2zTpA+p+77rqyF9EPru8HKX5C+YSGVqZC
	sfBWptVMCOrWcNQWpCHFcqhRLBULo1++c1my3AhtPh9vqRC9yS9Z14YlBBhRQCYoROA=
X-Gm-Gg: AZFdTZf4ltc4sm4bRFEyWN855kGhPLfHLbYWVgxjsS7tMFwJRdytPvS5E6Cf4NOa3Mo
	Fy3JJJUjv6FaWNm8UBNF1vKYzbzOBvdnryLr0IdU+RWn213TZB0dSWniQPqM2BRC51c0g/h3a9B
	3kc1gf6GgxIjWiVbXf5hhQlFEU6qTXCErN1cpuHKk8sVGS8jPjrNNltbKIXSbmqLOBOEmnVdD0U
	b2qhv9CN8ErwwrYL/IlYAqsECfqH+0yzmjEL4+VgibK9rPCKc1rzcdtSb63W3/dtTq7WG/CBjZ/
	aahgjrlvTKfaSBnAVzSxRaLxW5U6mDx5eAvBBp7M90a8sCF5LJI1Z0BAWORomtyGcP2SAs2FdOn
	jFALgMg/de1yq7MwWXqwmVsQIfk9wtKPGBNUCNWE8uHqM5ut1ONb1OZD7uxVtraczQLNIQ+vH1g
	ERDYsLqTjnQkzXzdzgDGW558nZHFexPV5NeM9qoMW4rOPZ5dsxDWrpGOBYHq5VAqPiGQzLsMD/U
	H9ya+fF06cVQAMqByNWZcQjrEvCCvPPVoPs/zbV6K1v5vWsj2x7rSgWbJHzCqwb7WiQ6iMgAF+0
	3OyrOrrIY4dsED2HgTyuKusNrp0Y/EclSDIh7yiQE7iTuHIbQoGP1MKP4Dd7iFAtH4Xyw8M=
X-Received: by 2002:a17:90b:3e48:b0:3ac:a521:95e with SMTP id 98e67ed59e1d1-3b41c94ce48mr6842201a91.47.1795317117866;
        Sat, 21 Nov 2026 19:11:57 -0800 (PST)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm13627149a91.14.2026.11.21.19.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 19:11:57 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>
Cc: Qi Zheng <qi.zheng@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] mm/list_lru: fix potential infinite loop on xa node allocation failure
Date: Sun, 22 Nov 2026 11:11:43 +0800
Message-ID: <20261122031143.3639941-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__memcg_list_lru_alloc() populates missing list_lru_memcg entries
top-down, from the farthest unpopulated ancestor down to @memcg.  When
storing the entry for an ancestor (pos != memcg) needs a new xa_node,
xas_store() sets XA_ERROR(-ENOMEM) and leaves @pos unpopulated.  If the
following xas_nomem() also fails to allocate, the inner loop exits with
the error still set, but the outer loop ignores it and reruns on the same
unpopulated ancestor: xas_set() then resets the state to XAS_RESTART and
retries the store.  A one-off failure is recovered on that retry, but as
long as the allocation keeps failing, e.g. under sustained memory
pressure, the loop makes no progress and, with no schedule point, becomes
an RCU stall / hard lockup when the caller holds mapping->i_pages.xa_lock
with IRQs disabled.

Stop the outer walk when xas_error() is set so the existing cleanup frees
@mlru and the error is propagated to the caller.

Fixes: 28e98022b31e ("mm/list_lru: simplify reparenting and initial allocation")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-21c1dba9-8d6f-4368-b38b-9a57cacb056f
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 651983d0bf8b..1e0ea7975acb 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -626,7 +626,7 @@ static int __memcg_list_lru_alloc(struct mem_cgroup *memcg,
 			}
 			xas_unlock_irqrestore(&xas, flags);
 		} while (xas_nomem(&xas, gfp));
-	} while (pos != memcg && !css_is_dying(&pos->css));
+	} while (pos != memcg && !css_is_dying(&pos->css) && !xas_error(&xas));
 
 	if (unlikely(mlru))
 		kfree(mlru);

base-commit: 7d1a16abe4cc5dccd21e3d6262e44433a5885d27
-- 
2.54.0

