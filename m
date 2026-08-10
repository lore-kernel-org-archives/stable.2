Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA87264A97;
	Mon, 10 Aug 2026 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786332700; cv=none; b=H3viaJ9fNtos5J8TKCHxj+Rkud7VzEqTeW39WCjLQFNCOWSQTw54mLY3sxDWYbWtaeD1fh2noHucNXuBdzVjezU06KlxiK+83NW8sx0ukDpU6A99pYDy7PFmGCwD6Dg4T5KVLQ336RWK5XwMV8IDPeJXGhCN66GzqIJGYjj0luY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786332700; c=relaxed/simple;
	bh=VJ0W3NbOGXkE8YnAcwkyQhYOT9DregWDwHGKhIuPXOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h+YaiP4MnS2pdjdF2wHixjBbO6FiX/r/ZOQUIT6+p+AOQj1ZPczUHNq7rAKaERPxZ+NoxP4ZcIHYJeqr0mavEUP1/J1g9VNNz9RStTIYaf5U5CrX7OFTqu8HLbik84uVQzgnDya4zdNan15DGjAGAtJYnBhwW0XFjPImjv8wai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uV0rXg5w; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uV0rXg5w"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67A3UnoaE1428619, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1786332649; bh=VJ0W3NbOGXkE8YnAcwkyQhYOT9DregWDwHGKhIuPXOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uV0rXg5wU7GwcWO13JgzvThI2yvhi+BMM/NCJL9Cz3qBvcVbeczbwcC06d3vrwG2A
	 mWywU+1KU5ib1GAGf3bv5jgQLu1dKIK2YwvwkbDerof0wRuQ2af50pd4Vu3uIuJpRr
	 dLNNS7dZ/9XHtv/zcymY5UkLFtG3xHyi2z9EPxbg9WFo8O7XBM7SorbHcEQVtZjFcb
	 /ABUKa5hrqlUq3jCtWVf9LLhAsk5m6KwzzvuGtGMjtYH10dSjHbnE0dE7WgmZPKEVF
	 nNhjxA9DcQTMi6I8uT9r5ynhjeKBNzFQi53iGqtZ+SjM3mhFaWWSlBn1XNCGfdmPHa
	 JB/qBEV+ydKPA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67A3UnoaE1428619
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Aug 2026 11:30:49 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 10 Aug 2026 11:30:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 10 Aug 2026 11:30:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Mon, 10 Aug 2026 11:30:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yi Cong <cong.yi@linux.dev>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yi Cong <yicong@kylinos.cn>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: 8851b: fix swapped DPK channel/bandwidth
 backup fields
Thread-Topic: [PATCH] wifi: rtw89: 8851b: fix swapped DPK channel/bandwidth
 backup fields
Thread-Index: AQHdJkRSWUHVLmCbxUW7tYFW8tsHO7aWpFxg
Date: Mon, 10 Aug 2026 03:30:49 +0000
Message-ID: <2405c4f068ed4b81a1718c2ced58b0bf@realtek.com>
References: <20260807081006.240450-1-cong.yi@linux.dev>
In-Reply-To: <20260807081006.240450-1-cong.yi@linux.dev>
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

Yi Cong <cong.yi@linux.dev> wrote:
> From: Yi Cong <yicong@kylinos.cn>
>=20
> The .ch and .bw backup fields are swapped; .ch should store the channel
> and .bw the bandwidth, matching all other chips.
>=20
> Fixes: 0194a95cbe721a ("wifi: rtw89: 8851b: rfk: add DPK")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yi Cong <yicong@kylinos.cn>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


