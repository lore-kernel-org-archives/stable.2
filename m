Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312713;
	b=Z8YGWNlQbWvRtA9Vo1LYvdef1AaT9L1sKmD/b5cEagqW0kfWN5jqyGsJGpbbqqraf7+b
	 hpfNSd2N05Zi6ZQx2XSA6w2mgb1wZJlqTZVhMEBAKPCfon9mUGTlKnx39eoIRVr7RVKA3
	 j2hwuhjD0Ey0+auZ1b5u7y214I7f8/fIIY0/XiAUAg8CWmywB9mU1XOIVA+tQekSm3W9J
	 0Z2DAv5OOgSOYWxl/moT3Oc5UPhwQ99L2ZGuclPII7uFGBuWGWEdzsr9DS51snwVtCNYn
	 nNUhmuPeEHAnDxM4mkBwT9b7CTC5FXc68xGpeOwuh9WSdzt+4DPwrh6R78HksbKOrOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312713;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=J48t8mCWZ0Ly4qztcbrxqVse8BQ1Um1Gqa5tCIqH990=;
	b=s6EVPh5qB8/3k7aZd0l2reH4jv4QZAO8gvSf7S1nOC6u9BtMW78J+YRiO0FzmOZwk3eI
	 +lfSSlKxoQMYHHPHPNFTA9E7nWA+v3hTPhuNemezwlPcu1aZjda144Y1vJk5a+L55fjg3
	 cD5a3cDNSiZ5jpBE3UTGnUAxkLlDFcc0Hp7/52cpqaUd5Mm9g8IcaWg5u0Vfj8SH+4+uP
	 MUEzMZ2euYcNx8Cp7sydi9YYTYDTXEMoFffYVxyEF8esBV1hGprEQureFVJft3kQYwznh
	 ErXqMGLVPO04KRXjv/KPdJ91rZS1B+QsDLG98XoLkuMZDMAPlRmjE2rKRQzFq3b/Jkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hiU/JVKX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48802606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hiU/JVKX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57CF1F008A2;
	Tue, 10 Nov 2026 12:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312712;
	bh=J48t8mCWZ0Ly4qztcbrxqVse8BQ1Um1Gqa5tCIqH990=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hiU/JVKXRON4pPovCVkTdBfU1F2AHh9WpLK0LoUtYTmH7G0CHrn3ufdzdom+ZHOVp
	 YVgzhj4DKzw1QO9x55hFRDlaZYsLi0MaNLt5T5GQoNr2qHFiUdfw/r37A/h8Syhjn3
	 8MzYEn32y2TqXGgmkFd60WECTLz5xOAeqdBj8hnKLAZ+9zvB3tgAgY7NxIiqjKTp9G
	 VE2SFe4I3U5bEluW0192FPPhbPrEob8C0ReK+5xwEGaWH+/XwDvUt63aQfbo05yc4o
	 +RYtPr3ZUEkYpBBHf1cwA/SEfbhb+TzzwQKizsYlydqULYUI+px4PQaRVOWSlNmXer
	 OeC2hQA7WZZkQ==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8C4B5198003A;
	Tue, 10 Nov 2026 07:11:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 10 Nov 2026 07:11:49 -0500
X-ME-Sender: <xms:Agrzahiqa8v-QwjQZ1V0sYnNjf84xOyrIfDXKR5HXK17hMm4ssA6uQ>
    <xme:AgrzajbzSEySfd5gqImCoqeP89oiMoXApwoUcrwYKKnvsakF22Ov3cfpJFlnGkkgH
    y-L5UwbZgSDsgTap3pqbA5TaixPanmtds5IiBDGM2cVzwPFDTzW2hDA>
X-ME-Received: <xmr:AgrzatEGPOTae-LdB3nuocIP7KX4gp_ETIIHD8XODaM8wzi-SZNRVrVwQBk>
X-ME-Proxy-Cause: dmFkZTGefbfqVFzQoxpaOb35aOaJJYZFYQvPzGDPo0Iw8/s+5tsv/j0Eaozcf4zKLCSuJk
    EX6o3FPlxI7euVfy5GZ4yBQeNhray/Eagm6hy/bLiFn43dNlHuG6U9X5dqkW5TdvSDl32E
    MCiAOECHe557g5jlRnWXG30eabfT2U2GrXuAzLGAvzjETk7rT6T7fRbCYmvUsujMizr16N
    71b/VfcY866hCn1NdGBDFB4a8VT++nHkgz2epE5PTIzhAMLSn/jhJLyr1q08Hn0UXkqfDU
    5jaBjS4I9mhYqRmUMVG2ZlOyeiZTITO2/kszXi+dWRQZvoFzIn/DouFW5VGKjOJRYrpqRE
    oWLEZdmA0aiXFnjCrxF4Uk38siGVsWyDPDkHmXGAFAPjxUzKmVw7g9/gAo+OOYyKNiKeY7
    VzLvd+Er+ab5ilp3oMLATULyKQyFyPdkSUC0fJy5L6Jhgvo6sJ68OvTbdbRnP2z0UtH8Sy
    5n05ryyntrgR8Del3oW+GfLhr4P+CHNI5EzBbbxFth4QRTwBUjPnSIcQqFtG7GSnZNPkcN
    zxnlOAclNPbLyRXLZP8jqH5iCsBssbIAowSvIJOPmV5sBNlX4uH7jJs7XZ+GK1d/3M1yd4
    I8IfqkZu8ig+R1AgkNss5B6cYCw2eOEB6vc/TtNu7oNJNuVfHPEOkerf9p7A
X-ME-Proxy: <xmx:Agrzap8vJURsk-mWwx-DcTlY8wrrblhsN5nlb7ub1G7K0w_qP7jaUQ>
    <xmx:AgrzaqVsznGBF6lZ028fBMj7nwciUpbKsIsk2UfW6tLb1j9g0bFcGg>
    <xmx:AgrzatblvMyTw4Mp_KARp4RHMOerEHvvkUDNo1FHHtLn1M5TrDLHIA>
    <xmx:AgrzanW2wTUQAxSkONh08bRNUV47M_MSyDdU3gGX-12nyKjmTTQNgg>
    <xmx:AgrzakKZRa9Bp_p4FlkMhZ-ZpHI_wqeki4OBfyXLLvvIDVc3f-lJQ7Oq>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 07:11:45 -0500 (EST)
Date: Tue, 10 Nov 2026 12:11:44 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, muchun.song@linux.dev, 
	osalvador@suse.de, peterz@infradead.org, fvdl@google.com, willy@infradead.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/hugetlb_vmemmap: map the shared tail
 page writable" failed to apply to 6.18-stable tree
Message-ID: <avMJ1sVDviavKjQu@thinkstation>
References: <20261109200434-failed-6.18-0120a603afad@kernel.org>
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
In-Reply-To: <20261109200434-failed-6.18-0120a603afad@kernel.org>

On Mon, Nov 09, 2026 at 08:04:34PM -0500, Sasha Levin wrote:
> The patch below does not apply to the 6.18-stable tree.

It is not needed for 6.18. The bug came with 32c440d67e6c ("mm: drop
fake head checks"), which 6.18 does not have.

But 6.18.y has its sibling, 01b1d0ffb6f7 ("hugetlb: remove
VMEMMAP_SYNCHRONIZE_RCU"), picked up in 6.18.51 as a Stable-dep-of
6e25c6a9c7ef ("mm/hugetlb_vmemmap: fix
__hugetlb_vmemmap_optimize_folios()"). It is only correct once fake
heads are gone. 6.18 still has them, and page_ref_add_unless() still
relies on the synchronize_rcu() it removed, see bd225530a4c7
("mm/hugetlb_vmemmap: fix race with speculative PFN walkers").

So the race bd225530a4c7 fixed is back in 6.18.y: compaction takes a
speculative reference on a PFN, passes page_count_writable() before HVO
remaps the tail vmemmap read-only, does its cmpxchg after the remap and
oopses.

Please revert dba93b8cceb0 from 6.18.y. It reverts cleanly, and
6e25c6a9c7ef applies to 6.18 without it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
