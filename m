Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795264135;
	b=u2nIevglO8XjlFYWoJeUBrXTzdUNK7iB5DfOdAcTEFd5e2YnIvzaEfW8IIKF44uxeLL5
	 n1qqGidF6MC0MiY0DYpDggg40x+hsBrx+e6YY6lOKT1nkGV7FLv20LJlzubhljkHn7Dxj
	 ZWM7c7ZiCih/k2cjenh4hLSrZxbN5QbQ8Ia6so9cT7VRFQSgzpG3Hu2Glssji/uFd3JX4
	 bN8ujrCSEK8WnPmYrU916BxUmjjzAdWSylPubcpAo2p8deqy3gXgq11uWdm8MDqvTinvr
	 qcW/qmwqEXiH9MKiw6CEWr73SkjrG2gH+lw8ler7nGSbyRxzv8X+RUa1usmxFNxl1Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xbPlJS6qwfZzqUa056hpUcKGkd9cFIzccwWJm9phGjg=;
	b=b4FgGhNfUoaKmm8VFABLM3SOhPDnafL7tc+NGSKjKS6MLxZUkdcMGKAJBtvEO7KlBCco
	 VrimML8dychrITPdx6VtW5hL+Ldq4Cse/PN5qMAbPj50QdG6DXtbd7X0bpehT6x1AIaGL
	 7yymD7FS5wq7AzwBG1OCgPqRvkbllQ1n4iylGKLL0rMfFRE9CtB+wK34F84Vv4LFsZ8qI
	 KspukzWBJrYh44PMv6syhV5DAw3tKMB0VlytSGfp3b+tDQw2FXdNWgNsoz90JH5tHL9rO
	 MXKH8YKG/X9lBi6YjEE0zx9amjJkr9wSu5cEZJOerdOWNLft9/QURisOOvQETWip66w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lMREvsw4;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674D1606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 12:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 674D1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lMREvsw4
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b3acec6677so2595634c88.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 04:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795264134; x=1795868934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbPlJS6qwfZzqUa056hpUcKGkd9cFIzccwWJm9phGjg=;
        b=lMREvsw4M7lZ1kgv7GSe+X02UOR03A0nw8vk5xpJ70qd+sSzBPAO7WLS8naehULzrp
         1lbPwzCUrkA8Z7YABjVOQB+IBmHYwYEx73k7HH7Vc0yq2LfOGblwkuMYPjeq5CBXnDBB
         wf8vhrmv7TSYOnKDYkQ5zA7oQoXvWB8zmOSU8NcBPn6lP9Y8uxdgI9AnnurZRI4qoB8Z
         ARb+dloSVJy2rlBGUOvwEerwofgpnpZdmViT+kHwvmh555zKf9fnkDgVD1TpwzVE0mlA
         GcuWTh3Vd8ojcIGNbNZ5lnoPhJx7aGq8EwXZ0DBUCH4XfzE5GujW+dnJscd/ZCCYqtoR
         w/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795264134; x=1795868934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xbPlJS6qwfZzqUa056hpUcKGkd9cFIzccwWJm9phGjg=;
        b=Va219Xr2F5XyTxGE4jaOCcgNM008RAOVtEsQFmZjHDWyUMoKZayZhti/8H7pRFPmOE
         UvUzpLZY7ZdfPVqbemTUs2KK06hNMpSsLlT+O8nyF2aWqT1Zu40kkjd+tLcMxSW6vsPR
         izGzEX12Osf9qus9c8FkKXXN1Ye5+HcbGxeME4Qh/NUD1M4TEiB9scW0EsEIHFLnd60i
         yKaTbe9yx/YXT5szDVl1PGL3k+t/+2Jpdbyx0YkINnNcpqP00eim6JaRm4lJ6a32QA+a
         EQ8KBfme9Att/baw/pt8aNOxan7Z36w5bzPfuBIDnKoyX3spmVwURsUQuR99x5lTmN0t
         Pnpw==
X-Forwarded-Encrypted: i=1; AL+hErFLN0d49SIIZlzSKKApf7BJtOS/GSm7cKKQneHpmJ14XMiX1eruoRVC+9WUFhhi8p99DcLolbc=@vger.kernel.org
X-Gm-Message-State: APuU4Z//o4IhgZLBdj0QxB2RUiS80AgpQUo0qp+asvcLJeTEi9vO3zsT
	1ZYwVyr8qOxvJl7xA4SacFu8v3hxf/w9p3PE4Y9cnBVoo4hXpU3wH00o
X-Gm-Gg: AZFdTZe++i95ZbXsF+9upWGndlpdnAJUXi1vAltHMvlkC4gJlwRgcJej5Wav6vaQnlC
	uau9zRfM44E3oswcM3q+vXq3n5jQIJguCrl8MOEjQSM7tsMSHKkcssTvhvi1QSskcCNFP10VAl+
	exnux88mr30pwA9B47xoh3IrGjW57TCl8JNk7F7LPTymcOyrHUetvKstlA6gotlYi7btiZ9/3EW
	Zd/+Ye3DpjL39lw/75/aViHXqVCR7C2QxbZEQiTIaFmsmRNixDhfFcMv/K+/u53WRz/9REWqJeR
	qoOacUKxKmmDIuB52oG/Ja6RAr1CAiogR2yVIY5cHHbxgBeCeev+zWkMPBlrz+SJ3MquYk2Q6ML
	xW0/FzUZ57rcbAwegPK8I7n16rb1M4H9/OmR1ZGviLElxxAKWG5ykAFOg36hoL2CPgsHRNi2N7/
	FadGWzXZ8lWcvz884zZ1Qo3SkgQXGOFYc7N4Gjdd6sKsWwgc7ZedJiAHxyhx8mO3u1jW5QOJYiB
	zwUshsIiio5hZoQOfR9gN1aQq2qhSsb5n43+hvI1GkJOVIgUKveHizHlRLuRRUigNwgvU9tQlBI
	GYp98/B1Yk58wA0d50XENQgoVaXr4fKM3SE0u6ZpeBjG3gZsIg==
X-Received: by 2002:a05:701a:cc98:20b0:1a7:99b9:2eb9 with SMTP id a92af1059eb24-1b5568fbd8dmr5539812c88.27.1795264134374;
        Sat, 21 Nov 2026 04:28:54 -0800 (PST)
Received: from G7XWH7K1F3 ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm9671917c88.5.2026.11.21.04.28.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 04:28:54 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael McAllister <me@michaelmcallister.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_serdev: stop write_work before closing the port
Date: Sat, 21 Nov 2026 20:28:32 +0800
Message-ID: <20261121122833.7545-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <CAFEp6-37+O4BoSL414Njogr-34G7se-8Nu+O7B0zjBY1Jw7UWg@mail.gmail.com>
References: <20261120062048.40310-1-enderaoelyther@gmail.com> <CAFEp6-37+O4BoSL414Njogr-34G7se-8Nu+O7B0zjBY1Jw7UWg@mail.gmail.com>
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

On Fri, Nov 20, 2026 at 02:39:41PM +0100, Loic Poulain wrote:
> > +               cancel_work_sync(&hu->write_work);
> > +               clear_bit(HCI_UART_SENDING, &hu->tx_state);
> > +               clear_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
>
> Looks like you are mostly re-doing what has already been done in
> hci_uart_flush()...
> Wouldn't it be simpler to have a hci_uart_flush parameter to not
> reschedule tx on flush?

Good point. The only reason hci_uart_close() has to stop TX a second
time is that hci_uart_flush() unconditionally re-enables write_work at
the end.

Skipping just the final wakeup replay wouldn't be enough, though. Once
hci_uart_flush() re-enables write_work and clears HCI_UART_SENDING, a
serdev write_wakeup callback can still queue write_work before
serdev_device_close() runs.

Instead, we can split out a __hci_uart_flush(hdev, bool resume_tx)
helper (since hci_uart_flush() itself is the hdev->flush callback):

- Normal flushes pass resume_tx = true and behave as today.
- With HCI_QUIRK_NON_PERSISTENT_SETUP, hci_uart_close() passes
  resume_tx = false, leaving write_work disabled and HCI_UART_SENDING
  set across the close.
- After clearing HCI_UART_PROTO_READY under hu->proto_lock (to drain
  in-flight wakeups) and calling serdev_device_close(), hci_uart_close()
  clears HCI_UART_TX_WAKEUP, re-enables write_work, and clears
  HCI_UART_SENDING for the next open.

That drops the duplicate cancel_work_sync() and tx_skb cleanup while
keeping write_work completely disabled until the port is closed.

I'll send a v3 along these lines.

Thanks,
Zhao
