Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793588282;
	b=ryTYxYcKqOqUf/1hrMyuU0tqAx7OpgwcDOcGkNf/2xy7GRZhFJ24rEWeouU9pygVoQS6
	 +vGbge4ZXIfM+1hi8QwgQVFLssM0B79E6bIXA9yjIeVX6bBduSfHwuuAbAy/gVJdHS3PJ
	 YHmnOpduPBjMIQqD4RGGyo733G9Ffb1FAuxbCSQNqtGHyMUTcoC+KIl6kvlPAUxqSKoNJ
	 dH1e3nxeQ2maCBgicrl6OVMJk+89csgtnAvSpnf26PBdxkcqFyWGxfCv1PsBDLUPIAqGF
	 CEBt5ohsaX0fqDmu53sto6ugMHBYtaZte7W5/Gb3lk9KXVMwzznPpnfyDcA7Bc15dCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793588282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i6tZUO8XBhTDjKD1jpOy09iINxG2kNUDkhNJoZ9/I2c=;
	b=xIEcWMIUq2aMMpH3qZfUbuITMk41QZ/eoZySbYi326LCKzJ/0V3YKfJIXsA0A2QmN9Dv
	 1dNCY7i2FicptTnr23kzDnkkGKOB6USeJb68hdEtIjtvbc7SWfiio68LgykJ7XW6yRUOb
	 i2ilZbybLaS9uCokJ+WoBLsmrawbjH5gu1M8CHOtn4mUWy2Ajl/e1PRmhhMRDhDI+ieNm
	 gJHNovAgvSX0DkgZyHONMDDhnUwcyJJ5anhPMog21i9o5Nvc+gVvSw8jRZhQweS+OGN9g
	 PC0tzObHFyIGow3G4zMptBnFKDt3mr2u7ouaeZbuDSJeYHTkzHCGFsP1Uj1MqwORJdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=obRqk5EW;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93082606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 02:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93082606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=obRqk5EW
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91c162febb9so30076866d6.3
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 18:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793588280; x=1794193080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i6tZUO8XBhTDjKD1jpOy09iINxG2kNUDkhNJoZ9/I2c=;
        b=obRqk5EW6Wtir5YMHsX/clzkm0ln5rDOJ+L5AfkfafhprKqOqK091VJRtrJHJlhVVq
         mocUZDz4cI4cQ4xyC0vlfk7XwbypEeD6urqi6o9SygIhqvZeeY39lVUr9WGoWuY44DfH
         jWBU+qN4NfeZImUJOCYCr1Hq8KQTNOvP+9nKXeYKjm6jJ9jVyDFACcXD0316tsQ7tPrd
         hnOHh2d6nEHzhFPvwTTJZzkSSUXtSNrQaznb86CaXgDJ2PsjdxAzLITv6vxgYLDd2D/h
         2UaGZ0Psp/jlZlRanm8+M2sGO2k8OZBTMD2Qj7OKrws6gGohs6eFwRRPbhM5WPc3XSSu
         VhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793588280; x=1794193080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i6tZUO8XBhTDjKD1jpOy09iINxG2kNUDkhNJoZ9/I2c=;
        b=FyRxWmp2ORvEUZM4403iVxT/kqCrx8zXFH6Ykg9CcojB5aCRqQlbZuOjKi76E5imJB
         GSkzmCNlZT6rOZkUkxJKWqsCESKtqqDDtGyk/3fzdvcP1OOWBcrOBU2g8Y9wv/6nipLa
         K2VccfxZEWaTMjcSKunfdeZauzqmj7oE3qrxkJFJfBk72kbSnyJYBmeQF0XBiPLv4Spg
         czTBTKECl61M1d66WEhMS4Tk6l1GVxk3PSN+f8rj6rQ0xNvVuaTQq407JwDDYHz+6hhJ
         usBdNw+ByGPth4CAf10BJuixkPK8/B3Xiz49M5ANvaZecCRg79eeCEJmt/asd4DeEewx
         tvgQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+dYGwAVrPnPym5sDf0oc2r75ybWSKtB2ekdDezn7m0ppE6wdk3LYUan7XsGk0dhJ6moNNuP8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0Psr1pxMK6wbyGFZkWIEo421Bn1uywn+yUhqf1uOvHN97LhgZ
	+nIc8gQzMc1sdTdFMNQcgcCxxtf7JLOQzlqjxmMgryy2hhMwAQQyVeeN
X-Gm-Gg: AYBFou0YYCg312RVG2loYPcrSB9UhHjgyNy0QCRcwdF8zxHZI295tmUK/K3ELlFC034
	hq0WpXVBpD9PiV6V/wVXR5BvpIzQA1XSG6tkaps/uQOKjswJol/9SQ0cWGOAv+fDns22h6BmZ8m
	xsSR8SL0nFXS45tmBD+X5oxLtvxeRFAnSdMVyPkM5n7pCaNR+OHENCqMBGYVlnPpZttvVx5BZ5C
	V/uxtI7DmOa+IoBiWA8kTuWrEvEn7yUaY9TlWW1mf3ppSsWaA4vc+A7wNFOYxv4dOc5zb48o7qw
	4HWoncIppsmTXEFQStOHuZBRKGdI+K7Iur8aEAQrmH314M4W6G/+1++CfQPd3Wr0Q2Zdoqh9BAC
	H/ySDUHpz0mTBqsHIAHGOuvSVUI2IwXDrktKT48gZI1zgut6ASODkMXuLbG4QdSq5kL+0oZKTYU
	SDQV6G3BvkxEwW/Q1FnakoPwN3aFOR3EP3G8QTYMigNosj/oYxBSt6AnDvVHYUJ8Vq0RF1bIiau
	VKsNvV31IQNrBoVyTX3JfxOPZOHxUHofb9BYRTbL2JBJZnFnMycqetGY+2jobZ/riGjzxMrqvSp
	YvUXbM8s4+io9liDY+T+vQDuzE9tMthDscGuW7TjL+68USI/TS01
X-Received: by 2002:a05:6214:40f:b0:91c:5f4b:d2d7 with SMTP id 6a1803df08f44-91ca4b6d8eamr145818826d6.47.1793588280310;
        Sun, 01 Nov 2026 18:58:00 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e23b0bsm79658866d6.2.2026.11.01.18.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:57:59 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Tianyu Lan <tiala@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mshv: Don't free overlay pages after a failed unmap
Date: Sun,  1 Nov 2026 21:57:42 -0500
Message-ID: <20261102025754.257856-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

On L1VH partitions where the VMM can provide overlay GPFNs, the kernel
allocates the VP state and stats pages and supplies them to the
hypervisor as overlay locations through hv_map_vp_state_page() and
hv_map_stats_page(). The hypervisor may write intercept messages,
register state, and statistics to these pages. Only a successful
HVCALL_UNMAP_VP_STATE_PAGE or HVCALL_UNMAP_STATS_PAGE confirms that the
corresponding overlay has been revoked.

hv_unmap_vp_state_page() and hv_unmap_stats_page() free the overlay
page regardless of the hypercall result. If the unmap fails, revocation
is unconfirmed, but dropping the driver's page reference may still
allow the page to be returned to the allocator and reused. A subsequent
hypervisor write through a retained overlay could then corrupt an
unrelated kernel or user allocation.

Free an overlay page only after the unmap hypercall succeeds. On failure,
leak the page rather than return memory that the hypervisor may still be
able to access. This matches how the rest of drivers/hv handles pages
whose state is unknown after a failed hypervisor operation; for example,
hv_free_page() leaks a page that could not be re-encrypted. Log the
leaked page in both helpers, as some of their callers discard the
return value.

Fixes: 19c515c27cee ("mshv: Allocate vp state page for HVCALL_MAP_VP_STATE_PAGE on L1VH")
Fixes: d62313bdf596 ("mshv: Introduce new hypercall to map stats page for L1VH partitions")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
v2:
- Also log a failed stats page unmap before leaking the page (Wei Liu).
- Rebased on v7.4-rc1.

Compile-tested with x86_64 defconfig, CONFIG_HYPERV=y,
CONFIG_MSHV_ROOT=m, and W=1. Not tested on an L1VH system.

 drivers/hv/mshv_root_hv_call.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index b8d199f95299..e761addda50e 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -643,8 +643,18 @@ int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 {
 	int ret = hv_call_unmap_vp_state_page(partition_id, vp_index, type, input_vtl);
 
-	if (mshv_use_overlay_gpfn() && state_page)
-		__free_page(state_page);
+	if (mshv_use_overlay_gpfn() && state_page) {
+		/*
+		 * If the unmap failed, the hypervisor may still be using the
+		 * page as an overlay. Leak it rather than handing it back to
+		 * the page allocator.
+		 */
+		if (ret)
+			pr_err("%s: failed to unmap partition %llu vp %u state page type %u, leaking page: %d\n",
+			       __func__, partition_id, vp_index, type, ret);
+		else
+			__free_page(state_page);
+	}
 
 	return ret;
 }
@@ -995,8 +1005,18 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
 
 	ret = hv_call_unmap_stats_page(type, identity);
 
-	if (mshv_use_overlay_gpfn() && page_addr)
-		__free_page(virt_to_page(page_addr));
+	if (mshv_use_overlay_gpfn() && page_addr) {
+		/*
+		 * If the unmap failed, the hypervisor may still be updating the
+		 * overlay page. Leak it rather than handing it back to the page
+		 * allocator.
+		 */
+		if (ret)
+			pr_err("%s: failed to unmap stats page type %u, leaking page: %d\n",
+			       __func__, type, ret);
+		else
+			__free_page(virt_to_page(page_addr));
+	}
 
 	return ret;
 }
-- 
2.43.0

