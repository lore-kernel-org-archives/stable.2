Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793811190;
	b=PmnCydnmEPAZmIfDlfrylvjlJaZNIJaSfJV/yTiwySmWVXsFr/qt4of2uFEHAZ5C/XSu
	 83U+jJ4QKk3Y3XjmmdQ5igDzfyyphNm30W3LsQ3D5LtF2fTEM+S2/FkjEUYYOORP2ag3q
	 ducloRx5Qip8+dvGSWZtMoXb1OIi2/uUI2kMN9wRLefgtCNIV/nfRCdsc0fNyP+TUf6Zp
	 KKWW3c4G/CDkNrVBFLPC/B/qC0Fg6PdMAMT0EFSVm2fZeeqecRVmeOGRFjcp6LJMu54VS
	 WoIbmrQ5K51Jt4M9Q2+9iIslY5Wwz3+pl4emwg0d80TKCw6Y1lUP09irufqjEfrCaDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811190;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=THYlU6dsxV8ed96P6OJPtEWq8tUs/nV5roX8ImFt+iY=;
	b=nigzYsvyrBOSYa3zXJEA9YkQjqSbXLoT3dsP4qlRGYeHCFPoKye+AIKe1DdaZAZNaTmO
	 Gqr9y1p+DafRRT8YI1Q1i77eKE+gph/cTN0o8ZTvO86TZGBFnmOMSL3Bab+0iNBM8ZooO
	 8N6g06ayroyHP9Mw/AQlWyZNv+3zef1yNwi+FvsbVJkJUlaeBVk+eIoxF35KPHz2KkVyc
	 cnckJn5ay9HVtngP/YwhmUpIG92EF8hDaAJUmFBqH12UY+V0v2kH2uRhL+U0Y8DoNJ6AK
	 +DtnAcKflK2HAgDXL3ZdOlH2QpXB+wE+Wu+VY2q5KOgn9e0QS4qD3XcKFJVuJoXwtSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=BIvjAjm5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.165
Received: from mail-200165.simplelogin.co (mail-200165.simplelogin.co [176.119.200.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5E606D805
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEA5E606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=BIvjAjm5
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793811188;
	cv=none; b=ewuAxjZP90EU4HaVoeuP3GWYoej2tgPTl6yWF7swF1B9Mve65vFJo+9kIp/acjRehFdBryyj3ZX62Owhm0CHL5m06vTVXI3Fl5R1v8tHKnIC+KEPXaLxzCKnVUhrmzg7TS0IjIgpzyM8ej/AdMffMtGDoEWoaQcVtyx2BdRH0QndS6L5gZbOmCSJW6BBPNWSSY5sHltEeccnoO369KsTp7R1K3Gx6ddFmYG8paLkeQ2003a4zfCniLGQm3CTKproSIRilYgkDvXXUY2mutEDK1VWabA100digYscU1Inyjnw5ON9z8PiVlW458z5Lj0S/Z7+KuCfpHH2AyhHrtjuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793811188; c=relaxed/simple;
	bh=b22BmvbWIYRK51tJiOsPu3kTH0mAG+T8cRcAHNYNM48=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=xEqLzWK2kckZgKHjGSIjZhmIh2T915A89KQOC6R0b8qZTM5kQYWoUanmaXeIptHmMNZrCIu9N37ZdvD72k7piLeay+NLjFMI9vRRgyvsO1Rgf3f0wS2jKOkHRqd+lst7NRgctYpLstbhFCq59CRlfvYj4lX5qYgNDViKSllN1hs9xFqC0xf1aNBtoC44sjcr0eRSILUXi9ljsGs9S+fMNFWpqt+xbUPgHF8IYGzj6ycEUtAj2XDL7AY4s3XQLqfl5wT8fLfFumvQEphZZBaCV/RWGpqy9t0KZrZQUutjO18lf7Q7YMhgM6oejms5/AP8QzhnwB6D9osjwuaHSDq6wQ==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1793811187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THYlU6dsxV8ed96P6OJPtEWq8tUs/nV5roX8ImFt+iY=;
	b=BIvjAjm5TRTO61GsOBpZh8JyEhMHRyp2ciJjRUsqrPmbrSppaR0sMWhwKWAEXDG9SQ3WbG
	pLzwuv43YJd5ISH48y5Dh7JmSHF9GAFWgtTuZI7oPrsSFxxaCQHe7FztKNejlPJVgpeq4Q
	XDisBlPe4pE7SmfmSFz2NcV1Az4/GnE=
Date: Wed, 04 Nov 2026 16:52:59 +0000
Subject: Re: [PATCH net v3 2/2] vsock/bpf: fix zero-length,
 MSG_OOB and MSG_ERRQUEUE reads in recvmsg
In-Reply-To: <auSngVsWiGI475J4@sgarzare-redhat>
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
From: jrmmhm.kernel@eldare.de
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,"David S. Miller"
 <davem@davemloft.net>,Eric Dumazet <edumazet@kernel.org>,Jakub Kicinski
 <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,Simon Horman
 <horms@kernel.org>,"Michael S. Tsirkin" <mst@redhat.com>,Michal Luczaj
 <mhal@rbox.co>,virtualization@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179381118562.7.1635260105890086879.1746288140@eldare.de>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
 <20261028-kbh3-1-022-fix-v2-v3-2-bc0752b2d3db@eldare.de>
 <auSngVsWiGI475J4@sgarzare-redhat>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1746288190
X-SimpleLogin-Want-Signing: yes

On Fri, Oct 30, 2026 at 03:25:26PM +0100, Stefano Garzarella wrote:
> Ditto.

Same as for 1/2, I'll rewrite it.

> >+    if (unlikely(flags & MSG_ERRQUEUE))
> >+            return __vsock_recvmsg(sk, msg, len, flags);
>
> If the psock ingress queue is not empty, wouldn't recvmsg(MSG_ERRQUEUE)
> (e.g. a MSG_ZEROCOPY user reading completions) also consume stream bytes
> through sk_msg_recvmsg(), since it only looks at MSG_PEEK? If so, maybe
> worth mentioning in the commit message.

Yes, when the read passes a buffer. I reproduced it: without this patch
a 1-byte MSG_ERRQUEUE read with stream data in the psock ingress queue
returns that byte. A zero-length read, as MSG_ZEROCOPY users do, takes
none, but never reaches the error queue either: it gets -EAGAIN instead
of the completion. Routing MSG_ERRQUEUE first fixes both; I'll mention
it in the message.

> >+    if (flags & MSG_OOB)
> >+            return -EOPNOTSUPP;
> >+
> >+    if (!len)
> >+            return 0;
>
> Is the order of the checks important? We should mention it in the commit
> description (if it's important or not and why).

Yes. MSG_ERRQUEUE must come first, or a zero-length error-queue read
returns 0. MSG_OOB goes before len =3D=3D 0 so that recv(fd, buf, 0, MSG_OO=
B)
returns -EOPNOTSUPP as in the native path on a connected socket. I'll say
so in the message.

Thanks,
Jerome

