Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608784;
	b=qC700mA/NSQ1CBBhDBqTpeIzcH7HU7npJLl3Pl4AZHUZsfS9ucx64uscI2KKayLC8h6+
	 CGaDy7JLv2H2vripKOD4nw/qHJSRYndzDWpq166wnGElU+Ep4sPQhB0Qku2waHWZw0wjT
	 rtpDvQfMr2CYDyv9+3OlclG+ZioFiKZCxwHzVWO8gkalNTQ11i1K/qZ1HoHOXZAoxkZ8b
	 PU/qVTVxx6/wkeErstp56KEb/xOI4ynoffu6T3SMu/zwOEPyCtBO68XDKO2xhqFqbj922
	 lnOwz6F6ZeV98+JDqWfhvZTg2EX2g8pOhs6IrrdX7hSXKpn4tPSgIDEOfuTUNtGnb1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FJtZRjKgFg90uSeT2CbjH35DbAO/VLflNjScs874eM0=;
	b=xXNVhYziX+HODcoy8zBoPHas9LP6nymplKu5cqhFXfdGSwpbQ0YHDzyx4zATR/0ShfAa
	 YNKV9DBnlyE7a9YUEXD0HPju4PQzTBlTLDAubx3XsitBLWuOGRMyD+1Tp+ySkVGF2zPNd
	 KKS75OHS9bA7YNy3lqnuoHsXtwpgp2Nq1mX7TGhxySPAsTbGwti5QY0ThOUbIB0fjvsXW
	 yxPGi/Ryl3tnbDypQfAPIN7idvbuiVny4B/LgCYHnOXknZeytzzVZDp9Rthvm99MbuQl5
	 WnteFl3wZYHTdE5vXkA8N7JaPdH44o0Jjrk7QCgnP8z72+LVwe2hwhfz5ab2yiG0SKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LW7hNVN1;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF92606A33D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF92606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LW7hNVN1
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so1536095eec.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794608783; x=1795213583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FJtZRjKgFg90uSeT2CbjH35DbAO/VLflNjScs874eM0=;
        b=LW7hNVN1/QnvVg3UkSRF0jxLpcaRrLGgFRFHtoTIp+6N3hBqKASEMnp3c3ONAYNXIB
         7jBo9XudgJ8EIkIEllsKdLrMfSlZRyLVJdZ8ZTm4YPL9UDgC5a86mS9iNltY3TeJoPQq
         VIYQCAoJTy5pBvL9AXkZaPvnWvf5MWdM2LDqxvOyDnAgJn+LxqCq0jRm+igqA7BFh9ee
         4rIw+phy0fECX1Kjyis2LvKy5JFSMAIsW9ExuxQ4LGct2uLxK5UdUYSNoDKGAeGQwdAY
         qsBhs3qGX8pZeKwd/bXuBSewMym9Ays/JuRaznUEQdh1lliYtVopM+5/hBAuCyf0gjTl
         Beuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608783; x=1795213583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJtZRjKgFg90uSeT2CbjH35DbAO/VLflNjScs874eM0=;
        b=nclb6/x0jhAnt1FSboSOh4RAAsg/cy0u1pTvHlHl3MhEH+84IMXxyeD2pHMLQjNA+S
         ykvceuRecs5RK2FqltTuLt4VTm6JnVScMV5bzj9+BSNrlldD8IhWY6gAg5Vz3PNcbg4c
         Mn3Lmqpx8oyXTHSyiepmaeYDBzIe29jOEPx7m+xGrhq+h9OLS+wk/3KJG6qq79vKPfWE
         6qPwHnUElNQk8/hygLHZNcdG0DiPk2+rXu+B9Ef7hHGhWtv1WQwz4qrGAtmItEXtBxzd
         BollV2yHlq0QA5ZL5FB2bHKoXzNyAP5UBlYgAiEMQU86rHse27G+SaiLeiBODMfsWXtW
         g7XQ==
X-Forwarded-Encrypted: i=1; AL+hErFmxJbJg+Nr8BTpRx70xtqNFTkvn1hQpb6KEsg2O+xvVnQwTUKBooL7M7qiWFH/EbiL0ILzY2Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8eW99e6IGDoEppPlsv8+tgakfxWU20HeiGtYaooj45aBBMyQta
	VC5jhITq5ogClcVzvTttVKT9c9zGLL0RXX3rGG59N7uU5RI0+6zksZma
X-Gm-Gg: AYBFou1HwgdmEHvbJXVmBPL7/3flgrSvSsLeNLWB7x2mYgp+WVT9jDh219cEdXKBFnM
	PGX/Cvu5m/Q5mkY6zEXNRsYwyRmcXcVPww3xPOA9Gu87n5XeeJqmEM79T7QPxew8riIdwraKSeR
	RZN573JCoAuOfneL5KF5b7fO+YYji7htB5c1oOBYJouNOQqOTnDirbcjaHmRre+HAeJ1mrALjra
	stAnbrsio6E26Qn77MxtCvY5F/8RNnDhFWZIt+AKULtpwoHkXEgT+hGcD+2Yrpk+FRXloIe3KBA
	3HIlwKt6ADJ4NnOsVB+opyahNkbXO6xjVCBP1T/FmjTD2HUMh6U5l4yU7KapHBp2u7HAq3dDodK
	hTb24uNcWBNPgnBpSnGCPPL1658EHoZ6LZDAABgwAF1rZHDhcTVXgUMW5PDwQUm1msMfmQlmGP9
	Cyqb2wDa/KvQsWIpspel/egnR8vM0owoinou0EpcwL2WS/ixYejAzeGLvp2+5A6Pp/7nUo77Pi9
	RrZdpo1WsRAERMQS1TwHC/B/tvxYrh2ZlcMz9Ls0c5fKEP8auO0JYpxCMCofDnaISBNrXtRhwPp
	zyH04M+l/YFHU6c5ATeBUjt8fkh9DtjeMYzqgtmUT2eDcX93+xiU2EySxNG/G7J1L044VLH3KFw
	r0GEGDiEXREwzxHFO2mhmFPo78de9zAhi3b5A46c1hgNw86fEnwq9zDOdl9k=
X-Received: by 2002:a05:693c:3e0a:b0:36b:d3dd:2e9d with SMTP id 5a478bee46e88-37966192e10mr3194904eec.19.1794608782828;
        Fri, 13 Nov 2026 14:26:22 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm17151380eec.21.2026.11.13.14.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:26:22 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: light: vcnl4035: Fix swapped raw channel readings
Date: Fri, 13 Nov 2026 22:26:09 +0000
Message-ID: <20261113222609.97564-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The IIO_LIGHT channel has channel number 0 and the IIO_INTENSITY
channel has channel number 1. vcnl4035_read_info_raw() selects the ALS
register for a nonzero channel number, so in_illuminance_raw returns
the white-channel sample and in_intensity_both_raw returns the ALS
sample. This also causes the illuminance scale to be applied to a
white-channel sample.

Table 13 of the VCNL4035X01 datasheet [1] lists 0x0b as the ALS
data register and 0x0c as the white data register.

Select the ALS data register for IIO_LIGHT and the white data register
for the intensity channel.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
Link: https://www.vishay.com/docs/84251/vcnl4035x01.pdf [1]
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Reference the datasheet's register table in the commit message.

v1: https://lore.kernel.org/r/20261113110123.96084-1-dennylin0707@gmail.com/

 drivers/iio/light/vcnl4035.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index f1cc75245001..4bbb3b458eb5 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -156,7 +156,7 @@ static int vcnl4035_read_info_raw(struct iio_dev *indio_dev,
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
 
-	if (chan->channel)
+	if (chan->type == IIO_LIGHT)
 		reg = VCNL4035_ALS_DATA;
 	else
 		reg = VCNL4035_WHITE_DATA;

base-commit: 9752760146e642f3e4a2ec860f8767fa72030d2c
