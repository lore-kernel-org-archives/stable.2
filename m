Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337562;
	b=iOG0NZjt47d/qFI8X39DkvWVzdKaAJVn7UIx4Gv3O8m4FYYGBtcJuQvIu2LkyfzErJuW
	 niOpFOJx30k5ySUTh3WjRbkViUyvRyoUERGvfCsrUk0L2X8cEtGN1RlqTQdpcfU8xu/BW
	 ExAjiF+6WG9w9cmAOjHYpWZPc5WHD1fxCPgS0oYzPJhztG9ACLza3ZQl1hD/7lm/UoX8B
	 0jCevk+BbYIkn4xt+JlM/RUScp8i/VGaet9qZOp4MrAu+XWOVI/nBtX641xYmwLHm159k
	 PPzFlXtD2AtnKGftGxJKK0z7TBr61slkaRQgGC08tbVGpNGvEq9qCSauoZrmTM00idQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=WWnZldioVaIQvBqHhtWfm3ijxoimf6A6B8W6nEeMNyM=;
	b=N2VPkgoH2CPYmczpp73mMPbAmEvQhX1Ln2T2qjzrcdtBvfrU6MmB/BRNumjrhudbJa+E
	 3UZQPMkv7n1QyUQQtzVZvzUOMDCH4kL2c8GGjV2THSAAFlJIrTsblyetW2jBnXoigGniO
	 0KcFCUR32vYOtKQ6AObL+8sM/fMJO8Wj1dxu+VwME+d1dcZWM4myNRuwmv8C2AH4ib6eS
	 jT3WZIyAUuiV6H94iZag3Dws7umjWK2W6K+9c74nGtagBpihjZvKDTESJEtTA636jsJbI
	 cUSQVRR7uW89z7ju2xiMQ5BsQuaH2VOm/wL62qtCLBnn+jzWQmxM+rfaQX9Z6cjuiNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--atifashhar.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eFtwUUhT;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D77606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6D77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--atifashhar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eFtwUUhT
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3abfcf726dcso3284731a91.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794337561; x=1794942361; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWnZldioVaIQvBqHhtWfm3ijxoimf6A6B8W6nEeMNyM=;
        b=eFtwUUhTY+0jkJqJtGdXrL5foXpP7zDOhBd6CDjTlQ0ophu8e90pUUoNjyYfZZ7wL+
         q8idMATXLqolvhlA5UvJ/oTrp9S8A9lVYFtIrGE64P1miOOC6EscjOCOrYg/GJ/lLyLR
         0fpuby24nRonI4lK+Q1ef8mfZ9eWABhd4xeXSEI3rjZWJ665uHUS/DMAcNMewJ14/xv+
         2LW5vlCMAyASHQUg7bS1znXs3C9zIc3QMVpPwr3HBx9XAP2iJ8rBQmm3YA0OS4SvhdQ4
         nsqST8gyN4jyHc5mmZ3mkctgu06rAdJbxHoDnQ4TmETaeIMgtZWDOREohyMR7RX7Vv56
         g0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337561; x=1794942361;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WWnZldioVaIQvBqHhtWfm3ijxoimf6A6B8W6nEeMNyM=;
        b=jsJ4j/7FwNRNUzYVq+5EaUZhcY/nzbiU9YJTV1xnfZI98teLL0b3XiD85od43q+bVa
         oK0wxyVIQ0kIsuldB3fnV0hu8Gz0265UwrigWIukXmwfzXEmrIfDNO4DsEw8gN/LrGLi
         ZhRvUe3hSmdI9hZaQWZIDgu2oLWFUg/Od2m5CcUH/NU0+cdqmrM8ccbeFmvm1UTZG4q4
         G7XkhL9ktJCBsZ6iUD9jLbWLc+ExBeUXi/trHmGMj1tmu7bgG1DmIVOnz8o6atV/3T1m
         fe9awbfcQNknxwM6UqKv5iOy96y13KtdH++ba1vYzt1aZ/TzBQC+o1wpAheqp6YRcSqr
         gLaQ==
X-Forwarded-Encrypted: i=1; AL+hErFnyfNcSbfNGvLBcSwpVnb6TrFXzm4XcMJh/QOv2M53b6LyvYvruSebGq2NxEcccrlFNP6Ub28=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VANkMNNZqtEY0XYhu3sVh2s2Sso0A+7XD9GxY02IO5wfDo6TA
	nxwaEZj5BUrBXSJ925sz5EsKrb83QYuIMjwcbQr4BHmyw3VcQ0IPQ10/UkEBSbRi27gPYH+11gK
	NelET2qWSpcHBbV3OYvMpRw==
X-Received: from pjok24.prod.google.com ([2002:a17:90a:9118:b0:3ae:c243:313b])
 (user=atifashhar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:524d:b0:3ad:ce24:acfa with SMTP id 98e67ed59e1d1-3b166c8500fmr3498740a91.20.1794337561037;
 Tue, 10 Nov 2026 11:06:01 -0800 (PST)
Date: Tue, 10 Nov 2026 19:05:59 +0000
In-Reply-To: <20261109102006.GJ176724@black.igk.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104133745.1432212-1-atifashhar@google.com> <20261109102006.GJ176724@black.igk.intel.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110190559.819337-1-atifashhar@google.com>
Subject: Re: [PATCH] i2c: designware: Release slave SCL hold in __i2c_dw_disable()
From: Atif Ashhar <atifashhar@google.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Atif Ashhar <atifashhar@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mika,

On Mon, Nov 09, 2026 at 11:20:06AM +0100, Mika Westerberg wrote:
> > +	if (tx_hold) {
> > +		regmap_read(dev->map, DW_IC_CLR_RD_REQ, &dummy);
> > +		regmap_read(dev->map, DW_IC_CLR_TX_ABRT, &dummy);
> > +		regmap_write(dev->map, DW_IC_DATA_CMD, 0xFF);
> 
> I'm not super familiar with the slave mode so adding Heikki just in case.
> Can this cause some unintended traffic on the bus towards the master?

No, it cannot initiate new traffic. DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY
is only asserted when an external master has already addressed this
controller and initiated a read transfer, and the slave hardware is
actively stretching SCL low waiting for TX data. When no slave read
hold is active, i2c_dw_release_slave_hold() returns early without
writing to DW_IC_DATA_CMD.

Writing 0xff simply satisfies the ongoing master-clocked read byte
while keeping SDA passively high (released via pull-ups), allowing the
external master to finish clocking the byte and terminate the transfer
with NACK/STOP instead of hanging the bus indefinitely.

> Also use 0xff instead.

Ack, I will update 0xFF to 0xff (and wait to see if Heikki has any
comments before sending v2).

Thanks,
Atif
