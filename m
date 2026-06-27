Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602617D6;
	Sat, 27 Jun 2026 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782544073; cv=none; b=bRXnYg/Vtl+7usdu/WesRlj7YaS0zTJIkbVTOfiZOaG6lJYHYRkqHunIQZ+9sRfrtN1PmpzmXcff7BoTZocvfU/Fb1Oio4XCDX3rRQxWeB+0V6TgMbTW0NyFkZ+1sqc5MBGJ2MWz8sHSdBw1WUFxHuhoJCROklvJ9TIaibM8/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782544073; c=relaxed/simple;
	bh=tn4s73pHxp4rEwFZwUjfRqZCNaTlu+S3OPocY77PtJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MY2bx+VjDwWBGUF5sQG4/q92D8NDNv60CdZ0cKogXqkfJ4Sp5JX+0hCunBfwTNRMCx9nnhytJMlDrtyziSkC6mZ8pWLZ0GD9tJmyTuxr+hSiRqRIgJmkgi6BUN8eApS6f0PiVPG/OooFK/bkXqKhmO2amCEjKaosTQnXYV3IukI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=xU/S7FRM; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="xU/S7FRM"
Received: by dvalin.narfation.org (Postfix) id E83341FECA;
	Sat, 27 Jun 2026 07:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782544070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rNYYePDvpTYtK8SFepELEAwsSYVLkoYEB6ceWPvctuU=;
	b=xU/S7FRMIcBIxxOSODQ+3Ef91zyv84NTqUiec1VYqN2+CMkERDDQoGi3WYivN99W7HRPZN
	QxkhFp+L6S3pvtsxyM+xpNfo//17XYVPSjnjtPJzJa4FH1Vu3gNqTMsHoTcr66z8/4cG2w
	saVkbm+DCyQhztbSbUTvrOschb/O79o=
From: Sven Eckelmann <sven@narfation.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH] fix: net/batman-adv: batadv_interface_kill_vid: extra
 batadv_meshif_vlan_put after destroy
Date: Sat, 27 Jun 2026 09:07:43 +0200
Message-ID: <2365693.iZASKD2KPV@sven-desktop>
In-Reply-To: <178254092045.4739.1497464106445743950.b4-review@b4>
References:
 <20260627034636.59693-1-vulab@iscas.ac.cn>
 <178254092045.4739.1497464106445743950.b4-review@b4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2053576.PYKUYFuaPT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2053576.PYKUYFuaPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Date: Sat, 27 Jun 2026 09:07:43 +0200
Message-ID: <2365693.iZASKD2KPV@sven-desktop>
In-Reply-To: <178254092045.4739.1497464106445743950.b4-review@b4>
MIME-Version: 1.0

On Saturday, 27 June 2026 08:15:20 CEST Sven Eckelmann wrote:
> On Sat, 27 Jun 2026 11:46:36 +0800, WenTao Liang <vulab@iscas.ac.cn> wrote:
> 
> Hi,
> 
> not-acked

Just noticed that we already have another odd patch from you [1] (and you 
never answered after my reply). Could it be that you just try to spread AI/
LLM(?) generated patches in stable@vger.kernel.org and hope that something 
sticks?

I see a lot more patch bombs and complains all over the place when searching 
the whole lore.kernel.org [2] and only checking the last couple of days.

If this is really the case - please don't do this. We already stress them (and 
other maintainers) enough by dumping large amounts of legitimate patches on 
them. Sending patches shutgun-style all over the place without any 
recognizable QA or oversight might just cause an overload. And when you then 
don't even take the time to react to the review of the patches or apply the 
requests they had to you (and instead invent new things to annoy them)... At 
least I will not spend an hour writing a reply to you anymore but directly 
reject your patch.

Regards,
	Sven

[1] https://lore.kernel.org/batman/20250401083901.2261-1-vulab@iscas.ac.cn/
[2] https://lore.kernel.org/all/?q=vulab@iscas.ac.cn
--nextPart2053576.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaj92vwAKCRBND3cr0xT1
y5/WAP92yVp2I7/TSTgNIsYCekkMLPcxg+GxSX4T1259xtOaYQEA21CF2Gh1h5bk
Y9GzKjpEPYKSTb7JCwzHtF70D6c4WAk=
=hJlZ
-----END PGP SIGNATURE-----

--nextPart2053576.PYKUYFuaPT--



