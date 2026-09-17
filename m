Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33356327BFC;
	Thu, 17 Sep 2026 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789606385; cv=none; b=odJwZaCOGLf9NzA8suB0Y4mnLvljje5euFjWAo8I+4PXRxioL1Bi4gkJaD5afhbJbpveMo+gK3VUyx+zsKUOweA1QL9I4CsCBZRC8kamBAe1OHMlp65jX+46f15RUxDgJE2cFCiLE6Q9BvDv4vvj76X7nKVDBIaM5AzAac51NpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789606385; c=relaxed/simple;
	bh=RXDABBWl8h9KoTfRjPtbxbE9H0GgjDQfNxrEnnWGIj4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ko4HVKwa9Z2gE1WuKUYaP3ObNbi9WRAMzZgJpjSlCJ/zz1jfPslh8sJ0v5r4JA5sFO0mBYAvh1btc1aeErir8DXMBvIBwON3FZ84QUfJWc3MIc/bsnFUmdFvESH96KK8bpitzW6CvfptYr3XBPhdIgAbLw+gud+7LzYAHiat/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YB1t4XGL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YB1t4XGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424431F000FF;
	Thu, 17 Sep 2026 00:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789606383;
	bh=TnRI04J838QlW2j+xCXhg0sb63Rekek+/bnqBaKeWU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YB1t4XGLoufbU+Z0ue2LWK4XzpzfthDFE7spCTSt0hJ0wcPOszFpvOerzgKStdw/s
	 lCZwU/fLZOt2ZGG+VXrv4aDXIe36Fw1GhmQFDU6dgnR1p3AFaIIyEbcn3fjIL5cnwV
	 QKtIIt5AerXE/Hf2PwPK6T6FhPutQCtf3QlTkYIA=
Date: Wed, 16 Sep 2026 17:53:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hongfu Li <hongfu.li@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>, Colin
 Ian King <colin.i.king@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Mina Almasry <almasrymina@google.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hongfu Li <lihongfu@kylinos.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/hugetlb_cgroup: move the per-node usage along
 with the folio
Message-Id: <20260916175302.be1e68f24b96b7c639cbd7f5@linux-foundation.org>
In-Reply-To: <20260916-for-hugetlb-charge-v1-0-70fb708b2e4a@kylinos.cn>
References: <20260916-for-hugetlb-charge-v1-0-70fb708b2e4a@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:30:26 +0800 Hongfu Li <hongfu.li@linux.dev> wrote:

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
> 
> Patch 1/2 moves the usage along with the folio on cross node migration,
> patch 2/2 does the same for the folios a dying cgroup reparents.

As I understand it, this series affects numa_stat output but has no
actual runtime effects?

Do you (and maintainers) think that we should fix this in earlier
kernels?

(I do - a lot of userspace infrastructure makes expensive decisions
based on this sort of info).
