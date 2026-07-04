Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0609374169
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130754; cv=none; b=Kr/J0o7CbR4LTKyctRXKmyqea0TiSpKrT9J0026DCbP66vPTbgcxRH8if09ol2r9R1v9ht+v03glnro4roP2zB+2d/1GTugn7a1L1dCvgk12bUKgG22P/OzIL4U4ug+HMRSoyxKQfgi6W/IYtMS1cHrGXexMwdSZmjVBQATHrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130754; c=relaxed/simple;
	bh=xLkf3sdAjF0xqNGaYyzs5mjxWZVEzGwxbxzzP3Y/xjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDBlNorfERWNvKURdEHkG+rQbHtpWr1qE5eyUmgCgDjd+V8Bkzz2eQAhp+X4apBnQoMWqEiZMZ2QgO4CuWySoGaEtBa0iRHDVAFDKJiN3Rfw7thyzLGBE+k2uieTiheb/SxhZhks30lqFDrB7pDG4oLiHLXniYKxHTlezH1rBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grid50lj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grid50lj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268021F00A3A;
	Sat,  4 Jul 2026 02:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130753;
	bh=fJnIJVJxK1JR9YumViTHUeDqJaX582M5sR6biBxIDpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=grid50ljbCV8PSGi/WNugEa7Xk1gXb8F0h0WVtVlg/jzJA6eq6nHKGdsRSeuga1GE
	 SqqMtY5rsNXkozeG/q0ghm1KixXC7PfKlKmnMNR6nMsYMMnAFY9wQn/GTZ3Y2dsrKM
	 RgE8gLlshzImlbmWsGuMJTpcjgdHUMq3ZrmAqoSQXf9LlO++2K78mzs1diYPrek4/S
	 Rx+SS7LeiZE+MZblMJpsDchDdJpt4tSVdtuAFNyXQQoklD+gBM8AAPyviuYkL8m6Z2
	 UxnQKxW/NEIjuczkBlZmQ+9QdttuCcC8eHMWqFup5O01+uTowHAJCZ0W3dhw3fepvM
	 v+STJHU1Py0JA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sashiko AI review <sashiko-bot@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH 6.6.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Fri,  3 Jul 2026 22:05:15 -0400
Message-ID: <2026070315-stable-reply-0021@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154904.975468-1-kas@kernel.org>
References: <20260702154904.975468-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 02, 2026 at 16:49:04 +0100, Kiryl Shutsemau wrote:
> userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
> without taking the page table lock and then apply pte_write() /
> huge_pte_write() to it.  Those accessors decode bits from the present
> encoding only; on a swap or migration entry they read the offset bits that
> happen to share the same position and return an undefined result.

Queued for 6.6.y, thanks!

-- 
Thanks,
Sasha
