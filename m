Received: from mta1.migadu.com (out-122.mta1.migadu.com [95.215.58.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026644CF461
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792310381; cv=none; b=q9HD+SwUEujulsnxKzpUekh5b3QpLezSbavDLRI9f5g6zYpIX6W4CipguGhpdGTgSHoy4cMIycJekA2QnTEW8TRC7CDGavqW3YYHZrJKgIfM+3F+UPcJKxBvefcPMw6ZgQFn/DJUIBFqi5/N9zxsk+/sr8xbJ3/39QnuG7F+Uwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792310381; c=relaxed/simple;
	bh=lyELolJu2xi7BInGaBj0/nHK9JAkLFJ3iwidm/fclC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2XnJBiz21Am8BC3FZlZ0ZrCKGZsE3pDEe9Ai6XqiRHkPnec6K6Q59hsVotWsYZFMutHngTzr+5YUD/FIXYo9L0s8YjCFMX5b8I7zEi3LKf8oPpMUvlYcP+5nNzkixYrhPixdLX7JAliR7wj91Clu1DM9HrVoR1dNya58nY8FDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lfrWoAoq; arc=none smtp.client-ip=95.215.58.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lfrWoAoq"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lyELolJu2xi7BInGaBj0/nHK9JAkLFJ3iwidm/fclC4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792310377; v=1; x=1792915177;
 b=lfrWoAoqPBnkUHg2TbGWDXZnc3sz1EwVdyHFT9QFlOOqd++K/YkMRCXa6Hy1w9702VnPO7F9
 bs7chR5uCdrXv7hE5tlHCqjppDu8zNGXix1VyMDYs5Ax55vtWtz4JU6jg9T5WB2N7em8yVI5Ncj
 GEBYURkYJvRqug+9Gusqvq08=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 77426602997a8cfb;
	Sun, 18 Oct 2026 07:59:36 +0000
X-Mizu-Trace-ID: 77426602997a8cfb
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
Subject: Re: [PATCH 07/10] mm/hugetlb: tolerate uffd bits set without uffd for PROT_NONE PTEs
Date: Sun, 18 Oct 2026 15:59:27 +0800
Message-ID: <20261018075927.2979-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261015-urgent_fixes-v1-7-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-7-42796911043b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Oct 15, 2026 at 06:07:13PM +0200, David Hildenbrand (Arm) wrote:
>The whole uffd handling when a VMA is unregistered from UFFD is shaky:
>there are still some scenarios where we might have stale uffd PTE bits
>in VMAs no longer registered for UFFD, which confuses other code.
>
>Let's just tolerate that for now and simply clear the PTE bit. Add a
>TODO to really clean up any uffd leftovers when unregistering a VMA from
>userfaultfd.
>
>The handling is now more similar to what we have in handle_pte_fault().
>
>Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
