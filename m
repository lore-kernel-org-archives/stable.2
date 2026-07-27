Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755D13A1CD;
	Mon, 27 Jul 2026 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135217; cv=none; b=rhGnVeDxpr60aIXFmYopb6hQVDhZwQF2BsNhNhSecK91UUZwNuRGrSF3zOYIg/nA0fs2k79GP8SDgDfmWfrqiyLuT2G+p6SQzfvzIZS958KWyWlHbjMaWlg6v0gx1LHiyxQ8VbySM7nP3Oi1IC0V6hSrX+SCcJfNjVbwbhCE0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135217; c=relaxed/simple;
	bh=50uxGbMYNVV2CVxctdvX07Ur7NMMwlrFHCcpscXFa6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FA7QaZGdCw0PQ663bJp+uWANg78CiSG5MjzAHj1CFbMhZYj5rf2PS8E4kMLTi0r6R63pR4r0phetGobq24vy+FHIbnTMRY/QW4PYokxuWaoVWAE26ypDkvBjlMiUnryIq/0ZOIFSLPONhNr8XttgXDbnZgA1uk62sgLL2AwTwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=asf0YvRy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="asf0YvRy"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66R6rVfX52913877, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785135211; bh=50uxGbMYNVV2CVxctdvX07Ur7NMMwlrFHCcpscXFa6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=asf0YvRyx3NhUOyYbHCOYIdjPs8qCge9KgpF7pY7pIUhnVA5wS1uBTkudmH4n1j03
	 In4doG+qfnnnRQJppQPFxOJjZOX+jvgiJDcX6gqFXHZ31F/2ziUzRJP1SNEcdAHPJ3
	 zaXo8SfhqtPBefMgAX7RtNuOlbcmQI3xDaC2H2u42UVOCs4uBGRUraroLmq8gc6Idp
	 kvLQ4A9H+kB8jkyDBZs7Qiu75eTxVHST8Js+forBUuEkqTwIO0dEWUxF/ZpctOSqDn
	 cbkPE+sk7T/40l7UgwSs66mKl2eqWxyPHiU00BJDjgikD1cGd7M4UXmhszoWiuIRx9
	 /4P+Coe7EC4Wg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66R6rVfX52913877
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2026 14:53:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 27 Jul 2026 14:53:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 27 Jul 2026 14:53:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: Fix potential memory leak in
 rtw_txq_push_skb()
Thread-Topic: [PATCH] wifi: rtw88: Fix potential memory leak in
 rtw_txq_push_skb()
Thread-Index: AQHdHZMjHtB3iU8Gwke527DaN58Xg7aA7f9Q
Date: Mon, 27 Jul 2026 06:53:27 +0000
Message-ID: <96476dd34ad845c58839a548641d3600@realtek.com>
References: <20260727064223.61836-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20260727064223.61836-1-nihaal@cse.iitm.ac.in>
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
> The skb passed to the rtw_hci_tx_write() is expected to be freed when
> the function fails, but the error path in rtw_txq_push_skb() does not
> free the skb before returning. This can lead to a memory leak in
> rtw_txq_push() where a dequeued skb is passed to rtw_txq_push_skb().
>=20
> Fixes: aaab5d0e6737 ("rtw88: kick off TX packets once for higher efficien=
cy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



