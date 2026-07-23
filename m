Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFA62F83B5;
	Thu, 23 Jul 2026 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836583; cv=pass; b=Kw2IlKHNldlupBzPyMz3tAV/7W7YWVZPp+2uIs49OjQeGeVN2Ced8Goi5RXO2FksAJoxbz4xknTrNwV+m5ymFN0tY8VhPxtn6xONUlsxDbwsLNP1bRM0iZ3Z1iLtnkI37xmkMUqupxSutUFbRw8ThLvqmiToZaPZxY/7zYG4QP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836583; c=relaxed/simple;
	bh=844o13I2LmNAbFHLuquKpbA1lfUYb4rYPNP3IrT+wgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcwuKIsVF15X4c/AQK4cRu6qi2TBvO+WtA70/EAqB8ibOcy9N72qPH4dq0Lct4qHdpR16BwFlqBzof5Sq28trn4t57M2lU4HDKfQICXJf/R1Ra83prB6c8oMV2yQPoysp4sH4UTXCVxihU8dtZQE4UDVQFObgnB+U79ie3zXbAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com; spf=pass smtp.mailfrom=yoavmoshe.com; dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b=RwdQAppc; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b="RwdQAppc"
ARC-Seal: i=1; a=rsa-sha256; t=1784836553; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lCuCz8qiU79E2KM7pC6ns4c+KN+wN3MUMmKekj5UpeIkuVZUbZ0v819kUJg4cEC6qCOcB2mUZAdjEMulb5OrpYZdEX7g1TyXQPMKGWw4QaUag3KqelWrDWhvafo/FCY5846EJvL7oa9KvUyq5XEiGA9dPkSR0Tp9AOvCs6VkTXI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784836553; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+8l2CuJj29/q9WU4sYROsZI8M/M6cU4ae8pKFk3sZ3Y=; 
	b=oKawccNzREyJ/TJmcyxmvq5/kQ3OeuMyNPUK9Ixni15ugICKcT12+UQYRTkvVok5MzFa3Z7AsSr7BnTIOEEpPBYfO/kwcZd8F70yBby+ZeXosKc1w0bWy2Tpyn3P1jOC4tatSJS471vLEFRfmDFLC2MUM2O5kiuEdsIWvanFYJ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yoavmoshe.com;
	spf=pass  smtp.mailfrom=linux@yoavmoshe.com;
	dmarc=pass header.from=<linux@yoavmoshe.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784836553;
	s=zoho; d=yoavmoshe.com; i=linux@yoavmoshe.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+8l2CuJj29/q9WU4sYROsZI8M/M6cU4ae8pKFk3sZ3Y=;
	b=RwdQAppcb4zIri7Pn7AjcvfwJyN87cEvPLUizLsGlboJusa84hYmEjSxXbEgh6kR
	QeJZmq4zfAs947qJhiGZljmnu7yRqFr229+wOqrVQGPpgc0/pehLm3ykZaSfxs19RUx
	0BgCcsXnCKfGxMjezpJGphoATzIpNs8EwfCcFedg=
Received: by mx.zohomail.com with SMTPS id 1784836550137418.0442233386244;
	Thu, 23 Jul 2026 12:55:50 -0700 (PDT)
Message-ID: <12a46993-82a5-4109-87fa-61b8fcf764aa@yoavmoshe.com>
Date: Thu, 23 Jul 2026 21:55:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
To: Sami Tolvanen <samitolvanen@google.com>, Yo'av Moshe <linux@yoavmoshe.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 llvm@lists.linux.dev, stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260718111340.159896-1-linux@yoavmoshe.com>
 <CABCJKudqGL+BFFcz3qsuoJB6S_OAt-vs2yqePC_=oy+JzmPpVw@mail.gmail.com>
 <3046e60d-509f-471f-bd15-3ce78c87500b@yoavmoshe.com>
 <20260721180950.GA3684684@ax162>
 <180001f5-bddd-4e58-8442-f7ef3c979500@yoavmoshe.com>
 <CABCJKufhvTxmVm8y7xr4RWWKsoZk0h8UGBnem+F5fknnimaqPA@mail.gmail.com>
 <7f273a08-b29c-4e15-b340-898b251efe57@yoavmoshe.com>
 <CABCJKud+GsBVv+XMTsi_4QAaTHo7jXD2Hyvi9wqKd7x3i2xyAg@mail.gmail.com>
 <415ffa24-a30b-43b2-aa6a-a1cde3bd4ef0@yoavmoshe.com>
 <CABCJKud9B8vB-J8f0HLHw6EgEKVWzy+Q1PrNxpO_6yCGtEyi8A@mail.gmail.com>
Content-Language: en-GB, sv-SE
From: Yo'av Moshe <linux@yoavmoshe.com>
In-Reply-To: <CABCJKud9B8vB-J8f0HLHw6EgEKVWzy+Q1PrNxpO_6yCGtEyi8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2026-07-23 9:21 PM, Sami Tolvanen wrote:
> What's the value for the __kcfi_typeid_imx6_suspend symbol in
> vmlinux.o? I would expect the hash value to look a bit more random.
Checking vmlinux.o with `llvm-readelf -s vmlinux.o` indeed shows:

  a488ebfc  0 NOTYPE  WEAK  DEFAULT  ABS __kcfi_typeid_imx6_suspend

Yo'av
