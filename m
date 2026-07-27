Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E383D8915
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182700; cv=none; b=nB+yDfqeZg+1z/BpnyiEQuvBEzzqTpKVSv3A7/TFO2xlLYgGf5BjKPgBYf0SSN4Jdka8bvmtfhjO0mJUlOxAC4EP+AGfhwBfw19ro/k3/eb4KqOTSIXBFsV3t77vccNc/+ytJ4UAIIkIzDRiTf9J9pKp9FJD0W9v0KL9Crmi2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182700; c=relaxed/simple;
	bh=vKQJ7QNJv+uZz9x0zSIk21ClMOvdIiAE3tig64AC2Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYMRVrsXTJW5px5sHgf0Ff1DXUQVWs9kyW67zuAIRY2V7Jj1t1oOYqqcC2EgplwI5bpPwF1ARHsHeP6FlfCwJFRGOcd7FQ0uPJw/wYPcd5/T89g9K4yqJvmAhqCSPOwI9t2hU51u/W+CmGK+Rc3Oh3Mzb71G+mYehho9+RaZ2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca10de42; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca10de42"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954aff6088so26745165e9.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785182697; x=1785787497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZaCjvFlh04tSbrzp8Qm4VrJ+XEIKD0uan3d5oYYxA9I=;
        b=ca10de4256robnFq86NIEIxsRDK+qjrxo4Z9mHKXeAfywqIeJVz673aPVdNZUGtT9j
         0xfFIw+AJcjPi4PNEYJhRPT+om/BnNeTq4NvUJBqg+ywNs7A77kk/owLTu/RubN90DRP
         AiEdUek5uHJdZxcZwN2mFchKkZyfrtkKdDSBiEVA0EkC81kEoF4zTSMBe0Q43dJRvWHV
         Q8k0JpnNlrP1Z4OQdN08X5HPqri8qeRUOX34Sn4+fZB4cwyFY1ishYYvqCRQ4hz1y5zj
         LigGKEFuu64FM/bBEwSiGluYN/Wdz73sZOpcuF9LI3+7OvTBxV53OlwnXzQkYiRMNNW9
         gEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785182697; x=1785787497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZaCjvFlh04tSbrzp8Qm4VrJ+XEIKD0uan3d5oYYxA9I=;
        b=DQ+5SPFhLwY6hR8ru+lIMwjATTfl3z0koJRjidvhNSAXpsPpYiYFEQX9LbOqjBiMhz
         ieCXkXjOd7p7vLMksC41dqLDO6DKlxVPYd0XNDFU+/te+E+LSnN/lQulg2xgUfAVBX8b
         XdxQlpofK+2E8nTwv0GBkdJ2bLKqCqA/fFyUk5FM/+CVIli5SeKY7q8ckf4Vo513nSwr
         fSLdFi4DO8kZUTdq2alFVsiqJ4c2lrqCTfcb7m5zT3nPxuejURQ0QL25LmxtZtdnA+W/
         xSdjFdzWf4hxrBVB4bw2MTcYsyDCrlH7xQEBJBN2nUpAV1MTZed3OrLNojucYfHSFgG3
         D6BA==
X-Forwarded-Encrypted: i=1; AHgh+RpCpuubbKrBJoDK8ijRRQDEUJ3EUSkBdZdpXhOkWRzEIuP6GP/erJNlIOxbL9oIh0pIwLAXUmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzogm/Iyn8Iz2DJuIys3RRe1CCjeNwtKAZDIV9BYFn982mRWEOn
	Yg5jITe3wmmRR5QbiUw2DcGZtpUqQMBtMjpWw5HI8HpeNLYXXMuOS8Y=
X-Gm-Gg: AR+sD10p3AEsZa0emVM55CAT1oDQzmiHaiigLxBeXAauLtJc1x6BjX6DYfLkUiZoE96
	8rgVnCta8fcdcYKcg7QUGTSBzWXS4PwVJWa/MfcbEF/JUPnMLDzW0GIfzHrv2LZ6kFsTIWzzeb9
	oiK7zPM4CziL/txbd8P97LO0zxj527EC85jXSyth10ICQ2zj2+o8XV/U5GgKZ9rtIyeBj5ohwPY
	EABvL2C1tuRU+4iTeSbF+8Tdy1IuXMsSdgp8jnwQDJDszh857RkPMpQSu1AMyPfzYJnvKpFcKP8
	OCBkLyvwpMHVADb1RJplbnGio07JStgaCUZNgc2VCf0nwYCHA5G4K6ke3Dmj86RfWFaJXuiKPzb
	UGGMKO7uSdPLwH4LG1+4B238SeF/UPDMHdUlGP4c+9G5H+TpCeWqgcdh7xZ9UPC/xKpMQAnhQbF
	osWauxcu2t58lt+x1/2YQacO0R4VNqDaokUe12uztMww==
X-Received: by 2002:a05:600c:6dd5:b0:493:e583:7053 with SMTP id 5b1f17b1804b1-496c4fe26d3mr3319875e9.35.1785182696309;
        Mon, 27 Jul 2026 13:04:56 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c46160dfsm18406235e9.10.2026.07.27.13.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 13:04:55 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	maheshb@google.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net v3] net: reduce XMIT_RECURSION_LIMIT under KASAN
Date: Mon, 27 Jul 2026 20:04:54 +0000
Message-ID: <20260727200454.4048141-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

On x86_64, CONFIG_KASAN doubles THREAD_SIZE from 16KB to 32KB
(KASAN_STACK_ORDER=1), but KASAN per-access checks inflate individual
function frames by roughly 2-3x.  For an ipvlan L3 + IPVS NAT routing
loop, objdump measurements on a non-KASAN kernel show ~1.4KB of stack
consumed per recursion level (across 17 functions from __dev_queue_xmit
through the full IP output path and back).  At KASAN ~2.3x inflation
factor that becomes ~3.3KB per level.  Nine levels -- reached before the
current limit fires -- total ~30KB plus the initial call chain, which
exceeds the 32KB KASAN stack.  The overflow hits the VMAP_STACK guard
page and causes a non-recoverable kernel panic (BUG: stack guard page
was hit).

On non-KASAN kernels the same loop is safely caught by the existing
limit: the "Dead loop on virtual device" message fires and the packet
is dropped without any stack overflow.

Reduce XMIT_RECURSION_LIMIT to 3 when CONFIG_KASAN is enabled.  This
keeps the recursion counter well within the 32KB KASAN stack budget
while preserving the established limit of 8 for production kernels.

The recursion path triggering this is:

  __dev_queue_xmit -> dev_hard_start_xmit -> ipvlan_start_xmit
  -> ipvlan_queue_xmit -> ipvlan_process_outbound -> ip_local_out
  -> nf_hook (IPVS) -> ip_vs_in_hook -> ip_vs_nat_xmit -> ip_output
  -> ip_finish_output2 -> neigh_resolve_output -> __dev_queue_xmit

Tested:
  - KASAN kernel (6.8.12 x86_64): panic before fix, "Dead loop"
    drop after fix.
  - Non-KASAN kernel (6.8.12 x86_64): "Dead loop" drop both before
    and after fix (no behavior change for production kernels).

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v3:
 - no changes, repost per maintainer request
v2: https://lore.kernel.org/20260711204700.1760374-1-tristmd@gmail.com
v1: https://lore.kernel.org/20260711134732.1385563-1-tristmd@gmail.com

 include/linux/netdevice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b54..bdcb61d352afb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3640,7 +3640,11 @@ struct page_pool_bh {
 };
 DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);

+#ifdef CONFIG_KASAN
+#define XMIT_RECURSION_LIMIT	3
+#else
 #define XMIT_RECURSION_LIMIT	8
+#endif

 #ifndef CONFIG_PREEMPT_RT
 static inline int dev_recursion_level(void)
--
2.47.3
