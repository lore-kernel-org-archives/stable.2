Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795321100;
	b=s7XcDv0y8FPE9LBq1M7SyyWty1lW76/M7PaDGiEimZopJNnI8Mq7MWvoNKJXuDdIaeZw
	 03AT5QihyrOc4vklcDG56MXX9YD20reiUANr086+0RTJoMWuhDmmK2osmQ7uQ5X+xC3J5
	 Ps3RJNi94jhTD/rtEnyeG9T/GTk/RnbQP0h0XmpQ3orLQifpvyXJ7Tg4WWUKJDGuoKGtM
	 jqOxste0aWxF1SypxSsuD7noCLbQxCNKUZ+YDl0RzDfGWrfnVvMhlq18iEyvc5sPAmBIe
	 //nZ8xA6RBRlSxqCoDX5opr6m6QOO29SzbqAv75M+vTB27Cu8jkfbZaLJYFLIAZqHHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795321100;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=K5SpmYF9qIoDujQ9JAnH9RzElX//Bxtoew+aHb0jqvI=;
	b=u3SrXsDQYGM6qqUrg2YoRn5TGIb4/BzY7sH2tmFZg24RXrigi/z35TvMG7ZutYOZr9uk
	 bRv/a2EcwO4xf7dgwIoGBOCKS9lrFWhW9XnCqTW7KSfP56oaBYH96f3Y98Cf1UXN+lJEr
	 mi7cCOwv1xhVxqUf4NXXwDurIMp4nquvMk7sWLgq64uHeX8GXPLNtEDgF4Z1NfmfQxh2+
	 9d1K41GUy95rsi1egi6dPNyopYkubdPi8DS0E7LbsWnBnxKHEyro3ajbtJ3b/zy1Ub1g0
	 FlBU7+Aoe7NYC881qIaG5shHfgKkwVa3/YPqXoPoL37zF0oTD7ti8a0lDZP/TamqwCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="PM/cmPap";
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81F606A320;
	Sun, 22 Nov 2026 04:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B81F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=PM/cmPap
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jXG5Z4sKZz8XrrJ;
	Sun, 22 Nov 2026 12:18:10 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795321090;
	bh=gt1N6m13cI6EhWhLtyiHmPGo+hhNRPWASFwiBtKk+cM=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=PM/cmPapFT36jjYL/esSR2YepgO53TVhEOMXTqWo+8qdIBE7KOXT8+/0xtq9Y0V0T
	 cNH4c/uIzcLp7tGH/ApErvwKmExmKRRtrcPxX0oeQkAETOh7lH2JRnhlB4qhuSXOaE
	 66FL0zJm4d+BeaS64f9XwjoE6DFD45wIlFQ33l7HHr2Oxc+zOsVhDMcMmgfWk6ziu6
	 HHE+IfrKmouHRXi5906rGm41pwf7Kb+pCspcc2nWsHgOoFZW34iYGkEdVi+ZDP3Ln+
	 b/NA7MUAdzRlwGZ8fbM63KknWCJ+KD2Vt0ulekYLjvq3PW+VtLAsclmf/VJWzOeGvn
	 1Ndd6Y0awQqlw==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6AM4I2QQ014271;
	Sun, 22 Nov 2026 12:18:02 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 22 Nov 2026 12:18:02 +0800 (CST)
X-Zmail-TransId: 2afc6b026cfac28-10a1a
X-Mailer: Zmail v1.0
Message-ID: <20261122121802335D1zR-8sXZ6-R3aYDkB2lK@zte.com.cn>
In-Reply-To: <20261120174914.GA1484@lst.de>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn,20261115012752774qFGtgUXwZKwN-2LDj0D80@zte.com.cn,20261120174914.GA1484@lst.de
Date: Sun, 22 Nov 2026 12:18:02 +0800 (CST)
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
To: <hch@lst.de>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzVdIG52bWU6IHpuczogcmVqZWN0IGFuIG91dC1vZi1yYW5nZSB6b25lIGFwcGVuZCBzaXplIGxpbWl0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AM4I2QQ014271
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 22 Nov 2026 12:18:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B026D02.001/4jXG5Z4sKZz8XrrJ

Hi Christoph,

> This warning triggers for perfectly valid values that we just can't
> express.  I think we can just drop it.

Agreed, I've dropped the warning in v2.

Thanks,
Shao
