Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B08026C3BD;
	Wed, 17 Jun 2026 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728026; cv=none; b=UPzebhNLRQkH5VNH+x3hmLApM2pUzMnD7A8FwPjgExuwcyqgZROhYNm33qZt4ODjF3CxGHBX3y+b5RZUOgvm/KREaSU/IKKUoPH9g49Ws0yVwG5W8v1kj8uRerXLLCLP6pdAAUUAGCpA2tGTDKy9ipmjLSb6p12L52L6zOWruVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728026; c=relaxed/simple;
	bh=wrLOksLk8ilXMkLV9/Thto0WWiWY33KYjE5bRuIdUt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bzge0DisN0ABU/C5Hl7T0SZKH6Qa2zjF3S6zgJDCjPzfOQgFjF+/3tJXYOwKDYsKbopmNqe0oivvpQJwm7+G4wRd8F6qHIJXhjU1xvQsw/h1qnaa1ZkKIQ44A022AVd8uOammeP3VzzxhJVWq9nE3jQ3/HdO/GFDOu3YBYO80Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M54DNP8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M54DNP8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB7D1F00A3A;
	Wed, 17 Jun 2026 20:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781728025;
	bh=LzYmwujWLunudnSgnq/GM6yLVXRFCVK3w+y0hYd1CS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M54DNP8IYmjHd0IQkzmNFcys1ijAP4kppy2npEyiWdnIQ1cRgQybQd2oowOGROrAK
	 sb65adRdvvRqjqDLf9mYSQ1/iJwQ72esG1uxFUh7xmeHWi8onQiUxA/2yodxRKL80O
	 QvpdBn3n/5belKUbYJd9BqQKcFo/90f+mvlzALJmGDIyfGqtHSBaCy3s0BCnYfrG2R
	 1aQygI+DPr8Cr5OHo0tHQBjekEW+4f7Ynrkh2lLzhUp6VwLMD/g9C1EQwYv1b7e2Kh
	 KcZKvAQus0AslgClYG1yOBCqcF6zlPQwvEcW5UWfqXXOOgxmHYRNZtSlwje662Cvqq
	 3PI5s9XcXyv5A==
Date: Wed, 17 Jun 2026 13:27:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Michael
 Bommarito <michael.bommarito@gmail.com>, Marc Dionne
 <marc.dionne@auristor.com>, Jeffrey Altman <jaltman@auristor.com>, Eric
 Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH 6.6.y] rxrpc: Fix the ACK parser to extract the SACK
 table for parsing
Message-ID: <20260617132704.0e1fe56b@kernel.org>
In-Reply-To: <20260617180410.271223-1-sashal@kernel.org>
References: <2026061543-superior-passerby-d597@gregkh>
	<20260617180410.271223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 14:04:10 -0400 Sasha Levin wrote:
> Subject: [PATCH 6.6.y] rxrpc: Fix the ACK parser to extract the SACK table for parsing
> Date: Wed, 17 Jun 2026 14:04:10 -0400
> X-Mailer: git-send-email 2.53.0
> 
> From: David Howells <dhowells@redhat.com>
> 
> [ Upstream commit 333b6d5bb9f87827ac2639c737bf9613dbae7253 ]

nit: you missed the "skip patchwork" header on this?
