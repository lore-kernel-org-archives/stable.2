Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794115708;
	b=FcECsO7cIvYChUSOPLAfIxdNDjxvS988U833rAjAFYg8ILS21VucloYbCPwEBlqfkULl
	 NqEsnFwHzNhwCHZC4w5NSkMMgC2AGHeynE/ZvRsnTNgE8Z0l9PVavs+jKHifqE3LjGd19
	 iAZD4BM+jOi+hTSZ6O1udElpGnjvyBGtUDz93DTxJnS5udYTj2h2TQidMepFngRWQjllS
	 AHIrDWaDzGgkJo/VHtZEB2agV2KYGiLUuFL1Syvsvq5yUNFZcFtjGu1Y2lpAvOfV0g1Zj
	 Yhmrjxh9GXosHmaKtpDIZ9qeIr/5nCeVlyQpuoPaNbBTLzpsB0cLcCAzREdPXDVtYHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794115708;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jGfSOo4/qi2MGnClnBBICNQN29SKcOZpaXj2n0mUyuc=;
	b=pU1cH2jW9Xf4m1tKEFtGwwDPZKsFbiZ+NgpOu6fOS31EG5QolzwIJXdDKfcHsu2G8pdd
	 Oqm4wSQVIrBiuWEYtykuAEg2qziSAPOhvbtNljUbDb2humTXJtS2IK7E44Zn1rMW/eI3z
	 pXjVstEIXZo1G0Yt9swx+cLRz3bjhVGx16E/kAWq6fTdfnULQC/euGmAcbJuFnR8M9QS7
	 kCPE0Ds3o1Y619VF4G5XELmgunAibpJbnRivNN+Shz+4EXokTkCLPyh80cMqVxZ/lKrOU
	 QA9on6RJEpD0tQvFJd9cR1KWyQq8AC4aME2nZuNxs+Zkp5TahFg46Bhmk7V/wKyE0Sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=LTSKy4jf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12CA606A31A;
	Sun,  8 Nov 2026 05:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E12CA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=LTSKy4jf
ARC-Seal: i=1; a=rsa-sha256; t=1794115674; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XaDun2aI3VXKS8HtZd+yySF0ZLe3CF5r3ExAuLuPKKx0JPHbs0rTF+Ln4jKACVMfd3reZ0IYPK35VZSugyhKmQWCjzXRh+wi5Gyw8lePYkxmv8W1NnxYnKcbbv9KHogN1VvyarP70xjYDa4Ir/GQyAuGIfe4Z35CsUJHYe0Q8W4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1794115674; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jGfSOo4/qi2MGnClnBBICNQN29SKcOZpaXj2n0mUyuc=; 
	b=ijKjBOhklnUbfI/HrWdXM411YhCL5/tHCAGJj/SaUHjxwrIxxsDCSQjjCWmNWyGBYwGTXQKg82pZe8Kb6e37h9mcULfHleof7sEqRs++6eMId7d7//j5ffogbtQpXNgyy9d2f3AgLHQtw1vu/yRIEioQlxxyGRHrH9SimmbpW20=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=LTSKy4jfnYXdYo5kn8T4282HmTTFRwKWUeXdGV5PjsEDWR/48r9Fz7lrQ4RSowu+ST8yPOEU5MeHHN3b3BGMxOj0pB+zdcv2D3moehXbfNkJ19XCNZR5KIXMGTa6+vvv0D4wldWwoPKzmiADT4fTuFJELS6raoZvLwBVecAAM40=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=jGfSOo4/qi2MGnClnBBICNQN29SKcOZpaXj2n0mUyuc=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 17941156724621020.6302714073776;
	Sun, 8 Nov 2026 06:27:52 +0100 (CET)
Date: Sun, 08 Nov 2026 07:27:51 +0200
From: Igor Velkov <iav@iav.lv>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jianqun Xu <jay.xu@rock-chips.com>, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH] gpio: rockchip: restore interrupt settings after hibernation
Message-ID: <20261108-re-heiko-gpio-rockchip-hib-1@iav.lv>
In-Reply-To: <9970336.2WqB4rESCP@phil>
References: <20261107-b4-gpio-rockchip-hib-v1-1-19f4d163a55e@iav.lv>
 <9970336.2WqB4rESCP@phil>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Heiko Stuebner wrote:
> This looks sensible in general, but I wonder what happens with the other
> registers of the gpio-controller here after hibernation?
>
> Like does the direction + output value, debounce get restored from
> some other means?

Hi Heiko,

No, the driver restores nothing else: after a power loss the bank comes
back as the boot kernel left it. Debounce requested on a line was lost on
both ODROID-M1 (GPIO v2) and ROCK Pi 4A (GPIO v1); direction and output
matched only because the boot kernel sets them the same way.

v2 will save and restore the output, direction and debounce registers
too, as gpio-dwapb does.

Igor
