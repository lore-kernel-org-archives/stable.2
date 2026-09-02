Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F24A5C37;
	Wed,  2 Sep 2026 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361392; cv=none; b=S3m8HjzIRF3I6DGrQc+wjh7iZEfA/51DZM1dxfrrNek+at5ScLc/w6V77PUHmIuAz+7Te2BlcCcBxT/85H2Ax2PWWS3kWMhj4Ye1yobWeT7S8j2tp1dEGfkRvCHHqAfl24uxusrTVdBkBWqYvd97KRzSXQI2aIDKtiOpgL+Ambo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361392; c=relaxed/simple;
	bh=AHb6KAw43LX4hboGqGhXugCWzp7EtaFyNAAbR1W1gL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D07IDlRXY1aN034rKVFsbToueQPX0VBzfcc0V7vJQ1xVgzDk8uLLYr8xKsNULzDg7i6WJEJUKSN7MxgUMiWX/HPAAA5PQue+EpK9rOb8eeFoWtQMgg7caNxS1U5jyHdFvPVaGkjGYRhCDznGlDXK/h45myNt0g687+4rLmgW5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB/7Tayw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB/7Tayw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E301F000E9;
	Wed,  2 Sep 2026 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361388;
	bh=gMDoHVoHQODfGlDRyrZ38N3/qQqV14jIqO44yngpLFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hB/7TaywyBLNvyyfXZpLnv2VPC+1OBREDQbQzJFMNZIWJLrhHcUVAIs+Br1Y9xBRW
	 ayvecCVhX6ljF2/m6xEdRJFROMVd91LMdocz6umvDzN4CYyIUzQM7VrEvT4qKAPPKO
	 rqcTxRvSa9tuH5VtzsqvqAXCzOywljr+GRaJwnobjhwBEJS4qzhtHlMJfr5/xgpTja
	 I8k7jpkumLZPtm0O9hWJJe+mW6nIivu4dFlLf/0Oyb+ZiZnXKTOfSKu8vnmwQ0vdAJ
	 csm616junuXT/URSmjNg7w3Nv6uJitkeQrPJlheK3zbF2IUU9AqF24dA7L3db+Pgqq
	 vAvXpoKY0q39w==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: allow esz to be set to zero
Date: Wed,  2 Sep 2026 08:03:00 -0700
Message-ID: <20260902150301.88535-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902143605.6785-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Sep 2026 22:35:20 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Wed, 02 Sep 2026 07:13:48 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Wed,  2 Sep 2026 16:20:50 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > When the temporal quota goal tuner determines that the goal has been
> > > achieved (score >= 10000), it sets esz_bp to zero so that the effective
> > > quota (esz) becomes zero.  However, damos_set_effective_quota() clamps
> > > the quota to min_region_sz, preventing the quota from ever reaching
> > > zero.
> > 
> > Where in the code it is clamped to min_region_sz, when?  And what user issue
> > this can cause?
> 
> In damos_set_effective_quota(), when quota->ms is set.

Please clarify this kind of thing (when quota->ms is set) from the next time.

> 
> '''
> 	if (quota->ms) {
> 		if (quota->total_charged_ns)
> 			throughput = mult_frac(quota->total_charged_sz,
> 					1000000, quota->total_charged_ns);
> 		else
> 			throughput = PAGE_SIZE * 1024;
> 		esz = min(throughput * quota->ms, esz);
> 		esz = max(ctx->min_region_sz, esz); /* <- HERE */
> 	}
> '''
> 
> This is a minor issue, the main problem is that it doesn't match the
> description in the documentation, which states that if the goal has
> already been [over-]achieved, the quota will be set to 0.
> 
> Original documentation:
> 
>     - ``temporal``: More straightforward algorithm.  Tries to achieve the goal as
>     fast as possible, using maximum allowed quota, but only for a temporal short
>     time.  When the quota is under-achieved, this algorithm keeps tuning quota to
>     a maximum allowed one.  Once the quota is [over]-achieved, this sets the
>     quota zero.  Useful for deterministic control required environments.

Thank you for clarifying.  Please clarify what is the problem like this from
the next time.  Without it, reviewing spend unnecessary time.

I feel like your recent patches tend to lack such clarifications and spend
unnecessary time for reviewing.  If you unsure, please ask questions first or
use RFC tag at least.

I agree this behavior is not matching with the documented one.  The point of
quota is making DAMOS not unnecessarily aggressive.  Hence it is designed to be
set as minimum as possible.  How about below?

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3485,6 +3485,7 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
        struct damos_quota *quota = &s->quota;
        unsigned long throughput;
        unsigned long esz = ULONG_MAX;
+       unsigned long esz_time;

        if (!quota->ms && list_empty(&quota->goals)) {
                quota->esz = quota->sz;
@@ -3505,8 +3506,8 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
                                        1000000, quota->total_charged_ns);
                else
                        throughput = PAGE_SIZE * 1024;
-               esz = min(throughput * quota->ms, esz);
-               esz = max(ctx->min_region_sz, esz);
+               esz_time = max(throughput * quota->ms, ctx->min_region_sz);
+               esz = min(esz_time, esz);
        }

        if (quota->sz && quota->sz < esz)
'''


Thanks,
SJ

[...]
