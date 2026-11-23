Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795414946;
	b=oZh6yCpcnfV1tPoOSCgcPcdti6pch3rZHyVMellCM2hjDf5wEIpB/zOmI4cPUeQ04ZDe
	 8QcI5rrWfuvwWY//xK5lvWCzYgDCTWlnQOBYvlvQSCy/umVCHImZ8eO52EXRb1BYDKUOt
	 keT6oP8x29YNFbGRQpXRmKR0KvF+fy136I0kCPkEy412zOPUueN9VvG038wjZCT6K8KV0
	 FDrj7S4gUCpnNo5ElcgWtZeOb7rfOmZG8H+77Un1JApl2R8/XfYJZMMXIqH31jCdMGuZu
	 ++NWXMCtHxk3VfxHgx2ap/baIC+NXG8HxsGIB92yrgriWEBgRkwm/NXEok7GlFfb5PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795414946;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=Iuulysn4lb0jC1mnVffm2Qqxiyi30Og/058AoNcVATw=;
	b=TbtU1WbXbPl2GvNb3zJ7Ym514QsJPUn2b9svll+UlZH8kuaFE17iLAs16u6qH36VZL9y
	 1U+Uk49FxZDfHGmlJ5nO16ZScwLTCeSwQn1P6Y/IqNFgACSZ4sSMHzRTFEnG3w8QTItwd
	 dNI3zrecwCbiw9aRCPi8+7D2t0u7e74w0cUuxSiXe5NFyHWmSNyJQYyE7J6GPTE8NB2LB
	 aQWUPpsxl468ZOYeXU3G8i9uVjUnvcXpsHQWfMFEP4ih6lLwey3ewoS4mhj/FeXMVSxKL
	 /B5WFUDkY+7I7VmLQYlUfvdpyirD1IKSlSErgNykT7Aa7/2FqUYvSlQyvs3rcdpGlyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=kfJXl7Yz;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4F606A31A;
	Mon, 23 Nov 2026 06:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FE4F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=kfJXl7Yz
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AN6MLd441408909, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1795414941; bh=Iuulysn4lb0jC1mnVffm2Qqxiyi30Og/058AoNcVATw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kfJXl7YzC/Q3C2Lag9IM0fsIBXKT5G/vXQiJ4DHGcgrUrKy1YO4UACBKRu+gisM6m
	 co9dA1ceP/dnaM/AXftWQBZntUL+/PC1BH5CiLlj/OV1vQjmAAX4aIAfaVYSnr/6ir
	 B7ix0sC0DTDdcjAd/ppreoGi4zpWkcVfdBJHXbhiX3KfAboom7vkDDXrVcr5N9wGyZ
	 KAgTHXVcAMGpHCeKvSKPNvEPDsSeflH8Y+bbf4IvALYk5qbFQh/Ac0PchQ4to8uipW
	 Np1pWWOMq6/oa8kBJ6EZ+FThWiOUk3uBAZyaRo8iOzSlC3DmsLJnw9ntPKA936xYBP
	 gU1Om7A2SGdMA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AN6MLd441408909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Nov 2026 14:22:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 14:22:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 14:22:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef%10]) with mapi id
 15.02.2562.056; Mon, 23 Nov 2026 14:22:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zhao Li <enderaoelyther@gmail.com>
CC: Hemanth Selam <hemanth.selam@gmail.com>, Morning Star
	<alexbestoso@gmail.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next 3/3] wifi: rtlwifi: rtl8192cu: don't mark
 undecrypted frames as decrypted
Thread-Topic: [PATCH rtw-next 3/3] wifi: rtlwifi: rtl8192cu: don't mark
 undecrypted frames as decrypted
Thread-Index: AQHdedZ/5R97SfqA40GuX9ytRsKsmLc7MDbA
Date: Mon, 23 Nov 2026 06:22:21 +0000
Message-ID: <8954a1c1913d4f1bbc8c5bb52acf8b1c@realtek.com>
References: <20261121163547.37019-1-enderaoelyther@gmail.com>
 <20261121163547.37019-4-enderaoelyther@gmail.com>
In-Reply-To: <20261121163547.37019-4-enderaoelyther@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Zhao Li <enderaoelyther@gmail.com> wrote:
> The receive descriptor's SWDEC bit is set when a frame still needs
> software decryption. It is also clear for a frame that was never
> encrypted, and for a protected robust management frame, which the
> hardware leaves for software to decrypt. rtl92cu_rx_query_desc()
> nevertheless sets RX_FLAG_DECRYPTED for every frame with SWDEC clear,
> in two places.
>=20
> mac80211 then accepts an unprotected unicast data frame although a
> pairwise key is installed, and unprotected deauthentication and
> disassociation frames on a connection that uses management frame
> protection. For a protected robust management frame it skips software
> decryption and MIC verification, so a forged frame is accepted and a
> genuine encrypted one, such as an SA Query from the peer, reaches
> mac80211 still encrypted. A station in radio range can therefore inject
> plaintext data into an encrypted connection, or end a protected one, by
> spoofing the peer's address.
>=20
> Set the flag only for a protected frame that is not a robust management
> frame, as the rtl8188ee, rtl8192ee, rtl8723ae, rtl8723be and rtl8821ae
> drivers do. rtl8xxxu, which supports the same chip, stopped trusting
> SWDEC alone in commit cbfbb4ddbc85 ("wifi: rtl8xxxu: enable MFP support
> with security flag of RX descriptor"). The header is read before the
> receive path strips the driver info, so test the Protected bit first,
> which needs only the frame control field, and read that only when the
> URB holds it. When Protected is set, _ieee80211_is_robust_mgmt_frame()
> also reads only frame_control.

Need to reduce commit message generated by LLM.=20

>=20
> Found by code review. Compile-tested with W=3D1.
>=20
> Fixes: 29d00a3e46bb ("rtlwifi: rtl8192cu: Add routine trx")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
> ---
> No new W=3D1, sparse or smatch warnings.
>=20
> AI assistance was used.
>=20
>  .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.c   | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
> index d6c35e8d02a5..aceedc37e5d2 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
> @@ -295,11 +295,14 @@ bool rtl92cu_rx_query_desc(struct ieee80211_hw *hw,
>         struct rx_desc_92c *p_desc =3D (struct rx_desc_92c *)pdesc8;
>         __le32 *pdesc =3D (__le32 *)pdesc8;
>         u32 phystatus =3D get_rx_desc_phy_status(pdesc);
> +       struct ieee80211_hdr *hdr;
> +       unsigned int hdr_off;
>=20
>         stats->length =3D (u16)get_rx_desc_pkt_len(pdesc);
>         stats->rx_drvinfo_size =3D (u8)get_rx_desc_drvinfo_size(pdesc) *
>                                  RX_DRV_INFO_SIZE_UNIT;
>         stats->rx_bufshift =3D (u8)(get_rx_desc_shift(pdesc) & 0x03);
> +       hdr_off =3D stats->rx_drvinfo_size + stats->rx_bufshift;
>         stats->icv =3D (u16)get_rx_desc_icv(pdesc);
>         stats->crc =3D (u16)get_rx_desc_crc32(pdesc);
>         stats->hwerror =3D (stats->crc | stats->icv);
> @@ -316,15 +319,18 @@ bool rtl92cu_rx_query_desc(struct ieee80211_hw *hw,
>         rx_status->band =3D hw->conf.chandef.chan->band;
>         if (get_rx_desc_crc32(pdesc))
>                 rx_status->flag |=3D RX_FLAG_FAILED_FCS_CRC;
> -       if (!get_rx_desc_swdec(pdesc))
> -               rx_status->flag |=3D RX_FLAG_DECRYPTED;
>         if (get_rx_desc_bw(pdesc))
>                 rx_status->bw =3D RATE_INFO_BW_40;
>         if (get_rx_desc_rx_ht(pdesc))
>                 rx_status->encoding =3D RX_ENC_HT;
>         rx_status->flag |=3D RX_FLAG_MACTIME_START;
> -       if (stats->decrypted)
> -               rx_status->flag |=3D RX_FLAG_DECRYPTED;
> +       if (stats->decrypted &&
> +           skb->len >=3D hdr_off + sizeof(hdr->frame_control)) {
> +               hdr =3D (struct ieee80211_hdr *)(skb->data + hdr_off);

Use the same style as other:

	hdr =3D (struct ieee80211_hdr *)(skb->data + status->rx_drvinfo_size
			+ status->rx_bufshift);

> +               if (ieee80211_has_protected(hdr->frame_control) &&
> +                   !_ieee80211_is_robust_mgmt_frame(hdr))
> +                       rx_status->flag |=3D RX_FLAG_DECRYPTED;
> +       }
>         rx_status->rate_idx =3D rtlwifi_rate_mapping(hw, stats->is_ht,
>                                                    false, stats->rate);
>         rx_status->mactime =3D get_rx_desc_tsfl(pdesc);
> --
> 2.56.1

pw-bot: cr

