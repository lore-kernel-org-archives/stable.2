Received: from mta1.migadu.com (out-85.mta1.migadu.com [95.215.58.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9AD54763
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788072862; cv=none; b=UHM4XP9PhGigNDBuHr3rBvMypmpfdyfaZ4w8YPQtggU1KGTToIy2rlnvuNvjnkuywAK5u54ju7o4P1bjSO+hlbnPvZx3s1KV4exgGL/78gVrg7vwl2vUFlIELu411pFJO98gUX6Mp7CMhvzILhYX0bBL5viFp1MBSpIHvzXpq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788072862; c=relaxed/simple;
	bh=CLM1qrAWCRhxzoMBMGkElu+OPpLsLYySo03hiJpSqRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUqA+5zLxNVOsKHcaBPrdkWg5VhGke32toZKRq3AnCOASY3WmQvhqtVRJ4P2Xfq3Dll/y27oSYV5e04yXegC+IGf2kWwgagelOa+1T2G5GVxlatGn04EGzwzZDXChoQgZFnhSmgPsb5GCHrnJLYOXY9QWEnbVGSkAupTUN7Isd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ikAoBihI; arc=none smtp.client-ip=95.215.58.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ikAoBihI"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CLM1qrAWCRhxzoMBMGkElu+OPpLsLYySo03hiJpSqRM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788072857; v=1; x=1788677657;
 b=ikAoBihI7pkW1+N7aDfekmTZ2TyKMr/byOK0P7j59TMkxnnaSgkgeNiDYb3IVT2eMr1Kc7ip
 OlQm9gLx83OxYij2k8Lzz1TYBgaB8yUT7m+Xyck/wl4IeKYBQgAKH7nZCNPk/vDLUbOhbf5wpdv
 k9CF+oPAICjHHkXina+vLqFI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c1706cd15f3f71d4;
	Sun, 30 Aug 2026 06:54:07 +0000
X-Mizu-Trace-ID: c1706cd15f3f71d4
X-Migadu-Flow: FLOW_OUT
Message-ID: <3ce53771-fceb-425e-b8e6-2ad0f886643a@linux.dev>
Date: Sun, 30 Aug 2026 14:53:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] mac802154: fix data race and NULL deref on
 local->assoc_dev
To: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-wpan@vger.kernel.org
References: <20260829230551.1787432-1-skwkevin@mail.ustc.edu.cn>
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20260829230551.1787432-1-skwkevin@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/30 07:05, Kaiwen Shi 写道:
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

Thanks for the update.

I don't think my review warrants a Suggested-by tag here. I only pointed
out a small issue, which did not alter your original approach.

Other than that, the current version looks good to me. Please drop my
Suggested-by tag and feel free to add:

Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Here are some related discussions about when a Suggested-by tag is
appropriate, for reference:
https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
https://lore.kernel.org/netdev/20260803190044.274355ea@kernel.org/
https://lore.kernel.org/netdev/CANn89i+O5b0xfcP5GLtUopqHz2ppewK9zSr4995jsjCPM+3AFQ@mail.gmail.com/
https://lore.kernel.org/netdev/CAAVpQUDaYX5ZQN+EYL3q4yeu0Ni2cqNODEY--Wb-2+yY650Mbw@mail.gmail.com/
https://lore.kernel.org/netdev/20251010065515.GA3115768@horms.kernel.org/

Thanks,
Xuanqiang

