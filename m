Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10842DF3D1;
	Tue, 21 Jul 2026 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611825; cv=pass; b=RxfsY4voCZG/pyXncas8sccq6ZUcHaZkgIML+vMr8g1mj/ZPw6yfDYKQ4JuMLYnMZf1Ja8KwbD5QeBffgEGCrHqjoq2s3T5ruVccs1onRsv9/3wfTt97GXyUMyzGcdhUFXdS44AWsIYEM+uC/UvWf83ulyWqcluCY6Gs23AzRVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611825; c=relaxed/simple;
	bh=3T0/hE0Stcsw2vObmLCtl5WoxVyBzpYUy5cEmhuJKSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unwKSK3gIsbr0RUzyelGGt+BpYo14cFmCgmUF3Cil/LoxYD2J2whFJPShbsULuSYbkPT6pIysq5im7tV/VMhPuMNnrbsbY6jsm1sbVLPzJslVxW8Si3XJzaqldUwrpXOops1XGCUwGDu4FPkOBU+1H3a1Z9IVGfc52CE+GP4hdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com; spf=pass smtp.mailfrom=yoavmoshe.com; dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b=d3O4CyJ5; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b="d3O4CyJ5"
ARC-Seal: i=1; a=rsa-sha256; t=1784611796; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JAZiciWAxdxaDBm2ejDbsi2u4MRQYwPOdjHpziQKaz+RowHBvMLWn+kLCDNKLLs8g4wtAVvM/FzolwdWcLSV4H47537+9qtUVThJ1nL3KTlhE2ERm2THFFbUnApys5fJymWy09ngFRAtityti0PZnb4XEAH7ahijy2VRGRabNj4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784611796; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=usf/+HzMy5QNUILiRJd2VbwOtJqgY9KL8yy6nGvOQ84=; 
	b=LPK/Wr8gDaTuY7nY2XrqDfoLOuo2JQbFFvRdeZW9M1jaMc1gMfXLA+tARUskHG8dY/xA+v3A2Ze7lt7GBqDY0xx361k/wP1bI5JLrcl8ihJ/sZQUfgS2Oj8A6iDkXYuQ6gxRNA8zt686L+qbYkFgTfISvym/y4LjE77KdUnlGEc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yoavmoshe.com;
	spf=pass  smtp.mailfrom=linux@yoavmoshe.com;
	dmarc=pass header.from=<linux@yoavmoshe.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784611796;
	s=zoho; d=yoavmoshe.com; i=linux@yoavmoshe.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=usf/+HzMy5QNUILiRJd2VbwOtJqgY9KL8yy6nGvOQ84=;
	b=d3O4CyJ53P11soT2mNxOURxEvpxU4BlR180UjT86gX0AMs7wGKVUpN96CyeKLIEF
	SwFCQUWLCU926lM7CMz9Ue62NHNtklAmQCyE/p2Sw/wSXqfu05tu3d9+C4Pm7RPYGVV
	R467EkaGJjGtcUDv3/8FYFZkF8ni0gPvV12kYfPc=
Received: by mx.zohomail.com with SMTPS id 178461179350753.645045637920475;
	Mon, 20 Jul 2026 22:29:53 -0700 (PDT)
Message-ID: <3046e60d-509f-471f-bd15-3ce78c87500b@yoavmoshe.com>
Date: Tue, 21 Jul 2026 07:29:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
To: Sami Tolvanen <samitolvanen@google.com>, Yo'av Moshe <linux@yoavmoshe.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Russell King <linux@armlinux.org.uk>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 llvm@lists.linux.dev, stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260718111340.159896-1-linux@yoavmoshe.com>
 <CABCJKudqGL+BFFcz3qsuoJB6S_OAt-vs2yqePC_=oy+JzmPpVw@mail.gmail.com>
Content-Language: en-GB, sv-SE
From: Yo'av Moshe <linux@yoavmoshe.com>
In-Reply-To: <CABCJKudqGL+BFFcz3qsuoJB6S_OAt-vs2yqePC_=oy+JzmPpVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2026-07-20 9:29 PM, Sami Tolvanen wrote:
> Would it be possible to just copy the 4-byte CFI hash prefix to OCRAM
> when relocating the function? If not, the __nocfi approach seems
> reasonable to me.
> 
> Sami

I gave this a try - I tried copying 4 bytes from before imx6_suspend
into OCRAM, but when I tested it on physical hardware (Kobo Clara HD),
it still crashed on suspend.

I suspect it's because imx6_suspend is written in assembly
(suspend-imx6.S) rather than C, so Clang doesn't emit a CFI hash prefix
before it in the first place.

Best regards,
Yo'av
