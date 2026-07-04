Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA6A37417B
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130759; cv=none; b=cEdCkKH7Q90X5KI+ZyZXUHaX1ES4WzUzKYBeu4raroW6KjJPh9NyQNOfUu6CD6lD8Kbf94BU8/rEMxAjaWbQnLsGM2CekarvJffKr9RWc07L4N4f9iViBJcrOnRahivvZB6aa2XoihqiwdIDRjVmzzAq3QqOhXa+QXGgLjNGbxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130759; c=relaxed/simple;
	bh=0SBaxO5/pmCH0IZwTj2aF8Jd0HnqR128Z9b9x5xBzdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qK22eT/BY9ftADpyqZBH6aaVQY9N4coklS/k5/Z5T7PHZMJ+U5paX/OGKgROu3u6LtnFkKuc3JUQvAvM0GxXinOi4/HJTNVKhMcTYNEyZbolcEAGDjMipUpuTrCyet0bHJSTudQxLtjBbnzsN7YYuQqNq9X21lY6Oiru0jBvhZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM6lCFYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IM6lCFYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300B71F000E9;
	Sat,  4 Jul 2026 02:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130758;
	bh=S+jPVpO8HgqEG5QyURsNJkyTQKF7Uh4pH9HdG2N9Vbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IM6lCFYiM/qPPdfCxplXL80sveitjupd02VPhc1rYdSE+uUFJ97DsozFfqb8YsPdg
	 49Y5CKNdh7Wr89hvsxn7H4QJjPLvv5X+hS034nSnePiL2ShE96OTpopmm69LOjEJkg
	 FYQXSmOln/HpnLXV6Qy1BBk2Duhgk46ct0+f591rHajewERYY8EGI6gTFpZsBh7v8g
	 1+NVIRdKse/Qf2FYRwFZzhV27ve8dECoXOdJczIjyRqe9psGZxpJUxSJmMsQZ//KIW
	 xUeZvdd4gnYXpAvEhl45OLi2fAt0FEOgDhLKz48lAv+p/uJB4+CZGkhSaNscGyL1aB
	 G0potOg9NYowg==
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
Subject: Re: [PATCH 5.10.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Fri,  3 Jul 2026 22:05:18 -0400
Message-ID: <2026070315-stable-reply-0024@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154859.975356-1-kas@kernel.org>
References: <20260702154859.975356-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 02, 2026 at 16:48:59 +0100, Kiryl Shutsemau wrote:
> userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
> without taking the page table lock and then apply pte_write() /
> huge_pte_write() to it.  Those accessors decode bits from the present
> encoding only; on a swap or migration entry they read the offset bits that
> happen to share the same position and return an undefined result.

Queued for 5.10.y, thanks!

-- 
Thanks,
Sasha
