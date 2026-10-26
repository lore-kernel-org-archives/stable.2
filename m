Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035577;
	b=uBl9OheqRXOm4NSVLiKcIjWDOxguwjRCX8Gg7bl05AKO7Rz7qcLkzOZIdUap6EJelzE2
	 GswYLDXAShsvwoVlEil7vr5axauXNuXb85WJqsLzUhrydQQbv+By9dOIK2Jb/IoAtXpm+
	 YkFQ6a0+CiLtSkN0ZeK6mMq6/UTP3hCY0lbO/zPccy7CX1KCxAs0O0WHyzJwbnAnHdXxZ
	 DMnxuVIO5z8nDeAXUSidzy/7HonRMQuCIWemKfTk6YU0p9id5OQT/D6ZSzL6hTPyZOUnd
	 FW3aK/+p/NU+yjxW05hr8l8haso44ZOGBpWGIXG/rYG6CaGH+6Pn2Ac2Jcv3LSuY8Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035577;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gozRlQP2gdqbfsNX2AM4B2Y+PLg6RWuvQqaTDn2tvas=;
	b=erz8P1YtdscR2pneyQyDS+fB0nVDzGRFcs2Kkd2HGASS1u8AhiOSqxb6x01TSWXtlkFt
	 4COEaf2sV7Y4ec0cV//JC0tHC/9aeLrIDts3c2d5XCidrH1DIlXD3bmwvFn3/IBL70pYo
	 3lrzMrta5SzoAaFM2cJNLpOiMZdu+aPPxycn1dK/Y8yDInq+xaD7vyOYYi4phFy21+HDG
	 wzTWfIoosDmadvdNDbCXncq8q2d8Lu8udMojXW/mDKR7fvx04cfbAa4Cq7bqBEZDbLtjV
	 o4U73hIn2TBrAcRGDJa+BSFg+4EclUUjLlNKW0j+ZiyjFl38fzTcm38a8sFMsdg3v4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=b8VWtkd6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=y+0ALcDW;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90492606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 17:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90492606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=b8VWtkd6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=y+0ALcDW
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id BF36D13802D7
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:26:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 26 Oct 2026 13:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793035575; x=
	1793042775; bh=gozRlQP2gdqbfsNX2AM4B2Y+PLg6RWuvQqaTDn2tvas=; b=b
	8VWtkd6ivSPvtKaIADrhl8vqZ0T7gVGFJChcXopg/CW0OT0MZK6KUzDk1DUInA3A
	DQXd7M/ANUBd3ZGolmlHwqbsN2t/n007uoNRPupxYUYsf2lGZ05faE0Z3xgp+iHP
	HNyJ3XTI7DVt2nt135NlJXphagsj//Ts17Z1fgZAoPDu0llimgoHavU/362eOt/x
	0fTYYihiI0pDObelXPDCdxO4Xvz4jPE8gmo1lK+V75WNMEHTG92aptK5kcxgiijd
	lqYcZgDn77WVHVeoFDrLFs6TEYS0Hrt0pEVVsHOsI0DBjHkw1ctsgNaZwj+x41yk
	BLTHWJFls30fC5YMeCAUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793035575; x=1793042775; bh=gozRlQP2gdqbfsNX2AM4B2Y+PLg6RWuvQqa
	TDn2tvas=; b=y+0ALcDWLZbbQexG18HzxDCXYXQAj67ZHExGPDL+IMp+bC3VD6M
	9RGkovUeJzcVXxyvTEc/PNnXsjMIVtA4V+Nbw9Os77A9561EjSbyblmgaaTpurPN
	aB/nqJnyyAmDiOB+vCccGJa5uCJ6r+4FNX88+pCB7TPAH2ohsWrxnHPu2aXdVh92
	sl4TGQxUbC+pGTYa9tt3f2ZKOkKcbMi7285KQMEnndcWqzKN+LrlY0F+aY31jaIE
	jvz3wICN6CNwwlYl3Wbu+Che/AtxxVmW0Vtu379Ed8D4RYpG8dy6eNOa7BSaqs+t
	f0HftapAQoHnG8Ip0t2HWoHADZDwhokWXZw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793035575; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jVpjH4l4RhWHeyvRXU70hwwRKhYm6trHuPDKonarNYbP4VP
	ygVor2fE5+1fI1fSE3cGgx3tKXbiLExTDdGKQnAnh+cSb2LmdSLUwwzQlvX+tm7e
	YGjHtwNQr6u8qi9XIgPh8sdbrcS7Oj0eWe9giNKx0cHegrznepA8O6ouMba6Vk94
	1VYxYCzO2HE78oEaoILc7PlfYn6fWeQJYRuprTY9Q3UA5f8MuVpj6V/2loO+w0gA
	b4fQHOUGBhh3kKNP/YxRvT9UYU5H3NOE1P5Da6w16cuofqf1h+E764YWhLV0/FlC
	KiPGX1F8IxaTwvVPLT0MYxJzIA4N4FC0ERZ1P+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GufLRvjeK9T9oNyQQq/JPRD8A7tK4hGwgAEL7dOtYz4=:IGb6NM7NJpowcOS7AREsu1vwVu3cjYvnaSjEGyip5II=;
X-ME-Sender: <xms:NI3fau8C5fYRyEFdBIlwkgvsnGbKTkAjYVlXc-4TRD_AE6qcvpQCNw>
    <xme:NI3fat00BJ_tzOaPbuYE3NrPun6gIQw5uJce1lSfNDqwAyOcRo_Ln72JzJN4HxcW3
    whOpfjze-aI6n4gmmJs_74Mg25vWKgB9VkCM3ujQZCXvC1qhSCw5dA8>
X-ME-Received: <xmr:NI3fapAig9jAm91KpG7iN9M36V9w6iiYGfAlv-eYOnL9fHoY8BaycO8MUlw>
X-ME-Proxy-Cause: dmFkZTFhALYc8iJiMlQC3g5bs7hQtPkv6lAItKCPDxNXrELyHy6SwWe3pV3Af7XmlPOZjP
    +TGoPutgWE/CDwNnpX69avMckpL8UV8zdpnMdPlXKkri7okyrxzdU8T+p+iF9UHx5tvwf9
    75PBrpgk4RnZYSRHo2SZqaMsBdjNFcnEnMHBP0yK25AuDlaeYBfs/9A2LCP9q3CXEEm2Dh
    7ofMwg9geSlYFfQZ8DFQkdWXrwTAhyDer5ayPZp94JeOiWCWbBcDXCQnyH0azeXwmi2avE
    rsXZXiu6K0AydSc5T10UD80G0DXte/dNSaj9nP8KPL+lJYKrQdzkiSpt2ehaeU9npH81r/
    1/AKY5HfzGsR+NtE6hNBVXFH3G64hnQZ9RwKPe/xNtu8bHQ4XuiNnrpZI5Rcxa8r+0NLU0
    GvNra05Tp9OSU9uDAFiV/4tE37bQglwCh8hd28PMLvcigB+mXgrhVhMisbG+TQ62dJsxZs
    KsYT2BVS+gQxwLKelcDnyHj2IjigAOXAebzcxhfuBrKuHXbep04KDU8m5elSe5h980yVQD
    ZUXdForo2hfXobY6hSzY4uvgQUxvw1a5aaAAOT2vhnO1WjAwUr24Al0+BP190B8R0goZHn
    qNRNozquHcwa7iqNx6dZHBD+6JdAZczycQaU9UNuL9bgcrvMkFpGT+CpfJCg
X-ME-Proxy: <xmx:NI3famAqp1cporiiSZVpbdgbI2fRAW0qerIqgl-1I40Q4ZMr-Q-kpA>
    <xmx:NI3farTAeByf3_0qae4dpP1QDSlvFP9gJj-pbYvmmgZBZkWlf3JXiA>
    <xmx:NI3fai6vsOY5KEKqTZLXzySlqtZRqV88jRXZWr8QzSFTKr5X3dv0AA>
    <xmx:NI3fajg7YVPru30XaX8_GjeLmRRUMVhCEU1fxO_g-wFza-tL7p7oww>
    <xmx:N43faiv4vPUoWlf1qYKPSj4XEiHMscYi4G7LrCwZ9hEqiOkBTH1lWchm>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:26:11 -0400 (EDT)
Date: Mon, 26 Oct 2026 17:26:10 +0000
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
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 11/16] mm/shmem: rescan after nonuniform folio splitting
Message-ID: <at-MPTlXmfs7r5Xh@thinkstation>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-11-703206d5fa0c@kernel.org>
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
In-Reply-To: <20261026-fixes_shmem-v1-11-703206d5fa0c@kernel.org>

On Mon, Oct 26, 2026 at 10:40:44AM +0100, David Hildenbrand (Arm) wrote:
> The final scan in shmem_undo_range() restarts after a successful split
> only if the original folio is no longer large. A nonuniform split can
> leave that folio large, so the scan skips the newly created folios.
> Hole punching then leaves pages within the hole allocated even though
> they could be discarded.
> 
> For example, a fault below the hole can allocate a 2 MiB folio after
> boundary handling. Punching a 1 MiB hole at offset 64 KiB splits the
> folio successfully but leaves the original folio at order 4. The scan
> continues past all 512 pages, leaving 2 MiB allocated instead of 1 MiB.
> The hole reads as zero, but the pages and their block charges remain.
> 
> Restart when the original folio is still in the mapping after partial
> truncation, identified by checking folio->mapping. If the helper
> removed the whole folio, no rescan is needed.
> 
> Fixes: 7460b470a131f ("mm/truncate: use folio_split() in truncate operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Do we want split state after truncate_inode_partial_folio() to be
communicated more explicit? ->mapping check works, but it might not be
obvious why. Just an idea for a follow up.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
