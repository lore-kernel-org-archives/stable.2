Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AF477E57
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352274; cv=none; b=bihGLtn1/2NA+dOrTLZw3tcEXcBwqnSi7c1oKr6oDUdlMx2mgbJeQp9tItmnhkqqJNO2eBb6X9nlchNCPkY8MSKTTu6UqfVduNxn0gWvDoEGnGUdMY5Z7AmfrjWP+DTWmGJgotbO33Je+fZgQMlZ//neMql3vJMZscg4pVCFzjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352274; c=relaxed/simple;
	bh=5yEV4XnolTA4d1Bxi7KrwZxByDjfSzCc7FhIPl9sFLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OL4GyajFShAa1Vmj4vpOUEgwg2Q6WDiV0pC3TGSBDiRl5N5c4COluer31d6qRuVrmaktr3adXptFawtDGcbudC8BCzx8ts7iXluOznEHIgd/RdT5lFF8v6xuk+BVwgYNhy1qetecqFZLJg1Vhl3j203inzPIblb90tz/guy5OQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5Xw9Vw+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5Xw9Vw+"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c252e703fa3so131780266b.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 05:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788352270; x=1788957070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TI6pUAVn6iqJfgwPq0UA4Qme1N3xxMZKcN9f4ke5Y84=;
        b=j5Xw9Vw+O7LfMfVwi6Jpx2KzGq9sUUy1+BLcLFskY4XODJ/8YdRp+FscnrlTJrIQsl
         EfooJ4d51nM1DYFw0BosbgdAx6ZZEM4MGtDyRWJZ4LH6GMnCDdeozonJYfnlF5Ee07XU
         /UnO/khGya5EkDdQoaZ1qRcxO5mYImbeIDTE1NiOrOPn5bep8mF8j209ZX+ZMTtxulAR
         8RVYl0rLRxNErvDiDNt4j24FeTPp8oBppo6xG/O0WB7fOFKecCbQKkv/5869ixMXsPat
         D1ieVUjQvkG/w1loHT86FoqSScSVsfAEpTRSwTgPqwjRJ1ZbV0XR2nnQaIAtALcupeB8
         fUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788352270; x=1788957070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TI6pUAVn6iqJfgwPq0UA4Qme1N3xxMZKcN9f4ke5Y84=;
        b=ROeFX203olgsQ8I8V37ToDpVl/BKz3lJgY1NmwjWiaf5RGHVvs1IXTDmy+vvNap3Lu
         yf67alpm3VL7p25fLvW6/GLJaV5VFgwiO/eS/jiOxXxfjpqaGr9ymCnLhvWAt2WXVwee
         jtJJPGdkjc0qaYcvUDyd7jJr/06x8gLwAfbptpa+AzqE5e2ETA6ky/pO5hrW3nuyi9lf
         AjKnh6f86xsLoJv4AN8MheNwRgPQSxU3gat1pUNS5AtONQ024i6lVJ5gOyHSftwm0ZtL
         bWULyCVltvEKsaHuNpbuX8N6w2PaIO75QTrCaCX4mtLqN/xVQcDHo6Haghhg/OBQguuI
         y5SQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoBFSKSq+Ndk660KgOCxuP+eelKqhPnlT8vSemS/98jFZj+qxuLroLgcFjg/XGcBF3IC23mC8=@vger.kernel.org
X-Gm-Message-State: AFuF++lcvonxSnj9a6yiPkntCTJC4/R4lPYFHBEWshhNmNmdwv4109OZ
	iXHE4B6ciJpa6pFoSa5lMLsZYfjEffv3yNgDC+jzOfyiG4hTVXZCrB2uC/4M
X-Gm-Gg: AYBFou39N8FnDNDGvs7APztf0GVf4IFWuoKe17wUxaLlUUJYtiUoJurh6szJ+8D4SLB
	+upAEnXOihagZwtbnJKE1O5tGFdrdoLA79i4Aim5Bv63u7KcTjuVltpn2nA84Hql6bZnldgE4GI
	YR2dgAaRPVJ/tMNP7at3EwBAlkT9wT5GqoKM9xvjZUdWcsJrt8i0u6HVhnzraD31MhdOl0J6PTh
	kPN2YN8eo+tY6seCwrvgyb/Z/KC0gscshrMPsMPlmBtcd1jRllX6FBmQPMjMcUcjwAR/w1v7pHs
	Rp4BhPHskeigKYJ1gDQgsHrIp/7EvKxHuX7rW3MNK0B9HFkE6gZqfc2DWX1vcRy6FeaZmPP6pby
	aaBHMWd7dT5fIpRhfd5SYnPiqv23qaURZASZZlycMJopqgdNhr1CqamAJWAQn4GbhMw9A2H9XYf
	PFRYYXlHKfslyYb4nb7YPYAN5fyffXIQ==
X-Received: by 2002:a05:600c:3e10:b0:49b:9433:ea44 with SMTP id 5b1f17b1804b1-49ce57fe002mr86704775e9.4.1788352243385;
        Wed, 02 Sep 2026 05:30:43 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce0b401sm145048515e9.3.2026.09.02.05.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:30:41 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net v4] net: reduce XMIT_RECURSION_LIMIT under KASAN
Date: Wed,  2 Sep 2026 12:30:40 +0000
Message-ID: <20260902123040.2172805-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727200454.4048141-1-tristmd@gmail.com>
References: <20260727200454.4048141-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Virtual network devices (ipvlan, macvlan, bonding) can enter legitimate
transmit recursion when combined with packet forwarding configurations
such as IPVS NAT.  The existing XMIT_RECURSION_LIMIT (8) in
__dev_queue_xmit() detects and breaks these loops, but the allowed
depth is too high for KASAN-instrumented kernels: each recursion level
consumes significantly more stack due to KASAN inline instrumentation,
and the cumulative usage overflows the kernel stack before the limit
fires.

On x86_64, CONFIG_KASAN_GENERIC doubles THREAD_SIZE from 16KB to 32KB
(KASAN_STACK_ORDER=1), but KASAN per-access checks inflate individual
function frames by roughly 2-3x.  For an ipvlan L3 + IPVS NAT routing
loop, objdump measurements on a non-KASAN kernel show ~1.4KB of stack
consumed per recursion level (across 17 functions from __dev_queue_xmit
through the full IP output path and back).  At KASAN ~2.3x inflation
factor that becomes ~3.3KB per level.  Eight levels -- the current
limit -- consume ~26KB plus the initial call chain (~8KB), which
exceeds the 32KB KASAN stack.  The overflow hits the VMAP_STACK guard
page and causes a non-recoverable kernel panic (BUG: stack guard page
was hit).

On non-KASAN kernels the same loop is safely caught by the existing
limit: the "Dead loop on virtual device" message fires and the packet
is dropped without any stack overflow.

Reduce XMIT_RECURSION_LIMIT to 4 when CONFIG_KASAN is enabled.

The deepest legitimate transmit recursion observed in the kernel
selftests is 5 levels of __dev_queue_xmit nesting, in VXLAN symmetric
routing topologies with VRF (vxlan_symmetric, vxlan_asymmetric):

  __dev_queue_xmit(vrf)             depth 1
    __dev_queue_xmit(vlan-svi)      depth 2
      __dev_queue_xmit(bridge)      depth 3
        __dev_queue_xmit(vxlan)     depth 4
          __dev_queue_xmit(veth)    depth 5

Since the recursion check fires when the counter exceeds the limit
(strictly greater than), a limit of 4 permits 5 levels of nesting
while blocking the 6th.  At ~3.3KB per level, five levels consume
~16.5KB; combined with the ~8KB initial call chain, total usage is
~24.5KB -- well within the 32KB KASAN stack with ~7.5KB of margin.

A limit of 3 (v2/v3 of this patch) allows only 4 levels, which broke
the VXLAN symmetric selftests: the 5th __dev_queue_xmit call was
incorrectly dropped, as reported by Jakub Kicinski and the kernel test
robot.

The recursion path triggering this is:

  __dev_queue_xmit -> dev_hard_start_xmit -> ipvlan_start_xmit
  -> ipvlan_queue_xmit -> ipvlan_process_outbound -> ip_local_out
  -> nf_hook (IPVS) -> ip_vs_in_hook -> ip_vs_nat_xmit -> ip_output
  -> ip_finish_output2 -> neigh_resolve_output -> __dev_queue_xmit

Tested:
  - KASAN kernel (6.8.12 x86_64): panic before fix, "Dead loop"
    drop after fix (at recursion level 4 instead of 8).
  - Non-KASAN kernel (6.8.12 x86_64): "Dead loop" drop both before
    and after fix (no behavior change for production kernels).
  - Measured max __dev_queue_xmit nesting depth via bpftrace in a
    VXLAN symmetric cross-VLAN topology (VRF + VLAN + bridge + VXLAN +
    veth underlay): 5 levels, confirming limit=4 is sufficient.

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v4: Raise the KASAN limit from 3 to 4 after investigating the recursion
    depth of VXLAN symmetric forwarding selftests.  Measured max nesting
    depth of 5 via bpftrace (VRF + VLAN + bridge + VXLAN + underlay),
    which requires limit >= 4.  Limit 3 (v2/v3) incorrectly dropped the
    5th call, breaking cross-VLAN tests, as reported by Jakub Kicinski
    and the kernel test robot.

v3: Resend as new thread per Jakub Kicinski request (no code change
    from v2).

v2: Switch from per-driver recursion guard in ipvlan_core.c to
    reducing the global XMIT_RECURSION_LIMIT under CONFIG_KASAN,
    as suggested by Eric Dumazet.
    https://lore.kernel.org/20260711204700.1760374-1-tristmd@gmail.com

v1: https://lore.kernel.org/20260711134732.1385563-1-tristmd@gmail.com
 include/linux/netdevice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 87cafc932e9e6..3ccd1e65bcd9e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3669,7 +3669,11 @@ struct page_pool_bh {
 };
 DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);
 
+#ifdef CONFIG_KASAN
+#define XMIT_RECURSION_LIMIT	4
+#else
 #define XMIT_RECURSION_LIMIT	8
+#endif
 
 #ifndef CONFIG_PREEMPT_RT
 static inline int dev_recursion_level(void)
-- 
2.47.3

