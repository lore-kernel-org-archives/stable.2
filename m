Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032217;
	b=gHjWQQyxA/gZ0exuxVmqWSC15TTFDU2xVk06v0hrLbSsBaalYvGxSB6Adzhzu1MN8Wfn
	 F6VpO3VmAPaz8YkxfVbNs1Hhbt8Q2c/b1rNCzNf26a8JVgl18nnuYcH5is71sfWYEINRW
	 /o4w+6XO35/C7QnyQGuLePZ1S+WZjPmVb8RSKpn6HNJ/S21k1Iikk0JQOFfwuo/jovmb4
	 GH1oeEOwDa7x54UpR4b9zaWdnqP6BSBXM0QAy4+f73Yfsv0Z5pyM+kwvZc+zCF+aiIZqp
	 S8tT+WwM6LNbEeDcGhYugMlebwJzDZLpMfNPQYnDYH79OCe1jlvbHgHMOp30/XGvaJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032217;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qkW8hTzvtjVugfe3/cd+IeBxoEhuYAvDS56/L0h6ujQ=;
	b=cV56sIcXsFzR79YOvx1wytHumq3O9vxOLr/o7sTCQNIjp+z07CSKmCjMcXGf1tFYsbgx
	 vxzJbZ+q29hbEdHa0BEO/W3Vm1w5oVIL7dL2alMCJ7Bx73UtFbsXA5U8OK6/LdyD/wy00
	 xWRbaTtzvsESmP9ZKAf6qC5PLLpy2D+1IT7A+FzTxpXnW5aN91IYjGvZZr0wgP6HZFh3I
	 s9bCFe4scNETvpp2pH9IM0DFqXEKsWWo4cGcVZpL8MS7gV/AuC9EbH44cDz1RpOupObBn
	 Zj02kAUy58CBz6IXzlgIzOmUHn/Gvu2QPURYe0BlYQtnaI2VjrCP2pe9VNerSH1XzDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=iTA75d6l;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=X3xxhdlR;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082160A262E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3082160A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=iTA75d6l;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=X3xxhdlR
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 75F7813802B0
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:30:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 26 Oct 2026 12:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793032215; x=
	1793039415; bh=qkW8hTzvtjVugfe3/cd+IeBxoEhuYAvDS56/L0h6ujQ=; b=i
	TA75d6llE/xcq40kiQHScyFhWzb6jHXmASv7BIV7WU5uKGLlXJjXXS9HpwoVuGFb
	/K6tVwJ3BVVvQSSSEjSE1MJBHASEGZlkEWaTUXazbh4lxcVDEIm68C8IO9+FzQx+
	5kAgmJdLPtqusbVOZLlxf2pPyUAf54p/uX+YMBulB2ohMLgQfKMMHoRTJXxsWFSE
	moTnXBLhJMzbZI6eC2KfS7DA0p9pcL1LZ0ktQgarsgKl+upAnNJ2wz6QzADl52KR
	fuTolfSbHIXIYJJLpQCjgmfj/RXcF/4vC1ElP1MXM4fyJ6SFOGXBL0Opt0bAbUeX
	s9LuUf3JX7+EJuLqGBR9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793032215; x=1793039415; bh=qkW8hTzvtjVugfe3/cd+IeBxoEhuYAvDS56
	/L0h6ujQ=; b=X3xxhdlR2n4MJYClXgFifMkH38vNiCxLt17x22NP62fcWsw9jty
	FDPj+Y2LTzf9yEOu0g01xcZynWXFVHBaRDL/BgMZgPABu3ChVjg7V7ti6QhM0NUm
	rzLhZLE6KrPX+aon4+KRsm7b4d4LQMdnh5hE6uGWNUe2JBjIcrIsMeTV6NorS3FK
	3IMhezpxWCr9a7p99ejrSCR9CvbA8Zde1oztqxSAe3Vg4Er4Lc7VZ+JSd7lPDv9j
	Ebtr+gHnoBaVYOVVSEXF0s+Z4OdNiBEY9cHqwas++9h8JrDuAUnRUZEXZZhey0Ed
	2JS07uo9aPY8VJ16eAcMBrnRLwFwk8z4JiA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793032215; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Dj2t3Q2p0d8ng8GmjHG+fQDS+MXyea3IPARS4COrkKcSESO
	gUtZC/TDOcPgyIZBneoLDiMEslNHZ3ynZziIRKGW6QETLN6K6R0eCgHySpRunb7D
	jKu77WG9gBfTtK/VbArB8vIKZCUX8Zyfv5JfGbGyHtEkiHyg6OvCLn0XQpa9hY7e
	Nu+L/CvLVBetBMxDcuLcoGFB6aBW77yNBQVH6qK8XxW3NTK5blI9Fe5HY3Jsn+RU
	jRV3/DVSym4ul+Lq2Uc5heRKd08zYnc1LaIbDiO3/WCLm9uZ02624qjXa/dM2hNi
	eop9mRKPB8QgqkH5gKmYkHqMojiaWqNketrKiMA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GakGN8qDwxnLhCAG78QpYNYCR7V4xlLXBcr1KHPT+UQ=:7lCRhhNYSHJPCDvJwYOj2cow038OFhaYSoUQhwE9Z9Y=;
X-ME-Sender: <xms:FYDfanvXkyEea80OS4g-HMDR8dV821HiTsjTez5EuF_BI47RnNZY5Q>
    <xme:FYDfavKRbx5EE_a04UWBuZGwZLlWfy-y9hHZCjeDBnFwFninJRiZ0BWMNmcaJRLiL
    -5m4cP5YW4-Cu8LOVxMUbWR7i9l2kMWjqQYrPzwvmqIZET2O-pNmBxT>
X-ME-Received: <xmr:FYDfak9ehBsvEqCtj0jPaG4nt5jKdVOVWMXN_UfqyGBbqFGgbYSGKNiyCnk>
X-ME-Proxy-Cause: dmFkZTEetMPf/XdcfRL7ShlxEnQmCfbKvikd/TPBFNP27ZTcZmgT31EhfOi/lE0FelkafX
    4nAi2WExLdLEStuSv6OzLxr1FeJJRsbSxrLe7wa8dc34xBQrx7cAOMxFzRoVJFk5Qsh0uO
    3vA/zrTAMkfwR+33ShcBrevmbmbjCEJ5M4+t13BlrItdpaGS7h89mEqhdf4Vcthfjvl7fZ
    JY1jeYR5Jqzd58wPYA24e3+QB0qz3L5DZAkHU0wuuDD7O+cma61OgrhdFnkOuGNYMTr5Kb
    tcNoMIjF/JZW/GzBtIF9JLJpYt8JL219hOcQpiwgZcI9qmb8mVBt6kN5ZF3aEOY3+qh7q3
    wpB1e/JQVuYv0tdMiJ3nFzQrng+lseyyYUyexcRbehvfGHuE8y2dx/51AJTh+smEFcOY+/
    A3BRHec7M8PHYUKLlB1Bw86mg3OeAhGHkjYNicppnIiv686lXB3QAVGNgdTizQUiG9b5Do
    QbY7tAjLfKvL/B3IDStcqXEGFwYsCjPGtwMJg9XN/0VVcDYhu/RSTXxYndsDsa6fPi6CNv
    sh/cPQOJxnKbX8eWveAqPNOoxrOWOYWiTvvSATYL2Eg2R069itIuZ9pobYunI+1Yw/Ltw9
    mrM+mWqaoNr+FulMEPY7Jx6sBUcPTJPkDpn8jLB3xCTHIAe0Yfo35SVaeHog
X-ME-Proxy: <xmx:FYDfam0_8C3KpamzyIszXfz62AIHNa4-AAfeO3NWAEkOrnzal_D8dQ>
    <xmx:FYDfart4nDqBnUyuI_o-QlRwuryuUB60YNDQaM-yWWha8c-dX3lTyA>
    <xmx:FYDfajI7t4H83H8SrGihVtcjFTioX-N37VL8y-xmdKip-NQ2LPcnsw>
    <xmx:FYDfajN1-alR5Gax8cgiaF_zd8UfzW0J7-4haFw2jlImezufspCG_g>
    <xmx:F4DfagqFcBwbRuQ9lEWjIScZKMJjdfBmNxHH_flaVixXjJtm609yB2Ma>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 12:30:11 -0400 (EDT)
Date: Mon, 26 Oct 2026 16:30:10 +0000
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
Subject: Re: [PATCH 07/16] mm/shmem: avoid moving the truncation start
 backwards
Message-ID: <at9_2qIA1Lqdhuxe@thinkstation>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-7-703206d5fa0c@kernel.org>
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
In-Reply-To: <20261026-fixes_shmem-v1-7-703206d5fa0c@kernel.org>

On Mon, Oct 26, 2026 at 10:40:40AM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A nonuniform folio split can fail with -ENOMEM after splitting off some
> smaller folios. shmem_undo_range() then sets start to the end of the
> original folio, which may now lie before the truncation boundary.
> 
> The final scan can consequently discard data below the new EOF, or
> keep retrying a large folio whose split point lies outside it.
> 
> Keep start at least at its original value when skipping a folio after
> a failed split. The part in the truncated range has already been zeroed.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 7460b470a131f ("mm/truncate: use folio_split() in truncate operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: split fixes, simplify descriptions, adjust comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
