Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D3345EDD;
	Wed,  9 Sep 2026 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936051; cv=none; b=Jw5mAxRiCaFi7ewuHXVFEBOXlfYz5idkV9YIHkXSoo0QA9QTDnpSiQdDnjlxB+vfpcvFAKfwc85Vgsk5H7dwaq864N0WAQGeUivfxsrg14Kt1m4g+aTpmKXsPHT3RcNvKlx2/HfIlkTDGVA85n9G9DF0wcV8SN1qhh2MvP3fyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936051; c=relaxed/simple;
	bh=kZl2kjwLaJpUo96A2seUiHTzsLR07/A3fr3+6N0EzpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3brfvlXrRZUlPYrutnixoEWOPwQpYFTqn9YOHJ1jjKDzz7c5Cd4NpVaxEYkkvWGdqBuvUv1nr8/9I9RhLbdTCNdOUgF4LTgqVNfLdhXyAn9jgEpj72VIhGYv/7UkAtA3x4+fSHPzO6Ea3oGg8VCuH8LoYf3oE7TECSjmwi7dp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RckfC3Bk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RckfC3Bk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC301F00A3A;
	Wed,  9 Sep 2026 06:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936049;
	bh=/5nTPdl7HnDlhHuu9VYhe8/uvbST2awhkc+EjwlnlUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RckfC3BkCeUJOkZwYsTt7g5r7rIm3AMg4fQMOpvZE1brFvNVQKPaaM82WKO2JRpFc
	 1iLfc+xcsg+E+EL7eYm9Bziq9oGJwa9LJVoecIe5INBJ91Etj2TzoUxU78P/pzkCF3
	 vBZcjluhLqyYFkx9uYaDq5X0codtOeC3Vbl7Rt5T1M3s4n8RrSTciewORY4kc3NKbg
	 ox/x+IsBPqWCY+Lo9ncAKujL/fzX7b/6jT9BpPePDr37Q8lLC6JpXBehpaS8VMpq2M
	 o4XeBAZfKphoevyB/jqYGeSkBeOLt0hxhIx9RM+cYYr3ISgsS9dn9tgWxT4Bqa2UCa
	 nMf2mTHn1EVHw==
Date: Wed, 9 Sep 2026 08:40:42 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Will Deacon <will@kernel.org>, David Carlier <devnexen@gmail.com>,
	Atish Patra <atishp@meta.com>, Nikunj A Dadhania <nikunj@amd.com>,
	stable@vger.kernel.org, x86@kernel.org
Subject: Re: Update on CPA fixes, x86/urgent and x86/mm
Message-ID: <aqD_asyNQgzSQBy3@gmail.com>
References: <20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org>
 <178821524784.3717435.3293914321834699913.tip-bot2@tip-bot2>
 <b2095df8-9991-4e65-9890-c34f8c206319@kernel.org>
 <apZ52DKlJIrpX6qq@gremlin>
 <7fe0aee9-d1e9-419c-9ca6-c0160223d5dc@intel.com>
 <ap_WIZwCPKB07nAf@kernel.org>
 <54f55b19-4a42-4c5d-a6ec-979132e11ece@intel.com>
 <5394f2d7-03e2-4aeb-a5da-60a0368340d9@kernel.org>
 <cd92444e-777f-470a-9bc9-f64e5edf10e3@intel.com>
 <3d7152ba-5e41-4cff-9c96-08f77f60ede5@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d7152ba-5e41-4cff-9c96-08f77f60ede5@intel.com>


* Dave Hansen <dave.hansen@intel.com> wrote:

> OK, so Linus pulled the x86/urgent fixes I sent earlier today. I've
> staged everything else. Here's an explanation for where that leaves the
> other x86 fixes.
>
> ==== x86/urgent ====
> 
> x86/urgent has 5 urgent fixes in it. There are 4 that are CPA-related.

Note that the rebase you did of x86/mm onto x86/urgent added the
5 MM fixes with an incorrect SOB chain - I've rebased x86/urgent
to fix this up. No other changes, so if there are no other issues
I this we can send this to Linus later today, and thus give it
an additional 2-3 days of testing in upstream until -rc3.

Thanks,

	Ingo
