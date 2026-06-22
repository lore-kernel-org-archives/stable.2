Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C112B94;
	Mon, 22 Jun 2026 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132473; cv=none; b=D4lh6guc5bIsKLBMQFqJFpHTeMebtiDTTpOZ6CQTgy/l/2Z3+k2Wkutm70J8KWf4/9j84jaduvq6gCZs4slGo6zygYzihpQrUm/FtSFhcDGdjq+v2mazdewI3ZWkYgtGZzNWxj9C5JDYTYSQUrFHcEBDPRGc2w+7pfPklcYAf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132473; c=relaxed/simple;
	bh=4UF/Am4MtOdJ83Vu4S6+mm9aMvWteN9nXnpm03SdfM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaKs7nreMIkXYQcGsDDjPfDYeGDTPiicPQ50IK5+8jJ7zRkMkpWMrJxIFKQLF1n5aoiq6C0DRV10SB6GC6M0pz1POregbAXNUt7/SXdGscA+hkKr9BF+p64fLQBBsiwpvkH7P4lwbXnBMAbbWArTUeFG+wAsYLWZvqvPIrN2eqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuT7Y1JZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuT7Y1JZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F771F000E9;
	Mon, 22 Jun 2026 12:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782132471;
	bh=73XLj4XVCyOSdZQ//mffGZhSsB2aUhfbu9xm49GWSOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XuT7Y1JZhH19OB08joG/4F9LKDGYdPRZh2/ULYrhgYC1zhsESxuByY6KU/940GdWu
	 nbgkO5xQJR5Q/i4/SP6PMLVONrxnHvM7JRJ+PIyUZWVTqEDn23wTqiZt1tTUdqciul
	 JRPQaAaAKT1Tgy6P8EeRmNK2tXa1SZXaeDX+03QTqr6MYTIEH9E8nlMbzbYroLB2jV
	 35CaK1d4G97Pq6lfQ4cmMRVCEpYof3nj2sRCrWTVJIx2D7wfJeXZf+5XkzhXXS20gb
	 hCwxeFSwdmcuQxlfGBWpi54q6ZAfLifCEg9rM2e7vX/TrGW/zWvRW/15hf8EKnM97g
	 9uHeYAHMGx69w==
Date: Mon, 22 Jun 2026 13:47:47 +0100
From: Simon Horman <horms@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: au1000: move free_irq out of the close-time
 spinlocked section
Message-ID: <20260622124747.GD827683@horms.kernel.org>
References: <20260619151816.1144289-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619151816.1144289-1-runyu.xiao@seu.edu.cn>

On Fri, Jun 19, 2026 at 11:18:16PM +0800, Runyu Xiao wrote:
> au1000_close() calls free_irq() while aup->lock is still held with
> spin_lock_irqsave(). free_irq() can sleep because it takes the IRQ
> descriptor request mutex, so it does not belong inside the close-time
> spinlocked section.
> 
> This was found by our static analysis tool and then confirmed by manual
> review of the in-tree au1000_close() .ndo_stop path. The reviewed path
> keeps aup->lock held across the MAC reset, queue stop and
> free_irq(dev->irq, dev).
> 
> A directed runtime validation kept that ndo_stop carrier and the same
> free_irq(dev->irq, dev) operation under the driver lock. Lockdep reported
> "BUG: sleeping function called from invalid context" and "Invalid wait
> context" while free_irq() was taking desc->request_mutex, with
> au1000_close() and free_irq() on the stack.
> 
> Drop aup->lock before freeing the IRQ. The protected close-time work still
> stops the device and queue before IRQ teardown, but the sleepable IRQ core
> path now runs outside the spinlocked section.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, I notice that there is an AI-generated review of this patch on
sashiko.dev. However, I don't think that the issues raised there should
block progress of this patch.
