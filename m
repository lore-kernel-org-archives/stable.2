Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F360B2E06D2;
	Tue, 25 Aug 2026 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787630061; cv=none; b=WutjqY4tkgSfZCIgnp3/Sg9JVBjVHlhJgbSiDCtwSY2rWyPaGPEcJHmL8vYI5Ql/cNDC3fv7vTVbj4VPZ19kPIJjrwuB4EQ4D7rC1EgqQBca3gD7GUseRwwMs2arZF7WDyy2UzHqsY0bjTX00rszSHYm3dzOd9mJDptAu1ZZFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787630061; c=relaxed/simple;
	bh=dFdr8G1vz6Vpx+B2PLtCdd5urz0EkbuxYwY7vvR5iZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BVnzfA72j3gXKjphJFc6C3gksUJoeBWFT4Mv1+arAvvp5AVTHn9htvxvEf1pMpOjYAjhL/bbypS+Nvv3Zexyc81sKJNbF19PggsELs2QGkxppHNLbw8ZRACpyUCAkoAbUyNRZ28+bQEpqHsmQu1tgIpkdZFrze3R/wCnD3WePeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XQQ1mkjz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="XQQ1mkjz"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67P3sElpD3451056, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1787630054; bh=pVUGGUtESPWCr8U+vx+Fo0CZMZDSVHEAUQUUytioJR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XQQ1mkjzoRPFgbNiG6pYiqbosL8zNv3A07jiRTfMAQebnnug7Qeo36b/tHXqPaRC5
	 U3DUAgT0yjZat5ObicbT4l1h9iJoxWpdEvHbCR1pUTpXWu28HzlZpsy30pcyRmn2do
	 9/o0NyiUlp9YrguHBgSP0bdXV+/Uc/xQRWMxDsrkyyqYIXhyL35iIupm7hY6zDEGcJ
	 VZckowop+ZfCHTrGZYCtUgU7gAQIzTuOvi9PJQgalT6AT+C6ay2MaSx/Ie/XCDmL7k
	 zdQV5478I0oLdvXh3NDCl7UD2CwLoa7kIhgxFeHjINdhrcMhEjZSZ97G2dHHwWCCiO
	 GzjOEzPWJt1Dw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67P3sElpD3451056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Aug 2026 11:54:14 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 25 Aug 2026 11:54:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 25 Aug 2026 11:54:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Tue, 25 Aug 2026 11:54:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: cap firmware section_num before parsing
Thread-Topic: [PATCH] wifi: rtw89: cap firmware section_num before parsing
Thread-Index: AQHdMgxJ9Xw3tB5KAUijU9hAYY9J+rauJi5Q
Date: Tue, 25 Aug 2026 03:54:14 +0000
Message-ID: <26bf80f23bfa4fe49183d1f724fffc5c@realtek.com>
References: <20260822080014.29611-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260822080014.29611-1-acharyalaxman8848@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Laxman Acharya Padhya <acharyalaxman8848@gmail.com> wrote:
> rtw89_fw_bin_info.section_info has FWDL_SECTION_MAX_NUM (10) entries.
> The v0/v1 header parsers take section_num from an 8-bit firmware field
> (0..255) and write info->section_info[i] with no cap.
> rtw89_fw_download_suit() keeps that object on the stack, so a crafted
> firmware blob overflows the stack.
>=20
> Reject a truncated header and a section table that does not fit in the
> firmware image before reading fw_hdr->sections[i].
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Logic is good to me, but please add empty lines.=20

> ---
>  drivers/net/wireless/realtek/rtw89/fw.c | 30 +++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wirele=
ss/realtek/rtw89/fw.c
> index 0099c5c03e7a6..57d4252ee78f0 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.c
> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> @@ -156,8 +156,23 @@ static int rtw89_fw_hdr_parser_v0(struct rtw89_dev *=
rtwdev, const u8 *fw, u32 le
>         if (!info)
>                 return -EINVAL;
>=20
> +       if (len < sizeof(*fw_hdr)) {
> +               rtw89_err(rtwdev, "[ERR]fw header truncated\n");
> +               return -EINVAL;
> +       }
> +
>         info->section_num =3D le32_get_bits(fw_hdr->w6, FW_HDR_W6_SEC_NUM=
);
> +       if (!info->section_num || info->section_num > FWDL_SECTION_MAX_NU=
M) {
> +               rtw89_err(rtwdev, "[ERR]invalid fw section num %u\n",
> +                         info->section_num);
> +               return -EINVAL;
> +       }
> +
>         base_hdr_len =3D struct_size(fw_hdr, sections, info->section_num)=
;
> +       if (base_hdr_len > len) {
> +               rtw89_err(rtwdev, "[ERR]fw header truncated\n");
> +               return -EINVAL;
> +       }

an empty line

>         info->dynamic_hdr_en =3D le32_get_bits(fw_hdr->w7, FW_HDR_W7_DYN_=
HDR);
>         info->idmem_share_mode =3D le32_get_bits(fw_hdr->w7, FW_HDR_W7_ID=
MEM_SHARE_MODE);
>=20
> @@ -455,9 +470,24 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *=
rtwdev, const u8 *fw, u32 le
>         int ret;
>         u32 i;
>=20
> +       if (len < sizeof(*fw_hdr)) {
> +               rtw89_err(rtwdev, "[ERR]fw header truncated\n");
> +               return -EINVAL;
> +       }
> +
>         info->section_num =3D le32_get_bits(fw_hdr->w6, FW_HDR_V1_W6_SEC_=
NUM);
> +       if (!info->section_num || info->section_num > FWDL_SECTION_MAX_NU=
M) {
> +               rtw89_err(rtwdev, "[ERR]invalid fw section num %u\n",
> +                         info->section_num);
> +               return -EINVAL;
> +       }
> +
>         info->dsp_checksum =3D le32_get_bits(fw_hdr->w6, FW_HDR_V1_W6_DSP=
_CHKSUM);
>         base_hdr_len =3D struct_size(fw_hdr, sections, info->section_num)=
;
> +       if (base_hdr_len > len) {
> +               rtw89_err(rtwdev, "[ERR]fw header truncated\n");
> +               return -EINVAL;
> +       }

an empty line

>         info->dynamic_hdr_en =3D le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_D=
YN_HDR);
>         info->idmem_share_mode =3D le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7=
_IDMEM_SHARE_MODE);
>=20
> --
> 2.51.2

