Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793540503;
	b=g0EKKgt73k8nJpJhJiajMOE4QAyzEUpqyuYq0Lgf4P+OcZicEXdNh5mAYC3dVjzo4BES
	 s7Pg+hVxxZpf12PRJ/0hJPoeTaFfnI0a+bS+oMjbHBosYCMdz45yVfMxBKxKeqHIyQW8e
	 /Z33ZvqPadkcKdSsQbYieRRN+1dOt6xoVZxbQgQNjMCZRmzUhe5ARqIlunvb4DS4/h/q8
	 lLC6xzNd8+fFN8GVCJCLDrAZOchiXJmqAY8mnHc1r6fsyQr6nlcMeqAi7PnUVJ1+10l9D
	 pO6moiQ8Zl6JiZC0GuFyqUM/j64wYT5QszRUjJOko8LjIA1hJV7KUFKpAz4pYkQt/kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793540503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=D9SuAAhicfGEowYvG8qAtgOKnV2KMOsPr8uS/Jwlz2M=;
	b=epPgcwmeRJjIi+cW23tBV+8dpGjdEgRGCcr7TwtnxOd1CEv3XZOhjVX/ayoPAQjo/Auu
	 yfhZycLQ3oC8v2ysTiqrUFTfOaLgxNKHWBmoT2He6nwgRRkCLA7uCih8WYm4hF1ObhBCO
	 vSTiwtb5phRLEggbb4DVD7midz/Ijx/cqrUb6jfqjiCtuUQb+Z2yoQAStazN14og/Ua8g
	 ODgyNgM+AgypSgim61WeTRhQOlXPU/IhMw1TIzgDbHCWfBpcjP/O6zJgX09pAa/zwKCnO
	 QCL9WQ3ZMy13UeTl+IoyTQcERF63Pkgv24zyPQ1WG/oonU4fHjccaEf+ffFQ+cCLPZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TnBwHmkB;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AF3606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 13:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11AF3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TnBwHmkB
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ea759cc9b6so9059455ad.3
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 05:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793540502; x=1794145302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D9SuAAhicfGEowYvG8qAtgOKnV2KMOsPr8uS/Jwlz2M=;
        b=TnBwHmkBJcfx2omypk51rDF8gsLIEFeSM7osdJ6QXAjKOddxtvEBYLseofQY5eATis
         yg2y3pAPEQ8hQp/4LLvFJKAqvwAnTCI5LzPZwvejPMGUaMGdSfTIriwzWvnoDRtezCR8
         +J9WV987bbhGwE6BSqE3Vv8mZfLl2ntWStNv83mYE2PpeulC3ptKKEd2JUdO5ed31qYL
         TbFwlf6foIj5OCRjFpXLG9CTimh+UnKqttveSHFYqvO2XZ1nkxddXXj0wemtWVdYT7S3
         1m8DI0lZd0ZjILlbOvxxa6QrLTzmfiaZrCNtK+F3YSGCncmbw4kkGjQ8Cb3atT3dwCO+
         w0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793540502; x=1794145302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D9SuAAhicfGEowYvG8qAtgOKnV2KMOsPr8uS/Jwlz2M=;
        b=eOy0L846vehLoLoVujStjX4pWgcj4oYj/aOhT2wXDycKuUEs4Zw3DFMS00vM4pPbfE
         +xS3ZhDDOtIu5iE1ZTEq/EMtapwV5iANxPrAObampV47rU42HT5sbCtJQNi7eeBMRMmk
         F7YXJfQAkkhSLlEWPv3h9+HiYWlm5Clcfn1B2jeq/UNZVtauCnL0mSD8vEQyCaQgdWj2
         az39jy1OlhRh6AbJVPuLL6AxkLwvE/4w6E3s8tvWR50yPasTLUrrf60LRWarl8NSLgg9
         6/wt1WgQdGDbb+dzvIBi3Wi5mBUvBP5kcvy3MVPxi5M9dXFs0dTeXHAxNa9RlBHpY8VO
         uYnA==
X-Forwarded-Encrypted: i=1; AKwUvBzWnL5o9C0PCTJQ5s0ICR4MaceOvgjyCMXFEX2maBLC4KH4U5nShELfEApqEUGFwlwWkPjN1c4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xOKTlmth/w2rg3aSdLobI7wLtJMAk8m6fmQjVmnrmc/CFvyuk
	bThh+z/fwgPl9A9SHpwG3uYY5EyXyLEV4Pv7BZb9A6Tdmw/HCoQ0TwMs
X-Gm-Gg: AYBFou0V98mZJP05PBA/480gMQ0h2rVV0u4mGIwX9wzLfAslL2BETlOPYjDB6uUGVCi
	jzPggVzHZGFoJSo7VdDNPL88+m5JU+k4SsnFgpN7CDmPuvgCz/2PDbPd37XASf4ot4OfzCplpWj
	0sY2eBf1dgyUcUuTEOnNNWkO7zA4v0CfcIoJztPQI4qrlJfisPjnN/+akLkoV0RZVnJh1pORqso
	lpNNVMxk5fGilq6rElDcDNeEAjVlyme+wE46Og2Zu8gBM/EnFhnFlVS2Qf5DQHcAVXf0U5RN6jw
	rIySRksk6nGwD9qdxzdz8OrG/41GFrPgJMuNYlv0KIiiNB0u50DltgcxbCRsudwMub78B95lOzN
	MvzI4z+NJWJpgafmbT6K1NjZpZnjOnBEgx2dO+hHFylYMIRsnjUxw6Kenxt5yBhC0TKDdKyMKUk
	EZRMsjGzJlkRVHFHkHkfbhAwKniEi+wh3PF79TkVcj+Xnn48jZVx6qGJU2qw1BNX0UhO+rCxCUz
	8MT1uvhqYCvQoo0MS9L8KRb+j0fIXFj+xV9E58oyr5xSJho5NqxzFQA0KPRyxd/aWZU8FRSnQfV
	RUuEZzU3vwiiheSIuS1kYxMnjj//5qQrSxOLVwpo5stFy2XvD98oxIQHp2Edaq8w8EE=
X-Received: by 2002:a17:903:1b05:b0:2db:733c:fd1f with SMTP id d9443c01a7336-2eb364005f0mr64610475ad.8.1793540501905;
        Sun, 01 Nov 2026 05:41:41 -0800 (PST)
Received: from KRHW1CJW23 ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3927ff6bsm18769675ad.52.2026.11.01.05.41.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 05:41:41 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	neo_jou <neo_jou@realtek.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Hans Ulli Kroll <linux@ulli-kroll.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw88: usb: stop RX work before unregistering hardware
Date: Sun,  1 Nov 2026 21:41:17 +0800
Message-ID: <20261101134116.30404-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <4a555879477e2c5b8eb2f2cd430157adef580461@linux.dev>
References: <20261028141904.8707-1-enderaoelyther@gmail.com> <4a555879477e2c5b8eb2f2cd430157adef580461@linux.dev>
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

Hi Luka,

On Fri, Oct 30, 2026 at 02:51:43PM +0000, Luka Gejak wrote:
> As far as I can see, rx_urb_work can't bring an URB back at this point.
> rtw88 doesn't set soft_unbind, so the USB core disables the endpoints
> before it calls the driver:
>
>         usb_unbind_interface()
>           usb_disable_interface()
>             usb_disable_endpoint()
>               ep->enabled = 0;
>           driver->disconnect()
>             rtw_usb_disconnect()
>
> After that usb_submit_urb() on the RX pipe fails for the rest of the RX
> teardown, and a failed submit only queues the work again on -ENOMEM. So I
> think cancel_work_sync() on rx_work alone already closes the race, and
> the same change would then work for the older stable trees too.
>
> Keeping disable_work_sync() doesn't hurt, but then the commit message
> shouldn't say the work can restart a killed URB. Or did I miss a path
> where we get here with the endpoints still enabled?

You didn't miss one. usb_unbind_interface() is the only caller of an
interface driver's ->disconnect(), and none of the rtw88 USB drivers
sets soft_unbind. Before rtw_usb_disconnect() returns, only its own
usb_reset_device() enables the endpoints again, and that runs after
rtw_usb_deinit_rx() has destroyed rxwq.

rx_urb_work can still run until then after an allocation failure, but
its submit fails on the disabled endpoint. The commit message was wrong
about that.

I'll send a v2 that only adds cancel_work_sync(&rtwusb->rx_work) after
rtw_usb_cancel_rx_bufs(), with a corrected message and without the
3e3aa566dd18 Fixes tag. It applies unchanged to 6.6.y and later.

Thanks,
Zhao
