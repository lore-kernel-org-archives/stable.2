Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40101375ABE;
	Thu, 25 Jun 2026 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782351745; cv=none; b=nppHn94SPVLGaGndy7JokFwdK4xiXWDFQwgnfuOKwsYz0nhCRLXvTiMEbVl2SzYpS780opnvagHswVSkTkSXlBT1GBz1IhEqPaDvzjiNSejshpIF7sErhad2HtwSB7o2R850s/JneB//fVpQAdNhvQW9XWlSh6RQjn5H5+WKcT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782351745; c=relaxed/simple;
	bh=XiSoS7kYjmSVTdF34rIAD/vbcoDiwLTje/ChX+DqAgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIhrJEZCWYPs2K5bUkaSrYoBirzmvdMdRknuBceleLbcqfGmmI/aWdNSwQ/fZdYO36xmf4iR7M92SPc64SqEYgcCSUiCBMfpzNGNmP473Ir5aA+M9Ivm1ATkBH9QRAjbf7yichd3EDHn6h6KToHRw9v23gH3n+sWlPxGMNEpx2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ae9x9g3E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ae9x9g3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37281F000E9;
	Thu, 25 Jun 2026 01:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782351744;
	bh=clTP1phHGX7USBYmYvhozxQUb7aSy62Sp83hMpW68/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ae9x9g3EL8xnCvPR/S/6UUr9nONNs4bnxjBMp1VYovXq81pGwqn0L+3t0mMgTkqNt
	 joLjfOLRKz9a4LD+4QRax6NcL0YVl8ZaifbeZDvCPVVBgRYMYf3byJpKM7YXyp8SBn
	 9Efslk9xMohTUNpmAQAhdykI24mS7AWfbWNTDbIS/ozzntDtchyGt6uSf2rBPM6GYH
	 icVWyXzBbXW0sTQS+uVqKFzW5OsN9wEGKoI3jANrL9s+uGI4nJSrvjBoRoT5vJedhF
	 FVkhQ6uKv313Wddw7BbyEkYYL+mS6LKyfUqvqqRvc2OlplTVU2AJcLpT+ey/qcjles
	 rtSBrhXMEboPA==
From: Jakub Kicinski <kuba@kernel.org>
To: maoyixie.tju@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: wwan: iosm: bound device offsets in the MUX downlink decoder
Date: Wed, 24 Jun 2026 18:42:21 -0700
Message-ID: <20260625014222.2976678-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <178196118045.462404.11069139160448641355@maoyixie.com>
References: <178196118045.462404.11069139160448641355@maoyixie.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wwan: iosm: bound device offsets in the MUX downlink decoder

This patch validates device-supplied offsets and lengths in
mux_dl_adb_decode() and mux_dl_process_dg() against skb->len so that a
modem reporting an index or length past the downlink buffer cannot make
the decoder read out of bounds. The block header, each table header,
the datagram table, and each datagram index and length are now bounded
against skb->len.

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> index bff46f7ca59f..ff9a4bc52f29 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c

[ ... ]

> @@ -606,6 +612,11 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
>  
>  	/* Loop through mixed session tables. */
>  	while (adth_index) {
> +		/* The table header must lie within the received skb. */
> +		if (adth_index < sizeof(struct mux_adbh) ||
> +		    adth_index > skb->len - sizeof(struct mux_adth))
> +			goto adb_decode_err;
> +
>  		/* Get the reference to the table header. */
>  		adth = (struct mux_adth *)(block + adth_index);

[High]
The commit message frames the threat model as "A modem that reports an
index or a length past the downlink buffer", and this patch bounds every
device offset against skb->len. Could the same threat model also produce
an infinite loop in this while (adth_index) loop?

The loop continues as long as adth_index is non-zero, and each iteration
sets:

    adth_index = le32_to_cpu(adth->next_table_index);

The new bounds check only requires that adth_index lies within
[sizeof(struct mux_adbh), skb->len - sizeof(struct mux_adth)]. It does
not require forward progress. Can a modem stage two valid struct mux_adth
headers inside one downlink skb (each with the IOSM_AGGR_MUX_SIG_ADTH
signature, a valid if_id, and table_length >= sizeof(struct mux_adth))
where table A's next_table_index points to table B and table B's
next_table_index points back to table A?

Each adth_index passes the new range check, so the loop never terminates.
mux_dl_adb_decode() runs in softirq context via:

    ipc_task_queue_handler()
      ipc_imem_tq_irq_cb()
        ipc_imem_handle_irq()
          ipc_imem_dl_pipe_process()
            ipc_imem_dl_skb_process()
              ipc_mux_dl_decode()
                mux_dl_adb_decode()

If the cycled tables also reference valid datagrams, each pass through
the loop calls mux_dl_process_dg() -> ipc_mux_net_receive() which does
skb_clone() per datagram, so the same skb produces unbounded clones for
as long as the loop runs.

This is not a regression introduced by this patch — the cycle was
reachable before — but since the patch is hardening the decoder against
modem-supplied offsets, would it make sense to also require strictly
increasing next_table_index, cap the iteration count, or otherwise
guarantee forward progress in the same change?

> @@ -629,6 +640,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
>  		if (le16_to_cpu(adth->table_length) < sizeof(struct mux_adth))
>  			goto adb_decode_err;
>  
> +		/* The whole datagram table must fit in the received skb. */
> +		if (le16_to_cpu(adth->table_length) > skb->len - adth_index)
> +			goto adb_decode_err;
> +
>  		/* Calculate the number of datagrams. */
>  		nr_of_dg = (le16_to_cpu(adth->table_length) -
>  					sizeof(struct mux_adth)) /
-- 
pw-bot: cr
