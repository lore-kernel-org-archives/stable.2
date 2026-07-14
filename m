Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A453BCD29;
	Tue, 14 Jul 2026 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047236; cv=none; b=LFn35ze7qmsuAs1/k9iBmWH7XbFnzFcKalZSYL31E8CItTuw34cGwIZa6iX5+G9JJJJSlntqkjP40e5EtbadXZMr28ePzmb0J1bhhy5qDq+0xdUVfJBDxhLxcmA5l1SSxLnpEtD3WHi5i/YCAnOk+1lq7sdfMZHcz+kSyvUyN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047236; c=relaxed/simple;
	bh=aw1YORKWBrQIwXLHxtSUGBD3rIJllH58KTEXf81yC9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsNdq9N/iu5CsAhckkIZ3G25MOG1vzaUcF2MbzgfCQRra3bZfyw3jnBo4le29I6iZPdOpUBQJFEsr5fGajSuvEaQBmrohx/OPe7G2Av3av6gqZPATiPhEKqoWbdR5MHGAgU3OcXrUPSVevZNwMGnyh7x9e3zVMmUEH15Do4lxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=zZdw/Zwy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mquybT60; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="zZdw/Zwy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mquybT60"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E71D7A01C4;
	Tue, 14 Jul 2026 12:40:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 12:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1784047232; x=
	1784133632; bh=zOFwnYn8fKwb2zNmcy6xu4xuyuD89fwUpbMgojxdUPE=; b=z
	Zdw/Zwyb81IxsqSfNS/raBGeuan1HzOQYWrNFbkXtZWmrGnFrHmwhqDveaZMfmxa
	Upjrr96mJda9sxuSQlC0XwMD3+dodrQIofGl7Ftxh5/PVKgucEA50e2/XAWxoH7E
	scd89ps49a0zDXfA2O3ddEu08apFSBxwA4E2uIqpGF4ZyXHp8vN6QgOwcZDUFdWE
	W01jTbMi3FjN0HiZ/8YGvN2jV882DY6z9ACQ2xwKSMhpX2lRglxuBWFpQeiYHBxD
	ixqNwxCwAHE6mrM5gUy/nUdqOLWlqneYhqs/f9Alba6ripl07oC8xSi1JvHNEsUh
	JmazU6KNQRAjeo++ovyeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784047232; x=1784133632; bh=zOFwnYn8fKwb2zNmcy6xu4xuyuD89fwUpbM
	gojxdUPE=; b=mquybT60523LAiJ2lXKXHpZMf++q3tFZxxH0PpCZJ+L2egIWwRJ
	xHr56f1D/2eLxpNP5x6wxqf6Xksgqqiw2GoixnaI+bJWTOFcNAKFMO+E3feYMJw8
	ydIprwdrSDyh6CoxBQ/rCQvEA+ojyjD5+YJvBjqkBRR3F0Y/ObLjYsjDsnMbNgqX
	0VuAtpJk9eALBauGIrRIRDJHA+AjgLBiExL2eTFFhkT58G0pUt/iTeRfQ6xkymGe
	eRK57WPYp2Jof0KA1cGr4BUHJliBODEYpBepT2M6YNqK+hQeZ9PW2OvHcr4Z8nUr
	EFq8sUpfAzDr8SutMP8wevnrJsYDMmRv1eA==
X-ME-Sender: <xms:fmZWaq5D-KsdSDYOKB1hwgrXn9KpwKA3sKtZ3OaYjMTlZ76SGDiggg>
    <xme:fmZWagpPUCxO367GuUOsYJ1tbLutPRT1ejqOSY4nv7IFLyntKom92p5-4anvVNzp9
    YYMfA7oW2FflEQKDlz_4eZpDSWLQKay_Opu5H8q1JvkZQyT3MkT_CM>
X-ME-Received: <xmr:fmZWapBtjlZpF7-AkzT5080VuSIE_r2onpwmP6URLtrWcptWwhedWuPe7KgtZw>
X-ME-Proxy-Cause: dmFkZTFSadJpVIVVrErQQ5w2CnbepoBgy44z029bkLXtVdKgSSNPIZMzKcIe9uqZn4Tbaq
    zcj6CdDtshQXjIieWXYkkTfUGYylzBJqUB2hRsg8qh/r/r9vzfNUv5SVdDY0Ft84tTZRyx
    +mY1ZeuZa7qeYQsG5vRcrTz+ioyIabOvZ44WliUYtezZXEAJwUBYvCHEhVP03OZpJgfxD8
    fZCiyklxgLdmqhr+dwiUZzGaJfDfH8MQKxr9EZnuy3KYT/bDXTZ9zZ1QKyBmCqduqKoWDw
    HLv9mdSi78zC8T4D/qQd0Ds7osYCRNpt+0Kp7xPiFqgGu0HLHg3bACIjI/eCiao0pPMEHY
    ev2V5YusamRF+J7KGyZOJGdSanPVqrxIoj1oVwDyLHJYVRyXnKhVRrFXYZbjNwmxFiJi5h
    jVSxmFi8jV8H8Z8fyDEEcVqEdHRcQ79+a7mCg3RbHvo8BLuDTsunMnmod0kE5zqQy4jEgC
    MDS4qZFhCQBbtYsYtXTP80AC/cJstV82taW5qsjQ5TBhe3tzYw37RiMCt/0JdQ6U8ezWUk
    L5ux+tBqdEenH/RgxWXiXCZtByWIyRYflPUF6AhzyKotiNOIdNHqkqzmnaS2YcaKA5HvD3
    pTObWLxx7xQA9LhUvSYhD/Piqh3gkF1z10zu/ZUvKBFjfTo3XFazq68NcfFw
X-ME-Proxy: <xmx:fmZWavxgOIUfIw2YCggDwLwNxjLCbk8Ufg3Hbzu33KjZ67TjCwzaFQ>
    <xmx:fmZWaiYW3te2kHeUvzxj73M3nrDHuNxK3CrvRq9e_YvZSSUB6-p7yg>
    <xmx:fmZWaovWViWPM5Y-l6a0PdpvnjbVEewYF7K0RqTlpSg023PBeqadgg>
    <xmx:fmZWaowpcDOQ-L0rTa2QzV5RE4bCh8LxjMsJgFI7WNlVX_qx-DQRFg>
    <xmx:gGZWaseA5mjguVNQhqIQPGtSlzou5PrQLfCFrEGriXgeYQaLmz3zjq2K>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 12:40:29 -0400 (EDT)
Date: Tue, 14 Jul 2026 17:40:28 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Hao Zhang <zhanghao1@kylinos.cn>, 
	Hao Zhang <hao_zhang_kdev@163.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/memory-failure: keep the folio, not the
 poisoned subpage, locked across split
Message-ID: <alZljHr4Nk3FOpCP@thinkstation>
References: <20260714122344.351895-1-kirill@shutemov.name>
 <20260714122344.351895-2-kirill@shutemov.name>
 <c4aa63df-30ab-464d-bd0b-48dc37c8e6ba@kernel.org>
 <alZNYYsybKZA0eJb@thinkstation>
 <18fe5529-2ad5-4330-a362-708a152bacee@kernel.org>
 <66A57599-EDA0-4E99-B073-F2AE0B2ED708@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66A57599-EDA0-4E99-B073-F2AE0B2ED708@nvidia.com>

On Tue, Jul 14, 2026 at 11:44:39AM -0400, Zi Yan wrote:
> There is an alternative, only igrab() when @lock_at is at or beyond the EOF,
> as I was bouncing ideas with Codex.

I saw this option too, but I wound rather not go this path.

iput() still can lead to inode eviction an bunch of random filesystem
complexity under us. I don't think we want to think about other
fs-related locking issues in split context.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
