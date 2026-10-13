Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170543515F1;
	Tue, 13 Oct 2026 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905899; cv=none; b=F4jahcjMGLlS2IkafFspTvfLZfh4QO5PTJAxciHFc9c54wvuHKU2j0rd5/deC9L/L9c40jQhBJeQ42j0QVHtFkI+adKRvXX7Su/B7Cpav4KxnT89nWOvSiyyT3maJfpOkdeQLc1/G+AlKgtyIzyigWU3LiBxyt5Yov62y/vyRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905899; c=relaxed/simple;
	bh=kTCzeYGjpwQkoEKHv8h7Ma4D/dFX+AeHEOwDr+fUDZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0HWSraDjh9JyiP6HMMSDXbz8b26j7/PeIYYjCW6sh8Gh2LCGPoDZMwshr2gtOkmh/SZ4rej1P40ozvfXdfOBdkmWnTMWP/yPpk0Cf5CErQ8exhdhwWKSjEMfSGvfyxrKRdr9+AuMhlgMHt+pPLkBEY72LHwFkdBRAAnzkPnQSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioCEEFu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioCEEFu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B31E1F000FF;
	Tue, 13 Oct 2026 15:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905897;
	bh=fRac/ENAf8sbWAIo8siY+nB/tJsXS7y2nHVsGkQK6zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ioCEEFu0T8VAMITdUgiseYpyrNZcylEasjSvB/52gdAjb7MpKfrigZtNehfc+4O84
	 2Ss8bW/XCj2GFuOxCy6cOYxU46pWWLTwCcd7b1HZrrdZCYZ+nGo8aOxHnIt5ihnjpF
	 Z7NPQyj1Zc9vJhkveWnIGur253+R7yMWwG+Hya6gTdSJyZb1pAkFtEocNRxNd0ym1P
	 spj4AajzxqpabqMXQctdPSjUdoPYMgy1d/xosgLDq1wI8fL5yRGp3BiEd+oLoQMHxE
	 Oecrk9BVgP0BFNMaK7fAjJDdC/Hjrn52mn+jFmuGaTp6Mjv4XTJ29jNfkVuQpcvRXr
	 eumrKq3nLrozA==
Date: Tue, 13 Oct 2026 09:38:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: serialize access to DH-HMAC-CHAP state to
 fix UAF
Message-ID: <as5QaLgssz5ZK7IB@kbusch-mbp>
References: <20261003210154.2453077-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261003210154.2453077-2-Jeremy.Jean@oss.cyber.gouv.fr>

On Sat, Oct 03, 2026 at 09:01:55PM +0000, Jérémy Jean wrote:
> A REPLY AUTH_SEND command can derive a dhchap_skey key while a
> concurrent AUTH_RECEIVE command observing this REPLY state executes
> the failure path and frees that key. The REPLY command then continues
> and writes into freed memory, causing a use-after-free. KASAN reports
> it as:
> 
>   BUG: KASAN: slab-use-after-free in __sha256_final
>   Write of size 4 at addr ffff88800359c540
>   ...
>   nvmet_auth_sq_free (drivers/nvme/target/auth.c:237)
>   nvmet_execute_auth_receive (drivers/nvme/target/fabrics-cmd-auth.c:621)
> 
> Add a mutex to each submission queue to serialize authentication
> commands and timeout handling. Unlock the mutex before completing
> requests and ignore outdated timeout callbacks. Limit timeout delays
> to prevent immediate expiry on 32-bit kernels.

Thanks, applied to nvme-7.4.
