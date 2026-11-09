Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794266975;
	b=bRevZC3mKbDfpbmYkIpooKHcoGNvGLjBx3iVQ4isA4z/uhYhxQUBlidODtZMnSZlWMlC
	 YFIp7Rk+ZhRaUimEBEbiJ+5/qALpldBDRebJqa5BYbySgDgQ9wtUPISfB4RH7BUGwYMNb
	 OYtGhYdzMoALMpiNgADUROINFw9Yd/30JfqCmWb7nau2RvezIiVkreiPQuBVw8HButJMO
	 IAZj2LzT+ETgZvMjmJbf29p3M4G3GPtCDVrISzdLPMALg7yxraOL40Vrhf/VSfGRYMapl
	 ViXjSQsXKACJvWoqtzrKD4Qz7o3qV1hvn5xKImaARmJJimUNks5QbplY9eaYamhWAng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266975;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=uHE7poPRTNrYKOoUAKgTSfSnfCIOFFR8J8xVuB4fiMU=;
	b=Uyv3JGb2rECBudiL6eSH9vAqAYQsPvZsjR8qh3uMrGuvNaIZCBbznyZoJImkQNckmTqK
	 oy2cYKVdoDENokhFaIVtIB3AQZcMWnf0e8uOkF/RUdYdFPfZeihT55grScc8ijuJ8QUVr
	 vD3Jyihx2XpZvY2MJuffAF7NUVJtgYHQvwQX134RR4GIOuQQf1TXI5r9nfvI/zO92Kjge
	 vPGjZfzliMqA8AvK139951DTR4I+IMzMfUndg257zX3w1w3SjQr+DeSRqFJKcKDIzo7/Z
	 x27IWsploMKxmcxYUsKoJlhKKW2+oJYB5Lq8buUhfz87TFTiQrKiLSAXzKIESYtiACw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="AQr/wRHb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48609606A321;
	Mon,  9 Nov 2026 23:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48609606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=AQr/wRHb
ARC-Seal: i=1; a=rsa-sha256; t=1794266957; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fsf0Hk2FnriheINxsWwPT17T2lKNpqvHtnyGY4WzQ/YKq1dDDlT0QQAA0DWEMey0/zJpOje03WbA8mKlno+gWaOsTXDA6+MhbHYLs9O/cElbboQBcQzfnxUu9eOsfSRCsDrnzQCU+Pb9fiB+Gki347w/kX5166vw5pYHX7JBxHg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794266957; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uHE7poPRTNrYKOoUAKgTSfSnfCIOFFR8J8xVuB4fiMU=; 
	b=NKBvjH7E0ZbZM4aKChjYiew45tGZlLN/4jo3hH/2nBKOq/HZy8/EVkwht0kqRRemreCHRJpg23JUqmErVEoPCMRSwIAcMJrpSSAIJ1BYKXsl6P8e9UaaQhrJMXrZ//4Vlm1wiViERZp4Qh3IL2Z0aIoH6h59gxxJaf6yUYKZGCs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=AQr/wRHb0XJENbWYjxwjG+7mFLbD87+U38HHIZ/eY/Cb6YJryUcs+TtZsW/E5VtvDKrArvTd+XEPg8Zh889bxeJd/JQJ5WoCTDJUybhs71adQwJF2212hlMNPsYZMSUBhMJpzgWkvkfUNErwNtmxjkQ6iAhMgxRIxmQZnpokXHo=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=uHE7poPRTNrYKOoUAKgTSfSnfCIOFFR8J8xVuB4fiMU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794266956303190.50034302404822;
	Mon, 9 Nov 2026 15:29:16 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id A5582180317; Tue, 10 Nov 2026 00:29:11 +0100 (CET)
Date: Tue, 10 Nov 2026 00:29:11 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: ricardo@pardini.net
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Andrew Powers-Holmes <aholmes@omnom.net>, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: Re: [PATCH] phy: rockchip: naneng-combphy: fix RK3588 SATA pipe_con1
 register offset
Message-ID: <avJULe_00cHwMh4X@venus>
References: <20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6roxkdhx6bgac7mu"
Content-Disposition: inline
In-Reply-To: <20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.7.7.1.5.4/291.452.71
X-ZohoMailClient: External


--6roxkdhx6bgac7mu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] phy: rockchip: naneng-combphy: fix RK3588 SATA pipe_con1
 register offset
MIME-Version: 1.0

Hi,

On Mon, Nov 09, 2026 at 02:12:47AM +0100, Ricardo Pardini via B4 Relay wrot=
e:
> From: Ricardo Pardini <ricardo@pardini.net>
>=20
> On RK3588, the sata2 PHY speed is selected by sata2_phy_spdmode in
> PHP_GRF_PHP_CON1[1:0] (offset 0x0004), with sata2_phy_rx_err in bit 2.
> rk3588_combphy_grfcfgs has pipe_con1_for_sata at offset 0x0000 though,
> so the value 0x2 (6.0 Gb/s, rx_err cleared) ends up in PHP_GRF_PHP_CON0
> and CON1 is never written.
>=20
> This leaves sata2 at its 1.5 Gb/s reset value, so the link only trains
> at 1.5 Gb/s, even with a 6 Gb/s capable disk and no SControl speed
> limit. sata0 and sata1 are not affected: their speed fields are in
> PHP_GRF_PHP_CON0 and are set by pipe_con0_for_sata.
>=20
> The register layout is described in the RK3588 TRM V1.0 Part1, section
> 6.17 "PHP_GRF Register Description". Rockchip fixed this in their BSP
> kernel in 2022 by moving pipe_con1_for_sata to offset 0x0004.

Drop the last sentence. It's not relevant for somebody checking the
git log in a year or two.

> Tested with an mSATA SSD on sata2 (combphy2_psu). Before:
>=20
>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>   Timing O_DIRECT disk reads: 374 MB in 3.01 seconds =3D 124.45 MB/sec
>=20
> After:
>=20
>   ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>   Timing O_DIRECT disk reads: 1266 MB in 3.00 seconds =3D 421.78 MB/sec
>=20
> Fixes: a03c44277253 ("phy: rockchip: Add naneng combo phy support for RK3=
588")
> Cc: stable@vger.kernel.org
> Link: https://github.com/rockchip-linux/kernel/commit/2f5fe2c0bbd4fa95102=
aadd60da1100989103aa0
> Cc: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
> ---

The patch is 1:1 from Yifeng Zhao with a better commit message.
You should keep him as the patch author with his Signed-off-by
followed by your Signed-off-by. Feel free to also add my R-b tag.
E.g. like this:

> ... (the commit message)
>=20
> Fixes: a03c44277253 ("phy: rockchip: Add naneng combo phy support for RK3=
588")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> [add proper commit message]
> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>


Otherwise:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

> This fixes the pipe_con1 GRF offset for SATA in the RK3588 combphy
> table, so sata2 links train at 6 Gb/s instead of being stuck at
> 1.5 Gb/s.
>=20
> I found it when an mSATA SSD on sata2 would only link at 1.5 Gb/s,
> and traced it to Rockchip's BSP kernel, which fixed the same offset in
> 2022 in a commit titled "config sata2 rate to 6G for rk3588" (linked
> in the patch). The RK3588 TRM V1.0 Part1 (section 6.17) agrees:
> sata2_phy_spdmode is in PHP_GRF_PHP_CON1, while the sata0/sata1 speed
> fields are in PHP_GRF_PHP_CON0 and already set correctly.
>
> The misplaced write lands in PHP_GRF_PHP_CON0[2:0], which are the PCIe
> link reset grant bits, and turns on the one for pcie3x2 whenever a
> combphy is put in SATA mode. I don't know of any effect from that, but
> this patch stops it too.

You can add the info about this writing the PCIe link reset grant
bits for pcie3x2 to the commit message and drop the previous three
paragraphs from below the fold that are basically repeating the info
=66rom the commit message.

Greetings,

-- Sebastian

> Only sata2 was tested. U-Boot has the same table and the same problem;
> a fix is being sent there separately.
> ---
>  drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers=
/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 3102a99128f6..c469222dba8b 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -1395,7 +1395,7 @@ static const struct rockchip_combphy_grfcfg rk3588_=
combphy_grfcfgs =3D {
>  	.con3_for_sata		=3D { 0x000c, 15, 0, 0x00, 0x0407 },
>  	/* pipe-grf */
>  	.pipe_con0_for_sata	=3D { 0x0000, 11, 5, 0x00, 0x22 },
> -	.pipe_con1_for_sata	=3D { 0x0000, 2, 0, 0x00, 0x2 },
> +	.pipe_con1_for_sata	=3D { 0x0004, 2, 0, 0x00, 0x2 },
>  	.pipe_pcie1l0_sel	=3D { 0x0100, 0, 0, 0x01, 0x0 },
>  	.pipe_pcie1l1_sel	=3D { 0x0100, 1, 1, 0x01, 0x0 },
>  };
>=20
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261024-rk3588-combphy-sata2-6g-03bb30151552
>=20
> Best regards,
> -- =20
> Ricardo Pardini <ricardo@pardini.net>
>=20
>=20
>=20

--6roxkdhx6bgac7mu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmryV0MACgkQ2O7X88g7
+pr2OhAAmxrt9iWQqsLZ88EeVj0HWviV+7WVM8l74gh7cXl2x4t1sM/LeqbmRjzi
d//J3Wd59neQxBNR4R0iKVhn6OGSmFUnnYJsh8y7lDNkrIxiYuLWoiA+ibdnwvrg
XvTpfaKuPuRCZ+BD7I5ibL3QCiNjxhr/4ZPk01GlG2jdAfV5qlsOb1kecyXHHWOy
qJ3NIPD++XrsvgE6nyjvYQv4hTuZgvf/Rj0nDC4IgRVG6ysqaIAcisPGFxX3HvnN
4d5hkLciRnBxU7JFWWqG+EsY7sR4xKQtPSbzVmw8u1pcWVTDDUqOMRiHcRvGsELf
DLWspqOSOfUG9t6GKRWTB92lYUxGMJWGRLQTd7SjT3YoQUoGZHLmaVz+l54XoDmR
w9zw4smrTd0RN4ckh4GkSgKKHTeTYYWIDUuYEXDfjFZcFUlGAEV2hAxutSvUhjTM
FqqJ6cytW2wx2BBf4bXKYHnHj1PD4a9GOh+WZniZhxbDZ/P7cDLjKhIsOIUtrLhM
58iB1LN6GhOWyoX59uacdaS0sKLv0+0ktoaqhlzQc+b+cUH/wvMSB6EA18l7fuG1
oPJRUaxjae41lSiiB9/vldvadH94Hs14OeKB+pWtGRrehN5/BydrVY9MbGI7BwiC
jxBGSOsZNZ+XcMi50/eN1ZJOQP3DhWKvJir0MxrvoPGDH0y+3lY=
=sZwb
-----END PGP SIGNATURE-----

--6roxkdhx6bgac7mu--
