Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0822F31A813;
	Wed, 17 Jun 2026 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685248; cv=none; b=EKDcHj8Wo7+EGa7MTlIpEoKqH0Phxf0ra3hXSdWuyCrbhhmS72hLrRBc0PIMBweEy/ZyQWO+Hupu5z4ey575aOXTotpj5Q/AH1Z0uzjfJL5dDKgnyiTGyHPmFahVKbcd2dAJXA10h3DNFpYDsFl4GV/LPhhyxvOgsUwSPuXRFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685248; c=relaxed/simple;
	bh=VNCbHQg5Qrsnj35x6teMZJAQNOJ6kX8DZ7xM+8qBSMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NGaQQX5udx1r/stTM7Dvj4fitLMOtoEgAcMoFC+pS6QUnjQb3XGG6pNqKFLhFxEiXixaaYx7/E40CzNayuBjNQZNuE6KyNTqBz34OiO6bx9+i4giU4XwVSDP43dJ0YCgTW3qZC8ghvoi0mv7zYggOZxUWdncprrRKuPzYPIZGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=m9rCVOj2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="m9rCVOj2"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65H8XhIO22587399, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781685223; bh=VNCbHQg5Qrsnj35x6teMZJAQNOJ6kX8DZ7xM+8qBSMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=m9rCVOj2aK0OxqJGQZ8kTOgQcHykEGWVzxgzsqejYrO31SS+mOHMjZfnOZc7VnzOP
	 hzKO9wSJ++HtwVO+Pv0q9ITbbtzhtv98oEA7wC+lAqZqx9JWoTk55JyBfkLok3lx3g
	 z2sV9iCQVslTdyvqOoLl5MkCaDZrLhz0n/ugo9CD/Hc9O9UwMrSax96i1G/zjbWCgS
	 3wIPNtCRh3HMUCJW+ReVE99IsyY6DBeQWNd1mqfxGHhw2kWArbvtb6irT4qDjOtWVf
	 vqykbJdmfQpezIka02O54fM+cEQUxBZeW0VZV1TTsffJv027atUq1ylAUE4FbfcB/Q
	 ivqbTNhB5JmrA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65H8XhIO22587399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jun 2026 16:33:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Jun 2026 16:33:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Jun 2026 16:33:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Wed, 17 Jun 2026 16:33:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dawei Feng <dawei.feng@seu.edu.cn>
CC: "leitao@debian.org" <leitao@debian.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jianhao.xu@seu.edu.cn"
	<jianhao.xu@seu.edu.cn>, "zilin@seu.edu.cn" <zilin@seu.edu.cn>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH wireless] wifi: rtw88: pci: fix resource leak on failed
 NAPI setup
Thread-Topic: [PATCH wireless] wifi: rtw88: pci: fix resource leak on failed
 NAPI setup
Thread-Index: AQHc/fmIAcGrEcSAmkm2jiCazgmzlLZCa/QQ
Date: Wed, 17 Jun 2026 08:33:43 +0000
Message-ID: <459e4dfeb2f048c3bff97028d8c1f3a2@realtek.com>
References: <20260617013502.114057-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260617013502.114057-1-dawei.feng@seu.edu.cn>
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

Dawei Feng <dawei.feng@seu.edu.cn> wrote:
> rtw_pci_probe() allocates PCI resources through
> rtw_pci_setup_resource() before it sets up NAPI. If
> rtw_pci_napi_init() fails, the error path jumps straight to
> err_pci_declaim and skips rtw_pci_destroy(), leaving the PCI
> resources allocated by rtw_pci_setup_resource() behind.
>=20
> Add a dedicated cleanup label for the NAPI setup failure path so probe
> destroys the PCI resources.
>=20
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing current
> mainline kernels. The tool is still under development and is not yet
> publicly available. Manual inspection confirms that the bug is still
> present in v7.1-rc7.
>=20
> An x86_64 allyesconfig build showed no new warnings. As we do not have a
> suitable rtw88 PCI board to test with, no runtime testing was able to be
> performed.
>=20
> Fixes: d0bcb10e7b94 ("wifi: rtw88: Un-embed dummy device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


