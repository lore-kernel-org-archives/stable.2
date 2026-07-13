Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CA2437465
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955342; cv=none; b=JBWV/hGH8uEbIkVDwIm0EDSSn1IlzcAhdP4WQQFa02Iwzkn8pTYsq58EWYM4pVvjDUaXTUo0rt8lQRIUw3zZEBBO+/tT1x8sN5SUeUSMhacmIbD6yItis/SiKzmSf1jOsE8o/1a28DOvEAupi3Q6TJVjypryp0b5gEQ+tmEvuOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955342; c=relaxed/simple;
	bh=iBCTBITROoFtlNKDjrunQPxWWHqiU3SOrFt93K5iEuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFSUF116nLjjmZjCyEnY1YBggp7kysHnbwJ2VWOV3ON/F/xyOVJUm/KWAuStoazQl9tOrLj+Lk/WSGSK5z/nZKa9jr/Gh46bw5lxuts7BJ0uovp2ts9WMOZLFxn41dtLVRTK3rQJp3vp4kjshA81k1TTDM0wNrewWasLAylp/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a9xF0d/2; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a9xF0d/2"
Date: Mon, 13 Jul 2026 17:08:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783955338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+M1zr9rTUgQMNlUXBESdweoGf9U7X+OYDnRmO6YXH1M=;
	b=a9xF0d/2L71ONYPVPsefz3XZSfE3ZamyNJyyyZjrgNziQQUb/Ozdcat8yaN8Sx4s0lz75g
	QLt3rFlj1NCfC7V+n2SdodAEZULM4owumuDrhIRpdxnMki8Kp/jw5NRdoH0OUJNWOD/Nc6
	hZYkn0mKy11XwwDe/1Bb79Xwt/TZwbI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	MOKUNO Masakazu <mokuno@sm.sony.co.jp>, stable@vger.kernel.org,
	Geoff Levand <geoffrey.levand@am.sony.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
Message-ID: <alT_fEu9AtQT9PxU@linux.dev>
References: <20260711130931.740719-3-thorsten.blum@linux.dev>
 <ik6jukrj.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ik6jukrj.ritesh.list@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 13, 2026 at 06:08:56PM +0530, Ritesh Harjani wrote:
> Thorsten Blum <thorsten.blum@linux.dev> writes:
> 
> > If lv1_put_iopte() fails in dma_ioc0_map_pages(), the error path
> > decrements iopage but keeps using the failed mapping's offset. As a
> > result, it repeatedly tries to invalidate the failed IOPTE slot and
> > leaves the already installed IOPTEs valid.
> >
> > Recompute offset and invalidate the installed IOPTEs instead.
> >
> 
> Nice catch! I wonder how did you catch this?
> Do you have ps3 console where you somehow ran into this ;)
> Or was it a manual inspection?

I do have a PS3 somewhere, but I stumbled upon this while reading and
trying to understand the code.

> I wonder whether PS3 consoles are still being used?

Not sure.

> > Fixes: 6bb5cf102541 ("[POWERPC] PS3: System-bus rework")
> 
> Looks like this was from 2007.
> 
> However, the change looks good to me. So:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks,
Thorsten
