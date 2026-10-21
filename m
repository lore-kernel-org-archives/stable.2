Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575228;
	b=FCQzbA3OyTUlO/X4B9u2NDkOe63ei1bxJxhx0UU3bU+x+VBYyY6NhTbRn+tvW8BJtHFo
	 JsobnU0Bxo3jm9HB4c5jaJJODXb6xWm7KBmq+O87mM3khSsLB7O2IHrnkgYYUjC7FRtPK
	 AbzHJB0j4NtB5NzX8WsDQV8x5W7pK9xXwBpd+Ag9Rgyi4iy1ueaJp2w//a0k9IABM2e7S
	 hTKbua6Bx0Z+LUH+Lqya/6eJe1FFCyhXoc5xbyAGMVlssYpafJY97mn73ZgGJTkkpSF2a
	 Sw4WvwqJs/XT2eVc8Tw6UIs8ux1nEwyy64aauxI/aJc51CpMghGdZlI26FVVMCrxMnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575228;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=tYJqufCjo1bLqz+aK1iPVMBINWSRhQ37F570JEgy46s=;
	b=3ujP5FR7FC6k05BhQRLHgH79c/MpeHaevchm/7qVUekcC0jik3PtPgJf/1VSZGWfJcMV
	 m0A6QVyocjzh/eTDX3S0tkTG5NSCuan9ytDgwYuVHFIbSYeXZ5GD7NKYlyIlTxUz5vnB6
	 vi99FL61QraK5oHuT5dDoNylRPFKvZwhhvs61N0BljL0KcKTg0LNgBjbG8tpM3VgFvWfc
	 2ZbRi1wn85srGJw4ZvaS7XluX7D36nrtFe7mFUcysRYXcbuoHZuCgb1Jmsl16cs4oAYcj
	 D4WPjqYMXEYQlWxEze4hRm/0pH/R5kyVflkPNsu+8T4VwjJGmmYhZjldeRjajFPDkBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EYe94fM1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B535606A326
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EYe94fM1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642031F000D1;
	Wed, 21 Oct 2026 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792575228;
	bh=tYJqufCjo1bLqz+aK1iPVMBINWSRhQ37F570JEgy46s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EYe94fM10VflfuiWyh0fRtTXRF2etpia2o7owGtaW17OQngPYqf1FFbWQ4TdxFWaX
	 kN58+4Oa0liAqIjhZdUaZkOXeta4+s/9qKfZ63oTaElOeMcWMGeh6kh0K/q+1C7Rx+
	 23SiepofIqcdKEsQHPWFWpRLt0agroNAM/Skvm+zJcudIM31ZVyLkskIR2iEAC/ife
	 N//ZWi1taX/maHkbkqoDlrgpBg8h0WF1QwpeBt6zQ7X2MfiUjwKYC1s3N7bHWuZTKk
	 7cE6pd7Bqct88tSYWJcnea00bJNlxdxR7g1Be1Dj6nqiOPYIyeh85q3KAgY/YY0pSS
	 nEEySMChLuu1Q==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 788A5198003A;
	Wed, 21 Oct 2026 05:33:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 21 Oct 2026 05:33:46 -0400
X-ME-Sender: <xms:9obYaohboYwN-Oyv_9N85Kp-o0wdjPGLYi9U4Jweczwc1LELqDzlsg>
    <xme:9obYaqsL3QdoxJkBeG6XFyL3PEzUY94bWbp4Gpd0xmQ8yNumUr0spy20mE6rqHU5D
    CaSmdSwmV2uU5iL8Z2nh0ioNc4B61i49ddYwhMUfEKodpbjdF3zmRKr>
X-ME-Received: <xmr:9obYavbanvw097VxBxIs0S__UPCi9uhLpbUPxgBBgW2JjK7WULFQT-PkxCI>
X-ME-Proxy-Cause: dmFkZTELFEvu1GI3tSCWgCF102QEycz4DGBObmJl25RALQ3Cxk5ofZC3Gvf8s8pkKw8wfz
    MIDDiGFmvC5la4lnge1OoLPCYhSCbSER0N9ED4GpBoKpGz7WEndh4bv7BOgeiOvwUVRCR/
    t+t6Bbg5wofZxXfbuPq+27rXWuoMcBAKqnai+8s/ItcqZLefslz5xWPGlFZXk9w59ddRfS
    lfla69TNWQ8VJYTH+j9csyZ0v2bEnyxjaqHX/CyzEBaJaC2HJfTOTkjb4+agGeZXo5NIVl
    TIN6DNXr9+W/INW0ot2rVh3w3hzXZV2mOfffcl2i7Tr7XmV+OjdpS774umu35PGGHrbZrF
    f4LwHHV/pKAcpG1KnWk3qLd7hqAx4vW75ZaXvZxVEBRufae1pBEOqAaSZgy2wbxGORAhS+
    X1PisJTloFMAcI7O9VKA6/t1XFAG6lwYxSPEX5nNO8/+GlK3YSYDey4u2N4AsaYyocknWW
    yILBQAjv5VcxIUBFet4ZgztQJS4vqcYs2jEsgXvxUKoCtQuCz2iJc5A2tQPwqUhEdl64o/
    0T/bGgLxVs6savQTGo6exNpRdRYHMBOQC7Z96jH53GoGZo1Ap6aUhj8Z7HjVAW8EJe528U
    hQJ3cUj7LN/oY3crn+ERq9HfcQ06H/Bg8lhmGGeFBENRa7ZWccPKlM6QKLqA
X-ME-Proxy: <xmx:9obYahVdJYdFMpM6Y-l81MVaMHtBXOMCEgdlryQyenvztAo2tZjbGg>
    <xmx:9obYaqLUrX4KnopubSD9CBagf4buRpH7l4LAiqSzp6KNHrLApBJQEg>
    <xmx:9obYake5XjujuGVgvp3pwHdY2Mu3jYbbQr3hLKlWWJPtfkpXyy0ZHQ>
    <xmx:9obYapYKEt7BVNoigejcPFVE1CX39IS8AeNMhJJJ2G6N-URof92d2w>
    <xmx:94bYasVbphJ8-7lIuQ7cRPykn1m_tE8OKmgcEDjojqMY2NsWAww3TIbQ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 05:33:42 -0400 (EDT)
Date: Wed, 21 Oct 2026 10:33:41 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Harry Yoo <harry@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <atiCG2iPrHwDznSZ@thinkstation>
References: <20261009125503.126202-1-kas@kernel.org>
 <15a9e03e-c748-4e51-b8cc-583a3610c897@kernel.org>
 <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>
 <as5q14OsbK2CmOrh@thinkstation>
 <20261014202936.GC371161@cmpxchg.org>
 <78238103-3a7f-432c-b1df-bd14d7cf4bb1@kernel.org>
 <atDMN5MoGrwJNpAj@thinkstation>
 <4aa14b41-9b89-494c-8825-55fffd5a541c@arm.com>
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
In-Reply-To: <4aa14b41-9b89-494c-8825-55fffd5a541c@arm.com>

On Mon, Oct 19, 2026 at 12:28:40PM +0530, Dev Jain wrote:
> 
> 
> On 15/10/26 6:25 pm, Kiryl Shutsemau wrote:
> > On Thu, Oct 15, 2026 at 09:16:36AM +0200, Vlastimil Babka (SUSE) wrote:
> >>> And agree 7.4-rc1 with CC stable is fine. Sadly, not sure if anyone
> >>> but Meta is using the feature right now.
> >>
> >> I thought it was there for a long time but it was only added in 2025 :) At
> >> least the enterprise world is slow to adopt things, AFAICS.
> > 
> > I was thinking to propose a patch after merge window to make defrag_mode
> > default. Do you think it is too early? I don't think it is ever going
> > to be truly stabilized without wider exposure.
> 
> AFAIU defrag mode is not going to improve mTHP allocation success.
> 
> I ran a synthetic benchmark faulting in lots of 64k mTHP with swap enabled,
> defrag mode caused me to enter a warn_alloc (and 8 times more compact_stalls),
> which didn't happen without defrag.

Could you share the benchmark? I would like to play with it.

Which THP defrag setting, and was the range MADV_HUGEPAGE?

With the default "madvise" and no MADV_HUGEPAGE, a 64k fault cannot
reclaim and does not wake kswapd.

How is your system setup?

> So perhaps bundle the default with pageblock_order eagerness etc.

What do you mean by pageblock_order eagerness?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
