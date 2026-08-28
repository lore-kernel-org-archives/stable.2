Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1EA3A4505;
	Fri, 28 Aug 2026 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787941759; cv=none; b=HmJFBWifJsEWnslpD5gVNsUqTBrbHNBR7LzxT0AlfQwnupHBuDXAMPQKFcxziMpV712Ymy2iXL5mXEezj4ZtCOJvPXYNDomgeG/9X42X1rU+oPTjVmRpSRerJQR0bylOETdgq4YmS9vS3vZGpViQ0Udc5g8UW6YplpDymiiegqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787941759; c=relaxed/simple;
	bh=tYCi2x5F+r0yfVDr8C945+5FuD0jcgPWMELcRlga2pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlWscIAKNfRfnTm2jAcZ7Yr+KQpCXrwWBgzgfxjCorNkDTx+dyQidmiPFdm0480WU2UBoHXTwIHgwYV6pWV3YWLCoU6xiS7d75OpiFUipiStqKFubYSSt0BgE6C5+AjY0hVXS/D27FczRXcO/xk2x3PXKrYn3EmYYqSnKPN7LXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5vOSBrJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5vOSBrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183801F000E9;
	Fri, 28 Aug 2026 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787941757;
	bh=QeOHqKFwwRXxKDoOadJ6pEtYZjxux1n/oCSHCxWNGR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V5vOSBrJlYoEX0iEEqFMvHyD/qvqqQD6D8XY4ZUpfg4jNKBDyLgJq5Zb+GQQ3GSI/
	 ZqWPV5YPCatrwZazeLHntHVDTKLi6fSFRzXWNQs45KQ4n+kQG4BYp5jfIT16Q/H/mh
	 jZezdZv/flg6Ym5n/H7JQPAzZ4VVOf40vu3kb0evCD8LtY2M0tY/YkZ9xDDJy2XYlw
	 gsz9GiW4nm1b9HNHCGwf0QXiqrYgq4k9zjigo3iWlrcJGULrFs5g8emNh+35bHcc3b
	 5q0NugBsnP6oRcJ2jZGthMU9G5y+5NPSUpvTyzXgTXsBE7EQZDwiBwATFOvhMZtzhx
	 gRtHWBUzW9fbw==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix unconditionally skip last region
Date: Fri, 28 Aug 2026 11:29:09 -0700
Message-ID: <20260828182910.70304-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828084737.290024-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 16:47:37 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Once quota set, the charge_{target,addr}_from unconditionally skips and
> resets at the last region of the tracked target, so the last region can
> be skipped even when it has not been processed.
> 
> Example:
> 
>     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
>     2. Quota is configured to process only 50 bytes per window.
>     3. Window 1: Processes R1 (0-50).  Quota is full.  Cursor is saved
>        at (Target, 50).

Cursor means charge_{target,addr}_from, right?  Let's explain that, or just
keep using the terms (charge_{target,addr}_from).

>     4. Window 2: Skips R1 (0-50).  Processes R1 (50-100).  Quota is
>        full. Cursor is saved at (Target, 100), which is exactly the
>        start of R2.
>     5. Window 3: The loop reaches R2.  Because R2 is
>        damon_last_region(t), the old code unconditionally returns true,
>        skipping R2 entirely and resetting the cursor.
> 
>     Result: R2 is permanently skipped even though it has never been
>     processed.

Let's make example simpler by setting R1 (0-50 bytes) and R2 (50-100 bytes) or
quota size 100 bytes per window.

Also, it continues being skipped only in a corner case that the region
addresses and the access patterns are kept.  So the user impact is mild.  Let's
clarify that to not make users unnecessarily afraid.

> 
> Fix this by only skipping the last region after it has been applied.
> 
> Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
> Cc: <stable@vger.kernel.org> # v5.16.x
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
> 
> Changes from RFC v1:
> - Minimal fix, only fixes the issue where the last-region is skipped.
> - Add an example to the commit message to demonstrate that this error
>   occurs very rarely.
> - RFC v1: https://lore.kernel.org/damon/20260825124616.5129-1-aethernet65535@gmail.com
> 
> ---
>  mm/damon/core.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a1656..21dc6b086c42 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2347,14 +2347,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
>  	if (quota->charge_target_from) {
>  		if (t != quota->charge_target_from)
>  			return true;
> -		if (r == damon_last_region(t)) {
> -			quota->charge_target_from = NULL;
> -			quota->charge_addr_from = 0;
> -			return true;
> -		}
>  		if (quota->charge_addr_from &&
> -				r->ar.end <= quota->charge_addr_from)
> +				r->ar.end <= quota->charge_addr_from) {
> +			if (r->ar.end == quota->charge_addr_from ||
> +					damon_is_last_region(r, t)) {
> +				quota->charge_target_from = NULL;
> +				quota->charge_addr_from = 0;
> +			}
>  			return true;
> +		}
>  
>  		if (quota->charge_addr_from && r->ar.start <
>  				quota->charge_addr_from) {

As Sashiko pointed out, this doesn't work if the the last region's start
address is smaller than charge_addr_from and the end address is larger than
charge_addr_from, but the size to skip (charge_addr_from - r->ar.start) is
smaller than min_region_sz.

As you replied to Sashiko, let's do the last region handling in every case.
While doing that, let's do the charge_{target,addr}_from reset in only one
place, like below.

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2688,36 +2688,40 @@ static bool damos_skip_charged_region(struct damon_target *t,
 {
        struct damos_quota *quota = &s->quota;
        unsigned long sz_to_skip;
+       bool skip = false;

        /* Skip previously charged regions */
        if (quota->charge_target_from) {
                if (t != quota->charge_target_from)
                        return true;
-               if (r == damon_last_region(t)) {
-                       quota->charge_target_from = NULL;
-                       quota->charge_addr_from = 0;
-                       return true;
-               }
                if (quota->charge_addr_from &&
-                               r->ar.end <= quota->charge_addr_from)
-                       return true;
+                               r->ar.end <= quota->charge_addr_from) {
+                       skip = true;
+                       goto out;
+               }

                if (quota->charge_addr_from && r->ar.start <
                                quota->charge_addr_from) {
                        sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
                                        r->ar.start, min_region_sz);
                        if (!sz_to_skip) {
-                               if (damon_sz_region(r) <= min_region_sz)
-                                       return true;
+                               if (damon_sz_region(r) <= min_region_sz) {
+                                       skip = true;
+                                       goto out;
+                               }
                                sz_to_skip = min_region_sz;
                        }
                        damon_split_region_at(t, r, sz_to_skip);
-                       return true;
+                       skip = true;
                }
+       }
+out:
+       if (r == damon_last_region(t)) {
                quota->charge_target_from = NULL;
                quota->charge_addr_from = 0;
+               return true;
        }
-       return false;
+       return skip;
 }

 static void damos_update_stat(struct damos *s,
'''

Btw, I think damos_skip_charged_region() may deserve a kunit test.

[1] https://lore.kernel.org/20260828090410.40AEA1F000E9@smtp.kernel.org
[2] https://lore.kernel.org/20260828115047.332978-1-aethernet65535@gmail.com


Thanks,
SJ

[...]
