Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D02389116
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927147; cv=none; b=jO//eGFMHVbail08zm53Rqf4BaM03J4P7GOBXLeyr3HbQsS1u2V9hLMsgFRvlpcWVw0/lEGdWEa42BUgr8afD5vCgCILXg64BSYMCKrcUEVbZBykSmPIxyyqVvaCq1HeI+o6/dLe5fhE0DWyiby53n70TG3PmYW/BQLjYuObgVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927147; c=relaxed/simple;
	bh=gF7RjPEJRFWajt/OLcEI/3tzHIgjMyeLim53Upe2oFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHyhGwlFpC1dSvUK+4ewVPZ5DgdVqirHnz9q3kBlJRYiCOuyJrVGxqhYd4RNSHKZE9zcNtwgNW5SdCqb01JkpyYqSx2soZmLvqaEAmPZ1+GFNRQK7P0yyEpaa6pg3nw5hgjhNdmvxDc5XtVYjO642amPICe5jNnPWEzH54UM3ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eXnuON0z; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eXnuON0z"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so9902645e9.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787927144; x=1788531944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BoxMq16+fYtVCLi36Xsb9nn9RavJ5HgJioRujA1lSB0=;
        b=eXnuON0z7SL4oznMBGst9qSBcOo3fOl/LXUzgaBWnOHkjqXCUiOSiSCofWmNzhHuFt
         C9xsrjVFAkWVcRXUi26Je2nO0TvJRYOAaewoLpq1ve3q6g2jZk8jh2rGROy/4aQSRHYW
         6ORnDst3cZZHfeFdJYvQqM8KJRef48cFX+G9wSS4GUWORN26q6PcvCDEPdVPjduqDrSO
         9vGlee0KGMyx+Rz+pfZl09rQERxM146WBE1qkQ4AbtGa1c7YMbrzTbyjtusCuT+t6sx/
         wXzZ4Jzs2EDS2Xsncu2VaGp0cy3O4sJ5uuq+Wj2Y9vtpma1BhqyAA09utlk4JNEbTIql
         uxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787927144; x=1788531944;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BoxMq16+fYtVCLi36Xsb9nn9RavJ5HgJioRujA1lSB0=;
        b=BLPTvX1J+ta2cW/BKc4rawV6lxaYpnLAh01ziUKlIe39ZQcujMkaR0zaiJucmPAiAD
         sTqtQi4gTCTPQezLjHc/FWPkwDVsLCg4VOtuUoRYeqpWalgT1mFFWlQqUdChpjVnRxpD
         eUX4Y5Nl5T9PGI9H6X7NHaafeY/tuSwrsbLDfvmJeblYblPCaYoxl8IpvlzQ1LEWNko7
         GhHfwcUrA1z0WY1lyuB41MrmC6oPDhXpWGeXyHYS15TElFfzX8x14PYs+5o4eH2dOW0t
         2nm6fZ8JzkKrAIqoDHOFX/IhcQ7OeM6VYzojq7a4inTqsAESzTNIJZvDX+2d4wHRC4LN
         Zw8A==
X-Forwarded-Encrypted: i=1; AHgh+RrdYGMvT+pLUHC/lXJSzDkWD5xWkNqR+y5Rjj9yXXbADjAQQNYUlCjfNrElCN80BHriZsykeiQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mBc6WdltlYxFFA/qXWAzh8KquLdGuZgFiiB3of4fAg63+TU6E6
	GG2TNInAQ6+F6Eb03r1a3pBDfBV00qmypkCYULBhoyOIU3sqZo47dA5vn+M19tdJxSk=
X-Gm-Gg: AR+sD13JT7plFixhGwYsnKaBcXhAJGWugRWdnijkdpF0SgL3XKQsi53XJTztrwx8Q4b
	+tp8eYG/XWdviq2ALwIZ89zmZZe44PeGVJOWckkuByY+uoTK3vT6HU7lblDruHxWd5xKTQ0CCJh
	2+ys936odUBPOKFr1rU5wbYuo0Rj1E680AH7Crg3ouXD23/exOo+tG6FPrthFhXBubH3vDhEMoj
	ZJhne9ZWsYzsw7ggin1hSfwUsiZvt4DNwE7tlwvb3Q324DqpEpqCKExyScPqBGzaF4d5xutqZ5D
	8Ic1VzatH8rWiVjJv5PhTm9ARuwraNfeAaZw3SGFNWxh+h7x/4PKjKn7TzCq8n2SwAgt4w4pYi8
	rF2gJPw1143a/XziOxm6uX11fE+1Jb/FkEhiYuwECLu2BWoInatGM6de+y+bWMO5m2wsFYCZpDJ
	N9KE0iIoCkRv9L8LFd0Maud3C1ygSIQmrXgrzzXvPxj8wI+VXbXX03FyyqcmyQd1nnTOou5gr4Q
	Q==
X-Received: by 2002:a05:600c:b85:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49cc96ad411mr23596595e9.12.1787927143838;
        Fri, 28 Aug 2026 07:25:43 -0700 (PDT)
Received: from localhost (109-81-85-229.rct.o2.cz. [109.81.85.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49c5a903eebsm17011155e9.4.2026.08.28.07.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 07:25:43 -0700 (PDT)
Date: Fri, 28 Aug 2026 16:25:41 +0200
From: Michal Hocko <mhocko@suse.com>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: avoid stuck FLUSHING_CACHED_CHARGE bit on
 isolated cpus
Message-ID: <apGaZdxAPH68kkCc@tiehlicka>
References: <cover.1787890328.git.riel@surriel.com>
 <a611f2bc40d30f9c14a6f41b173185975c46a203.1787890328.git.riel@surriel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a611f2bc40d30f9c14a6f41b173185975c46a203.1787890328.git.riel@surriel.com>

On Fri 28-08-26 09:46:21, Rik van Riel wrote:
> drain_all_stock() can leave FLUSHING_CACHED_CHARGE set after the
> work is dropped.  It sets the bit before checking isolation and
> schedule_drain_work() checks isolation and queues in a separate RCU
> critical section, so housekeeping_update()'s synchronize_rcu() can
> race the second check.
> 
> drain_local_stock() only clears the bit for work that ran, so the bit
> remains set and the stock is never drained again.
> 
> Reorganize the drain_all_stock() loop, reducing nesting, splitting
> out local vs remote cpu handling, and skipping everything on isolated
> cpus, which solves the stuck FLUSHING_CACHED_CHARGE flag.

Is there any reason why we cannot simply clear the flag if the work is
not scheduled?
---

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69b37f63a307..907ac63e5067 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2261,8 +2261,10 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
 	return flush;
 }
 
-static void schedule_drain_work(int cpu, struct work_struct *work)
+static bool schedule_drain_work(int cpu, struct work_struct *work)
 {
+	int ret = false;
+
 	/*
 	 * Protect housekeeping cpumask read and work enqueue together
 	 * in the same RCU critical section so that later cpuset isolated
@@ -2270,8 +2272,12 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
 	 * pending work on newly isolated CPUs.
 	 */
 	guard(rcu)();
-	if (!cpu_is_isolated(cpu))
-		queue_work_on(cpu, memcg_wq, work);
+	if (!cpu_is_isolated(cpu)) {
+		queue_work_on(cpu, memcg_wq, &memcg_st->work);
+		ret = true;
+	}
+
+	return ret;
 }
 
 /*
@@ -2303,8 +2309,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				      &memcg_st->flags)) {
 			if (cpu == curcpu)
 				drain_local_memcg_stock(&memcg_st->work);
-			else
-				schedule_drain_work(cpu, &memcg_st->work);
+			else if (!schedule_drain_work(cpu, &memcg_st->work))
+				clear_bit(FLUSHING_CACHED_CHARGE, &memcg_st->flags)
 		}
 
 		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
@@ -2313,8 +2319,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				      &obj_st->flags)) {
 			if (cpu == curcpu)
 				drain_local_obj_stock(&obj_st->work);
-			else
-				schedule_drain_work(cpu, &obj_st->work);
+			else if (!schedule_drain_work(cpu, &obj_st->work))
+				clear_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags);
 		}
 	}
 	migrate_enable();
-- 
Michal Hocko
SUSE Labs
