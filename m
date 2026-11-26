Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795706046;
	b=M8ckr+j3hoNScTTlLUaN6R3gdJvxFYCkntiHlKqXJpoCoeP1Bn7bXJY92V2vJg76dXWB
	 ID5BO2IBQVWtSWvg9xM2UQFsbwXwAFAsKx/1kls0JmZg6zmweK3wp4nRtoyA+LFURLnli
	 II5VtjYpWlveoMauckKoPlFnKzk+T8TYV4yN12ZXmxqzJb/aKF5z0NjJsZkegqZihXaKr
	 A0sZs+GG4s4ivGwKkOAokXs8TWC3Nu7xPPwZff06bLaMwqQH5WlwRqFttCqMYfkSH5Pfr
	 RgNgQiQTTaFtMZ9vOjzti0v6ZBT/amKIeNGFQ2c0RMKnYbpa4G7JXGSLc3Sk4z8vVEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=eFW9nR5FZygzb44kff9BBbQhCAydCKU+plkkUp60yKQ=;
	b=Ue0bvKfbiNqzquXAYFc5J6OYXMNK/huQHfNqq8d2RP8l7CrSSTdHwesPgJJR0gWa18E6
	 07pcyOoKOHru4iHnTepYECPqH3M4m/kRcMdDhe2Nui0ppHfpe1LRzvSTvSSZvMt9o2Rnq
	 9xGxQfIiyn3aBWqydFmBHRwt0Gkb48OmvmT/dIHgr0tBe2oiY6pc2+ZlLDJlCH6lsJOsi
	 WAiBu+8btXJfYbTroTzBJrSyme/dhVlXoCCNzhVVViOXtiSEIXOtdC/XGWeLSLjgR05Io
	 bEv2n1NGpD1WLTikR/ADjbSUEK2DV/bNrVyz8vK11ZixTMjRbNs/AxpKpCia0nRWP7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=Q2wYqoOf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE6606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FAE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=Q2wYqoOf
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67da69e7c31so7788691d50.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:14:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795706045; cv=none;
        d=google.com; s=arc-20260327;
        b=PR83GsMjfnfw8hHUEPdRuezhMO5bjFxsy1VcJtjiNi0vI8dtHPNt9eqE/psZfhhTHx
         Uc3JKOOjSn595i+tVYAY5fF87Lfjaq/h59Ay+C9r3em4eNzlwwvN0TKiQn85KTrpikzH
         +LcGGKpLNGvG5BtlGkYQ3/lcdbztfBkp/XK0pZmgNsp3e67pONEjqNdJ6Bqp5Kt9qOhg
         fYRgMVltXBCyCHjv7MCIDUvgZAqRBRFRe6rS0B85cfbLRM0vvM0ZMBHXNFWPo+mXW6XG
         vwkzCajJ1S4VIUSdw4Qme7lHCmQ3PL0r/Yy7aEdcjMpn/20YLphqdYiO1P/YYWolra7c
         lS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=eFW9nR5FZygzb44kff9BBbQhCAydCKU+plkkUp60yKQ=;
        fh=59V8OffDL4lTKuEjiGaz+wvnez2O8ZH196QtmfEDrMw=;
        b=ewesszl6bUdhXJq/dGlLpMiQO6v+CwmvC1xiStA5VTCH16Qzxik7vG5wPwZABTbSId
         2rYT7bwp3NeroPiaGay2Lr6EKx092R8dbql8PZj/5CsFn8633mTG7CY3vIxag8XF41SI
         zku8M2wWTtx0Mr1u6KxaQwxCJWz3959MkBy07sqnhKj4CPOe7T8yhf4Iz8QQaysR7PPM
         FSA9IUmgItWAPgyaV2ZF92rDt/KqY8LCS+8fO5deef3iAbPJBLBAMzg7ACf96xjA//o3
         qEpfvgTzZWNjt6qHH5jiCXuUxrEURW+hrctEwOehNUSF0tKQ7peviZ9/6wZrkGQaH5F2
         rs8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795706045; x=1796310845; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eFW9nR5FZygzb44kff9BBbQhCAydCKU+plkkUp60yKQ=;
        b=Q2wYqoOfAzFWcbZP2J03E9GBIo/E6xrBSXIv4+6xYv0m7fcajUrJhMlqHpmXmzUa9s
         C6gbBpV0BRxv0xJ6TyImw+JwU73hGMDeHunKLAfzk2yasf3oGGhYKZelkLsn3NbHMB3m
         +ki8zXoJgf8TK5DEMKiLBm1WAjdBGEaDrMdr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706045; x=1796310845;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eFW9nR5FZygzb44kff9BBbQhCAydCKU+plkkUp60yKQ=;
        b=JMJBX653KDis+70fOp+gdt1C8SMy/mQRi9X7+fBi+1M+DYroXDxXUbq3EOY+ZNNEkL
         OB/oHyIcBkO6PfGmVsUg6AEXvp+x2V8hOgjjDJGy1CegKyIQcECQsCEPR0b3olePGXbL
         3GgVuRtq4Sh5/LdD6bIyh0kZF8rAM7s7a9uPfPZqJjTShTxJ43Sck0noVT86Y4SZI4Un
         HvYrDZaiy6kV1E3EKPoWzjPqR161tHLwu0puP2NtUc6tDsNdLR0oSMc9U/Hlz+YeqrMJ
         IANNlHeHtq00Gp9pBLPm8mnSRV4j5mRFp6fwlnZeT1pi3wBzlJ5VGqDm9C+0V9Uc8+PB
         +XKA==
X-Gm-Message-State: APuU4Z8wEn8Vq0yTCYrBbg2tgIksdGtELXLnrfIWY5LW44E3vtI4ZOEX
	L91etE7Bw9kQYFwHqhs+w5+PUpAM7gwQEYEFGDfbWvQfd5h3zQr9pmnrvCgKrf5DXAG9+yBn8fC
	1RBH+V5z85HA3e3+WAPWAsjHmfSoW0vrF7XlpLhT4UINT3DU48A5MJ4I=
X-Gm-Gg: AZFdTZee+YOQuyz2rYMCMB9KM44zwE96tpjO6pT2cxBrFyLny/6ulFB/iaGhgchJb6S
	M9YYyUH+XrLxQuJf0MogZaP39YB3vd45l/vAeJitLN6FtGlH+6JxK8ZI1QoCH77lU3WlvqP6vEk
	L+Qyx0GKGD2YFoZrWXwf8zFDAMznF5oUOU8cDEdb4F82GfhedK8JVnt+gHyH449DFg3stZzdEXV
	JCVMsETADLHwhbe4Y31UErwFOsiWDfYduSJKEnd8dVJdLJKOrtgVJ03ay+ZF3c1AzgMUefk0TKM
	gjgCCj7ryEGYnq8DKMmHgBhtiJ4RtZTD+3eheCQokfMeNMQWnEwr9V5oMckdjfi9k5lTu9zzsSD
	aWfErP4dKHoN2OhgPjH89lOhzDc7OJf6w7zMHGJjwGbi0FPX3ts53OF1Rnfdhgd3jkincuUz12U
	W0JbOXLlFbEcUqA6YNdiMsvFUGh8eztLYiaxgkCAClhSz3MUeakYq3TLlM9gfEtz0jNXHGZvxcm
	ihOtyjaAD9rrrKVQsgmI0fpbIg0sT3PVsCN
X-Received: by 2002:a05:690e:438d:b0:67a:693a:b1c1 with SMTP id
 956f58d0204a3-67df450894emr5317515d50.107.1795706044640; Thu, 26 Nov 2026
 07:14:04 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 26 Nov 2026 09:14:04 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAFaZ9epjtBjMgjWapQR6QAzUYK4Ytq1m+VvwFv1Wu9kYauW0Zg@mail.gmail.com>
References: <CAFaZ9epjtBjMgjWapQR6QAzUYK4Ytq1m+VvwFv1Wu9kYauW0Zg@mail.gmail.com>
From: Dickson Wu <dickson.wu@certik.com>
Date: Thu, 26 Nov 2026 09:14:04 -0600
X-Gm-Features: Aa3M54peyYs6lEDi797Y2lCFVLy5gaYAuU8bITlzCgTwK1T10kqaMjoy_53KYjs
Message-ID: <CAFaZ9epcBDcZ3L72Z5KbouBiw9nMEiii8o46d8Rpxh9R-MwtXQ@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] Bluetooth: hci_uart: clear HCI_UART_SENDING when
 write_work is canceled
To: stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 26, 2026 at 02:44:59 AM +0000, Dickson Wu wrote:
> [PATCH 6.1.y] Bluetooth: hci_uart: clear HCI_UART_SENDING when
> write_work is canceled

Please disregard this one, sorry for the noise. My mail client damaged
the whitespace, so it doesn't apply. I'll send a v2 through b4 once
the serdev follow-up it should carry is in mainline.

Best,
Dickson

On Wed, 25 Nov 2026 18:44:59 -0800, Dickson Wu <dickson.wu@certik.com> wrote:
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
> [ adapted to 6.1: no disable_work_sync()/enable_work(), use tx_lock and HCI_UART_FLUSHING around cancel_work_sync() ]
> Signed-off-by: Dickson Wu <dickson.wu@certik.com>
> ---
> 6.12.y and 6.18.y already have this. 6.1 has no disable_work_sync() or
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
> Tested on v6.1.193:
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
> index 0116dbaf7431..1378ae614ca4 100644
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
> index 158b057ed3a6..b3148a84e9af 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -312,6 +312,7 @@ int hci_uart_register_device(struct hci_uart *hu,
>
>  	if (percpu_init_rwsem(&hu->proto_lock))
>  		return -ENOMEM;
> +	spin_lock_init(&hu->tx_lock);
>
>  	err = serdev_device_open(hu->serdev);
>  	if (err)
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 70449949d527..195957f41f28 100644
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
