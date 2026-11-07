Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794073005;
	b=07m2ZQyxIJTX5SyMHdCtImleCI3WLtRPjY7Xrm+Zvj2AG7gFl/t57tzwRcYJhgXKS7D2
	 ddgPWRxlGU7t8HKxiv0LaUv3BKQl0+OnwZMIChlzx29jJzjLyCr5GTQprNUl9rrsnFDiD
	 BDaa2fvH6IDBOkTZeLarXLGArD6VioqtlymIgfglWwePoPwY6GaBMTAsQs3alD10KFHCa
	 y4I4TREDVqo/dI5ohjvVp1u59zyoUPH6CjmIOrbJ8pM4JHWu2SG+PZ1jcylYiZrM/fT7c
	 PlivKjf8o7LMpBkrfvdV/MoOQRuDxUuK2QCtSMBKeJwSc75cIEPr3gpJ5wlKAp/JWzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794073005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=c1TXvO7TccARf170PqShOSUdoyZswTtcvgBaLxcLf58=;
	b=UI4A4Il96XT3jQEjJOztxS+uVDlHKHqHK2UoanrTLDl3j2EVFjFp7CxJJBNGJDR7UstF
	 mF8yP7aeOKf8FPBWDI3/wsisLs9g+HkfSU+WJ6TQcJ8qQfmYOUL643Og5Qe0XH1+CXlFt
	 /04I6IXxjSgrJcH9A0ZHuqdyCtZ+1pUqLfUiVOhjY3HJzqKEFizuQAG5ciHE8IqpZ2IVQ
	 nTmw7/31cy4MiICm9aay9BnMQZsy51hk6BHNhNCrDXU6QQTnpyR0C7Q3xtzWx3PiZnerX
	 d5sn4mFoiqAcSAPFnbUxaZVmi+s3Wv/hutDxHm0U9Uh1L/TsnvrgAAZrdFzBbapppAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cXdw7prb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CCA606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cXdw7prb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A801F0089F;
	Sat,  7 Nov 2026 17:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794073004;
	bh=c1TXvO7TccARf170PqShOSUdoyZswTtcvgBaLxcLf58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cXdw7prbODAbe6C2xwwcqb4OLe+0KV5XmNTmilvOMBmBEwrBLX6Uk1/DouDhwXV6O
	 RnPTr22iiSrbXIWd9dySkQD65eupiXQL9aeAoLuSKVPxC21NVpwSHj8TAoaspobTKh
	 LbIG5JsQlnZgYo1vfCtSpdi0MI35/c20z7ymGZSm0yGKfWJePknTt1x/MIOfQdpebb
	 Yea4u/Zq5gfwXJmCRUvb/zYh8sNPPr624tysS30q24uHC6JD7peNt8zO0KaqvUQoVw
	 4pALzBk6PpqO6LnmH28xIhJEPoxIchppEAbSQvgISJcTfO/0bfzUsewWbc1o1ZppED
	 ERFFTmDuZA9Jw==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: disallow max < min damos filter range arguments commit" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 09:36:36 -0800
Message-ID: <20261107173637.109352-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107050426-failed-7.3-1bfb9384ae0e@kernel.org>
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

On Sat,  7 Nov 2026 05:04:27 -0500 Sasha Levin <sashal@kernel.org> wrote:

> The patch below does not apply to the 7.3-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
> git checkout FETCH_HEAD
> git cherry-pick -x 1bfb9384ae0ed52d61eb601b655014b7815ff849
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050426-failed-7.3-1bfb9384ae0e@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'
> 
> Thanks,
> Sasha
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From 1bfb9384ae0ed52d61eb601b655014b7815ff849 Mon Sep 17 00:00:00 2001
> From: SJ Park <sj@kernel.org>
> Date: Mon, 14 Sep 2026 07:23:21 -0700
> Subject: [PATCH] mm/damon/core: disallow max < min damos filter range
>  arguments commit
> 
> damos_commit_filter_arg() receives range arguments for a few types of
> DAMOS filters.  It allows any range including max < min range.  It is fine
> for the logic, but makes no sense to support it.  Actually DAMON sysfs
> interface is doing the validation on its own.  To avoid duplicated
> validations in multiple DAMON API callers, it would be better to do the
> validation in the core layer.  Add a validation of the given range.
> 
> Link: https://lore.kernel.org/20260914142327.92510-5-sj@kernel.org
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@davidgow.net>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: <stable@vger.kernel.org>

Including this, five DAMON patch cherry-pick failures [1,2,3,4] for 7.3.y are
reported last night

The patchex except the last one [4] don't Cc: stable@ and look like not
essential hotfixes.

Those are refactoring [1,2] or a very minor fix [3] that doesn't really impact
users.  Those are not built in porting-friendly way because those were not
meant to be hotfixes.  To port those, no small amount of refactoring or porting
of more dependencies are expected.

I don't mind porting non-Cc: stable@ DAMON patches to stable kernels.  And I'm
happy to help doing that.  But I'm not quite sure if this is indeed what you
want, or picked by a mistake.  Could you please confirm?

[1] https://lore.kernel.org/20261107050429-failed-7.3-1d2397b2c414@kernel.org
[2] https://lore.kernel.org/20261107050431-failed-7.3-cec08aad3def@kernel.org
[3] https://lore.kernel.org/20261107050434-failed-7.3-af19aff38d6f@kernel.org
[4] https://lore.kernel.org/20261107050537-failed-7.3-5695abc4e742@kernel.org


Thanks,
SJ

[...]
