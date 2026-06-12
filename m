Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4D3A0EB3;
	Fri, 12 Jun 2026 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257542; cv=none; b=tHkvrJ0ciWxzhiGfm5NaCusjqFOV1ZgZXP3GInEFoF0+WqMOCh9ETP5mhIHH0tjBb6CjP62L+zg1Ov8IfifVZ6zNtzk1/2KA4m92cvP9tU0ORkj4ZPKqbaUdw1G8PzuWOVnOi7VBt9xOvN8VxJaSPgV7lWb1NFal2pjtfige1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257542; c=relaxed/simple;
	bh=/3552dzjew76TXF/z1eLbYvw5AtxdSSxtNaID3wNOs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7Lq5yhI41/DSVlydihS14IVnMg+c4S66tLgTBIBP0APndWR9ZTSuuKxzOHfU2hUlR93Ae8F5TsTe/7GrOS5JBri2hJitK7m09DPShUN+x1BcAU/ImTci28nFJvU6PIPAzRYyvm9HtJhmyFK0TNd0n2juydcdMeBUYsdOogj5Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iOP+LaI5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iOP+LaI5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sSNTgVx4QMoefTtclx/Xlh2WSlXoLU96d/rrkCmv4CU=; b=iOP+LaI57rubw5md7KzBUu0CBW
	O310mn0wVwUPcAuHvtihvhU0czBbxZj0UJsOmZm9NNOW0DMFEVpm//cC16anx+ZlTzB2phGgcTr1/
	mB0Wp1ql4MgzSwrpk2hq31F+JCnXHKnvsv7pkGtQEnqRZRZEBiwhA7hswE5Dm9BG4590EUeM0rZyV
	i7W3JLv9UVmI877uu4dYdygK7zJFB2wj+K+N5UTjxfHirYeF9AmU9uBmzn0kF0LhGYVXVmnBlpJTb
	k+OEmrJ3p/XArlzHp3Acsr0PQoTLHa6U7aQAo+4pgEjiVbDRhIVnzBK5gpS54p1JhjmbevIezwnvY
	JGYoWInQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXyS2-00000006G3N-12Ru;
	Fri, 12 Jun 2026 09:45:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7D76C300312; Fri, 12 Jun 2026 11:45:20 +0200 (CEST)
Date: Fri, 12 Jun 2026 11:45:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, bsegall@google.com,
	dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
	vincent.guittot@linaro.org, vschneid@redhat.com,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, riel@surriel.com,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] block: invalidate cached plug timestamp after task
 switch
Message-ID: <20260612094520.GA42921@noisy.programming.kicks-ass.net>
References: <20260612094042.3350401-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612094042.3350401-1-usama.arif@linux.dev>

On Fri, Jun 12, 2026 at 02:40:42AM -0700, Usama Arif wrote:

> +static __always_inline void blk_plug_invalidate_ts(void)
>  {
> +	if (unlikely(current->flags & PF_BLOCK_TS)) {
> +		struct blk_plug *plug = current->plug;
>  
> +		if (plug)
> +			plug->cur_ktime = 0;
> +		current->flags &= ~PF_BLOCK_TS;
> +	}
>  }

If you can guarantee PF_BLOCK_TS is only ever set when current->plug,
this can be reduced further.
