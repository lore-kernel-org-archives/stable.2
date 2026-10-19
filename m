Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1D9351C11;
	Mon, 19 Oct 2026 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376499; cv=none; b=r/l+X8gUnhPNgq4tamgDROZxZSqA958cJx2Qm01zSV+TMzji44iA1PBtxNkrmazbWGqHWPvZ8hTnfuFzjOqAIjl2k8JZpS5rYfZZX10JmfH3Ms9OBr76Co4ExxhSbeHFwK85ZvFDTXZeLS4vgx79uVegZ1sowG3uaQUuggh4nYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376499; c=relaxed/simple;
	bh=qM23NXe51pkF2WTvGtn9Kb/ivffMwC9wxINYUQBpk14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VNEgcMk4faPzJq1DvY9xU8JPHXPV7ZJKrQul6+HfovomUpUPXlKxc9cL2SNAgbDfnAfZTb8zNC2I8wmG4pkHy53CrGnk+b6ziaYP0HiMT/IFDSg0fB5Xz6+riS1d8+SnYZwzEvQe22MV4LsGE1U3/jVcmLfL9BU06Urgk+d54qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lnLXuLvj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lnLXuLvj"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69J2LKVM01478123, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1792376480; bh=69ccR7OQ1b2EAG78Ki8USmwFMUSNqOgExcx3FVhsjG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=lnLXuLvj61AlJuadBs6L9f3Rw5KHq4Djmx4+Bei6qi4Z67VAhY1EDqy/gpNLlgyFG
	 So247SBlEEaxFnmb/8IykIiL9OIUrM4FGBx1Y96Vc2fSEm21Mx2Qwew7LN79W76dbj
	 6i6d5BdWJGyvwpDIlNkWfvAVXnk4WdhZQuNl4JvrVYjTD+SSE+gTRDOhYYbkABJd/l
	 LmBV42DT0b+7hyeSVZAO2Fn8+QPJREQQNIwAgj3BM7PEl2FdzdFLov1UB/ZapPqnlY
	 ShI0MREKMpq70RdKsW2vGTxaaeuPhX6wwKNvhkspGKYx8VIEN12GanxdV4KEnZR9Ir
	 o7OLBNXr9V45w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69J2LKVM01478123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Oct 2026 10:21:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 10:21:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Mon, 19 Oct 2026 10:21:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Bin Yu <byu@xidian.edu.cn>, Cheng Wen
	<wencheng@xidian.edu.cn>
Subject: RE: [PATCH] wifi: rtw88: usb: drop RX frames received before the
 device is started
Thread-Topic: [PATCH] wifi: rtw88: usb: drop RX frames received before the
 device is started
Thread-Index: AQHdXYqaFNBB0XT0c0qyULo7ZayUBrcEIK9g
Date: Mon, 19 Oct 2026 02:21:20 +0000
Message-ID: <69c2ba63fab645e6bc8df5af65bbb2bb@realtek.com>
References: <20261016161931.18495-1-25031212351@stu.xidian.edu.cn>
In-Reply-To: <20261016161931.18495-1-25031212351@stu.xidian.edu.cn>
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

YuanZhe Liu <25031212351@stu.xidian.edu.cn> wrote:
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wirel=
ess/realtek/rtw88/usb.c
> index 64e1c3420e0a..12fb669015d1 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -664,7 +664,7 @@ static void rtw_usb_rx_handler(struct work_struct *wo=
rk)
>=20
>                         if (pkt_stat.is_c2h) {
>                                 rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_off=
set, skb);
> -                       } else {
> +                       } else if (test_bit(RTW_FLAG_RUNNING, rtwdev->fla=
gs)) {

Patch content is fine to me, but I prefer the style:

if (is_c2h) {
        ...
} else {
        if (!test_bit(RTW_FLAG_RUNNING, rtwdev->flags)) {
                dev_kfree_skb_any(skb);
                goto skip_packet;
        }

        ...
}

No need additional comment for it.

>                                 skb_pull(skb, pkt_offset);
>                                 rtw_update_rx_freq_for_invalid(rtwdev, sk=
b,
>                                                                &rx_status=
,
> @@ -672,6 +672,14 @@ static void rtw_usb_rx_handler(struct work_struct *w=
ork)
>                                 rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
>                                 memcpy(skb->cb, &rx_status, sizeof(rx_sta=
tus));
>                                 ieee80211_rx_irqsafe(rtwdev->hw, skb);
> +                       } else {
> +                               /*
> +                                * RX URBs are submitted at the end of pr=
obe,
> +                                * so frames can arrive before the device=
 has
> +                                * been started. mac80211 does not accept
> +                                * frames in that state, so drop them her=
e.
> +                                */
> +                               dev_kfree_skb_any(skb);
>                         }
>=20
>  skip_packet:
> --
> 2.34.1
>=20

