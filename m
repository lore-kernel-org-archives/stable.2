Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.157.154.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181579;
	b=0ZqGUh5Nxg+tTUMr63qHTo/fdFglsQhjNlRVI2F6cLu5kl1DhlT+//Xqk12Pj0GO+no4
	 cLnnuGyPaktoSEdV0L4+t6ATi+3smkBxSEyO7EO71ThUcCGS+mF4KrurDlDN7bMejMdoc
	 j9Ir7YJlC0Km8PtIlsci3RmYktkDCQW7yqknTzxlsvOt6Lq3R3+FHh3GrOV3Unyvy5yjz
	 5khuj5lMnfGOdpL+r98WrDvmzBZO+0qKrKOsGtWIuhMQYnJTONFS9QgaxjY/eKyZNm213
	 AdE9wF0pRpoptnaaEayt0nA9Cjn+cmr3pAczXVsg0lrz4eNw1YCZ/5+Jkqy09h15sGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181579;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=al1EqTd4Io1g40WGE8lvrP5ZsrZEmQO4GTQA8+l1Iuc=;
	b=lz0Ol2GA0PTOTLhlxV8MrqQ6dwmLP8Vdfkij/40uqfi7Ou1OLiZydM6JUSgZ5UMyPsxJ
	 m62kXkPb5FIU/1PDs1FUmc+dzV/MoHebCItdQJCWIKqVN3/gfeOJpTYgWzanM+4iaRdUw
	 mrRTFgZDsIB3BfTEgvCP9g+G58xwwdR8apUi7bK34tkgd+Hn1HRGtiWgZMyzy6nHsY4YJ
	 rQC0Y+f9i0LaxU/TXa+0F18I7w1nsrc13gUkRSuqRpUfopGW0xn/rGtKpbP8mPE4nFDbB
	 EhZ8dolIUVHC3lG3wWMwLAQbjD/DWJOlhJEbVIkyk43zGeNMjkGRfH04V+0l+4lD+Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cdrolet.dev;
	spf=pass smtp.mailfrom=cdrolet.dev;
	dkim=pass header.d=cdrolet.dev header.i=@cdrolet.dev header.a=rsa-sha256 header.s=default header.b=i8liUIKZ;
	arc=none smtp.remote-ip=216.157.154.161
Received: from opentek01.opentek.ca (opentek01.opentek.ca [216.157.154.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40354606A321;
	Sun,  8 Nov 2026 23:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40354606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdrolet.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdrolet.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cdrolet.dev header.i=@cdrolet.dev header.a=rsa-sha256 header.s=default header.b=i8liUIKZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdrolet.dev;
	s=default; t=1794181571;
	bh=al1EqTd4Io1g40WGE8lvrP5ZsrZEmQO4GTQA8+l1Iuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8liUIKZRyt4Pz0BVRGSqm6RcWg9WGRlBsUAcyxIn2asoUYCA7AOFaPuqV3Wo+xTc
	 GFflZFzIgPMVtSZUplR9WMV7pdzWRsMAiQ4N/vcE9LIEsRyV/UetfMxdalCoKyFC8C
	 gZwhkHizlGetGKCx1OHwYep6TrV3pPr4+yoNIgkl3Ui3LilLPJ0J3IcS6CIpF4HceC
	 O1n2eH4hZAoGFLOlAHVy6lNepQ8f+f5/28oUgt64yNoYoBVi8UyNBVefSeypTvloFk
	 bqpM5MyTPgOdpAYHQ12c0N0eCrk/HBTa3wbeYfcGRUyLx0SY0TFr8V4QemrjMCibHA
	 oB2jqvtcTZqcg==
Received: from localhost (bras-base-drumpq7715w-grc-39-174-89-1-234.dsl.bell.ca [174.89.1.234])
	by opentek01.opentek.ca (Typewire) with ESMTPSA id 4536D16A1733;
	Sun,  8 Nov 2026 23:46:10 +0000 (UTC)
From: Charles Drolet <linux@cdrolet.dev>
To: devnull+b.danias.tutamail.com@kernel.org
Cc: b.danias@tutamail.com,
	bod@kernel.org,
	hansg@kernel.org,
	kieran.bingham@ideasonboard.com,
	laurent.pinchart@ideasonboard.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	rfoss@kernel.org,
	sakari.ailus@linux.intel.com,
	serin.yeh@intel.com,
	stable@vger.kernel.org,
	Charles Drolet <linux@cdrolet.dev>
Subject: Re: [PATCH 2/3] media: i2c: ov8856: Enable runtime PM before registering the sub-device
Date: Sun,  8 Nov 2026 18:45:57 -0500
Message-ID: <20261108234557.12874-1-linux@cdrolet.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104-ov8856-pm-fixes-v1-2-1958b730ce66@tutamail.com>
References: <20261104-ov8856-pm-fixes-v1-2-1958b730ce66@tutamail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: Typewire on 127.0.1.1

This issue occurred on my Dell Latitude 7320 Detachable about one in four
times I rebooted. After applying this patch, it didn't recur during 10
reboots. I also ran a very similar patch for a couple of weeks without
seeing the issue.

Tested on Ubuntu 26.04.1 with Linux 7.4-rc1 and a patch for TPS68470
board data. BIOS: 1.48

Tested-by: Charles Drolet <linux@cdrolet.dev>
