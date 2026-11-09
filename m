Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240182;
	b=WVISXuqAa4DwSN2Nk/r1n3I5G8xhpXIOc1sIQqtQhfNHBcijL+nrrN0UbniVQSoEgVX4
	 eu1AM4WLv4R6Jn/VhZ4GXvDwLzHmonvg4dYgSVGyBidLI3vomshNCXN4ptsSpTkFv6gxg
	 i0EZw+j4HCmylJymzBp1tvVOvtKMSgjJXbfwLRNvYV3LfqpFsVSWtuVVhLCusKXNU0U7V
	 vik6m9d2enm+YsARvPeYfY3BY5gSko9DSk+N9xSeKhz5/OWWDHWfdKTy/1cRQLK6ritGk
	 U5GCAfNdLw/jaWd3S0hwWP+I4+W0UmLtrSsenX5mO++iOSQKpDUiDfp9PGnuIVenUDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240182;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=HNCbvLN8ICuoCz0fHhWsUE+dzGmKKqmDwgj4AtvdWT0=;
	b=VwSTOVkoCIyrvYVIN5nroh5b7eBrSaTCNWpbIj30XGHWBgFkmLZ71uXHxx2yxktePmlq
	 RhJO1QvxZsM2pn2xTVBx3ih0IAI4GVM/rC4/UI4K8qhClmhCkSEPDO0kEwqeLJwgF+KIh
	 0jE7YhMboDUrqo0ChYOJEhTf7swA2PTSx15D2d3pXzH/3sxqN5eKxm3r7vn1YoDto5hvl
	 9vGati9a1hExlMMW99OtSQ/UdzKqIUqDc0OpX58zxaXsXP8JmG8DOze0m/rr61QASnTYD
	 BQu3Z7t3yqzRErcycW47UUH6WxmteZ/DJbdBjsoV46C2eY+QTmCFERFx7OyDW1Yt+ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=MRE3mumK;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16752606A338;
	Mon,  9 Nov 2026 16:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16752606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=MRE3mumK
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jNZLq0j7pz58fdb;
	Tue, 10 Nov 2026 00:02:59 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794240179;
	bh=M/RNTyCTnYXRawQXr7b5ifRdZQAzhOIHwOMjs9PSuU4=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=MRE3mumKgI6wo5VuNEaQ0r2fZJdBoOxD+/tUb0NIv2EQZ88ctiUIbViR8LIBfVxsg
	 chdhNq8D+iQtfnrAREvEEUX7+RAt9iIVfpnPSV87ahbgVCTjXpizhkvyudx7WbMq6t
	 ov8lQ81WjkKxfT2Uf291IVXmO6A/O3EGkfHOyapW9V2FsPSkfO55CZP0oa0KE5vj9D
	 FfZ0kepD6GwEtW/DJihBiESTKc6lHfS5EeOMV6uhm9Kdr2FK5kcxUoIUT3mGEln/18
	 G/lQJiHEQZpsC0zKBgcDBLks/swfbHeGTYLzmwQrOJwE5JjS9vMjovUeBDBOvLORhy
	 nJtBVRfocQVug==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6A9G2Tf4043123;
	Tue, 10 Nov 2026 00:02:29 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 00:02:31 +0800 (CST)
X-Zmail-TransId: 2afb6af1ee97dd4-a9b69
X-Mailer: Zmail v1.0
Message-ID: <20261110000231218wQzBUXC6z9Ptr1Rb3WqYR@zte.com.cn>
In-Reply-To: <avHkMosHVOXCpVPD@ryzen>
References: 20261029190111138tS0yRo0lL1zJZ_IutobE1@zte.com.cn,avHkMosHVOXCpVPD@ryzen
Date: Tue, 10 Nov 2026 00:02:31 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <cassel@kernel.org>
Cc: <dlemoal@kernel.org>, <hansg@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYXRhOiBsaWJhaGNpX3BsYXRmb3JtOiByZWplY3QgaW52YWxpZCBwb3J0IG51bWJlcnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A9G2Tf4043123
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 00:02:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF1EEB3.000/4jNZLq0j7pz58fdb

On Mon, Nov 09, 2026 at 04:18:10PM +0100, Niklas Cassel wrote:
> The warning is redundant.
>
> ahci_platform_get_resources() already prints a warning for this.

Right, thanks.  It walks the same child nodes earlier and warns for the
same condition, so I'll drop the warning and only skip the node:

	/* Already reported by ahci_platform_get_resources() */
	if (port >= hpriv->nports)
		continue;

I'll resend as 1/2, with the ahci_dwc fix as 2/2.

Best,
Shao Mingyin
