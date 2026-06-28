Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274A2EAB82;
	Sun, 28 Jun 2026 03:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619005; cv=none; b=ti8bF12B9i7RcOLtnxSIRFAqGw5bqAF6zFNPtNx7l6tG2iw+GQJeu3nCmdEEDIm4NDg52wmBXn5FjyZKbRh3UKjZScwXmjCCwM1qKeF2xH3D+6VsyBEg6aIx81TRPDqla42aFtGQPZm4PYOBMnEgJuf+m2pZpfVlSzUtfXx1qHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619005; c=relaxed/simple;
	bh=ySfoBfR3OpmIN9VesZyqZy8p9Fp7Dfb8MMkecoPLnwY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JvGkpjrtivt3ffYp+VEWAcS6Eok1x+YaJaxL9Jyki8FVFKOPjtZ2EVvsE++5QsanmUhIJgf2c4fcVnkjH7BP/qgR7DSXc9K7crCi/80O+rUfz0d4PO4US+CQ6aOf3Vjj6XqWvEaviP3QWz0wVnSupqFoqAaLayKLhbuZ28cDs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowADXfdYKm0BqqCuqAw--.7249S10;
	Sun, 28 Jun 2026 11:56:34 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/tegra: tegra_dc_pin: chunks>1 error path leaks
 current mapping   from host1x_bo_pin
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626144958.49221-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:56:23 +0800
Cc: David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 linux-tegra@vger.kernel.org,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF581601-39A9-4F19-ADA1-2FEC1EE9C991@iscas.ac.cn>
References: <20260626144958.49221-1-vulab@iscas.ac.cn>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowADXfdYKm0BqqCuqAw--.7249S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Xr18trW3ZFyDtFyxJFWUJwb_yoW8Jr1fpF
	WUtrW5KrZ0yry3Ka1xJF4rZFyav3sxKFWxGr98Gan3ursxtryUJrZ8GFWqqayDJr4xCw47
	Xr4DKFs3G3sFvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8Zw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjHq7UUUUU
	=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMMA2pAhrYikQAAsj



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 22:49=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> When map->chunks > 1 triggers an error, the function jumps to unpin
>  before storing the current map in state->map[i]. The unpin loop only
>  cleans up previously pinned planes (indices 0 through i-1), so the
>  current mapping returned by host1x_bo_pin is never released via
>  host1x_bo_unpin.
>=20
> Cc: stable@vger.kernel.org
> Fixes: c6aeaf56f468 ("drm/tegra: Implement correct DMA-BUF semantics")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/gpu/drm/tegra/plane.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/tegra/plane.c =
b/drivers/gpu/drm/tegra/plane.c
> index 0cb30910773f..e61485ee58f6 100644
> --- a/drivers/gpu/drm/tegra/plane.c
> +++ b/drivers/gpu/drm/tegra/plane.c
> @@ -161,6 +161,7 @@ static int tegra_dc_pin(struct tegra_dc *dc, =
struct tegra_plane_state *state)
> 			 */
> 			if (map->chunks > 1) {
> 				err =3D -EINVAL;
> +				host1x_bo_unpin(map);
> 				goto unpin;
> 			}
>=20
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

