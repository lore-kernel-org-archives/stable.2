Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608106;
	b=4FZJfWSCVVs+lBGcbSskYwNgfD3l6hDQGpdIE6H4mNJ3DxwhfUKSXI9YyXzwn//95Fgn
	 4y6r5XmxEHPN1S0KFQv+n/UtmabG78/Xz1ytqzicvhcPYiEKmKO0ZX6WNN58vu2Z20ZCX
	 yuIepONnBwayP7+lQ6AZukAiFNHenWuQUa2vfDB1q9G1q7jI+4ocsWq3BeMPlqtXKWE1U
	 KFW8miA3hpbM5zVAOlqe3TP4fPIst7ETZSjwOFDNiXG5o4o29tHdhQEJfWKGnor8fePaB
	 61fPR4GwXixav5ZoYZItN/D/nXfo9FHjzuHr41z67p3tdwcdvme+GBV1F7RECA1YrDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608106;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=g85ZtScV2I4XNTHq3zpYSJXggv8P2pnkPwzz2Ze7ydw=;
	b=pLB/QzvBGV1Z0EFKhFkbZUlERQ0uSwXwG0TGnk4MCGQbd4ywou/nYdzQmvJCNibuU3mu
	 +NkYQtCwVFomBuogv6hO4y94RWSQbQyWIYsTXoh9iGbb7BcBUoE7XeA4icgBvbbBicgyd
	 H/4O/oIHGzCxsYcBL0dnLQsuuiqkb8oSXQGNs92vastwjetCmfs5BFrzT12AnKEo7EDD5
	 7W9DTfZMmeCgGmHV5HMJAqsJc3yyUAliMKGupRtP7OQ8YLSFD/et6gaNl0FGnC4EXnCs/
	 REPuoySsrq3Xp0fWY9G+AjaHCNiAbi7jHyf7d4Fa0YN+ULNQr3Zfw6ZFpBbcrJX7RTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=lweNZejM;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=QAIDFWPg;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B4606A31E;
	Wed, 25 Nov 2026 12:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A9B4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=lweNZejM;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=QAIDFWPg
Date: Wed, 25 Nov 2026 13:01:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795608104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g85ZtScV2I4XNTHq3zpYSJXggv8P2pnkPwzz2Ze7ydw=;
	b=lweNZejMWRcfnmeBRHYPK8ptOMUZoF9wWQiFgD1Un0ZNl4/S71bUpfAEPgqec9Dr92aGmr
	ywFMraGx9AgmcJDuhVn3gamewb08i7O1pRCT3F7SVSMNc2rZPkdd+XoY5aHBMllZpwWsfT
	PQd8b7NCG3qBqPAQjercIHjry4vyjfALBoIsSC/1WFy5VgxttymDX9vDPQ1vPa6mFA3Zjc
	QgUp790p24qvkDhwNsTYGbAITxVTPIvPwciqtPmN6iRYfSa+GQeiXyCtnzyznUTuerqQZP
	dlrQJcbrQiLP6EYUCfJtaU2vlw9eyNzVZNccQQzvAl+BJNwMWDTzwclBkTHkCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795608104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g85ZtScV2I4XNTHq3zpYSJXggv8P2pnkPwzz2Ze7ydw=;
	b=QAIDFWPgqhD/EhRvXQzB1vdIdnif7+H/wL6YaSrkwwD5a3cFTTiYPO7NnanqHJq6NQnURE
	lz9q6UxfNDuvqoAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org, chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCHv4 1/4] powerpc/64: Leave lockdep hardirq context around
 replayed interrupts
Message-ID: <20261125120142.Uw7Srj9z@linutronix.de>
References: <cover.1795603946.git.ritesh.list@gmail.com>
 <6a02babe73f316616cf829af3ddbbfc61fb4066a.1795603946.git.ritesh.list@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6a02babe73f316616cf829af3ddbbfc61fb4066a.1795603946.git.ritesh.list@gmail.com>

On 2026-11-25 16:56:03 [+0530], Ritesh Harjani (IBM) wrote:
> With PROVE_LOCKING, boot warns once and lockdep turns itself off:
>   DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
>   WARNING: kernel/locking/lockdep.c:4448 at lockdep_hardirqs_on_prepare+0=
x22c/0x2d4, CPU#0: swapper/0/0
=E2=80=A6
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Closes: https://lore.kernel.org/linuxppc-dev/b44aefc5-e066-478b-8d34-50d2=
d0deab6b@linux.ibm.com/
> Closes: https://lore.kernel.org/linuxppc-dev/20260922150619.lwWqj1AO@linu=
tronix.de/
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
