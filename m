Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780332;
	b=Ac30nw+wWH87RN0QEXlXhPTn41StNlwTIRREKblTBtHi4NDvFkEUSSRYsncl3+Etn1W9
	 vf3jQ3q6y4/4j78LnYTnCQlUygb2jV8Op4tZzLYWcWei16z4MwVzbrwoAD9sVjjemdIDj
	 6bOtwS4eOsav669I2lbLgHJLj7d0hRzHNj2GS+9Dp3b2JKWppd8hii15OgcYQc0oOqsfz
	 ORldJvzNVa8DKIckC/wrYLxOrsKOoLbJl4IpeWKwMJW0BWgTDHl9xoBB8SCYDy7+hwB1m
	 6H0YZdO6PbJg8UR0SZ+haVC78Z4zwMuUHrwgSiwOv48OG0DcuWEcjMuqHm/4DL3jgjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780332;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=hi5qJ65lroEbJctduqeaaU8tikCP3YYY/M/NeJrI+/E=;
	b=ZlQigkRkxjv96aIdqsGIKwn6ZL+/Ht+n7UVNzzDDkrSfqBd+lkYWrNQ/X/QHodvKwTzx
	 SuvLJlwXgeUO1IEPyDL9miWKKtlBdI0NOeh6YvSywV9vSwwDT/83xtxi43WBaoRaijEyz
	 pBNpKfTDuVRUu1Tvzi0ydJ4lZq7ph8VLkteVJL9HsCF0AYDgMYDKRZDAMlkjB3TdjF2r/
	 pWK2BEyFfGYMholJqTBt/fdmGkJ6PXe3tGXuWME6yiI7mRPQBgIsv4028h+nAfw8c6Gp4
	 JCkVUbQAuFTloa/tu6t02LjQJt0E/4eGgJlWXFO7akQS7JFJrSGDLm7Lb0r2DzzCjqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5JTWdx4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C5606A31C;
	Fri, 27 Nov 2026 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5JTWdx4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29441F000C1;
	Fri, 27 Nov 2026 11:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795780332;
	bh=hi5qJ65lroEbJctduqeaaU8tikCP3YYY/M/NeJrI+/E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=m5JTWdx4qsiAu96OHymoYaIML+ZcUr1Gybqs4jUGiY742mpTqvYW4MY1kobdMePqL
	 8ANNDxOi9zhd1vdpRZy4HTOiiR7hQkt++15a9UsEIc3Wum1iUUuglrozSjOByOBwFW
	 268oVPX7kRYZ9ijdO7utkxoPohh4bN5Vcvvq1Md6vV/KWCa273W3pLDngfaYxNVIsK
	 Ix+4C1jSutkLmZEs2cQajXeFl34NlWQto6FR8dTi25DZqOYdcHwqvthdhOr++Rp0OE
	 Cus7GGmcqvmyuv64+EQq/ljPxtQPD4NChhTib031vW5WhkpE/F5F9QDVDi28sMpHNd
	 Y2qy7/yi4pT2Q==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] phy: tegra: xusb: fix OF node leak on lane probe
 failure
From: Manivannan Sadhasivam <mani@kernel.org>
To: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org, 
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261109074711.1751-1-zhaofeng2@cmss.chinamobile.com>
References: <20261109074711.1751-1-zhaofeng2@cmss.chinamobile.com>
Date: Fri, 27 Nov 2026 17:22:05 +0530
Message-Id: <179578032581.13164.17986311510079310417.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=mani@kernel.org;
 h=from:subject:message-id; bh=TijvSIXr2L21MTkuYOVikZl0F1o8JosKj9YQshKhm9g=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrCW7o+bgsB01pCH3JjHuIX9X/Kz1cQCjR7j7wa
 rX+uTVx5zeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawlu6AAKCRBVnxHm/pHO
 9eQpB/0W8yqkr12ZPnf2VE9JVsV79m18yW2Z5/fMcYYwbWGa7V14g/Fu9fDRWRnmNgeWoOUoyi8
 Xl9JFIbSJAXWPK+X2axHZk4TQKQbLEXGgCl4ltb4ScTon7MsQPEFC6DQzeWrSvNGz804kb3eyhk
 WQuLZ5BUetnHCpDaseBVCH845+geTJooAJr1/M0DxEneVs69XQzWm+BJSWhVYR1QOBIkgy44tFD
 6hprBbUkSG3Y9PR7O3QCt4pPdwZZ7hlkn1ZsUgpmHuSpMbRTCOr6qP/VFpzmeiCymovOpUQV4vG
 yntqzmepAGsttjipRli3sMkjMN5TJ2yePQE0Kb6PWpeWGoMC
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-09 15:47 +0800, Zhao Feng wrote:
> tegra_xusb_pad_register() obtains a reference to each lane node via
> tegra_xusb_pad_find_phy_node().  On success the reference is
> transferred into the lane (lane->np), and the disabled-lane and
> phy_create() failure paths drop it, but the pad->ops->probe()
> failure path (e.g. tegra_xusb_lane_parse_dt() rejecting the
> "nvidia,function" property) jumps to remove without dropping it,
> leaking one node reference per failed lane.
> 
> Drop the reference on that path, mirroring the phy_create() failure
> path right above.
> 
> Fixes: 53d2a715c240 ("phy: Add Tegra XUSB pad controller support")
> Cc: stable@vger.kernel.org

Stable tag should be dropped. This is not a critical fix to backport.

> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

With the tag dropped,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Please respin.

- Mani


