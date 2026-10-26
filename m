Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029936;
	b=ayc65IEdoFsA5fKraLUFjTVTKqwPF6VjxzlEIXLnywWQNaauOGpJukcAzp5TweHRZTky
	 d9kr9+Tfc5ghLHSY/UP0bo5aRzZMb5mserpizjuVJrrvRL+riRMebbxyvYE7aqmT6Bd20
	 3sK+F/x9wFoQ9ATK/S13EOBzeRRh9IT0civQbcjB6RCjSrOAdAzx1hFCUAvjB/zzYHahR
	 WNVLkhq3ioClAt04K7QB+2sUhnvHU1oWzDg4Q8zhTi2xrF3UmVuybgfgBgBhW1Qgu+WmG
	 ANMXlnNbp7/LiL3u/FCtUQNCnJsNH9dRrxA4NpI5E8Y02gGq59SLlmimENii0u8Fi5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029936;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=CPgBc4xaMzIFqQc4IC3B48/bd19HMe5+87bnM/Zq9yc=;
	b=QcFWyWbuEyr9mEZjHZt0r09CekERLR4wbKqZ0Fa1q3iS7X8tyMbSK2JXaqxjN53UP4lt
	 aXyVS4encD+5PBPhDq8udDgwSgBX0q4hxWI8J/Pn/PDNi37mRq+RwB2IIUkoHjx+8CPAl
	 G0TfvJe3TVaqU1DeqX+ruhd04/WBavuci7bQwwmFP715paD9chxXp4GvlaikjCNZjHtE9
	 iaFXkHpKUTu3eLcbWG9oTvzu4JV0a5cxVVAqOmRP8Ppxg1NYxEqXckR2P3xBCYFqVE6xl
	 W3v2K7lI99tgKs4r96lCiK5YGlgPZF2Dz56xVW1XC+64jBmxaUJzkl0jUr60HZb3kQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=o0BKoQCE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="Kz0s54/5";
	arc=none smtp.remote-ip=103.168.172.138
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09633606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09633606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=o0BKoQCE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Kz0s54/5
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 57F4F13801F3
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:52:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 11:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793029934; x=
	1793037134; bh=CPgBc4xaMzIFqQc4IC3B48/bd19HMe5+87bnM/Zq9yc=; b=o
	0BKoQCEo3nSrcyVCxtJP1KJxl/yw5aVebOquu+la35y5fz9jh9W0wIbsccWPZOtw
	lPv0PfFhRS36jmErd0kS3aCFrWXSr6hBe03n1budn0uiDaaykqK2f/fDwglTEM0t
	PwRTOZut60Q9SQoxlkepYalWady5fZJfrJlIjjlj/ouTkGyII3DFnbBLlyiSIgvV
	HHQgPvG5QWRfaHVffWOinWQo4RxSsggAVN06fL9rqytCyZKaVtvisskLTe6pRuZU
	qcGSazzOT/ln+dhx15bgJEhjQlIkGf0AuMAgwSAlVOy34OCMk1Wg6x87uYKnqG5c
	x7vr6szoyhJTqwIVnvqvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793029934; x=1793037134; bh=CPgBc4xaMzIFqQc4IC3B48/bd19HMe5+87b
	nM/Zq9yc=; b=Kz0s54/5iJjqL/Hh3p2OtVE9uLiC6AN79waFcNg2he6mabZvfnm
	n0XWxAimat+vJBiSn8Jmd3iLewQGdKw47wOJnPMQDOdSKl/xZ15jrFiCga3kHtfL
	M6gAB6obdV0GQEymXG0DOWwQhKGTeNNAuPSqWN78l1t4UbPSAIJWNnwkiJJQ4YTr
	tIBJTJTkj9DwvnS19J2+X0k9gt3dbElymBO/yct7zQlUPVlLMAo706mTvH2cOUwO
	jmuESzMcfXZ1yXG1biavNgJK7DU4hfnaioqEiCZ1ifmblUbrCkMy3YXTK/JkGVlH
	erWJcKTsyKCkg2+QATFWk/r4KG4nH6Soaww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793029934; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:b8cam9gTOfKf+eRSradQLadE69Z+ZRJP9ES3DdMuTXL2x7O
	zjK+TJNf2WlxhlCE6tURZ2y3pOfNvgaSFbaQ8xdC5VvVcMmS5utmdsCQxGEa+Lh+
	CoHhz9VIx9DeeHrdPkwONxbi/jLSkec3C92GfXGt6OzNGrkccpf4PS3/j0qjFzIy
	s1Duv6cZ0eV6gW6Z/ngCzwx0cJKqwYnHX/7XHE4HKqKdxhYu0/EGTiyXjctO7GHo
	+WEMlcatWSNRKz4YQ3Zb6oeESrDWhBugD50nKDw8ct4xRpPjoriGEvOhY2Vv6axR
	4425t4ekZdMSpV69AWRgeuhTzr+8zb3lzwvItCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:TSptQC+uPMW58EhXC2TW+E5AzwHwIj0iAaNeMtqyI1A=:5YQRYL/pXslXA49efxXcFJfhlbdrgkaeNfpXN03LNGc=;
X-ME-Sender: <xms:K3ffahXllY81gQANBHMWb7ApPzS4XFdgRPGgmQsQBZqVrOI-rfCLvA>
    <xme:K3ffaoS4f-N2KBXy0sO2JKuIUYhwMZ9jSMURIQtPmKJaFiuHdBHnUX2StJGa_IL5L
    8A0YepPvhed_5e-_CoeEJI8vqWAoNyRTn1Ki4XBNBlLzi4HYd5E7io>
X-ME-Received: <xmr:K3ffann2o7DU9q1N8a1-EiSkbdymdeOHlv95OV7smwUBwfgkxPDQN5Osb3Y>
X-ME-Proxy-Cause: dmFkZTEkSluo7FEz7n1qY7QYOfbn0owFYeZY5oOq3jGyfhvPnNpVEknLvAeGR1+iGM3syA
    9KIyaf94wEd0nEJHg2+khnrAfvqxgujFfy94I/ENHCdc0906l3qTkFhAemCDZZtRoxQBpm
    ISOWhrDqbIIdQD/XOE0Efd3BZFKX5jwo5O5BVQet0MVPWPwjx/89wQFabKcqsb87E2zGhQ
    AhHs9zIIZ+GdDFr2ga3NpUuXWeHL9qnhJdz8bu55mbEWD3a9HPXRp+Z1vqFAzmuJVpG86o
    jDvHzSpOLflmtoY1U6+79dpdUBqHq75y5KpZ9OM97P7mgyK/gICBKBi13o7qY++ND5OLLr
    YZTLwIugW9gTdbWrpRzW1DUeaLESRpM8rozbGIb7htDEohjfWM6G0235tRBvr5Lq4T46p6
    Hy1JiSS0d+flJ3EyLB1tHFF6xqKs4XcGDrliXW8nyDab27YUhPkoMSrRX0Q28XOlGmGwKk
    qhM8mFIJrU5PxpeECU37qyJkils1hwny+zsf1IpG52mzKP1ds/hxmicboQ7qzWJxQ8S3+0
    Pv4PtDi3sLD+barIJSVFqqNfykQ7mAowqBqY6pOX02pWMz74t/xkVx+6Bx4Ok7znZcyAV+
    GJ2hnpW15TnIYQHZYc3bCOWkqiZotgTDwAtJEqKb1lbgbzxXsZhL1SoYbGuA
X-ME-Proxy: <xmx:K3ffak_F0cERTHmcQXmxXAI7UweRjo5_rxdsq5rs3fPxmQdpTENHJQ>
    <xmx:LHffavWFQzi_x4edbTi0is-2e57xE3DOZA6BYkc4e8CjvbhJ8LLUBA>
    <xmx:LHffauT4MRVbf9U50mVFfA6bl6K-ealI_VMKfGYJUT-sh9uJVp8T6w>
    <xmx:LHffav0lwvfFc7HeGCdTdI6O7GaLWe95hMP8ont6HY_mJQ1JZHKKfw>
    <xmx:LnffaozOOq9MK8xz-qfmkdgz7WlkK1yxG60yntUXhVC7MpPc-gw5b-C0>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 11:52:10 -0400 (EDT)
Date: Mon, 26 Oct 2026 15:52:09 +0000
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
Subject: Re: [PATCH 04/16] mm/shmem: honour F_SEAL_EXEC when an ACL is set
Message-ID: <at93HVbtV34eDnOM@thinkstation>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-4-703206d5fa0c@kernel.org>
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
In-Reply-To: <20261026-fixes_shmem-v1-4-703206d5fa0c@kernel.org>

On Mon, Oct 26, 2026 at 10:40:37AM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> The owner of a memfd sealed with F_SEAL_EXEC can still change its
> execute bits by setting a POSIX access ACL. With CONFIG_TMPFS_POSIX_ACL,
> this lets an unprivileged owner make a non-executable memfd executable,
> bypassing vm.memfd_noexec=2.
> 
> simple_set_acl() updates i_mode directly, bypassing the seal check in
> shmem_setattr(). Add shmem_set_acl() to check the resulting mode. Share
> the F_SEAL_EXEC check with shmem_setattr() using memfd_check_seals_mode()
> in include/linux/memfd.h.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: use common helper; simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
