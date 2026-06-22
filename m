Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485443B0ACC;
	Mon, 22 Jun 2026 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133521; cv=none; b=KhtfM9YXWW6+1eTPBqf5lRWpvQ5noRkkI72wpLtRtsqvW08OpK8oj1kKifll/Vakd7pdgEjhcTbJ/17a/pMHLKORP/3QYcI1X0ZwjPxGUQ8RiE++9hSs7mpLp1DMLczTNwsyV1xgzpRNFujoAgwYuPA90o4SjneWFLKM1cduRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133521; c=relaxed/simple;
	bh=aAiU1+PeTaueKXXRO5aRh54gV/A4fotfpqPEVsXzdGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlhdnJvMk3fhFylCWdao8NLNBMVJcQdHh6effVp24Z7i6FzF7OAL7qBtuwtEqxuaoqxovMCLKQsQz9rbtRhmirmzpFzXxNlM3RWnpUFnNiyCLN6q3FC37sfqpHlmNqQt+8Y5i0GlwIttQsibk7rtXjQa/sbplAn/3hX2My/OLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoIMw0Nq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoIMw0Nq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A030A1F000E9;
	Mon, 22 Jun 2026 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782133519;
	bh=ST5sgeGD2s+EyPUvMS7cEgSB0Di8OpE8mQiXgesAnfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JoIMw0Nq4A/QLZ9fTo1Z5nkni/OiTAxA8eOoitNkisfdfxfLT+fDTULGljflcubi8
	 rIAkL6q8aI4/w47eW7u3UOwu8QDHfCN3p67cu32YlTH8OR97e3y/qvdKod7Ay4fbxn
	 vxlZa1SYgbbG+AXMGwBFd0v8DBG/5A25sOg+sTZhsy692Huzs5bwSdvpsMyDSBhKZy
	 XaJZJOOFEYS3810q0YSUjzLmMOiO/CZ9Yj0ga5SMHlk+bsM4HHx3ZRbzts3H6DB2kB
	 lOw7wivSav8wJgxY7j3ko0G7MWlaSfnVOIX+q2OuZiuBngSy6XgrY2Zlx1vAAbTiUH
	 b++E9joaFCQvQ==
Date: Mon, 22 Jun 2026 14:05:15 +0100
From: Simon Horman <horms@kernel.org>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, barak@broadcom.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] bnx2x: fix potential memory leak in
 bnx2x_alloc_mem_bp()
Message-ID: <20260622130515.GE827683@horms.kernel.org>
References: <20260620062402.89549-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620062402.89549-1-nihaal@cse.iitm.ac.in>

On Sat, Jun 20, 2026 at 11:53:50AM +0530, Abdun Nihaal wrote:
> If the allocation of fp[i].tpa_info fails, the error path will not free
> the struct bnx2x_fastpath allocated earlier, as it is not linked to the
> bp structure yet. Fix that by linking it immediately after allocation.
> 
> Cc: stable@vger.kernel.org
> Fixes: 15192a8cf8a8 ("bnx2x: Split the FP structure")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, there is an AI-generated review of this patch available on sashiko.dev.
While I don't think that should effect the progress of this patch you may
want to consider it in the context of follow-up.
