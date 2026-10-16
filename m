Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047FB48DB45
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176483; cv=none; b=GgoVTBTx/AwrKhaTHujqH1AydzhSkl7X8z8ZxweKn95AFEvEbu7VtT2O4BSNQZskw6A/MA0IFCDp/xfxzRdDv3309TS8znKu3JsIHVOzhxlTI7vy4IRnUE2KwlU5OXVIHBsJybylvfHj0sRFbwMeNgcelCDPtFYDD3AbcE8hq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176483; c=relaxed/simple;
	bh=/mlGGUmh4imtXySY7AXdz4KuC8XMU5x8T9TuD7xZIic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tV0C7+RfxEYdsM6/v9062+jY4QQ3vTi8OGz9aSd80lGXcpe0NKPJwzAC9JIkOltLpVciyysVpugW8E4egVPWYX+aZZDQU4Mg4fHE+Z1BA19OpGW/o+rOSp3f6WTEbKC5K3scpuqJxhlLdjskPmJgR+cx5I7uS1mRFcS727LD/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=U/cDlfZZ; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="U/cDlfZZ"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35c76e9614aso240657eec.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 11:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792176481; x=1792781281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7HjfQVA5Ug4OqWpNl1Z5zod/bI4WrApAYRfZdU17cg=;
        b=U/cDlfZZcXsv84cy5ctJHrDSAaBCJFigmr7NBBo+tmYyo5xtvW3VMSAS4CHNjYawVm
         kDWZKPsqkyXXwgAd9WDxr7PhB/zsymSp+gIwWIqEB6IpJ4UVy9p4YASucP6/ieTYACm5
         nMH4zxt5lKtbU86Ea4FYREhu7193K/VSpASkbpmLOIX+RnyLFgUkaaQ+IwLJuhUcK2gW
         dPqmRIyvp4zClnN3Jbn3W2NY9oHa9J0HNmjZlFLN+TjAkaRXnLRek2YVfAxPRpj1CRZg
         pvMzcJE0BrmnSprOiWzsZjLK1d9XwGV3ed1lcMXIQpbaNpbU9TGI8ByFNXaOkcenNy7e
         gPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792176481; x=1792781281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s7HjfQVA5Ug4OqWpNl1Z5zod/bI4WrApAYRfZdU17cg=;
        b=Wh0D+Ao904vU9UNeu0RTScO0CCcC8jx0PvxlhkJv3d56cyi6rFCBI3aXAK+D37EhiH
         /zXVtStpVsaH/iMdTNvTefSvm88MhXegYurET1GUvpYynbzbblCZVI5dgysqi5syqdLm
         HQv/zejvvQQp0aYUZC6VvhAO/R3pbOO/aLvBreYl9MhU1NZHpEo+ch7qy0oBVqNjExOs
         FNPWuVxrIlTUAF0MuzKpptb7fJ5zHcNiVKd4YZmTPhWExQKnthdVCBKvTcL8491nr5n8
         46wQmiWYJXt+VX5qDAD40zRQ7Bvo2DS8aemYDTH/RdQ61WGsZB8V/EAhg755+zbVVS+4
         0m4A==
X-Gm-Message-State: AFq9FYLq8njm6jhZwQlQc+gtWzjinCsWnb92AiJo5+AID3c2Kku5ey2N
	fDqBSiYtPhQSpwZX4xgab+dgxjwbXUb+nYqCy7Q9EIKiFj7ShWmvOxef1qzMuMt3ZxHyfU1kYjP
	6wgr/1D5ggA==
X-Gm-Gg: AYBFou2K/B3fHYI0E0CAQLyyj/P9EzP/94egetCJh5zUgJ991wv/a//4b8TPA8jBh0x
	cW4DS9cOPq5YmN19EVr8ptD8htHNpnM49lknqWFD1WGfMpxLkawSFsmQFY29bNYkLDDcGNN2CRf
	DzlfXDEstDXnw7fPwvh7WihRgyfx/u08MaTAPICUcqpPHzSyoa30VdRG+ydUh12seKFKUzG9ytf
	5OZPeYZUniIdCxw9XSjOT1qS9wKXvFPIuIqR2mh5ipRF2r+SlZQR8C82Tjpc/tvLnRkIV3qGeGc
	7drtWTVqeNnzIGKO1vFOKyM5f60jmMS5ETV6SOg+NliCkoVlG6eUBVCK3Tg/lbvXyxKfSodSQTd
	IqppuXcSCmaaJw+3qh6XO2cgEN6y4tY9SGE8/yje2bizr1cVHI/rbee9TI6hgai9NKD4tfEsh8z
	e9G9FM1rf14u038Wu0s5VFxVfp95W081mH3IaepwvohMqhH2nWqJBZVACC41tqRN48Cu295UJPC
	GBmQTuj2FgXgblruq4SX3+msCC72DvKSWciwDVN8yF1ksLzSaoAjMJolK/M7CchnUkVzlA=
X-Received: by 2002:a05:7301:380a:b0:35a:ca1e:4d82 with SMTP id 5a478bee46e88-361a1c50083mr999407eec.20.1792176480952;
        Fri, 16 Oct 2026 11:48:00 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:85ee:eb9a:5637:424d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082784ec8sm8004502eec.22.2026.10.16.11.47.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 11:48:00 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y 2/2] blk-mq: reinsert cached request to the list
Date: Fri, 16 Oct 2026 14:47:53 -0400
Message-ID: <20261016184753.27189-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016184753.27189-1-artem@trailofbits.com>
References: <20261016184753.27189-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit b051bb6bf0a231117036aa607cadf55be8e63910 ]

A previous commit removed an optimization out of caution for a scenario
that turns out not to be real: all the "queue_exit" goto's are safe to
reinsert the request into the cached_rq's plug list as they are either
from a non-blocking path, or a successful merge that already holds the
queue reference. This optimization is most needed for small sequential
workloads that successfully merge into larger requests.

Fixes: dc278e9bf2b9 ("blk-mq: pop cached request if it is usable")
Suggested-by: Ming Lei <tom.leiming@gmail.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://patch.msgid.link/20260526153531.2365935-1-kbusch@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Assisted-by: LLM
[ Backport to 6.6.y: Reinsert with rq_list_add() on each of the three
  target preparation or merge exits; the target has a single cached_rq
  list and no shared queue_exit label. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the corrective follow-up for
CVE-2026-64017 to 6.6.y.

The backport reinserts the cached request at each of the three older
preparation or merge exits. See the bracketed backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y).

Thanks,
Artem Dinaburg

 block/blk-mq.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1ad77737b27d3233489b4d9f690c9e6ab77d2130..e3fb9222c5ee00c1fa2105e1194d5f9eba831092 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3024,16 +3024,16 @@ void blk_mq_submit_bio(struct bio *bio)
 		if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
 			bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
 			if (!bio) {
-				blk_mq_free_request(rq);
+				rq_list_add(&plug->cached_rq, rq);
 				return;
 			}
 		}
 		if (!bio_integrity_prep(bio)) {
-			blk_mq_free_request(rq);
+			rq_list_add(&plug->cached_rq, rq);
 			return;
 		}
 		if (blk_mq_attempt_bio_merge(q, bio, nr_segs)) {
-			blk_mq_free_request(rq);
+			rq_list_add(&plug->cached_rq, rq);
 			return;
 		}
 		rq_qos_throttle(rq->q, bio);
