Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795338750;
	b=wp2syqK7yJfwEfF+SLK1aeRgOdmAD7rIb031/oNMdoRIpCjd7lmIfd6aku/sX/MH+XeM
	 aGwYv3VmI/V95I4Bd/iNSarz2Y2qPHzcUnrFadSpg8qsg9L8+El3XaR60skJMcRij+kWK
	 wsUg4fP48egC1WFK+nJYkZfyX53mHGvhanW5zQsblu4GnNLDinfclnDuYYdn8oGtJCF01
	 IPqZ/13Y4I5DGGCc8C4JnLtXdZktlvbJztyHiDx77HCelh8EDbWJnox2l44IFS63KIc9w
	 UusnoPCLLzjNS4TxrCISr19+D56202fbQMPeozDPzn4G/78A6mNHYglSu7NN4VR2lBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795338750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=EQRZRUVgWLEXWXY2UUdHCwG6T9sZpfMFCWNR0hoVHQE=;
	b=hbU7AtUyErJ2dpqGsQmGKKFISM9zRn6zLjKbXB8xo7zI7XjR0or4eSkly0TwyrwkdSj9
	 ZMPBi3J9sM45bNra22yV0TVU2QD7sJxz0E+6xtU1Sdn5AtaB20FfPWm+hnUaqtvoCTV6+
	 eoAfLgY5PQsq1PkXF8wd50wdE9y5wgLwodBWcnyRbESc2vKsMHWS2mD9ZDJsrG+r3Kaz/
	 lgjm6DJMW29QYggrgKQHwQ01l5wl1dLRHqFbPJzQuutfKP8SqJTRy+mXYVchXBn2Ekx/W
	 Auzsc0tZXJKJBfgvEeqvOF2D5mZK4tDTBpjZ/C6Y0CxnpDeKHts5WjUrd2sLGGbuS7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PLS4XcuQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D5606A331
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 09:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D80D5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PLS4XcuQ
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be3dd6f636so185635e87.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 01:12:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795338748; cv=none;
        d=google.com; s=arc-20260327;
        b=WQpe83DO6jS6y591FdmA1xoQAo3oc788AWIPoBpK1UBIw+LUEP5pQqD5ZzZLosonSP
         lo9s7N6/SP3wza63MjLpIQKBN7guP2n3lSvRmRepB1ROq0tYgeWKzQ9E01nZ6FiTAacq
         4tmF+NKstDFEL56caN/ZMVI4cYe0Gekr9tEUMpOYpoYfaJtQ0G+qj79TpPx8qDAmp/yb
         qi4JPjVEtKy1CKmtvp9HOBayY7pbqB8u6sVlSnm/cd1BWtMBls3J5SlgW9BCKbBkEwgK
         ytD2Xt22+3kXRltuzdpis9kkpaXl6YH2fjiQ2kqFHIdpJWTBtEQpm+aIhKcWxo5LKLYz
         9rDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EQRZRUVgWLEXWXY2UUdHCwG6T9sZpfMFCWNR0hoVHQE=;
        fh=Kw2zLWy6s/04jJCe0FvNdRBHHUpGE/0WI+LS4/SHQhA=;
        b=lUEeyrsy3anZS7oHWEvu8hpnLmaOMrJq0aGr3gpUsiNQVVnXGkf8eLBuLupw94/Bny
         awalU+kKpEZ1xiw2P5GEa33zVWSkgWRaNTzkauQi8UYMHllr1lH6Udb9a4+xo8N8+yu0
         2MAXB8/zybRG8b4Ux97bAIWF7UTX9S6oMvV1Yy++9T7t49GSObVXXO6aQh25IM1FzrGG
         kwSTzJ/67mlZd6mbsP5V6JeFWH8QPHIvCcP5+pPlq3dNMbdQwRPU87X0eK5i2Ocm5XjM
         Odsikrm1Nd4Tbfkg+UHvjW5MCQEsjB7MrfTM3gaI8aW0A9tPPReKFuGyoolZdXQSSZEE
         JWzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795338748; x=1795943548; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EQRZRUVgWLEXWXY2UUdHCwG6T9sZpfMFCWNR0hoVHQE=;
        b=PLS4XcuQdsaZB2j2yf4YdDnBfZ1BFyW7tN/f+hhQY5ch5NWWQ5DRG/N0qkfcHEkjot
         +6wCseLb/5VPyzjDgzvYeCeXcsNBYT13qwPPbwqkdlyO1vYivW2QRwnGfN2RO0wBaMvd
         z2ACb0g7OPqWAIgH71B6etQRkvbLylRCvlJgQ5G8J4JwMhhul/oVR036M0iowTse1OPW
         Vu2LU55F1jCM6vV9Qy5W2QAF0wBHWJluTb99lpdFL4bExaX7mkkLx5o+3O3Mbiv7tOQO
         oh7OMpDtwTqTioQF+kuyqxcptav/gxGzeFva+s9vhYMD6A50yCFCPQfsN4H6t612wgkR
         WgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795338748; x=1795943548;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EQRZRUVgWLEXWXY2UUdHCwG6T9sZpfMFCWNR0hoVHQE=;
        b=RASeVnRzSSMOm5/b6YAhHfmAgmdj1BSh8OG6LK45nPI5TYj9tfDOo79cjeNTKWGM+H
         +7ujUFi6oWbBuGKBEeATCFJyCDsS9xPRLjQRaagdN3Zn2dwHeGG0g7DzQXo82ZMA6RZd
         sLIGRPyfnuNu+xV+r97rba2judc/9Kj/MxXVnM0rZCuNELQVniE0fasXEfmaGrjCLVRQ
         a18Ayba76f72mPIy3ZmIeXACzfjvX6B5zn87kr6HnMJx7iXMgwQEuFQ0qnc+2Q4Ga5Ro
         V42/nLUH15LSlwm7/+f/kEIJyqXY3vj2vd+kMB9MCDAOV4tGez2VKe8FSfG5AqX452O6
         HybA==
X-Forwarded-Encrypted: i=1; AL+hErEbf4a3+1ABTJ3FqZx1jhZyGDW+/LtnyCZ4O7xuaSFNsFbne8NP7jdREfvWxMPEprRcc2fLuSo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9F+ccYVjcFlwsuzPmFxKlUR10CV+AOETN06+oUkETZLwOqlcm8
	bgCOfO9YfmKMMI1uPwmd/4vZpuV0mW9vNHwZuv84kdavO8Hh9bZx/EF24IZvotVNwoKFQgpg8Uk
	dAto6XZCc9H936uX5S3go6V0h6js37Ao=
X-Gm-Gg: AZFdTZdOHMov7Sc0dq4WCQ44eP8+IxoXw4SrgluNscmaCV4gZzB7CLkWbMMINijDl2O
	RzaXaqIOHv9wyJjj1pViC7WOkPGhO6qjOWsV1bDC6gw++o6Oh3VnfFjv9QtU3bWXW5mgZBld40W
	iNnBpXUn4Artu3MQyIA9Ma2xgQzNrCDLqeEchTYQv+oJcaaUZkbKVFH1qPQXN2+ZdZf8h00DxH4
	k3UBhOjrYVOg8+yTjdCF+s3G6LXPYUVsIGun3sb5etVTm854WvlD/AU5zDjVF5UbX9Ps535sJue
	cWz655d7gMP6+JjBvYJlNdElpP3jhIFGv+uvP3CjnZJCDED6JSmm0RbdKqBTgOu6QRLhOQfJThn
	cczLxU2uRAIP7gA4OVP0v0jfKLvveW8WEqhnTzh5kwhzFCADlWO0GjTM2q3MI6FBgOC5u+yQ=
X-Received: by 2002:a05:6512:31c3:b0:5bf:e6a1:3115 with SMTP id
 2adb3069b0e04-5c1bc76a33fmr3276447e87.2.1795338747873; Sun, 22 Nov 2026
 01:12:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-sun8i-emac-mtu-limit-v1-1-22492842d318@gmail.com> <e72505dc-f20f-4473-98f2-52161e08c89d@bootlin.com>
In-Reply-To: <e72505dc-f20f-4473-98f2-52161e08c89d@bootlin.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Sun, 22 Nov 2026 01:12:16 -0800
X-Gm-Features: Aa3M54oySI-tTJ0Yq8ZA8YifNr7RX6205w52YmRPUl3JnSPbZIf10o3azHoDuPs
Message-ID: <CAEy9hNVyfNZu9R-2duqwFhYps9t58CwZM777yM7AmU0rcc=dYg@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: dwmac-sun8i: Limit the MTU to one
 descriptor buffer
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, LABBE Corentin <clabbe.montjoie@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Russell King <rmk+kernel@armlinux.org.uk>, Nicolai Buchwitz <nb@tipi-net.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 11/22/26 08:56, Maxime Chevallier wrote:
> The problem is real indeed, but not specific to this glue. Rather, the max_mtu
> computation should be fixed for normal descriptors altogether. Can you work
> on such a fix ?

Yes, v2 does that in stmmac_main.c, with the lower sun8i limit as a
separate patch on top.
