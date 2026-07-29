Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A14443E22
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318854; cv=pass; b=Fxi5s+4jafXMcRvnUomJsxpmQRGGUIjGSzbhVXd5hJlgwIRQyWqvWteB5qpLUB5RZQP5kJHEkMpPwn9tspxkJ0q5JhVzZB1zE/OaUBTnh30wEXinxJv2N+7IMcUeopRkAfsBtHmAHcBQj1x5JJJTkGFWNT/sgZ6EZesenUhTdJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318854; c=relaxed/simple;
	bh=rP7BjFvQ2F1S8qcl0M/g0VqSVGVgtmQW6//1T0K4nNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsQ5BZcLoisYBA7seyzIFC1oWyLTv3gm2IWtqr12gWaIl5nBSvS4iHSrFmkXiCe9Vk32P9szZo7+mT8fPVvlghspRni1Pil/yGS/DbGOQov0iaVwFDwRKgY7VjwTkTU0nzgiwyaggk5YFBfYeseHSnRCt5nFy//QAVf/j6x70m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0dnYfuN; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0dnYfuN"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c96d7933910so81313a12.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 02:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785318851; cv=none;
        d=google.com; s=arc-20260327;
        b=XhTpk4epzCm/v+UowqHuyZ2Op2EjnyuFjQczrJV08NfAHwxA0FJpjVDaxcRBkcXBbi
         xElQL9Z2R2zANG3QMCaS43Hefh3Y/9y83+9yDVhPtuP4eixs6ihW6uOS0zxPgClBQuHN
         m9KntaVPjbIfISP8g6/YHVIaxZrOG2KxJRuuYzR98x2NwGOM/o0X6v8xjJph6qCJ0kQM
         leXd+h4S5oB/DscommDAWdhiLcn41DjwKbmDTeBg5QadSUQiYfQZC8B4CeM0MG4V7cX4
         9kjTiQlpKRuHN6iespJVmIfyc2+dX3Sm4pJVlJmAgxy2R55AUEhIrTLM79fWl/nhm9be
         WT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rP7BjFvQ2F1S8qcl0M/g0VqSVGVgtmQW6//1T0K4nNg=;
        fh=QZF//GY0ag6gZiC9yj/tyNY83NxwR/47qxmN65Ny4Og=;
        b=mnBesh9BUH8XceJD291uma5IsXvVOsKKFdzDYms00F18R1HitsoDdGPyocUZmyD+14
         glOTCaBooSUS0+cosj8jQSE4h8ohCwaSXMokhxIiZxVBklBrk3LVPvMSjo8olsL/hPsR
         AW+dC2WzGTG8zHVBCEVM2NNOGvOkFJz+ke/lcMrnMSU19YboEipgeJEgr8tVB9JQJFSC
         uEma210Ob+6lja1YZqVOUahExg9UxlzT7UtuMPaSvisLJEvRUddV2RGm4eXNva66Szdf
         dgEUufWuONaCiyRtQnhkihWZ2fXh4/mb534fnaGKfdx/aXlBOJ9p2xgvcbtoQanCVjky
         EW4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785318851; x=1785923651; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rP7BjFvQ2F1S8qcl0M/g0VqSVGVgtmQW6//1T0K4nNg=;
        b=L0dnYfuNzOYQSr3J7VZVopp4qKSAi5nblaCELmd26htBYgoN7ldSHNKxrWAv2C6xuZ
         4C/UKWoUUhRe+dCyBhdqU9yePQ19vWIiw8fOeinAOCNe21z5KBkRdnJ0UXmR6Xq9lCiv
         dbJPZI4N4E2ZlFaJs53qNSONVP8u4j0uFA89BoUwSdOpl5XSGibTTWWQBQP+hxrfQuNQ
         b9OOUWkCq6o+Icz7vjTawW1rbxQglKT88yiK0fizHYonD57JY2NxNOvUxcbJhO5Xfynq
         ExSkA8ORgL9E79mtVMyOvDH6ikJfR4ry9WAPWxY9woP2cUOtAZ8Y4dK/7Mxpd1eugt2F
         k7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785318851; x=1785923651;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rP7BjFvQ2F1S8qcl0M/g0VqSVGVgtmQW6//1T0K4nNg=;
        b=bpUHe5H6LsV1jQjAVlTr8ADcEYp6jS2sGFxufVQZKqMTRXQRmfMW55yNYSHnBw+taR
         pLh0j6yAAJmIKGANpxtTca5NtySzsqs04miewmANsTVjDdlSFlYRubNdK84isM59H7V7
         ECnUaMQCIwKymcqCwd6T+3+sCfyYG9euT5Z4sbl2DdI2Cr+GwsIaBl6lPtRD6VJRZ0/1
         L7s/rxdGAhkLemn/3PijkpY/qpBxoTF8AetDp0VNA6gfFzEISBEuTWQ3fWonX1JDOKzS
         ULOxT3R5W5qLFFVdKGFDcAlMvJPDGkMWa6jK7G1Z4T8ugf0mWpjAgG4tCRGOO2NDSuVA
         VuJA==
X-Forwarded-Encrypted: i=1; AHgh+RonW5kkkuVLPaYoSM+76LrRusB/2xB4+hPCvPtwKr2f0nRnsJiLbZK4VnANENao+GFBwiLEp7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjCbuq0SJ/3T1QbuOqIaTZJ/9tA3JemVyRfaQfnI2P8E0Xnbw/
	e7D9Q6LClhD9n1YailBrbty3sJ1Urp6oATbLAw0YUL6F5/GKsQXb3y9dR65cksj3yP9M5AxZrFO
	0qczoef919pg6weHvETk1NqlaNq5Cgbs=
X-Gm-Gg: AR+sD10jQCvvC8wwrGQ4M5qSSaCesagJS01q9U9QFEanGSnPa5Q3gJK1wu442Ctth9Z
	E2dfpvRzbj2bdqInUMpx1M/EENREzOTPf5tlVPiK8JHBgjReFysZWwhCoFycGLxptJp5koBXOYT
	DbiUrLqibYP/oq4mQhB47OjOWpwZ/mhQDXljq9KSO92iNJKU4nWiHTfkFn+b20NZ92KTv0FzJAP
	DdJyrCwDKDcdorbEvRRepwQb069xvRclkDlXxqEYJyiWmobsDQcA9+udCC1c8z6/JTUMqJHcMqy
	PK1+SmdgN8shOnuV88dtFEUMHbd2pPGKg5KrN/YHP2+HqlS/jZGLsewMn4X+1tVXlGbzcHZPiWX
	A8XFszXUv6bPWTF9PRUr6DaQD+EE5I0OqeA8=
X-Received: by 2002:a05:6a20:dd93:b0:3c8:e10b:7aa0 with SMTP id
 adf61e73a8af0-3c8e10ba35amr1946887637.4.1785318851492; Wed, 29 Jul 2026
 02:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729030122.21462-1-q.h.hack.winter@gmail.com>
 <20260729030122.21462-3-q.h.hack.winter@gmail.com> <willemdebruijn.kernel.36b6c7169b6c6@gmail.com>
In-Reply-To: <willemdebruijn.kernel.36b6c7169b6c6@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Wed, 29 Jul 2026 17:54:00 +0800
X-Gm-Features: AUfX_mxhkvmo3EEEhm9LRdfp5oOIoHFBG_U9ePZX4E9k50o-Kfi2gbetm8DrHvI
Message-ID: <CAH78Gvsoa72OU_5ChR0hboEPO13cGoEdVFDRmeNzmRZ_1gMtww@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] packet: use consistent hard_header_len in
 TX_RING send path
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, daniel.zahka@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

You are right, this reset is unnecessary. vnet_hdr_sz is fixed for
the entire loop. When it is nonzero, copylen is overwritten with the
current frame's vnet_hdr.hdr_len; otherwise hard_header_len is a
constant snapshot throughout the loop.

I will drop it in v5. Thanks.
