Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037196;
	b=GALF5OntKS+539HiTAj0j5BnCyi/A9aVMJouXgBTWi1mQaBRKK7GHatCP5AQnW/9fNuS
	 EgYnA80cJ2SFagWhxProXqHhvA8c+ubMKCeZpgFDK3AT0FR18/8AwR5zVNtZit9E2CNHD
	 rCHf0M8M3UPOTqWswpD7KUg10zZQYK+NXlUpfxYfV+7qFmtMkjKKkvL6YDiRRo+blZFGG
	 ILgpi9oBXtt+tIi8pNUl6Mur0wAGrzL36BIvhBdxAnj5tsIez44PNlLIsBvfPoJvnRkuJ
	 aNrGnPefsuqnVqDThNh2LjxD4vrhPgMPaaT5nDwvzXnI1ye6ES49nrHBZch4MPGXWIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037196;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KACmT1OYSdKCyCU57SCSDyT0EpPZTJC4vq2Q6TppUno=;
	b=XCNEseRNGijmqaA7qxT/REAoPN9xF9fhmFZN+uuOeskrUpoIa2CwCwiZJhod0oX74XGz
	 pTNdB0WPMOHRvKVx5lR27gIUtkSYgWZM4YdufSxQj6uPIHCrn2zNr2C/470nUy/5DnWCO
	 NklKNKOzgLgtHMh1LdtL1oxFfNTveXaqDHZQH/jlvIqdynrLmB01twl9P57GW574U+FwH
	 MRV8WcaPDtkuGYGN+EV7hpJMnupxMocPETQy8QKfmtwsupbFGqJi86trTq5+wMYAjF1mw
	 fsAzcey0wxKp/dapVXwT+9D1suziPBiLjmxHiOg3mh0ji67bqo8GaN1b5cCnL87xFrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=Jd5+JTA2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mB+sgAFt;
	arc=none smtp.remote-ip=103.168.172.136
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A955606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 17:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A955606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=Jd5+JTA2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mB+sgAFt
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id A8B9D13801D2
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:53:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 13:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793037194; x=
	1793044394; bh=KACmT1OYSdKCyCU57SCSDyT0EpPZTJC4vq2Q6TppUno=; b=J
	d5+JTA2anFbRN+nBzegXTAvu7ghYtA7aEPbLvwEE0xIqOGuA9F7c/gSv1oUUyhUZ
	nVFb87OeqlMd/ej5V1pOWWLROJR47pXdf7IkWj+LjNqdqvZwsfboZWgaGQ+yB+r+
	kbhT4Q6SYtjn/CaClOuV5ERYddnynImXnL5CYkx9EaM6v4nRgIyOxDdTEDpumGyT
	IVDrHi9JxfEhbstOpKYdts8q/olSFp1rhLTCM/bZS43lHJuoqt+R3A09GBiBws3i
	PfKgz43l55YoS309zIDia9nntfZb3b0FN0CZ/dtzcuwJaTY1JvLg2batxg8LNWSj
	PXSQx5bO2e0fA56EHCaaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793037194; x=1793044394; bh=KACmT1OYSdKCyCU57SCSDyT0EpPZTJC4vq2
	Q6TppUno=; b=mB+sgAFtkmhO4wvVqYZa6mOtpMK8TfmZ1ULJsH7qsBgqFl6bUHV
	NTrF7b/7PqofzAlUspS+OkDLgFpx1/ZnJy+eNxie0I9OjY78tO47/ekEENEmqcMR
	mP2IEE9jh1DzWLlOt68zoOTpBYyEuzu1N9RLEv193vf0yB7ka/j0XAWucu2c96DW
	2GusFOSsEO5F8wuazkJ29HaNmAwV8tXN0+48lWSimRiDppggTswICCi9XpKyQwVD
	p1a43nlS1NaL+sOgHOOwDRDgyzyPxM7mAVmCG2qUjQXJzNXCjD5Pvf0LRABET1yh
	ut6873xozx3JD1rhtCSrgiScfrgpuWhvykQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793037194; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Ga8F8/R5UnNmu2WXHXpyhA2T1U1zt1nTSgzK2moU0HMLXMe
	ly9GKF5oegWZLfbuqYUvsgOZtJA6kAkukTRw9ZQjsbbdw7qkZq8pWIEUjL2XFMak
	91L4usWF8XpTeEyXiM4fXc8aDn+RAmqDq1rJ1FFc3IVu0JOBrmcH59ethxZxoiJ4
	XIS/L58lor1IAG26ED1PisMeglfDdGgv4wrIbYH4arco5HkkDx6GwAvla9VQZCr6
	8zxm+cZaD4hzV0yhy+9OsBQEC+oKn0GBgLnoyAMEgrL/tzHeaBXsdq5gDBUTefhO
	oRUCRPCFQPLHMbSe+T5GDHYKA9YVcDiZEfmwpZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IeqHrH4qIXx+xPUlMhf7YIjv9KFxsPF2dPcCj2TGE0k=:wVd6akMHCr9G257g3NGzQjmz2P6BKorB5KPID/xSr5c=;
X-ME-Sender: <xms:iZPfaqQCidi1UPaTv9N5eLldVWZynia8Oi9eg3oyYThcBvNwqm-plQ>
    <xme:iZPfauSK6YsCZCu-Hy1qRsE8v3f7ohP6sReOFlJac_9R0zkrn-z1H5IYAP19-UW9w
    ZLovY_w9F-P_tX5zLQ9U0NrvNrb8Z9nyKAt0FqsjqLT-IgNeyvcO_4>
X-ME-Received: <xmr:iZPfauhwInFRFYstERI3dLG-GFcy4h0llenFAbbBv-P88ae11TXqtoWDkJU>
X-ME-Proxy-Cause: dmFkZTFCJC346uT6BkgpqQYR4FNPAi1RA63Z+5L1PPhx5EiCpW4UTmnFOpzGWG2lAFxYWG
    ow1NfL/UTp/Pd4DBanvkvVjQX4/GJ9QHoxX2Gnm+9O7gKo81tMOLCB6mgJceKwlnlE/6R0
    V2YJ39AyV14l8ouat82SghyoTr/S0qOn4UjCWDfZBVfbZ8H6KBl+RFmwuyJgsMdh+ieuFV
    d3YZBJi/v/7a8u8UDV+6GBpxXisMoQE/lBwP/kVhG7Ecprx03wwiSqHTSA8W8XkMGFowSD
    sBsXoX6pbh6kmOG7yuRNSEET/XSSH+CeKPAuXjog7+s9n69YFxLZ6RvMAi2C1P2qu/rztS
    Z6h7Bk6lcrSoJpk0r5tIQZ32INvXGzppWl/zUTV/+JrDHRouN5X1NkNQRS9mQX+ZMkxAQG
    yuI2KtNX+MVO1nPv/LUVzeMu1skyc8UPO67BpjOrJQB30rkhzCBlUWI8auYwoN6To/3Gr+
    PrjzqVoryOE91bbJ76HytMXjUtJpnfaGneD0WZ+6lz+q3nhG433Lqm+AEW+vJeQGxfhj9W
    DA5+frXFGSYYYRUVroTmsSKPKDRM1xeYtNcajZ/wqDmkv0snlv081E0SS2TmnCDXlTe1Lu
    hkKPdhvEzsMWhe/dY1J8rdd+7t7BNLU1RQ6t5Rhm833tvRnyF9S5YycCZQOw
X-ME-Proxy: <xmx:iZPfalJtL--z6xTOZq9C8MTzUStdVcC7q5RaJCzrXHWjffyNjIPO_A>
    <xmx:iZPfaoyIXFFInL7MgoVeCrXnbbYFlhQKDGsQGVNgBVxeaCvUxRG5Mw>
    <xmx:iZPfalH6fmBsm7jFLTPyirWAjTDIezwZASigPySIcM6gJsfbzqHn8w>
    <xmx:iZPfag5IyLv3WMATrG_ciQH9hx41q8yLQuLkZ9Bj1Wmj_sUItjiYmQ>
    <xmx:ipPfapk17ES5yDc78-yfcDVcAYf98re0iAEFDFPiQ8bUBE8OwOyq1Ja4>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:53:12 -0400 (EDT)
Date: Mon, 26 Oct 2026 17:53:11 +0000
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
Subject: Re: [PATCH 14/16] mm/shmem: fix truncate loop after boundary swapin
 failure
Message-ID: <at-TaQ7RoQj9rMCN@thinkstation>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-14-703206d5fa0c@kernel.org>
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
In-Reply-To: <20261026-fixes_shmem-v1-14-703206d5fa0c@kernel.org>

On Mon, Oct 26, 2026 at 10:40:47AM +0100, David Hildenbrand (Arm) wrote:
> If swapping in a large entry at the new EOF fails, shmem_undo_range()
> leaves the entry in place. Its final scan skips the entry, then restarts
> from the same start index and finds it again. Truncation can loop forever
> while holding i_rwsem.
> 
> Advance start past the skipped entry so that a restarted scan can finish,
> as we already do for folios that cannot be split.
> 
> Note that this does not fix the missing zeroing when boundary swapin fails,
> it merely prevents the endless loop.
> 
> Fixes: 8a1968bd997f ("mm/shmem, swap: fix race of truncate and swap entry split")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Okay, one more stop-gap:

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
