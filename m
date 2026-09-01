Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1D343889;
	Tue,  1 Sep 2026 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223860; cv=none; b=Z17ls3peFYRDh9zNoiSdcAk4ILyqq+u/TC5sIEuJVBos4PNRW83uXV3lCqMbEBhqiQwN3nfpA4lxTXRr2TSSqyf6ml85jAgyHUE3CT7xQ1wfEsLCur0oKJVKufBVDjmHqFLgJ5GaFKDamtVgcygj0JaTp8GeK1+okopmICQ2DZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223860; c=relaxed/simple;
	bh=1dz/NW2izqSm708YvZtGIvQsS1bXVh/J/C6x0DXFkiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xp84vDMYSO6+s5AZS9c2YBi02KDJFdiSuOtAOUKf/rb6pyCpey8Bq9qexZ7fy2KFalnzPd92dbIZw4mwKeoZFNvzP/OR8Icl3D12oOigXifOq45L6RCmMCt4kY8My9FDPoZ5/eQw2ZPOj6TTRH1RDPYa+/zLsmGpgBFFSCjKdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wr6QVG9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wr6QVG9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C321F000E9;
	Tue,  1 Sep 2026 00:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223859;
	bh=WaZdL5/4xTpVe94Gdwvz1Rj+GpxfA9H0D9S8roxC2zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wr6QVG9q0n0SoHaVG9gXRXl+dVswmtQi2r8zhEbm71rjpGEd2k01TJsrjNoS1P2uE
	 dFpu3CIxYZ+kQ4YNZunSrXG8sUEbFOeAQEsSWaFv5BmCJB4+QhxZBC4iOpYH1Jkt0R
	 +vFc77a+xm0lIqfqEry+vlTUIV1h94t15U0SmLwCw/5mbwlfMUgJWvSlvdZHfVeOKf
	 1RZUSRCHh5ZA0cHfE1PkAFtcUdKdOdl2+pgflVBLxgrajOtqtWUJV2bNCXjt0hb2nF
	 5pLuoJ/bgxKbng8K/9HJTd4bMUMa1elEKBc9A5gaMHF3AN5BymHZEvdAeD0yjiF0SD
	 0ZKkJnyNY2qKA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Yueyang Pan <pyyjason@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1.2 0/8] mm/damon: fix DAMOS bugs in core, paddr and vaddr
Date: Mon, 31 Aug 2026 17:50:46 -0700
Message-ID: <20260901005047.90102-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831140254.72004-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 07:02:39 -0700 SJ Park <sj@kernel.org> wrote:

> Fix misc bugs of DAMOS.  Patch 1 makes DAMOS less stress memory
> allocator under extreme situation.  Patches 2 and 3 fix wrong folios
> walking in DAMON_PADDR.  Patches 4 and 5 fix wrong folios walking in
> DAMON_VADDR.  Patches 6-8 handle extreme and unlikely memory situations
> that can cause divide by zero and underflow.

Sashiko found no blocker for this series.  Sashiko sent findings to damon@
mailing list [1], and I replied to all the comments.  Please read those for
details.

[1] https://lore.kernel.org/damon/



Thanks,
SJ

[...]
