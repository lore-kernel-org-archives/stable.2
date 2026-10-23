Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785792;
	b=oOJJ+ndhXf/6o9ML8vXqhWMqRWIqAisM4b3+3k4fJyvGJ8jMP4J/8CXnbdHi47tLw4sq
	 vYJ0b3pWLaqeDJfdm1gssnrvI/FLyV3aUuZt9RbQCy4qc/lnRtkhS8SaRWmQeZMkBQPZH
	 8+JJ1sZBZNvt+0WhhPrBLebRtli83D3VediTLpbrM3kAb/3MuL1oa7acDMXC4vfgiMWHG
	 hrWf6UpGtUbALHE4pCWxRf/hNsVnpbrIVrTKDS070s8+a5B2SLFzOqEXkuV9kbcoPl0bN
	 WoBPF4rnkOAZxmz1Ik4DzMbL/qoTsiVxD8bfoGEZjoVfuuNFv9y1jHeb4XgPUbZcV/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785792;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ELXFG3+sBYtCERcY6VQwRQTnFWN8KaMY8NkiG7aKN78=;
	b=rR1E8hcqellFZDsNgsCEK40e8inMnlAPnx5GkADP24yJrLw4Jt+mpj5YfsnJykD/g3zf
	 +Nzcz4hbKI6NzUWmBYSIEp3JxdnTp9I0mb2USnYr/yyTHJqxCNl61NmxXu/h9ZBm9E0ZC
	 e+pfq49I/7Hkx20lYyMg0an2/alCQerfxRsT3e+IZollahfMotKvsyByYwf3U1OPVU7YI
	 cctSf7pXwn6aYmTNU+V4KdRF5EIuMhKdS4Dup8wgXjou8jXe16ffWvdBzvNr4Sw9iZ1H/
	 yuJ5qmOttX1HLpTi19oPSMmGAgTN5gZLGuh/neMuISan2Mls3oSvfWPe1chJtfOA6rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKGQWq3A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99846606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKGQWq3A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894CF1F031E1;
	Fri, 23 Oct 2026 20:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785792;
	bh=ELXFG3+sBYtCERcY6VQwRQTnFWN8KaMY8NkiG7aKN78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TKGQWq3ANf7tmc+IquC5riZuvIsMof/Lzi/YfZ2ksnZetUq2iahLYD/9KpkbrTW1H
	 mbVBUJy+2THmJ9CYQ/XRNS2w6p7GUJKMLtJ7PSLNNXaz891vezSPmViiIWIWkxYx2v
	 qwCH0A6qmZup9tv+UwqTPwCHskfuEOEC+mBnJ8mRAf48Qrm0MkYKLQ3Xo1SqM9ODjE
	 AfRNODtSf/cNSyGHKwVEl9sAAv9XuwOwe1eLCnVK4OTLCrtD5u2YG78mb+QQXk0U16
	 kFNxchOuw2DlEAmu1LkCcVt0UXgu/72ztdDCp3qN40rtUG7buTVX3KfJklQxsyAzdh
	 fvi7vk5ytwL1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.10.y] net/iucv: fix the recvmsg window update
Date: Fri, 23 Oct 2026 16:02:50 -0400
Message-ID: <2026-10-23-1-daily-reply-0014-iucv-recvmsg-window-5-10-bounce@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022130935.1228149-1-wintera@linux.ibm.com>
References: <20261022130935.1228149-1-wintera@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> +	/* Claim the receive credit here, not while building the header: every
> +	 * way this frame can be dropped has now been ruled out, so the window
> +	 * is zeroed only for as long as the transmit itself takes.
> +	 */
> +	if (flags == AF_IUCV_FLAG_WIN || !flags) {
> +		confirm_recv = atomic_xchg(&iucv->msg_recv, 0);
> +		phs_hdr->window = confirm_recv;
> +		if (confirm_recv)
> +			phs_hdr->flags = phs_hdr->flags | AF_IUCV_FLAG_WIN;
> +	}
>  	__skb_header_release(skb);
>  	nskb = skb_clone(skb, GFP_ATOMIC);
>  	if (!nskb) {

5.10 still clones the skb in afiucv_hs_send() (it has no skbs_in_xmit
rework), so this claim runs ahead of a remaining drop path. If
skb_clone() fails we take err_free and the credit swapped out of msg_recv
is never returned, so the peer's window credit is lost for good. This also
hits the sendmsg path (flags == 0). Unpatched 5.10 loses nothing there,
and the comment about every drop path being ruled out is not true on 5.10.

-- 
Thanks,
Sasha
