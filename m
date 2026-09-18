Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1701140E5F;
	Fri, 18 Sep 2026 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789703344; cv=none; b=MeHSbYqYiSQ2gYKREPbMMc2SBNgRq3FMuDjgv2KlySOc2o37kc4RlbEhGqsDPMDH9RgQ6OCvCbGEU3W+BrVJAzD71Wu2WaG4mEYs4CiW6cIXbbt36IrECF/i581I/ICqi31UIIyiQ0Fg74tQ41539E/LiywbMiRhUb4dZCrSFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789703344; c=relaxed/simple;
	bh=c4zruUhRlTCaZTakd8VSfyas0wFE1JULdP24VFneNvc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kNIgsUV5LmQac5u6XPiL5VJg23h9YPeufR37Jh4RHbKR458DowgFDwZZWwKHiVkuBy+VprKbWwj/jgKefvqcKDqWCh0cfRaWJroMIu79LmnJ9u+oNbksNvBYbV3Zr2Gckk07gq46p2WVnADw7JU2tgpWswN8mqTAthHWTPmpApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gp+wsNqp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gp+wsNqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3D21F000FF;
	Fri, 18 Sep 2026 03:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789703342;
	bh=R4q08ERpIGjLGCf1CNdAlc+T9V2LICMNbsbDVrMf148=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Gp+wsNqpXSHoQgyqaAiMkwFieo3u6guFDNRHvmB2pdaa7h4DoXupHH121rpO462Hp
	 4hT/7JdNNOOsujTnobpCQ061+0AHRj9EiwC7L+WL7b00jqY40azeolORSh7Pqyup35
	 /+x0IhbEDxQ8WgK9jgR28vSQFDR1GhOIDP+OuOMk=
Date: Thu, 17 Sep 2026 20:49:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hongfu Li <hongfu.li@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>, Colin
 Ian King <colin.i.king@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Mina Almasry <almasrymina@google.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hongfu Li <lihongfu@kylinos.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm/hugetlb_cgroup: move the per-node usage along
 with the folio
Message-Id: <20260917204901.efd6e6908c85c104467fdeff@linux-foundation.org>
In-Reply-To: <20260918-for-hugetlb-charge-v2-0-2b6d8c2bdc36@kylinos.cn>
References: <20260918-for-hugetlb-charge-v2-0-2b6d8c2bdc36@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 10:56:09 +0800 Hongfu Li <hongfu.li@linux.dev> wrote:

> The per-node usage reported by hugetlb.<size>.numa_stat is accounted
> against folio_nid() in __hugetlb_cgroup_commit_charge() and
> __hugetlb_cgroup_uncharge_folio(), so it is only correct while a folio
> stays charged on the same node and in the same hugetlb_cgroup.
> 
> Two paths move a folio which stays charged, and neither moves the usage
> with it. hugetlb_cgroup_migrate() only moves the hugetlb_cgroup pointers
> of a folio migrated to another node, and hugetlb_cgroup_move_parent()
> only moves the page_counter charges and the hugetlb_cgroup pointer of
> the folios of a dying cgroup. In both cases the node (or cgroup) which
> was charged keeps a usage which never goes away, while the node
> (or cgroup) which ends up uncharging the folio underflows as soon as
> the folio is freed.

Thanks.

> Fixes: f47761999052 ("hugetlb: add hugetlb.*.numa_stat file")
> Cc: stable@vger.kernel.org

I'll queue these for the next merge window, with cc:stable.  I don't
see a hurry to fix a four year old bug.
