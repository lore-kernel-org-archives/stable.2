Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B99368D7E;
	Thu, 10 Sep 2026 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789012227; cv=none; b=hb/lATQBbiMRmr6hf8bcXB/Do90fU6HngokcvE4ixL2bXgg5jqjN4AlnQKTbvUlMCkWaa1Aq2R+gKNXlQ0q7ikIR5ND1T/ZPzo6JDrAXD6iy3MyVr9UtEvjCpru5yOxAhDfIeGTID3oi8L941Js1HEm2Oz72q+qDa0vADEOrxG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789012227; c=relaxed/simple;
	bh=Fl2hD7eZNPR3m1nJOG44jeeOc2XZ40LE5CwXFkJxTQY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dbWFotytjZRDiEHxj+ZDkBtvOBg1QdJy8LKhvzKyZXaxBRS3vcLAlJU7vy1/3itl7cgDadlLHJHwbpYzlEkGfMnMsmtIC6k+UNPUu88rXgLO9JFGBfmEUedR0Hp0SxhnATr6rC/FitcoqzUiPJSyJoHP9DQ3ktymiUtcbJQw8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jr2kXP2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jr2kXP2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEFA1F000FF;
	Thu, 10 Sep 2026 03:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789012225;
	bh=FFDeRkMdJrtTBEuOUYj1R+PSncWxAsrSSczDwcmPw7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Jr2kXP2b6c6JgOXQemT93dXI+H0UX4QrM/Rn5jtkVFcSsyLyKgE0JjmTNnlvjcIlr
	 r9APSb9SYZ8VhAypYkSfgEXkdcWwHOI9YgTPlKlPTdXX8b2BeknzDM3OEWQN7JvzaK
	 iPGEniZlHWHYr7Mwo14u3oGGZBgHpypdeVSiHYWY=
Date: Wed, 9 Sep 2026 20:50:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinmeng Zhou <jinmengzhou22@gmail.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Jinmeng Zhou
 <zhoujinmeng@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: fix subpool minimum reservation rollback
Message-Id: <20260909205024.01f813f93a3307099a0a3b5d@linux-foundation.org>
In-Reply-To: <20260907132055.26696-1-zhoujinmeng@bytedance.com>
References: <20260907132055.26696-1-zhoujinmeng@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 21:20:55 +0800 Jinmeng Zhou <jinmengzhou22@gmail.com> wrote:

> When a reservation request is partially covered by a subpool minimum and
> the remaining global reservation fails, the error path first calls
> hugepage_subpool_put_pages() for the subpool-backed portion. It removes the
> failed global portion from used_hpages only afterwards.
> 
> hugepage_subpool_put_pages() uses used_hpages to decide whether rsv_hpages
> should be restored. Since used_hpages still includes the global portion, it
> can remain at or above min_hpages and prevent that restoration. It then
> reports the subpool reservation as releasable, causing
> hugetlb_acct_memory() to incorrectly decrement h->resv_huge_pages.
> 
> This was reproduced with four 2 MB huge pages and a hugetlbfs mount with
> size=10M,min_size=8M. After a successful three-page reservation, a two-page
> reservation which needed one subpool page and one global page failed with
> -ENOMEM. HugePages_Rsvd incorrectly dropped from four to three even though
> the subpool minimum was still four pages.

Thanks for making a test case.  Perhaps this one could be enshrined in
a selftests/

> Roll back the failed global portion from used_hpages first, so that
> hugepage_subpool_put_pages() evaluates the minimum reservation against the
> current usage and returns the correct global adjustment.

OK, I'll queue this for testing and review.

AI review might have found a couple of issues in the nearby code:

	https://sashiko.dev/#/patchset/20260907132055.26696-1-zhoujinmeng@bytedance.com
