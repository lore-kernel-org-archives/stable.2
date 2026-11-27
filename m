Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767189;
	b=JHmuyumX/kxjvXoIqc4d2z4SSLxL18jtRL2AuGqXGaopsFva/a0YzGl0xMRMm9t7a6P4
	 LLAUuOLYp3DH0gC034SuwKIpqFZBcS8qLrpu9VxH0JA4DnDTFA2+/Sec2lC1e1fipjwQJ
	 Uk8QMTYSnMlJRgLUkMZPS67cL0bWtXcxKhHGFbWGO750O485fe8waeGMOTNM79WiO+wmH
	 R/GAouH+zD9YztoI2+3vvI6VNOcW8dTU6LHwY7RTwZx9kX2MsFxzF/SnZIbWDK9mfSoZQ
	 kQg+60v7P2FVs4OAiKN5lKgrrh1sbXol2B7SqoubJAWTu3jAzt7/0abIVgRPjV+blfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767189;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bd6xCwpTiKGU4ro+LQAZ+l79onsi1Nqvm1Tjp6NoqI4=;
	b=V+XLvJGDwGWQAboNfB4BnDkr+o673VjOjJBonJUzj1l+6YCKZk0zYGh8ljNvmIS0mo8K
	 UZzFJ1msXCbzaYA0/mo2dn1sm5mHcPWf1U1vKB+EhoJpoavJ3BIgZwuoempJKtOo+AVr/
	 L+YuUjCfK42ub0EyxkSe8nt42WOwYx+pltiwebunXEjPbFF/cn5+OKMO6FEPfPAqNdj8O
	 BpfclIrTW4bUXUckuD2dfKbPq+iSNZZZG6X+lsUAuijc/XcrKrEZOi0/Rp9pBp7H/nT6j
	 8evq80lLLM1q+r0KL1utIhINLpRrtmkYasjJ66yemxM+s7pUgq0KoS7pCVqFgRFkfSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=VvFM6XMO;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (unknown [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1668606A323;
	Fri, 27 Nov 2026 08:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1668606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=VvFM6XMO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bd6xCwpTiKGU4ro+LQAZ+l79onsi1Nqvm1Tjp6NoqI4=; b=VvFM6XMOQOUvCIV3mKoqWZEJ9l
	0tFFHGfSrdRaAUBILW3pY6oBRbP7rLUajVFSpwxJ0RC6znqzTaHLlDsAx2FHpQSOKvWXgK/LUdlwa
	uU+mrr/PGc/GlX9ABjOoFrfvRUw2QOuFjeaVukypay+7z5x821x4xnAkNhvHnccuqthu5c76UQjmW
	WuoHu9QNvuWWyY3DJDGQXSefEYJkD0SEy2NrgHwc8nQkwM8k6Ipy1q/2wdtiY1BeJy1IcedXKaT1U
	Qg42A+b/vQ/FtiycE5IR3FXdWJNEbWdP/7T+TDUc9IRxoPNVtQ3QGdl0ZVo5C54kLKa5RPFJ/4oxq
	AIuwm4Ng==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWr4q-00000007Ro1-1oNR;
	Fri, 27 Nov 2026 08:13:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 78A57300756; Fri, 27 Nov 2026 09:13:03 +0100 (CET)
Date: Fri, 27 Nov 2026 09:13:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: look up address filter files without
 ctx->mutex held
Message-ID: <20261127081303.GN49833@noisy.programming.kicks-ass.net>
References: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
 <20261126-work-exec-update_lock-leftovers-v1-1-1024b26792bc@kernel.org>
 <20261126152414.GH49833@noisy.programming.kicks-ass.net>
 <20261126-gedruckt-gastarbeiter-vorsorgen-5fea7cea1877@brauner>
 <20261126-erlogen-bedrucken-dementieren-5de5e5460481@brauner>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-erlogen-bedrucken-dementieren-5de5e5460481@brauner>

On Thu, Nov 26, 2026 at 10:26:02PM +0100, Christian Brauner wrote:
> So ok, if we can't drop ctx->mutex in the middle of the ioctl then how
> about we don't hold ctx->mutex during parsing to begin with?
> We let perf_ioctl() hand PERF_EVENT_IOC_SET_FILTER off before it takes
> the mutex:
> 
> ioctl(PERF_EVENT_IOC_SET_FILTER)
> -> perf_ioctl()
>    -> perf_event_set_filter()                // no ctx->mutex
>       -> perf_event_set_addr_filter()
>          -> perf_event_parse_addr_filter()   // kern_path(), own list
>          -> perf_event_ctx_lock()
>             // revoked? has_addr_filter()? ->addr_filters_validate()
>             -> perf_addr_filters_splice()
>             -> perf_event_addr_filters_apply() on each child
>          -> perf_event_ctx_unlock()
> 
> The parser fills its own list and counts the file filters in locals.
> Everything that needs ctx->mutex then happens in one go under
> perf_event_ctx_lock().
> 
> So ctx->mutex is never dropped in the middle of an ioctl, a migrated
> event is handled by perf_event_ctx_lock() like everywhere else and no
> ctx is carried across the lookup?

Let me try this.
