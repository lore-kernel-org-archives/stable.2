Received: from mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6896335F184
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304564; cv=none; b=ell1tLhHL+rvkIDsdLAC2n4vIv6AT+XA1D+MiltcwwDgognF0SzTpEg8tJ4mmaOeNNTIP150aa4Za79rTEiUcIoC7kyF7x/w0jsHxMGIZxFuaZUcflsQxKLNmz4p7wBUfoCCZPqiW7fda7hqd7M0iFsc6rY/B0OitXqPgPL5NmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304564; c=relaxed/simple;
	bh=L5Dnhm6NG0TC7wQ45/nC5deJSj63hjDiiipgdq6joRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElLQbtLISQQkphdBje8mztIlXa8TCdyHxX8JiTUYRrpH8IlpSNlfTycPFPEa4S4v+tuaYM8ab05asZV4QQi5DpKL/zu05Ws5v3RL5u0ExIPMpek+8Yr/7BiF5yJ5/WKRajVjmY6F+nKQNCgpIejtylRSdwM/0ymKapNjhy9f2/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OsHCmT4y; arc=none smtp.client-ip=95.215.58.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OsHCmT4y"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=L5Dnhm6NG0TC7wQ45/nC5deJSj63hjDiiipgdq6joRs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792304561; v=1; x=1792909361;
 b=OsHCmT4y/LajFmI0bK7LG2zgbrqRqa+ldNTsDcfgUbYxYYHDLVh5KAERwWpzGFekusOTShiS
 bgOyjNeY1r9LTv8EbaSHJolXmvehSG/DyoLfdzRZ+92zM1tT5zw+5jIXa1FHjRrFmipVxmdMoo2
 ceGX8Fs+qtXYggUpm/R+I9Tg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 582e136e2d86482f;
	Sun, 18 Oct 2026 06:22:41 +0000
X-Mizu-Trace-ID: 582e136e2d86482f
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	muchun.song@linux.dev,
	osalvador@suse.de,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	agl@us.ibm.com,
	mel@csn.ul.ie,
	riel@surriel.com,
	peterx@redhat.com,
	kas@kernel.org,
	rppt@kernel.org,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 03/10] mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()
Date: Sun, 18 Oct 2026 14:22:35 +0800
Message-ID: <20261018062235.15630-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261015-urgent_fixes-v1-3-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-3-42796911043b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Oct 15, 2026 at 06:07:09PM +0200, David Hildenbrand (Arm) wrote:
>Let's fix another instance where we use a folio after dropping the PTL,
>where someone else could e.g., MADV_DONTNEED it once we drop the PTL,
>making us trigger a use-after-free on the folio.
>
>Fixes: cb6acd01e2e4 ("hugetlbfs: fix races and page leaks during migration")
>Fixes: 1c9e8def43a3 ("userfaultfd: hugetlbfs: add UFFDIO_COPY support for shared mappings")
>Cc: stable@vger.kernel.org
>Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice work!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
