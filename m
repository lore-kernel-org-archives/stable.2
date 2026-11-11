Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435532;
	b=NyrKvpodv2wTd3FVD0UNhuxi2E6T3XZc+pIbHV264ilhLqnoMwfuA47PS8shlGockw9l
	 Y5a76a8gRIS63aT7PZYTYmHT26KwRyWe214ciAKAgsayMQM2vMixoacdvCPeOkf8cqN6b
	 ouO0i2OD/cMNEBumCTX8IOCmAxdILVqOX0jxNS4Akk4c5Dh2e8Mi254w6WZAgQ81hWXyU
	 Sz0ktnaRwQhVwSJ8/87nT5yWd28dhNVyzJtPVoSekH9MOF7X86B7QgXy2v5exwf2m4FWJ
	 vrxU/noyrQIxYLxV7+plhjg4P0Ld3+E6DmEfEzuCVTptlz2WmTP4JytmyA5Uc6cRc2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435532;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YhV5+1cS0emO9WNIGDx6eBvv8/9J401vylAgxkfRXbk=;
	b=FPuhrvHBMsPTWCtiJivd5KO/hUJpq8TqoD4EY/ptb8TB2t5fNqT+kdUvvn6H14TW9RW5
	 0G0c4XM642UL2g3auYsf6CcRkQjIZw41mWrpxLvpea3DgKVLm+loW7OiQMJw58K6wKrO7
	 5jCGZzHi07CG+RLuYFCj9P6wJw/GpdglW5OxdueNFbEBE+3gzfppKv4wVMCq1FJhH1OEX
	 GKeX0LlabFzDoVyemLRDKUeokOL2ri3+2Ovun2Cx6ZQy4HelQdBCYAPXB61QxJcl7vVko
	 Pi3UyVi8wkCL1fFfh/jm1gByXuBYi+g0d7uqeXGixCX7yXru+P8sV/Tw2igcoS5gFsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=N9gTsIvA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25494606A31C;
	Wed, 11 Nov 2026 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=N9gTsIvA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388ED1F00A05;
	Wed, 11 Nov 2026 22:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794435531;
	bh=YhV5+1cS0emO9WNIGDx6eBvv8/9J401vylAgxkfRXbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N9gTsIvABmWA9FG/AxHE9BOkDd+PvfjEmh/9xkTi4E6r7N/z2bxN7nq40VisAO49F
	 IgUSAQYdoqkEMhROZYKhYAJjC/XC2ncIl2uqCE9C4Ngoz2nsfjoacmgz3/SUlnrv7j
	 f2Mcda/BOS1gCJ4w3EOHrh9rdEh2rSgXT1W+3JxY=
Date: Wed, 11 Nov 2026 14:18:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, "Lorenzo Stoakes (ARM)"
 <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, David Rientjes
 <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, Kairui Song
 <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, =?ISO-8859-1?Q?J?=
 =?ISO-8859-1?Q?=E9r=F4me?= Glisse <jglisse@redhat.com>, Yu-cheng Yu
 <yu-cheng.yu@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Dennis
 Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>,
 Chris Mason <mason@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>,
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Josef Bacik <josef@toxicpanda.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH 04/13] mm/migrate_device: allocate THP deferred split
 heads
Message-Id: <20261111141848.11762f60e737c97c3a239fe1@linux-foundation.org>
In-Reply-To: <95682ddd-d200-4827-a009-77ee59d14f86@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
	<20261111-mason-migrate-et-al-fixes-v1-4-3d2454362e8d@kernel.org>
	<avTB6h61nXfvCXUS@thinkstation>
	<95682ddd-d200-4827-a009-77ee59d14f86@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 20:40:17 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 11/11/26 20:30, Kiryl Shutsemau wrote:
> > On Wed, Nov 11, 2026 at 06:13:18PM +0000, Lorenzo Stoakes (ARM) wrote:
> >> From: Josef Bacik <josef@toxicpanda.com>
> >>
> >> A THP that device migration maps into an empty PMD can end up on the wrong
> >> deferred split list when it is later queued for a deferred split.
> >>
> >> This occurs if the memcg has no heads yet (resulting in a warning if
> >> CONFIG_DEBUG_VM is set), where deferred_split_folio() will then queue the
> >> folio on the parent's list.
> >>
> >> Once a later THP fault in the same memcg allocates the heads,
> >> __folio_unqueue_deferred_split() and the split path resolve folio_memcg()
> >> to the memcg's own, now existing, list and take its lock.  They then
> >> list_del_init() a folio that is linked on the parent's list, racing with
> >> anything holding the parent's lock, and both lists' nr_items counts go
> >> wrong.
> >>
> >> Resolve the issue by calling folio_memcg_alloc_deferred() after the charge
> >> in migrate_vma_insert_huge_pmd_page() and falling back like a failed charge
> >> if that fails, as __do_huge_pmd_anonymous_page() does.
> >>
> >> This was originally discovered by code inspection.
> >>
> >> Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> [ ljs: tweak commit message, remove unnecessary comment ]
> >> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > 
> > mm-new already has this: "mm/migrate_device: allocate deferred split
> > sublists for new huge folios", same Fixes: tag.
> > 
> > Hm?
> 
> I assume that's one from Andrew that he created after a security report (where I
> was CCed and the reporter didn't follow up), but he never sent it out officially.

oops, that's supposed to be commented out.

> So let's review this one here. It's supposed to go through my tree either way :)

Patches are identical.  So I can say

Tested-by: Andrew Morton <akpm@linux-foundation.org>


Based on Ada's supplied fix and reproducer. The report uses CONFIG_TEST_HMM
and privileged guest setup; ordinary-user reachability through a production
driver has not been established.

Built matching pre-patch and patched 7.4.0-rc1 kernels and ran the same
one-folio HMM migration test in each. The x86-64 KVM guest had 8 GiB RAM,
one virtual NUMA node and four single-threaded vCPUs in one virtual socket.
CONFIG_TEST_HMM, CONFIG_MEMCG, CONFIG_SHRINKER_DEBUG and CONFIG_DEBUG_LIST
were enabled; KASAN was disabled.

Both kernels migrated 512 pages to device memory and one huge folio back.
After a partial unmap, normal THP allocation and freeing the migrated
folio, the pre-patch kernel still reported one deferred-split entry on
the root list. The patched kernel reported no entry. Both one-folio
tests completed without a panic or warning.

In two further bounded pre-patch guest runs, eight migrated folios were
queued on the root deferred-split list. Both runs produced DEBUG_LIST
"list_del corruption" warnings during folio release, with
__folio_unqueue_deferred_split() in the trace. In the second run the
warning occurred during a timed scan/removal trial. Neither run crashed
or hung; no delay or fault injection was needed.

The patched guest did not create misplaced root-list entries, so the
concurrent scan test stopped at its setup check rather than running
identical timed trials. These tests do not establish unprivileged
production-driver reachability or privilege escalation.

