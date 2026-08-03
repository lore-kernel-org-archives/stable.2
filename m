Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A08435523;
	Mon,  3 Aug 2026 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790028; cv=none; b=HK26TRRXMXJxFBZGGQq7xVyC5fO4V+D/bkJEsdObDmh1Vny9eiQ4ePI8P8UWUPSvLakgKsq0Bjd5ijq/pAc/xquLuNsTf9nyBe8+VZQPCWrREuqjBNjkLpwFAJMw043z3Z1T0DZznnvXY1owkVIMHzhAVK917qlNF4b8QA7xLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790028; c=relaxed/simple;
	bh=Cf6XPw6dD+8sq/lQVAYA0+d7IPG0c+3Q6JI+HkWOkUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgJFfoE6euOOQ/BiZN4a4bKvpgNDG5o/c/CLAHG5FTT4twMjKLw34sfsnzVNV39p0aRNSXZ7+lijiR0ykcWeyqDPdZ89bLsNMYSCu0dflufJTyYV7uT81TIwjF3+RQVJiPfwu0CgOuE0x+cUlJCPUi+9Bv2eTm+l3ppuUtaYEP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRoPMII9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRoPMII9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ECA1F00A3D;
	Mon,  3 Aug 2026 20:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790027;
	bh=2Rcib4bBbybHkbZgin1sCpS/iNUjgnAN+5dNXEdntbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dRoPMII9sfhLJrF5yC09mSNyij0NFAhSTVh2J9hVA9/J9RBsJhbjGiBXbe9Nxaq7X
	 KlQ+9Bq9U+HawY/CVh6yKY9i0QRep97WN5k4J0K5Obmuddo42bJUKoBg2NcJIxRsex
	 lu+95RkUzDFa3sn9e47ZqzVkeR9rdr3pOQNyR7QKUS3Py5RO+lb8goNcmI/nUZohPo
	 HJ/59GgeHvCYpT9I9+ZhnTcisR/GSE1k2u1xKKw+e6co7PfTvIHJh4gqGsk0cOmdGr
	 w+bmik5FlKdBOcIerhwZj8gOFlVEDJkwmyZHuys2aoeWHhU5Fc7GkohJWV+op+fqLO
	 8gj5dVTKzLzgQ==
From: Sasha Levin <sashal@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Danielle Costantino <dcostantino@meta.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Hao Ge <hao.ge@linux.dev>,
	Hao Li <hao.li@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>,
	"Liam R . Howlett" <liam@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.18.y 0/2] mm/slab: fix unbounded recursion in free path with memalloc profiling
Date: Mon,  3 Aug 2026 16:46:56 -0400
Message-ID: <20260803203504.stable-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803-kmalloc-no-objext-for-6-18-y-v1-0-8b01d1021f0d@kernel.org>
References: <20260803-kmalloc-no-objext-for-6-18-y-v1-0-8b01d1021f0d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 07:15:09AM +0000, Harry Yoo (Oracle) wrote:
> This is backport of "mm/slab: fix unbounded recursion in free path with
> memalloc profiling" series [1] for 6.18.y.
>
> The last patch has a slight functional difference compared to mainline
> due to lack of SLAB_ALLOC_* flags. I described those subtlties in the
> backporting notes in detail.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
