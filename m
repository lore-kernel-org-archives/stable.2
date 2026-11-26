Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795705976;
	b=4zm2crlcoNRuV1TQCh2C1GxuSXCXCFmTe9Fcmb7ag9M0UemVo5pMTYT5cmnMpX5q8wzQ
	 GhjaZx58ZO36/Cc1DxHre8KPK7PIGhzjoV01bKLCywswH1jjBCNAFNDflVThzJpYS5hnD
	 WQ+YKi7Kqgbbe0N09uPY+VUiEfoqw0rtvbPVmtb87UaPqA+yUPQwRg2bkhk+r6Zz71hkB
	 ll6s6/sOVI5kS+s8mxTXnrStqDbL69zszTJaZtsgL3ElL1GhIks03cUp9CGNHEUG3GrG9
	 sF7GLLVQFOQyBeKz6e4wiRENwDVfgkyxg98Z+ABPJPLBpBxTC0hKeg67G3+pAstXuHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=hqyTz9OxFV+fmE3hus35v/zz1FvvouOfAGWkbfu6tfs=;
	b=CmejFIKjIrQgj5yUR80+Um8XEa00F91o0ihsL3SJTyLv6LHhesttYncdoA40euJyoyKO
	 st+EDL5OcWrI5715kloFCu61CRI9kubAu8fqW+WyCQyNgSAsHMiyCKXuZwjYZHJAY36Vy
	 aubYvzLoM4MQtgp6riN0Vzv0MB/H5zoU87qijC1Dkoyi5e2Mn7MCOyroyh1D255eicaqI
	 +14S5d5BHiV3sQj60v3hQbGYWicwQwC2njtGjCRZU1H8sNFKGEOwbuxWO4fSzX8cjwoDL
	 l5eAz0TG9C7UbWThDgRAo0TEyLV0M1xBPU6Kmy8XV2BaI2bdaDdBG0AmJm21Viq8mLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=HRbLfFxz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F68E606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F68E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=HRbLfFxz
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67583c777abso7406554d50.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:12:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795705975; cv=none;
        d=google.com; s=arc-20260327;
        b=cw2jzArIKKw+DbZrjxvQh0GxmX6BxGbBXcc1s8yj0of5MxmCw+zcTrLqKydLy1NFGT
         Ou3H/CLiix2GPxYyiAy0UrO8c2eKiL59hrnu98X2/yemcxUXLivKtFdyzIEQM6ExNcvU
         gClmbdd11dYIfVqdmnK3AI0XDpwCcs4yhZub0ruqLtCzOqPEesDjZoTp2itg+DBjlqID
         WB9spHZpGbrGRUVZr5M0OJ4ARPYIjKgWy4+0AkV+SC14gRBPBvVBeFa/9gQdoeo8ABv8
         0lSCrHNvQ8F03S10bmcReXlj4uEampxUUgdK1ewHPG5NTn+NRwnFgR2ejGPi2xZlafpz
         A3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=hqyTz9OxFV+fmE3hus35v/zz1FvvouOfAGWkbfu6tfs=;
        fh=59V8OffDL4lTKuEjiGaz+wvnez2O8ZH196QtmfEDrMw=;
        b=jCX3RfqOVKzG8pw8Bm5ikJExiYVFVJD5+Ewcqpf3R1pS1cXzp30V/CEhr5yieT3PMs
         DDHfUywHdTn3OcxkbK/drZNzB1VoVgFJRQEPAmTJQXVv3B+KGNorqtQlyzsTRY+g2HSl
         rgQaOFfV99u2MsegoVB3+Zv+NSfVPGuidrIE7eSA48PopOoQMjjIMOG0mT4ouNCw3up0
         PgnkhTCTd11ejvs2PmwgXjqxGTppWiE1W4+XekQ2foSeTZfMbzNZheMUSQ7oKidLVUQ+
         u4HOXtfim28y+MOMf5Q78zSoopNssoj/IB+z5dgAK9UikWYcK8fOU8M1RhU0NztDNXbD
         YLHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795705975; x=1796310775; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hqyTz9OxFV+fmE3hus35v/zz1FvvouOfAGWkbfu6tfs=;
        b=HRbLfFxzRFX7HE8fBUw8aRQA2+KleZfdT6zarUvn+byJeYebMdG0uSKq8OASsW7apz
         TA5m7b05X/3KZYV9k77z5EO2+gXuLrPeQcqKJQxTNEB/+Qz7lTf8+qb1CeilYqjYP4Ly
         NV5xb7Y3sujCvxmasreXsQcH4t/GbHhhai+EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705975; x=1796310775;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hqyTz9OxFV+fmE3hus35v/zz1FvvouOfAGWkbfu6tfs=;
        b=INlAYdFRrbhDGCF+LKjHsDY0e0Ydk4c3EeLyr7Cd/EoHduBM2GIDm+NkoYLPAz0Est
         ZYWg9efynSx8bbDbyivNZRUQwxO3F91ce5FocsT7phAgMKJz+INiLjAxKJ8KXnngJs2a
         QeW++ZjyfzHfxtWoK5wCfNVOEFY9z7Bv6reqxKmbgQCmtS9+O/C4AqNBHkRraEJ2JIJo
         Xt1gvpwPknozD9b7yz+6vgLur6dfY5+mry2uXTGRMeZ3yi7+SDwim8dLDQ92lJElxEeT
         LuGeD3OFGrrEpszEtnXqyOhEx4VOobA8mz2FrAVMvHuAVQQ/xHfzqBFQ/slUolZQsZnP
         0UoQ==
X-Gm-Message-State: APuU4Z95KMSbssT9A/bZ+/oyMtaxR4qLdS+8pS8i15xpwC7oNt6Wby/6
	BZPbM51hjaIUuOb1QW/QppRYQFIVHV/Pg+dASdeIN/jpu4/dNuaV4NnrbApChkq5Iw5eGxWnigt
	pPZVWFR8nuQ0grxA9m6rqlvLMI3bpB4L2hgFAQKiRAxXuLUF5qrVM3i0=
X-Gm-Gg: AZFdTZdX4HfcWvxWZ5JR3wLTn0pz8LsB6ARRedVzg+OQDRJ42oMtJG4u0lO1Ycfh1fa
	L4zuiCGaWyQv2w9Z9ZiibUac12xNqsFeIgyunK3FtyknwpOEV2I1U/fWrEQ942ZzF3yMCrwLi6r
	rBO5kp9A/RnR9L12uqUCoZNnYY0fjmbQwt1LJCo/RuKUuHLpva5iyia4urHHfx+p2BFuIQSKt57
	Ji2/4oUURUU8KGVxnOsVELI9qv0X5jShwegg7SVGgKvtZ4JOOf5Jml4X1Ai8iOHQryOR1P5KNB/
	8AF1NeDjSIxbxCT1vAfWA9PD1Guvwt6OhTYjbfOl4whZ5jijlcWXHGnOszAjhMXQZBq//iVlDVv
	QAQYoKjwXDC9VG3f/6HS1pF87WcmsBwU9wNmkxvW4Q6KxMnxRh3vJaCVEhaSUIn5Ugo2W9QDu6k
	z6EGzvqskZwkD3mnXALaF5mmvAn3aZUuhr01uINlEoj9XQ1DIfFhk0FYwJjc2oEYjRxyahJX873
	8Xk9Q3zcmfclxkK5MeJMkm+qcfS/AM2KR93
X-Received: by 2002:a05:690e:4088:b0:67d:b120:2ce8 with SMTP id
 956f58d0204a3-67dec49ca09mr9084429d50.38.1795705974959; Thu, 26 Nov 2026
 07:12:54 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 26 Nov 2026 07:12:54 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAFaZ9ep1MzprNHirA++5XpLuQC4PhibJr_FBWHxEt=Exvic1QA@mail.gmail.com>
References: <CAFaZ9ep1MzprNHirA++5XpLuQC4PhibJr_FBWHxEt=Exvic1QA@mail.gmail.com>
From: Dickson Wu <dickson.wu@certik.com>
Date: Thu, 26 Nov 2026 07:12:54 -0800
X-Gm-Features: Aa3M54o31REJEJsWmKY5B_s9OOkSIuon4sFzhNnSTVAtuqLrNKs60p-Xa78EGR0
Message-ID: <CAFaZ9eo1yq-=qcgmkf88YPRTeEfUftisOjXUG5BSnzEoCyws2g@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Bluetooth: hci_uart: clear HCI_UART_SENDING when
 write_work is canceled
To: stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 26, 2026 at 02:45:08 AM +0000, Dickson Wu wrote:
> [PATCH 6.6.y] Bluetooth: hci_uart: clear HCI_UART_SENDING when
> write_work is canceled

Please disregard this one, sorry for the noise. My mail client damaged
the whitespace, so it doesn't apply. I'll send a v2 through b4 once
the serdev follow-up it should carry is in mainline.

Best,
Dickson

On Wed, 25 Nov 2026 20:45:08 -0600, Dickson Wu <dickson.wu@certik.com> wrote:
> From: Pauli Virtanen <pav@iki.fi>
>
> commit 1b0d946d6f08bd39211385bc703a440911b41e46 upstream.
>
> HCI_UART_SENDING bit in tx_state means write_work is pending and blocks
> queueing it again. Currently this bit is not cleared when canceling the
> work in hci_uart_close(), which blocks future writes when device is
> reopened later if write_work was pending.
>
> Fix by clearing HCI_UART_SENDING when canceling the work.
>
> Also make clearing of tx_skb safe by using disable_work_sync +
> enable_work instead of just cancel_work_sync. hci_uart_flush() purges
> the proto tx queue so we can cancel the pending write_work there,
> instead of doing it just in hci_uart_close(). Re-enable and possibly
> requeue the work after queue flush.
>
> Fixes: c1bb9336ae6b ("Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths")
> Link: https://lore.kernel.org/linux-bluetooth/07e0a28650773abec711ee492fdb1bf5d21a6c98.camel@iki.fi/
> Cc: stable@vger.kernel.org
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> [ adapted to 6.6: no disable_work_sync()/enable_work(), use tx_lock and HCI_UART_FLUSHING around cancel_work_sync() ]
> Signed-off-by: Dickson Wu <dickson.wu@certik.com>
> ---
> 6.12.y and 6.18.y already have this. 6.6 has no disable_work_sync() or
> enable_work(), so instead of disabling write_work during the flush this
> adds a tx_lock and an HCI_UART_FLUSHING bit. hci_uart_tx_wakeup() won't
> queue write_work while a flush is running, the flush cancels and waits
> for any running work, holds HCI_UART_SENDING while it frees tx_skb, then
> clears both bits and replays a wakeup that came in meanwhile. That's the
> sequence upstream gets from disable_work_sync() and enable_work().
>
> The serdev follow-up, ee43bade37c4 ("Bluetooth: hci_serdev: serialize
> flush with transmit work"), isn't in 6.12.y or 6.18.y yet, so it's not
> included here.
>
> Tested on v6.6.163:
> - x86_64 allmodconfig W=1 build of drivers/bluetooth/, base vs patched,
>   no new warnings
> - x86_64 defconfig with BT_HCIUART, BT_HCIUART_SERDEV and BT_HCIUART_H4
>   built in, boots under QEMU/KVM
> - I don't have UART Bluetooth hardware, so the close/flush race itself
>   is untested here. No existing selftest reaches it.
>
> Since the locking here differs from upstream, a look from the Bluetooth
> folks would be very welcome.
>
> The backport and the test runs were prepared with AI coding tools
> (OpenAI Codex agents, with review by Claude). I went over the result
> before signing off.
>
>  drivers/bluetooth/hci_ldisc.c  | 37 ++++++++++++++++++++++++----------
>  drivers/bluetooth/hci_serdev.c |  1 +
>  drivers/bluetooth/hci_uart.h   |  4 ++++
>  3 files changed, 31 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 548e58e69eb7..8c43ffb30725 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -116,6 +116,8 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
>
>  int hci_uart_tx_wakeup(struct hci_uart *hu)
>  {
> +	unsigned long flags;
> +
>  	/* This may be called in an IRQ context, so we can't sleep. Therefore
>  	 * we try to acquire the lock only, and if that fails we assume the
>  	 * tty is being closed because that is the only time the write lock is
> @@ -129,13 +131,14 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
>  	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags))
>  		goto no_schedule;
>
> +	spin_lock_irqsave(&hu->tx_lock, flags);
>  	set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
> -	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state))
> -		goto no_schedule;
> -
> -	BT_DBG("");
> -
> -	schedule_work(&hu->write_work);
> +	if (!test_bit(HCI_UART_FLUSHING, &hu->tx_state) &&
> +	    !test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
> +		BT_DBG("");
> +		schedule_work(&hu->write_work);
> +	}
> +	spin_unlock_irqrestore(&hu->tx_lock, flags);
>
>  no_schedule:
>  	percpu_up_read(&hu->proto_lock);
> @@ -176,7 +179,8 @@ static void hci_uart_write_work(struct work_struct *work)
>  	}
>
>  	clear_bit(HCI_UART_SENDING, &hu->tx_state);
> -	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
> +	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state) &&
> +	    !test_bit(HCI_UART_FLUSHING, &hu->tx_state))
>  		goto restart;
>
>  	wake_up_bit(&hu->tx_state, HCI_UART_SENDING);
> @@ -236,9 +240,16 @@ static int hci_uart_flush(struct hci_dev *hdev)
>  {
>  	struct hci_uart *hu  = hci_get_drvdata(hdev);
>  	struct tty_struct *tty = hu->tty;
> +	unsigned long flags;
>
>  	BT_DBG("hdev %p tty %p", hdev, tty);
>
> +	spin_lock_irqsave(&hu->tx_lock, flags);
> +	set_bit(HCI_UART_FLUSHING, &hu->tx_state);
> +	spin_unlock_irqrestore(&hu->tx_lock, flags);
> +	cancel_work_sync(&hu->write_work);
> +	set_bit(HCI_UART_SENDING, &hu->tx_state);
> +
>  	if (hu->tx_skb) {
>  		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
>  	}
> @@ -254,6 +265,13 @@ static int hci_uart_flush(struct hci_dev *hdev)
>
>  	percpu_up_read(&hu->proto_lock);
>
> +	spin_lock_irqsave(&hu->tx_lock, flags);
> +	clear_bit(HCI_UART_FLUSHING, &hu->tx_state);
> +	clear_bit(HCI_UART_SENDING, &hu->tx_state);
> +	spin_unlock_irqrestore(&hu->tx_lock, flags);
> +	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
> +		hci_uart_tx_wakeup(hu);
> +
>  	return 0;
>  }
>
> @@ -271,12 +289,8 @@ static int hci_uart_open(struct hci_dev *hdev)
>  /* Close device */
>  static int hci_uart_close(struct hci_dev *hdev)
>  {
> -	struct hci_uart *hu = hci_get_drvdata(hdev);
> -
>  	BT_DBG("hdev %p", hdev);
>
> -	cancel_work_sync(&hu->write_work);
> -
>  	hci_uart_flush(hdev);
>  	hdev->flush = NULL;
>  	return 0;
> @@ -516,6 +530,7 @@ static int hci_uart_tty_open(struct tty_struct *tty)
>
>  	tty->disc_data = hu;
>  	hu->tty = tty;
> +	spin_lock_init(&hu->tx_lock);
>  	tty->receive_room = 65536;
>
>  	/* disable alignment support by default */
> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
> index 753343ca8489..835ec8f2f09e 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -313,6 +313,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu,
>
>  	if (percpu_init_rwsem(&hu->proto_lock))
>  		return -ENOMEM;
> +	spin_lock_init(&hu->tx_lock);
>
>  	err = serdev_device_open(hu->serdev);
>  	if (err)
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 39f39704be41..2687f76cc01b 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -12,6 +12,8 @@
>  #define N_HCI	15
>  #endif
>
> +#include <linux/spinlock.h>
> +
>  /* Ioctls */
>  #define HCIUARTSETPROTO		_IOW('U', 200, int)
>  #define HCIUARTGETPROTO		_IOR('U', 201, int)
> @@ -76,6 +78,7 @@ struct hci_uart {
>
>  	struct sk_buff		*tx_skb;
>  	unsigned long		tx_state;
> +	spinlock_t		tx_lock;
>
>  	unsigned int init_speed;
>  	unsigned int oper_speed;
> @@ -94,6 +97,7 @@ struct hci_uart {
>  /* TX states  */
>  #define HCI_UART_SENDING	1
>  #define HCI_UART_TX_WAKEUP	2
> +#define HCI_UART_FLUSHING	3
>
>  int hci_uart_register_proto(const struct hci_uart_proto *p);
>  int hci_uart_unregister_proto(const struct hci_uart_proto *p);
