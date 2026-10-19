Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615444C4EB;
	Mon, 19 Oct 2026 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389149; cv=none; b=lcOINUOSw0nLMFvWGxcvLMI4uvISCQ4rIjXr6GgGqCY5RMUjJkvPteTkG101W/Q6JMhrElphKFppHnIT/O59qU5lIRko8uYCBgXuqDLf/Kpm4FIyhm1NvoBjDKyfTg1riB4hib528YipiVGetEQM/lX1xPhX7kUg6/ECsCvOFWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389149; c=relaxed/simple;
	bh=FMuE+08PAY11vz15RnOyuBKikfbMyXEH2/mTXI9oJgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jLvClKOt/uXT5H30RF2aw0qahdzq5kYLnstH995/CQ1MOvXgNy/k9V4cRRJi3DcSDVS4A7kFofNwpqwcSwT8gR+gimFjmIFUAo9jtqhytRTZyBn2SBriRXnhYKhp4z8ml5JO7/sYctF4UIZjRRqTCWOWm82erpo9yuQiP/dIQjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vYK3KrUc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vYK3KrUc"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69J5nxFoB1609801, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1792388999; bh=i0Wip9nnS2iGYKJZUzjTjJYuEAbf6heF5ftt7mc8AOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vYK3KrUcpCFQdsVXD2x4vS41KCUDYBYmIEoX6oMNof+G72MYqWaQrx3dV6uvCF7WG
	 OysEWavpb1ZmzI/1gcXOurrJMSASBzE5FM/KAdGJs/TRD5ys4MrSh792/ur1zqg8x+
	 nuXcqebiLnLokqAzMP6DD+xC/K9dzWPXFOCTANkoxmzoXb//13/oKTfsdCynfWEdah
	 bzjpZQ4a+gnmyjlv9Z79QRKxVIpyUSoZY9udRzZUc6ZFsSjk3dWO/WVubjAR7jGuP3
	 BNY/DJiGlz7+VH4ChaU4vXx5d44j9nADCD6ZXcCbMQpdb0ONVBBN/AsnUM3VqLMRsn
	 uV7vT0BhIMpjQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69J5nxFoB1609801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Oct 2026 13:49:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 13:49:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 13:49:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Mon, 19 Oct 2026 13:49:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Devin Wittmayer <lucid_duck@justthetip.ca>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw89: debug: return the error when a read
 handler fails
Thread-Topic: [PATCH rtw-next] wifi: rtw89: debug: return the error when a
 read handler fails
Thread-Index: AQHdXNCstrHtmqrT4UeeOjgjVHhW/LcEYFHA
Date: Mon, 19 Oct 2026 05:49:59 +0000
Message-ID: <80c16afc7ae94713a01e625491ab64a0@realtek.com>
References: <20261015181150.13483-1-lucid_duck@justthetip.ca>
In-Reply-To: <20261015181150.13483-1-lucid_duck@justthetip.ca>
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

Devin Wittmayer <lucid_duck@justthetip.ca> wrote:
> I hit this while testing an RTL8922AU patch. Reading read_reg in debugfs
> before choosing a register set off a kernel BUG that killed the reader.
> It does the same every time on an RTL8852BU:
>=20
>   rtw89_8852bu 2-1:1.0: invalid read reg len 0
>   usercopy: Kernel memory exposure attempt detected from SLUB object 'kma=
lloc-8k' (offset 56, size
> 262144)!
>   kernel BUG at mm/usercopy.c:102!

The change of code is fine, but please reword commit message.=20
I think only need this kernel log, and single sentence like
subject says. For others, you can put them after your s-o-b
following --- delimiter.=20

>=20
> After that the driver cannot be unloaded, and on my test box network
> configuration hung until a power cycle. Without hardened usercopy the
> reads return kernel memory instead, and cat kept reading until I
> stopped it.
>=20
> The read path passes the handler's error to the copy as a length, and
> saves it for reads at a later offset. Return the error before the copy.
>=20
>   RTL8852BU over USB                 before    after
>   read_reg, nothing chosen
>     6.18.52                          BUG       -EINVAL
>     7.2.6                            BUG       -EINVAL
>     6.18.52, hardened usercopy off   256 KB    -EINVAL
>   mac_mem_dump at offset 1,
>   after a failed read
>     6.18.52                          BUG       -ENOENT
>     7.2.6                            BUG       -ENOENT
>     6.18.52, hardened usercopy off   256 KB    -ENOENT
>=20
>   RTL8922AU over USB                 before    after
>   read_reg, nothing chosen
>     7.2.6                            BUG       -EINVAL
>   mac_mem_dump at offset 1,
>   after a failed read
>     7.2.6                            BUG       -ENOENT
>=20
> Fixes: 831cceed3baf ("wifi: rtw89: debugfs: implement file_ops::read/writ=
e to replace seq_file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---

(I mean here.)

> ---
>  drivers/net/wireless/realtek/rtw89/debug.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/debug.c
> b/drivers/net/wireless/realtek/rtw89/debug.c
> index 3a430bd08..3b7f8a809 100644
> --- a/drivers/net/wireless/realtek/rtw89/debug.c
> +++ b/drivers/net/wireless/realtek/rtw89/debug.c
> @@ -185,6 +185,9 @@ static ssize_t rtw89_debugfs_file_read(struct file *f=
ile, char __user *userbuf,
>         debugfs_priv->rused =3D n;
>=20
>  out:
> +       if (n < 0)
> +               return n;
> +
>         return simple_read_from_buffer(userbuf, count, ppos, buf, n);
>  }
>=20
> --
> 2.56.0

