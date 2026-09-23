Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69755931D
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182048; cv=pass; b=tdmhQiQHXZfqtpysPr8ZrgFCpzu/YWHRQZ+o0drtJSzv8hp0UJCTV+X6letZJflB+45nPI7DIVj/qXCtcOg0lyYw5dvCSSW2JFQ07exfG5O7E5j5dr5xWb+0oxyQ1ez1gHBx1zAU3VmTJ44AY5W6MJhlaSFyzrj+4ZpnFJtqnCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182048; c=relaxed/simple;
	bh=ZUu/E4ThfNs6/hpOHi+oCAKFDMTBtwuUpcdaOif5M+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGhiumCnEyIpWg6GJ3N8ufpjaEKhaLacl3QzSkSDqWIJLK8ToMNW7W4YnzgXL2rjiSKMNWlNui9PBHiWnMEQY2Wrv8ZnLJExxiC2edmAEzLNuCVKwljby1yzxHhr54sejqBnf34wRhYovNqAi9pCMWuGynJR0kkxqRLg/qks+HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRm2k+p2; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRm2k+p2"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so8366135e9.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 09:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790182039; cv=none;
        d=google.com; s=arc-20260327;
        b=H+UMwCJ1ScF+oyUR2xkB8xNo/v4AlADK+XemdVuQD9MvlxBfxcJGQ22CwRp3soHbbL
         dRM3IAQDpKkvX81xa0x2ac2tt0YHEr6vK7rJY9+pZ1P2X0eCVfbNvxfkpdl98wINTsNl
         QRbyVV/q40hjucLfXIHXSXfH6rO+zCh41OTt2PYxZstkDZMQTQkIsHox3mSYD/0RelqW
         Opip8aRoeA/aW7CyqpvLtX0BbPYkPS5Km+OmzXWE9zH3ZRzXrn7czYno3MVnCxiF5Lmf
         bpVj96ab1p18GeY7FtSqm7HvR5uGJpiRNQca8jcYJpa3ktJrkhYPKzKM675MSHMWJa8d
         VrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tAQcvfsEw2NREatFJ5f2rKVMnBOJ07JjjvYvVs9Yqug=;
        fh=FPduv9OoaPEIQ5BbCbLm/VuHKlVRBoS0V8YLEjf+03I=;
        b=QxgtWe7cb7WJjZTMLKPETlXugHHxmCyHYsnTWvz30CzP9xY4bUImyAk7wt5SzBZ3K/
         BC48Ocubhq1F3yaJPmqIkvULXdWHNJgLsSwPD1pnxI1kj5CwtjxBBszVZ1jmAS47MtD+
         yJ87jdhTMOf4thZOFXkHeUqwgp3PR2nPHlqVvbSm43cnt0/zI7TfHQ/6uDvcTE3gm9i9
         FgT02h/LeUfgaMLS3w8+DETgbvRh66uOnX6zeaUuWar1XFLBnBxf5TH1weZn2LvTfZ0L
         8nG7gCog9mrvefJbldkqUbsCNQAMIqAz+DOvBEO5n1vU4x0UgIQFRBqlcBU2MJ9Mlx6o
         tpow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790182039; x=1790786839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tAQcvfsEw2NREatFJ5f2rKVMnBOJ07JjjvYvVs9Yqug=;
        b=eRm2k+p2QYxUN5yPzHo1FVb7o4MDsaEyhvy/R+BHFhYrvaxTN2O9FVI6nKV7GMOtC6
         Yxyez1QH31RC1hPnMP+To9pLJoKAKOo5KXJ0JuXbizMmUKOnH2PwZpAIbNn6F0hcxJqJ
         zxWnJNTa3L7suTs8BW9WtSSd5u8S/MyEXzLxZGXP60pr+MpR6uwC4Pisrn7xk4k3ACUi
         Xm5GJmfgWhMOnzEfwx+pTmuNJYeTIynH1SomvwQDcHA+zprTQN359Fz8A00NPNkIOFa1
         ny+jtbYvxL1J1HGvbs4BJdn52MjqNFbmy0+IZj5YPNM2KnWgnNLOsgg+7DhdLL1W7TJ5
         BHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182039; x=1790786839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tAQcvfsEw2NREatFJ5f2rKVMnBOJ07JjjvYvVs9Yqug=;
        b=bcPdjgV6eTfZYzR32Tg11Ri4UENx7hARCOr5sQbg+PWJAKjEZjqGtKZfbOYko9t93X
         odJAwCsPxsc0VFnNtAEgf9Q2uEfE5vwBuzNSZx0Tx/aeaPXZV1d0KxN3Mgf8g6fNBYyw
         a7zMWnaG6xJsbP/8sqn5uugrfn7Zows/8fdbRs57NAn46P7bcWwu9TUE6BgVd58bK0Oi
         DcWZ5GF8XA95n2kF7nSARrVGZ/QIY0SwzLfcOg1l5odcT+A3WJNbwPEpwvHMsWIQ8zBd
         GE0Ji0zv4WF8hzLh820ORMSmw0i1Qfbg5aQw4I+nypY5weEtJ5HAQGISYMjQFST6dJn6
         e/8g==
X-Forwarded-Encrypted: i=1; AKwUvBw2owPE1jiWbUZwWJOF9anIFFuUI38tk8mt0bnHEjgqN4zGd1u8IVnHM4fT7pxazoMKvQpsBEI=@vger.kernel.org
X-Gm-Message-State: AFuF++mUJgiCEUYmX9olGD8pIwIThoCgX7Grq5AiqjgiLpm8NURtVYIQ
	xzOQZ11F3V98hsZvPAczzBNEHBnMHeGirbKPCsCz9WEavB6vuMxXm1PtDf5Lxq42fChlwgouO/0
	VXyBFwBv1qh3S8AoKLKq2IxYdJh9pmdg=
X-Gm-Gg: AYBFou2B03fZshokn3afY7xaTQm49qduCJD/FOpVGeDAVD9edCgIwUNbSMcF4yvlc/w
	m0D06bBYifeDGiGCEXcEkgNPrWtx+FamZzFWRGVMSVKUwI+fypE/um98QUPXVRabvNE2qxwrASF
	h6ZKhzkgIRzEtLTB4eNg/1hSqfwSn344/90lx3Si+32T0wkplw97iux/Ct2GN05Qb/dwe7l7PFs
	nDOzqqnwDmXTh28NjHXba1U/sFgthCfYdW9276ab+DVNV1wAcG90EEkqZyd30EfN+MPJ6OQoYse
	JnyzqMW2mR8qRUgikohvclfudgmPK+RHF0+896ecNZ8A6F1nYl1UDbVMRS98aQcuNi1+GUUJcQy
	GDtjzSumJ3hnQGw==
X-Received: by 2002:a05:600c:4e93:b0:49c:e27c:6b10 with SMTP id
 5b1f17b1804b1-49fdee0a952mr49666665e9.3.1790182038728; Wed, 23 Sep 2026
 09:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923055139.2982-1-sj@kernel.org>
In-Reply-To: <20260923055139.2982-1-sj@kernel.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 24 Sep 2026 00:47:02 +0800
X-Gm-Features: AclHuK-q8bibuGsWXEsNmxKAcN1nnzvypJ4ztbgQ6XSyFRq2oe6A825P900qgHo
Message-ID: <CAN_Opa_d=Dta4hRcvXuyi0wj+uoOgLxOCuHU3K4d9o34e_Aypg@mail.gmail.com>
Subject: Re: [PATCH v3 mm-unstable] mm/damon/core: keep the temporal tuner
 quota over an unmeasured PSI round
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Karl Mehltretter <kmehltretter@gmail.com>, 
	stable@vger.kernel.org, Lian Wang <lianux.mm@gmail.com>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the update.

I also checked the issue I raised on v1 regarding unmeasured rounds.
The temporal case now uses the effective quota to determine
current_value when there is no previous PSI sample, while measured
rounds continue to use the PSI delta and update last_psi_total.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

On Wed, Sep 23, 2026 at 1:51=E2=80=AFPM SJ Park <sj@kernel.org> wrote:
>
> From: Karl Mehltretter <kmehltretter@gmail.com>
>
> The patch in mm-unstable of subject "mm/damon/core: handle uninitialized
> damos_quota_goal->last_psi_total" scores a PSI quota goal without a
> previous sample as achieved. This leaves the consist tuner's input
> unchanged, but the temporal tuner sets its quota to zero for an achieved
> goal. A running scheme with a nonzero temporal quota therefore loses a
> charge window after a quota-goal commit.
>
> Use the effective quota to preserve the temporal tuner's previous
> goal-achievement state during an unmeasured round, as SJ suggested [1].
> Score the goal as achieved when the effective quota is zero and as not
> achieved otherwise. A new scheme's initially zero quota stays zero, and
> the consist tuner's behavior is unchanged.
>
> Move the PSI current-value calculation and last_psi_total update into a
> helper that takes the current PSI total. This lets a unit test cover the
> unmeasured and measured rounds without depending on system memory
> pressure.
>
> Link: https://lore.kernel.org/damon/20260916001311.101024-1-sj@kernel.org=
/ [1]
> Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goa=
l")
> Cc: <stable@vger.kernel.org> # 6.9.x
> Cc: Lian Wang <lianux.mm@gmail.com>
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> Suggested-by: SJ Park <sj@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
> This is a fixup of a patch [1] that is still in mm-unstable tree.
>
> [1] https://lore.kernel.org/20260902002725.108635-3-sj@kernel.org
>
> Changes from v2
> - v2: https://lore.kernel.org/20260921020013.33105-1-kmehltretter@gmail.c=
om
> - Split out of the series for squashing into the broken patch.
> - Collect R-b: from SJ.
> - Update commit message to make clear this is a fixup of a patch in
>   mm-unstable.
> Changes since v1
>  - v1: https://lore.kernel.org/20260915060937.3423-1-kmehltretter@gmail.c=
om/
>  - Use the previous effective quota for the temporal decision, including
>    when it is zero. Keep resetting last_psi_total for new and updated
>    goals.
>  - Move the current-value calculation and last_psi_total update into a
>    helper. Test both tuners with explicit samples and check
>    last_psi_total after each call.
>
>  mm/damon/core.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 4687b909d42c..733025b36745 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2956,6 +2956,28 @@ static inline u64 damos_get_some_mem_psi_total(voi=
d)
>
>  #endif /* CONFIG_PSI */
>
> +static void damos_set_psi_current_val(u64 now_psi_total,
> +               struct damos_quota_goal *goal, struct damos *s)
> +{
> +       u64 last_psi_total =3D goal->last_psi_total;
> +
> +       goal->last_psi_total =3D now_psi_total;
> +       if (last_psi_total !=3D U64_MAX) {
> +               goal->current_value =3D now_psi_total - last_psi_total;
> +               return;
> +       }
> +       /* uninitialized last_psi_total; make no effect this round */
> +       if (s->quota.goal_tuner =3D=3D DAMOS_QUOTA_GOAL_TUNER_CONSIST) {
> +               goal->current_value =3D goal->target_value;
> +               return;
> +       }
> +       /* let temporal tuner show the same achievement as in the last ro=
und */
> +       if (!s->quota.esz)
> +               goal->current_value =3D goal->target_value;
> +       else
> +               goal->current_value =3D 0;
> +}
> +
>  #ifdef CONFIG_NUMA
>  static bool invalid_mem_node(int nid)
>  {
> @@ -3208,13 +3230,7 @@ static void damos_set_quota_goal_current_value(str=
uct damon_ctx *c,
>                 break;
>         case DAMOS_QUOTA_SOME_MEM_PSI_US:
>                 now_psi_total =3D damos_get_some_mem_psi_total();
> -               /* uninitialized last_psi_total; make no effect this roun=
d */
> -               if (goal->last_psi_total =3D=3D U64_MAX)
> -                       goal->current_value =3D goal->target_value;
> -               else
> -                       goal->current_value =3D now_psi_total -
> -                               goal->last_psi_total;
> -               goal->last_psi_total =3D now_psi_total;
> +               damos_set_psi_current_val(now_psi_total, goal, s);
>                 break;
>         case DAMOS_QUOTA_NODE_MEM_USED_BP:
>         case DAMOS_QUOTA_NODE_MEM_FREE_BP:
>
> base-commit: 4b811cf44e3dd87981f18631be832027385f7d4f
> --
> 2.47.3
