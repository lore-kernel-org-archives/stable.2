Received: from mail-24428.protonmail.ch (mail-24428.protonmail.ch [109.224.244.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462918EFD1
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781936048; cv=none; b=d1utn2rtD9MriW4yWouuWgeM9DpENtvHnN/ShzvWIEsxDhye4Z1mtg2LMRoeioYhVhKf7OfrrPkAsx5+XPzCagCXCSwRrvzjXuLy9uJQWGfBCsA8hxSQQ7BWGCha6w8fAINtjImA5ysrStG65gvbs5jXChYvEv5+WAIMimv5mmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781936048; c=relaxed/simple;
	bh=yUiQwt/pxdNTjCrzt4OD0KcA0Oib1tCa907x9vaNgy0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mSA4gL+cp/Muxff+t2st3GHFvOp9eelToCBKgZ429tcVwKSwJU+dtx1643jnqDY8y5XeBf5vupzNq2em6Ndo3H1wU+cc3+61bcHMeX8Nq4t7+PceaIZFZEFB+bOAWIQtA54R1M1qJWnReGMuLok3sd5JrDwxr9zMK/TFu9Ait0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=huSlxRdn; arc=none smtp.client-ip=109.224.244.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="huSlxRdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781936036; x=1782195236;
	bh=yUiQwt/pxdNTjCrzt4OD0KcA0Oib1tCa907x9vaNgy0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=huSlxRdnkqD8nHeGkA66cUMWiowQnOerqJRbMeMy+6Yp8w3jdu/tYMHhdLVhSL+BW
	 G36hmsZi6LK/mGpuT7qUzgaSLJxOJnAGiRa42+RYXK33OxeweHl6pWvkuBBeqoT1NI
	 /+mR6XnJKQiU+nDwaNOCf6uq/ejg+FjlH3nVevcmPSNpeUnXI7FsznVl/Xc4e76tUN
	 Tmw+rSm4sbOph20hXLgTsFw23b3aB0qCXlD4PmE0t9klp6RpA00+v9LInIpNCjwiFE
	 GmTXSRveJJC1G2R0URDp2QkuQjcRm7EOmUdbOXV9jOaZcUYfvQdaop9MNDoIvK7fDK
	 o0sE83NwzjHIw==
Date: Sat, 20 Jun 2026 06:13:50 +0000
To: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
From: Cyber_black <Cyberblackk@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "gabriel@krisman.be" <gabriel@krisman.be>
Subject: [BUG] io_uring: possible CQE32 overflow flush inconsistency in __io_cqring_overflow_flush()
Message-ID: <Zurr63tEcYPbtU0ltI3-1KdtzFeys4ybMi-njjblykGD6LnMs7gYFwRzZNw3AbjYglMSO8LESxjUPHLnV2-AXHNa_17pDLHe9eCKTXBozLE=@proton.me>
Feedback-ID: 117998405:user:proton
X-Pm-Message-ID: 590ac41afe365612470efc6e1cb4b6b859dc335a
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



Hi Gabriel,

Thank you for your response.

I found this bug while doing independent research. I was reading the Linux =
kernel code from Linus Torvalds' main repository (git.kernel.org) and the i=
o_uring subsystem caught my attention. In particular, the use of shared mem=
ory for optimization purposes stood out =E2=80=93 especially since this ver=
y feature has been exploited in the past to develop rootkits targeting io_u=
ring.

So I first studied its architecture and then read the code in depth. The bu=
g emerged during that review.

Regarding a trigger scenario (PoC =E2=80=93 Proof of Concept): unfortunatel=
y, I don't have one. My system does not support io_uring (it returns ENOSYS=
, likely due to enterprise compatibility settings), so I couldn't run the l=
iburing test suite. However, the fix itself is straightforward and the logi=
c is clear.

As for the target version: this issue exists in the mainline kernel. It is =
not in a stable release yet, as I found it directly in Linus' main tree.

Regarding the patch format =E2=80=93 I just generated a clean patch using g=
it format-patch and sent it separately

