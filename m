Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36863630A7;
	Thu,  8 Oct 2026 05:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437535; cv=none; b=q++Mr/aMF7jKcJ8SrBqeMtLOQ34fz/8DWwND6RFZ6DrHkppqLXVNWOCVyUANaPvEWv5VDDokNquP8OoyALHkvDqNDKUgGHUw0OByvCfXbzTcZ46mWINx7xI41vpph5qH/ojoWn6ucINn1UWdiIIoZ4KGLU2z4xILuMXY3KQZUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437535; c=relaxed/simple;
	bh=OfPe7P4i0pucuqGPwBG5yxgT/sGDRljDRjmY10FNEzI=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=lAH0e8AvsI+aGYrYAkb/hGaGiHcRHVFijiO+WiEWssGbJqv/EcWE0QizYw6TZygqTItfxXtGUntvwGGBums3Ja5X4Ch8/oyn9v0jpoZOnhBIUc4lNO1LYJCqavQ7j273Uj+TOsax5a/CVONfZfhcYJ3axjtWuVPUsqH7ae903OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BpptVyC3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BpptVyC3"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6985VswM6224256, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791437514; bh=8oK3AmSjQBk5Q1aVoMQlW4EuWsZphhqNlXBWecIoXcs=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=BpptVyC3F4ULz12Sfyrxxwca5c53zMaWBmx6A3uzQYOHwVUI9iSy0IoXNhxBK1I80
	 5tHpeTIU5/842qo/k/EiKlY/QRjFkFUC0NN8QAi57DaU7HKOQzYNZkH3ckvD1Zg0uf
	 T/G4qSlsxHhCLGjq59yVwhP5glf6PH4mNZnBAmnaa+BWJOnc4Nkw+H4qO3JFJDGCTj
	 Jf0kFCwp2TLg2mmN5QYh2U/VJLFzSPSRZj0GD2noqwybnUI09cL2j2frFGExqEnp6R
	 bByD3zqJw8xWsc/l4B2/37xY23G4ycrOukxGu20U2qhEiGpbh1KLPP1hp8y4qqiKX/
	 p3deZW26zKHxg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6985VswM6224256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 13:31:54 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 13:31:54 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 13:31:53 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 13:31:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Tristan Madani <tristmd@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
CC: Kalle Valo <kvalo@kernel.org>, Po-Hao Huang <phhuang@realtek.com>,
	Chin-Yen Lee <timlee@realtek.com>, <linux-wireless@vger.kernel.org>,
	<stable@vger.kernel.org>, Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH wireless v2 2/2] wifi: rtw89: fix IE length passed to cfg80211_find_ie() in WoW AKM
In-Reply-To: <20261007161721.261452-3-tristmd@gmail.com>
References: <20261007161721.261452-1-tristmd@gmail.com> <20261007161721.261452-3-tristmd@gmail.com>
Message-ID: <c67176c8-24a6-40dc-a39a-09441ec017d2@RTKEXHMBS05.realtek.com.tw>
Date: Thu, 8 Oct 2026 13:31:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tristan Madani <tristmd@gmail.com> wrote:

> From: Tristan Madani <tristan@talencesecurity.com>
> 
> __rtw89_wow_parse_akm() computes a pointer to the IE area from an
> association request frame:
> 
>     ies = mgmt->u.assoc_req.variable;
> 
> but then passes skb->len as the IE data length to cfg80211_find_ie().
> Since skb->len covers the entire frame including the 28-byte management
> header and fixed fields, cfg80211_find_ie() may read past the end of the
> actual IE data.
> 
> Fix by computing the correct IE data length as skb->len minus the
> header offset, and validating the minimum frame length before parsing.
> 
> Fixes: 480dd4dddfc5 ("wifi: rtw89: enter power save mode aggressively")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

6c17c57d45ef wifi: rtw89: fix IE length passed to cfg80211_find_ie() in WoW AKM

---
https://github.com/pkshih/rtw.git

