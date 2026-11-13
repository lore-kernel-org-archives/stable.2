Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567721;
	b=WB+KE85fSsWkpNVqSJdzXayoSsdnNEe4v0UX1fUmmEfswQMN8muGMdW9/nMKDJ/wdMYJ
	 IugPIUJ8aMplPlM+oegNyjAO006DTjNujjTzrakaCZZ7iGLV6rkBo/HSXRAehDRYGy5qq
	 h8gn+BYmroc7Or5FmKJe0h+ZW9nxZ/3xCHSzouV8cq3Z9OCRhjr0WYbd22vXfai/mn6ZP
	 uin/TlKsCGE7aZhPhcjaYFiR6lU8P9VaFKiadayG4B7Lpp7oWdQxLaTob2a1Zb17C1dc6
	 XLb8OMFdTEHXIXADBLceyYYmaUS1MB6avty27WShs3q7aEBZFsWb1P07YLaMu8y5byw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XrQXIIJcWWHsCurNHxzIBKzj+WWkbswf8BCsQIq75cU=;
	b=A1qVXdpfegJaIXtZlQc7WMKe1ESWRPGlnXbcfPFSGE/ZfJBfflEcToKxNNo/i5GYAfU4
	 KkSMZR2SGSZA7Af7G3mx3QqZIkEJ2GX2Hrs554pb1/prZQqbrmTWXZDj38hxQSxmI/Wws
	 JfRbRNq8SI7otaR7M647dPgrCl5Hy+tjAb8dWJ56R+E/vtBjYW68CLqWuFoPI5l2Gi6bR
	 n/SeCvD5YNuyc4CE+vETuDrdNGHRjoiCOrB34xRNpoXsvFikvpfdYJICwEPOEqnd81ZBN
	 JiOsUuyhzTOpQMwXtjQ+K3OglwxNhYgsDgLSkQhnHPvx8Wu20S+v5gguKy7xy46BXkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QoScEWo5;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D4B606A8A3
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1D4B606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QoScEWo5
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so1036855eec.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794567720; x=1795172520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XrQXIIJcWWHsCurNHxzIBKzj+WWkbswf8BCsQIq75cU=;
        b=QoScEWo5v5xuUnykj2i71ZG+ixB3qmy6gmDh7j7qPyzKZvXBsWfvMPfrLtSxyebLTT
         ghm6WSr7XDsuwPgIK7yq45JM4MHJ2vIE+/8wAaeeBtsZ9l0jEgqqIlq/rP2GWnm+fRPi
         JObAx1icFUlLtPFfEwLZloJ+W9ju50CTzX/l7uck2J4xciCb6OQqqEKgSxnDt02I9UUl
         CIEx+fsRa6YcOn8RgWCnHYDvaqFMjbOrZpfGYY1kQ84KU0XAHN7lbbLIvBm3xcuZArlD
         y3/wUPhhAP+D/Ar+qdspq5R7dEffAak32FxHfC8Z+RSODqd3vJdb1un6Z7R85iGfqCz/
         yA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567720; x=1795172520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrQXIIJcWWHsCurNHxzIBKzj+WWkbswf8BCsQIq75cU=;
        b=IFZxw1GrzsrPjwlGv0WqeNfj5pTPKSgvQRgIylxIqyUCppnth6LD2fhyX7k7LmLGZJ
         4KiMXZ/7gGaxonu5bs7OyFPi2vlko2Rgl93W7MZ3RqPuxJLAj5s5BtGmoKQjfRBi0u5j
         4YzzTY9+m4rc+lwvuRljDE4aGR3c4WyaI/TheEq31iAKGBvvu8EOuNKpifeQGRmtBdX1
         6MnUn7vxGytDFmYt+w76cTTPqPijPWuq9D3cjDafCNkaeH9ThIDhx36+Qnet7Xdc05bg
         ZHcWHfRY4Ps24990IETeKKnxpaID66afWsd3IsVoF8vOd4OcAg/MvZdPI30JffrP5LAm
         Lp6w==
X-Forwarded-Encrypted: i=1; AL+hErHD+eNY8U5cUMYs6rVI0BdVCmJsCyVRwXTiSJOf9DelasXzoySTuarpuEzktmmzawyY0mvzAzQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8S+e3BoBoDvCuq6aORUrnyoySmZ6l5PoWhn8ikvtmqUGxKy+/P
	PTdMb+YlhZJ32/xgbTbyvxCo6UlBYp2ZtPXt3wI+IaNoaxjwqKj6xDoH
X-Gm-Gg: AYBFou1Exw+fllDpdYX1atNe8GQYH2Pz20T+WIN5vt/h1ekyUmZrxqKAYWx0qqHr3vI
	zllESwyIBqDpTd6C2Jnx/qtoq0seCnt7kznephxehqB58kUHOAlE7/myoHRt3rh+RtsNciBBvYb
	JiPIXi+Xr8h1Vz2pKcGq93QGOj6T0+NmvSZRuAyLRqayd0EO2RHU2v2er7oWjR3QE2gT14xbmm6
	8JYpf80DmrTwFn3o72EmzDvaxbtoH2rqRKlLq4hE7EZNjtuXjLzMBwfs52vNSa5usJayIkQBJvv
	OeiGIeo6TsMw4JzEqs2uGYCDZB22sMDExWpXA5+TTQ7o4T+OJNyS8sqF2+CzQe4HCTFqvH2VtCO
	1WEROfV/Q9rvBzl9GQ63G9y95DlOk4hzmf71UL7NdserpW+biCytNVrayO2nWRG0EDqTVOXDw77
	+982ftxCm0zQI8+fWNRdj+S3qtmTDadbRhl5aa3WgBHi3lmB7LnuqtW0LndYGj3E5h4M2Ukpcqj
	5wTy1+HIxGJYr4w3JfbqEtYW/d3l6z24tA2gcppNfGfG03G5iKy0McHluXckGd7olza//iwS1rz
	4PI2XqCOkPXVWcldzMK4wbyebxG9p2UQmUvaBRsHb9wBBpGDeQBmpS9DVSdQJRy4/cJvU0oDYDl
	NlPLdK6B+EnhS7bI4JunL1IQLfF74t7MBNRiN4w==
X-Received: by 2002:a05:7300:f794:b0:351:207d:bff4 with SMTP id 5a478bee46e88-37963376965mr1902056eec.4.1794567718572;
        Fri, 13 Nov 2026 03:01:58 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm6461589eec.10.2026.11.13.03.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:01:58 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Parthiban Nallathambi <pn@denx.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iio: light: vcnl4035: Fix swapped raw channel readings
Date: Fri, 13 Nov 2026 11:01:23 +0000
Message-ID: <20261113110123.96084-1-dennylin0707@gmail.com>
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

Select the ALS data register for IIO_LIGHT and the white data register
for the intensity channel.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
Link: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
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
