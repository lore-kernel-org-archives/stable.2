Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177520;
	b=0XTUKb8ADro14nY1mHMn+kwL+S0vwspcwIsS7FF0z8gBUnRYA4RvsDSTTFtoE/tQAS4v
	 JbDMQYVfgfkIONjIklQmQW3mAQUHImbHQxcSJUka34lPnuV0UPi5rF79E1UudHdpTG4Rq
	 VVht8r3+dLL9tSivUfszCyC2bZFM/yneeRQ3dEy6QFMbgVsAQaOhHtCh9g34gBbv6aGwo
	 iSTiX8/Qi3DcjTZQUDw4ZL6RHoJc7bZ7g9bRe+xmCiTXVs1glhfTkoLPAFc5iZDeWxX4r
	 4gxr03/KzUm1jjwHUg7/JkYXw7tA/xEm7UEaK7Tpxlq58Vd6gR7/V5GDQmAvZXLIIkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177520;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8q9/TMmLVp1fSuWDi6PaMbIvtn4/2YX12Iruh/57dQs=;
	b=2msqupHEPc05qHQ48rg8KRJtaB7P7CoUNUM6KpTWEq4kf98kVu0NAKkE9yFTJWPZxswe
	 nIz+jZlawgHQi6V6VceufKtfk7HmKXO22eo7hcdgLFzpPFIT/pIZHJucz0KkM+AgLN1g9
	 l/2XzV1/hI0AWfemFZel3cp1h2jmbg99NpnxAbPBn7tCbU0o+XOxPrpD9XkzuY7SZwVzX
	 YF4e+Xl10TcC8IssRC93y56LWEEQdAhzLMmFYSCzQ541oAUJ3yH651twgEXhT7YSKFJSX
	 PvwOvFsIAQiqGC44mmtCANJEnl0E9Cg1qFHnxpOpGX1UngCG6WlNoxsDZIn12Jy/g0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=U5OcW6xd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1080606A320;
	Fri, 20 Nov 2026 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=U5OcW6xd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5EA1F000C6;
	Fri, 20 Nov 2026 12:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795177519;
	bh=8q9/TMmLVp1fSuWDi6PaMbIvtn4/2YX12Iruh/57dQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U5OcW6xdu/HCWTM9/0b/zElK1hYihCStgMLaSefb3VM57bezMv+Lz7k35MI4bWECw
	 LHA+D/JN0QZgV6Wp8tYwJObrGLdS4ayiZhLXvmsa/Z3jPGYH8NuLRQg57QC7Cll4aP
	 7lY4XcVq0HpmhBsE1w0c+YDZMpjMBY56JXm+0Tgg=
Date: Fri, 20 Nov 2026 13:25:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] usb: mtu3: don't run gadget completion callbacks
 with interrupts disabled
Message-ID: <2026112008-gown-cloud-258c@gregkh>
References: <20260929-usb-mtu3-gadget-completion-callback-fix-v1-1-8b75b48fab96@gmail.com>
 <b0c42b21-6b28-49fd-ac07-7af1456de4b9@gmail.com>
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
In-Reply-To: <b0c42b21-6b28-49fd-ac07-7af1456de4b9@gmail.com>

On Sun, Nov 01, 2026 at 09:45:16PM -0600, Ryan Brue wrote:
> Hi Greg,
> 
> Gentle ping on this one too. Similarly has had no comments since the resend
> on the 29th of September.
> 
> It fixes the softirq WARN in the commit message, which any gadget function
> that reaches netif_rx() (u_ether in this case) hits on mtu3.

I see no context here :(
