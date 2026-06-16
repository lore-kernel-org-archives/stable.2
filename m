Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDAA18C933
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570103; cv=none; b=PfY9zagCyMFZQEtlpOyX1wW56nygbu9ycwLI564T9v0vst62KXbaPWYp1/PIZnnYsI0wDIsF+7FTecO2YShfoNikhFOkEXZZ1D0c4xl1Ldqp8eM76EEzUqHQrVi5nIPxJWZzREe3BWzUNxKJxr5w89kv6bzqWNUWpmUfByILHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570103; c=relaxed/simple;
	bh=TWow9wPNCG1NJkVn0Uk+JDq/aWSkjCamk5dvA3DvYDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwnmbMPY5mzspAJ53z3fk6VFYYblR0gQAYVz1jat4BT8H/f3i33GpDcAjmS332mqIqDAumi+1IHUhOeDmF/1KQTaBh1ao0xBtUH5i8PcpUny5uqm3UqCZ5h1dEWVhIsFvL8h8WgPYWxWgXKPTFcn961SZUDvm+1T16VZ1O2uRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke1lrxP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke1lrxP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E077A1F000E9;
	Tue, 16 Jun 2026 00:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570102;
	bh=w0ciJiSgNQtbspvr3JpKmV19BPfa38r1Y2PO0Fc3aDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ke1lrxP2ROShj6WCk0Or+nv717N3dLrVU5Tf7+YroT+oQhXvGW+Rc1/bufk/rPp7e
	 f6oL5qazEKwzkpHjdfjRzjFBaXPc+/63Tzx21zlNMu0zpGMf4JjRnYdNCGfDfT6piQ
	 GDwkDaQXc108Zp3dfb5SQ87U0snKubiXmo0IxEm1Kmpi5j7xuflUkDJ75X15OHTl2X
	 6PxMUZyi1Pj0UycKZG8cZZ5sRT/EJ2nnu6HjgaacjnmnaVihLFfxKwy2YLE30FIVzu
	 s3+XgXAGXOWhyp5MVGM+L/A7uutaiOG6zEjs6cgGX6RBMD4xEOUOlXElFCEFEwaqH8
	 pbJCjC88p3aNw==
From: SeongJae Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y] mm/damon/ops-common: call folio_test_lru() after folio_get()
Date: Mon, 15 Jun 2026 17:34:52 -0700
Message-ID: <20260616003453.141287-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260615193731.2389762-1-sashal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Jun 2026 15:37:31 -0400 Sasha Levin <sashal@kernel.org> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> [ Upstream commit d6b8b02a27b3dd09ec12144322b3dac46d9bc9ef ]
> 
> damon_get_folio() speculatively calls folio_test_lru() before
> folio_try_get().  The folio can get freed and reallocated to a tail page.
> In the case, VM_BUG_ON_PGFLAGS() in const_folio_flags() can be triggered.
> Remove the speculative call.
> 
> Also mark folio_test_lru() check right after folio_try_get() success as no
> more unlikely.
> 
> The race should be rare.  Also the problem can happen only if the kernel
> has enabled CONFIG_DEBUG_VM_PGFLAGS.  No real world report of this issue
> has been made so far.  This fix is based on only theoretical analysis.
> That said, a bug is a bug.  A similar issue was also fixed via commit
> 3203b3ab0fcf ("mm/filemap: don't call folio_test_locked() without a
> reference in next_uptodate_folio()").  I don't expect this change will
> make a meaningful impact to DAMON performance in the real world, though I
> will be happy to be corrected from the real world reports.
> 
> The issue was discovered [1] by Sashiko.
> 
> Link: https://lore.kernel.org/20260525162256.8317-1-sj@kernel.org
> Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org [1]
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Cc: Fernand Sieber <sieberf@amazon.com>
> Cc: Leonard Foerster <foersleo@amazon.de>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thank you for fixing the conflict, Sasha!

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
