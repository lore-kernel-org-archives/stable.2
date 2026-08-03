Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A102848AA;
	Mon,  3 Aug 2026 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761629; cv=none; b=r+GSYcMCjY2dt9KTYmPUnExxDGdgr0pSDUEJvU7n0HMxGnmt2orxFiSbRBO5qJiRDXGhvUiXLyVsmpPM5lKIL8VMhw2yvksnBym/loF0nnYtkRI0RWIXFgHy9Gc3FFtELfHqm3/k97zerYs4r94ooGU6xlTgSwgHUeO9YGf5SQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761629; c=relaxed/simple;
	bh=ayQAl1BoqFaeUbBRmt64vIc9EgtB92ieqEmhoYrmDw4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cedhKkq6sTGs6+o1xoxC5HPLLjvVuUyR9Lme1IUlDAYOn7jitFF5vTW/jd3CarfmgbwOieCvbF3RwnHKQ4SvcCz5S+QnjqINc0E2ui5sAY7So74ACatK+MjzKGELbwPKndROvBIO+5Rmz+5++e0j/r3VTymEn7XIkYFeiY2zl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lvb04J3H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lvb04J3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6798A1F000E9;
	Mon,  3 Aug 2026 12:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785761628;
	bh=RbLnWJ2TZnEy0ypqzX5nO/5wqlJr0zpM8nn8QVAOlVo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Lvb04J3HuD0TQbm4JZKmX9GRix6GQncP81O9SssQ5HWd+2a4+DO4oEo0hvwK6ICab
	 goAclVUTr1dEfr+HJ9iFz6z1brSQ3ezAWAy8zns1SZuiN4DnN049hetXJ62njdOEr4
	 6aLXqRok0SDwAYvdyka8Y43XphWR63RVaWjzeH0GE/npLBhefEkuWry4lUC2dihAI3
	 H4LlDgVSxhRvLw/gFOmRCT0Qs9G1uYB46cSDB/u2JFqzHGOfkDUTO/1PZqEVbGmeRD
	 aPiMVbJsgmWyU3QtbE874qxabt3YSYXCmy+MMtK1iHo922cNV9sMTSxK2U3caaXHDU
	 hrNzBs74RtYlg==
Content-Type: multipart/mixed; boundary="===============1505895571335451361=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a66afeeafca30042408238757e166de2d5ed5bc93a4098e0d57627c63ed7efb2@mail.kernel.org>
In-Reply-To: <20260803112218.3361213-2-dingning04@gmail.com>
References: <20260803112218.3361213-2-dingning04@gmail.com>
Subject: Re: [PATCH bpf v3 1/4] bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
From: bot+bpf-ci@kernel.org
To: dingning04@gmail.com,bpf@vger.kernel.org
Cc: memxor@gmail.com,greg@kroah.com,dingning04@gmail.com,stable@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,davemarchevsky@fb.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 12:53:47 +0000 (UTC)

--===============1505895571335451361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
>
> The verifier can mistake an RCU-loaded map kptr for an owned reference and
> assume bpf_refcount_acquire() cannot return NULL. The kfunc uses
> refcount_inc_not_zero(), so it can return NULL after the last reference is
> dropped. Passing that unchecked result to bpf_obj_drop() can crash the
> kernel.
>
> Only treat the argument as owned when the verifier tracks an acquired
> reference for it. Borrowed pointers remain nullable, while owned pointers
> keep the existing behavior.
>
> Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref")

Does this Fixes tag point to the right commit?

Looking at the code change, the fix adds && reg_is_referenced(env, reg)
to an existing condition that checks !type_is_non_owning_ref(reg->type).
The problem being fixed is that the verifier incorrectly assumes pointers
that are not non-owning refs must be owning refs, which fails to account
for borrowed RCU pointers.

The commit 1b12171533a9 added logic to mark certain pointers as
non-owning refs, but the bug appears to originate from commit
7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for non-owning
refs"), which introduced the logic:

  if (!type_is_non_owning_ref(reg->type))
      meta->arg_owning_ref = true;

That commit incorrectly assumed pointers that are not non-owning refs
must be owning refs, missing the case of borrowed RCU pointers which are
neither. The current fix addresses this by verifying the verifier tracks
an acquired reference before treating the pointer as owned.

Should the Fixes tag be:

  Fixes: 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for non-owning refs")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30810949269
--===============1505895571335451361==--
