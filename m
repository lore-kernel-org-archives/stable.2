Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74F31ED8B
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791779339; cv=none; b=aX28exeFjtPxTgY+KGaYSmzw3ab4aybq5UFNEgbchzvZFc3HYjkMoyBWu0QtTSCM5MXH1thq+1Oa1+NJvQErnNKh+RobZcqyezGMrnbPrncWJ8RVUwUgSYdKdK9R1DH4uHJCUEW+AGkRUJMcwVwt0GcnYVwZhgtstXPnfk3FnyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791779339; c=relaxed/simple;
	bh=pRlzebhzfMcwBYlKAjXu+UMHQRlq2AZuMEqk4W6Kg7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjsNvSOajQyQEJs79Q7yoFgjiAd5MiKKxOg1sNLBJrpgIZPJO96RTvg7kbQDGwd1nAlB1IMgAv8wREPL12FsK+zpjJxHxuL/AjAGtHg3V/rJ1BOYpGhmWR7obssS2w4GAdCCkO8h0twRAdNpw/d2S6JmW9JRG/7n6ja8XzWZtbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mng3E7jx; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mng3E7jx"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91b8306b9f8so6120796d6.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 21:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791779336; x=1792384136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u/GOj9Vb9MItUiIqU9aNuHv58kWFfc6mqjL05EnCs3k=;
        b=mng3E7jx3pG2gAebQ5UtLuJ/HDKL3yr4zxU8xVE+O3vjJ/XLsiIQ2UHtirqdewgYmH
         yMm1pewQMbUCxQpyMQ2yWgTJj7ZQ4QjLVhX4z50qzg2wD2Tw0A8QpmcXfdcgQod2imNp
         VmkYf1Cobshbet9LKCj1jSDN58pYnerYjgXNWVLVVuQPegX9L/yRrrxKsL7hHwf7IKpc
         2+9Ywk6Nwr5ajZJNNECYD6x71WVMiwL1O8n/EYHeSBv+CLGlIC4Ndi9arGEvruX/VLEv
         4jaDiA8g8+6XWzcU8UpJ69D+jratftcZyu522SSj+wcLf5xrOuJLFb7R3D1GhvJR2Fug
         bdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791779336; x=1792384136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u/GOj9Vb9MItUiIqU9aNuHv58kWFfc6mqjL05EnCs3k=;
        b=DdhZdoXuhL3em2JzHXXcA6bwX+0Xh/mj1+033GjPMZpm2Q+kKyov37Ko+OSjPoQJry
         dW/2N97GJ+RzXGZ97hp5thOBhwc2fF6lNC8LdmnwY0SvCYJEGQKszYNviFNiJWEV/tH3
         Mo+jdjKgXk+57Sbcq26eoPsJiikGOfIghzbgJ2WaFT5nM2PVr2htRmtcF9SNuAGrPHVz
         pnpgMjY7648MS4ZoOyTDIz7YHQ68eFnJtY58Je/G+triojo+6RHxmq73+Xguv6NA7l0D
         2Z6ocfG4qeSZFCNftnPlKGKsSOS41gvXB3I4KppCGU0XBg4iIKg2FQsiO7twC/WcT0D2
         2yAg==
X-Forwarded-Encrypted: i=1; AKwUvBzSKFgo9P/yoC2PAYDSmymjVdfYXYCoMHeeVU2O20rF2uft1gUcptDrioYsYZGJILed6GpMu+E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWvoUyKrqMq7Xx+b8JL+9zYA7tAPXwkj43V+++pyxyLjgaVfKz
	ZuyrOe3zSpcdQjGjCVCSNiduDSY2E2EX9gAJ1iE5l2t2C+RQ+yl9xJGu
X-Gm-Gg: AYBFou1BtGq9l2WYCMtRo72Ru35lGHl6BLHydUnkH00zYIamqUzrULm2bFcWQo67cBi
	bdnn4SaoKWWMu1uwBufsN7CX4rQXAF9u5FoK151/qCmOKg0kroAc6MdRLJ4r9A5jBAN8IATa9oe
	uUb/sTnD2KoVsbDwUTcxrU7JAy4DEorsmJH1acDd3urvxi3bM6aaOfyVKnl6okZCU6Dg+Ei1Qe8
	rY9xfeUPgsfMR5HFR4BwVhY/G6jQMj1EcKu+9wJEfMVgj3GAvw7hmq0uFyXWI3fwn/3WtdCqgMO
	X0NSVWMR/7og0Ag2I45HKYNvD+fYzcNmNmWyF57aNpCL3NNJqYWKN3/rKWsD9LhIZdiIdbBy811
	shuR0R0iNGE/jH1Ebm/bHZ3u9y10f2Zk4Qbgqi0fYfrZyuLiQ2PhUD+YULLgtR0w41L08x/Nbqc
	y/UJHK2LjbLNqzJxWcBm3b9NpCmT5SodSIpJu4dXcgvZVDcHfVdYBW+c4uyn0sXIlTokqbZkCqB
	XBwwUa6O0KQ4VOsPkK7HZAAuVVgG16N
X-Received: by 2002:a05:6214:4c8f:b0:91b:5d39:e142 with SMTP id 6a1803df08f44-91b5d39e995mr132501616d6.55.1791779335903;
        Sun, 11 Oct 2026 21:28:55 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550e6609sm85433906d6.43.2026.10.11.21.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:28:55 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: Jinank Jain <jinankjain@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Tianyu Lan <tiala@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] mshv: Don't free overlay pages after a failed unmap
Date: Mon, 12 Oct 2026 00:28:35 -0400
Message-ID: <20261012042851.389128-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
hv_free_page() leaks a page that could not be re-encrypted. Log a failed
VP state page unmap here because its teardown callers discard the return
value.

Fixes: 19c515c27cee ("mshv: Allocate vp state page for HVCALL_MAP_VP_STATE_PAGE on L1VH")
Fixes: d62313bdf596 ("mshv: Introduce new hypercall to map stats page for L1VH partitions")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Compile-tested with x86_64 defconfig, CONFIG_HYPERV=y,
CONFIG_HYPERV_VMBUS=m, CONFIG_MSHV_ROOT=m, and W=1.

Not tested on an L1VH system. No fault-injection reproducer was run for
the failed-unmap paths.

 drivers/hv/mshv_root_hv_call.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cb55d4d4be2e5..9614cee4dad39 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -651,8 +651,18 @@ int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
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
@@ -1003,7 +1013,12 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
 
 	ret = hv_call_unmap_stats_page(type, identity);
 
-	if (mshv_use_overlay_gpfn() && page_addr)
+	/*
+	 * If the unmap failed, the hypervisor may still be updating the
+	 * overlay page. Leak it rather than handing it back to the page
+	 * allocator.
+	 */
+	if (mshv_use_overlay_gpfn() && page_addr && !ret)
 		__free_page(virt_to_page(page_addr));
 
 	return ret;
-- 
2.43.0
