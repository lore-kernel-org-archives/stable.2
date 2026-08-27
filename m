Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8219D499F11
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855981; cv=pass; b=HBlKE0vGArOxzsKSZWMLiCCv9vOMkrEJPt9VTpa0xyaTNpD4iKHVVf6cuD+JsR85xNgmUOXhlehjcC9uxuVqt+YK1UKrotLpT6GcvpEtrfagAFp3nsFhrJtiR7fdf0+9KCtMeXHV7SE09/b7tRwj6Y/xk2u0aW7HtSboqMGWeF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855981; c=relaxed/simple;
	bh=445iCSTTCoBe15Hu3Q0tcs0o1U+eeAp83PGi5YJxTA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jmy/8Y6SADYzjtqIKfBrrNeXL2ucGG9nKoOcl3VlAG6TV+62a3R6kYBQlKN54UDVkmmnr1M52XjSlTlACi6aJjvIHkYh/5BlQkqU0NCC6d1rqAP3LUK2AhfsLIPB5mRTusFsWv9CC14aQ3yCzZW2SCs770IJxsVg9dH2xWnx/Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kM/LTmSz; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kM/LTmSz"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e7632b193so12480385a.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 11:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787855979; cv=none;
        d=google.com; s=arc-20260327;
        b=h78Nn9ldTtVAloh5bfxk3iosm9Mg5mrAyE49S58c2bJEXZqGdBiMjdFmILSCkmutGY
         +dhmjtQg91B8wlzf+P+yXwx3eCFtKYMa0oybn//la3c6AXqE2eAPcKQEoWRdZ4ZmEFEI
         4wF8qYLWO08m5L9mZWuS0KdzvVZkQ7xM3stVEsCGcomHr0T/t9Pap+iDbU6CZZy7/TjW
         h8TWTUmxgka+2ktyo1gOAWOdcjdnJw3tw7uLm09kwLiRkSlP3WhgEF3b0e7rOUvn7uOT
         ggq/TrYHPi4rOE/R93POqqOH2iLxdU7/U0IumqyGKAs3taY5iAzh11OhdT9GQshD5rZf
         6OvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=445iCSTTCoBe15Hu3Q0tcs0o1U+eeAp83PGi5YJxTA4=;
        fh=DrF2qftbRuzmtZYBDcUb8s1CoMQYNPIFaSAHHJEwcbM=;
        b=Twgk1/pwwo9J67LTs2rvYb6P4JW1PQP9sGc9osnKKRONmJzu1P7dci4W2jJXE3Gvea
         dIqOlbH9AbXbUhJtRpdHbdIiyBWugshi6wqWt1aqC09ft23RDj9pKfC5lyYUy3cbLe+O
         nBVLCJVan7ODjOomrEFJaPoPbi0R4park4vxSyrJ3MqpRdBCkV/5UDiaAVeXhnUDSjsT
         DScfwcOsVjpuNyMYzOgGxBewgcP39BzGIcfsZAHw2s+QClNCG0n63EUkT3rkpKfqEiar
         jZLdD1m9rJ5cJXs6/FN/f5NoYqFjN/RCtOwREj73CQSs66/S3oOIul/XzXEaSTKWH53d
         QC3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787855979; x=1788460779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=445iCSTTCoBe15Hu3Q0tcs0o1U+eeAp83PGi5YJxTA4=;
        b=kM/LTmSzoS6Y0PH8bT/wWDKBss0HJQa4+UtDuu4tsV+f8lcM/e59BQoVQk+TD3rHYf
         HRjMpjBdYA397FQ+PswQQ/mBIctZ0IAnbJEJMOEayRBlBCj7a+DHserTNqqBThW+pPVO
         oUpiCEwH3fQ01bqkvELj4mpZQe1HKZwpwrcIOoMOJWygu665SNII7aAbzMf3FJq+fc4N
         IH2Zo0Qai2el/M/3Q7BdQ7/U1GAFW/+Vk0Mc4dYRZRQV2M72Xcg7lqarVALQ8gqIZa7e
         gNF2tuGnFF5JYfncshb8qj3uKm7QHV9YpzGHxbaPfEqHAsyG1ulNX1BeuY+jUabnGWRh
         I8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855979; x=1788460779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=445iCSTTCoBe15Hu3Q0tcs0o1U+eeAp83PGi5YJxTA4=;
        b=LE0BlYB6m62c8Fkk5W5xwyVd2XWpL5QgclQ9wtwsmuUU5WYnlwBfdi6aUJh/W5SExY
         9ZwAdRBcSp9X9nl1uWLTS9SeZZ8Q6TXEupex0b16euRknMe/g/o6LHGlVx6srm3+OTXP
         Zd5SVlCT7wlavxhiMtEtwWaBhQdNM8FVF4OVpAL4QkqE+CAbpT+t81Es/ZGINdQUhLx3
         5rz3qeWFvj5pOekYNgAJzvCMnW4RFWMn7+NoLsPUpkYHQTfCdAktYNuJ5XrwDVgYGEst
         +utV6MCC1sZJIJK/HNKFYdfblHJcI2sQZasoG3qTc/a0kszxdTXhIkpEiw5gCE1Z1kD2
         HqLA==
X-Forwarded-Encrypted: i=1; AHgh+RpfXuakEu/Ya+SU7vqG1bFDJoQ5/rM+ZTGXyrjzrj0Id2rCkB+8siLIQUFQnRbScevA72i0UQI=@vger.kernel.org
X-Gm-Message-State: AFuF++klwVmHM9g9o2LgWJWr/ml6GGJBezbK0HXid72UPGO9K4vFIb7r
	F0fUMP1YjV3FHK30tDCDmgdNB1257l9PmKZ9OrqlFlv1cZ5BupU8VJy5yypeJ6s1jVi/VPGVt5y
	7xS3ZkAomTCkqQnTWGMQKGEG1idt3pGa7EY2dyjp1
X-Gm-Gg: AR+sD13xkKmWDfaO2JTlYoaeNujwMhOa+LL4OaKZSe7+0LKl99V2E1qQAiOxKyrpzhz
	1QHhVP2Aw+wzxQAYFHREeuBDNLibE6mQQVmp5uhlzVMBSt1BdbFxqiUm2HYgpFjehpkqGgfLldN
	W7MMYqUt6BUrsjodAZiS5RrUPz+oF3kpg9TqPNISd810CROj8IsPUwHrFQk5UQ2664p0EkQLJk7
	+KhARi4qDOuLdLVUdOxamgIJqVsXJ3klKtK3p72bHsTndMMjbE7D3sHjFFIAp39+L4ymNTy5SVA
	gccG7MsiS9DFsJ3ao79uE25+F6b/SAJDDQbBd6Tla8p5jhQRZHQ2yVIwJt5LHKg1fX9CQV9P5WN
	lcz2roBSOEqWtUdA6pUuuxe8r3PyXoSFkVv9mfx+2Vgaxc4p30jBNfCRrEdk=
X-Received: by 2002:a05:620a:a913:b0:939:2e1:91b1 with SMTP id
 af79cd13be357-939139b0e77mr79071685a.42.1787855973945; Thu, 27 Aug 2026
 11:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827182514.4667-1-zihanx@nebusec.ai> <20260827182514.4667-2-zihanx@nebusec.ai>
In-Reply-To: <20260827182514.4667-2-zihanx@nebusec.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 20:39:22 +0200
X-Gm-Features: AcwNN1VRhQVJWnUjimjnCssYVB-RsZLLiLw-RwPls-JFeJyYJ0GNI-z6p5Tnrm8
Message-ID: <CANn89iLL7g9iZ-pZZw321GFNVKKW=xs-6exMxeoM7=krsL2T3g@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] ipv4: avoid divide by zero in fib_rebalance
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, =?UTF-8?Q?Peter_N=C3=B8rlund?= <pch@ordbogen.com>, 
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 8:27=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> fib_rebalance() computes the total eligible nexthop weight in one pass
> and programs upper bounds in a second pass. A concurrent change to
> ignore_routes_with_linkdown can make the first pass return zero while
> the second pass sees an eligible nexthop, resulting in division by zero.
>
> If the first pass reports a zero total, set each nexthop upper bound to
> -1 and skip the division. This matches the IPv6 fix in commit
> d2c26c2911dd ("ipv6: avoid divide by zero in rt6_multipath_rebalance")
> and preserves the lock-free rebalance path.
>
> Fixes: 0e884c78ee19 ("ipv4: L3 hash-based multipath")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
