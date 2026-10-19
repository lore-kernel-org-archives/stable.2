Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA1331EAE;
	Mon, 19 Oct 2026 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413830; cv=none; b=PnjlKl4HHR8oDNYfs9a4tiPfaICxqGQfrg/TNjURgCglq1bZ1WrOeMb2fMEN2c0sPxTwvti0kVSeXLcEPQtwvU+Wmu9aHZeqj9EeOAGxWY07sULaQOK7ZKPi4WUGlpBK73zYFHbLZ1tsjUMScI1J1fdA40Ry3hXQm3HGDOh+ZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413830; c=relaxed/simple;
	bh=+Zkftj1gAqFgA4rA8vvXnjRSqbYzke6DaC9Z4l+O33A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYKhMAyTxjLaAPY1/mVQ40SF6d7PPVz29e3fhxHjGxroy5rH2QCsGKfl/z2YyVphC/SdPjFAO3MtmIqRNVfcogwLoOCm0DDRVIWhPS1G8kDRNRe3W9NTVvu/gAHQRXNz+UHtFubwnkadXIhzYYAqs+CoWSAynd8u8fJTzhm9kww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouS/o/1Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouS/o/1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293ED1F000C5;
	Mon, 19 Oct 2026 12:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792413829;
	bh=+Zkftj1gAqFgA4rA8vvXnjRSqbYzke6DaC9Z4l+O33A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ouS/o/1Qkx0tn1uUzoxJHqMsgeZeffWr/8rLScjjDpsS/z66/czXzEc2w22K64n0T
	 gNiTue+QsIjdZJliePm+bIWmCEkbDZIOzY8UXllU3LQsFekGXUOp8rz3ya279MGLRn
	 QdUVvAKQzBMPA/sq6k1T4231WjUx8IwXImBcEbiuzBltN6ImIPPfWs47BudMT1lgdJ
	 Zgy/bbfIaMDgZuTNIdFVF9HHFbE74f0Hafqu+DvhLUPJrrX3DRAjzttKDTfpym94NH
	 /sInb0+8LOHyIIeTNnWVbkSoRinBiE+DGb+afN5yhgLMrFZ8/DX0sK6m+LaiThFpMf
	 vxQ2hOjI7McHQ==
Date: Mon, 19 Oct 2026 13:43:44 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/mremap: do not charge a shrinking move twice
Message-ID: <atYQW_lfJdRZnU_n@gremlin>
References: <20261017180412.a79a36e873c5268df126cde1@linux-foundation.org>
 <20261018015044.798412-1-nickolai@csail.mit.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018015044.798412-1-nickolai@csail.mit.edu>

NAK.

You are flooding the kernel with patches, 17 series across 11
subsystems over 24 hrs:

https://lore.kernel.org/all/?q=f%3Anickolai%40csail.mit.edu

This is in strict violation of kernel policy.

If there is anything valid here it will be treated like an anonymous AI
report.

Do NOT engage in this kind of behaviour moving forwards, it's harmful to
the kernel.

--
Cheers, Lorenzo
