Received: from mta0.migadu.com (out-199.mta0.migadu.com [91.218.175.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9DA40F750
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792310889; cv=none; b=f3HSuuBx1OZ+fG5BC0tk4DqDTyhb8YWcPP0XpaWOa+A/vn54EePOj1H3bwj+vkcIntWzySe3OKBFEGESlueLLoDOCfEX7ML8y2nKEVj12v5mrkJA3EELKJj8Rgb9cK2aSbNdJr5WJPxAbyxGNSqstpXx2fGbcMEyXr4bByqlDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792310889; c=relaxed/simple;
	bh=XbcCGqXm08UD+4MN89FaxhWYXmB/b4iOm5BY4cHWO+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5nyhUNn0CKAZpCYnnSB2eJW97X1iz248yHEutDE6QKjC7P6XQYOjobCU8qyUWH5DXxUaEGBs0PoYWdhuxPAiwBYOmaaCudeIbtHZcQGzTlqqQq9dpkEi16KRiFfD24gLpjAO2g80p6YnPveh6sxRgpeDnVRWfdYi8AUlo1fvx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p7jnQJDx; arc=none smtp.client-ip=91.218.175.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p7jnQJDx"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XbcCGqXm08UD+4MN89FaxhWYXmB/b4iOm5BY4cHWO+0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792310885; v=1; x=1792915685;
 b=p7jnQJDxQMGX25AeFA7oM+lhn6PaZkuGuFKMJ28uIQrj5oGa14bN9VPLVMltoQNSZ3xMxHJ4
 MBwro4frvjNLi0qW4g74zXI+af9EHawmu1+cfcriWwvf+r4RygGT8ITaYfTpmMiYivez2iKfuca
 bTLLBgBV9PA8Dzjeg0ZTLouY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 56d35b3a46d02963;
	Sun, 18 Oct 2026 08:08:04 +0000
X-Mizu-Trace-ID: 56d35b3a46d02963
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
Subject: Re: [PATCH 08/10] mm/hugetlb: tolerate UFFD_WP markers outside uffd-wp VMAs
Date: Sun, 18 Oct 2026 16:07:59 +0800
Message-ID: <20261018080759.4295-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261015-urgent_fixes-v1-8-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-8-42796911043b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Oct 15, 2026 at 06:07:14PM +0200, David Hildenbrand (Arm) wrote:
>UFFD PTE bit handling is a bit like swiss cheese, in particular with
>recently added RWP mode. Having uffd-wp markers outside uffd-wp VMAs
>already confused this code in the past and resulted in uffd-pte bits
>confusing other code later.
>
>Let's play safe and just ignore these markers in hugetlb_no_page(), not
>silently propagating the uffd-wp PTE bit.
>
>Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
