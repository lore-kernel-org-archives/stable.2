Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795146D55D
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016190; cv=none; b=r9jll7MoOqwMy0el4L1FAT2+IBE4UzT9o19de7IOup+l+l/nI4q/nmBYFsmlWt8J6kh/s8e2xdQrQsrKNnbjSkvmVlkBUZ+V+CEnxLobPrTuOPyHjKbXBteaZvhxHSA8mFM2+5Ygmg4jABEVtx6thTL9IU7Wi2xDIzRZbBRuaF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016190; c=relaxed/simple;
	bh=DPJhE7DSm7fhjaUOyLzhIxyuzWXFVHYa2G+da+2GkCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lilwUdHQqyBf14ta+BHd8NYHHvHYoxx1cYxycXqZI1RKmJObMvT15nhs/+juCDHLWYwleUS0spRm7G3VzBXe5KnFzCXieO67/8Vd6DwbPqfZi8r/ZaGyjDn8HwFsacMECvJU4B1B8FO6UQw9E2iETjVjVGUn+0Mr2d+J0Iz26eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9JVXKO0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9JVXKO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FA11F000E9;
	Thu,  6 Aug 2026 11:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016183;
	bh=ETFue5ipcpPj8CwOJSA8dxY/CQyoPMrRHN1OJjsEHvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U9JVXKO0Wd1WgI6331lXmNQvztslIMt2FCjQiaBO9AnKNcdyzsYlizIS3SVZMP3EO
	 NjeyH1+vMVOl98Sddk3whCx65X/WwWetA/xTl2LaYi2h6Dk+Wa/l8ZfBy2Iu599wk2
	 NmnZqKv5TiQtnkNmBcPNXWyzg4M2m0M0y5K4BHEsHn2Mkhcjp3LvijTbr80DZlJ/vK
	 Lv9konDwxJeY8jnkY0XHOcEriXRxG05SLdjKV4FXlSsbr4DuBNeMQ+tyWtzkG9jD0s
	 eUBBOuHMHgPv/W2F6gJ5BMEy+U+PsMdv/cZHaa6eaCvFDGtMF74+mD0uGPgOoa10O/
	 emLMGSXTKnffA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	David Hildenbrand <david@kernel.org>,
	Jann Horn <jannh@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kiryl Shutsemau <kirill@shutemov.name>
Subject: Re: [PATCH 6.12.y] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for unpopulated ptes
Date: Thu,  6 Aug 2026 07:35:59 -0400
Message-ID: <20260806021809.0006-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805134349.2776535-1-kirill@shutemov.name>
References: <20260805134349.2776535-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:43:49PM +0100, Kiryl Shutsemau wrote:
> Report pte_none as written in pagemap_page_category() too.  A pte_none
> carries no uffd-wp marker, i.e.  it is not write-protected -- the same
> condition under which the present and swap cases already report
> PAGE_IS_WRITTEN.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
