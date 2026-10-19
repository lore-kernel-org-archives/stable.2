Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792435740;
	b=J4mnDckfRSn8Z/j458EDaUiv0YhPLVQkGuoPhNpe+D2xYgqpOmB97e2vp2SAYKAiLISC
	 lV3wAoxl0YS+92RqrQSP/tDtV1vcZtYSvhTn/3L4TYLaF5DVKz37zVIkOnGpnMXFR71DD
	 pylzumeHL8XbClJWrcyRGhS4l/ZyQlEmqsoXujaoJ+72Ku4MIiS2tPR8UVBg4nFes7KIr
	 bmlL5Gh/sn9E5/mHzvDqxv0EJADjIW5XwbJrhg4Dk8t3onQv/rm3C7dRv3f3P61RQoYF6
	 +qGn9kL5gaGJujIwgvOjVfNWimxSNJM7EeG2WUWqdULusUh0f0jNdxzHeyx5nXCmH4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LLSI7PktqOCoaAdY+nRTbxlJri6KWY7IdvuhfDd+3gM=;
	b=lPnz/m7bGSN3BqZexj355y2neL+L8HRfsEx35qiaEdLv1i+EjLlqXtFoSzqHbR8RQA8q
	 c7M+mQoXovuVl9t9uatm8GeuUEvTlgheY+nZCMgnrJI5ZywOZc5Rvx1XWQxYj8FoY0Ii8
	 gtaL/9c/HQAEFXgrx3+pdQVQh/Us28WojgmxphR+lp2t45JhiRru/LlMlLJCdAcXSA+kU
	 vyI3PWsLpqvxbPFqI60U1Dqh6o5xDlAO9GKPyXRoYBCCBGUOhSTYslpkoOPk1Vrjqq3WB
	 1HQNldUfRDsmQWul9rJoesPUvXpfqF1JUdg2Ytz8o2hKo3NFpWfEX2NsxDVVLm0tSmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=U4ZHCe5N;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ADE606A31B
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5ADE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=U4ZHCe5N
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53644ab1f7bso21429631cf.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792435739; x=1793040539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LLSI7PktqOCoaAdY+nRTbxlJri6KWY7IdvuhfDd+3gM=;
        b=U4ZHCe5NO6N+hQbi1iEFnMsNMJoMSf3gdmKTzm4rJN01YlfmjT42JsbW+9aOcVaP1E
         K/GcbkOGYXM75il+9cB7zF9MIGTjM2ehLhZdjZs+0sqrGeSF2h332E2jfN2UgPIp4b1/
         8AvC+3ro+a8aXwJsjMe6IjzPXIftsFduWqnIFbClS0D359WMbb4ZquUeOlDIItJiAuyl
         ML8gFFl4E7qw+8cfR6AzXAPn73IL0IdXV/jsO8RNITQGH69gh2denSnriW99kszKrm6b
         GMOKybKDCa22Ns4t/TtQOPUfDQ2WPFKHncHzGU+Bhsx7BUv8jl9YQw7W8wBYdk/j41Rw
         2Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792435739; x=1793040539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LLSI7PktqOCoaAdY+nRTbxlJri6KWY7IdvuhfDd+3gM=;
        b=cGSjvIs8xnPRYSkHUZ8Y2VlqS6rWZ8Hul1beH+sJFFy4LhVRMPzw7ORGV2uSc60DER
         n5EPYYtx4AjP/zul0SeZUy+YJHx9yB877xGv72pWzHs3tiyUd8CzYtlxSk51Eei6IBw7
         QHD79+Jxpc37skshcTgnMjxLI/JrzE8C7Y6dbYSn6KzmIiKRB1ilYSkdske+NyBUqPGv
         SDuu9eQgZLKs39e15LjOxsN37c026vBpF5bfpvjsCf8BsNiw1mUyQ+fr5Wdub2NgGXBG
         fK8Tje2z7jNHJDrGmu7z6GMMIFdqJSsc/loajUOeVcPtuMhYgaKr+umz5teiaGUft2U0
         3nsg==
X-Forwarded-Encrypted: i=1; AKwUvBwARFYMEuhKMIvgyye2GEedXU9uaWxrTDnsrl70ua5ccM7lntV1BMKkFIIpLdtLo70ujVP4yMA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEAtnv3hqLlTIUtPqdJA3J8h0CkNzyBukjNwtS7VncD3SLCx4G
	jjS2yq91Qqkicqk+OG8R3rzU1A+5e17SMzon340LeSI29CYL7cX/xMR+bm2SyyD8MAA=
X-Gm-Gg: AYBFou2vQtObXIjo/A4dhXEptJ+T4BChTLbLz9v2aehwvEwfZlDtlJxFuWPT6HZSzbA
	sH4+Y9b3q9L3c4ddbKenS+QUqT5DyIiuks18SbaaHSjf6j0KAUerAjZJwx8sjV1SXUErNT/HkES
	nQQ/lm1030oDtwtqiY3R3ZHzASfjD89hiG3+p2x4tPz3J56S30UW24frsIsCedEYVDtKKrvfPHV
	wWiIAWylAzzxlU5lDHwGJORX6cHzB5/4zt5YQ08MV/aHtHjg5yt6mZa+hCn41QdFZdj3ZYDFQPG
	rAv1azi7RNkpMZwzlOeUvFcr3z4C4l+AKnDhimTn8KZcRrCsxp5QIk+hUM55PCEQ5REHwfOJhqv
	CmE9sISqqP5fK7a0PH9tBYFdDlT1kjMXtGs4NqRpnhp/hRasxW0sUS6JDpvLPkK3Vj6muXoKVjr
	t6OG3TRLCpc2zM3TwF2uG723BgGoJJ+zVHUIw1gkQaMD1TOEuNPIs3y9xmq5giJoegRDN6TfCp8
	xrUE59aJ64BRE6FO3GX1j+nHccSNbEduHKFkVN6qupz+2mFuqLS60V6OUrO
X-Received: by 2002:a05:622a:401a:b0:536:5e83:589 with SMTP id d75a77b69052e-5365e8314cdmr96885911cf.71.1792435737103;
        Mon, 19 Oct 2026 11:48:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040a49b4sm3183196d6.24.2026.10.19.11.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:48:56 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	flyinrm@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] mm/page_alloc: let the highest memory node recover from hopeless state
Date: Mon, 19 Oct 2026 14:48:50 -0400
Message-ID: <20261019184850.3427905-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
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

free_frozen_page_commit() clears a hopeless node's kswapd failures once
its zone recovers above the high watermark, but only if another memory
node exists for allocations to fall back to.

The test `next_memory_node(nid) < MAX_NUMNODES` finds only memory nodes
with a higher id. The highest-numbered memory node therefore never
recovers on this path, and its kswapd stays disabled until reclaim on
that node makes progress and balances it, or demotion is re-enabled.

In many cases, direct reclaim many never fully run against a lower
node (CXL/kmem), and that means its kswapd can end up full disabled
in rare situations.

To reproduce, fill the highest memory node with bound, non-THP anonymous
memory and no swap until kswapd gives up, then free it: /proc/zoneinfo
keeps showing node_unreclaimable 1 for that node. A lower node recovers.

Count the memory nodes instead. Adding first_memory_node != nid to the
existing test would also work, but a count says directly what the check
means: some other memory node exists.

Fixes: e7a5f249e6db ("mm: re-enable kswapd when memory pressure subsides or demotion is toggled")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 417c427b196d9..6d4f03faf96ee 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2929,7 +2929,7 @@ static bool free_frozen_page_commit(struct zone *zone,
 		 * kswapd work again by resetting kswapd_failures.
 		 */
 		if (kswapd_test_hopeless(pgdat) &&
-		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
+		    num_node_state(N_MEMORY) > 1)
 			kswapd_clear_hopeless(pgdat, KSWAPD_CLEAR_HOPELESS_PCP);
 	}
 	return ret;
-- 
2.53.0-Meta

