Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33433DFC6B;
	Thu, 18 Jun 2026 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776199; cv=none; b=chQFFI32xGCAEkUJMcmXBU6gs/AWozIVNsRuQ1nYn1RAMyRqMF+NkaXe4AI1xpVL7FGO2L1b+LyldD/WLD3cW6Hs5z9F/K1O5oiqq3LHPYE5FmCPSWtwbbSPHJQFtNGyb3bnPPnLYwmBdAKoU8Jxr8KZ6tWeOHFR7BOa0rfT/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776199; c=relaxed/simple;
	bh=1j6nLnLOVBePWf0/aAALwVLmoB3ZSMnuH+q4qiF6yGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qykrRz05RQtOaCETGV0V+GAswuxXg23qYEhvJj6Y//9fDh0E8LT9cSSEAMSDQJ40L+oGnjglMe3+jNEC5eg1uXxTm1IDYYQcz+3PeUzTh4GUAgiiXQq/EM0yIj5YCxweAgWN47e5X29qtnpEci6l6vFg1AqidQUXMgG+ooBhVM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EF99F2002AA;
	Thu, 18 Jun 2026 11:49:55 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wa9Nj-003Psb-2o;
	Thu, 18 Jun 2026 11:49:55 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wa9Nj-000000005Vo-3N6X;
	Thu, 18 Jun 2026 11:49:55 +0200
Message-ID: <bda9fbc282d9be7d07605684c12447877663754a.camel@pengutronix.de>
Subject: Re: [PATCH] reset: sunxi: fix memory region leak on ioremap failure
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Zhao Dongdong <winter91@foxmail.com>, wens@kernel.org, 
	jernej.skrabec@gmail.com
Cc: linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Zhao Dongdong
	 <zhaodongdong@kylinos.cn>, stable@vger.kernel.org
Date: Thu, 18 Jun 2026 11:49:55 +0200
In-Reply-To: <tencent_2C7697B076D53BBE62D99B7CD15E77A20C07@qq.com>
References: <tencent_2C7697B076D53BBE62D99B7CD15E77A20C07@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mi, 2026-06-17 at 11:16 +0800, Zhao Dongdong wrote:
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
>=20
> In sunxi_reset_init(), when ioremap() fails, the memory region obtained
> via request_mem_region() is not released, leading to a resource leak.
>=20
> Add an err_mem_region label to properly release the memory region before
> freeing the data structure.
>=20
> Fixes: 8f1ae77f4666 ("reset: Add Allwinner SoCs Reset Controller Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
