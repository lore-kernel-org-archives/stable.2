Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDC546AF27
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016183; cv=none; b=MXMmfqV8pvLooFwkQy9Bant8qWxkgITmjWMakOyP//ovAqhlN+mCXK4KzSwG5ZpI0un5LF1d3yf+R+OKKa2XGtDn/ErJ6X9vXaUS4BLWX4s5B5DxMFsMt686xPd/s/RkUjQ84twFGS1P4o+QiGouRRusWQbppMHsAFWqDwyEfjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016183; c=relaxed/simple;
	bh=zasmxL0ToND6KMcpgmr5Zb0Hn4I8svmUWXjBd8uHxxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUauA40Abiej4STcaSxVBrPaTgJO7sjgNrWAMzJHD0J94Hx5pS2XfWW9dFf+0lm9w2jV+wbQaibSrvxRKoGd36DGB3G+kQRYiV+YH36Kb95YHh3bVgxWmu3HFw+b7q//FXHBaHiDwj3YYe2Jr4L98JN7dIlp0jc7K5Lff4FuOa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjgbcGaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjgbcGaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380CC1F00A3A;
	Thu,  6 Aug 2026 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016178;
	bh=w2GezKHb5rDPMGFnycBGZf3QsAcTr3FzOmkXKo++Xxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bjgbcGaEBxwqx5835qZTdRzk0pizX+JBekblmwMt/DG6szxy2g49bu+l52onPbzg2
	 +H9cW6v5sM1H2rGBj8pXMQmHRPOqoJCQ8lLWB4gLBgxi0BA+RfwEYuYYHBU6bJ0hGG
	 suZrLqDg1NDt5I5DBX/KKs3v9XTEyey/5V1d17TGyTa3F+NhYvWAtC+RTHxj6RR27n
	 A/fCnyA0JJl9vYW9YMlpdq0P9PTyu8+pzZjv4xPGdcpYjT9Ym1tGXtqbcbWcNGM5LH
	 9NdnSNkYw83Mb7qfZKr8cEwMMbPlvBy7lLB7RYMtTK2wPoQ0qohRjrBeFv+ujl8F67
	 MnKUvmW177+bA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Sashiko AI review <sashiko-bot@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kiryl Shutsemau <kirill@shutemov.name>
Subject: Re: [PATCH 6.6.y] mm/hugetlb: fix swap entry corruption when clearing uffd-wp at fork()
Date: Thu,  6 Aug 2026 07:35:56 -0400
Message-ID: <20260806021809.0003-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805134338.2776503-1-kirill@shutemov.name>
References: <20260805134338.2776503-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:43:38PM +0100, Kiryl Shutsemau wrote:
> Migration entries legitimately carry uffd-wp, so clear it with
> pte_swp_clear_uffd_wp(), matching copy_nonpresent_pte() and
> move_huge_pte().

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
