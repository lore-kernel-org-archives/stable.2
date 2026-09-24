Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C43AC0D7;
	Thu, 24 Sep 2026 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280169; cv=none; b=XsxL4oplvUegPHWgww0ROpAj5tHz8QFzMeZe71w9+KLJn4SG2Bq7LV4R1b6Yr9+PQzZQp7eDe//RyJeZTnatwZ+NnNjbFbVAh+6cJE/vm/b0Ik3oboZGKapsNfvlaIFLjsIJSZGjZip4ZPMpUxORUk1NYIqGBCKKLlpMhvUE454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280169; c=relaxed/simple;
	bh=e0s8mXCInSUcPR6/UQchgXZbd5Ddvd4iHqEXyXB/Jv8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=R+JaGQ5LpxZLnTiuYaH/foMftaEoAhQP+EAiBem02DITb3N9ad2RX3dgMDhQHqGurTdu1v5LKrBwIXhMPQhC7XgrXVVmRna01cY4TOh95qC/O46ske2WXUF4qIpwqERnQcZnOFxPsxwBDm/H8/puKW1VVmAApqdCRPk2cBXyRa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X5Q+OOML; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X5Q+OOML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8ABC1F000FF;
	Thu, 24 Sep 2026 20:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790280168;
	bh=Erz4LJe6kh7QPf4uqg2zepfaCHHFYn+vw8D8/ABgOjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X5Q+OOML5RdDvgXB/ebimQyLK5pgYR+e6utm0gk1qQh6f5y8GR/TWIGI0J0g9vTTq
	 p+1ac+96Njuu0l76rymBs0ZmDMeM1ByrUii8EkSpLaxdzYb2o0C3mtjgbx7K06OczK
	 5P0RsSEsvnCi/hFrZnBe3dcsMZ+bLiikMBse9oIU=
Date: Thu, 24 Sep 2026 13:02:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, stable@vger.kernel.org, Kunwu
 Chan <kunwu.chan@gmail.com>, Lian Wang <lianux.mm@gmail.com>,
 damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 mm-unstable] mm/damon/core: keep the temporal tuner
 quota over an unmeasured PSI round
Message-Id: <20260924130247.07bf24d96794d28a4d8a83a9@linux-foundation.org>
In-Reply-To: <20260923055139.2982-1-sj@kernel.org>
References: <20260923055139.2982-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 22:51:37 -0700 SJ Park <sj@kernel.org> wrote:

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
> ...
>
> This is a fixup of a patch [1] that is still in mm-unstable tree.
> 
> [1] https://lore.kernel.org/20260902002725.108635-3-sj@kernel.org

thanks, I'll queue this as a squashable fix against "mm/damon/core:
handle uninitialized damos_quota_goal->last_psi_total".

Which means I locally named it
mm-damon-core-handle-uninitialized-damos_quota_goal-last_psi_total-fix.patch
and shall squash it in before moving things into mm-stable.  Karl's
contribution will be captured in a footer note and a Signed-off-by:.

