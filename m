Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D0223328;
	Mon, 12 Oct 2026 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770008; cv=none; b=d9dykEzboRf6VDDv5vOR6CeFkVoX+PNza4X/ysElEONhQNf/lZwJUi2DO4dcEjNDASMyT+gjMJlKrerXEvk/1W6oDJRsHIY38tGhrJqxpOppzypY756QyrKrNncvH/SiXbq9uqdXwCnoWGnOtfOWc4jFJtDsdMChyNyzLq9BE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770008; c=relaxed/simple;
	bh=88qBKFRmN+J2glhgecKoSAo54isz19C5mLMHIAOQ8BM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bs81hrfhhKwDrDFTBrzp/rBuOOU9/m/U+0Y+o/4H0c+qo9kQs5yqxZuofE1TNGTX3p/OWku2vVYEHSlgavGQF4VrDXBkh4i2V5xyb9RS+Qp1vCe9WRzbgVHvEC7W6VJr9DLsuvjuK0dgVfaQ7WeEteO+g/YxIajjOozZ7UBYRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MESWXVso; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MESWXVso"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69C1rAAq93435225, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791769990; bh=pE4G9iwyn4AdNkXvPYBVLDo8PLOmS8Y7MMPhLG5kK/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MESWXVsolcI5OkmV1ZJLbwoCqbwA7YYLPFUhMqZgZrfzrLkNYxivFIu1y9ufmFQMO
	 XFnGk17aWlN0pll5DohD38nOMh6TzCa/YeLB8TNxFUhmf5f7K6ty4+btOT+v7TRoN5
	 z1DQx0oxeYhNiivbhuM5BZIEpc0Wb+pClY6/E6fFxkx/O/3dPxJYk8xahs6iPiDEpG
	 QxnZaDeRs5c1o89EAgv9f73AGzVZJuAwJTTGtUi7ovQt8pal3NMr6GyG++zHDt+jE4
	 DqTT+45pPzJDw4TadnsfrCx2plAHMC8hBR+gaoMhI7sGJuuwOltD6R1ki4HuK9K/af
	 Dhkytb3xCt2EA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69C1rAAq93435225
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Oct 2026 09:53:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 09:53:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Mon, 12 Oct 2026 09:53:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Luka Gejak <luka.gejak@linux.dev>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ulf Hansson
	<ulfh@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Kalle Valo
	<kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: sdio: reject oversized RX packets
Thread-Topic: [PATCH rtw-next] wifi: rtw88: sdio: reject oversized RX packets
Thread-Index: AQHdV+oFzdPCoTpk60GGBadLGCjSGrb5Jf/w
Date: Mon, 12 Oct 2026 01:53:17 +0000
Message-ID: <13bac899a2ea49d28dcbd4a8c765f3ca@realtek.com>
References: <20261009123022.87787-1-luka.gejak@linux.dev>
In-Reply-To: <20261009123022.87787-1-luka.gejak@linux.dev>
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

Luka Gejak <luka.gejak@linux.dev> wrote:
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -1389,6 +1389,14 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *r=
twdev, u32 rx_len)
>                 curr_pkt_len =3D ALIGN(pkt_offset + pkt_stat.pkt_len,
>                                      RTW_SDIO_DATA_PTR_ALIGN);
>=20
> +               if (unlikely(pkt_offset + pkt_stat.pkt_len > rx_len)) {

Can you use real hardware to test this patch to see if there is actual case
falling into this branch? (see below)

> +                       rtw_dbg(rtwdev, RTW_DBG_SDIO,
> +                               "oversized RX packet: %u, %u bytes left\n=
",
> +                               pkt_offset + pkt_stat.pkt_len, rx_len);
> +                       dev_kfree_skb_any(skb);
> +                       return;
> +               }
> +
>                 if ((curr_pkt_len + pkt_desc_sz) >=3D rx_len) {

Because I wonder if this condition is right? In my perspective, the
curr_pkt_len =3D pkt_offset          + pkt_stat.pkt_len + align_bytes
             =3D pkt_desc_sz + ...   + pkt_stat.pkt_len + align_bytes

Why does the if-condition plus pkt_desc_sz twice and compare with rx_len?

However, it should enter to handle/free the last aggregated packet.=20
Can you enlighten me how it looks like that?

>                         /* Use the original skb (with it's adjusted offse=
t)
>                          * when processing the last (or even the only) en=
try to
> --
> 2.55.0

