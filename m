Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5646D572
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016189; cv=none; b=mnbgFFRokaF0wxFtjH/cTobT8QRUCQQLcEeC9TktmsW/3xx3yJjQuV+jurEV7HeNi1eqBoO1Jql42nmVH0bsezJPoO5tBpb7O6bPC6N8/nyI/C/svFSesJeF5Jb9/CWd6NB7f4yWLl/KxjtKWijzeVo/y4HpJHmeu137SjS7CbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016189; c=relaxed/simple;
	bh=BOYY3hueWZl/PG31xbbduavaWD13V3+7hesrBybY/bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOUHkhVmOqU6oGyMQGxRrUjTZDRoA3sbKDNSzs7eH1u4QKhDEh/QwYp0nblpetjKCCqWMIiQ1xfiSTWtv3R0a22dnkDP/wk+/z1NgVK8NevUnp/p+hsJh7xSzEc4jcfe9OvogwGeN7qCXSd3Bfx79HgRhRWzTusktfPhSqO3Bxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MD3usfY9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MD3usfY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53911F00A3D;
	Thu,  6 Aug 2026 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016181;
	bh=XFwESMWcbVNNHjx/+fUUW91e9GJgt6tDggKhVX+7KtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MD3usfY97T1w/r3x+2S2Z7G0tjBWb7zCyMGRARR5f7WKU5FMHddOvOlUDbkB+Jvp1
	 yI9o3j5JSAHLekZuJ1+E5Q7yrsYZ4b08q8t+heS+5+Y+USoyjRmpdu/gZz8L5QP01H
	 0DRZ3+7lxqMOhGBLU66sW7DqMZ1K7XLEgm231QW7eXp3hYw4T+Prs87nbWxlnX0sc7
	 1mrcq7ZkWrKBMTOu0cAhCeEhmFWbAk1496tMdFuOyQZkAPaYm7bnpDNDEY3kJOThXZ
	 gVQCh2lR5HkMeyZSZbLJB4WNJarfSFMCoLMQheD9WGc44/hCAiRfkMAyNxlt36RDc8
	 TnAtkN/HSlMfQ==
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
Subject: Re: [PATCH 6.18.y] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for unpopulated ptes
Date: Thu,  6 Aug 2026 07:35:58 -0400
Message-ID: <20260806021809.0005-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805134352.2776545-1-kirill@shutemov.name>
References: <20260805134352.2776545-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:43:52PM +0100, Kiryl Shutsemau wrote:
> Report pte_none as written in pagemap_page_category() too.  A pte_none
> carries no uffd-wp marker, i.e.  it is not write-protected -- the same
> condition under which the present and swap cases already report
> PAGE_IS_WRITTEN.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
