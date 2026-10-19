Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437517;
	b=LG4+8LZ7iuXdj9tc6EERg/yr75EjpY0DAreYrobjKIggPJvJl0zB1FNaFl0bVshneLxz
	 f1CEhg7urk6QS+ZYUtH0Lo9Jh8TP7VFel4ldG8iVEQ1FivwUT7jHkZ16nVnVRX/zcZL1q
	 k7aNtuhgMuOeLhR0lGsfV1Slrj9nNzFLikB+AarHAtwVBHJcSBbk27Bja95ZNH+gL84z6
	 mIgzpQrPxBwel2K6NpjejCW/EarekaXgXJqouEQq25kG4igWl9mjikWOar97Ufc6xwSQh
	 B81mV55FV/bdjPBuL4DXsr3HxuqCbtGgfV0Cc5tWck2bFJpcmooccl8PAUcVhgH4Jeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437517;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zjkMNRHMwq20keQ1Gem4ms+JYBGpvhrMAhk6qlMwcwI=;
	b=HXyfd7n8MJdsxj8qd4kadeyQ+LrQzy8s18D308v/osvOJ5LeEvDDjGFBuyl0MKF0cq98
	 T3vD/7xuF8lxffYuTjhMR7e7mDqw/KD218UfhUCTs0zA+ngpu2+sxtzZZ+3d8tKnGpK5T
	 Xecy1K8h9S+v95OZdarRCKteYSMYcRMCVOVLixiYMJf6/z9GdPHlSWbyhikNUmcg9o+no
	 onPWzBrf7JqnKa4QKzIPCe/TYfXDF3lWVa9CVElDgnCFLoyk9aKkskM9wLt0Kmx7yIiwV
	 kNokQDvQ29wBJDysBat6HFC20RTwueqrjoaLmbkXegK9PP9JPH8cluxMlugkkQp97CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F2606A31F;
	Mon, 19 Oct 2026 19:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 592F2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Nerijus =?utf-8?B?QmVuZMW+acWrbmFz?= <nerijus.bendziunas@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "John W .
 Linville" <linville@tuxdriver.com>, Simon Wunderlich
 <sw@simonwunderlich.de>, Oleksij Rempel <linux@rempel-privat.de>, Kalle
 Valo <kvalo@kernel.org>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH ath-next v4 3/8] wifi: ath9k_htc: refuse a command that
 fills whole USB packets
In-Reply-To: <20260916173429.403889-4-nerijus.bendziunas@gmail.com>
References: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
 <20260916173429.403889-4-nerijus.bendziunas@gmail.com>
Date: Mon, 19 Oct 2026 21:18:34 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <877bjdwlbp.fsf@toke.dk>
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

Nerijus Bend=C5=BEi=C5=ABnas <nerijus.bendziunas@gmail.com> writes:

> The firmware ends a command on the interrupt OUT endpoint only on a
> short packet, so a command whose length is a multiple of the packet
> size is never delivered and the device stops answering WMI. The
> previous patch removes the one such command; nothing prevents the next.
>
> Refuse such a command in hif_usb_send_regout(), where the packet size
> is known, with a warning.
>
> Assisted-by: LLM
> Signed-off-by: Nerijus Bend=C5=BEi=C5=ABnas <nerijus.bendziunas@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
