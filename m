Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A03223C503
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589884; cv=none; b=gsH+T894obi9tqTOKzq7BY/mtpdzhxAAtx283qGYfLnl90JXULU5/msLaOUcICg3SJ+zSvur4vIqP334MYmnGhfBNRYr0enQFNM4I8Z0BbXWmY39uXAO97Vs0fZe1ViGdF0tMWOvvKirl98uUIZc9r2NG70c7V6aIZZRM7U5e0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589884; c=relaxed/simple;
	bh=eO9Qi2Cm2TNPt5aydFXh9P/dOOrSYAofeQj5U5prHKs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eU7xfvq4H1cb9R+71h99d4r/IP7D6HCfTY1aU4EQYXHpSmw54bwvvDv5TOZbLuS+6UlwEAfm7ufZSrChCK5N/OjUPtFvfSMPN4nSovlXFj6LqCSDIBNdlsXK/g5sSvxenrg8T/XtO0JhCvUxPRZSR4Kb0BEmJetuEZkQSpMaJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=Vp1kqCzg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S5EPSVHZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="Vp1kqCzg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S5EPSVHZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 771CAEC01B4;
	Thu,  4 Jun 2026 12:18:01 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Thu, 04 Jun 2026 12:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780589881;
	 x=1780676281; bh=Jk/ejdTUG3fUT9bWQptHorSCz30HaRUThr+lwxTvrCo=; b=
	Vp1kqCzgtQV5mwqHsTCeTcNnFb3uLte5tsQaRrazcdlLfKZwktK0Gh0Of9M5GF8o
	OTlqKg+9F7VMWeEr6T0JOq4lpmDjhGQhSH3hi5wd/UQpiIUE1kbVDORR3DiP2z1+
	ovVvyV2+LwpvX2czIStE7OZ+eE+Ead6Iv2KjdccHpk/FhHyBiJN97wb8BfUcy3UW
	FSFboyzs+adWKhRhPL6V+JYFi9ZDJsz4O+P7zjaXS1JZdIb+UiZn7DBAMiK/KmzH
	Obo/VdsBBkzN/XAj3RemCLrw2DKPKGtCD+2yqgemzeopWhYgGyaOI+v8JnJM9hq4
	EGoWE5rwXuhzOYbGxe36kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780589881; x=
	1780676281; bh=Jk/ejdTUG3fUT9bWQptHorSCz30HaRUThr+lwxTvrCo=; b=S
	5EPSVHZ7OKRSWg4aYnaLqYZxoEIBa4pLJ9OjfVW8D9lQYddto4M8pDXvQgo36CGE
	IuIi6hnNfuYkB3krjjjCc87b8/vTWKtUfObocVAldqnvyZ+a5NuE2nzjDyXUREGj
	S5o/tUcCHwWMDTUIs/GRAroLYCXXs9f8qLHwRi9heFyaT8nhevLvORzSiKRDlj+p
	ArXaPhqqZkgzSy5oQph27KUzTayQTqvkRxuGhzPn0HMbH98IT8aXFK6WuXG+7nlL
	LAkiy3yq04NFzP46Y3UZqtuGS/pjlpaN3SoGixO8Ouc4lCUq4NyVnedD4pKU7hMc
	oh/cGcA+PKdEC7UqACndQ==
X-ME-Sender: <xms:OaUhaphD5pbEWJSBtVmkH52jmd7mcRICn9-6t-_n29bdO9BL-ejEYg>
    <xme:OaUhao0rdBwU4daTOElDtjAJ1lDr7Y-elvzHektUN3w9SCrUpUbVU6DZsjn1aPu14
    DbBM_irnS2DahGmdQeZT09RqSPq6EzHmchu4b_jMJzdndMASjg56hw>
X-ME-Proxy-Cause: dmFkZTEq8jR2O0KN3mzl0D2IhxIIn9fZMsNA880ILYO6LhmUlqTmsvtXYXXXUMIyvLxhgi
    ejfGlhp5uQNTwUbKd4gBRMTUlpo2rFuXKMxds71/jK03yo5DS6ME1plDHtC/9PwHEf9u8B
    AN8BY2Hs7lzQNu0CCj7ubCHq3Jovbve1Cr9eNIY/Nce7rz7gklq04cuSE80+tkVu3Xal27
    h460m5IULe7FRllFkQQTKa6unyZMq7v3xZciV+/nZ/gmQfTaIJ2j7hmInSXyy/AnGToZAB
    TPTBOa95OP5H/McdM9WqS0VvBKLBdmu8fG2iJ0VJtbUacER+TYPMTKwi1ixTwIIY7kV1Rw
    79rltZpeSB81gwwQdw+9Cm93nHFoGFtXf0Ih2J057Dzkjb29F39IDBKTCOgTcb7vu0brST
    7AYAoqjNVgklZNcNZ36SRuD44WvRVJ0vPOoNc4ZSp8Hu53FMfCmy6eKO7MrB6LESk38ei7
    6fnrQ7ynzSeGW86K0118W7Q+P8TsazkX2Y+3wleWm0QRWmBhGeHW6JB1mtyo0NtUsTZMsF
    i7OVjmBhk8lPiTmRd+lQp6TI4GR2UnVbaccMMte7hqnV0e2rx0L0Fns56oweMQK8rd0GqV
    TG5K5BxwcTm/ygiT5+YJOowcxzpTO027GlUbQypwDVy6s1469C0zKajAceiw
X-ME-Proxy: <xmx:OaUhai-6c_ev44AF9jwTNedyvoINBimdSZZ5bkKncaEsZ-s8bHOGeg>
    <xmx:OaUhaqcDq6PunW5_5KjF-CtZyFEcOArPJX-e7tuxvfEwPmy81p8UAQ>
    <xmx:OaUharETbu-EfyhxlZU9O6Pb9QmWyE1XxMBClgyD3IimX9LOyC2Jpg>
    <xmx:OaUhaofpTIclMrZK4RCY51kNUCxo5Tovc7zY67Jm-mG1VjPaIq24Nw>
    <xmx:OaUharP4VRr0awYbMx-4FbtgclG0wsb3OkKPrfRgjiQvLApL8LyfQvRz>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3F0D6216008A; Thu,  4 Jun 2026 12:18:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGEhOIfceYI-
Date: Thu, 04 Jun 2026 12:17:25 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Sasha Levin" <sashal@kernel.org>
Cc: "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>,
 stable@vger.kernel.org
Message-Id: <44dc3931-4863-4291-a239-30cc9405744c@app.fastmail.com>
In-Reply-To: <20260604134538.3463737-2-sashal@kernel.org>
References: <2026060410-arousal-fasting-6cae@gregkh>
 <20260604134538.3463737-1-sashal@kernel.org>
 <20260604134538.3463737-2-sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 2/2] Bluetooth: L2CAP: use chan timer to close channels in
 cleanup_listen()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Sasha,

On Thu, Jun 4, 2026, at 9:45 AM, Sasha Levin wrote:
> From: Siwei Zhang <oss@fourdim.xyz>
>
> [ Upstream commit 8c8e620467a7b51562dbcefbd1f09f288d7d710d ]
>
> l2cap_chan_close() removes the channel from conn->chan_l, which
> must be done under conn->lock.  cleanup_listen() runs under the
> parent sk_lock, so acquiring conn->lock would invert the
> established conn->lock -> chan->lock -> sk_lock order.
>
> Instead of calling l2cap_chan_close() directly, schedule
> l2cap_chan_timeout with delay 0 to close the channel
> asynchronously.  The timeout handler already acquires conn->lock
> and chan->lock in the correct order.
>
> The timer is only armed when chan->conn is still set: if it is
> already NULL, l2cap_conn_del() has already processed this channel
> (l2cap_chan_del + l2cap_sock_teardown_cb + l2cap_sock_close_cb),
> so there is nothing left to do.  If l2cap_conn_del() races in
> after the timer is armed, __clear_chan_timer() inside
> l2cap_chan_del() cancels it; if the timer has already fired, the
> handler returns harmlessly because chan->conn was cleared.
>
> Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
> Cc: <stable@vger.kernel.org> # 0b58004: Bluetooth: fix UAF in 
> l2cap_sock_cleanup_listen() vs l2cap_conn_del()
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/bluetooth/l2cap_sock.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 634ee15cb71558..db8a90fec98e9d 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1456,6 +1456,10 @@ static void l2cap_sock_cleanup_listen(struct 
> sock *parent)
>  	 * pin it (hold_unless_zero() additionally skips a chan already past
>  	 * its last reference).  We then drop the sk lock before taking
>  	 * chan->lock, so sk and chan locks are never held together.
> +	 *
> +	 * Since we cannot call l2cap_chan_close() without conn->lock,
> +	 * schedule l2cap_chan_timeout to close the channel; it already
> +	 * acquires conn->lock -> chan->lock in the correct order.
>  	 */
>  	while ((sk = bt_accept_dequeue(parent, NULL))) {
>  		struct l2cap_chan *chan;
> @@ -1473,14 +1477,12 @@ static void l2cap_sock_cleanup_listen(struct 
> sock *parent)
>  		       state_to_string(chan->state));
> 
>  		l2cap_chan_lock(chan);
> -		__clear_chan_timer(chan);
> -		l2cap_chan_close(chan, ECONNRESET);
> -		/* l2cap_conn_del() may already have killed this socket
> -		 * (it sets SOCK_DEAD); skip the duplicate to avoid a
> -		 * double sock_put()/l2cap_chan_put().
> +		/* Since we cannot call l2cap_chan_close() without
> +		 * conn->lock, schedule its timer to trigger the close
> +		 * and cleanup of this channel.
>  		 */
> -		if (!sock_flag(sk, SOCK_DEAD))
> -			l2cap_sock_kill(sk);
> +		if (chan->conn)
> +			__set_chan_timer(chan, 0);
>  		l2cap_chan_unlock(chan);
> 
>  		l2cap_chan_put(chan);
> -- 
> 2.53.0

Thank you for doing these for me.

Best,
Siwei
