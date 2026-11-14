Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660138;
	b=gnF2UIUYA0f6BZVI1HgkbVbpHwG0ssELfc9ryzaU0zHroj5xrw4lnonHxt0I3+JZbYjP
	 3RrY0c2tYyqe62OEuwKtquWPtUv0iXlZIVOl/SLkIfF/ZeNhqVccoz4YzWPscVcUJVRFw
	 pnYyymxOH8WLESKHWG8/lIhK5VOq2rOEGAQ/8CAxFHQXwqTUyzR46Q7PDT7pGKxwnUp5Y
	 iT114NgpItbhqmn/CZAevmtHkTal2LPOtZCgNfUzqXEUICnhSd4nJ67iij47zsexVHRIU
	 SUw35kbdZia2j9b7QU6Vw0yL9pmwieo+3zKlMEGXUD2Sg/ilk/JsgFopJh6Cm2kpwGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=C4WPmCztPH+KoFhzb/uCAJwlkmrIRFMhr6hpJOKutGM=;
	b=VbIriqcyR6pILrSGW03k82pSHTxA33REd21ZKRn1bfeOwxVdyyvZdng4/zaCm1TiMSeq
	 pTkz2aDJQJ72PEhQalXoC1fHd9VX+LetROsEk7wJyFynbkMAOK5ZUu0ge2rztvIvRJcVu
	 ze0gOwkK7fd5+uB8rAVtvztJ2f2Nw0PFjB9QENUMBYDYosM7whkNaozYeIv0F9o1ip9y8
	 pZ3qExt5E1plrcamghfYOpcczOqDolcxNK5MOj0gXvDwVGPEpOfKNPjfOsxkNuNqRNHw3
	 1Gd6+HzByQZCpM9Zkp3gxNZXwIAPPstkTxIvSzA9qhTQ0PRU56HneRfptTyDwJz0Ybg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QjRgsCuA;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3880C606A330
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 12:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3880C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QjRgsCuA
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1438d9363fbso977734c88.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794660137; x=1795264937; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C4WPmCztPH+KoFhzb/uCAJwlkmrIRFMhr6hpJOKutGM=;
        b=QjRgsCuANNFrlvin3D92M2sMsLDO28F5Rz/dFNYzpImcK+hth7ZUAFAfqgm2cDEOTA
         rHSWlbG9Pmgd4pwMUOfqFwGECGjIHM26mF+laqI4pBszc9MjquWfPH7/7540zzFa7cTD
         amzn5sF3ezrYD/7TYUp8lAoijwqHCjy9OUhzzjHDX7xJ5OlFmMfB7RW+30WDAro/5VN0
         1IWOVigmc/lOGXztMhFSOGsTLUC+UuHNf1RM/7zlUu4wwvrqlQJfW8X01u5EgN6cWvtU
         eaKPdNLR4puGqIWdL5aRH2pAx20BXITPiS+bSQeu57eHzPyOoG4x+9wddO5Qx2PnFLKz
         tcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794660137; x=1795264937;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4WPmCztPH+KoFhzb/uCAJwlkmrIRFMhr6hpJOKutGM=;
        b=2TEoWuRL6DT6lg+W/OpPCFXNk8O695QqOvcOUQxK+3ueQVYbCKn4pBvMWe3CnmTigA
         I+zRfEI1A+Yap3NtyXX9EeVeZp5xXrFlQWuQWL++khQl+wc87JHxs8W9Psquq6oYjvpe
         U0ni2KIJVyzb6VY6zZIpuUGIMwA4xU0pnzWii06xasjRGZhspecrdDESwY8GINYLcrbA
         E2OVtndVgOn2XLscqJPCNfzg3zrQng6ANRnfcHmE9WeWEyZJMO8WY/1T9xMBT0L19Mzw
         kRaxf3cTwhYnscaiZKEBUtt2soKyMNVYynnxvCqFPR+r5lPLiXUNrPGLCZ9fyjAJiVHj
         xh5g==
X-Forwarded-Encrypted: i=1; AL+hErEYCEMqb9nsOvz0SSACPw2DqucffEfhjLkcdiyVpqO4oIYYvTud+xIR2TWajeO/o+lX324sqTE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9N4BJuqiIZWR+e1dNyXre7Veaj0mFTYEsBl1OfEGGYYP+tunoM
	10h34Da2SfYgvant1Ma6HuisIjIZ689VDtMhv+PANg/V/42Hn/CIbiLv
X-Gm-Gg: AYBFou1Fi19UaF2TBsj9KgnIt9Sc15HOefeLqCZShI443hNMLSjKB9Zfs0roKsRNwc7
	5aJ4ze2fQ0KeJxNtUxqnXjJK34hufQ+uxvKPI2aR3HT3uJd/GlwSjh7/+0Qhq+hHK/qtjKsr/NS
	r6VmPOZ1nv+MZ+1Lv/w3P1Giw3mamcTLF4wBLco8WU4CU7tUhI6cxXKBVACwSIzZnVDYnHxEBhk
	+RGSdfBSVzzScHu0QO/raOIP6vlQFtwx7fdcSj8J05MS0PuYGHDK8AfmoXLPsD3RKlSb3ksTg3Y
	YAptycxhykeN2cYEqibu6NlIAN7JHdpzCccl3/3vA7ejIsFU9JJ74YsZFKW4sc+viizwnDa8VZZ
	IMsvCtxycM6meKTgbnCzPCFYOjjbPutM28XMcF6p4aWaxrGn6kq5Vl/J7yE0ShJiqWU6FCUJgRG
	9NHOZzoAwcgjDF36jTeiNxVZsOD+Pd9XeN0qCcohTOb+YpZ3Otf/xWpILDsOp45o9rtzSaM7Z+H
	qmK7kUHRPwEy7ZBVhFp/xCA/o24Tk6HiulnE1Z73/+mz1wDQVMxCc3jchdXkopZIWmHVam9YBe1
	Hn9/0l4eycDP7CyDN/iUW8qKbGk1b9gajHuP6Qn/UKSUyh+jAw4bjWjKkOavVDk0cLE=
X-Received: by 2002:a05:701b:4294:10b0:1b3:b3d5:566f with SMTP id a92af1059eb24-1b5030990dbmr5086025c88.11.1794660137166;
        Sat, 14 Nov 2026 04:42:17 -0800 (PST)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm16550060c88.14.2026.11.14.04.42.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Nov 2026 04:42:16 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH net 1/2] tcp: avoid wrapping Fast Open blackhole timeout
From: Esko Mobius <echoowall@gmail.com>
In-Reply-To: <avVX-3s3AYwtxQe7@google.com>
Date: Sat, 14 Nov 2026 20:41:59 +0800
Cc: Yingjie Wang <x-professor@outlook.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "edumazet@kernel.org" <edumazet@kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "matttbe@kernel.org" <matttbe@kernel.org>,
 "martineau@kernel.org" <martineau@kernel.org>,
 "geliang@kernel.org" <geliang@kernel.org>,
 "ycheng@google.com" <ycheng@google.com>,
 "weiwan@google.com" <weiwan@google.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <EE7A0514-C23D-43C0-9C38-CF15CFCF8AEF@gmail.com>
References: <cover.1794325665.git.x-professor@outlook.com>
 <340d9f1f96e235642e8b47b5e7c836a18de8dd56.1794325665.git.x-professor@outlook.com>
 <avVX-3s3AYwtxQe7@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)

On Thu, 12 Nov 2026 06:15:12 +0000, Kuniyuki Iwashima wrote:
> No one wants to configure 80 days blackhole timeout.
>
> Please apply a sane limit in proc_tfo_blackhole_detect_timeout().

When picking the limit, note that the product wraps long before 80 days.
With HZ=1000 and the maximum multiplier of 64, 64 * timeout * HZ exceeds
UINT_MAX once the timeout reaches 67109 seconds, about 18.6 hours. A
limit of one day would still wrap.

On 32-bit, time_before() also needs the interval to stay below 2^31
jiffies, so the current expression is only safe up to INT_MAX / HZ / 64
seconds, which is 33554 seconds (about 9.3 hours) with HZ=1000. So
either the limit is derived from that, or the u64 computation with a
clamp has to stay.

The same applies to net.mptcp.blackhole_timeout in patch 2, which uses
the same expression.

Thanks,
Yongjian
