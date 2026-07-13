Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9AC1DFDA1
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960946; cv=none; b=Muiw5AluHcy/vD4+cJl3pAqHVV8QDNb0V5PjiQjjQJC1rR0m+aZYde7BtuspVftNAz/LbGmvRUhJyC5z3yXcgDUPqnzlCwAJrbR9hTEJ7JUQ6hM2XoWJzIqH9igg13EKN9cxNWUc95LWHVwKpXFe2HpoM5DjdSIjpvpzRn+P2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960946; c=relaxed/simple;
	bh=0x4QPJy3oGRMxfHWoYqSLp4a5w7gPSX6tWw8LsKJyyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvTam+/H9yY6JEehpY0/Ra782+JzWpTz1ojCCqtrj7OXiiPfx97813f35Acrhi926uvf+Ue/7ijIPZEz9J/PRvz+oH5wsc//tI/ju18tlJQ2o5D7THcf+4arjyqDqUtPhVJG9Vuk1SCd7ut1DXHAY5V5hfO3MlHSDj1oLYGGXdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMD95T5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMD95T5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10EE1F000E9;
	Mon, 13 Jul 2026 16:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783960945;
	bh=Zltyqt7dF1hkJN/jP/CdnhprTdfvpBe1oag9qSSox24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YMD95T5gB5V6T1KmPKUt3jBxes75nLN+JrX7ufd6wzFcjrcdf4OPFO5O/6KEGbI4p
	 /qPsJdKgM1VcjGX+E9RJOqAdM796/JvnoQaOR0QS92oa5R1put/ZxPUddbroI2Tu71
	 FefurKURKfoiisCy/CjS7hvxUrfgD1Ex8u47gMffmBu9NPWCSru1kAE1rx7Y29oejY
	 7i1zDqIEnOgFDcMGP2JEkipfRSoxeoDToKGDEsej2BP1w2RYFvievCeyzKg1L1xlH/
	 YKrYIjUxFoY2yWG5K3uqnUsZ7F3Xt7FFGhZzEg5MwswwfwagH1A1r0Bqd8ZvZEmx63
	 Lmwi+0z29/2Zw==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2C724F40209;
	Mon, 13 Jul 2026 12:42:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 13 Jul 2026 12:42:24 -0400
X-ME-Sender: <xms:cBVVaunnabxwFOWElc-2hiBfATA0yTqjWE3aMVTIQndTuJglQjbcMA>
    <xme:cBVVaoKqoeQWkiAxePVsb5xWtY9UPuGCuRv4lu1mcCUm8WG1U-9bL-DnSuJHayltB
    kbDhU-jlolP3PSyv8edC4uYgNZkwxEWwbaV4_70CFloi6rugs7NFZC4>
X-ME-Received: <xmr:cBVVaraMibBRTCi72ti4GcRWQ5JyV8HJ7ZlaaQ-tw8zj4r8k8gVN2Tc0ga1NXA>
X-ME-Proxy-Cause: dmFkZTGMoWnWRGMKpgIRcZga9S7P7sHAGK5d+gFuMURcEOT0aJUrqozEaYj6fAMVLY196L
    c7Q9Qx95Y6WcY327qRelJqkKmKiY8PyHcdZc3JZu/hVxbAUCmEOUcUUvGZPJlzK+Zg1A7p
    E1M4Hr0gckN5dJRqg90LQ0EHm2k1fI/i+fUhPF+S0gisFoPy96WSVpdPglvA43z/98UfZS
    77zo20OTGrNknxecuDjYSkHGwSxjzQ1LYlvgazPzK8oFp3YKDb/rYy0YfHXnH6tiE3ZJF7
    ZokTq2XxIK+Yzvex9+lS2uKqt+BJb+586vgE/3bYp3UeKEBWyikgLa9l9cHHjIxzYEIHil
    oF2jNkQA3L0opoOSBPQ21b1KwnAtX+7mm1hI1VkIvCQ4Sd8xTjNlbp2bhYvHJ2okcMR4ns
    hsRCs5wvczPDK1sHUQYigsqKB7ZtUPERQqVE+pr7t0diJqU2CJ0D6rKy0JLWAbPnh0PP+w
    GMO82NWmJpzPCDTYl7tKUndgaEXCJlprGOkG6oO+jiyNiJ6ompZ9Gl/0s/kkHRKHMwro8s
    R9WYSyj47gkweDae0dm64/jnpgoYlfQRkSg8eWsf6jTGBGtei9aL7PRaOPj+mFaLXnfhGc
    FUKxgsObsfGFTX1wCE5bSoek7+u19U/q8fwZmEcgbsplA5BpMngGDPZ0RlYA
X-ME-Proxy: <xmx:cBVVaszZU1TD3CD3AsVnwyX518CY3FWJekcfZ1uGZO0tyLXOt_73IQ>
    <xmx:cBVVavY-_LVEzdVDUJGtqVbrXGgvLeKIZpGs4SCglyb0k4KXp2XSCw>
    <xmx:cBVVajXlPXaX2BcJ5bBNoWT8IgmSVzr_trhD-_ioOaq5hELW3DCn8g>
    <xmx:cBVVaqFIKNFRiu1WcDspECKkHRpK8vBhy5plkTOPM4mCrQJ8NdAXpA>
    <xmx:cBVVamEIjRt3MpSq9SGrtev-xed03Gb6y-njY6BZpA-E3wjOpAI01VIx>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 12:42:22 -0400 (EDT)
Date: Mon, 13 Jul 2026 17:42:21 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 	Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 	Vlastimil Babka <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, 	Uladzislau Rezki <urezki@gmail.com>,
 Toshi Kani <toshi.kani@hpe.com>,
 	Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 	Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, 	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 	"H. Peter Anvin" <hpa@zytor.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 	Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, 	David Carlier <devnexen@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 	bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v2 1/4] mm/vmalloc: acquire init_mm lock on
 huge vmap to avoid ptdump UAF
Message-ID: <alUUfGnM_vbhOTVK@thinkstation>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <20260712-series-vmap-race-fix-v2-1-ad134cc3a12a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-series-vmap-race-fix-v2-1-ad134cc3a12a@kernel.org>

On Sun, Jul 12, 2026 at 11:42:24AM +0100, Lorenzo Stoakes wrote:
> Currently there is a nasty race between ptdump and vmap when attempting to
> map a huge P4D, PMD or PUD entry.

<... skip 145 lines of commit message :P >

The code looks good to me, but I think the commit message needs some
love. It is long, and the pieces of the story are scattered: the race
itself only shows up around the middle, after several paragraphs of
ptdump background (including the arm32 and EFI notes that the text
itself says are not relevant to the bug), and the one genuinely subtle
part -- why the read lock is sufficient -- is not spelled out at all.

Something along these lines would be much easier to follow:

1. The race, up front. Diagram, if we you feel like it;
2. The fix, and why the read lock is enough;
3. Why a trylock;
4. The arm64 wrinkle and the temporary ifdeffery patch 4 removes;
5. Secondary changes (guard class, walk_page_range_debug() assert);
6. History, if you feel like it.

Point 2 is the one I care about most -- the same reasoning would also
help in the comment in vmap_try_huge_pmd(), where "Therefore, acquire
the mmap read lock" is doing a lot of unexplained work.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
