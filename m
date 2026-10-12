Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65349B1EE;
	Mon, 12 Oct 2026 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818571; cv=none; b=Q6eq4l7PbedwWwnGAK5lfPqhgv87wK56+wHvbQ3n6clti/6w1VD8tOzcQMZfsBSYDx9Mt2xdeVsjJ1D4qvpt4mMM3E7/27Xr9cFMzA2gEh19wViDK7wO0TofRcm07pfNGJuR+npXFCoR7tdVcEY1kd11DrbDGex6eb0dH1LhZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818571; c=relaxed/simple;
	bh=1pPzW7bAAqdCipDrvBuW6zUDyI/nx3IHVJIuif6myvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jehmm1fkOWqz4XWv5XvhcK4VryC7FeC5UjKLnX+oYbchPrEchblYKIMfNgkXobycriiV4fphbu7Z0o2zJi0sAXaHuzHQs2pH4keb3MwuzpKzBFY5DQ3skPs2Kl6D4mCt/2tZQGOvtGUvDsQeCM3mEVHNwZDt8AhfNjSOr3Yoy5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+Q5xuvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+Q5xuvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017F01F0089B;
	Mon, 12 Oct 2026 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791818570;
	bh=1pPzW7bAAqdCipDrvBuW6zUDyI/nx3IHVJIuif6myvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E+Q5xuvHEC5Chf9m05/NcxBNZ5uFubAUsH9Ov3RGE8jxH1vlB8Sb5xcnRXulUhNWO
	 KD1IBzoN8ESgl3dEbUj9mna+IfFHFuNc+3Bo2o+TKvL46QBhs8a4XibxU2ob09eufD
	 zedBAkmHP7dGaI21tWtcUHi+eRptSZ+/ZoMdPjcCl6o9w1A15YfJX7MxUcYZFSbZRR
	 v1+GHzRQlh5YKBqq+atDUO19pSDOF+r/26rYBPBIuAfZnVVrtisWMAB5XCZLZlOfgW
	 j+D0ldOJWjMtzryj5mqF/WknhAASbrVR+m0KSy+iEs9bFKxL9bMSDuPTkjmwb4FQDn
	 voGhJo1HL9T/g==
Date: Mon, 12 Oct 2026 16:22:44 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
	Lance Yang <lance.yang@linux.dev>, Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: don't discard lazyfree THPs at PMD level
Message-ID: <asz7Nz7wGtGSG-Wa@gremlin>
References: <20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com>
 <asy445BYRhcsGDE9@gremlin>
 <8B17F897-40BE-4834-8078-949DA951B46F@nvidia.com>
 <5a52d615-8eb0-4ed1-b63a-f9016041a23a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a52d615-8eb0-4ed1-b63a-f9016041a23a@kernel.org>

On Mon, Oct 12, 2026 at 04:39:03PM +0200, David Hildenbrand (Arm) wrote:

> > I can remove the dead code if you think that is better.
>
> Leave it in and let's clarify that we'll restore the functionality shortly.

Yup as long as there's something in the commit msg that's fine.

--
Cheers, Lorenzo
