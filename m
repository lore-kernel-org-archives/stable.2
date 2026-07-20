Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD428419FB9
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551602; cv=none; b=kLFvxnSVLTBRR2A/rmkG3EymGVFoN+tp1f91qiEvLAcH8pilFGV6kKiTrCYIRt3kCzv2Ga7Gymf15ha/TF+1RnCnxlV8PsDjKHApLNava53/OyQuhbWjhA+I4qOI2WqrWlZ0WFZIWNPFSWLgQRM3CiMddnYce0nd3gFXBf1UC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551602; c=relaxed/simple;
	bh=7qaDLv1BniL/Ba2rE6YGUY/Ivj55dvv1laonTC2OuKY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HeMs5OqERS98XsUyo68lEA//lnEy54tVALojwGOzWoBSIEQINmgdPcaQ3xI156SFP0ZKmg7J5ZnWV61c5X0hYsbXYLzjAEAOs7VFKnh06lJlLupPk+YvzebICK/17VFNyxBQNH7LN9klqk0+k9o/ihkzy7ArC73bfLJF2iW5r7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1wlnOA-0004wu-KN; Mon, 20 Jul 2026 14:46:30 +0200
Message-ID: <811630842892a53858bb6c6504d31fa9cca0fd4c.camel@pengutronix.de>
Subject: Re: Patch "dt-bindings: vendor-prefixes: add Gira" has been added
 to the 7.1-stable tree
From: Lucas Stach <l.stach@pengutronix.de>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>
Date: Mon, 20 Jul 2026 14:46:30 +0200
In-Reply-To: <20260720111729.362978-1-sashal@kernel.org>
References: <20260720111729.362978-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Am Montag, dem 20.07.2026 um 07:17 -0400 schrieb Sasha Levin:
> This is a note to let you know that I've just added the patch titled
>=20
>     dt-bindings: vendor-prefixes: add Gira
>=20
> to the 7.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      dt-bindings-vendor-prefixes-add-gira.patch
> and it can be found in the queue-7.1 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>=20
This adds a vendor prefix for a board that isn't even upstream yet. Why
would this be included in a stable kernel? What was the criteria that
qualified this patch to be picked into the stable queue?

Regards,
Lucas

>=20
>=20
> commit 26b08f0fcf83bd733238cf556bab64c65ded09a4
> Author: Lucas Stach <l.stach@pengutronix.de>
> Date:   Wed Jun 10 23:30:47 2026 +0200
>=20
>     dt-bindings: vendor-prefixes: add Gira
>    =20
>     [ Upstream commit 61a7e4c2c98c08da6bbf8c30c71da57610930ae7 ]
>    =20
>     Add vendor prefix for Gira Giersiepen GmbH & Co. KG
>     Link: https://www.gira.de/
>    =20
>     Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>     Reviewed-by: Alexander Dahl <ada@thorsis.com>
>     Acked-by: Conor Dooley <conor.dooley@microchip.com>
>     Link: https://patch.msgid.link/20260610213047.500701-1-l.stach@pengut=
ronix.de
>     Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index ac83310259a914..55ef75d530e6c2 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -658,6 +658,8 @@ patternProperties:
>      description: Giantec Semiconductor, Inc.
>    "^giantplus,.*":
>      description: Giantplus Technology Co., Ltd.
> +  "^gira,.*":
> +    description: Gira Giersiepen GmbH & Co. KG
>    "^glinet,.*":
>      description: GL Intelligence, Inc.
>    "^globalscale,.*":
