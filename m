Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8AA20ADF8
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786870617; cv=none; b=N9Lo1gdyVIY3CC7oG1YKGXypndc800cv0NzEZ62bJMaTMHs9HhZZsIBwLTdRgqAr5r0SDZwNVU2FPOdpabNNbK//+VKE+5hlDM3q+v6L0xa9jLcLCWjba1gNu70+HoWluP5r+MAxkCS1rawaIOC4j+Re2U+cCMUO5779gClQDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786870617; c=relaxed/simple;
	bh=tJAz/ItHBVgRIrjKlGA7Yf2OR9BlJEZ77puY8x/smJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOHSr4/sJ7PXCmeIHpQ4lhSsMNmH2HwUW2wwByBh0+8arWhtwpvuBbHHTPTIzHLtXwtDnue/F3KJoEsha3gdH0mgrXYRJdFYV/3k+Vlp9fcEbt5qwh6ZOnXeL/SvEyLJjgU7UjAGb/u07/h9xjFBi+HT6R4MQKS6bV6LT/EdZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1287698f8f.0
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 01:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786870614; x=1787475414;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0b91MIc9baawgnHgsNGw4IC7c2ROOK7JfMUTm1Q4pU=;
        b=jHYk8esL4TXiP7V7MLvhqLnFV6/xUCH6Krenv1uAKPAWOgl+aBJHbHld/gEREtlAyF
         TBvEPzhQCX6+hK1F94KOYoYrjDndd3kc1I9QohaqoWli3McEBSzhNIlbVWJp+oP3e6h1
         Q4VpU2wKitoQyFp7hoO6Vn+ib3cyQlgUJu5rOqOcBuxPYpCl9DpC1q6kobhlZfdq84TA
         01nui/CozNZabhzA9+g/Z60lSkwz8KSo5aAzBHUhpkquMc5PkSCi7vYmFwAnKYb8X0jU
         AcarweRgkQXEto2VeOjG/cJyjM57EuBPDnD0fmZubioZAZh/bg8USfjVzh/5p7nFGuVl
         a6QA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4mQZXeoU5Le3CKhPjwSDexrrIa/V8hgcDIZpTOnyRRsIp4LbxaE8yB0k1Kh0ojts3SR4Yito=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dOkvwk2VrCOafp1CgeuR2+SWmrKnSR2Unl70R2ki9FZTXdIT
	I8womvgXoPB9AUgetjKU/azXU9v/wtG1HKIkguKGz0E+KN4whng++uTK
X-Gm-Gg: AR+sD117GTdlKcTYiKMsNaCIgbEH1btJ7Y0lmwI+Rm1xxckadfSlwFPfszarrAWCjJN
	3Cf9hCFTGeAKqMXxJrH1QajxbAi64xvsKOkEPYj1UaJdKbRMdfLRBLd6KtHSqlvVt6plZJ3uamA
	COx1JaE/bThgVoaM6cdAjHCIJaivfddwqHbYFbIC5khnaNIHXBWLbL0VTcAmkgLcPMvxStO/1HN
	LYxbbELkY8tip6guvN8DSyXQwoUAT6c6qIOxY0MmfuSwn7IlhfaS6GC1wsOE7yM8VvqcSNyN2X4
	So6adBta0H9qHDnZ3oHHOdQCQeG9nfOwoaeXS7EG1cMbGAEij4yBx1v+c4rECFAsmoQg73hwHML
	AEGEheszHpp4BUjC2NJovfwmhCdSr4YDtZyr7OnyvpJVOkaqxoX2PpgYRACtjc8B4QJoJG57uiu
	v3EX1KETsbgfmmaUdVqFgmscBvwof0CyKzaU0V/1n2mb2+lc8x9YUpktJrHVdwTkbYEqX4XxoSO
	y4MCb+DBFOzHST7YUFrSINnzam8OA7vLksMzD/0A33h9k+eKAe6zoQiKOh9hPsvQXVm
X-Received: by 2002:a05:6000:25ec:b0:47f:f3d4:26da with SMTP id ffacd0b85a97d-4816070f86dmr24247754f8f.11.1786870614391;
        Sun, 16 Aug 2026 01:56:54 -0700 (PDT)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d90sm23948147f8f.22.2026.08.16.01.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 01:56:53 -0700 (PDT)
Message-ID: <1b4e3d62-619a-454f-a1f3-32165a58f3ef@reactivated.net>
Date: Sun, 16 Aug 2026 09:56:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: of: don't mark hog nodes OF_POPULATED before a
 chip is found
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260815-gpiolib-of-hog-flag-leak-v1-1-6126aac5f6f3@nexthop.ai>
Content-Language: en-US
From: Daniel Drake <dan@reactivated.net>
In-Reply-To: <20260815-gpiolib-of-hog-flag-leak-v1-1-6126aac5f6f3@nexthop.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2026 21:44, Abdurrahman Hussain wrote:
> When a gpio-hog node is attached by a device-tree overlay before its
> parent GPIO chip has been registered, of_gpio_notify() sets
> OF_POPULATED on the node via of_node_test_and_set_flag() and only then
> discovers that there is no gpio_device for the parent, returning
> NOTIFY_DONE without clearing the flag.
> 
> Since gpiochip_hog_lines() skips any hog child whose of_node carries
> OF_POPULATED, the leaked flag makes the hog silently ignored when the
> chip is registered later. Applying an overlay containing both a GPIO
> controller node and its hog children - and populating devices only
> after the overlay apply completes - hits this on every boot; the hog
> is only applied if the chip driver is unbound (which clears the flag
> in the remove path) and rebound.
> 
> Look up the parent gpio_device before claiming the node so that a hog
> attached ahead of its chip stays unclaimed and is picked up normally
> by gpiochip_hog_lines() at registration time.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> Fixes: a23226b7c1f6 ("gpiolib: handle gpio-hogs only once")
> Cc: stable@vger.kernel.org
Looks correct, and this is consistent with OF_POPULATED handling in 
of_i2c_notify() and of_spi_notify().

Reviewed-by: Daniel Drake <dan@reactivated.net>

