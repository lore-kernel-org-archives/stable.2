Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793034934;
	b=VewsjKLPpgqaSUG3ittl/x9F4uCv3gv/9bA3MorL8DNe4ajKm9SYQIwv2jEaTAIiGHkB
	 MtGZB9me4jzkaKne7p2RHA6RAF2G4mgrtHqJc8EvobNvsRFznctY1pIf4XirxgSWWtOcD
	 oCtS6wAc1NqmVGxn6yYFDgEgA4TQonehCATtZf2N9x6u8kVuI2Tmvj84Qn57Ncd9sLZ9i
	 d4kUeEx5D5/r30vXutUn077IrdoIIZbz87Hd6lZEKjoyN+smQL7qZt8/tp9uudeltEbbJ
	 XL8zQC59cceN6fjsv4G51WTBeXcherpTzZkf5AkeAIx1EBrBx6EIUFAxoAZKE+/399g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034934;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WgWZTIZ7qHEcd9eqvBpm5VFp1o1TmVO9nxe8IAIt6xQ=;
	b=mAwPMwj2ywxDVR2PRyi3MsSadhAFTnBuwfbfPvl8fLlPvcye3ZYkJPwPRwP4C/cb0J35
	 RJxxnqjDhk5LdxE0ZNiZPlg4P/B0X0KVALBfTGqPqEJ1H5VLwl/rqIk5QQa1bjEHL8/ae
	 mXtdrISvwnYSU9KfSUrX0i5j/vgg6loKrSKaKpYqKydFTTBrpchIZS8qjBJT1uMsoTXX2
	 8gflngRP0IP+y5XK/nYnxGVjmNSNq9mAuyZpjeCmEiWsmV/ZGmJcLwUF0/bHu/LIj5YMn
	 Ltc65kx3tA2Io6/qMoL50i2OGxoO9gOu3PfrFxhcUlxSRG88SN6wqTtYYpKXxGtsKQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b="fZ/mmV5g";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=T2a+0L1C;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55E606A327
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 17:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F55E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=fZ/mmV5g;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=T2a+0L1C
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id A95E813802D5
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:15:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 26 Oct 2026 13:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793034932; x=
	1793042132; bh=WgWZTIZ7qHEcd9eqvBpm5VFp1o1TmVO9nxe8IAIt6xQ=; b=f
	Z/mmV5g9zLaRu5j3caYih8wYVeK7pKR2YtVumaOb7e9AEDxtWwuyOeOFmO+eXRSm
	1PSO/VFOy/+mWa9abx3T/2yAELqvdnmAeSJu4fzYNvWJTRR2Jy9srIM+XYmCKdSN
	34dn8nODhQxO4aGw97WCjkzr51iOwn3ruBlaWbfWsb19OudhJxbB5YDBf5pTNnXU
	+85Hyy13345QP8VDIx7HQEcye1Kq3tAknpXR1YgWlU1X/KWCkckpXky9L9/pqTyz
	ooN8GW80M1NG7tct3Au1Qb4j8E/mEuaXsdTCAaG59G/O7w4TwqAvgb5t+bXBUdLR
	V/bb8NEqSPXsjaQ2/6n/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793034932; x=1793042132; bh=WgWZTIZ7qHEcd9eqvBpm5VFp1o1TmVO9nxe
	8IAIt6xQ=; b=T2a+0L1CD1iecshjOU3hWu8d37blUekwLbjtDS5gZpKwM9pjLG9
	Vh5wjo2Yl1LE3RquV44L5MZlVhg7ag1UV0M73oLMBcwkzOTV1CLOD7lFHm741eds
	5JoDvLpHNfPTRMvfMpOtrtztR3jMnXJWgPZWUrmoeGxD7hBnGsMLrcEjsVQIAF53
	vto83Oo4BV8/3XsguCeiXq5ueq1ezjOFmuP1zROLHt6nCS1xsspUVr+0RPfxa0u5
	02AlJc5y2VQEx4RkptibYJOCx6zM4phKtMB08UgWHrGyWEGZ68xWXDPNiMuiIId1
	UNfzNs6wjmOLNqXYP2to8UYt7mU5mcEMQYw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793034932; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:mXUFnP9Ou8CY6EAldWOK47JAotPOJYip/hywivmCd2Keogo
	SoADiubvLgK1yjenbgyjBzdAlN04ciEeD5TXcf6kXzGvaKIXl8LyBPKjVS+RRQZ3
	bKoNyB1ki2gptZ+lF0waAkDSt6+xZCWg/B9fCqcU4CiUXCM7UATKVNz8CIAAmthn
	GKJaoJICZkLBOZDRbCj/FDD/krDwXGPt9PO1n2wpO2ZfdfkeeoJKHvlsy9gZbvXZ
	tCrNYw+DgVPmi6F70AAQeACkygVYNjme3BiF/NxztGEP5XOyTseAOUDPWN9NlW0Q
	hJQd3DtC0nrB4IghZmjIOGhhRx+XWiETP1QLZ/Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:CwTqFkX92AiYgrdq5UPorGiNimGP5HguOsZVh3B4CWU=:5B4/pBpvFw4Mf5/ZSFPGmD+cCMlqrVZFb5WHDs2mwGE=;
X-ME-Sender: <xms:s4rfag58y-RJ_XDZpFZWVrazj564_G53BdUi_PptTtpdDPSLEW2lSg>
    <xme:s4rfahChi4WKT9gRwf_v0J-xS1spZmaNKWGYOzR4IT59tRyctsE9lE_ag6xsXsNph
    RRuAOVYRa9nEt1iJnji-zjC83WAUgaHOjEbBHy7FzNNtSBNgTZwa9HH>
X-ME-Received: <xmr:s4rfakcGZqQLYXC2H57zOUOZqsixT43wyiUlZ7bmVPj2z9IMwBSTgVoP09M>
X-ME-Proxy-Cause: dmFkZTFB6PNGhMhAXmj0ZOtRvHKd56A9JXD4WvNPHaZaK2XiU5P65xov6wStY5RJjkvPKO
    XSPqLzkGO4Zo4ODwiKKxS0X6P41grxvQjvP6oiDZiTh+fpDH0yL2MunT0+fjiS+FaAqY1/
    PaJgc/5aspdPW1Mj45Bp7VVVdrPLEgSlrB+JkwItGH4qYwuHSgEwJtjBUZKOymAYKJScIB
    KoMf/Q5MRD1DE9DmWfw9Wo0qm6Ock8Jg/0ZvcH/PY8Ox+HjLKJTKKASZNlPl8RIBfaFzN+
    hv3kzzwRvjniNu6oVve34NyDlpJcCbxEX6LePZcQhFmYCUOx0RpGtkzk9m5jAP/xJV1jqB
    qmfqQgYHKFDf/konLHPaAJTbFRfxuWNuwXsBKupI59MnPZtXUnXHlo+/ycyFM1EouEFEOx
    7zcJr24zTYLLO1S6FjnCnGL33sOzapaodQgyvAUHSR+M/pjoi3r1wj6VJRM+aigFAfINZQ
    VhhPPtbohfWHOpzxaDLQmMyoBtRLSztcPzs4dLBl1kNw79rRydZoPrFc01SCGpo8oEKDNH
    wHV4Oldi896kOORnjwO8XhqyPwv4StCU+V/qewoqv2I6NmJul/pFVodwr6eWAdHuancEy4
    TgqJLAjDjyDuZTnngn7454DY/QRz+2UE3Wx2GivQVzMxTOcFQZPY0oQk91Xw
X-ME-Proxy: <xmx:s4rfakuJjJ6-h0mknCrr9JvZdH7hQUDw35nzt6NEtELk3WpJKPuJqA>
    <xmx:s4rfasNMDaq6ohN-_TuZ-en2CdiRi5XkgSxs0kvFu5pl5w_Yv2ruAw>
    <xmx:s4rfapHLmcRWRAKMDXbGPP_ApfgdpsicwQ4b7apUy01Q4IuctmCrIw>
    <xmx:s4rfal9DZ0S-IpAzW3tGo-tkqwsJYFiR6l7ih97I4dUG4PAROuBgTQ>
    <xmx:tIrfas6H2672-_gf-0iJEJOe_gcSKJw9pgPdfdJgSt2h7xlz9Ix8uzMA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:15:30 -0400 (EDT)
Date: Mon, 26 Oct 2026 17:15:29 +0000
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
Subject: Re: [PATCH 10/16] mm/shmem: discard whole new large folios on
 fallocate rollback
Message-ID: <at-Kn5yabin1E1Jw@thinkstation>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-10-703206d5fa0c@kernel.org>
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
In-Reply-To: <20261026-fixes_shmem-v1-10-703206d5fa0c@kernel.org>

On Mon, Oct 26, 2026 at 10:40:43AM +0100, David Hildenbrand (Arm) wrote:
> When undoing a failed fallocate(), shmem_undo_range() must discard each
> newly allocated folio. Its second scan instead passes large
> folios to truncate_inode_partial_folio(), which does not necessarily
> discard the entire large folio, but instead tries splitting it to
> discard only the requested range.
> 
> For example, with huge=always, a failed allocation starting at offset
> 4 KiB can leave page 0 allocated in an otherwise empty file.
> 
> Discard the whole folio when unfalloc is set. Note that we enter this
> path only for folios that are not uptodate, and can consequently be
> dropped without losing any data.
> 
> Fixes: 55ac8bbe358b ("mm/shmem: fix race in shmem_undo_range w/THP")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
