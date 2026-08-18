Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5491A6814;
	Tue, 18 Aug 2026 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787012693; cv=none; b=aHidWLZnK54E+QyZcZkvpZAcS0dwZ31PWrJhZc/+c4jumOrLwQT2YWee5Q0gBzXF9FXd7qzb6H9I+ezjp9e9riDQGCk6YoGV6llMJMTMrK+1DxNeKLoRZ3OLucN3N4E/+hu4l/FlaBxKyZsl36MhKeIK+pDFYxez/kQN2DILuTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787012693; c=relaxed/simple;
	bh=NSMe+Euo2Q15ZCXr7745shQH9/CnkMK8aiFG9BVKj+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tyOHgczBqFypXJSuTOF59CUbYZMeJmkaMzz1MXQcOdmT1UR/6zyCA7flUvWJb1Zh++sMpq2HituKBPRh1CSo0g4sIbgg36+P5AmMCqdE+6dX8MQVyHNQ8t5bXnvXeGZML1G/zvaLj1SZu0TMDwkCEA0XwDGVACUtto+IoXDcg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=C7d0Z02P; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="C7d0Z02P"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67I0OVQD0312316, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1787012671; bh=NSMe+Euo2Q15ZCXr7745shQH9/CnkMK8aiFG9BVKj+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=C7d0Z02PbB9bO+gFnTECpYxPVt9mBc6mRESxi4OVvPPsbkWui4Z6SpN7Wpw1l93TP
	 iQPUsF9MrWAl4GwNRbaF0oHcOVWi4LZeczNQAm7tyMxxGXDC9G4jWhxNlQsPS3DT90
	 3h94+os8AqMOmlYF1sYAlK7SkeQAKwfCM1VCPIYtsmpKD3ttz5whze9TjWEKUcZ6th
	 /ekhUCMV518SV7ezCjK+MK853Iu+IYTaz1ZL4V6MDMG3m1wjU20DMeiH6bvNth1hJL
	 SeZAU/+/A0bMtLOXug2svm1e1aY2OqoV0ZObUG3ZaKnhhQh51njPdovPCjSgmEkdY4
	 uwWWDCPNj/OwQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67I0OVQD0312316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Aug 2026 08:24:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 18 Aug 2026 08:24:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Tue, 18 Aug 2026 08:24:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Linkai Gong <gonglinkai@kylinos.cn>
CC: Damon Chen <damon.chen@realtek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: debug: fix off-by-one in rtw89_ppdu_str()
Thread-Topic: [PATCH] wifi: rtw89: debug: fix off-by-one in rtw89_ppdu_str()
Thread-Index: AQHdLhPZwDTxnFam8kGBHEygeVbTEbai81ew
Date: Tue, 18 Aug 2026 00:24:31 +0000
Message-ID: <2fb8ce3162b04686b4d64b09ff64d2d2@realtek.com>
References: <20260817064140.511320-1-gonglinkai@kylinos.cn>
In-Reply-To: <20260817064140.511320-1-gonglinkai@kylinos.cn>
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

Linkai Gong <gonglinkai@kylinos.cn> wrote:
> rtw89_ppdu_str() uses type > ARRAY_SIZE(), so type =3D=3D ARRAY_SIZE() st=
ill
> indexes one past rtw89_ppdu_infos[]. Compare with >=3D, like
> rtw89_txcmd_str().
>=20
> Fixes: 419ed7f4a053 ("wifi: rtw89: debug: extend bb_info with TX status a=
nd PER")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

The same patch [1] was applied.=20

[1] https://lore.kernel.org/linux-wireless/aia25i0ds3B6QF6c@stanley.mountai=
n/#t


