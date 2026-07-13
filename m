Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8623E358
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783977361; cv=none; b=hwNbpKBkE9E6Z7jTQZY1YpOCLTiGFm/H/ZmYkSPSLyZRjKMCncQntJniXbTGNaoJKWmjyPs+R7qvwzFCg3khGPh/NfI13WWgi8TVTqSNM8wz1c26ygHyAEtRfui8sW0oBM5mknXYpCxeRVWnFXWpDZSZJFoZVLLncL/3+cdqLOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783977361; c=relaxed/simple;
	bh=OjupI1J8Uf6ZmRz+nFaqT/63B4bo16S2X+GqHuBV27E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PADueCtPS5MTp7poa8HeAUFyreYlJ5Dh44P/cni1VzPErHPElc7p+Jo0wCqM/gHF+qFR1uXQpWbGsCbBk8Dxm/7qxzRgkMy2Tc/aacHxO4M9t8cB4WP6F5wIuhQnIg2nnJkpKRHy3BjMTCLpescei7DaidL2xs/gH3bLDqP88gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do7EiwmZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do7EiwmZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493f140ca8eso22418365e9.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783977359; x=1784582159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2wQJEgASjgsy4yDd4CAOFiJYx60jS5AQH+okUrcyglg=;
        b=Do7EiwmZjZewBwE5xIaH16fPw5ti35pFMVzdFswhPRtuCuRgMmzQj/bcYHXi88RJey
         EkIff1FRN+EUdwI3KFX7a5qnq3/ou+PP3tv1nRH7pcqcOmtWVo2YYU7g4sD5ahVvbXyP
         yQkVufcyd8z5A76iPwg03lwqM+p8QNzKkMH+vk7E8OR1DJamSHuDQTzaW/IPJfe142Y9
         HG9rylTBXOxomReUX2BXVK/rnhs6WPHoaGYAo4sqfLjW+SOC0/RszY81sM5RpS25FEKu
         P9h5phXcT+qDgw4Ju7Vil+2M5mUdFyn+LiAAUjRnkidokAgo6LAz72swbQKZM1Go3FBz
         CcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783977359; x=1784582159;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wQJEgASjgsy4yDd4CAOFiJYx60jS5AQH+okUrcyglg=;
        b=OPBAzGGh/69fhLFZ8L0sT2odpJB+wXuDjm3iyViN9a1jWN3JbPJnm+816zlj3c1Eu2
         RMs+TTi4nTXyoNGB6TqLeRE+Wl0FHVjeGjnlRafGUHHH12Ha0GkD0EtAPJzapzKCbqoA
         Co/ZJOi6YwylY6OGsSxpT5WHi7gi0XrPQrqhIsoxg2NKaTnb8/GUb1Z1u7knWTaUm1p0
         dECa6KjNYHzGaE2Ojjv7Ei57VGY9fURj3Q87NoeE0XYdlSCoKanC3Gl404h7ORCJT3+I
         T5nnAALems5JwFkVvh9QdiTl+jtZn9YClml7b1bxY5rYnoinbnbZLxrEO7V+sZnCsBXX
         c8dw==
X-Forwarded-Encrypted: i=1; AHgh+RqIDitHEnfQ1Xowy4/1Cok3eh5QGbZlw08DGaBzKbusP8Sj9zvnf8Vdp3Iexiyn7bx2/JmcV+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdG02vis+rT08ef3gotIlUuY07S8Qy6RqhR7JSgvka7xzS0X0O
	+p4Jop+Evz3gmgMt6P+wq8RE9o4T86CpmLJPKtTGGzc2i4erN2x3yloG
X-Gm-Gg: AfdE7ckkULzRBuVHWHrOFwUm/FoB3LxRAQ3xFXSVGPLHaClCOuhgJ2pqdadxVrjVE6u
	mE5QKtiIiOp5sfjxx5FiucedRx67Y/bWq/+nqo4yXnE92lT08p2F1T3/6NDt4MqnmUDu+jWAT6Q
	Xn169k5SnIMB69kwl4dvmQWNQ2CLrajCIcO7W+ZGjtOnw/WKkZgxMNiTUFiNmaP94VyH0qt9a4m
	fHxnpUgGZRb6bT6X3zPRM5z1k2a1gHbBXIZ3ygbjSEQStWUR8kbAbghwR9rrKMUVaX0ziL273DC
	N/6nJ5rMB9g/cjmPiEqYXBdeM3z06fdcNH1b2C1XwxDGAYidIKQGCeeLy2zdhJfRlgqTvWR9rol
	sHh73x2Apns/r4RHICfb2C6gnuf9hGjMCLbDrPpktnfzt04CQDYKOzkw4tPSnSW50Hm54+/QskV
	LJRlYsfvBWtHMw0/QYRE2ylkyGXkhTfOD8Wd7SRVIrFubMkgrXPUqNwjmcHS1V
X-Received: by 2002:a05:600c:464a:b0:492:7083:e5a with SMTP id 5b1f17b1804b1-493f882b117mr72487425e9.31.1783977358718;
        Mon, 13 Jul 2026 14:15:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f462e0cb2sm2500839f8f.0.2026.07.13.14.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:15:58 -0700 (PDT)
Date: Mon, 13 Jul 2026 22:15:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: david@ixit.cz, vadim.fedorenko@linux.dev, horms@kernel.org,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: llcp: reject PDUs shorter than the LLCP
 header
Message-ID: <20260713221556.13a830b8@pumpkin>
In-Reply-To: <20260713155848.55530-1-doruk@0sec.ai>
References: <20260713155848.55530-1-doruk@0sec.ai>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 17:58:48 +0200
Doruk Tan Ozturk <doruk@0sec.ai> wrote:

> Every LLCP PDU begins with a two-byte header (DSAP/SSAP + PTYPE), but the
> receive path never checked that a frame is at least LLCP_HEADER_SIZE bytes
> before parsing it.

Is there a similar problem with non-linear skb?
Maybe they can't get into this code, but who knows what can happen
with unusual configs.

	David


> A peer LLCP PDU travels: NFC-DEP frame -> nfc_tm_data_received() (target /
> NCI path) or nfc_llcp_recv() (initiator data-exchange callback) ->
> __nfc_llcp_recv() -> rx_work -> nfc_llcp_rx_skb() ->
> nfc_llcp_recv_connect(). For a CONNECT (or CC) PDU nfc_llcp_recv_connect()
> computes
> 
> 	tlv_array_len = skb->len - LLCP_HEADER_SIZE;
> 
> as a size_t and hands it to the TLV walk. When skb->len is 0 or 1 the
> subtraction wraps to a huge value and the walk runs far past the skb,
> causing an out-of-bounds read; nfc_llcp_ptype()/nfc_llcp_ssap() likewise
> read pdu->data[1] for such a short frame.
> 
> A nearby NFC device can reach this without authentication; LLCP link
> activation happens automatically after NFC-DEP.
> 
> Reject PDUs shorter than the LLCP header in __nfc_llcp_recv(), the common
> choke point shared by both the target (nfc_llcp_data_received()) and
> initiator (nfc_llcp_recv()) receive paths, so a short skb is freed before
> the rx_work worker is scheduled.
> 
> Reproduced with a KFENCE out-of-bounds read via /dev/virtual_nci on
> linux-next.
> 
> Found by 0sec (https://0sec.ai) using automated source analysis.
> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> v2: move the check into __nfc_llcp_recv() so a short skb is dropped
>     before the rx_work worker is scheduled (Vadim Fedorenko), which also
>     covers the initiator nfc_llcp_recv() path. Reword the commit message
>     (drop the "same guard as AGF" wording) and add a KFENCE reproduction
>     note.
> 
>  net/nfc/llcp_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index aed5fe1afef0..72b6e707ad0c 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1565,6 +1565,11 @@ static void nfc_llcp_rx_work(struct work_struct *work)
>  
>  static void __nfc_llcp_recv(struct nfc_llcp_local *local, struct sk_buff *skb)
>  {
> +	if (skb->len < LLCP_HEADER_SIZE) {
> +		kfree_skb(skb);
> +		return;
> +	}
> +
>  	local->rx_pending = skb;
>  	timer_delete(&local->link_timer);
>  	schedule_work(&local->rx_work);

