Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D742F5038E8
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068663; cv=none; b=Z8OhIC22tHBvEWyjNEHkRmuocJj3sumKRpgQ3b9nmUmIUjIOjWcwVlLChUhFKTV9Bf2NSwYEQYOmIPgUm5AxiTfKjammZ74GMvi7qUdpVIYApaUNHssYDam+SAFR4tkoG7502rgjxopxiJX9TOGJ5PWtAqUK414KTJRHt5v4mEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068663; c=relaxed/simple;
	bh=tJFFw9uPe0COJHDp/vwA2HRLeYutGQ6B9o07VGyIKyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xv6Cgle5uDGMXfO5NyyQTmNcdXhBiR+dDptuPK5aXIw4MZTEsBi0GLJIUu1wD8U/m0ZI9JhnXOl8cqZyB++ABJZs2tXre3HWV8JM+KGU+br9dxodOb7O5kUOpxbh45DyHwb1gms0P94ogGrVrAZfdAa2jihhBwdcCR8GinVxSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu6C2j30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu6C2j30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0371F000C6;
	Thu, 15 Oct 2026 12:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068662;
	bh=7Um6CkdFgFUiyKYnZ7yOGgIt/JttBH/B2psH8qXvtys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hu6C2j30wXNnbuczWidEmYA2tYA8h0HL/8ogd9tRkF4Is0v1xLiH26FObqD9Fi3gc
	 3DT603vtut5x6vtlR2/ZZErENSa8sCgBksufnasaVoaN6Aa7afy6Iy1kYrSHtiiF92
	 QV+U3JmV/SLApJOhRXO1nyLX4w1QuJolPip19JNP9m9WGhd8A9Xm1Xo2O1Ko9MQQjt
	 jp1nVPxnbCgPTp5/enFIAbrNo9v/0gXo8SOB/3ywYUgxVBZRMAsoOGS6aihEDWKHnD
	 ZT9nRULIIwhjlNLVcAIDyg5DFmM44qF/i5QrFZv0DH/J49ja6ahtRy8qBgag39NQJZ
	 x8IyrVAYCZ5QA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.ams.internal (Postfix) with ESMTP id 91CEA198003A;
	Thu, 15 Oct 2026 08:50:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 15 Oct 2026 08:51:00 -0400
X-ME-Sender: <xms:MMzQakR0IF72dlZ4HsQ_UigfElwBAi5-kJG2Nq8h4ZXejiLJjUPl2Q>
    <xme:MMzQakK_aEbQ6kWUpJa1nzJHnnKLzCyroXZz95EqNc9TnAbI1XaXXz1ZuyD5bR-Ar
    _uU7o8esZeIVOJjrggfxTLwY320zY_YFSk6qhodR84cFWBvO4TCeEk>
X-ME-Received: <xmr:MMzQarG82ZwlLWm36rWKCazDk8rqnagziOZx8ZQ_TVqLFyi9qyRsZpanYgw>
X-ME-Proxy-Cause: dmFkZTGYpibDVUZ03mxVIum9EHYrtGYOQn4TWhgXWuWTE8ALD1yvxSQ55vrA6jOaYpis1s
    eS1Fo8Mjgi7ucTvYo9aIaXtOB/73L1YM4sCtarqJZqvGWCcTaMxfc7HBxZVtKcb4wJvczJ
    DhWGHrpbBlLD6ge7X4kHBWKewvm6YVYsr45UakZ5Q7HzmsGDeJz5eRFyJToaZGUUTIwjiJ
    yalidQOWiPKcNzTs9pKQ7mOgU4SCuGwVAYQlV41nKioPZgy9HanYgoNCcWM2YM4gaw9TNP
    mdJ72gP3f6FG12kya8a+TGGjVcnp9Lok8H/20qPi80IexeX8J/hf2KI4CDbytSCd4F1mUJ
    JtvWfWJX2J+PDTRIpyCkiU/p4ZK7j0ildAASL/a4jisJUFqvA4VooHn9uNFYYxKsEJfI4S
    rSwrV6wUbwsYIIn3tVsZtpasauV73VGEZRZ49ngUE2b99FDhpIoAozH7GXQOiogAcJNS8+
    DnEgDZwKE1awDWKAuQDYMum9QqRIqsDhcMiFIctw1LcpYZV64AULTeIbHGkp7o9Gm+YN7B
    ZxW1Z6zG1AUjtItBDbdXd/IgJBVpwju24VFpuMr/5Q36mi3uRQVxEUAI9YGv1U/0XJJHuj
    JeCbMLrTA/D6HN1LcLdhop93y+fiheEVISd3AcyjLbPfd44aCxTbDXevs0ig
X-ME-Proxy: <xmx:MMzQarIIKWVPhU3P_F4pN9US7en8m23-GcvRTeu3GHEyQ60xBGTfOg>
    <xmx:MMzQav6o05HUtsc2wfRc8TCtA3LTflDIv9sxh0CUNo8Sp6yis9mgEQ>
    <xmx:MMzQaslX4HyepFWK6-873Jo7lrDtezkVNsh0vFLzjDqFly4d9tvpTQ>
    <xmx:MMzQasSMTjuKD4Y9V6salpe5zd1tz5X6igUYJdJtebn83pv0dO8ygw>
    <xmx:MczQahhKbGrNgwbwiREVVR_uNxM75mkZDGAeDd9HN_mewaIWNneCvGLz>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 08:50:56 -0400 (EDT)
Date: Thu, 15 Oct 2026 13:50:55 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <atDL-nSFP2KVU7cI@thinkstation>
References: <20261009125503.126202-1-kas@kernel.org>
 <15a9e03e-c748-4e51-b8cc-583a3610c897@kernel.org>
 <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>
 <as5q14OsbK2CmOrh@thinkstation>
 <20261014202936.GC371161@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014202936.GC371161@cmpxchg.org>

On Wed, Oct 14, 2026 at 10:29:36PM +0200, Johannes Weiner wrote:
> On Tue, Oct 13, 2026 at 06:37:20PM +0100, Kiryl Shutsemau wrote:
> > @@ -4127,6 +4127,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
> >  	return page;
> >  }
> >  
> > +static inline bool order_nofrag_promoted(unsigned int order,
> > +					 const struct alloc_context *ac)
> > +{
> > +	return ac->reclaim_compact_order != order;
> > +}
> 
> order_defrag_promoted?

Works for me.

Andrew, could you fold the fixup below?

---

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c593913a14f8..440e515be50b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4127,7 +4127,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	return page;
 }
 
-static inline bool order_nofrag_promoted(unsigned int order,
+static inline bool order_defrag_promoted(unsigned int order,
 					 const struct alloc_context *ac)
 {
 	return ac->reclaim_compact_order != order;
@@ -4260,7 +4260,7 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 	 * Promoted requests fall back instead.
 	 */
 	if (compact_result == COMPACT_SKIPPED) {
-		if (!order_nofrag_promoted(order, ac))
+		if (!order_defrag_promoted(order, ac))
 			ret = compaction_zonelist_suitable(ac, order,
 							   alloc_flags, gfp_mask);
 		goto out;
@@ -4642,7 +4642,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	 * for compaction without freeing anything.
 	 */
 	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER &&
-	    !order_nofrag_promoted(order, ac))
+	    !order_defrag_promoted(order, ac))
 		*no_progress_loops = 0;
 	else
 		(*no_progress_loops)++;
@@ -5024,7 +5024,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (defrag_mode && (alloc_flags & ALLOC_NOFRAGMENT)) {
 		alloc_flags &= ~ALLOC_NOFRAGMENT;
 		/* Retries went into making blocks, start the fallback afresh */
-		if (order_nofrag_promoted(order, ac)) {
+		if (order_defrag_promoted(order, ac)) {
 			no_progress_loops = 0;
 			compaction_retries = 0;
 		}
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
