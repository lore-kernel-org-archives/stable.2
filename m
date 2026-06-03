Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241A37104D
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480361; cv=none; b=GJ0BsrSYgmaPAcyAj7coK+3psyUVHinqvpa+X25E1UNm8lHpkhi3mVNtzCMy3li2cvNfZBGRDXyZUcVR5M2JfZSGD3WmZtYJ4MObSgQaOwNxvlXYnDK5//94zqLaQruALrhJkdqsSCHWJTEXAp2H4iLDw8mWUu7BNr3vKLW8sP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480361; c=relaxed/simple;
	bh=YY53cw2KFoXP90UlUZOe1zK95d0DwsY3YnKMfN7jpPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghBHCAs1BYKbEBXw9VDIcHdzRwWD5/e4tAUeUn09R2NiEZuV522KYSfdJJFecqbrtk19A6NdpRlZ04gphohKOY0v2opxRSQEOlGG5QDa+IEsZc4cOrzkzENf/d4Dr082HEbL+R8y4Igpz7JVHiz9NoGaMyHrPvadna7xc/QsVp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YfPoiDZK; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YfPoiDZK"
Message-ID: <bcf95603-a04b-489e-8edf-b6bc4a42192c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780480358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9y161r+C4QaUQPCPFY8+/eWlsInhIknGyIgcTTS+Zk=;
	b=YfPoiDZKbBT/Gq1znLBKg7M/pnDycgPCLsUnM5pAO6QSkWDgpjnE7JiGWJ53PHqcdOxqMg
	0qVAErTuGUhQr6r9xL+flbasJvM6idM4nP8luELXc01opatOy4V0+ugM4O3laFOVhqmCwH
	53iUQ2lbj07rnJO5W0YktFF9XUCDvWE=
Date: Wed, 3 Jun 2026 10:52:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/mincore: handle non-swap entries before !CONFIG_SWAP
 guard
To: Pedro Falcato <pfalcato@suse.de>, stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, jannh@google.com,
 liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ljs@kernel.org, vbabka@kernel.org, chrisl@kernel.org, kasong@tencent.com,
 baoquan.he@linux.dev, youngjun.park@lge.com, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, kas@kernel.org,
 kernel-team@meta.com, stable@vger.kernel.org
References: <20260602172247.279421-1-usama.arif@linux.dev>
 <ah8XqXQycZdbYFG9@pedro-suse.lan>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <ah8XqXQycZdbYFG9@pedro-suse.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 02/06/2026 18:51, Pedro Falcato wrote:
> On Tue, Jun 02, 2026 at 10:22:47AM -0700, Usama Arif wrote:
>> mincore_swap() also fields migration/hwpoison entries (and shmem
>> swapin-error entries), which can exist on !CONFIG_SWAP builds when
>> CONFIG_MIGRATION or CONFIG_MEMORY_FAILURE is enabled.  The
>> !IS_ENABLED(CONFIG_SWAP) guard ran before the non-swap-entry early
>> return, so mincore_pte_range() can spuriously WARN and report these
>> pages nonresident on !CONFIG_SWAP kernels.
>>
>> Move the guard below the non-swap-entry check so only true swap
>> entries trip the WARN, and migration/hwpoison entries take the
>> existing "uptodate / non-shmem" path.
>>
>> Fixes: 1f2052755c15 ("mm/mincore: use a helper for checking the swap cache")
>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> 
> LGTM, thanks!
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> 
> Maybe Cc: stable@kernel.org ?
> 

Ah yes, I have cc-ed stable in the reply to this email, but probably that
is not enough?

Thanks
