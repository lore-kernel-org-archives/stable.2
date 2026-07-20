Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40251416CEB
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555253; cv=none; b=YU/QUk1p5bUhDRzT8/kOROImD+veSap4/MX82AJzsdH0zON5AHNCjEjlpUaFtJuaMrROggjNVkxUItO04JXegIhkMPbIRXe36YFMEiMoXL9hYTCQR88nP30pXIbVk1o6eymjqsOfrYYl3BT/CiHC7f7xhgb0UUqXTlwWUY3oOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555253; c=relaxed/simple;
	bh=4yntPrZ75aFgvK8fRFr1GoNSyySukRHtLsnky+C5c6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+VxI2zRJ45t04Z0J/7awtqiXtnrUFjfAjFyWISMjXggzcrdOKXx5q/GZShQXRwI4vbqyC9SYwUaQcl/rS5jWNEIL2ugna0RQUjfp0IOUem2hArr6+iHnbzPQ9aG9GKCPPPxK3UyjQ/hxCoxhRjpE+6hKLvAsz9rJEluDY/Y0tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BzYs/+vZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BzYs/+vZ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49558ce01afso12009805e9.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1784555249; x=1785160049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0oaxpczoCU94fzTgvg4t1BTobNQ29rp5vCPHjPJ9yQw=;
        b=BzYs/+vZaGwQkp5INEgLsEK+x+Kyq1j3gpy5eh+IQXhI6Z6BmatdVL18pZ4E4GiQhv
         PlfuSVVmk6ZYaHQ+aENw04HeLg+WKywpn3Q9LaO3gnfoJQUSenJ9cjNgRdAXdUcId0jR
         Wn5gY+bxwgWM1IJAgIOFdA1Vm/9+Lpy75PMyItza+fCHNwKakpQcPdxpzaArhQJZiRcE
         aOqPMDdpExpA2DsHfkwucqn5L41GZvpEkXEaXza7RO3vPfM0yC52OlhvUFThvsWLMeCk
         cNTR2tUBH+cY/Qu6G4ORDqbcKBnaC9XHMBpvfkdkvyuaWQaMRmHtMZDAS0ET+xgPRkuN
         JDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784555249; x=1785160049;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0oaxpczoCU94fzTgvg4t1BTobNQ29rp5vCPHjPJ9yQw=;
        b=N8vinVW3hhC/2ivtKziP551EOufbFn3NcZoMrFp4bx+ZTTe1KczyK4x+WeEH5b3/YT
         s1wT70cLoYBxH9WN+7eP3w5q1DkfcMZZ5ryzUmw+3hvY8/nyU8nrlVr5RVsWh/UfNgnm
         BD7vkc3CzShRvTkT3+Ualo9vv76vDvfeNR2XAc4h23CTKXZ37szczd3OSKldKcBfEP0h
         t/HTYMMazPv8sKk/Q0xE88m/yA3UX7sbeW0j/r4aCwitJG2hCqB1QBGSwJ3WtU//FEtL
         pGF3/yOZ2athyZZ7xYS9FhOxaPPaLh8RJ96R33BN7DNGPUWClTI+yvMg0Z3/2tTo7doG
         sUtw==
X-Forwarded-Encrypted: i=1; AHgh+RpssLiZG5PIUJaRmg5B4XYL2Aot9PJN63VpoFRVZMohIiytk5zaUZ5dKP+wHmsYKs/XZMwFhI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyk4Zelk2/bcA/k6tgBxWbSMX++WR2k87RcDNK1+a53/9AibfS
	QmaXmFYKGLXszXHM57QzQx1fuA4NwuVbeCPBrj/M2/CH+ln/lOwY0QdRoq7H7dUkMxwp57Muqtw
	y9AjcIMHkeYEWhbrNlN4fW00tlolr0rTi0jEqfb+1qxuwUxcWDWVaUkq8nzok0KDq
X-Gm-Gg: AfdE7cnooyOGKacM+OpyR+Bh1XfUovoiR41BOw8D2p9aKFH247c5kKPBhHMSUJmKhjI
	qBUOPjffncASYoKza7QhjBMp5TQ9RuJffi4rGSfRrEpPoUcynp3PuhYLD7/fzaikN3Yp8mZJOCH
	mtVSIGn4NDqUeY4YkpJH3AFzYBr6g+3nYcOKwQ3rC9oJzrbhtLun+k9btMVV2hKqpKN57aUblL+
	Hyd7ZTk/6SxhLspse+EO2zhasr534Giq+vhh98GuldGGoFH6q5WLlT6vKCyONttH61l+yQh2GBH
	TdnCk4+o9+qNZ/4I9KErxAqPir9X4bdnEEuUZGpmBf90Bh8TYUYsSUMyzeu/w0lW7OTPnW2YB1c
	P0Wh3QJa7E/xcO7uQXCcxVqYO2mow3kP3JsDs1tD5eh1Pi+bQwQxXcd+T/Qd5SSeuQyMOfTyjk8
	bOeIqlSrw6TyB2lS66N1dEwXJs5PgyWmMLBjxWffS0bbsgeSuLFrQ=
X-Received: by 2002:a05:600c:470a:b0:495:4e22:5eb8 with SMTP id 5b1f17b1804b1-4954e226f16mr141625995e9.38.1784555249162;
        Mon, 20 Jul 2026 06:47:29 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:32cf:3416:35c6:c361? ([2001:67c:2fbc:1:32cf:3416:35c6:c361])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e496ffsm29626545f8f.3.2026.07.20.06.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 06:47:28 -0700 (PDT)
Message-ID: <524c6b9d-352c-4f84-bc8a-802dad97d909@openvpn.net>
Date: Mon, 20 Jul 2026 15:47:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ovpn: prevent UAF re-add to by_transp_addr on
 float-vs-delete race
To: Ibrahim Hashimov <security@auditcode.ai>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ralf Lici <ralf@mandelbit.com>
References: <20260708224631.1365-1-security@auditcode.ai>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Organization: OpenVPN Inc.
In-Reply-To: <20260708224631.1365-1-security@auditcode.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,

On 09/07/2026 00:46, Ibrahim Hashimov wrote:
[...]

> Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07

Sorry for the delay in getting back to you.
We already have a fix for this bug that is queued for being sent to net.

You can find it here:

https://github.com/OpenVPN/ovpn-net-next/commit/beb427921aafd186eb139349bf04c6d54a4927f5

I was caught by Sashiko's fire and therefore had hard time sending all 
the fixes in my queue, but I am getting there.

If you want, please check the patch at the link above.


Thanks a lot.

Best Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

