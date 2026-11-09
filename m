Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226973;
	b=n64Gy/XKii0cMZ+bWKd2yQFiOXpHTMeyG83jBRzs3mgvic9XxyoHAkZ1znf6TCGu4L+d
	 frZZBpMUTUH6PrG8u5nsFGlJR9a+4+uZl2hcjCZxgwMA+lwb8KgYdmd7xVREZV6re5+Ls
	 8FSwydZCdvQI4A714/Co6dELFCyhPX9/KJgLBBGJrbEgNqQMo7VU5rVh/omy4e9AQyj+O
	 yKjjY0igye+ZSr9Yp4jI9hlwm3T1McWju54u1fuggev7wCwSU1Ja0/znXCMiOE5RoYJr3
	 8cQYF2ggKNzzSWD6MTGTnBa2AQ5+4FEFYYeBnhRLnv9fpDmWKk6sdNHxVf99H2NJQ+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=+K/RW1RXwgl8n5BhYLeIz6f76FT6mOh914QOLAa75TI=;
	b=oV3R9PnjP8JyGv0RGKn29c9YX4HSoRW6ov1hzB3iVPonxC7mQu4HrlqdrAhLnsBg44iD
	 NjzlAoOEW7yDZCacAnMIWMNfrhsFHftb/bp+UW53nqml/PK4JdSA7BnNAqT1XYwMqVcNH
	 BYgRaMt3jIbP+lXf/9uaIq8LHjGMiLhp/Qui7+MNNENljV1dczJG7RUxNg3Q7VwjFPQa+
	 cAjvNprBaL3v74/79y/W43wN4HHseOT+KfPbmJFTG11UnotwxblH1IvZbcLudnoODIxMX
	 bBUYolJBVcOb6AoLlKXaXnxub+NGPxEXV8yCqvKC61zrBTD+iLCvlN0B2lHH8tvwprQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nLzVhwkv;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F65606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52F65606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nLzVhwkv
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so677260f8f.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 04:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794226972; x=1794831772; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+K/RW1RXwgl8n5BhYLeIz6f76FT6mOh914QOLAa75TI=;
        b=nLzVhwkvmGanhbgy33J/GFjK21O2FGTN38r9aONUDRe8edyDXkIaBfvIqLSpMtnYPm
         YEWEAP77v8TyS9h8REcwDpSqsfzUFzbC9q3oyBbVP/IyRBHhBwLUYdmN0KPfqDF90tuu
         1UDdm8bwpkTQ3784WmxMnQgqJN73ou6yfsbwh+zrkMIhGY2ec+T+tmuhRBONMY5LIUEu
         Ao8lIZDopRZf3Xy/HfR94cWai3CxbWMArSE+/RyUZLPXIfW5ml9Tr+rztHYomxvpkyru
         MKy/ORhwkzdqyicEbbf3W5w2f/c37C7nIV0dx1yT+1q9lRZnwbeUW/MDe3uakhh4ArWG
         xEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794226972; x=1794831772;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+K/RW1RXwgl8n5BhYLeIz6f76FT6mOh914QOLAa75TI=;
        b=c4TD4QsD3OADalPZO0eiLfd9QbNYpEzmNF1yjSoEYlKkJ/L91ueFKEuOT8F99z+nZX
         f8mMNOaQh6tNxAPN8XuzWSWr07KyZ1pkxYPRCCd/hZbbFORjSUlj2vSw555tAXN1MbXy
         xGWyd7nD+VrEyCQRIhes18KYFGi/BrXes8dn5JuQCFCmt1Cl75W+QxOglKRbQWIe96bE
         aRzAmGZpiUYYxYy2MiWNMOy0MvE9WDQsq7tLAEmfqKFlFmyjuBy2n8JySiYs5N2ulRAb
         pR5Bnd3t9UFYww4Mtxyhq2icDLDxwnU/bqNunHBGCJFbaYRhACLLNmOGRUR4d1rhnfkd
         6Jwg==
X-Gm-Message-State: APuU4Z+tgxSWJuauEG3zucvvblSIc7C7s9vzQN5cJ4VyxM2M2J91u3qd
	tqdSfpcxewcQpSIkeu3TxsJSUhglxWU+YSSEfMZwbRAEsNrT9Ax4hIfIEXr2xHPw
X-Gm-Gg: AYBFou1lcWgfqCeI9MqTdtcLbAa/qGz0CxR5KdM1XQ5ItIaE0bRFjxBxJHiG7GsJayn
	+/LNeP+MqRWp0gns8ui4lSwO4MRFbb8GTnCXpl/k0+m+LrMDXyk00heCI/n5k2hClCZRy5KQ7fC
	GXLycx71aysxLA7ITARetOI4bpW32c7RoJtZ6kY4fapjfb0oKiD0xXHVTFWx4PTouPn29F/pG48
	5XPSD/kmrnho5scbXveKNimK5REihHufrXP1dTcoPDhhK4w3J9w5/IIfj8Wj46lMVlhkRgk6FWz
	jCJZU14b0eNv8vRM6LTFcOVTE8wARy+hLOOIa4xKYruPkO+JYZDN/ql/PpCKnoGeBT98XbHKFtl
	Dw+j8JeN7HrJgeQp2ULQKACYRqHK63ccjJHKlSa85xFNwjfrKzt3eHuBQmwZbnHJLYY18oym152
	4qQ0LRQTZn62Su1EA/Z+kCKyqv8Uc+1E/5+mM1Zu4UdjtJru0hHdZBo+8H4kVt+wtu0IBIuWijW
	yOFtGoJhAvgu5+l17odeqmYlGfS+QPL2i1Eb/MYBwD3YDs7j0VSc6/IoKS4omIjVraEg5zkWVSy
	2/Ps21aG92eBOJNzfaVdz6EGd+ZbzIyGZjVw+V1DM33ABCtDt6uvNh9tl2mk2xCB3J/T3jRDOa5
	Q5xkg0cQ=
X-Received: by 2002:a5d:64e3:0:b0:48e:75f:477d with SMTP id ffacd0b85a97d-495877b99a5mr7582937f8f.7.1794226971364;
        Mon, 09 Nov 2026 04:22:51 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4974b7645cesm3072774f8f.32.2026.11.09.04.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:22:51 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 0/2] nft_byteorder: fix the uninitialised-stack read
 without removing multi-register support
Date: Mon, 09 Nov 2026 15:22:49 +0300
Message-ID: <179422696909.5131.4005481731765358036@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Pablo pointed out that the full upstream removal (bb061d3) cannot be
applied to stable trees: nftables versions before 1.1.0 can generate
len != size byteorder expressions, and the removal rejects them, so
existing rulesets may fail to load.  The removal is tagged
stable+noautosel for that reason.

This series restores the multi-register path in 6.12.y and fixes the
uninitialised-stack read with a targeted initialisation:

1/2 reverts the removal currently in 6.12.y.
2/2 zeroes the destination span marked initialised by the control
    plane, but only when source and destination registers differ, so
    in-place conversions (sreg == dreg) keep their value.

This does not reject any rule and keeps the old userspace-visible
behaviour.  It removes the dependency on CONFIG_INIT_STACK_ALL_ZERO
zeroing the register file.

Compile-tested by reverting the removal and applying 2/2 to the
pre-removal tree; runtime testing on 6.12.y is welcome.

Abdifatah Suruur (2):
  Revert "netfilter: nft_byteorder: remove multi-register support"
  netfilter: nft_byteorder: initialise the marked destination span

Pablo, this is the stable-specific alternative we discussed. If a single
folded patch is preferred, I can resend it that way.
