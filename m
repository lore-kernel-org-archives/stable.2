Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A566A3D669A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758716; cv=none; b=Jn9wvhudKei8CMfKQIUFU/5fJUMvIYBkvtqrQV7HiF5TZMCdU1rTvUnOLUKVAokNvcKhzoC8q4k9v/ZvJiLzhlKrv3y97aisH/FiGyMKB5zAy8A48oe7G4/7Aqd6WOPuswZoQwlny/8nUsiTVIyETZzdpIIaTgeHWz4/H4NHwSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758716; c=relaxed/simple;
	bh=NS6BZf4rOF7Ll2unaGSb5GJXwIo0S5ZB9zyitM93p00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9XBEMqbNmecaMFXuHztrPcCIECoVqIfGBN+6txYWl4LTQOq9dx6iQdDnz2Y0eTmcExkpqAssSqdQ38m8FRorpBSwDs4ViytE7F6ouLMw+6OlMEKG5cAd8k/UX9Pl+QNRav9b/puATQIoriduZzF36WwWJmVzgOvk1+ax7eiE+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO+NED5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO+NED5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D001F000FF;
	Wed, 30 Sep 2026 08:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790758715;
	bh=FfLC8PJiiUMVKR9WkomrEQZWwfS1GSXvR6IupdX2EMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nO+NED5LyBB0JRkVsMwRdZkOjbK+OtKx8nfePOQzaYPz1O5b/vhvALPa1rs6Krk6h
	 fV0H9HLi/GWgWousjvTpAXJLnCwf+2fAhFBMPnzdGmvoJvhxqbvajv19igW2Q8fq6D
	 tQxt4pZ6qisny9Qi2WaWQqLkyyUVLXAF3AHgbQjuRoNdZsnBlPtsFGWSQ5spsk9MI0
	 tnMMAj8JbNTcEQe9AQAW/KE1nw/2kGukZi7tYLlqq5bn+uEF+OEOEXAkMZ8po0YMWo
	 ezp6SJIWBiuXcfMVzwhF4Gmguao4XU0oA9Z5D032K7Kr+Y4dq27+Df/b+lk8wwC42s
	 g93ClAEJOzHZQ==
From: SJ Park <sj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: SJ Park <sj@kernel.org>,
	aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: allow esz to be set to zero" failed to apply to 6.6-stable tree
Date: Wed, 30 Sep 2026 01:58:29 -0700
Message-ID: <20260930085830.43139-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026092900-finalize-hungry-54dc@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026 10:28:00 +0200 <gregkh@linuxfoundation.org> wrote:

> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 90179da203ba8b708c84a12a07cd44be0f346334
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092900-finalize-hungry-54dc@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From 90179da203ba8b708c84a12a07cd44be0f346334 Mon Sep 17 00:00:00 2001
> From: Liew Rui Yan <aethernet65535@gmail.com>
> Date: Tue, 8 Sep 2026 06:54:11 -0700
> Subject: [PATCH] mm/damon/core: allow esz to be set to zero
> 
> When the temporal quota goal tuner determines that the goal has been
> achieved (score >= 10000), it sets esz_bp to zero so that the esz becomes
> zero.  However, damos_set_effective_quota() clamps the esz to
> min_region_sz when quota->ms is set.
> 
> This is a minor issue, the main problem is that it doesn't match the
> description in the documentation, which state that if the goal has already
> been [over-]achieved, the quota will be set to zero.
> 
> Fix this by set quota (esz) as minimum as possible.
> 
> Link: https://lore.kernel.org/20260908135413.97570-1-sj@kernel.org
> Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")

This patch also depends on temporal tuner feature.  It is introduced in 7.1.
Because it is a feature, <7.1 stable kernels don't have the features.  So this
patch shouldn't be applied on 6.6.y.  Please don't port it on 6.6.y.


Thanks,
SJ

[...]
