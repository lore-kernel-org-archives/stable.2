Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792950415;
	b=4aQ17taHsCcvi/uQv5zsxWdb2J1VVZjRroOkfAD/WD4AelXZHkIRra+iTdit3EY6J1yq
	 5wdpdZopgH3HcYq1+w5dLWgHTAmAMx567iXOI66k/LuvILT4Q1Dtc7zfRAZBDGSaC/fse
	 6YbVaW1sy7s1WUi+JKVRUoAOoAvrvpgTsGAKj3ZqBxl5w76s8qldJEPtnmW/xRdb7v8L0
	 FK68SceqlRC5s72hXmdsJk/9mf9L/b+gNb4EX6tsWlnnyFQyhsuxr+MF04iv9S1iEYlPW
	 R4U0N8R4bV5DvGK3/VHW6hkWo/lx+5aCSESCr7jh2vaEbd9nC75UJGgw2eGv5G7k0JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792950415;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bAufoNrYjBpv8soDMVz4gw6z9qVyFbxX6lvDmVDSc8U=;
	b=Oqs6tam3diX0TNKDsrHgfQNLbvonwyf69aSl3ZlGnGDqJe0XKmM46psFa9fUkBFSPY5x
	 oknw0+V3eaCgdHpolQERjhEh4tb1p9jqlDN+cS7iGkzBf0xMW7gICUgSOngilAbRQKS7h
	 CYkuiTtRkf+GxJq1/oUkoL2/jIpdwKicbvoyCr7ysBlZOfWEZKC6lm0SXWgb9yIV+7RyC
	 oTe/V0Vf4XcRQx4zhk9zb3uCkSp6ZD7YYAZHw2mF0xzKSuGvC5y+xbd4DXZTmPc61QtQ8
	 eHUbzs3MnoBoszv6fi2AbUL+nmpxH2PCL7fvttRzb4bfRISXGjHFV7+sX95okDsra/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Orn4yYUx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3166E606A31A;
	Sun, 25 Oct 2026 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Orn4yYUx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4A51F01825;
	Sun, 25 Oct 2026 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792950415;
	bh=bAufoNrYjBpv8soDMVz4gw6z9qVyFbxX6lvDmVDSc8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Orn4yYUxVQAf+rb3mcBcf9FcX+InyQ9gvp6Wym8xXBBOuurayefwVEqnLgDHb7liz
	 4nnLLaOv9GgQDJ9+XSn9N8DQAtCrYMSF7uTC8uhu7hPvTihAavVIhULWn1grlUZuvG
	 dyqg2ZfvVCH0bwVD5qg6zb7wDQPlOvuqixyZ62z85o84JNJrzvVcPwdFB+KQX6pzDH
	 mwkdqcL6OHbkefO1yO0NmzN79/tm7pGW7B/UBwcsPquQavTMH3CBWotUDDyd8DwXo2
	 MaYP95jK7Cg9uAoWnJpKbG6syPVtTHXx4d54IKh6PA6IHhkERtzk8lLAtUw5zAH7kD
	 exfgHHU/1Flnw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH 7.2.y] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Sun, 25 Oct 2026 10:46:46 -0700
Message-ID: <20261025174647.165255-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025172434.161597-1-sj@kernel.org>
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

On Sun, 25 Oct 2026 10:24:33 -0700 SJ Park <sj@kernel.org> wrote:

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

On v7.2, DAMON sysfs interface calls damon_commit_ctx() for validation purpose,
for parameters commit but initial DAMON start.  Hence this patch fixes the
issue in parmeters commit but initial DAMON start.  I will post a new version
to cover the start case.


Thanks,
SJ

[...]
