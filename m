Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F99046EC8A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758774; cv=none; b=ipaymLpN+t9G8/HsnmPJMw3uOy62ejCQzcImOZUXQ6Do4WiVAoeI07q1VJhKpVEeCFJTolESiBiVFBGNC3KABkztMH2JBa/TgSTan0bRdF5LQKLsB0L8EcliK0jjJKowKihz4j3OBhjMzhrRy/ciPOjs36lZjj359EPpvKbkaxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758774; c=relaxed/simple;
	bh=zWOyOLWUneDxxgi3nduP2dZ7f5oPmFu34YllpuSZKo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drESzgnquPGdgA1aVU6p4kwOMS6r8uv6I5xqgwfj1ssY86MxApKE33t60ev45yeE5AbYXU+hfoObOc1wY1Do6AOYjLykrZvhGcrGeOBAoeEpK2pWJ/BPqSzEC2fe8piB33BjIGmo6cRNBVG9F/2iMpV804TInlxMHm2zKcE17Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCAwEuY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCAwEuY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19B41F000FF;
	Wed, 30 Sep 2026 08:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790758771;
	bh=FHRNcTZGcO+39u6qmz22aseJCyAo3UqEAkomVOTxO4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RCAwEuY8J6md/KE88q2FMOqO0vtp5UMPAgcDxsEf8OimqMihVsM8883rxTN5cA3Gw
	 VuoID/O3WrYyXLVXVtCwqCesrIUS1sOXywmjAj+1WVCgRCW/Br2G/Ja3lG6GJwwQM+
	 g6WcrJ4fgsxmlf8juwH9iv9Fj3tUJpCEx+EfaDzanZDGMIg77v2qMWrFF1+qcSOFJY
	 ktsqwD1k7FvnOXACIbCAPL7Yrkd7kmlO2YdNXIsz46iXq8wgpnfxDhX/i/EQ5GIWSn
	 OhMF5MXP/Qw4ObPhmhYNiamCZNbG/zvHA66OzUWlCWrh8dAk6z4g2qnI3Y2XkTo0xt
	 F3AT3oMmjjAhQ==
From: SJ Park <sj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: SJ Park <sj@kernel.org>,
	aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: allow esz to be set to zero" failed to apply to 6.1-stable tree
Date: Wed, 30 Sep 2026 01:59:26 -0700
Message-ID: <20260930085927.43285-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026092901-ditzy-scarily-fa8f@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026 10:28:01 +0200 <gregkh@linuxfoundation.org> wrote:

> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 90179da203ba8b708c84a12a07cd44be0f346334
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092901-ditzy-scarily-fa8f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'
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
