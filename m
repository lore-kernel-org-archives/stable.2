Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067791;
	b=v71Zal1bisjBvRZn147TNdqU0t2+3zp3iAxK35olirpFjyKHRr8HM/p3k+3+7TqE6/QP
	 NU8MHLeqhaBgt1oFx2dZYeay7DQEVI0zk/3wV7l72b2C+CucTUBbmYyOklVKFq8wRgHjC
	 UhxZr06ipWqYH7msI85RD7aewz9LXYw7zN+huELwPdzsixwz6Kmj2zJ97Od7lMjAWtel3
	 ecSQjAu1ljnhH5EVPpBiF1wKlhPTKqEbelDSFx30NyqTBqFSI+ZwnsHJrldItP/ShHObE
	 Vweqnvw4mSIZ3ZQrf/tOLUwUKKFcohftWAeoqklO4jSW52cnJjEg4iZxVkL2qEhEwMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=mnZnYd1uErokHW3JZtcuDus+QTj/bsC1tUBcSjVgMow=;
	b=XLysxyS7wcu1AJF4dRxMrHp58ZInBHmJv7RmLGd/qwtcVmY8cdZQ5WMlEwHpt3hicnWH
	 aDMJE55egmM4lUi5xGXCfn6Qtg3PI6uO6ykBEJiz9ZSYZ8ft0yNPehxK9+o898YGANqof
	 xnAFlworRQ9cjzJ+pPKLX5x+rNZ6OO28V7asNwZRV7DCHRTuYYl5g1yvfEbnCvOjKDNUc
	 Irc7KgrWgwp+yslbzJYAOHvXH4X/Mxnek5rxwc80VbQK/EeIT1KjfUg/JSdRz+Ogp7R3v
	 gzUoaxgM5sid4xm29FjlhlU2h/jIZZyD0kOu7gp41B9QI5IdVD2JRccmNoxxUkYa8Bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=csAroUZG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83737606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83737606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=csAroUZG
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-55c48582654so19025071cf.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:56:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067790; cv=none;
        d=google.com; s=arc-20260327;
        b=lcSYg5QN1rhG0TpzdJIGK3AgEpo4+yiPUww5uphnmmBN6+MAGAb+wyZAb9t9IEUMqU
         yWlWX+gf3Q/M652WRtuIEdlVFzUjvqoiiMmx9BS08jpNQHO+XW6Qxy9uHgmvsU++JhN2
         TtwEmysschxLKTUH0YHk1HXBTln1bdtD6Ec+YCOQ4yGYJRJpq8pMMQkieKwl+KoFmHe2
         ewceRzC2y0cj80HjkwHFX/eVYTdNtgjP9xITaOkSTHqGnJi+KLFo9pHyBSm/Qy6oz8td
         viwOON053sCl4vLfZxWpz6UNDma1x7+VF9sBPQZhK1tz8SJkecJpt41uubnpQbatMg7O
         iYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mnZnYd1uErokHW3JZtcuDus+QTj/bsC1tUBcSjVgMow=;
        fh=hh64WXw32xDCPRIwo8kqdpPDKtEO7rcNvFi6kTS088k=;
        b=MokhfJ+Fg28G/X7zUNH9q7WPGxMDDUErehM4bl+MS1TwPH/CP/+Ib96/J7uEUZSIVO
         V7DaJS3Tlr2oVhIIQedrf9NYNRbb6FuWnLKqozRPnRHscoxM9Agx+LRRqKvED9PkWNBs
         mI1sSIZaDkZ/NRMh8q0ygAoZ2A+bEZbWp+as/cnI/Mg6f4CPA+zRE2mpJE3AsFbT3jsV
         OY/3+dSbDH7m6lxQQc0w2IJqcFzjtxm/3E5YOkiGxWSFkk/1gOdj+nSIVnaN3Aj+OQxu
         lEImdJzvTAcERRItSTTV5nUimbd7gJrsvxU6a+I/1Mpb7BMJP+QOCl+SfLLKdRNv254r
         B3Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067790; x=1795672590; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mnZnYd1uErokHW3JZtcuDus+QTj/bsC1tUBcSjVgMow=;
        b=csAroUZG8+rlHC33rnWAg/z8yoZZkBbAll+6Ixis9S1JptlfgQBBwGTmzcb91fRStP
         Vdm3WIaPr9xoTswtb5+uwM4/P1UWRPVb3wFMWc2M+gjnJ6JJLY7NElEW0rfI+nJ2Eqts
         45yNiakWcgw6bVFF7uiVYEpTMWcwmYc+je3iitGW2RjKHFnjLffcTDh0VglnVFg98lgr
         w0RZxkKDF/t1nALGN2URHgR2ZWECQuTxRZsFqQwEx7PaVWM8ottmOsktPdz5UTCLLnFQ
         RG/M8b9kJFbHx7OpZEbIUXqw7UXn8S/0g3TgHSxOXdZmFEbd8p4xiCbWHJTitrluQUHO
         Eavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067790; x=1795672590;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mnZnYd1uErokHW3JZtcuDus+QTj/bsC1tUBcSjVgMow=;
        b=Y5WFgc3xMWP/OhOufJXuJI5NKWfDtTYMdyUAGQQMf+0p2DGloZUs0EPPp6pSRGUUzb
         Q9UyE8VY3fv+HpGOEnbnxgqdRTkjcJif0K+8nHHMudk8wPGnRz1/XoOl4uq4xkRrce2S
         6V1imPoRW5nu2EUuwed+87JiiP42z6Ik/0kpoDFNYq+ndgbDFp8ZKtBssiATq2c49rnE
         17d9cyfZULkJCabF8Ms579GPQGRHHncdnUCzPiRl/ciBAETwtcWYct+qn04iS4vUg/ZV
         q8XtApsonbDAfvVp4T2seKYXhLoz+NzHlkDBjM0OCOY/Z4G9nUsS/Tx3aCXPdiG4eyjs
         9mSg==
X-Gm-Message-State: APuU4Z9vl6ZWoMSCoxS0eMO4A1Z87XQ4shKkg6OwYFdywJT3td/Eo9JI
	k4jjbAjcMKKkBeayVFuPm4xBG+FEB3uU0MPClJhfevwOAAEo9vSoMtwNRyCKs8qdEhZtUEx333U
	74TG/hOOAYQQnPR6RkqFQuyNIHMbAkbysADz741jtjN1P
X-Gm-Gg: AYBFou16qKdqmuJ1eoVJChhgoIaI8626L4GodY7BBSHzadJW1WOXt7A8iWQAwCk29yX
	KPGtw/U+rvjx2a5L1rz9tgnYi5DgWNuYxYoHINnwuM4i3yM5YUFG8qoTxZ8mBjzURtWphWNh14w
	q2FxU9OoZB/WemByljApjIbBlGLQXnxKS9Y/Y9xJYl1fkLDe+ws2A08WYjccgBR/1IJFo4zZo2o
	m69J83EXfNKizk4JRdriDD6qh+cd+AIHPs2XGJ3f+FtK8oUd9EuGShCgHmADMQoddadAHpRgke3
	mDrMlh4L3NCd2pKP7Cqm65A0u3leLi3S213yxXsjTE9M9QwUJqMCV9VllzKF4ajAm67wjDZuvlF
	czKvtCniPecKPW4ZRJm9lB910t/F+yLGAvN8+cMHBeslZs6rik6xMJq7y37D9eMNMgmv+LSYr/d
	+d5zvdIgmcr2ayWpLEOw==
X-Received: by 2002:a05:622a:4084:b0:55b:f621:e7d2 with SMTP id
 d75a77b69052e-55d5a553982mr82620341cf.15.1795067790316; Wed, 18 Nov 2026
 21:56:30 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 00:56:19 -0500
X-Gm-Features: Aa3M54pTyqXxiigIKRiBsOD1wWBco0xT5X2rnoC-8iFR9mlDCcnWgnsDo6aKIlo
Message-ID: <CAMcAce_TKY0jMqggzwoYgB29OrFZYAi8Qae3Q2ZMVP_qKOAq1A@mail.gmail.com>
Subject: [PATCH 6.6.y] Backport request: beaf0e96b1da ("bpf, lsm: Remove
 inet_conn_established from sleepable hooks", CVE-2026-63865)
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stable Maintainers,

Please consider backporting upstream commit:

  beaf0e96b1da ("bpf, lsm: Remove inet_conn_established from sleepable hooks")

(CVE-2026-63865) to linux-6.6.y.

While v6.12.118 already has this fix, linux-6.6.y (tested on v6.6.162,
kernel/bpf/bpf_lsm.c:309) still retains BTF_ID(func,
bpf_lsm_inet_conn_established)
in sleepable_lsm_hooks. The hook is invoked in TCP established state under
atomic softirq context, leading to sleeping-in-atomic bugs when attached BPF
programs sleep.

The backport is a clean single-line removal of line 309 in kernel/bpf/bpf_lsm.c.

Fixes: 9e1026079c65 ("bpf: Add bpf_lsm_inet_conn_established")
Signed-off-by: BoBppy <inkxiao12@gmail.com>
