Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=87.76.132.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972543;
	b=MOdpjcpL9OjzmhgnqsPxUUqnI9D0QWZd12hSIzHakT4zizthRdnLcD7761wKroih8DbH
	 tE/IAwK9YUNxjFObayfdV+Yo768kgApat0y44HpY6Uar3U1SpNjNv7/Sx0+jfyE0O8XTV
	 upaTXnYCK4W/6x0yJDFfY9TiKTrkncy098eEGAglgOitfHhJgHdAxNNvROopkgO1ZulIK
	 5erdy1Wfz7iik5Cazo3+BHIkxXOSMDlhLH0Cyj5pSbQMKWQcd8becFuavX9bi2cB2iXes
	 ax0oQalzaCD7RJEGf86AqbuzMx6XJTWU9bitv0V+yOUW4WwGI6WyOKPBL3QQRHE89Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972543;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=+KHEn47nlQ9uLgtAXPZVmmWUYpmyUHFzXRIF/RY1rao=;
	b=tHOQl5SiZ+2HAHfPRgek4THXnbkDiqcP7UTThwV/7ZGyViyyCY3XbPkbBbHll/TgFf4e
	 V+LLKmNLa5ICvr7Y3f2XV0nALp+ctGloIyuTGgE3mnQoGbzo4dc8wOfx9cJ/YD/TqiZSw
	 amIRYzjAA7Z2SYU3gu2n4MBELGT2kqt3ETfQ1uWXMHsGb3/fTVTt+2KsDKlqG7vrHV+/f
	 X6aSvz802Y1bSqcaG43M3L6LI1hgAqyzZFkcjXH2p+LueIruI509qP/HDRJsZla9D3VFw
	 DAN9H4Mlw6Qwtom3UIepDKrbHiamXYUS0ujRtxQJ4tucp51rh0DefkrcxzMhVn585Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auth.ink;
	spf=pass smtp.mailfrom=auth.ink;
	dkim=pass header.d=auth.ink header.i=@auth.ink header.a=rsa-sha256 header.s=dkim header.b="Or/t5clz";
	arc=none smtp.remote-ip=87.76.132.165
Received: from mail.netskyway.net (mail.netskyway.net [87.76.132.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82D606A31A;
	Sun, 25 Oct 2026 23:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F82D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auth.ink
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auth.ink
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=auth.ink header.i=@auth.ink header.a=rsa-sha256 header.s=dkim header.b=Or/t5clz
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22C3D3002E4;
	Sun, 25 Oct 2026 20:55:34 -0300 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=auth.ink; s=dkim;
	t=1792972536; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+KHEn47nlQ9uLgtAXPZVmmWUYpmyUHFzXRIF/RY1rao=;
	b=Or/t5clzfgdcHBxUqqDIyqrK5tzW5yXkV7/pJ2rj8L9cNt8dXpudRsChZUsUkLWjz9rwWF
	/J9o7dDMsHQAXSnI3vXHzG/moTrJFuGbntengRfWzQl9/LhYjaxTaUqImiLppIluWZQeOz
	fMNk1r1Dq4eb7jL0hC/QAh993c1cyiuLCFQm1vzsD4PL3wvht9Ts80U7OVh4caAhwisKF9
	kxcnq+rNtCsFyfksv3cnTCYvP4yNQNyr+XtHBS/9C2xNeMhtfHxzIyeiiQ2CCw3p0MLaDg
	UShscoiamUHwXJTVxtOA3x2pBv2SVBEa7ypY3+zpf1nq0Rsd8TvwF9w/fr2s2Q==
Date: Mon, 26 Oct 2026 01:55:33 +0200
From: Tamir Awad <tamir@auth.ink>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
CC: lee@kernel.org, netdev@vger.kernel.org,
 Rodrigo Zaiden <rodrigo.zaiden@canonical.com>, kuniyu@google.com
Subject: Re: [PATCH 5.15.y] af_unix: Clear oob_skb in scan_inflight()
User-Agent: Thunderbird for Android
In-Reply-To: <4ADFAF9F-7A76-4897-9374-914E5A384D8F@auth.ink>
References: <1685aeee-c65d-4a8f-9bfe-607e13e114a9@auth.ink> <2026-10-25-1-daily-reply-0005-af-unix-oob-skb-5-15-hold@kernel.org> <4ADFAF9F-7A76-4897-9374-914E5A384D8F@auth.ink>
Message-ID: <A37FE39D-BD84-4FBE-A160-1ACE5AA98D39@auth.ink>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Sasha,

My previous reply was rejected by the netdev mailing list due to HTML form=
atting, so I'm resending this in plain text=2E

I've added Kuniyuki's updated address (kuniyu@google=2Ecom) to CC, as deli=
very to his previous Amazon address failed=2E

Kuniyuki, could you please review the 5=2E15=2Ey patch and provide an ACK =
if appropriate?

Patch: https://lists=2Eopenwall=2Enet/netdev/2026/10/23/274

Thanks,
Tamir Awad
