Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792950475;
	b=O228hLYEVRXfq9uj9WuRkbjPOh1G3OBvK24lmVwoBmKSwiuJhsDzliwd37C7BxVJPSuo
	 luyGyU8zEmV4ZclHTT40Jj1omGt7852XHfzxYDFbFMKA1n9payMd/l/+9aKjflQ/ktJaP
	 /i4DhrnTSNJ+cNheu3emDqPoJmdLCZEcCVs0doaolGncuHcTrsMp/yV69T3rT35jIR8yD
	 rNh18EHtjxdUfrreOviv+akibt5Y5DnUHPFsMbEpq1F76sW8Vq7vGI/1JC+K75wUHL4V9
	 e1W/AUKoogbjwSlBiW4y7XWuTuB8PAU6wUZ2AKDhXjiAufsDKnpBhIG7GP2p9N3felQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792950475;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=umoLJmKZTlAf2lH0+QaiNGrYZlN8I8eaFHN45iIXEqE=;
	b=xltr3B++7L01Gyr9RaXnESE9PwwfYVEM+i+GDKnwHtL9ff4Zx1jiY22sHPT3Z5Mq09h3
	 /mYuqdCWtUtw86YOXk2E0EpXWIhpexFoY4Bzks0AnGA5I7VQpoXbYee8uY3+sKaXB7ZC0
	 cqG86nifkFiZyM6EklUTCZaAxtJgudblap77rr8USmVEbpO/TrpwkzyMWKgnirPU2MUt3
	 MK2c+m2CIHGsJSedHv56qIW7NmMcNm4zDCOMTXWVsG6Ydx9kYqedfhOdpjHBx1qOwzvak
	 v8G4RSVYkRJqDvXP8rBupfqI+29m3PmF+4uVTLWM0LC9WOwXJQKw0/buZz4pwU23Msg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwfF9bpF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8479F606A321;
	Sun, 25 Oct 2026 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwfF9bpF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076971F01825;
	Sun, 25 Oct 2026 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792950475;
	bh=umoLJmKZTlAf2lH0+QaiNGrYZlN8I8eaFHN45iIXEqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KwfF9bpF4oRYrf7S8breNvRCiE8XkSYmqI1+/LvQkoxystZZh0MvwQtj6Vk/nIonf
	 I6th8/DcipruVViu8UHTwLAXW3xnDiHsL366t7jvLnaKIlrAUcEHblTAorINeIoryG
	 s1KMtV28iqJ9WRhBmg50gEixPnMhIhl924uAx2fDRUyi9Tyq4qE5IyL1AqFV84Cz8X
	 gWsdQ5EGjixn1svyOHna+qhsq9qFPiPlINt+1dkttT7fyfG3fErWhqrisjBdPB/w6w
	 BI62ym0X6bNV2PZzEOCBYvLnw2xQfqU7UmKksyIa6RfW4O6frlip5qKGBgdQYDC+27
	 K61RhAXvh3obw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH 6.18.y] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Sun, 25 Oct 2026 10:47:47 -0700
Message-ID: <20261025174748.165405-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025172712.164385-1-sj@kernel.org>
References: 
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

On Sun, 25 Oct 2026 10:27:10 -0700 SJ Park <sj@kernel.org> wrote:

> Patch series "mm/damon: move zero damos quota target_value handling to the
> core layer".
> 
> Having zero DAMOS quota target value can cause division by zero.  DAMON
> API callers are checking the target value parameters to avoid that.  It is
> easy to make mistakes in some of the multiple API callers.  Move that to
> the core layer.
> 
> Patch 1 adds the corner case handling into the core layer DAMON parameters
> validation logic.  Patches 2 and 3 remove no more needed DAMON API callers
> side handling of the corner case in DAMON_LRU_SORT and DMON_SAMPLIE_MTIER,
> respectively.
> 
> This patch (of 3):
> 
> If a DAMOS scheme has a damos_quota_goal of zero target_value,
> damos_quota_goal() could trigger division-by-zero error.  Hence each DAMON
> API callers should do the zero target_value validation.  It is easy to
> make mistakes.  Actually such bugs in DAMON_LRU_SORT and
> DAMON_SAMPLE_MTIER were found and fixed [1].
> 
> It is better to handle the corner case only once in the core layer,
> instead of multiple places in all DAMON API callers.  One straightforward
> option is using an alternative denominator for the corner case in the
> damos_quota_goal().  However, the zero target_value is meaningless.  In
> this case, the quota goal is always evaluated as achieved or
> over-achieved.  The quota will only keep being reduced.
> 
> Simply avoid using zero target_value by adding a check in the core layer
> DAMOS quota goal parameters validation/commit path,
> damos_commit_quota_goal().  Update it to return an error in the case.
> Also update its caller to propagate the error.
> 
> Notes for stable kernel porting.  The upstream commit doesn't have
> Fixes: and therefore not ported to stable kernels.  It turned out it
> fixes commit 8b549a4fd3c5 ("mm/damon/sysfs-schemes: commit damos quota
> goals user input to DAMOS") which was merged into v6.8.  The user impact
> is a race condition that can result in divide-by-zero.  Hence backport.
> Reproducing the issue requires sysfs write permission, certain DAMON ABI
> usages that are supposed to be uncommon, and a rare race timing, though.
> The issue was discovered [2] by Sashiko as a part [3] of its bug report.
> 
> [2] https://sashiko.dev/#/bug/linux-7f814c9a-986f-4103-a55a-ef9537dcf62b
> [3] https://lore.kernel.org/20261021005234.94107-1-sj@kernel.org

On v6.18, DAMON sysfs interface calls damon_commit_ctx() for validation
purpose, for parameters commit but initial DAMON start.  Hence this patch fixes
the issue in parmeters commit but initial DAMON start.  I will post a new
version to cover the start case.


Thanks,
SJ

[...]
