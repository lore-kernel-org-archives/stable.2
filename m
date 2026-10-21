Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792544551;
	b=AN+E7LCSSfFTsRiuD5g22CEzniH8KkviWT7EURMJmIfU8BR0Tlb5TRgxcyOjjLHDjajb
	 myBsedjG/Ut17ZzFkZbstHhiGqr8SdpXobiWb4Nvofz12LwrlhXHbya016EuQNKhMDhCU
	 sh7ecFtfGgKnrRVpoMw88riawSs7UTnUL1Ix6+NZzP8ebpumW+3SnZCjiG9KlY/+xeep8
	 dkbnSxs/tuncAZhnHDkIUu9j6mFeJx1ysPpsDmK4TQKH74rDnZJ1T5jl3PFj6u5pfV9Ud
	 Kn2d70E7yDtj3jIy0enqIJRlQjQn+uoMhiETf/G6z5pCv6WC6hD0INvxQykDaJ5h10w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dxapBMnN2fMQ/g84o5Y9DlnPN8flfC6uQghMcWIgUyI=;
	b=nHBR+L6wZyMmqzRZmeyy+h00gf/vfAJ5eAAMIEnOFrf0Nh68sT0whJ6un9tRp+BRqOV1
	 EYMOxS2UxPd5jHacKwVX+aZQu6eg5HPnGdcogCCEzeCIykq517i6yGHw0vqN1FB8smacQ
	 W+fKkKm++vnJWPl4FP/qgNeeqfxaUndRTImqTDLJJwuyYpoB+AnYQK4CtN7F9hRqWL81t
	 YSuh2e7S3SLw9C2oBSYp1KVdVQ512iVv96cUXa+Hn4UqTC4Xbr4PLIG3pG5/Qo1yqEqWc
	 HJD0Ar3xQlpMNexoyRZLa0pgA3mrfFt4NBp8CRfS5LCw8dJDE3SB1g/gvtYx+2Ob2bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hr1WboyO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5014606A319;
	Wed, 21 Oct 2026 01:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hr1WboyO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3D51F000C9;
	Wed, 21 Oct 2026 01:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792544550;
	bh=dxapBMnN2fMQ/g84o5Y9DlnPN8flfC6uQghMcWIgUyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hr1WboyOwa1TDkH2A6h52vTFk8H0+YRNy4ydhMRTZDK9IiMqrH+yJHcLyTXUUQ6Pi
	 oKyXI26fWhMrTgxA6rH8IqA2LuKtXx93v/3BPgwfKy+z3sWP5ZGlK3lLMrmZzO7O38
	 dHsC75sTYd7Z6Q2tx+Fptm6AcQx88Q1Kfx3CRIsQ/uzwlNIth6z+tb8Q07BJa0wEm7
	 nHG90GkwavFP36Y2FkUBIThyxOBUsSFX1VOEVTrLbwT9BlpG0GlGnrES+fxDyWYkEn
	 gGH/7O1B5hJWAJfZgfcGnGwgIbFJjN+4/H6ZPCRhsCuImNEXHlo/skf1b6wPzo3sjX
	 7UgZDEiXBEqcA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/sysfs-schemes: hold damon_sysfs_lock in target_value_store()
Date: Tue, 20 Oct 2026 18:02:22 -0700
Message-ID: <20261021010223.94305-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021005234.94107-1-sj@kernel.org>
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

On Tue, 20 Oct 2026 17:52:33 -0700 SJ Park <sj@kernel.org> wrote:

> On Tue, 20 Oct 2026 07:47:25 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Remove a race condition under certain use cases that can trigger
> > divide-by-zero.
> > 
> > damon_sysfs_add_quota_score() setup damos quota goal as user configured
> > and pass to the core layer.  Because it could have a race with
> > damos_sysfs_quota_goals_rm_dirs(), which destructs the files that carry
> > user configuration, both are called under damon_sysfs_lock protection.
> > 
> > The damos quota goal setup disallows zero target_value parameter because
> > it can be used as a denominator later in the core layer function,
> > damos_quota_score().  Otherwise, divide-by-zero can happen.
> 
> This is no more true due to another patch [1].  The patch added the zero
> target_value case in the core layer central validation pass.  But it forgot
> removing the redundant check in sysfs.
> 
> > 
> > For the zero value check and final assignment,
> > damon_sysfs_add_quota_score() reads damos_sysfs_quota_goal->target_value
> > twice.  And user can update damos_sysfs_quota_goal->target_value via
> > target_value_store(), which doesn't hold damon_sysfs_lock.  As a result,
> > a time-of-check-to time-of-use (toctou) race can happen.  If the user
> > sets the value to zero between the zero value check and final
> > target_value assignment, zero target_value is passed to the core layer
> > and results in divide-by-zero.
> 
> So toctou race exists, but it cannot result in divide-by-zero.

And the toctou doesn't matter because the final value based same check will be
made in the core layer.  But the toctou makes readers easy to be confused.  I
will post another patch removing the unnecessary zero value check.


Thanks,
SJ

[...]
