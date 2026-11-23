Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446068;
	b=Yd9XUJk5qYNl8CJbm5ssxmJyBvpoZm3KEkjFCf0I4qbfsJXnkt+OPsRbYOHjfF0OpKSY
	 jnj+dDtQqV9c71/sc7+7oKeMiu7DC8n8XoamfJOnVRbE2W2fTCMRzsa4TFUkrBMHc2SZs
	 H8/tezacfJmpnQVwcf8CL4yBDJ40gNZZ8F+PnP9COjcVS271xyLazWXFpbGWWD7TtlgSc
	 ZVAhRyKUY9Zb0e0L4KvilUaiRjfyHPH7iCRMk4j+7kbzTunLN0IRlsQT5thKjcX0Y1PA4
	 K77CdUxvoL2WeYAFKWr3XAfClLbj4WJBf/jKxwoxuUMtH/ctqD17hcX8huwvexrK0Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446068;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FNI9jQDSnSNHPsCwqaBlID0Lh+CsRnV5aWdnjr7sqjU=;
	b=zhLwOv4UaR2c2h6CVeuck1fqYVSjZZ1KvCMEGgANI3A47Lj67nJrS/zYOLICJvCd1DLo
	 UWyETbw56oIxdYlaZyvgaDLMx5aQm8ctvwNPcGdmIywfSfIaAGOJSeMWLBT02543pjN/R
	 kT437vyBPv1ZAH8rv3xcChGV/LMpYK527FoROyuWG9yeleXhVd0TfHy5j/ANNEia99qzN
	 tPiy8U4t4Z1NeOcT6u5Hgzg1R8XzSZeC5SQA+cOyoLmwKbzkCNOYzNGHMjOaRnnYAPop9
	 19nJzc75Njmz7YvtBiakRbz45kzx2Imz1qquKy8O8xgyPh+MnPI0auFa0R3dgynuYGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqxyXrb3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7C606A321;
	Mon, 23 Nov 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqxyXrb3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB03B1F000D2;
	Mon, 23 Nov 2026 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446068;
	bh=FNI9jQDSnSNHPsCwqaBlID0Lh+CsRnV5aWdnjr7sqjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mqxyXrb3kLtCUxdK3cMQroGTLUYCR2cKkrAYCpRm7uVgSg2nfIr/SM9tEXkaKvAeF
	 F1yvMRbHQJFtQ06jB9f/bsDS2k3UeWOfDJNqLWuFR9OLejvKS4HCtXDMVC2FipnjO/
	 KiPeSB+l9KRdhk/820wBQ1dHUWvqy/gOUQakf2tyodulVMFduER9wIS2xZGv9LbUzp
	 7XMwV/JuQP0hFvL67VZSxKDcJNs4y7p66Lc6MjHS1UJJ8tgxSLt2oy6uJN3CGXUD4e
	 XtQ5q0Sa491X2uNcfAP4jST0ntlzxwW8+We3fYb2VU4Y95DtY1pZdxl7Q+g87/0Jzf
	 kNIToMo9epntw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Carlier <devnexen@gmail.com>,
	Aveline Noir <jm5905938@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH mm-hotfixes-unstable 1/3] mm/damon/stat: avoid 32-bit overflow in idle time milliseconds
Date: Mon, 23 Nov 2026 07:00:46 -0800
Message-ID: <20261123150049.81317-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123150049.81317-1-sj@kernel.org>
References: <20261123150049.81317-1-sj@kernel.org>
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

From: David Carlier <devnexen@gmail.com>

On 32-bit, the region idle time in microseconds is computed in a long
before the division to milliseconds. It wraps once a region has been
idle for about 36 minutes regardless of the intervals, so the cold end
of memory_idle_ms_percentiles reports wrong values with flipped signs.

Do the multiplication in 64 bits and divide with div_s64() so the sign
of recently accessed regions is kept.

Fixes: e5d2585d9e85 ("mm/damon/stat: calculate and expose idle time percentiles")
Cc: stable@vger.kernel.org
Cc: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261117094339.30978-1-devnexen@gmail.com
- Collect R-b: from SJ.
- Rebase to the latest mm-new.

 mm/damon/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index e44f5bf3645cc..d90a43becaddf 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -129,8 +129,8 @@ static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
 		accounted_bytes += region->ar.end - region->ar.start;
 		while (next_percentile <= accounted_bytes * 100 / total_sz)
 			memory_idle_ms_percentiles[next_percentile++] =
-				damon_stat_idletime(region) *
-				(long)c->attrs.aggr_interval / USEC_PER_MSEC;
+				div_s64((s64)damon_stat_idletime(region) *
+				c->attrs.aggr_interval, USEC_PER_MSEC);
 	}
 	kfree(sorted_regions);
 }
-- 
2.47.3
