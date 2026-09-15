Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680925B2F4;
	Tue, 15 Sep 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478577; cv=none; b=TH+AbBuq1RYwkGcHmQQVIdHBM2vMBrVUH1tfGXuloxplhOcRsCoFMixCu3vgLV2tOK6eW4uW5FHpt2kEGPqHcz8VQommM84QVNSR07U+GU8sM1j6NwAQ/9FHaxMCBjx+XQueBufRxV1gpl0FLqKMXBRIAeYFjlz14TsEPV21bsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478577; c=relaxed/simple;
	bh=JMXomYmsfmIoISdAio4INXjT/EiwXOv/5nZ607WuGTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=neR5rso1viuDKKJXsj5bR5+vLy+eFEYZbtBFRIf60fYId9q9n9frBNq2AEikv9nqAauHWW2W3xcwQJDvgkKOuFYaB+MKRQ85x8h6Vf/wfoEbd4cqjohe9B3j98JquJUDoA/NofgSpNria7rRdQqkfgMna0LKMZ1cDwi0/xJ8qcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kH4lbsDH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kH4lbsDH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JMXomYmsfmIoISdAio4INXjT/EiwXOv/5nZ607WuGTw=;
	t=1789478575; x=1790688175; b=kH4lbsDHlCBeFhkOfS3xi30PFs02tsg0dC6FYXscLOmPZ/e
	7UTlMsCplQTKTIPcJe1sT2JusuMdGmwc6wayMpgBWSIG0gjHpm0StGBKwP+/QFrgXy/WrLFt6+al+
	5WO/PNHO1HV/k+JgpAg0HkiC8PbqNb+I6e2XGo9NSxIGS+4OQ8JObON0PWrq/hURF20B/UgKAufuu
	zn2HzOOB8pVv/TSTtdykXdWosylC1Ii1cuOGDx4hOkZOyj7hPI8tmF/vtn2zqOeo8GGVZdRGjXXk9
	67RXW9OgmZeUhGMPpQW3uTGXSN8DfJo8dEcpwoupCK5XTAafnyYvqJN8UwHVAylw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x6T7b-0000000H0Ft-1FNg;
	Tue, 15 Sep 2026 15:22:51 +0200
Message-ID: <3422e0b3b7d4889d2a728c41b0b02f6c80fa71bf.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Report port_authorized for
 4-way HS offload
From: Johannes Berg <johannes@sipsolutions.net>
To: Janne Grunau <j@jannau.net>, Arend van Spriel
 <arend.vanspriel@broadcom.com>,  Hante Meuleman <meuleman@broadcom.com>,
 "Gautam Shukla (Gautam Kumar)" <gautams@broadcom.com>, Kalle Valo	
 <kvalo@kernel.org>, Pieter-Paul Giesberts <pieterpg@broadcom.com>
Cc: Jason Huang <jason.huang2@infineon.com>, linux-wireless@vger.kernel.org,
 	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 15 Sep 2026 15:22:50 +0200
In-Reply-To: <20260912-brcmfmac-4way-handshake-offload-authenticated-event-v1-1-e41a6a8281a2@jannau.net>
References: 
	<20260912-brcmfmac-4way-handshake-offload-authenticated-event-v1-1-e41a6a8281a2@jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2026-09-12 at 11:40 +0200, Janne Grunau wrote:
>=20
> This will conflict with the "brcmfmac: add FT/OKC roaming offload
> support" [3] series but is written in a way to easily resolve the
> conflicts.

I ... no, I'm not going to take that conflict, and I applied the FT/OKC
series to wireless-next. Please create this patch on top of wireless-
next, if needed at all, and then you can backport something later to
stable if needed.

johannes
