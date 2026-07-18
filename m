Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DFE25B0A8;
	Sat, 18 Jul 2026 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784395318; cv=none; b=JZcUbTtq64fRx2ldn4nhix5aFlPkU1wF/OKavrYKzm4wn5q0btmkapg9jMu71KkyU2h0IORyoXy19FzT2cARcuvElQYRpV6XZQ0tFCcIkfXHIGRlO8bc+pemWj7AiF7Fi2jxZSlFQHFzqHCdr8bE4kZG5Fux3YeXIsK924UAmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784395318; c=relaxed/simple;
	bh=Km1lPqO0Ly61jpdeaD8stG06jwJUC39qa5KK1N3Mczg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U94z2pfELpomD76Bee3PL6YNEeSBa0NGQKnEweJ72IHPlEF5A6qj6UUgMamIQknUAsQHKp8XLg4B6HiqcAEsrb8+7wspPWV8NTeSBTgqr2p+z0rETpVdfI89BYKmPPssOUfrX5iccnmlKrM42VnjB04tjohHWLm+4XwQuHe3vxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGNL6kXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGNL6kXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82401F000E9;
	Sat, 18 Jul 2026 17:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784395317;
	bh=u3zF7fQwUKoNE5eqD36Ay9nz96+mxu218W1M+/Y5HIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UGNL6kXoOYwOpibJRxflDNDon+6aCUMlKuw6KGRZ7VHYzBolgaq9QxuQ/bNnbq0dQ
	 /E/B8tzEMLtRj7NHuubbsnxi0UUrtuJAeFR8KIexOyCNAgkq9c4FvXhMbzF5qD0yvL
	 u+tj1PyaXx0LjslbANxnJa51SMbUwqWdGTaML4QO5gVoVHG5FwOAPW2GMZalSUoMn8
	 bMyhqq6+LoqxDSPNPBNdDlLR1T642dLY5efynodVIfD9oearsBEoGOdsIEE3XhAxWG
	 cOo/dJjpFV3yiAzlQAoTAiny58zIWqvHcclSxaf1zMApW7vvCHQ6bVH2AZdRfnlBA6
	 CmZZ5HJm96KwQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: handle region split failure in apply_min_nr_regions()
Date: Sat, 18 Jul 2026 10:21:46 -0700
Message-ID: <20260718172147.87900-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718163708.84113-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 18 Jul 2026 09:37:06 -0700 SJ Park <sj@kernel.org> wrote:

> damon_apply_min_nr_regions() repeatedly split each region until its size
> becomes small enough to meet the user-defined low limit of the number of
> regions.  The loop assumes the split operation (damon_split_region_at())
> will always succeed and create the new region.  But the operation could
> silently fail for memory allocation failures, for example.  If such
> failure happens and the region was the last region, the linked
> list-based next region fetching returns invalid pointer.  As a result,
> invalid memory dereference and corruption could happen.  Fix by breaking
> the loop in the corner case.

Sashiko found a room to improve in this patch.  I will post a new revision with
the improvement.  Please don't add this to mm-new.


Thanks,
SJ

[...]
