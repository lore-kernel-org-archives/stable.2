Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867331B131;
	Fri, 24 Jul 2026 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906242; cv=none; b=N08uO7Hx4yJ8yF8P4vcla+fCGcojXUHI1aC430n4MCB0CdU55MWcHJzhPj7sdfghzjBN52tnNs3wTXkCI2rUtS8VrxLKJXg03tcAzNqg04iGRGNgFOkegZwk6jvuGMEZx482prBJ1pWPkML0qnTyRUQvZWk8YAnXteCUKM0avlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906242; c=relaxed/simple;
	bh=VNQ2MvPsuoFXHVXisyiw0gGiOpUMPq1wLZDvY81bHq8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=dPkl3PFNjZwkBAstGvOWek8xUjBX/srRbDzsh717uTYYnZnildCZWZUuXOH0S0aUHwt0bz5juXVuTA2H41G+VMMCnjDr6iWNtYu0RK1d2htXrox7AkB5bx17515J1aiK2YrpSruCE3qSRml6UcMs8K47+QRYSMIfBiV9npLfqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aMkqjHvG; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aMkqjHvG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784906208; x=1785511008; i=markus.elfring@web.de;
	bh=lFO8VOdGYjzY3vaA4iyorSXAdZsj2AKzXtfVfArKFEI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aMkqjHvGKTs7cEWK7jk0HLSlhrEb3oQDiK1VSOJA3fSyYGHkgQcew8qiRUmGPUdM
	 g3P1JDxoaal6e09MDHCCst3dkByS4Pxdhgds/dui4KeD7nObxXB1cLWT20fF+8XEO
	 5BiPxnP/8WrKcv//1mRHT72tCNwhftkzkLJCNI2GpygnXuOgghtff2/WOOyyNKusG
	 /yQ6tOh6F3+0Eh9r/xfcHwCsn6GE6wMdeq5ESMJObDPUGFh8HschGrUXAJAm7lEqG
	 vZqMro6uSz1ForAkMwxHOVdLRjx+xOES7ex/bSGkxICSVq9xIJqfnA/wPrukk10e4
	 00gsZj1fI0Qyyx5yMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrPT-1wZLWt2RrX-00QG1w; Fri, 24
 Jul 2026 17:16:48 +0200
Message-ID: <a1abe46c-3040-485f-8d2f-3c5f56d03b0e@web.de>
Date: Fri, 24 Jul 2026 17:16:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vaibhav Nagare <vnagare@redhat.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Vaibhav Nagare <nagarevaibhav@gmail.com>, stable@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Ariel Elior <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>,
 Matvey Kovalev <matvey.kovalev@ispras.ru>,
 Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
References: <20260724140044.1055918-1-vnagare@redhat.com>
Subject: Re: [PATCH net v2] qede: Fix NULL pointer dereference in TPA fragment
 processing
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260724140044.1055918-1-vnagare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yl+WShJP79N0UZelCGEj/9KlgXXHt0nIPdY3cAsF47VD+gQ7s9p
 PwSI7nZcpoOP6NoVOeM/DpiHAfBiFr5dNqU/dCt4Li3vFHflHDX8H/5ksImnx/mVuNKsyG1
 MiG9qV6PyH+oUDRKzTvDv4G95007LiLbKfpDBVWa/JRYGWuIP8bDkn32jUVYeP8lrPgd22w
 ljE3bvgovUzKsyNXRG+Mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TpCcm2c2pT0=;QYhZ+7NKnX0vuUpYnj1gx8AFXU3
 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

=E2=80=A6
> Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
>=20
>   v2: Addressed AI review feedback from Simon Horman:
=E2=80=A6
>   v1: https://lore.kernel.org/netdev/20260709044704.141507-1-vnagare@red=
hat.com/
> ---
>  drivers/net/ethernet/qlogic/qede/qede_fp.c | 39 ++++++++++++++++++++--
=E2=80=A6

Please move patch version descriptions behind the marker line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc4#n795

Regards,
Markus
