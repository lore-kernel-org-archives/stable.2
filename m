Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147B390239;
	Wed,  2 Sep 2026 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358209; cv=none; b=L4imQ5OskI/8SFTGVGE8Om2SBBGJ/VjNs5HKMkHPSvDBNmhmlm5qhWCGoG3RXrJSLe5jaaOp+wSHeIvS6zNyOxYzOfFGGe7p1dCXDPn/GPcg/hh3EOI5dYiZQxypNAIR9Mtwy9EY+Xhv2na5dRHJwJq1wDA/S2SQcgiGABRBeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358209; c=relaxed/simple;
	bh=YwGokD0r74aDWLGOYZ2BYv68juXgI7r0hr4IEVBmjsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhGNiFVG45PS3FK7Y7blfc+sGVj4VuLFiv611EKnYiXcPFHeWuWwVsOra2DjUakWN2+d1O495XdbekzWhoCiWGA35nPVORLK70wNTiBHS3+8XQraV24jzIP7jrlHajwXPEK+RBvuI9d9/pp98CzvZxEzHOaoKdUvT948/xgoXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAhB4egW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAhB4egW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B551F000E9;
	Wed,  2 Sep 2026 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358208;
	bh=oihjsCCaHvHV7Ff/eBY5FAk8c0jiEhpNBZtjuRbpKTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LAhB4egWDVKTZbo/WjNpEn1Ptf02oJWczukKKktsE1y2dTGpRlXs4Np28vHY1QNHI
	 K+S1q2j2GIlwhDnAUWDXKjFmrUYPPAh6o0YFjC+AzGuJfuOu4GS8oQibhtbpI6jLt6
	 ZIdMAkFVc8n8B9DeyY1F7iWv51s1kYW1bK8XERhVA3xLT8mKHeCz5pUP4qd8dPHN4p
	 YHIJG5tykKEbSVIdhLiEEHuEHgwROeUnDx31ozmjtbOdH4Mta57efgCv36ezivH5KX
	 p9pPj8kNZvyVDSwFrUkvSEAesHaRzBKqM6s8NoICC3VJaFxXypTOwM+6aAB6DIROZw
	 fYWRdlCPXI9Og==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Wed,  2 Sep 2026 07:10:00 -0700
Message-ID: <20260902141001.86733-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902084445.27170-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Sep 2026 16:44:45 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> When setting goal_tuner to 'temporal', if the goal is achieved,
> quota->esz_bp will be set to zero.  In this case, damos_quota_is_full()
> will always return true, even if no regions have been tried to apply at
> all.  This causes qt_exceeds to increase unexpectedly.

To me, this looks logically correct.  Could this cause any user issue?


Thanks,
SJ

[...]
