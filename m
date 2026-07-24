Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55641D206;
	Fri, 24 Jul 2026 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885476; cv=none; b=dIKj2E0K9kW1dLRjNSjNksyPQ7QbVMFmYhC6i9VtUo+ei1omSRe3LrPcnCXZsCeEAHii/fkG6GLPGe11So+Ei1J/cJruq+dpa6znN3iiOWnD15Kbk2cFVHjRyIN1RWbDRQZ5AY5fatwb9HJ154mw5SCrIG871Bk/FqgG3NeX4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885476; c=relaxed/simple;
	bh=fzgD4V5MIA0KiY2Mvng0aHc371Gvmh/kTPZoO5D8dqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WGpOn+nl4zSc7XJaPSH3growr2aUO5L4o6vEarOS5B3h00p0WFCOWm7LIQcWM+fCuL32UlFuIxSUzkO+iqKTq/27yqxaRNqOSwGHtnMERVWQw7tHceDplSpk9VMZGF/bN7ppr70/5bQoMPnaADiFHTLc4h7Vxn3JwTDVv3fpUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wmXj99XG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wmXj99XG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 570CE4E40EE0;
	Fri, 24 Jul 2026 09:31:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 142BC60395;
	Fri, 24 Jul 2026 09:31:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0BAC11C11DC0;
	Fri, 24 Jul 2026 11:31:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784885470; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fzgD4V5MIA0KiY2Mvng0aHc371Gvmh/kTPZoO5D8dqI=;
	b=wmXj99XGkNUvdoLYe6ZYh7bKy0Al1jCTXcD+0yxSVcX2DSjomdJMPvYE84NsM8LTzzAwol
	Xa7SoNRgXMANfj5xWwA8Qa0CLxepjv3vpeWeh/JUDNdbDackEURBRi6LA5B3Z0pME2/l5k
	YhBDu31ilwXZXnT8lCeT4shhIHc3LVcK45kaFh/IbroIG1sQs5VNHHgifRaYPa4zF8j3u0
	ZqlUORIFvGqTqE/HoTPq3XbL22FU+iadhdGIqcMC0lNOZdyp9nFLZgZGgViBu221F6yrPl
	NRNNqTQsgGl73zJq5EfgGeNaT6eV/NZISy5uQm9ey7l6IYdyj59R6dSkjjkKoA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,  horms@kernel.org,
  kuba@kernel.org,  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH net v2] mac802154: lock rx_mac_cmd_list and drain it
 before freeing sdata
In-Reply-To: <20260722101608.37744-1-security@auditcode.ai> (Ibrahim
	Hashimov's message of "Wed, 22 Jul 2026 12:16:08 +0200")
References: <20260722101608.37744-1-security@auditcode.ai>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 24 Jul 2026 11:31:06 +0200
Message-ID: <87a4rgspid.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3


> rx_mac_cmd_list has no locking. The RX softirq producer in
> ieee802154_subif_frame() list_add_tail()s while the mac_wq worker
> list_del()s, and the worker dereferences mac_pkt->sdata with no
> liveness check.
>
> Removing an interface (or the phy) thus frees its sdata while a queued
> packet still points at it, and a later worker run reads freed memory: a
> KASAN use-after-free, reproduced by flooding a victim interface with MAC
> command frames and deleting it. Meanwhile sibling interfaces on the same
> phy keep adding to the list, corrupting it.
>
> Add rx_mac_cmd_lock around every access -- producer, worker (which now
> dequeues under the lock and processes the packet after) and the new
> mac802154_flush_queued_mac_cmds(). Drain the queue before the sdata is
> freed: from ieee802154_if_remove() after the RCU grace period (filtered
> to that sdata) and from ieee802154_unregister_hw(). The drain precedes
> cancel_work_sync() so a run that already dequeued a matching packet is
> waited out while its sdata is still alive.
>
> Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---

Looks fine to me, but honestly this is flirting with the edge of my
human memory.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
