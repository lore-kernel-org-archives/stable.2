Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB253769E9;
	Thu, 10 Sep 2026 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057953; cv=none; b=Fm2S514EdMflrhHfIZ0tpd/leO9dYcvJBEcZWEiAqUQEQzh/Rav64u56xFlubHfCTDnSjnbiQn3QIblebjPPeyk/S6YLVtkpZnJmYHvPx9aAWVs+7fD3cX+w6/fudxm4XhHsDftCf/hX5vwR5tekKyObg9l2baw4XU9ZfTVEMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057953; c=relaxed/simple;
	bh=N74wWT9FOOFHsmY62Ucf5HWSK3FAaBmB14MUhDz8L7I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TflBAchAXBoxx3E5k2/Q/Wa7aHGq+t2RUFetkhpaipE7NzwOJhmSSqXEeuWXe4K0ckJYoVjFzXCbmMdPN/Jq2ThvKeLjopfaM+0KcuTmShFetbWj1bPz1NM3XTzP+i4PbNmT2Lhz9xTSdn2Kvr0y9ZI6mZOGrrRdH+v3Lu696nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrKF8pcf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrKF8pcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148B71F000FF;
	Thu, 10 Sep 2026 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789057951;
	bh=a0/78sgIbTGsy1syBUAVOAA0rcs0r6SNRgEXEJ47pzo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CrKF8pcfCSpnzSjH/EcGOLcxgeOJ6PrN1g5ODmIxjuI4ba5q9pJQKiCD/Ppw24A/V
	 PYucnInZETDeousEq8d/s6iyhMY0F9JccrVWEJG0kkezkV4D/yRWMkIIGv/IiAXaLV
	 zIKTER+uo/6tBjQaPsSz7UpiBrVb6Z/ZUZCYYpi7D+PJFKlqntty1L3rHYMwqL5gbS
	 D4jLEyCQaEW0DzQzF8hO23oqZCN8Zu2fRNMefq5lCdMLueWEFvgDxG3W4buyPyjn8Q
	 6OwscwNHj4693vrYt4eRup647sRPTpJ8QNY92XmlrCpCGyNckDXsd9mbRbQPmMXIWV
	 L8lnT7bJKViSg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Thomas Tai <thomas.tai@oracle.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
 David Heidelberg <david@ixit.cz>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260903-wcd-dma-v2-1-189cff560a28@ixit.cz>
References: <20260903-wcd-dma-v2-1-189cff560a28@ixit.cz>
Subject: Re: (subset) [PATCH v2] mfd: wcd934x: set DMA mask on parent to
 silence "DMA mask not set"
Message-Id: <178905794984.1265903.6426238332027371571.b4-ty@b4>
Date: Thu, 10 Sep 2026 17:32:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 03 Sep 2026 16:42:05 +0200, David Heidelberg wrote:
> The wcd934x MFD parent (a slim_device) never initializes its
> dma_mask/coherent_dma_mask. When the DT-aware children pass through
> of_dma_configure() this triggers the "DMA mask not set" warning for
> each child.

Applied, thanks!

[1/1] mfd: wcd934x: set DMA mask on parent to silence "DMA mask not set"
      commit: 5a5f978cf3cd2f50b9e123f851f5c6577519ee89

--
Lee Jones [李琼斯]

