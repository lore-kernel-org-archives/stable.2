Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681272;
	b=B4qeywMMBnFb+ygEaT3GwFA2m1U06wfETaEUepbPV2fPtkxkmKektjeL204GlYuQH+O1
	 G0cl9xFDA9nmZv1OlV3qSsLZcK8InmuyBXfw6KsLjtgzCRWmjH3XTaTbqr5k+HjaiKlcz
	 BBplkAU4zccFGudcVdywV60SH8rN9DzfleJh5aPwDDBdRLyxZARb0hjrvMfgQqncItfnb
	 magSHN4KJ18hUfElom6rXi29pLV+VFCbyIY0zvJiXkLf8Gb6lneweDUsUOWUm9v6uMLg4
	 RXQcK4gT1bmM7XoIbgYyU+yphrdhSgErzvJ7Yzq/+3bzoxB49PQrZRVgDvn5k3JTpMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681272;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=xIJH830yAU8Etb/lYqZfpJ4EsMpPggWMJX7lGP00TrM=;
	b=aFJoFkE0clO/krJC915lxim2tPN2gALO27dAj3Lx8Ed1/UxIHx0RYH3MZxS2zy31dDjn
	 R0azVfhdvlX5avXJvm/m7fhdAYrYaeWSpFLkPwTCQT3yMRDJjhopShwgO8u01ifo3UqB+
	 DTB+/vpzm7xOxk6LHuFjwGV3j5DtQCa8q07mIQ3VO04RvLmRPwWiuR+sUN29Yo7aIc8Gt
	 7B0PonLIPmqNYN8ktw0ihKiMMfyCAPWa8YTAm1qyz7/rWqF2sDRDn+y4RVqtNrEPELkxT
	 VnQvdc8GKEdj+lGcIoWsFTxhXn30HzIJAEL/sLIb9ZWLmK4FUpb/+DFJX0PwWKV4/HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLdIUvRD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9150606A323;
	Sat, 14 Nov 2026 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLdIUvRD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA86A1F000C4;
	Sat, 14 Nov 2026 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794681271;
	bh=xIJH830yAU8Etb/lYqZfpJ4EsMpPggWMJX7lGP00TrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kLdIUvRDvJxlUbY1ynRLNC3qDVm22HDJQ/oDoeAj04J3VQf5GOK2z+EVYkFf54oeO
	 ojMxnJJciIKBWDTf+n2auyLYOSEpUgnGR63WYG6R7v0ceX42IOP9B6sHO9PCtbaxqU
	 8FTFzMmpeWihgC5vIRFbUbZVoQJLQLQJ1FaYtUMWyWEvptvnftr8Gd8NEwSs/tjm4P
	 IfryQo5zUxv5NMGHR4OmlosERhkQzHZgGtHy0jZYv0hXUSugT1jq3HrSUrJVoQAJ9j
	 BHU7F3zmvwDZJSycFY0Uv4MQdEl6eRlTEvANgZi+rMgpityIDbYPWUvZR5PZlsfO2a
	 LsMXcMZ02scMg==
Date: Sat, 14 Nov 2026 18:34:19 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc: Balbir Singh <balbirs@nvidia.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 05/13] mm/migrate_device: don't collect a range twice
Message-ID: <avinH6zgTzpjMCrf@gremlin>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
 <20261113-mason-migrate-et-al-fixes-v2-5-50a2ed382b61@kernel.org>
 <avfrWjzLQdDcmXO6@parvat>
 <8c79ce88-7730-44c4-92a0-d760d6f8e9e1@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c79ce88-7730-44c4-92a0-d760d6f8e9e1@redhat.com>

On Sat, Nov 14, 2026 at 08:45:55AM +0200, Mika Penttilä wrote:
> On 11/14/26 07:09, Balbir Singh wrote:
> >> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> >> index 9e5dab8e1b77..28ed706109da 100644
> >> --- a/mm/migrate_device.c
> >> +++ b/mm/migrate_device.c
> >> @@ -257,13 +257,17 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> >>  	pte_t *ptep;
> >>
> >>  again:
> >> +	/* [start, addr) is collected if we get here after splitting a folio */
> >>  	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
> >> -		int ret = migrate_vma_collect_huge_pmd(pmdp, start, end, walk, fault_folio);
> >> +		int ret = migrate_vma_collect_huge_pmd(pmdp, addr, end, walk, fault_folio);
> >>
> >>  		if (ret == -EAGAIN)
> >>  			goto again;
> >> -		if (ret == 0)
> >> +		if (ret == 0) {
> >> +			if (unmapped)
> >> +				flush_tlb_range(walk->vma, start, end);
> >>  			return 0;
> >> +		}
> >>  	}
> >>
> >>  	ptep = pte_offset_map_lock(mm, pmdp, start, &ptl);
> >>
> > Is the intended race a concurrent MADV_DONTNEED reclaiming the PTE table while
> > PTL is dropped for the split? That would leave pmd_none() true on retry, entering
> > migrate_vma_collect_huge_pmd() through !pmd_present() and taking its hole path.

Balbir - yeah exactly the PTE page table removal, and it zaps the migration
entries installed for [start, adr) too, so those don't keep the table alive.

And yeah, we would then see pmd_none() on retry and
migrate_vma_collect_hole(start, end, ...) would appends entries on top of those
already collected.

>
> I think this is "ok" for the fix, the hole is collected from [addr, end).

Thanks. Yeah addr > start, so it's not PMD-aligned so always ends up in the
per-page path.

And if the split happened at the first entry then nothing is collected yet
anwyay.

>
> But couple of things follow. It can't be possibly collected as
> MIGRATE_PFN_COMPOUND entry, only small pages. And the collected entries
> in [start, addr) are wrong ones.  Finalize will recover, but the
> migration will fail for those.

But that's true for any zap that races after collection started, so there's
nothing for this fix to do here.

> These all are handled in the HMM walk based migration series.

Ack great glad to hear :)

--
Cheers, Lorenzo
