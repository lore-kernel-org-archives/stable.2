Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795414483;
	b=eh0ZugAPrNIBBtG4BezZqPjczh55GNdUEsRMwM6f4evcfM0CLkBPZT6B4nty8n71t8xb
	 hlUGjT4hGuQxI/YkFj/x0k/Mpaxu6KZHCWrJ+oP+8sy88am3hn9K9zamAqeXrEg8sWW8p
	 tFR8ojJI6nrkTmJH7HmykZHfh/+oFaugTu++JEh5wE8e3/lqwlo/yos7ntvHdsWpaz8t+
	 JK8N+i/4JaF0rFFscacmxnrJv4mH3MOhZspGv+tj+TBhXd0YsDDPoAuWdx1wkjzdQKEF9
	 gkgWBL/IaJqkBpHsrs9ckfAEVGrd9OptZQIEr8LTODUgC1wYEVGF8z+E9EDQKvPYfaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795414483;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=R7Axc5ola9l+8N6tU2oZkcxPPMMFI/z1vAo/IUT6BSg=;
	b=ow/uz+SxdvUXJMd9tMWyL/LAZVUJlcswNVgU1krs1R6JEDJ3duyNGlnpubXzTQhkCZPJ
	 S+miSeVJdaobNyyyHQMEfbeO3FWx2PQLEcX+hDmIKd6D4boKvL5nHEumj0okXD8PFfxR1
	 OPSWZ1ChdJCQ5Lzq66DfPB2U4ouIOw2IiOjlNBXc5joGvhXXBwUWAf3ehVjg/S9b4yxAA
	 YHOj964ZNoP9Ui76bF2TjsoFADVdnZc9DPWPEZbp+3k1JJpoD4Z5g6sfClJVTrDkH4TAK
	 R0m8X2BuiX/oACtU3gEJGMC172+47uTnwu+ZhFdmbLw1d1pGhLiZ/ff8QgMg/5f/NfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=aw8bawu8;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE120606A31A;
	Mon, 23 Nov 2026 06:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE120606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=aw8bawu8
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AN6EcBK21406257, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1795414478; bh=R7Axc5ola9l+8N6tU2oZkcxPPMMFI/z1vAo/IUT6BSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=aw8bawu8YlB31YOXMbH5NW4/kOcv9yU06J5/VQusbzMXeqTUqzWmQ9pmb67PrSnLb
	 WGNBnMyO6tGEjeocKJlAWx9qqE6Uj/tkUTvCKr8NezFDTtyUcNoyFXQuGmZTzj9CfO
	 2Oa+DNLrVap+iiUvfBtR7a/sOns5InlxiFGiUA9AeOIYYSkFq0kQiyZrXm8JVZoeOP
	 FcWqkuE+9jYpW7fl0d4XXprNoDuSyL2mC5vbny37ebW7p9ry2217dP6RRGx6IlbOsC
	 F79ZV6LADKd83DgMnDBNzKZnmAmbj8Ig7WHTUwCXu7K44yDsNA7InUKynbuJqygA7L
	 uAnQCAEHbGsKQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AN6EcBK21406257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Nov 2026 14:14:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 14:14:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 14:14:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef%10]) with mapi id
 15.02.2562.056; Mon, 23 Nov 2026 14:14:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zhao Li <enderaoelyther@gmail.com>
CC: Hemanth Selam <hemanth.selam@gmail.com>, Morning Star
	<alexbestoso@gmail.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/3] wifi: rtlwifi: rtl8192ce: don't mark
 unencrypted frames as decrypted
Thread-Topic: [PATCH rtw-next 1/3] wifi: rtlwifi: rtl8192ce: don't mark
 unencrypted frames as decrypted
Thread-Index: AQHdedZ1DDnSjpqyuE+VBINjK718ALc7KUpg
Date: Mon, 23 Nov 2026 06:14:37 +0000
Message-ID: <ee07e9227ef54a6ca5520f7bd80c0f95@realtek.com>
References: <20261121163547.37019-1-enderaoelyther@gmail.com>
 <20261121163547.37019-2-enderaoelyther@gmail.com>
In-Reply-To: <20261121163547.37019-2-enderaoelyther@gmail.com>
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
> encrypted. rtl92ce_rx_query_desc() nevertheless sets RX_FLAG_DECRYPTED
> for every frame with SWDEC clear except a protected robust management
> frame, including unprotected data and management frames.

This is what the comment says, but you are going to remove.

>=20
> mac80211 then accepts an unprotected unicast data frame although a
> pairwise key is installed, because ieee80211_drop_unencrypted() passes
> frames marked as decrypted, and it accepts unprotected deauthentication
> and disassociation frames on a connection that uses management frame
> protection. A station in radio range can therefore inject plaintext
> data into an encrypted connection, or end a protected one, by spoofing
> the peer's address.

For data frame, will hardware fail to do decryption and flag sw dec?

>=20
> Set the flag only for a protected frame that is not a robust management
> frame, as the rtl8188ee, rtl8192ee, rtl8723ae, rtl8723be and rtl8821ae
> drivers do.=20

I think the purpose of this patch is to align the behavior of all chips,
right?

Maybe, we can just move the chunk setting RX_FLAG_DECRYPTED into an=20
inline function, and all chips call it.

The commit subject/message can be simple that=20
"Unify the setting of RX_FLAG_DECRYPTED".=20

> rtw88 dropped the same assumption in commit 0649ff58a0f6
> ("rtw88: Don't set RX_FLAG_DECRYPTED if packet has no encryption").

The commit is to add missed ENC type, but 8192ce doesn't have the field, no=
?

>=20
> Found by code review. Compile-tested with W=3D1.
>=20
> Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
> ---
> No new W=3D1, sparse or smatch warnings.
>=20
> 834fc28d7880 (7.4-rc1) fixed "managment" in the comment this patch remove=
s;
> with the old spelling in the removed lines it applies to 5.10.y through 7=
.3.y.
>=20
> AI assistance was used.
>=20
>  .../wireless/realtek/rtlwifi/rtl8192ce/trx.c    | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
> index 99472053ccff..3d11ddf86136 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
> @@ -300,20 +300,13 @@ bool rtl92ce_rx_query_desc(struct ieee80211_hw *hw,
>=20
>         rx_status->flag |=3D RX_FLAG_MACTIME_START;
>=20
> -       /* hw will set stats->decrypted true, if it finds the
> -        * frame is open data frame or mgmt frame.
> -        * So hw will not decryption robust management frame
> -        * for IEEE80211w but still set status->decrypted
> -        * true, so here we should set it back to undecrypted
> -        * for IEEE80211w frame, and mac80211 sw will help
> -        * to decrypt it
> -        */
> +       /* SWDEC is clear for plaintext too; mac80211 decrypts robust mgm=
t */
>         if (stats->decrypted) {
> -               if ((_ieee80211_is_robust_mgmt_frame(hdr)) &&
> -                   (ieee80211_has_protected(hdr->frame_control)))
> -                       rx_status->flag &=3D ~RX_FLAG_DECRYPTED;
> -               else
> +               if (ieee80211_has_protected(hdr->frame_control) &&
> +                   !_ieee80211_is_robust_mgmt_frame(hdr))
>                         rx_status->flag |=3D RX_FLAG_DECRYPTED;
> +               else
> +                       rx_status->flag &=3D ~RX_FLAG_DECRYPTED;
>         }


The subject "wifi: rtlwifi: rtl8192ce: don't mark unencrypted frames as dec=
rypted"=20
isn't clear to me. Which one is 'unencrypted'? and which one is 'decrypted'=
 ?

>         /* rate_idx: index of data rate into band's
>          * supported rates or MCS index if HT rates
> --
> 2.56.1

