Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC072313E21;
	Thu, 30 Jul 2026 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372927; cv=none; b=F6Pv0SNT/CBIiOLutpHHohw7HUf3PAiJ7uab+Gfc079/k/dvr5LnflzeFMXwaPuJdsvm7FIW0l+3n92xEj+qKfX+jVv2g1pg+u7B/dAn0Ik4xvrzdw3o/2HoRA79uPio0djnzqKFuWXBz1BA3WRKyoFDfmqGx169T/etev7/yv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372927; c=relaxed/simple;
	bh=N1SwWs+o4in7aeTTZ7kegDyZsZzmPQFOJBIM8hUigvk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Nzy2TF+p2S+Et7XB8LUQRlkBNqV43jrYBW5mFDRXUwEZVL+PJ0F5rzGLOxC2+zLfwnUp52BEQuHTuqcfaTqqfltkvoWJx7CECsUsgu0NONhmLrqJXk2ggH1DDHCSQDIdOYeJ7s+MSJ4QaI3ujm1kT/XUcrxbHjM0BHJmuQzqHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GbhS64Ol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GbhS64Ol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DD91F000E9;
	Thu, 30 Jul 2026 00:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785372926;
	bh=2ge99MicqCJZVBzMhvmLfMa4E6XjEn3jhqh0vIzfEiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GbhS64Ol5wSWM1jNHKBXGbtg2prTUayi7T7xdxtugVqKV6gQQkIA/iYD14KuVZhpp
	 jHP3vWz1fU1Fs0msPCrj3PHjayQRc6VpBOTA+AC9ZZGK+llQogl0WNRKE0RDCS9jAo
	 9nYODBwzmvEk2F7Yf0awsovfzXOMdnvhXBa2dqAQ=
Date: Wed, 29 Jul 2026 17:55:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, Hannes
 Reinecke <hare@suse.de>, Hugh Dickins <hughd@google.com>, Yang Shi
 <shy828301@gmail.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hengbin Zhang
 <uqbarz@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes 0/2] mm/huge_memory: fix huge_zero_pfn race
Message-Id: <20260729175525.5e80051b8b21f723766142d6@linux-foundation.org>
In-Reply-To: <amm2GOFablLbBC4H@lucifer>
References: <20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org>
	<f0e39f91-8dd1-4d9d-8d4e-da5d608a7148@kernel.org>
	<amm2GOFablLbBC4H@lucifer>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 09:15:08 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> (It'd be good to get some review on the actual changes also :)

Indeed it would.

I'll add these to mm-new as there's presumably no rush to fix a 2018
bug.  And add my little "acks?" note to remind that review is pending.



To simplify the dependency things I added

  Fixes: 3b77e8c8cde5 ("mm/thp: make is_huge_zero_pmd() safe and quicker")

to both, as Greg applauded yesterday.



Should I be worried about
https://sashiko.dev/#/patchset/20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org
?
