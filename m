Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794656503;
	b=qJDDz0PuUAvePFlYx3zkW2JQtWMEsIJtqYa96A+K0UNxzWC+J94D+Pi+kAFAJpbFNJBU
	 Y2TSipXZHcpivHoDkwJPp3Wq888UjpJ9kvRsOdqBYgYssxMtv8deSeOm14ExaVrhik8B0
	 x0FBGxe7DRI0lhNOKcGxfuTYH1J/QJA75/lWo1ZsH3HlZtktks0s/wbeR0MGIC/BC1ANP
	 dc93CIvftLO+78Xj22w0PZxymdV2pT2qecta0T9JWbjFgSmUqfYJb0qiRQvQKbzJQ/gyV
	 QEeR+ISs/kD4aFtv1l8+TvV8/uODYfYqho3PNlTtlDF/K7neFUCT1xlSByLw2pdPdXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794656503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=a/fji4ANglWLhnM1b925r1xDhw6BBJRmXgZEro3KYGA=;
	b=YNCIy6bF3J8e4fJlIBMY+6A+huyvrnGYgdmc4mEfsWtWVsMJym8ZoZJA8pDvwpXtsnCj
	 M5OLOUHJpFkclb+EcP1IeC0DT4V7PwW9Rz/IWi6ln2a6TsZNI+Y7OlubfQxPICK6zfiN7
	 BoQG2Xf2T/TuHSEFVHTZUJIrSR6yqeTP489nv9sDDbleh/dvc241nYjx1Ucjr6lsFKiNQ
	 0kpvzdphBQkCu7XkU42iQxDgof0Ma1EMqpKVvgKfrwhT/epw7PmJP1O6SPz3L2EL1Qw8Z
	 CHMxvmK8MhLQZYxjqxTkc8SnIZdRSjRZ41ovfq2KJ7BbA2gpW+3jmnySQRgk5sQ2VYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flashbots.net;
	spf=pass smtp.mailfrom=flashbots.net;
	dkim=pass header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=SfhNW8Bq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477B606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7477B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flashbots.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flashbots.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=SfhNW8Bq
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4932b13c4ccso1678904fac.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 03:41:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794656502; cv=none;
        d=google.com; s=arc-20260327;
        b=f/vnwGgGOGgF1zJbv7lVjNHXGH22ZAJ8r2b/DvbF4eHjxVem4qrwlWL1GmZTrF0K/n
         /z2+4N+PXowf6aSRRW/22Em1Uk+xF6PPX9rgMq5KkWtmO7RpN+yVi2EN8BomddoJhWBh
         II7PNaw2uKOkEWnbNmcNcJ3L/MRlCMIMysLpQyHQD653ab80WtjDcgJkoqkXK/xdOFbT
         weGN2ebprtylx3PKOON/YX5KrF2e7heiThNRt5y1BKge3Mp5lDGBkOJFsxNhLHil+KZv
         uSjIauA921AnT4nKc81gFmO4et9ydLp6dzc3SsutPXdnBhtGnoGm6FEpin76Azzv0NGN
         MSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a/fji4ANglWLhnM1b925r1xDhw6BBJRmXgZEro3KYGA=;
        fh=s5uiBRi9s3aFEkn3b767UoBr5M/Nei8pHWd91dscWhU=;
        b=kk0AidkLvyx87vwdh93FPFOheMTWqm2pR0Uw7e0nPSqP2aU2ZyRcH2AE2NfwFchM2/
         m81Pc0TjtoNcNNmaXw08Ql9l7j+WgL0cJMqS7XnwTtwwXq9kLuX+lPkLbLmEdtIDSz2z
         p2qTYjd2vBySWVrUBdy+CpjKvWSlUXhFUTNegmmoofoeS+d9QvC4x7GKBIgDk40ZtX6L
         xd2L9IVfPyDkGNixDR2sGG/VwYervVma7FStY44QYV1ViYJfw+CO7KhycRkeORUmyB/g
         xf4PyMlREec1Ir0aAC66RrU9lVHi4sTRlyX/XSbFtrz/DQzvWFZz2M+G1mxvkb3EQYMK
         rygw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flashbots.net; s=google; t=1794656502; x=1795261302; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/fji4ANglWLhnM1b925r1xDhw6BBJRmXgZEro3KYGA=;
        b=SfhNW8BqVu0CW4poXzqUm6B1oWOd8eNStJMSTQDKrtbRdeOdJsFzB7J3HIZblAIcpf
         cac47QrNa/PWVHqws13sWke4lBegqC8KZsm602qrQe0sFYzdoVy5XjXIApeK+MBOPq9a
         l4lrtkdGzjLv8+Vv52PJ5xLotZzYkWHbTH9GJC0iuveH4RjY5rE45gbE53Mcs62ic6dB
         TiVkC9oyZy3LNgrg8azjGmBNPqIEQKjca+D8ItZ0McEadaGBm2seHpR1gQKSTsI7+cpa
         y9r9efImzZISYuVHBneZ0GL85iZlPgiBP16Mkv7ac2NftlWKN1nY8MBxsPRbz0yKI6rX
         GQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794656502; x=1795261302;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a/fji4ANglWLhnM1b925r1xDhw6BBJRmXgZEro3KYGA=;
        b=TCR3EksxLBM22dzB7jSO9te4tvz5S4kDgyRNnBfGuI/cfjUD2YEd9KUWKfy72NMU6E
         bFwKOKLViK2+Ap19tkibfgniT8PiMY5enT+fqwzcE0RcMuvwYhAUFu64j9C6td3+InwH
         zWHYoUEiu3oZ73xFU5c89oUP/3J4nvF5l51PWJdj6ELq+Y3LhMXwFuZMdUd1/wYeYSA9
         nuH8voxvpSa/xNqKvW8NxnASrp9S0CQLYIT2vd8xPLXmvqTQ2Xkw6PBzEL5BNswYeZMH
         LHQIMuVqfAkxICKANDY48zS+tepUgXbGbQTLggb+yppeEGKQQ3NV9wbWAfucopXYz06C
         44+A==
X-Forwarded-Encrypted: i=1; AL+hErGn4H1h2RNyIbl+lZDZ/0s0NXLiC/Ew/fjRfcMhxattsALhO+79k8ts3atZLYjvicyoayK0Rpc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nautysvoBJ5Fz6BYwEt0JmDNCbpnitkeTMQO8Pknv4yuUQJ4S
	viIO3XoL5DADnFv1V15jjbdZdU1KQA3gnMdOFHXSgDHBrW0pHZqDz9UTkhuYIr67DFoq/ZacAwJ
	rF7tKxBZoiFYR7FM1cxQJTFvjOF1mdrrlzRaCKmRlpw==
X-Gm-Gg: AYBFou1mDNWG04Aqk06WngywPymxqYINexKmwf+AlxXiGWPyTEtRFW21UWp5jva6Wns
	QHYxdrmxr97wXvlPS21Kc4hz8RDHx7b5LjTe0gm280i94T30eIESk2ePdIHtx+M/6wR2P0XdR76
	/BQVAefW7fDRKL7k5huPb0kn6Yx8CE8LZxsFQs58eWLGnSm4k3CpTEIbDaKT1DTy9YR26Zv/m2S
	35POT8LWw02OVBJ0oSpiv0RUoBW7SFYiLhkjMjSDm2vXVSXSiwve3DPHedZKzhVSw18wBvGI2Vz
	4WcudjDmeXarFJ/bARYNKl9JcaGLN5cGP2JEzSGcIEd6Bomkhv0Jk1YdOJ4n1cG4yDovY6eFcaq
	WCs8Wv0t5aU5cXuVmjwfuDS13DdEW7nQ7842e1aL5dDStFKosvN2nRkxVxVVIHP32pnWKAzHDl1
	nYomfxqrAfajsjnhZIRn9ntfQ2MYxryfo4HjxdEj7vz3JHUJ05K+oqxegC2C2/wiJOlCdL0ZUZ
X-Received: by 2002:a05:6870:6c1c:b0:4ad:7ef2:6005 with SMTP id
 586e51a60fabf-4afdf445b53mr4823353fac.11.1794656497656; Sat, 14 Nov 2026
 03:41:37 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
 <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com>
 <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com> <0f9ba1a6acb57a8c126739175b4e38dafac08c9d.camel@intel.com>
In-Reply-To: <0f9ba1a6acb57a8c126739175b4e38dafac08c9d.camel@intel.com>
From: Moe Mahhouk <moe@flashbots.net>
Date: Sat, 14 Nov 2026 11:41:26 +0000
X-Gm-Features: AclHuK8iaDFWSE6FVS5GEQtiGzXP5xPODgzuL6kYZ3-GR4mSvXxwjBpv9blLgS0
Message-ID: <CAKV3HMMfx4APmardWdtL8yhirXMuuBQMZ8xrtowHNRnTKXNRiw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5B=F0=9F=9A=A8ext=5D_Re=3A_=5BPATCH_v3_0=2F2=5D_virt=3A_tdx=2Dguest=3A_Fi?=
	=?UTF-8?Q?x_and_speed_up_the_wait_for_a_Quote?=
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"Miao, Jun" <jun.miao@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "djbw@kernel.org" <djbw@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2026-11-13 at 17:33 +0000, Edgecombe, Rick P wrote:
> We do expect quote execution time to change, so this may not be optimal long
> term. The exponential backoff could limit it to 2x the real quote time. For a
> long quote this could be pretty long.

The backoff is capped at 100 ms. The 2x bound only applies while the
sleep is still doubling, which is roughly the first 130 ms. Any Quote
that takes longer is seen at most 100 ms after it completes, whatever
its duration. A 10 s Quote returns by 10.1 s. The current code adds up
to 1 s.

> I'd almost wonder if the guest would normally be happy to spend more cycles on
> getting a faster quote.

I think so too. The cap is a single constant. I can lower it (10 ms
would mean 100 wakeups per second, and only while a Quote is in flight)
or replace the backoff with a short fixed interval. Tell me which you
prefer and I will do that in v4.

> Can you explain more about the quote use case you are targeting?

Attested TLS. Right after each TLS handshake the server in the TD sends
a fresh Quote. Its REPORTDATA is the hash of the TLS public key plus
keying material exported from that session (RFC 5705). That binds the
Quote to the session, so it cannot be cached or reused, and every new
connection costs one GetQuote. Requests are serialized by quote_lock, so
today a TD accepts about one connection per second, and ten clients
connecting at once wait up to ten seconds. With a local QGS the Quote
itself takes a few milliseconds. With patch 2 the same ten connections
take about 0.1 s.

Session binding is also the fix for the recent relay attacks on attested
TLS, so one Quote per connection is becoming the norm.

For the long term I have event notify working on top of this series. The
driver uses the interrupt when GetTdVmCallInfo reports it and keeps the
polling as the fallback. Over 120 back-to-back Quotes at HZ=250 it gives
2 ms median, against 8 ms with polling alone. I can post it as a
follow-up once we agree on the polling side.
