Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B432931FC;
	Mon,  3 Aug 2026 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784231; cv=none; b=DLRRkeb0WK+P9woFPdQx1ZgwnS3KMr0xJ1Cvs9ZxDfqE+r+84WRi46nSxo78NuNWN526p5LeVUSKCOZQ0jSSiXn5MQ0ceUMOxTRIINzSoSHD/sw0/wMisxhX/1kpf777qm39N7UhKr5Rd94pUFyCCIbtDMbQZL7qGek0K1Z0AB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784231; c=relaxed/simple;
	bh=zFyEHXr2OusskRszUDzPD4uvCUQzm+Wji6wQnGHkIqc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EzLEy8mDByeBK/uXaZoQRPXgk9srFzXnEdaegreDZCg1W9ov7eWT1k9gB5cNjCvpPldG7ryYI6QRmWqX/PlgYdBwuWPfP8x/WdTiFI4kRBwGeQIMc9/W7pWLl4ur4gakRoVEGx9SJxOLhWKjLidQsIMD6tXTwZZ76/Ey5XaHeBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWKrBMYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWKrBMYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F711F000E9;
	Mon,  3 Aug 2026 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785784229;
	bh=iUN+q0zuQtiAx8BaxKD9+kz0B/7SxOMEYBkzWwMFM6M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=oWKrBMYMy+ttZWa3W8UBBjKQc8xlcFWDNFFI2h5Zn1DMkx1UfVLB0HaqldZoXzJrR
	 NPz5AEC8NyvF2xnoB5BjfjjXpa181T97BxgRTV9RONKix+kgxmc0OCvMvwUvKKIUHd
	 hRMu2uG2Mq2A6At+1iAdE0n6fc/NhMnVkM9+9qMvXGpWqnFGGzlUZkNHTDLO4Aq/9L
	 JKrMywIZftVkW9jUVJoaaAyUKiXNX5SSnykv6yT//5yTdcPLrdvxTvw6hWbA31xtxm
	 Xm+2wJ1FaFxG8dkCs/oiNg6J8cR6dHjAeyihgONLEZarwYmSNSIe3jAFAnDljcGUlk
	 PVPgD0Lz7EsEA==
Date: Mon, 3 Aug 2026 21:10:26 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, kys@microsoft.com, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    linux-input@vger.kernel.org, linux-hyperv@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: hyperv: bound initial device info descriptor
In-Reply-To: <20260710022854.3739558-1-michael.bommarito@gmail.com>
Message-ID: <23o67n97-nro8-37q3-3843-pnqr434n60n2@xreary.bet>
References: <20260710022854.3739558-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 Jul 2026, Michael Bommarito wrote:

> A malicious Hyper-V host or backend can crash a guest with a short
> SYNTH_HID_INITIAL_DEVICE_INFO message. mousevsc_on_receive_device_info()
> trusts the HID descriptor bLength and wDescriptorLength without checking
> that the received VMBus packet actually contains both byte ranges, so a
> truncated packet with an oversized report-descriptor length makes the
> guest read past the received packet while copying the descriptor. This
> matters most for a confidential guest, where the host is outside the trust
> boundary.

Well, untrusted host can crash the (confidential) guest in various other 
ways.

Anyway, the sanitization is good, so I've now applied it.

Thanks,

-- 
Jiri Kosina
SUSE Labs

