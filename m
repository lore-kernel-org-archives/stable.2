Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792804956;
	b=CHbAIX5cZhE6E3lUwG30do0B3dvlikKAmxKaVRbHqCpDMnu7wtl0d1sUKahJevNgFOdh
	 oWWOk7NQJViH5WkHobIK01eJot8YTxZ8Yu8I7bfaTg/K5qIW8+YpzvLLkaRVJPOLnpW9g
	 dT4iIcQEH8G5+Cp57+7fm0FXcKOxZKMnaX1tsebsITTkfbyjbdLVJft6xrJIGJpf7oHPw
	 AoR++p5528SfcntTPeFZKQz+3QHCIt+4n9FIBEE5f5hFaY3YPH6uG1Qs2dnTos1/Ihom4
	 Z+c5FgKRG1tVteIwjJNJMo7AbtU7JapYLG0CF4KaQLj+RdTOKjKyRd5q4kZO+FvBoqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792804956;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wYR2M2iVhPBLmlpr1xOyUZypnHKQt/AYQu7IBgbQBZU=;
	b=HEtCKC/x0jr7Drr0mRoa00yBBYCEB++RnxDA0lZmX+pWyu6+YqDKcxbVMcsbwZLqRGfB
	 CjL6+OM1QoGU3zsaXJWTrJBtZjmO1rOHRc4cR0mCSl/T9a2E8+dRIg4GsWv8Moc5XMoOL
	 gKwL6Uor3BpEaYPB8ZIskd6xh/CsOlL4D+1+5K24fkeCMQVcKqBWznv4YoVvIC3dY86ZO
	 OJUBZCAJIDG4BARAwfc35hNcsNPLISjg1jJM57i2ra55BpqW9vboofVVh04f0cQ5wYGoF
	 SPubuGZDC9x2lNJ/jL0yE1ND21IcfGJGu+KN3eJCYwu7GJ0aVEfYQvNT8aqy/dkfzJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B025dT8I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645C606A31A;
	Sat, 24 Oct 2026 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B025dT8I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC7C1F01825;
	Sat, 24 Oct 2026 01:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792804955;
	bh=wYR2M2iVhPBLmlpr1xOyUZypnHKQt/AYQu7IBgbQBZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B025dT8IqnKo9J9ah00/inNxyi1JmmsDJJJ84SWS51C1yg2CHTP2TJ9S3DJ9/6Vn/
	 RQmLnqeHRn1yeUpspA5wQAgRVT9y1tNjL1JUW8CuEDzDK/JROD6+0inGu7yUMuiuFg
	 uk2qy+x7R2Y9P0ug92ptKFpmEd1YiZNGS2cCJ9qpN7oAo4G/+S6opzTkpb6ho7bnpa
	 A+mwAdsN1WsteR72rOzaIFWayrfMoQntkqSDKZLoQTgRxNAu/b3lAzylySiKi7+bB/
	 mPRUP/sbknkQuYdtSxDm3xpAyGogKgZ4KZDnZ5aIf39MgYzeOyawsS0CXYX6h2dNOH
	 A46vVSWT75AXg==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: reset watermark wait state on each iteration
Date: Fri, 23 Oct 2026 18:22:27 -0700
Message-ID: <20261024012228.88920-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179277129124.2.16132047926074873101.damon-empty-schemes@gmail.com>
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

On Sat, 24 Oct 2026 00:01:31 +0800 Aveline Noir <jm5905938@gmail.com> wrote:

> Found while reviewing the DAMON source code that if an online commit 
> removes all schemes while kdamond is waiting for watermark activation,
> the scheme loop becomes empty but min_wait_time keeps the previous 
> positive value.  kdamond then keeps sleeping instead of resuming 
> monitoring without schemes.
> 
> Initialize min_wait_time and init_wait_time on each loop iteration so
> the wait is calculated from the current schemes and an empty scheme
> list resumes monitoring.

Nice catch and fix, thank you Aveline!

> 
> Fixes: 6e74d2bf5a26 ("mm/damon/core: add a new callback for watermarks checks")

But, this is a preparational patch for online commit support, right?  Shouldn't
the Fixes: be the commit that enabled online commit?

Also, this bug seems nasty to me.  Users could work around the issue without
restarting DAMON only by installing a scheme that has watermarks that activates
DAMON again, and then removing the scheme again.  I think it deserves to add
this to commit message and Cc stable@.

Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
Cc: <stable@vger.kernel.org> # 5.19.x

> Assisted-by: LLM
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

> ---
> An x86-64 KVM test using free-memory watermarks reproduced the stall
> with nr_schemes=0 followed by commit.  The same test resumed monitoring
> with this fix.  DAMON KUnit and selftests all passed.

Thank you for keep adding this useful test results.

Assuming you agree to above suggestions, I applied  this patch to
damon/next [1] tree after applying my suggestions like below.  We are in the
middle of the merge window.
It may better to let mm.git maintainer (Andrew Morton) take time for pull
request works, rather than adding more changes that are not really urgent.  I
understand this series is not really urgent.  Hence, Andrew might not add this
patch until next -rc1 release.  In the case, I will request adding this to
mm.git after the next -rc1 release.  So, no action from your side is needed for
now.  Let me know if you find anything I missed, or disagree to the suggestions
or the urgency judgement.

Changes to the patch file that I made:

'''
@@ -8,6 +8,10 @@ the scheme loop becomes empty but min_wait_time keeps the previous
 positive value.  kdamond then keeps sleeping instead of resuming
 monitoring without schemes.

+The way to wake up the kdamond again without DAMON is bit complicated.
+Install a scheme having watermarks that can activate the kdamond again,
+and remove the scheme again.  Doable but cumbersome and complicated.
+
 Initialize min_wait_time and init_wait_time on each loop iteration so
 the wait is calculated from the current schemes and an empty scheme
 list resumes monitoring.
@@ -15,11 +19,15 @@ list resumes monitoring.
 /* TODO: move below to commentary */
 Changes from v1
 - v1: https://lore.kernel.org/179277129124.2.16132047926074873101.damon-empty-schemes@gmail.com
-- None.
+- Collect R-b: from SJ.
+- Add how to work around the problem.
+- Update Fixes: and add Cc: stable@.

-Fixes: 6e74d2bf5a26 ("mm/damon/core: add a new callback for watermarks checks")
+Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
+Cc: <stable@vger.kernel.org> # 5.19.x
 Assisted-by: LLM
 Signed-off-by: Aveline Noir <jm5905938@gmail.com>
+Reviewed-by: SJ Park <sj@kernel.org>
 Signed-off-by: SJ Park <sj@kernel.org>
'''

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
