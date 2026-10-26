Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793034735;
	b=hJrFS8Pegjczj93m5EzAbCkLcqjKNkz83cyeixXGdiJPVJfGM1ghUwbwXhSxSjpJGwbt
	 AOVeiyNUveqf7GpeooMT3ZF1N/w/+BE1xObPoKQrFh+1SNs69i2OjPyUGs0YYuE2wxjI4
	 5qcIjKX5g9UukD+GDzYl+iuhsa3SrCnBIMVR37mrCVyFA8bBC1rDc9a2Vma9SNrtLsWH0
	 mqZMNmqAra1/2wTXBBeYSatyLgXQTiarnQVb/8TdebYQSCPm/yjPMW4uUzsagmSIavCHm
	 hLKHWZtib3xLlB4WqiTgbkM+9c8ESdp240R8nFBaQKeQhtPnx6vFm4I0zn33VvceWaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034735;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=RZqGYNXG9Jy9oaDhM1F6gbcQnqTBe6d0+Qk2lQBEUtQ=;
	b=N6M10dF2N1XTVv0GlKbPr0n8gwF7MKi4oFnKBxIXhFF/qcojO2z8VnVuL/7DJqfXIL3z
	 pFpufLHpN2H9voXvFRgmZ7MzcJK187ozkByMC5ylo3kY/bueVe732FBlWIVi556PsLaeq
	 KRoxHHhJJKc5OXPhh2XDbi4jnn1/OMPtdvK4IqoQa/WvDOBpf2h1MsbpogMx72M8Ksw0t
	 G1x/5LmdVL+gCnhFyVv47tOKACqEjIiGpgjuQsylynKNd54w/kXJ0vEzXcwCJ896U97Hs
	 Raj+yoJUDsd/nc4Utk1YzWuBl3DjVOv/rg4wMw5tZefWPUd/rzyMpoGFINkfOusXxoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=AbWyiBsH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=m3cPI2hm;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB2F606A31F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 17:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AB2F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=AbWyiBsH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=m3cPI2hm
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id A3C0E13801F4
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:12:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 26 Oct 2026 13:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1793034733; x=1793041933; bh=RZqGYNXG9Jy9oaDhM1F6gbcQnqTBe6d0
	+Qk2lQBEUtQ=; b=AbWyiBsHJcOAxp78Gt4falXdJ/81IDqSJLWnhkR08Drjh0il
	rRI3YNXUjvbhb2cf3tead8IQuqocZRovMqAiQWbMzdOMyv0Ipo1EgG2h+nQaIvkW
	DYJxu8IaaEHigLR3MBC3dSruMXaU5GG5e8cZ1kWqiLNNb1R6iu6nNRuZmANYH7Cy
	7H4Y/COcGaaFYj8DvBV/ymHEZJRsSwaWh+jONqTrghBnFfV3FqoKbvke+klVKPt7
	IylY2026lfRWAKvngJYsz9PKemVYH5ViGSHWSV9EeSBFoLcZ64+YtglHDEUC7JqQ
	mSWz20w0hZx0pw5bwPoiNw4E8lk5WBAiDX0v2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793034733; x=
	1793041933; bh=RZqGYNXG9Jy9oaDhM1F6gbcQnqTBe6d0+Qk2lQBEUtQ=; b=m
	3cPI2hmhe5hC9lykGVQzMYBHrGuUtBaKBX3b3PDp5p+gcvgP1x9snj9bqSgRM60A
	npnPx0faO2Nl+EPpUAS5vSOXXCEas6LUFCBn64NhUTO7uom48ZZfYftzLGnZCTAj
	LtzUaq6dzH1iJJbl8qOR6Osp5N6ebo64RU1Z30eCgRvN8YXm39fe6INPBOD7geCb
	MFy52sYavldvCCnTMEc4Ld85f1dZttLwcdqqumhqWEfGTdZjcrM+P19iBuNTVBiL
	qOIGBRRb7O29niDiljAJe0MXjiY6T1zjmhgtKgAEe3mHF0nOr9neg8yISNGwCn1B
	bGvglgPQ/spxAxFk2eeHA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793034733; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TGQ0zx+CJT5qsEFlneAWy+5b2j7chVl608JTHwAbd/1CU7y
	n8FxUjwIxIOoqG/51Kl6q0ytYhxjsxL7ae++0e1k6hwmUeFO4WlspsUBg+T7cJoQ
	CEXoqQJXFfqPwhlAJ7NMsIL/zPy7cB0ZX4DwinVeJp96BQp/taBCbwRH0Q3m226y
	vX57HI6/c0ADoDwWi+G/m90zLtErbzmjtf+8ODPyQznimXbWdG6I0QXwGRgxuN6D
	ZeH7oGBAyG/g6od6cqD2whVdpM4V/oqz/tp1JgK7LS7mWKk67XUURuuK/lb6fGck
	+c7e4RVp9zQx/jXJDyDx+tqMXyCxi8Mr2g7oZXw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NjjF5I72RcwC2+4ccWoW5S+EHKEscCvEII6NdBABJgg=:Rd0QNiSVptMYykHMLxZ8QpMclorHmpkWRqBU7dC9M/g=;
X-ME-Sender: <xms:64nfaqla3Y1_T0gGn6lOm1YQgBvqZstKIvz_kmKG8_kK0aQpVB0FeA>
    <xme:64nfaojA_xesgJNSkuazJJSILp_fHjMzysAlADF7tSNvL2WCxu-LjVdLKajwpLwU9
    dvfEd7a-wmmUNs11ZLnnm3tcnCKHriorz52g1fVorZBay8nqOAPuY8D>
X-ME-Received: <xmr:64nfai34Cu5W37PFLt2lpW_MgC6hU0egX9yN3JXAW20U5KMizTslMQneuco>
X-ME-Proxy-Cause: dmFkZTE8ZOKPwc5EzHtOWWinHBwzi2uf5XLjKi9jT0n+Q2/8hHEk/Az4FBy+BaF9zD4zXg
    S7yOtBmoLCsSHpCAzmHJKhimZLJIJSfin8UFhO1xIVZuJgAH+H9RthWtcAyMIvL/aW7GrU
    pfcDJY0Kg+JaM+oPKz/gLV+sFVN/Q+RPDyrZnPWdUhzuz7VIjsgAWzMw9d+YYXSRF+Ezpk
    nhF75BvW1D4+YWIZ9mw8tSXJ8mFZjBRM83ZsHx3DhPKpANNDVd3JA4r4HzBG8WaAYbTKR0
    t8crRv2FlN/UxXmh0hAeIgMh/lbKcb3kQMtWtQXbhkZGSy0F+zmf1rTixFGiyk4nwDf0bN
    PQijd6ps8/hCEbxR/vj+M4pttglEEVnSfU/xua8Z7cGAk7tWqNfCbl+u8uOfTYlgRN5YpE
    2Vrk8QzMLmRxH+oTmXMe1x+yTV/iWxw08D4CDORDP8fq7I1429eegPp1LN6wMPjWzwksUk
    Qw1WNKg2rdZEB2oTUqg028qyv33q5076GUQzmqjhhbyqO+JJu+Z782tynz23o9x/2KFw4O
    Pm12/RmGdNbvwuf7OOWICCT4MOlU79OLzzHgR8VaIpyBjThhbfkbDstz0Qdt5FfTvHDcsH
    fR1iPr4h+QtJJ0lCnZNfRvd6dZ0laru5GMGUGqUR9V7ajCDZW4d0lVHDWFGg
X-ME-Proxy: <xmx:64nfavM2JRyZebVj82zcOB8GMN_Vg8Ss00kKstbg8o8FeW5TvbbpJw>
    <xmx:64nfaslAFKEu9BHWSiP2__QDHI202MX4gBWy5DimVV94YF1RZZ8Szg>
    <xmx:64nfaij9W1EiG4T2OpidKyD07LJlqGeXReigCX2rg3AngGSn_l8mJw>
    <xmx:64nfavEOKzypMUlFwlkEiigoQsQ-BZpooV48zHPnmhTH6lhMhpopxQ>
    <xmx:7YnfanDN6h8UCSIsbhn_F7PAJD8llKYUhfVYkligy5QhEpsS1_az97hx>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:12:10 -0400 (EDT)
Date: Mon, 26 Oct 2026 17:12:09 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vladimir Davydov <vdavydov.dev@gmail.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lukas Czerner <lczerner@redhat.com>, 
	Carlos Maiolino <cmaiolino@redhat.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Stevens <stevensd@chromium.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, William Kucharski <william.kucharski@oracle.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 09/16] mm/shmem: preserve data in clean folios when
 splitting fails
Message-ID: <at-GrQNgF3V_tL3w@thinkstation>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-9-703206d5fa0c@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261026-fixes_shmem-v1-9-703206d5fa0c@kernel.org>

On Mon, Oct 26, 2026 at 10:40:42AM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A shared writable mapping can have dirty PTEs while its shmem folio is
> still clean. A read fault can install a writable PTE, and a later store
> sets the PTE's dirty bit without marking the folio dirty.
> 
> After shmem_undo_range() has handled the boundary folios, a concurrent
> read fault into a hole below the new EOF can allocate a large folio.
> For example, on a tmpfs mount with huge=always, the fault's offset must
> be within the file, but the allocated folio can extend beyond i_size.
> The final scan then finds this folio and calls
> truncate_inode_partial_folio() without marking it dirty.

This is hard to follow. I asked LLM for a diagram. I think it would be
helpful for the commit message:

CPU0: ftruncate(fd, 3M)                CPU1: MAP_SHARED, tmpfs huge=always
─────────────────────────────────────  ──────────────────────────────────
i_size = 3M
shmem_undo_range(3M, -1)
  first pass: hole, nothing to do
  boundary folio at 3M: hole, none
                                       read fault at 2M+x (below EOF)
                                         PMD folio [2M,4M), crosses EOF
                                         writable PTE, folio clean
                                       store to 2M+x
                                         PTE dirty, folio still clean
                                       vmsplice(2M+x)
                                         extra folio reference
  whole_folios: finds [2M,4M) folio
  truncate_inode_partial_folio()
    zero [3M,4M)
    folio_split()
      unmap_folio(): extra ref
        → -EAGAIN, PTE dirty bit
          never reaches the folio
    folio clean
      → truncate_inode_folio(whole)
        [2M,3M) dropped
                                       read 2M+x → refault → zeroes


> Splitting normally collects the PTE dirty bits when unmapping the
> folio. An extra reference, for example from vmsplice(), can make it
> fail before that step. The fallback unmapping on split failure excludes
> shmem, so the helper still sees a clean folio and drops it, losing data
> outside the range.
> 
> Mark large folios dirty before partial truncation in the final scan,
> as the boundary handling already does. Exclude failed-fallocate
> rollback, which must discard the folios it added.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify descriptions, adjust comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

The fix itself looks reasonable:

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
