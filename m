Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269147;
	b=XAOWr7eIgrFDp9OEOGRa9LwICmVFW7ixNvU5q/ouDB7q0SrnTrXJStZCCuazT5flp1Fr
	 K4pOxS0iVDseyekYWAI/tj53xFuPsy2FMw5zcLrQRTcHWqmIeR858+/Cn6e1B7mVYnuQx
	 aCF9QAg8vhy8oyhXeXIzk+Hg2+ME2cDMBfFPPDk5wJGs2Cu6ExSQPwZ5UR4oeXoRVns07
	 Mn9HnSNMLcPFJhrV/i1bEJWih4QxY+O4zWVC6MmLqtZ3cE4nR8BSrKwj/bt/kSVlCSxYy
	 GJf6+wN9erDBcnLpdYX2HbwLqaKdUhgHCBWDVUHAKyL7Rqi+ki9i309au141AQLRXWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Vc0r3JbZbwBvUVapNGhL09kDmaTErdcaYY3i2MzSoa4=;
	b=bdWJaxmn1xEqxwPwTB49KBNxWb8ApQMRfh/hzxj2AySlwwe/CvGkxegZSeLkOoYk9q0+
	 Z40Sj6ApisJdkoIOCDb8RwrpGKa2ypMZ60JJzGTa9xzlDeDnQ+ldOIYRKz1XDuD12yoKJ
	 k4QRViaezz9kQJrtOvQrk3ex7eCsxHb7yLnQGYqk6dWz1Gb05jYyTURgsb9aPOFGUe3rT
	 gUj4sxBr6gTuBVJJ7I6VIHZbbLwrlDYEbkBNY0jP28q5lohGLTBdR9FHyi1/MktdWIpea
	 fS73mnPHfu205uAqdHAKXB4B9rv8KNFbYN3egATlovu9y2T7GfZnBYFnrv8gXXgIHhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zH9z4kbb;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF29606A322
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEF29606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zH9z4kbb
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so21237665e9.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793269145; x=1793873945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vc0r3JbZbwBvUVapNGhL09kDmaTErdcaYY3i2MzSoa4=;
        b=zH9z4kbbMg0lkkb/HqgCLaFR9vONpMS7UnrW2ezQXaMot4yuVlvx8b5AsRhSxwcAbi
         Q4V4plM0s/t0NDmjNPggc0m3ZhTaJqh16rAqpGi9MHj+RiOCp8gednbCJjh+al/OBh3J
         k7dr5f93QI3uvgi5N70JgAPgUqm5BbmDSTg4+7OuWMyvYgfA37I5zYTduwmKcfRgttzJ
         kjcY4e0V4EKRJbYh1+4WRLNTrxvUqyF0Wh6n+2CKqJa9D29js7cu4+6Z8dPMKadEGaoD
         kMgHq+0nvRzb+a+PbaN9D/ZrUsU0nRFfB6YPncLGLwQk91Qn1/Z4TSQbNgEhroKs+9x9
         ox+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269145; x=1793873945;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vc0r3JbZbwBvUVapNGhL09kDmaTErdcaYY3i2MzSoa4=;
        b=hAlFPInwT2+NTczQzdqGpmAvHHVdZ7witB7pUn3TCuTeZxWor1t0bjNGq20O/2nP+I
         Mj9NGbzCnLC9mvwIWdU5CB0PBJoIUskbaqvv/K/CHDd6XjGiXxOQGLXz5/NO4y7jgs37
         U2bDdeBlwLbzaJbCEXGE3tgr/bDyvxjhR1DK8kobE0iTpQOhl7JDw2t/Va62Gwd2aFQX
         mg8F1GM7hvsIvUBpCp8JImEJfm+/AfekDhxt8lJUKg4aGbRrRrpSI/ob8+pra9p3C+Sj
         HoJCsY4czrilmjWODOEBfXxPEEYU2wmZ8kPr6Nu1uPP4rbL0EGJVpeh8F9lzphIoo8Oq
         1DMg==
X-Forwarded-Encrypted: i=1; AKwUvBzX/KSuiQOwQBANxoZPXbQVVLwVjhFUiDXrFa9UwgF/f7IQVS3T5+9dvfi88jWnvUhNpOC+t5Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlbQJZkYyTeHT8yKQ36RSFvVgN/rqd7ko5OVkpxwj+GsdlxJrP
	RlhunwJPP/eWOqQpvr3fr1q6F5dGWtv/AFVzXX5qPazzhWJ2eCFQPvHdf7HZ32gJ
X-Gm-Gg: AYBFou0V7MLSnoKpUvRqnBdaK2T23IL7eyuuAvFHQebQTVSfpWPFDsZLCInycx8J4Cq
	aELD126sVnVfOiQl0NvSupXy/6yoSKYnw7qTflwBRSX3LIm0+nO6n1yilRauJHhdCUIeAOl9wZv
	wOrS9zY3abc7AqxXdIy7ooEsrIBtrc6oAqatRV7PCi6YKyNktsiSX9gJOLgjRJ1aD5T4LXED3em
	XDBHq/3KJGox4/SCgIBLtH3d0fMcHu8doS7aUSvOMROUgrtgBqUlOQol7sz+g6c9jK5b9hx8QIf
	ilK2NPxd1yfx/SJlqpZ3Yq20K+CKiPyCrX1UzC53DcFHbKc0kxwNh+aQFPzjFLh2+l4LAjeLRml
	BXxjuiu14tafJ8B4/bxRAuBb2PbbIyzuWqMJzUTVvA006afGiHb8Kwmcmly/cM2iaOV3T/x/8V4
	CocLFCIGbdq1jO9H66gMqCGSepI44Bskc5kwJi0Z+2fKw4J8kvtcG7blZZeg6ZV20YTJMBNgSGC
	3HJ+hJYvm4eK3dL8mOuoZH6xWSu3l8fcfdvVa38lyG4VWtZwSUmOHmEf9P0znm7pP7fgrqmqd0a
	38f8R0Zh73HvzXHCXW5hzYmT83ESrMZZyhruJo1SUl76DZDBOGw2mrWdqNQNyVGaFA==
X-Received: by 2002:a05:600c:6088:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4a9677ca203mr118445565e9.27.1793269145060;
        Thu, 29 Oct 2026 03:19:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd354asm31946023f8f.43.2026.10.29.03.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:19:04 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:18:59 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Esko Mobius via B4 Relay <devnull+echoowall.gmail.com@kernel.org>
Cc: echoowall@gmail.com, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, Shuah Khan <shuah@kernel.org>, Thorsten Leemhuis
 <regressions@leemhuis.info>, regressions@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net 2/2] Revert "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU"
Message-ID: <20261029101859.6893f1a0@pumpkin>
In-Reply-To: <20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
	<20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 15:23:09 +0800
Esko Mobius via B4 Relay <devnull+echoowall.gmail.com@kernel.org> wrote:

> From: Esko Mobius <echoowall@gmail.com>
> 
> This reverts commit 2640e6419594 ("net: advertise TCP MSS from the
> configured MTU, not the learned PMTU").
> 
> That commit stopped the learned PMTU from lowering the MSS we advertise
> in SYN and SYN-ACK. For symmetric paths it argued that "the peer runs
> its own PMTU discovery and usually already knows the real path MTU".
> That only holds if ICMP "fragmentation needed" can reach the peer. When
> the peer sits behind a firewall that drops inbound ICMP, its PMTU
> discovery is a black hole (RFC 2923, section 2.1), and the smaller MSS
> we advertised was the only thing keeping its full-size segments off the
> narrow hop.
> 
> Inbound ICMP filtering is very common in enterprise and carrier
> networks, and it is pervasive in mainland China. We hit this in
> production after the commit was backported to 6.12.111: TCP connections
> that reach a server through a relay with a smaller-MTU hop complete the
> handshake, then stall as soon as the client sends full-size segments.
> Clients on networks that let ICMP through, and connections that bypass
> the relay, are unaffected, which made it hard to trace back to the
> kernel.

If it isn't a silly question, how to connections in the other direction
work?

I'd have thought they'd need that ICMP message to get through.

David
