Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459BD3AC0FC;
	Mon, 31 Aug 2026 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162341; cv=none; b=asVtOEgfX1/zut9jREps0tn8/Dvym3EW+R6bX9Wl9xhrSJKDgtQsqHfsfplNh/0wOgYulN3rRWb8IISgm5ae9iNO6KFvpLd9S9nWXTpAwOgm+43lqPxVP62OBbDSwRuoXxVDryC/GGGenBWqfxIiVhtUZ9g8SL7ZLgU7nco1Mhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162341; c=relaxed/simple;
	bh=0C1DpZSex7yIopHmCohYVtHcaaxa74ajHIR5lkcvaIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nuPOb5sZhKY5ClwW+AXmu6qfTdRayZ22hXcuGqeBrhtKPdEFYgXBJhK8OJrdtjY3ZmmjhyLZbEFxsMjsekLcxCw0p1jMc7fBJzcCkzdVa0/o0Ypu5MNhEIILAiVtITioY3sq53kVWPVvF0nsk50Iib0V74EQ/v5Zg4FO9AqWSCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wLaMV6nv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wLaMV6nv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 526F64E4145B;
	Mon, 31 Aug 2026 07:45:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1DF0F601E1;
	Mon, 31 Aug 2026 07:45:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4F9611C783B9;
	Mon, 31 Aug 2026 09:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788162327; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0C1DpZSex7yIopHmCohYVtHcaaxa74ajHIR5lkcvaIQ=;
	b=wLaMV6nvma89mGbAdovz6/agGE8q97+IlGEHAUuChQvNIN6cJE7Mqf7wSVSmK/v/jed3K7
	FwEdYsOB9PsOusIAfGfHUMG0Jr7UK8bcqoRHHDnBxYEb6os7ZjxI+mktIfGaLoLQHyY4oK
	cUqBRNiVCWQBx7uRMxD8U/z/ckM+AAa0v/aQRlm0laqFYQzWeIJZIo5T/wQOu0CcFVqO8L
	Fqlz8LpIpQRs+weMyMI6Qvk9y4r3rKZLEqMGjWNUYTOSHNbDgnbJIj85RUivKpBY7mtf8j
	ZCu/ufza7jEF60YSKSqwvhHzw5cYt1TQBid7EvzQuRP5bFp8xoKWrnpB295PNg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  linux-wpan@vger.kernel.org,  "David S .
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Xuanqiang Luo <xuanqiang.luo@linux.dev>,
  stable@vger.kernel.org
Subject: Re: [PATCH net v4] mac802154: fix data race and NULL deref on
 local->assoc_dev
In-Reply-To: <20260829230551.1787432-1-skwkevin@mail.ustc.edu.cn> (Kaiwen
	Shi's message of "Sun, 30 Aug 2026 07:05:51 +0800")
References: <20260829230551.1787432-1-skwkevin@mail.ustc.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 31 Aug 2026 09:45:19 +0200
Message-ID: <877bl6d980.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 30/08/2026 at 07:05:51 +08, Kaiwen Shi <skwkevin@mail.ustc.edu.cn> wrote:

> local->assoc_dev is shared between the association path and the
> association-response worker without common synchronization.
>
> mac802154_perform_association() stores the coordinator pointer and waits
> for a response. Its timeout and error paths clear the pointer and return
> to mac802154_associate(), which may then free the coordinator object.
> Meanwhile, mac802154_rx_mac_cmd_worker() may observe the associating bit
> and enter mac802154_process_association_resp(), which dereferences
> assoc_dev.
>
> The worker's bit test and the handler's pointer dereference are not
> atomic with respect to cleanup. Cleanup can clear assoc_dev between them,
> causing a NULL dereference, or free the coordinator while the response
> handler still uses the pointer.
>
> The recorded result is exposed to the same window. assoc_status and
> assoc_addr are written by the handler but read by the association path
> while the associating bit is still set, so a second response for the same
> request - a malicious one, for instance - can replace them between those
> reads and leave the caller with an incoherent status and address pair.
>
> The response handler only needs the coordinator extended address.
> Replace assoc_dev with a cached address, removing the pointer lifetime
> dependency. Protect the cached address and the associating bit with a
> dedicated spinlock. A READ_ONCE()/WRITE_ONCE() pair would not guarantee
> an atomic __le64 access on all 32-bit architectures.
>
> wpan_dev->association_lock cannot be reused here: nl802154_associate()
> holds it across rdev_associate(), hence for the whole of
> mac802154_perform_association() including the wait for the response.
> A response handler taking that lock would only get it once the
> association has already given up.
>
> Reset the completion, publish the cached address, and set the associating
> bit while holding the lock. The response handler takes the lock, rechecks
> the bit and the cached address, records the response, clears the bit, and
> only then completes the waiter. Thus cleanup cannot pass the handler
> between its state check and completion, and the cached 64-bit value
> cannot tear.
>
> The handler clears the bit before completing, not the woken waiter:
> otherwise complete() is issued under the lock and a second (e.g.
> malicious) response can reacquire it before the waiter and replace the
> result. So a wait that returns success implies the bit is already clear,
> and the success and negative-response paths return directly. The
> transmit-error and timeout paths still clear it under assoc_lock, which
> serializes any racing response against the cleanup while the call returns
> the error it already selected. Both paths snapshot assoc_status and
> assoc_addr under the same lock.
>
> Both users run in process context, so a plain spinlock is sufficient.
> The lock is not held while waiting for the completion.
>
> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Suggested-by: Xuanqiang Luo <xuanqiang.luo@linux.dev>
> Fixes: fefd19807fe9 ("mac802154: Handle associating")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
