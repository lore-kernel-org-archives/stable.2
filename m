Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF12F5A0E;
	Tue, 14 Jul 2026 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005941; cv=none; b=rDXxC3mb/8ku2jw6cYZTVFfI4BpFj8FHCqmoMwDSaHCxG60B2m2/EhNhcXF4hpu6COgRPDBKj/Pqew5JWb+lPM8QR2ZmnkO3hScd4RYpzBksJeq8esV/h0ZT5jTeQa88VWJzcPec45kwx8XVgLexvaopvSUslFgBtxnGLdbGpec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005941; c=relaxed/simple;
	bh=QKLHpYC9cD10hDiGlFe4/QTrEv2pYoWptLgAsLjXIE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtWHCTnzkKdRq2peF921RuAtrk7a4F+RT7BvD1y8EuQ6Lm+a0UcH0sLjrAOaeqgjSOM88fkB1AstIKSFjByU9rmTCAP3jZCmtc9OrTVclZdnJSypsGCIzBat5v4aytOfQFLoIkNBpj724osso/YRjrPIOyrv2r6Xo04cfLfTByk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ufuW9pbH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ufuW9pbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DE51F000E9;
	Tue, 14 Jul 2026 05:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784005939;
	bh=TMXzA4wrYATAkRbd0MtGWCT8lsBcidpH7evOMPd0N8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ufuW9pbH7t+BO068AtApQMfa4+R7cKxsBYRakma1PEbq7EB76XZ69ffufKfWQMuem
	 f85rZKZBc6EuYiVdHJSbXn1izuXBuR+2eXapNX2n9Og9RT1CeamIHN7/upL3odkuGa
	 MVa20/aJOfYrBOAFuzn5EHWR0Oi5pGxxGx0gd9zA=
Date: Tue, 14 Jul 2026 07:11:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qi Xi <xiqi2@huawei.com>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, sunnanyong@huawei.com,
	wangkefeng.wang@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH stable/linux-6.6.y] mm/memory-failure: fix missing
 ->mf_stats count when hugetlb folio already poisoned
Message-ID: <2026071451-geologic-handprint-89d1@gregkh>
References: <20260706084118.1284271-1-xiqi2@huawei.com>
 <6a756801-f4a5-44a5-abfd-e9ae57432c56@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a756801-f4a5-44a5-abfd-e9ae57432c56@huawei.com>

On Tue, Jul 14, 2026 at 09:45:03AM +0800, Qi Xi wrote:
> Add stable@ to Cc.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
