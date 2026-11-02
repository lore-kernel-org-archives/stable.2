Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793596450;
	b=S8VU+Kr+EuCmBbEpfYx6++JoqmvmvwTLzM0P2JmXa/JDWA1y2F/oUKR4MlWi6yw/Z0EO
	 ukE2BmhfLOv7YHJZLlVNuLIb+/mLVQouXSSpDa5cWmJ9cB9wStalzdQ3f+lat3QsHzhTD
	 SZJxUpZh1IT99FF0drIupLuGwCGf5NX563FnxczAGySycpy15eycn7fODdNYu8hLCaTIc
	 2Nn6ZRKPbdyVSIvVSabWwfZJFQwDD/H/jMFcXa02BBeEzsE4iivS2i53lE7IhjTowSLNa
	 aGi3cxF22+kzU1edqd+92GWlOSFzIGnoMuFxvDF1BukHBhyN+HeEEbCdWCNUesG7sfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793596450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v8urwWaa4j6MLfo3l3z4XF2xgg1WktAvkm23PO6lNZY=;
	b=cr5mkaO5MZyOXCVe51NwoAAQKgwWiJiyfVKhcFdiC+TUNPVngYVoNdVzBcdhjBezNqqD
	 dUhIHD0jAgsrn29qXqdZrQEBI1XKqXmefjr+lY6FSE+7KSgCsYE/hcdyemjuJZHsycET+
	 DCfwSjfVpVvrMFMNx4NlBsO7Z1cc07ZaykSMwyaBpMU9aa5PIXX9WM+6x2H0inADdj6J7
	 dE4Tnus8E7O2Fh7l2Vbu/TLGMEt1QHgrrFj8JAr5p6PyuU648+BhQxUKq5B26FLm96XUl
	 IE4HtVMMwFCXr6h2YVOUhK9nklAWWFKL9Z/E8KARSiQMilJJml2UyRWCpW+3PCL/9Rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzxiRlEY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17AE606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 05:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D17AE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzxiRlEY
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67989a2f9bfso1651571d50.3
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 21:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793596449; cv=none;
        d=google.com; s=arc-20260327;
        b=MZ0XHFfdmrMOoZeO07Yedbtj8ifXtDM93wcS5hnwrfqFooCEZNF/4qcu1v5gwZ03F+
         DeWcIjxpCDGD4HtdMCH4EDJ+QVnP38m0j9V97OibxHmNM2A73tqz5/j1lBQBaFDYz/yh
         KZ0Igt9vknfyhQ6uVcCCEdcfwQD6D/bZQMmBQw+QDsaWjktHwUDbt3Wr5VGioVjsAwwf
         Zs7RRMFGnKOITaiOrmC2CGK+CqrtO9TTsqFtez4nEC3Zl7G0xhYEoOy8sGn5I5MZCBNx
         PP4NmIiWB7JPV2QeK4UWhc3tWTl7u5dHFEwNAkSsChS5KrHseRfmvVRZfHWXYDUF3L6q
         csDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v8urwWaa4j6MLfo3l3z4XF2xgg1WktAvkm23PO6lNZY=;
        fh=DIdpMjtdAE9N1mFg5qswZ65JpIVyfeG9MXPqypMYsgQ=;
        b=KI04AeZsOOOa+QlWRlgkU88Ih2bY6e54ZnZGWwt1uigSKqPQxjIHtatNjP5TXzIxSX
         6i7+g2j3sQ31TzZ0gj5cqDW0eSKX7JP2zKlqVZpSHJEoZY3ERri7PiA/YfAfhym7DYLG
         JgoX/Hvaf64dyVx5mnw+GOHRq08viCDsFizZrlP/Lgu/gxrKgXuCWvgdx/GXjmIYYChR
         Vwha4krNM5NF9GzE2CxgVjrzl0zfdJuJmwG3XfCt8k5EZ/c+PTCkiZ44HLfQwC9HTr6y
         jZ6BGYPtm5CHTupRqFVzjvrt1G5XjAerDnRiYte2u7VLrCMvSpRzkVijHZbwpWIJPYfO
         JkDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793596449; x=1794201249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v8urwWaa4j6MLfo3l3z4XF2xgg1WktAvkm23PO6lNZY=;
        b=pzxiRlEYo/Ud2clGm92Z2Nc+nPMSTo5A2jvtHpEqc3cpTfPP/45gQBmYZvBjfwZrES
         7xSCQRe+Fet+9w3qh6Ex8XRsZSJgLfxOKRppVXDobRX4J+o1qhJydRf67EkYzExP2Uok
         ENjdP4oWITjCEGdcahatfIou+Zfw2DByx0xQmPLKJGvekvC9I0xg9/T6MV4kZARwL37h
         ZTvR9O+fi1A//KgIKF59HOWBU+YIcXBRJHp6qacYZ50zcUR6diwPqH88gJVPSmko46VM
         KXClWOTa74D4cnflESOCBfsRI2IXwDgPJruGK49ryiSvcf3rkcdhy/nXJwl6zx5h/jSJ
         C3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793596449; x=1794201249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8urwWaa4j6MLfo3l3z4XF2xgg1WktAvkm23PO6lNZY=;
        b=pYWPrG1O8KfQ04w89q9KkaflE35RzWxmtsHn65Z9xbkbCryOz8pQkQO/IWdPuGxzmR
         PObNQ/dnhaMU31qJb8+Dd58MNHa3fFIrUgFHHeu3QqFhzdVaUEz85XOshJ0ujXt9G4LT
         4KwNmzv17z2hD1+JRGAh5xyTtFZITJWYyX24khcfVmX+14VEpvbm2BYE527ry+U1E8nn
         QNQa35a3t/obgdri8xVnp++xu4W2LqNKMiOplySGa6+c781cKBBdFd292e1roSUEUlxs
         7Z7f7/pHrQ/R1pIUE2NU2oarjgQAG4DESrdVW7EqV8FuyOA1lM5/XUP4g82lwFj0fAbt
         5c1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxwsdadsRES98Xf7rv58p84L0vvYiVNiFrGSAa4OhueKsKM6OIdz2ICgD7cEL+kYFbBGsdlFK4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ae04VzHKDS4/KCvlALUZMIKCxIpwzN+SX2p9wKdqP82SQ6/WM
	Pndn/bi5iSerc3WRSebo+uvss2IKdTGvWUhPB5RFaFGTw7YmqY2Rdo6ElaeFWR/uiAvJwPL8rF0
	6j8UPRp/mhlrTFcnOv/TCMJiuTMh3v2g=
X-Gm-Gg: AYBFou1jIv8mFLisyl4yCYvkxizq6LI7jyiYDsgoSDuJQsvuno+YzRqhAklG5/xjfLR
	BxEnXTU4+mVhdbnapNgYskKeiPbjoTXTqnOUGcQBkQ7GmMIRmAS7xpzS8RV6grd8LwnHHQzZ9Kf
	fXCcqi9m9UXRpwRPZGmHt+hMkmREp1bN0juF4z1uZ0jMA94QpIrKIP0VG+tyyTcGivx7bdsi+Ji
	e5kLoi1kVsGGCU4meBmMrqa0+T7WweA6avuQLRB9LknsCgGeR8EiAMT/7nmXYHlgbFLuR83/oBQ
	6YnOHzfmLi/5xEhgmbsdCChBtsDEQK4lUZCoxwGjy8nbEGGOl+YnSgFp8PMsvM5idcG9siAWv8k
	ATN6WRxZaevs+AcaqasCH9kPn8j9JO0qR4F0n
X-Received: by 2002:a05:690e:dcb:b0:672:bb7e:c919 with SMTP id
 956f58d0204a3-67ba4c909d1mr4822552d50.2.1793596448567; Sun, 01 Nov 2026
 21:14:08 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005-i2c-xiic-rx-fifo-v1-1-0177ac5f72d7@nexthop.ai>
In-Reply-To: <20261005-i2c-xiic-rx-fifo-v1-1-0177ac5f72d7@nexthop.ai>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Mon, 2 Nov 2026 10:43:56 +0530
X-Gm-Features: AclHuK9Mvr8Imus9GpDjhEHLlkYTTfWG_3Dm8Qn9Rw_Yjm6XgiZ4JHgA2iLl30A
Message-ID: <CAKfKVtG4oCxJEvsQEDMxZSLbjSgzTxwMQ8Ky2Q9FtN3=6F+_rg@mail.gmail.com>
Subject: Re: [PATCH] i2c: xiic: don't fail a read whose data is already in the
 RX FIFO
To: siddarth@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:21=E2=80=AFAM Siddarth Chilukuri via B4 Relay
<devnull+siddarth.nexthop.ai@kernel.org> wrote:
>
> From: Siddarth Chilukuri <siddarth@nexthop.ai>
>
> When the controller is the master receiver, TX_ERROR is set once the
> core has NACKed the last byte ("transmit complete" in PG090). We have
> seen xiic_process() run with TX_ERROR set but RX_FULL not yet set,
> while the RX FIFO already holds all of the remaining bytes of the
> message.
>
> xiic_process() treats TX_ERROR without RX_FULL as an error, so in this
> case it reinitializes the core, the data in the FIFO is lost, and the
> read returns -EIO even though it finished on the bus. The next read on
> the same adapter can also return stale data without reporting an error.
>
> Fix this by checking the RX FIFO in the error path. If the message is
> a read, there was no arbitration loss, and the FIFO has all of the
> remaining bytes, handle it the same way as RX_FULL and complete the
> message. Since IISR is toggle-on-write, only clear RX_FULL if it was
> actually set.
>
> We found this on a system with several AXI IIC controllers in one PCIe
> FPGA that share an interrupt. It only happens when at least two
> controllers are busy at the same time. With 12 QSFP-DD modules being
> read in parallel for 480 seconds, the failures went from 2083 -EIO and
> 1158 reads with wrong data (out of 11.2M reads) to none.
>
> Fixes: e1d5b6598cdc ("i2c: Add support for Xilinx XPS IIC Bus Interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siddarth Chilukuri <siddarth@nexthop.ai>
> ---
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
