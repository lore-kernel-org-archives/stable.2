Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512733E49C2;
	Fri, 24 Jul 2026 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883970; cv=none; b=twlPUJPoH1D9OH6k6/ylbL0kEza4Iq40UZXsuGzw0ZG1DmBS+ANMrNBZH5EWK9c85VSG4mRfyvGWtrkrdA/2CjV86vMYZUdTnkNOE9VZd5Qpb57bRoL6pvPXfxqwMNqBSe/NH6c+eXaZwh+RFZzhr3SBoQFZpV9Wi5KCpFkGoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883970; c=relaxed/simple;
	bh=rormYFfBeNOEclTGBN37CYEEzjXL09NmrWjNXjpYRUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pIFpTCp8fdsO+GGfB/q5w+4KIm6O04JJJutP0QuiHivD0IUufRt0gTQLi79dyGLowG3xNnWoZHLDkAEUFLwaiUSw4zw8y2LSB5/nVA6fk5FogCPiqqc3SkWPGT86KuLHbwEUanCuWwknFpYwoiEmRXbuMZxIsEeuKkXZFTqt7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uVjgbuti; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uVjgbuti"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66O961vK41092277, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784883961; bh=rormYFfBeNOEclTGBN37CYEEzjXL09NmrWjNXjpYRUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uVjgbuti6OgHm5jzKAHwzpk6Wm+fKDxcl/zIcSc6WG+6KMbSsnN+vpmZ+dg+VPHVM
	 +gj3I2fZwm3+SYkIFyTnYuezykTNireWKrviPywV3DnOBnVhaUBFDyqNeFpnjNKlpD
	 B1Os9LX08z/ZESFtKch7hvJzE7xkTj1Xx6UOSs98lC24xFihKBWLpwQqDJWPFA2Jhb
	 /hRoDiyXOrwIv1NhgHEu7HWakUPTWprzIcrrUh/zrUUnCg0gC6y43nMlHJ8MoRbNVh
	 tKKvQs7TxsJXnK0fzwAQ48bCAhfLyPsFQIDl/qKZS3r3a00RIMnOvrIRaqKYYZlqjo
	 eXV/BKkNjdglg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66O961vK41092277
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Jul 2026 17:06:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 24 Jul 2026 17:06:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 24 Jul 2026 17:06:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtlwifi: rtl8192du: Fix possible memory leak in
 rtl92du_init_sw_vars()
Thread-Topic: [PATCH v2] wifi: rtlwifi: rtl8192du: Fix possible memory leak in
 rtl92du_init_sw_vars()
Thread-Index: AQHdGpjY2bN0tVV5q0KIB13q5JY93bZ8YgQA
Date: Fri, 24 Jul 2026 09:06:01 +0000
Message-ID: <f0acc4a01c7b46aba71883051eac02bb@realtek.com>
References: <20260723114539.136986-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20260723114539.136986-1-nihaal@cse.iitm.ac.in>
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

Abdun Nihaal <nihaal@cse.iitm.ac.in> wrote:
> The memory allocated inside rtl92du_init_shared_data() is not freed in
> any of the subsequent error paths in rtl92du_init_sw_vars().
> Fix that by adding a call to rtl92du_deinit_shared_data() in the error
> path.
>=20
> Fixes: b5dc8873b6ff ("wifi: rtlwifi: Add rtl8192du/sw.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


