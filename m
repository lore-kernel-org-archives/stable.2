Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222385;
	b=XNUlQ0LHAZ0V2phEm7RszbBAOvjI5PRVNcw/eUGhTJZKD4BHvcbKmMcEjubRPfgvsOSs
	 CC2K+sJOwmIkIwbI+TUlZoprD3QuUUK0E6NoQKj8AMZAIzNYTeC1JW2MRjhy3Mbpo64IM
	 mUV2wHSe15J4JHpeRbt98Vx32A2LZRtodSNFZOJo7nFAjbYXNMXhpUQ9k086CEVtFp06t
	 Ep/4n6cPWnMxfOE3oqkFL8ARx9n++mrdXr6Y4GuiNvq0pFa5QRIgUwf2xZ8I3SvS6A8jz
	 /4RVAfbZ1pC3mB8FXKQFrX5vAYmSuyPMVfrh6Ru05p2evkYgReFvs6j2UUAkIIuY3kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RAcEs6XFMJPdLRK7Qq6ZCf1PAdLxwqRv800fWic7tw0=;
	b=ABXCsqXbbQLrpO7AYEGA8CXnLyy5rxWMBl1UKeRZc4RsaVKNVp0+CXQQ8DJxjWlEsBmf
	 T/hlB7WcAc7CjbwQEqLhKAP5DIdTWcEhqJKZNq8nBIt7UDmbgSlNDD86oABvq2pQLjoEr
	 qkR4U43aV3qXmMVrvxlhPv22HzFyqjeTSVDU6zNF19MddqDXcZ7ZcvFL79Q5MWVVEypM7
	 tBVslNs1YV7OrK/be/Vd/MDqF2e611CjySuR5gntBd1P/bdWCjvOLARag8IPDtezYb4fb
	 wlxmRsudLqbMWU7B/dNQ23eVstJV4KXxs6GWtOigLfgHhWslSjZY2829Cs/I9rh4jUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=tnG8wVFH;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196D60A3804
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0196D60A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=tnG8wVFH
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c7a706b1fso1349606d6.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793222384; x=1793827184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RAcEs6XFMJPdLRK7Qq6ZCf1PAdLxwqRv800fWic7tw0=;
        b=tnG8wVFH4NLWp9aJT+EUYbhzQF6Ujc6IyXZlUanZKP9zUdilvBGVN+6NDyzOk3Abin
         +bxMXs49MeTe89mMu25saDec4vh8EC4/ZWO3+rTC0whpv0Ev7q9ShrUMXMciN10sUONH
         CC6siFQjj7jc8zir5yQqIJlJrHJDYwhV79/aFxkoiDpsHcCB+ZN6GObu/toWd0Ih5a2N
         aRb+yFLh6HWA94zQ7gybUGhrEclHyayErZGaCgnAlTh6nZRNS/oOYiyu6+rTrblYM1ry
         o7b9f1neJs6YLEM1qfA5aPOFpdJE/tIcIzeHpsLajfhf+5nm3ZxyBbRBWCpudNuKFEOn
         fryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222384; x=1793827184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RAcEs6XFMJPdLRK7Qq6ZCf1PAdLxwqRv800fWic7tw0=;
        b=JDY/ey53N6Z7w0HbhzOYvhWRh0idDyfGpq81EuuNgejWwyrNXoTlvV8exFIIbZI9NZ
         5138E23sQfzqFw2gwIdVgQMT2OiQdfWFsoK7M5ow98p+wtd36JDxMQPUuxwWYsrbMgoQ
         sDFxWUPXocnm9t1Zt/hMVYWgwrlZsIxA2+VZDpfparn6R4S/iTx51AsPn0waXhXumtWZ
         MfSt+44lq6pllg6OCCE5ph4dXdJvWWNfpzkWUEIoOCEaGpYYifigEeIVA4SxHKf6xa6m
         39vnZDQgH1zpferEtJoNRlPk0rB1eCq1E1UweqiBu0wH+v2FeEsohlYqMwcKmfvzjkal
         e9SA==
X-Forwarded-Encrypted: i=1; AKwUvBzjqKGg/zcbhk9zTH7dCicPgygySA5HeJlduAubkVKgENgW1Up5+s0wM5a4cwwb54MzUqivML8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhlLADuEz6EehcDmEiTSV8h9v0eiW56aGqVXEiVn0ioz3MFZLI
	FPSdfQrxRwRfOuXFzwTnpNJmBzdNQjrDDLOlmKJqWJTahOdAkk+MV+exP3KOZR//z0o=
X-Gm-Gg: AYBFou0xXhygZ4UpLn8rmFzs06daaoIevJg3KlpKq0HXOlycinnmWKpK55mxu3DPEet
	ED+Nfw3I7zzm7RFvH5Iq+dkfQAtbP+WJJi5LKxFSYp1eUl/L0RrVAK1BpXPx5V+m1kBH696xruc
	ZWJZMxqvWyIstySL6EwikVNxZiV3ekLaCIJbQv4mxOSkw9QoAVYCXLa289C1vorDGA/NWEdj4OH
	Y9P8MmamyvHRixs7cFEohwoOCKeV7ixiFcewzZi4d8drvO3cOIs2tTAP01CkGXb0usB44+raTyf
	qKXbf2MyCvYb6wf31iHS8CDqCJ76o1mXZsSV6KQUzydw1L3MOj9rvzQEjxp6p+oOWtiX/CFN6G1
	Zu0W3Sotv6DWepPzpiwZzpINVQ2VMwhhbbtngUIkGA//UqnVowEmgNy2f89VO/m+gHfqzxoNqGH
	FFcD+wFVnAlPMIM7FwwqDohUaH0/AjTM2g6xejRb3K9fwPavCnkk6cJjDPF/HhQZ2/ptiOcv1UK
	5/j+GmpZjUwsrcJ5TmsKAXzosFBhVoIOIidD8F9D9+xj3VwBV1rD1vuAnFAG7V3XIQvjkELX1Nv
	/6nGUddFPLBhQ7DigRaLipfD+ieHTkoId58vL2bnM+5MuUZC8WFqQ6SBZQe3v8t/dJ54LrhsIFf
	w9Ck9gDswDOGsMCav7JxOCDnIAw5AUcqbr/1Z
X-Received: by 2002:a05:6214:ccf:b0:91c:7ae8:fa2c with SMTP id 6a1803df08f44-91c90431fcfmr12968936d6.14.1793222383945;
        Wed, 28 Oct 2026 14:19:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a6d598sm139778966d6.3.2026.10.28.14.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:19:43 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v4 8/8] mm/mempolicy: read the zoneref slot once in mempolicy_slab_node()
Date: Wed, 28 Oct 2026 17:19:30 -0400
Message-ID: <20261028211930.3504634-9-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028211930.3504634-1-gourry@gourry.net>
References: <20261028211930.3504634-1-gourry@gourry.net>
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

For a bind or preferred-many policy, mempolicy_slab_node() tests the
first matching slot's zone for NULL, then reads the slot again to look
up the zone's node. Offlining a zone's last block rebuilds the
zonelists in place, so the second read can return the terminator:

  CPU 0                             CPU 1
  mempolicy_slab_node()
    zonelist_zone(slot 4)
      = node 2 NORMAL
                                    offline_pages()
                                      build_all_zonelists()
                                        slot 4 = NULL
    zonelist_node_idx(slot 4)
      zone_to_nid(NULL)

Current GCC merges the two reads, but nothing requires it. With
mm/mempolicy.o built with -fno-inline -fno-ipa-sra, holding a bound
task's slab_strict_numa allocation between the reads while a movable
block earlier in the zonelist goes offline oopses every time:

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:zone_to_nid+0x0/0x10
  Call Trace:
   kmem_cache_alloc_noprof+0x294/0x610
   do_getname+0x34/0x230

mempolicy_slab_node() and zonelist_node_idx() are tail calls here, so
neither appears in the trace.

Read the slot once and use that zone.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0884c629670d..cd63c3e2c029 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2176,6 +2176,7 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_PREFERRED_MANY:
 	{
 		struct zoneref *z;
+		struct zone *zone;
 
 		/*
 		 * Follow bind policy behavior and start allocation at the
@@ -2186,7 +2187,8 @@ unsigned int mempolicy_slab_node(void)
 		zonelist = &NODE_DATA(node)->node_zonelists[ZONELIST_FALLBACK];
 		z = first_zones_zonelist(zonelist, highest_zoneidx,
 							&policy->nodes);
-		return zonelist_zone(z) ? zonelist_node_idx(z) : node;
+		zone = zonelist_zone(z);
+		return zone ? zone_to_nid(zone) : node;
 	}
 	case MPOL_LOCAL:
 		return node;
-- 
2.56.0

