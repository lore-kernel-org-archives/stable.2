Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.124.121.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785359;
	b=NwRZgbRlontgBPIknNDsgTKCPtXFFv2vP7+Ysn08NhmNALEb9LKZMGWkh55TfB7N7mAZ
	 Y3JreV2tIFbydl6GzvwG7EX/l72DsxFMLm0qstohNp1PyiWBDSJUfrawqq3YjoRYo/PQF
	 BHu6ZWkZadMUZC42B20xihOsS5MbU3mEnFX1gWnZSIRTfihrOO3Wr1tgq12BHZegNJ/ep
	 tKA6B3+rtwpsrNSb0jbj5bxeK/IiBf7xpWIS8BzYqWbX4NxdKcXqFP66BYEfzUibcPARi
	 4ST72cR3a+O9qdF5qjv/kVM6L+w0mn/T/ZHgxNjCONffnQ9lqvYB/5oYQdY295jxpQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785359;
	h=DMARC-Filter:DKIM-Signature:X-MSG-ID:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ZwNTgkt38B3f+NGhOd3NDSBFsSvy5cKG6LDyCGr0oS4=;
	b=gPjlMvHzGbhCJL63VmsRJdulCAU+h8WNTifXmQZ+RxPjnf1P17yWZGqCyx4++bCC1YQb
	 e3tchqB9ROHmpGcDVD9kxOP6Gl2LhHJZIo6HRIgLtIMdEO3BI0W+KTgiW3j53uZs9MQdr
	 XBvomoKkSiZXQhvAAhv0jD1OkbZSaHpm0bSJhRTjDhdgTwOsPyksVjfMlCoSPSYSzIS3c
	 4etMNilHnAznzFlv01A5Mps/2Ykti52o2fsrLjsCOGUprQo3mes+7VY1A0w62DOwI1ywT
	 mYGVZOEjwP3xx+80h5tiMF9fakK5+01PDMRVGKrwby1Sxpq/sWxpGjSIGPnOw6M2ZLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zanders.be;
	spf=pass smtp.mailfrom=zanders.be;
	dkim=pass header.d=zanders.be header.i=@zanders.be header.a=rsa-sha256 header.s=202002 header.b=wOXimm1B;
	arc=none smtp.remote-ip=94.124.121.26
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211DC606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 211DC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zanders.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.a=rsa-sha256 header.s=202002 header.b=wOXimm1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=zanders.be; s=202002;
	h=cc:to:content-transfer-encoding:content-type:mime-version:message-id:date:
	 subject:from:from;
	bh=ZwNTgkt38B3f+NGhOd3NDSBFsSvy5cKG6LDyCGr0oS4=;
	b=wOXimm1Bj/jR2HbYsqD5Vuxy8H0K7ljyeZTin87qmsUVDj2jMaSntNgzyDVs3nPpah6O2X64JvJXx
	 slh7lIX0cz87cRQfvDdB5CN6wBQJm+BnrH+MTI7I7xEkzbgAzl6vL9UoZQBjrvA1vD/34cmSuh1g0I
	 /fUeda8fo597Fh6Q/3l0jDIV0sGzx4PYxTBA8I6tjQdvmZb6caXZpeCvSxcXnDjwExzRsdNadx7P3Y
	 2JpIrg7/9PLTZVDS/1vS2pypwHrRSNX2e2FRp3XpjRm1CMxfyF/7DXN4575oqtIRfrfzFrrfO5NK6N
	 ZFywfDoSycQUBF3DLeVmKtxIOw79MIg==
X-MSG-ID: a4cad46b-ea64-11f1-8642-00505681446f
From: Maarten Zanders <maarten@zanders.be>
Subject: [PATCH v2 0/2] clk: vc5: Enable PFD frequency doubler for
 VersaClock 6E
Date: Fri, 27 Nov 2026 14:15:30 +0100
Message-Id: <20261127-vc5-6975-dbl-v2-0-5a05581902c1@zanders.be>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2jFMy8O68j8MC9oOUmOAtNiop
 P8u4NrlSc49d4HA3nGAc7aA5+iCG4cVxCED07fDjdHZlUHkoiKiGqMpsVJ1iVY/UOZc6Jokd7m
 CdTJ57txrz12bH4envrOZt8Zm9C7Mo3/vf5E27086EhJaKYU+KVUV1lw+7WDZh6NmaFJKXwXck
 Em7AAAA
X-Change-ID: 20261117-vc5-6975-dbl-30e4b713ef09
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Matthias Fend <matthias.fend@emfend.at>, Adam Ford <aford173@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Maarten Zanders <maarten@zanders.be>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795785348; l=1228;
 i=maarten@zanders.be; s=20261117; h=from:subject:message-id;
 bh=YD6DxF2+57SevKyc/DXU32utyjKIuOUzgDfp21AN/gQ=;
 b=+TKO3EY2x+X57wOYmxyljyHHwtF/SISgEWUBmXFLKl5k99aXVd6YR8KnJRIeFxklEHFMsLQbp
 GzRvDCBz5w/CTUeZbzvvdPm1U5+lgSTuKJhWvU7OGRm24TfYu+mRJNA
X-Developer-Key: i=maarten@zanders.be; a=ed25519;
 pk=9vkWF6gtn9DS+97n+W487XUEhrI3+9cvA7Fdon8T1uI=

The 5P49V6965 and 5P49V6975 support the reference frequency doubler,
but the driver doesn't set VC5_HAS_PFD_FREQ_DBL for them. When the
doubler is enabled, all rates are reported at half their real value.

Tested on 5P49V6975 only.

---
Changes in v2:
- Split into one patch per chip so each backports cleanly (Jerome)
- Collect Reviewed-by from Jerome
- Link to v1: https://patch.msgid.link/20261117-vc5-6975-dbl-v1-1-d332b89964dc@zanders.be

To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Brian Masney <bmasney+clk@redhat.com>
To: Jerome Brunet <jbrunet+clk@baylibre.com>
To: Adam Ford <aford173@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
To: Matthias Fend <matthias.fend@emfend.at>
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Maarten Zanders (2):
      clk: vc5: Enable PFD frequency doubler for 5P49V6965
      clk: vc5: Enable PFD frequency doubler for 5P49V6975

 drivers/clk/clk-versaclock5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 77987cd64bd6f58d3d35ccbac548fa064b892950
change-id: 20261117-vc5-6975-dbl-30e4b713ef09

Best regards,
--  
Maarten Zanders <maarten@zanders.be>

