Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349688;
	b=LXiFlMjSUAo0Ln/bYTXsAEMQz/db5ckEgKQ4urCYEC/5R6MaiHkUqSZ2O6t7DZvP834y
	 2YvE4ud+sG1SfQ9RxpABnqlI0YYm1nyFkkt9xvQD9a9ZUzhnwvWkzCaJqtMovgUBuyE//
	 6vt4IzBvEGijFfy+VBRT+J7YKEyNI1YFHCVmTJvu1TQR47HE3Z6V3g8HO46OFl2ss0X4B
	 FjnEOSHLT8BWX0U86Mh0MIoucwo7e65gbqGDM/Bu2tN1We/GSUbs9CCro6dNUNJHgEy3d
	 J/CjaESdgGDYNWYr50w3CC2LEged3w6V9xQy0PmgTFgFEy8aYBDMwF9NY8LZKTV1qTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349688;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=R6vbE0PtbYBdzOcdkK69nfI2NMGSRYdaGf+o1bvzgiw=;
	b=38X6YxwdjusqBodjKPmlwPkr1aBig7B5yEu2U8FXZoFNj7hYfhYergBwpw5jRlPPa7wt
	 iwbOOwHQXxAagdbJzHpOXj1x5UaX8tEHCwhWlJAv5NEbhNhI6dRdtihPDFTvmGfWdDPgY
	 Cb5kAIzm6FMgDBEEzY7ToGowkPJOxT2i285OoLvCQGwnq2mVkSJnRlXsXPI3sYYM+9Qv6
	 Udc6ZtP2rv6GWP+wkaEFqXgyDLbJvbBLYYZCgLj63O8wTCrdSZmTSILnRu0E19FJVHfDP
	 ewOPOsy2v0pLYhc0OePwiu02G7V3D1hRwTCaqygtMqHp5XdmKZMkYeyKqLGN9FRqREA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=g7zvKaL4;
	arc=none smtp.remote-ip=109.224.244.22
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE7B606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAE7B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=g7zvKaL4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794349685; x=1794608885;
	bh=R6vbE0PtbYBdzOcdkK69nfI2NMGSRYdaGf+o1bvzgiw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=g7zvKaL4lKwN2N+VfFEQTvirHWJZKH0GhxAC3xz7O3PICsC3q3N/TweRADNXGhXp+
	 8J8Km0R7I8MjiY7DP5HLBdTLHjRzLBHZ0nhhohHwdmCAsU6KcWpNE4LTU6IkRbxK+N
	 V6eCC7itw9+IzTSqzhDa94I/CnVle3l8vDWqoLm/weQJU6tQPoPwcmW2HMZ4HiQOnu
	 ZPDqNqnFfstrnTbiUUzsa04Y2jNPIPZ+qr0RsqNPCs2/snK94gKkmEQLcfALsvW3es
	 s8ew+WwVQEnD9753SBg0wHMPFzhh4rgt37dSAbop897CAwfkSfrY2fTnGegODnE9dK
	 n8FWyFu+dXMiA==
Date: Tue, 10 Nov 2026 22:27:59 +0000
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Hans de Goede <hansg@kernel.org>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-smo8800: keep the state until the last file is closed
Message-ID: <20261110222752.2902827-2-ca@modelmiser.com>
In-Reply-To: <20261110210359.upmeyc4b4xksfva2@pali>
References: <20261107204950.88952-2-ca@modelmiser.com> <20261110210359.upmeyc4b4xksfva2@pali>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 55ee3176eb9293db6a8a8609f158030110622166
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
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2026, Pali Roh=C3=A1r wrote:
> Hello, I have not checked this patch too deeply, but I have feeling that
> something is probably wrong if we need to add a new manual refcounter
> around a whole device.

Fair question. The count covers only the lifetime of struct
smo8800_device: one reference while the driver is bound and one per
open /dev/freefall file. It is needed because the struct comes from
devm_kzalloc(), which frees it when the driver unbinds, while a file
opened before the unbind stays open and still reaches it through
file->private_data.

> Anyway, this freefall logic was originally copied from the lis3lv02d.c
> driver, which now lives in the file:
> linux/drivers/misc/lis3lv02d/lis3lv02d.c
> So if in the freefall device of dell-smo8800.c is some error then
> probably the same issue would be in the freefall device of lis3lv02d.c.

Thanks for the pointer. lis3lv02d does not have this use-after-free: its
freefall state is the static global lis3_dev, which is never freed, and
its file operations reach it through the miscdevice embedded there. It
does share the other half: a read() blocked at remove is not woken there
either, but with static state that only leaves the reader asleep until a
signal, without touching freed memory.

Making smo8800_device static like lis3_dev would also fix the
use-after-free. I kept it per device because with static state a file
left open across an unbind and bind keeps the device marked open, so new
opens get -EBUSY until it is closed, and the old file sees the new
binding's events, as in lis3lv02d. Either way I would keep the wakeup
at remove, so that a blocked read() returns -ENODEV instead of sleeping
until a signal. If you prefer the static version, I can send a v2 doing
that.

Chad

This reply was drafted with an AI assistant (Claude Opus 5.5).

