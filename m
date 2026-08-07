Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4B378D8B;
	Fri,  7 Aug 2026 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128004; cv=none; b=NWaxUkKstjGaP3CCqG7EXx7RUE42rtgO4UQuPeh5st0cRzrXE7bwBoOzF+kiMuTnbCm92hJTbA2+CArmrowgpz/2QHTgENqRkUGWkwG3Kl3eQH3mdo79Tb2a3eNBNCvgNKDZ9aYdNdTJtmdSJeF8IirwPKQ7U6rHgpwxr/vkY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128004; c=relaxed/simple;
	bh=1SEKdE0RgioBJ5zpkpaMdX+EPmtIBFWXGqn5hAStrlI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WlirsFqjQDRAFMuEFR148/YNltOpeSWAlA026qtYf1mb2c37Pf3gbyxrBgRWe4SRvDFEOvpPCbaMhtnB/KAQ4JK0dSKqJ1MxmPK7EnNIaHz95G8qk4+ljoXEik5Xdg/JXrerN1VSGeVnqLtBooMlofnNczG68dGLgREXbQv76ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XuJ4tXkf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XuJ4tXkf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zxRYcCKMAB9BEGfCUUNSRJUQ8AWqDioy7n/wpVpm8LY=;
	t=1786128000; x=1787337600; b=XuJ4tXkftHOvKJnDKsUln26C/pHiehO9T+q+kM/J013EZgo
	DhqMF3nV5/Bxjxxz4yPzknX4FU6hUb2udvH+1tD+OoxBaNawIN+KveF/LE3vffs65Caa6xzz315rz
	5xSZY7ctxuVFOsG7Hhv6P3k4Wvi3dX3PXPdUAqDCYly8GTlJCXMm8bBX589YDdZ/jbrvJNmIH02Dq
	l9ExJnUyDKnmlCAwxdp67HDt5K1YEJuQ48NqvaunG07JGg6PixTXOYmU63cOp0eEUSKy0ff9hMNNd
	WKjiki9f5Fng62a0c4gC+a6iUE9qCQcrRk92gpuT8NeYJya1VjtyafwduwiKgm6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wsPTu-00000008ULg-2sZj;
	Fri, 07 Aug 2026 20:39:46 +0200
Message-ID: <9cf8e6ee9c4c655e685708bc5660429074b18326.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] wifi: mwifiex: ignore ROM regulatory hint on
 WRT3200ACM/WRT32x
From: Johannes Berg <johannes@sipsolutions.net>
To: Georgi Valkov <gvalkov@gmail.com>, briannorris@chromium.org,
 andrew@lunn.ch, 	chunfan.chen@gmail.com
Cc: francesco@dolcini.it, kees@kernel.org,
 miriam.rachel.korenblit@intel.com, 	wenst@chromium.org,
 rafael.beims@toradex.com, avraham.stern@intel.com, 
	peddolla.reddy@oss.qualcomm.com, error27@gmail.com,
 s.kerkmann@pengutronix.de, 	gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, robh@kernel.org, 	krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 07 Aug 2026 20:39:44 +0200
In-Reply-To: <20260807182124.41572-1-gvalkov@gmail.com>
References: <anWWr80yAcOQaVVS@nxpwireless-Inspiron-14-Plus-7440>
	 <20260807182124.41572-1-gvalkov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2026-08-07 at 21:21 +0300, Georgi Valkov wrote:
>=20
> +				/* Allow platforms to ignore an incorrect
> +				 * regulatory hint from ROM, so userspace
> +				 * can set the correct regulatory domain.
> +				 */
>  				if (country_code &&
> +				    !of_property_read_bool(of_root,
> +							   "marvell,ignore-regulatory-hint") &&
>  				    regulatory_hint(wiphy, country_code))

You're supposed to always update bindings first, no?

johannes
