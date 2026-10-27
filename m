Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119796;
	b=nmn0NELlwij8xv0v/E+rBYxi2dtgl0lUIagB4m2VgPktHzVSPzt4i7kAOT1pjFvocafK
	 wi8MHaf7+zEIharjNYfwCSC0BgbGJ6j573kqFswsfZJANnwAe08Taq9c8VTSbdcqp/km8
	 MTZTKWn1zWQ5wlay89dKiDhV3V0MCN086KOct2B+02B58/FhRuuQKFlabodalnM2U1AVT
	 s0FAHx0ED/uORBGrg4hJRKJkpmigw6hANKUXla1iOq6TFHQxqQIf3IHT44c+PEQjK01Ty
	 39hgldVC1ZwUpU1eLPTZyMQKsSASDDdpmZn7nxZaUy7iwlm3kaQgD/XGMwTUCAZW3gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119796;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=8a32jiRIHg8MgSuY0NmSAXzTQgRPvZ2S02jS/vgMnZU=;
	b=kHJ/SthEsEz1sntqBDvfHhPs7IHXw+8p1TaZDTeS1lPYZLMxXOKoi0B2Q9bhifaBruW8
	 9EWlfS561R1HSgPr1c2ggXCCRiA27TKBV3f5o+uVKkcItlci+KHeae61cytD2ujB7kOK5
	 zs+/X/JXdWVf6uANOrshposGFBlq7NBcBaNydJDZrJcqCfaDtOBf0P3CroesRODuPFd03
	 L+L+x88Jhpx3aDCVFCLuUCMisHKHpXgNT6CUjgLxHOBNTJVanMZ0Pbo8rgAEFXQYr0HTI
	 9plRFNpp/2YBjWKmGtOChSwdfyzxTRtxumUb1+HR9YlJgUJhnEoSRbXlHXWS3KDXFog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MdieU0Fk;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0E7606A31A;
	Tue, 27 Oct 2026 16:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD0E7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MdieU0Fk
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93F4415A1;
	Tue, 27 Oct 2026 09:49:51 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 152893F59E;
	Tue, 27 Oct 2026 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793119794; bh=Wi8JCvfDMPalrSXsQQq726qxz61LBuEE0WYkMWBem1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MdieU0FkgBD9jO+oaHHb+PAU9kNPVL8ASMuIuRPu9Bb+9eQH/ca8vRrM3DvNmi2wv
	 P0JcOZauSNMXB9JRYOb4jbHCvFXAWy9LbhupAt+49YAEvtdX52igbRblbRKxDC6vHv
	 muZXbhgWDd0yQKEsjKHTxULFBhdUdGv5Zxyp0Tsc=
Date: Tue, 27 Oct 2026 16:49:45 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zhao Gongyi <zhaogongyi@bytedance.com>, will@kernel.org,
	Ryan Roberts <Ryan.Roberts@arm.com>, dev.jain@arm.com,
	baolin.wang@linux.alibaba.com, lance.yang@linux.dev,
	mark.rutland@arm.com, akpm@linux-foundation.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: restrict transparent contpte mappings to valid
 PTEs
Message-ID: <auDWKd-kXH22WPjD@arm.com>
References: <20261013093600.54995-1-zhaogongyi@bytedance.com>
 <daab2f45-56c2-48ad-a24f-aa4f889e4da2@kernel.org>
 <e0f60526-bb95-4d39-9a7a-72cdf32ca5b6@bytedance.com>
 <cc2e3af6-bb56-41b1-9cde-151797c3068d@kernel.org>
 <3b57c214-6a43-4fc7-a531-fb5eac196465@bytedance.com>
 <at9H9Vkx57pIcPos@arm.com>
 <c267c29a-5678-4c0f-a15d-e5c12ae8c427@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c267c29a-5678-4c0f-a15d-e5c12ae8c427@kernel.org>

On Mon, Oct 26, 2026 at 11:33:31PM +0100, David Hildenbrand wrote:
> On 10/26/26 13:30, Catalin Marinas wrote:
> > On Sun, Oct 25, 2026 at 12:00:33AM +0800, Zhao Gongyi wrote:
> >> On 10/24/26 4:55 AM, David Hildenbrand (Arm) wrote:
> >>> If we have the spare PTE bit, why shouldn't we just use it?
> >>>
> >>> It will make batching over PTEs faster. And we care about that for present PTEs.
> >>>
> >>> So I don't quite see why the stable fix couldn't just do it right away? Do you
> >>> have a prototype that shows that it would require significant code changes?
> >>
> >> I tried a small prototype that keeps PTE_CONT on present-invalid PTEs.
> >> It leaves contpte_set_ptes() unchanged and makes contpte_try_unfold()
> >> recognize pte_present(pte) && pte_cont(pte), instead of checking only
> >> pte_valid_cont(pte).
> > 
> > I think it's worth doing but currently not sure it buys us much unless
> > we also change pte_batch_hint() to cover such entries. However, if we do
> > this, we need to audit the other pte_valid_cont() callers (e.g.
> > ptep_get() needs updating as well).
> > 
> > So, if we aren't going to change pte_batch_hint() as a backport fix (I
> > don't think we should, it's an optimisation), I'd rather take v2 now and
> > continue with a proper pte_present_cont() etc. patchset on top.
> 
> Your call, the version actually looks quite clean:
> 
> https://lore.kernel.org/r/52e7e1f6-3535-474d-9b46-6bb62f96eefc@bytedance.com
> 
> But yeah, audit needed (e.g., no need to flush when shattering such entries that
> are not valid)

Yes, the fix looked clean but I didn't particularly like the asymmetry
between try_fold and try_unfold w.r.t. pte_present(). Well, that's more
of an OCD ;).

Going forward I think we should move towards pte_present_cont() but
together with changing pte_batch_hint().

-- 
Catalin
