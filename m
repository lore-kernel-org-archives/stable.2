Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785796;
	b=l9yKQJb4YT7PNRmjaObs7RI2wUAqAY95GullSZGoTaPh6CMBkqe78EGqPIkIC7AqyUNE
	 KoBhaCAAdmOzW+jrG+cGve8Wh9DshbiG/NFlSexzfkP78aUWWfb7rh+qAHyDX48l5ewIv
	 LMNNM0CVxquLGBVuYTDlm5xkPv0hk7ytJjWa4m+l0mIr1yK2auJzoUCSCgQ7V5S/mVAh6
	 gV/wZBVUEvvCPGdpWlDTEH6JzlmMmra4T3sdA3bNeQ4iy6+947b14ZpXY6SFOznWUKupl
	 g6Otk+Mos2nu7ipa1CKxPO+kSv2y8hwwQCbcGt6E/BKyid0SLk1dAVQ3sB1kBbxnDjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785796;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aiKTjh/oO4UHkhh/e0hU26pZyMzVo28SpJOfz6hRIB8=;
	b=i3AA+onxiAA+eseT51bBwPWIxCirqD1snzzaxtCEp1ZEBCQxnCqdiYicalJJp+wPOXHy
	 AxtDmtHEec8lFJXuUNichjW7Ogb4LiPMPTPxgujo3yTm0bWm/Cut9vIos3Vcgtui21Lhe
	 mtR+i9fbYW+7p8u8YgmhjPkG4PSB7WnSAOnOnp6N+a5vySlqLIXVbXBysB0CF/m49Sb3c
	 ZvUj9jPNIwUcG/cH6IB2ulz4AarvBqBrhbIb3WXxY4JyWp90D69engyqQw2K/JG7B84qX
	 +djsu/mQioOQwFLo+7woMHu1VzCZ3pc57cBbwFy5rqt8NB2HZkTS0HF4uXFtFA+qcbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jK5SE5DK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD05606A31E;
	Fri, 23 Oct 2026 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jK5SE5DK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A661F031E0;
	Fri, 23 Oct 2026 20:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785796;
	bh=aiKTjh/oO4UHkhh/e0hU26pZyMzVo28SpJOfz6hRIB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jK5SE5DK/ZVVX50YnV8rqW4FQM6MfE6uS9Z5NcykGYAmCCaZKmuc8sze2Y1/376mK
	 MZSlxJ+mnz1ScskxanEgtJxsKA7uVSRTQTcrtYUk5WAq3/8Bo3EqxnltiyYAl3z3Il
	 IYAir7G62hmbrcZxFDcW5MbbLqbE40P9fYDvZ40KarADvXL3U4VsRomOVPERsWqzzi
	 Je+PYf9FPAiI7K/q55youvsz8of2rC2haSaP6C0mREDLiMOT1gNOsFY1fCtG1N71o6
	 gsQAYqsjd/xD58HhWqY8hbQu+GzDsXt9dPJWBs67HsI7kmtFM43ngqKwZIAt+ajDAY
	 1hBNzbZ8kDQoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: Patch "sched/eevdf: Move to a single runqueue" has been added to the 7.2-stable tree
Date: Fri, 23 Oct 2026 16:02:53 -0400
Message-ID: <2026-10-23-1-daily-reply-0017-sched-eevdf-single-runqueue-7-2-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021131517.GN2823843@noisy.programming.kicks-ass.net>
References: <20261021131517.GN2823843@noisy.programming.kicks-ass.net>
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

> Ufff, why are we backporting this?

It was only pulled in as a dependency of "sched/fair: Avoid overflow in
place_entity()". The whole chain is dropped from the 7.2 queue now.

Peter, Vincent: do you want a context-adapted version of the overflow fix
on 7.2 (h_load.weight becomes load.weight), or should 7.2 just go without
it?

-- 
Thanks,
Sasha
