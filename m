Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511138;
	b=j5ytH03SWkGGXeyc5iPjfDU8zNmUkwcc5TqRWwbTqxN7oUAJbXo/66gnZt73cTdoBH9L
	 YkeajeW/6vtCeQ3CikqQoSw1mVfAc0vP0Wyx5ZM2alo8PVwfrfSAOmi79HRNDGhicAjW6
	 miB/CeQuXvOhVb44CjNPxzYsruwBbey2TFPYCyW9HJ7tu1Ftre20mTJd8bq3EnYAJMdbk
	 zcUhIY/u11ole/lEhLMcwAI2VtyorPB5vxx5SQVno7PHgsufybgTtJKj9dLBmkjGsCFZ5
	 k/+ICxTPR/nWpr2AwCf3i3U/eCu9X/FcVt0V0dNLAytRWymGz6Jx4VSIkDIMfkrE0Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=oUhbWP+xO4Xwp6vLYbQPz0V795zRUvYieGT7E6JzQ8w=;
	b=qev49E7WAMKGEdvv+N9jVyjgiecnYZG1KY8iRI9XRAUqWG2H7/P+eFE8c7BRZZPblqhS
	 bPKvtDI786JKHaFDXEqZEyTRM7482opGwNtxkeNaFztHkTQGfEzGqixzELIbVpfryN6eK
	 4fa0mp7mAxGPTOBJ7O6w8ZAu5G6c02wZa7jE4bMGeT2NDdBDb0pkJ3YUnAOUT9pT4bFyK
	 Yq2+1rGi3HVI6YyHcyWHHT76w/VsVWz+lIYnnchPiVRW09SZrNy7Y1MXeX+eJe6QYTR5Q
	 AiTdPXMin0kQkmSLkeanxauFyzIAmIXtJhag3ZmUbTsOQH8F9rE75I8aPjsziyaBXFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ej8oTcel;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6E606A8A3
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4E6E606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ej8oTcel
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e987ec84afso1318875ad.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794511137; x=1795115937; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oUhbWP+xO4Xwp6vLYbQPz0V795zRUvYieGT7E6JzQ8w=;
        b=ej8oTcelsuxDZjwEAidMbY9rbmtg5yRfaMBEc28Z2tLU+4A2XWb8VABD1CT+D2Yi9m
         354ilxe2H8hvV4iE549AjneiNHzyT7OJqo4prKUQiwBRD/Q6vPWEDBmV1FeMePtmce9R
         t7Kt0t/Xl+Dc6orqritJvaXlQEDqBcQ4AEFFTm6M2Nl7ESYQHVIYTrR9mLoNxBGiXCUx
         3CwdU6zL26USwaHCGuIoncQIO+0tL6rJq/nfoKTHYSJ3pDhBQc5+9MwJYyAHf7XyCWey
         2fzWbiXdMhJ9IHk2dC7sYPIT2V106tMj0ag1SxOSYfh0FyN9hA/McLzOe0xIYqw0BJsO
         33nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511137; x=1795115937;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oUhbWP+xO4Xwp6vLYbQPz0V795zRUvYieGT7E6JzQ8w=;
        b=YB8XBc9NscCJIlbBJx1htH28tvpfsZEtxLnQJRNeL5+QA4/wgQS08gkYgubmHRaiBC
         A4c9PbEFqOiEc6N1As7LBdcI/xjzkryZgnxUlxiQ5ZQMi410vk3nX8X3D5dqxA39v9R0
         Rqqf7JxGom5hjJ2DRj2Y58GTtacbjOMJ+6nLT1p9k9ZAEiw1qJ9Wn6yEbpzrKob7IMWe
         u2yNLwM9fG/2bGiT/iUnkZTqOZjUKvsVnSX32WIaEOITA7PpI0lEz45TrzjgsxvtuMBF
         ON2A7RFk/c1aLtGPI0xcNofl6q8gA2YiLL/oLKxeBVjw9RvBvQnC73WJYUkiUkQbdlB8
         vJoQ==
X-Forwarded-Encrypted: i=1; AL+hErGCrTaqeUebzLAux9UwJruIz0tPz9TlNuCWbYWULRGQYeFMcq5p11PqtYvKezRExQuur3XyEKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XLdRktskdwec5HP4A1G0R6HK6rxhqdhq4gkvgryHgfp7uDMbR
	kgr09C6JXd2ys7ITwl7Vu1lI+40uKpOuaYmGEcKOONuRKv63sN3YIlDea4FLO+FqBVTDWCsPjDM
	E8Jfql2kqAw==
X-Received: from plsb19.prod.google.com ([2002:a17:902:b613:b0:2eb:162b:6e4])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a85:b0:2ed:eb27:6c5c
 with SMTP id d9443c01a7336-2ee0dca8c24mr3309075ad.50.1794511136836; Thu, 12
 Nov 2026 11:18:56 -0800 (PST)
Date: Thu, 12 Nov 2026 19:18:50 +0000
In-Reply-To: <20261112160448.41566-5-lui2012qwq@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112160448.41566-1-lui2012qwq@gmail.com> <20261112160448.41566-5-lui2012qwq@gmail.com>
X-Mailer: b4 0.17-dev
Message-ID: <179451113093.3909038.4032474606987042553.b4-review@b4>
Subject: Re: [PATCH 4/4] usb: phy: gpio-vbus: free the interrupt before
 cancelling the work
From: Neill Kapron <nkapron@google.com>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: linux-usb@vger.kernel.org, b-liu@ti.com, gregkh@linuxfoundation.org, 
	nkapron@google.com, tony@atomide.com, bigeasy@linutronix.de, balbi@ti.com, 
	shimoda.yoshihiro@renesas.com, robert.jarzmik@free.fr, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 13 Nov 2026 00:04:48 +0800, Chengyu Liu <lui2012qwq@gmail.com> wrote:
> gpio_vbus_remove() cancels gpio_vbus->work while the VBUS sensing GPIO
> interrupt is still live: it is devm-managed and freed only at detach,
> and gpio_vbus_irq() schedules the work with a 100 ms debounce delay.
> A plug event landing after the cancel re-arms the work, and its timer
> then fires on the freed gpio_vbus_data.
> 
> Free the interrupt first, which also waits for any running handler,
> so nothing can re-arm the work past the cancel.
> 
> [...]

Reviewed-by: Neill Kapron <nkapron@google.com>

-- 
Neill Kapron <nkapron@google.com>
