Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CDF59C96A
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096998; cv=none; b=ZyYaHFKQUy1QFjfRkYoe6mlYmVkZ7TzEKmHwDYHkWeL6JS5qNWs8Rs4TUttQdckNE0v8rAGnz3vxEJIEpy+kyQtLjpQ7/Pl8hpkx14Ss1wIPN3ElFzJ/4af9o2uDYElm8vbkHj/I3ZsEyYCNYC9A6O+5FpdtLY634xxy8qSvHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096998; c=relaxed/simple;
	bh=8Di9qigXUDyNOrzACu/IjvQS8CZV98qXR9LZAd4EhC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulos4oK9bZiQ9k9y6BNQ5Je3KOMWyn93EcerpFtZiq3BCyhsBAE7hhnOnvhGkiaogRPqRzPnVzBR4ffWDhjufAU+d1UyWn6MqZ2H0qNxCf1jGbDC2lhhycxjFzJt/5KGOvYsOdcAxB+T8C0y/2C4L9J4toPjECjjKiCLsTRW8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7lXfCoM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7lXfCoM"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso962583a91.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792096995; x=1792701795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0wSQN4j3y/wqDxcmHCHdz0iAfBFTqdwL5Kj3XHoYIQ=;
        b=c7lXfCoMbeGIm8bs0ntYN3bJjxrp9NvMgJvnmfCsNcc8NuJhbOq1U6EHJr2yqZ3Dac
         G3B/1rxm9Vkf6Nm1Nd4wxVURCwbYpDR3c5u60Z9l7o4a0ci5WLmJZsKizR8yzGqMlStf
         WquHN2Yf8T+06XHkLnzsipjQTMUNv4MAH5ujOLN/sBsFYz+d+2NnUfnaWct1C69mYQct
         rD4sSxlFj4Z9jgbS37zotZlLvU9CCls0n2slET5s4UR/co4P+DDGNMw98uCKoFOAI9o9
         oHgqs8aEa+nzjPhxy2CRhptyiXQ55ca5K6DqGFhXngTHCRBD1MK40Wo0ABfmxcCKgbEe
         1mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792096995; x=1792701795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0wSQN4j3y/wqDxcmHCHdz0iAfBFTqdwL5Kj3XHoYIQ=;
        b=aGAGA9bWagz1yZRCTaX9XMC14mkt3ZFdNHIjVGhlFIfm5baGvMT/ue+mA0slPZKM5a
         tsTzwIjYi6TgaR7La8ECR0aNyBr7rxDlOez9BcP7frx+U3UER0XJwGy1iCBHZXrUM3/Z
         k2eAeZcxeQU7ZkLAW+64uOSWAeW8nQLTSiXRIkML+++YsnYT+2/qnoKkkS9mKOn4yGMP
         npUWB8zMrr3e5VrvbTSz5fzd1T/axRYeHqvgiqKBq91cjZiiMdjpkRTh6lbTBgfsJ4Bj
         F4IGL7h74u2MXTwFwVMZRuJO+mAc/DETCo7ifPapRL1WTpJFi3/0e4T9gL5xOGL7WJ5n
         OJfw==
X-Forwarded-Encrypted: i=1; AKwUvByk3OnUNBgNqXdhtbmSauhJQKnNNe6bNj39GUN4hQs9uP94//S/ooLSidb/iqVppMCPRd9QJT0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQKyynK9Cby1FOYLEzBEo+derNFNbHYujG01DXg/9+lgGDPLa5
	1zp+6R90kTJ/AWQY16umDJZmRwvXLyzKkG6QZkX5ddpSUf6LDDd9KhMi
X-Gm-Gg: AYBFou20rfQuo7XY05wHqIuh0YJBY92DUUex9GnQKCcZsCIrGQOx4GWEN+8XAyqDDYu
	xtp6XNr0918y70lPZIMg4YzAbAroddY+2lkI1ph+Psg94aHsjWtqUiZmO4wQsT7ni9l9JW5lkDJ
	KYZlVoXxtS7JMIZiHc/d+rRhLWXAleSQc27T39dh1LE04FM7G+quzMMfP5QbVyT0lHJIHBbcqUl
	+Xbpk2bN+lysVUHQcHZXdXLHS/W0ZWMJLn30AbPKJ3+yp46VnrYTs+tqMOxuagKpNodB0ZyLCLO
	chcPt+lXPV7KUmtF1QHl43tyfRybQyrnlb1leajYvdSHwYPq6CIbbHmV8qK4yJlDK4LZaOncH61
	7gAq36E1z9Iso6WIGvmGIGvflcXMucNbE0Dlae7xC3cagRgFBvjRrhikTzSc132WU3icd7LSmYe
	6IJcNXPinV4PvaA5UEy0SK95ZwyrP0pXdSPP/8FX4GD/mgaJ1VYELH/YOd/FbLvsPFi0v0Scjwh
	GPQsyRhPqjkYvfP0r9isSMsvLo8DiXIDap3qHvcmEFvpXQbLWN11A==
X-Received: by 2002:a17:90b:2681:b0:3a7:250:333e with SMTP id 98e67ed59e1d1-3ab3ac578ddmr16320662a91.11.1792096995407;
        Thu, 15 Oct 2026 13:43:15 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::a891])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9d266d6sm106429a91.1.2026.10.15.13.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:43:13 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: akpm@linux-foundation.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	fvdl@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] mm/cma: do not count skipped ranges in cma_declare_contiguous_multi()
Date: Thu, 15 Oct 2026 14:43:09 -0600
Message-ID: <20261015204309.42630-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1792032699.git.skunkolee@gmail.com>
References: <cover.1792032699.git.skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cma_declare_contiguous_multi() adds the size of every candidate range
to sizesum before deciding whether to record it. Once CMA_MAX_RANGES
ranges are recorded, a candidate smaller than the last recorded one is
skipped, but its size stays in sizesum. The replacement path already
subtracts the evicted range, so sizesum is meant to track recorded
ranges only.

When more than CMA_MAX_RANGES ranges exist and one is skipped, sizesum
can reach total_size while the recorded ranges cannot. The sizesum <
total_size check then passes, the reserve loop ends with sizeleft
nonzero, and the function returns 0 with fewer pages reserved than
requested. cma->count, available_count and totalcma_pages still
reflect the full size, and the final message reports it as reserved.

For example, 8 free ranges of 1G followed by one of 512M with a
request of 8G + 256M reserves 8G and returns 0.

Only count a range once it is recorded.

Found by code inspection with the help of an LLM. No kernel-level
reproducer was produced and this was not tested on hardware or in a
booted kernel. The example above comes from a userspace copy of the
selection loop, written from the source.

Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
Cc: <stable@vger.kernel.org> # 6.15+
Assisted-by: LLM
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
Resend: the first attempt of this patch was blocked by Gmail and was
not delivered to any recipient.

 mm/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 527b2d894f3e..c2cdef953ee9 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -594,7 +594,6 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 		size = ALIGN_DOWN(size, (PAGE_SIZE << order_per_bit));
 		if (!size)
 			continue;
-		sizesum += size;
 
 		pr_debug("consider %016llx - %016llx\n", (u64)start, (u64)end);
 
@@ -620,6 +619,7 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 		}
 		mrp->base = start;
 		mrp->size = size;
+		sizesum += size;
 
 		/*
 		 * Now do a sorted insert.
-- 
2.56.0

