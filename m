Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FEE47427A;
	Thu, 23 Jul 2026 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834147; cv=none; b=KNP2YBT9mQiM5QuZN2b/tZMiQO6Y9FdgsG2vQEgeYIIoDyesQp0woUdRzxONKDZJg1NQgccXTDFUiZuJwDevdCewb6/2fPlkUquj9Zl7bFV5DMrjKiRkF9chKrw2Bsx8fxnYSjDq50mjDU/jZdFNe+Q3trA9VzyYu+4PRLn8J5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834147; c=relaxed/simple;
	bh=uCW1kXMwf4PGuUEnT7OQAnOTOXPxStUgI2pg2VZlxgA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=HxsLVUArfwtSRnLEa+4D1l+ngGPXM89FT84S0nQPwdUaeV4T7Ed9CGELKLyX4Zjq20oCtYQkHE2r0PWAKnMvZRZw2YJPrHqptsB/PoQnBtCMX4e3HSWml4xSM9WzPwY5Uqr3DOMp9TRCpenZIPJjBYNDvCxtAtLNiX5wt/T0+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Mk17AewM; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Mk17AewM"
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c68:25d4:fa24:78d1:31:7a56])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 68A0C1D18;
	Thu, 23 Jul 2026 21:14:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784834073;
	bh=uCW1kXMwf4PGuUEnT7OQAnOTOXPxStUgI2pg2VZlxgA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Mk17AewMFrN94wLLhJZL07pYkZJmkrAho0ag0EUEXSrYGBcTnHdwlyAH0kCowT2u9
	 lj7fUdG7VROfh4RFBWZBXQpfrMOSLdAXuo3HAOEjfTEvLY7+2wFnPT7pwzQgXvQdNx
	 Y7BuJvI3cLkG8LoEFGjSYgsR/ovjHffVl4k7e3g0=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260723154117.1917644-1-b-brnich@ti.com>
References: <20260723154117.1917644-1-b-brnich@ti.com>
Subject: Re: [PATCH v2 1/2] media: imagination: e5010: Move e5010_init_device to Runtime Resume Hook
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, k-willis@ti.com, b-brnich@ti.com, stable@vger.kernel.org
To: Brandon Brnich <b-brnich@ti.com>, benjamin.gaignard@collabora.com, devarsht@ti.com, hverkuil@kernel.org, mchehab@kernel.org
Date: Fri, 24 Jul 2026 00:45:29 +0530
Message-ID: <178483412945.3268456.2480655680667852399@freya>
User-Agent: alot/0.13.dev35+g4a69c46ca

Hi Brandon,

Quoting Brandon Brnich (2026-07-23 21:11:16)
> The PM framework skips the runtime resume hook during system resume if the
> device was never on in the first place. This results in a crash when a ca=
ll
> to e5010_init_device in the system resume hook attempts a write to a
> powered down device.
>=20
> Move e5010_init_device to the resume hook to ensure register write only
> occurs when device is properly powered on.
>=20
> Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>

Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>

Thanks,
    Jai
