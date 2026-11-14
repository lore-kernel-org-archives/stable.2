Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674012;
	b=VuOqr7SzpzAmExeNGQ+Z6PB17n4t6h/EVguhFsXwiMjj7y/TXYW1M8uAADJ2DryFOTew
	 +E8ETaj0zq2jBjxqulis5GbEy0FYNDCNYeSsNn1GjNvBpXSBFrjINv3E7Ag/7CYlWOz2X
	 shqT3woT+VcvjdDe5J6H5xgbuge7ij0+epfBO2VQaGf7HpNFJ9rIeJounwH9uT6X9xB0P
	 pVlk3R6N+euNWCleNhNryPtUj6ZeNHQIkVwuyC/d9FVIStpeO3uPxjCVXQHIGqGjqwtwq
	 kzGFulNO1+9YaPDuvw44LgGcim2gllaaxpB7BwEhH5oRaR1dFqUjKvI98twUJUBdu1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674012;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=XfwekdUhPrWfH86K3T6gPuC4Oo1MXLlT2SimSgdnvbQ=;
	b=E0rDP6RKiUI6xR98j7FLeNIHzHxNeNpyI0HuWXlR6IoGkWIHfMueV8GDr1QLgmflOqVX
	 8qeMy2gfvzq/Ufm7kt19PI3dz1+3fajlcnLbe0eNcD7tgu2QuQuV/deInV9vKdkUbVFSe
	 HNrTQthEFYO+YNam+AFUpcvkoi9JzJprqMxs5Zy7mFH7Cz7exShCIOWeUzYuw4ZPnAbaz
	 gZGHD31rYb8YcRyK61E1FEZ4amFURCAohd7GxrIrpualD/GW29cRpisnWYw8kza200GBl
	 pi1OdgzsffXRCUSFuDJNgOvaN8NLisq60a0QxaiW3GRUxsdycbPUkf3WLdx1T2xOW8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=kviYSNKA;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6DB606A330;
	Sat, 14 Nov 2026 16:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC6DB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=kviYSNKA
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRfnh70Hbz5BNRx;
	Sun, 15 Nov 2026 00:33:28 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794674009;
	bh=UrUIoImpp0bE5S2hBewG7n80aOK75B+r0XS94ao9cN4=;
	h=Date:From:To:Cc:Subject;
	b=kviYSNKAxtqlTwN45tp6M1AaSymfb0Q/051nPYUy2NWqjnA50UVdLavx0dP4qZSLq
	 abIWBq6ISs2mZ0L2nVuwSyP50KU5eY5cV85wgmGCCoekBP8BEYjYRKgrObmL5bQKmb
	 FkQbTn6yhivh3kuK7ks8mJvSZiZb9/fUmiN1kJGARcKdsxsdZamq797KzUIbgt5JtJ
	 6AlbnI7Juhc9n+X90FRr0V8aaVGg8dUvKnCVQAW0MtLWN9eaoDRMGzuETQxrUNuly1
	 p7RdqEjEr+1X6WIp/1LZN7yvG83qXuoL+dYBE/JZWWNB+41Kb6nQjT3d+8QRsWGmcO
	 7fthN210CH9DQ==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6AEGXK0D085600;
	Sun, 15 Nov 2026 00:33:20 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 00:33:24 +0800 (CST)
X-Zmail-TransId: 2af96af88d54d08-28ce0
X-Mailer: Zmail v1.0
Message-ID: <20261115003324243qi0CFfSksizkJybVkq3QH@zte.com.cn>
Date: Sun, 15 Nov 2026 00:33:24 +0800 (CST)
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
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvMl0gejJyYW06IHByZXNlcnZlIHJlcXVlc3QgZGF0YSBhbmQgWm9ycm8gUkFNIG93bmVyc2hpcA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AEGXK0D085600
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 00:33:29 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF88D58.000/4jRfnh70Hbz5BNRx

Fix two independent data integrity issues in z2ram: completing a whole
request after copying only its first segment, and returning different
Zorro RAM chunks from those allocated when the module is unloaded.
Both changes use the existing backing-memory map. They can be reviewed
and applied separately; the supplied order is the request fix followed
by the bitmap fix.

Built for m68k with amiga_defconfig and W=1. Source-level A/B tests use
the actual request, allocation and unload functions with substitutes for
requests, bitmap state, memory addresses and unrelated teardown. They
cover multi-segment and cross-chunk read/write operations and bitmap
layouts with holes and entries above bit 63. No Amiga hardware testing
was performed.

Shao Mingyin (2):
  z2ram: copy every segment before completing a request
  z2ram: return the allocated Zorro RAM chunks on unload

 drivers/block/z2ram.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
