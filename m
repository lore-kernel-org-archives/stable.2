Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080640;
	b=ChMam2RXvSE8tI8Ygu/roPBoTzmphiFVx3wsMtYh6VhWjL2QuHjY5aneo0nrY7wBliRo
	 KUXh1xdaiX0SSPf89W0BVTN2+VzZ+p30gWd+3ncbKk9VsvKVUJRA5wxcDF2pOpncwyh7V
	 aQBIhm4aQYUIoTB8MR2rpH/abD+eMmeEDWRFRvEc/J+utbRK5KqKuzYL/tJllWG7Av5c+
	 DeDN0ETzUd2E0wirtg9IwE6HyemLYs21PL3rJHQGkOPyfwTiAzI78MdmeamcivoUuz/S2
	 BZGa9GanqfvXZhTdWTvAQYMG9EarbQftntDUZPpi0Cq30bJofPH1NR9yErPoxzqeH5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080640;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=crU4sJAfHc1PeVBE+a052Ur+XGgcU5XUUHxZfWXg24c=;
	b=OvSTlXtc9a3Al8yYBLlFr96QYECSbYpoX8r99J8X7Yvpc0ycf1ojlRxbn4VOjuKrywmn
	 E/TZmEOQQtj6Hj0xEmWLNQGteIJ/ODWVg2agHdm2BpO0Dkszt0q1MvUaJPBpt8ztXW3Tn
	 Ma+7ahwrBp9+hb91AgAGSGvTwyn72JME1J/7zFDvWuJ66gUBBlFaMXAX4Ci3ftlMUq5k2
	 Y9b+yTnsXNS3L+1QdviMhJ2uAkCsM7DjLZ7+33UKpNEZA4rNx4oYA+UYNPA58DptbkAi8
	 HGNcY+T1ArDaPOF84IHnp0ynXSzFWAw5uD9QFDTSF89eo8p0uwo2qJoHasmJzdG8zgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlVmRybf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E4606A326;
	Sat,  7 Nov 2026 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlVmRybf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC781F008A1;
	Sat,  7 Nov 2026 19:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080640;
	bh=crU4sJAfHc1PeVBE+a052Ur+XGgcU5XUUHxZfWXg24c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HlVmRybfC8pECuqxo57f6jFl42DpcTuEwttF5MoEeCuwVWVvLS5yDiUt9b+Th58av
	 2I10RvSXWdnRUvtCTxoGbV+S7ofuFGASAm0dFzWdka9BMec8BEn1RD/m06dr63mMFO
	 DRavlaxf4buGY93Y+WFlLMX9r6zxaGwmFoBoTwLTtJxdUHQoQytGMUahxadaSMEk9p
	 g4q6V7VLSiu1e1op5p9MsAdzY3mu004erG1BWkcaaoJIPmDrx6LD0UpPMO33pKE11U
	 Gy6X+3rXBnkFUxtzblgjN54MFdHJFEq5qonYb7n4ESw3SaAy2S6i/T81AXVSLydxw7
	 KxNohdcZM1CZg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com,
	stable@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: disallow max < min damos filter range arguments commit" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 11:43:51 -0800
Message-ID: <20261107194352.198354-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107173637.109352-1-sj@kernel.org>
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

On Sat,  7 Nov 2026 09:36:36 -0800 SJ Park <sj@kernel.org> wrote:

> On Sat,  7 Nov 2026 05:04:27 -0500 Sasha Levin <sashal@kernel.org> wrote:
> 
> > The patch below does not apply to the 7.3-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 1bfb9384ae0ed52d61eb601b655014b7815ff849
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050426-failed-7.3-1bfb9384ae0e@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'
> > 
> > Thanks,
> > Sasha
> > 
> > ------------------ original commit in Linus's tree ------------------
> > 
> > >From 1bfb9384ae0ed52d61eb601b655014b7815ff849 Mon Sep 17 00:00:00 2001
> > From: SJ Park <sj@kernel.org>
> > Date: Mon, 14 Sep 2026 07:23:21 -0700
> > Subject: [PATCH] mm/damon/core: disallow max < min damos filter range
> >  arguments commit
> > 
> > damos_commit_filter_arg() receives range arguments for a few types of
> > DAMOS filters.  It allows any range including max < min range.  It is fine
> > for the logic, but makes no sense to support it.  Actually DAMON sysfs
> > interface is doing the validation on its own.  To avoid duplicated
> > validations in multiple DAMON API callers, it would be better to do the
> > validation in the core layer.  Add a validation of the given range.
> > 
> > Link: https://lore.kernel.org/20260914142327.92510-5-sj@kernel.org
> > Signed-off-by: SJ Park <sj@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: David Gow <davidgow@davidgow.net>
> > Cc: Usama Arif <usamaarif642@gmail.com>
> > Cc: <stable@vger.kernel.org>
> 
> Including this, five DAMON patch cherry-pick failures [1,2,3,4] for 7.3.y are
> reported last night
> 
> The patchex except the last one [4] don't Cc: stable@ and look like not
> essential hotfixes.
> 
> Those are refactoring [1,2] or a very minor fix [3] that doesn't really impact
> users.  Those are not built in porting-friendly way because those were not
> meant to be hotfixes.  To port those, no small amount of refactoring or porting
> of more dependencies are expected.
> 
> I don't mind porting non-Cc: stable@ DAMON patches to stable kernels.  And I'm
> happy to help doing that.  But I'm not quite sure if this is indeed what you
> want, or picked by a mistake.  Could you please confirm?

TL;DR: The four patches wrongly have Cc: stable@ tags.  Let's ignore these.

I just found mainline commits for those patches do have Cc: stable@.

The patches I posted [1] don't have Cc: stable@.  But Cc: stable@ tags are
added to the patches inside mm.git.  Apparently because I posted those as a
part of a series that have both Cc:stable@ and non-Cc:stable@ patches.  I
shouldn't mixed those.  Refer to other thread [2] of the same finding for more
details.

And because they don't have Fixes:, seems it was tried to be applied to entire
stable kernels.  I show similar cherry-pick failure results from these patches.
Sorry again for this complicated situation.

So, I'd suggest to not add this and three more cherry-pick failed patches
[1,2,3] to stable series.  There are two more non-Cc:stable patches in the
series.  Apparently those might also merged into the mainline with the wrong
Cc:stable@ tags.  Hence those may also be tried to be applied to stable
kernels.

In lucky cases, those may failed like this.  We can simply ignore those.  If
some of those are unluckily successfully cherry-picked, and if those don't make
some test failures, maybe we could simply keep those.

Let me know if you'd prefer just adding those, or finding and dropping those
wrongly applied ones from series before released.  I could also help in any
case.

[1] https://lore.kernel.org/20260914142327.92510-1-sj@kernel.org
[2] https://lore.kernel.org/20261107183202.177477-1-sj@kernel.org

> 
> [1] https://lore.kernel.org/20261107050429-failed-7.3-1d2397b2c414@kernel.org
> [2] https://lore.kernel.org/20261107050431-failed-7.3-cec08aad3def@kernel.org
> [3] https://lore.kernel.org/20261107050434-failed-7.3-af19aff38d6f@kernel.org
> [4] https://lore.kernel.org/20261107050537-failed-7.3-5695abc4e742@kernel.org
> 
> 
> Thanks,
> SJ
> 
> [...]
> 


Thanks,
SJ
