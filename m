Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792461549;
	b=FGL9bn1DyDbHtzciYpeJtDGhXtqWQJc1rYd+vNd2g133mEYkOANxr/CDO9K8tSvICe5C
	 SY4RYbGtO5O1x2nBbn13tD0yQNsEl7gC2p2VBjZ2I8B8TtdB9Ietkd/F0F0ROqnm3UBb+
	 Yxhj0nYoNxv+TD5WJ6bO/t7pq+ONzz1sBRJh4cSNy0wxavrWG1wVqMrUKOl525+NhdAyU
	 ZAwnArA2BiUICquCqeNnp7U4DGkU3VWhH2Hbxo2teapItW9kVWdUmlkR2V06Qw6oPQYqs
	 q+AYnRyP6hx3PCI+tHpIvpQDZ/ddbdtNxUAP+A0/+w/IUaUmV/OygNRgI6WMj13SdmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461549;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=pe7sgYfFN7Lv2bDurW0e99p0vNrWClqpL0btm8VcimI=;
	b=PYuGi7fSt+fSLaPZgYx//152HUNFCPwcJ5z02WRtwketZpYZ6TaWx3vgU4QwuWpJnPUQ
	 3qrln5bIivqgwiOc8TodVcS/1UewgdI90d0GaDu0uU/O+N40eqkm0U/qqcYmjRGMZ/7Lg
	 oIoyUiu8YGRqHvl3uab/9vqOiZyxoGQ8wSjJhjyy5KzIKEGeBiQ9SH5HRoerm3AdE8sRH
	 s3zvoXJFFabl0UIBZ3FL10TkuNllppIYboDCESBVpTgo0xOZyBefMjeT/rmXQcudK5KsI
	 6/j203QPq4k03JzQcXNgaBUHXlfFORaEtPAv0WThhXI5NndEpAfTE6Fue38s+0x1xxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b="b/06GJCL";
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C6A606A319;
	Tue, 20 Oct 2026 01:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98C6A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=b/06GJCL
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69K1wwsQ72561327, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1792461538; bh=pe7sgYfFN7Lv2bDurW0e99p0vNrWClqpL0btm8VcimI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=b/06GJCLFsPDHMQZNDrPAgcR7YP8StoXyTzDPC4WPlHy0WHxYmHTDXXjYgOv+SOXv
	 e84g+ThUIP9yOhR9oES16KVEH6XejvsdVaR0/K3T1k8hyDFEILghSWuTClwd6TcpMa
	 jq28jEcbgWQ4XuIxiNKkXZZyf0hBkuF4G0a6kR66IZ9scXn9xh8LuJDsw1M5HKI6r4
	 eWGtjc1wiCgcMtKbbh3kBigCQL/q/34+zJZU9bpVADgBULDF2b8C2f2q1sQ9iRvinM
	 SPoaSw0ENruP19c3oX1vOXQeqMWp3J3nipTGvocUmbgQOugyWCrZ2DUQvdd70wiI0R
	 OafCExPzmPKJw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69K1wwsQ72561327
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2026 09:58:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:58:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:58:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Tue, 20 Oct 2026 09:58:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Devin Wittmayer <lucid_duck@justthetip.ca>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2] wifi: rtw89: debug: return the error when a
 read handler fails
Thread-Topic: [PATCH rtw-next v2] wifi: rtw89: debug: return the error when a
 read handler fails
Thread-Index: AQHdX+t9KHlH1DXKjEG6aExqhn47/LcFrSzg
Date: Tue, 20 Oct 2026 01:58:57 +0000
Message-ID: <f1fa8aedc86d4c5db53e48eb5eee24c7@realtek.com>
References: <20261019170120.726156-1-lucid_duck@justthetip.ca>
In-Reply-To: <20261019170120.726156-1-lucid_duck@justthetip.ca>
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

Devin Wittmayer <lucid_duck@justthetip.ca> wrote:
> Return the error when a read handler fails, instead of passing it to the
> copy to userspace as a length:
>=20
>   rtw89_8852bu 2-1:1.0: invalid read reg len 0
>   usercopy: Kernel memory exposure attempt detected from SLUB object 'kma=
lloc-8k' (offset 56, size
> 262144)!
>   kernel BUG at mm/usercopy.c:102!
>=20
> Fixes: 831cceed3baf ("wifi: rtw89: debugfs: implement file_ops::read/writ=
e to replace seq_file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


