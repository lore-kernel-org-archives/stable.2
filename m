Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597431;
	b=wUEZioXQLEje+OmihUq+GGlwnoqSdyOSC5q+b51bPjpb9ig+WtmHbBMv2oJwM0TPITzc
	 SMAZv/h1RtCxjG+H7spD3gC/s4vH1XvJy8SGGM/9c88VNpC5/7fT6GkCix+Z2ix16pmFt
	 997sjskclB8/oozRDWGQp4McVd9JEu/fTDP3WjLAeB1WZiz+clA9PNPS7fxcsA+CXTjeA
	 B+HMAXonfhH4AU7Bzoh2k4uDcX23D7zAZBVlKxj48zJFPl+qv8KDRGzuYmifQti1E3Osc
	 R4kSZ0IBRzUWi0CCHH5HgM51lmjDQM3yQfw1KRO+cJyez47uP45vIqWCUBAEtOi7gqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V5RSPGAWd3oxeQteUUuoK6f8743toWOpgplcBAfwJJQ=;
	b=RKjCKnfniP57O+It84fkNwnRnFkzRGiflKfaRtID0YpGbqvfGCjGT32dbx05p1SEsInG
	 G4FsWdJwLBR7mu6oMVByf142MVkllu0WHxL4F+yanHWDql/TGyIUxUwEL/+XFGMBayxWY
	 0eMhZmN3T8TrXOBFHI4WffciBCYpWzC8S4YRQLxkFevescbCpnf49iPVRc83dMYR66ay8
	 fLPFSfQPTpLQCRUpb8SAMEM/VBXjpF7Cyy0n2G2p0/B1Ni149DDS78PH+bMn+3sm1hHpO
	 FtE/UoBqR2lbKtmV7+65SPOORi98c889aieG0356aEKgp36qnpFWhlvcHg9CCw3QpQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HY9x75Mb;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A83606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90A83606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HY9x75Mb
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3866a784546so7356176eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795597431; x=1796202231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5RSPGAWd3oxeQteUUuoK6f8743toWOpgplcBAfwJJQ=;
        b=HY9x75MbktHUwVKLIjoW0r4G8U9AL+zGRk/oiAJaPZPbj8AB7HKEVuMM+TB8aJ+dJR
         f8bZI5psfk9sGePKAGpDU//iYdl9et6CkaKxTKr1p6jyP7AW+UXJ78GDY27AJEwceh0m
         kEX0bojnDdo7s+nPikxRobNvgGGtC3XSMKL44XnlnNDbn5S8ITEV5BaoQewaisdOyQnq
         FjzaplAhjZ8C3aqkcvN0uyoIeOQI3URFC/7xOTaID+zcmrPlSXW1rgEeS+rAQfXIUG7v
         dg1t00lGESsaIEde0lStnYO9fwo5IGucPsIBYy/xDyknxzheatIJPO5oM2i0rbsPD4EA
         MW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597431; x=1796202231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5RSPGAWd3oxeQteUUuoK6f8743toWOpgplcBAfwJJQ=;
        b=jQzBohymk7eupIccqcimBZwy7Kd6dTVhkmeq3ci/wlCU4cqSQqqoYrAeFTPGHiJ1f7
         9pv3xGqxx3wvap7KJ2cV1fXJv75++OJrTPhu/4VU0WrnP0SYZfq8oPMuOzmGnL0Kf6bb
         y7af+RdM1xMR2i8+5L4UcSatgih8rKkzHLkxrITyBPE5LiGOqecyw6nT+7NKY6O1pLJF
         0WROAdjYgaShOQdmYjRPgagaRJ1MRbMuXJcZ7yzgBaAFq9xUeAGK5ZtUaQSPKoHTpNSW
         pojNyDRmsCwSFBMNJlq/571Ykyea7rm3jbA6WcWz7foDgfrgdqlGLvVO1a/Dhvib0xN8
         YAtQ==
X-Forwarded-Encrypted: i=1; AL+hErFkQneJcM9zrSUk+ls46bvGBdpTTIrn2Ruq00aR0MheIe+IDZd06DJS4xtHIIkWyLQuyCvYQO0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NDmdw0XQnivo2/HUVeJkUAf/jnru8UG540HWHdaTOoyzGQTkV
	odcf9jzQ5N3ZhlZe5IIVMFoOp1PGBmpIAHW7xev1l1TD7Kfjuu3zDGA=
X-Gm-Gg: AZFdTZdaUWuoNSny5ott18jWelZwxSCgG0hKSD/fg5D+IyhL9lcrjaQg0YNMt6+JprH
	dZ2ZnG0L7a6z9x6DNPjAm92s9p1LFWJwU4iSm0+kmW3d+cXCKf6rLeMauoJKKu1M8AkVXeAJ48y
	RnOOP2PkuF8uscJnJ7PfwnySmMY0HrpiR2yfRomc2l+kSUsUhUrHDknxEndTadTjFmHDVe8tZ1o
	/gx6Pt9b2yebkHEfUXmXshCD/RKhJ73e5gPt5QSWeKVJVETWZCPZ8wSivQrGjs6j0yrUdKOwfjz
	XYG4otF9Ean1LH5AuUmwSRsv+bY11PCa+2srfshTP5Dyvr6Hk2fdvJChzqhiDxELoR3vxoMbDhL
	uZdeVkmF1P/uBTdqSJpCh0UpOSt5+BJ5Jf/YmouohzCu6AutXGoR+2FLklbGk606lCUnFShcy6D
	h48cwa0y/6cVWRgdfBgjNK84vESV9V2bwyhNn8u9Qv+y7nWN6j83daU2rqhUzTaipJ00akEzzvR
	XoDqoJrHVWaMMARmgJY7RFNgOrejEv+nA64e01C6xo0Rh9IBbvDiipaASyqUJGc/JmNMsav5eBB
	a3Cfg1m8LGKxPXznasHfjIrdlxK0+JypdbTjK3uXKjArsovNz7wnSIeK1vI9FBJCSLwXzOw16M6
	L00U8bNgaCcHNDQ==
X-Received: by 2002:a05:7301:730c:b0:381:2114:99d0 with SMTP id 5a478bee46e88-38571415bdemr16715777eec.39.1795597430484;
        Wed, 25 Nov 2026 01:03:50 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:44a2:4377:d176:9ad1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd4efesm53859174eec.12.2026.11.25.01.03.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 01:03:50 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Wolfram Sang <wsa@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] macintosh: therm_windtunnel: Fix i2c adapter reference leak in probe
Date: Wed, 25 Nov 2026 17:03:43 +0800
Message-ID: <rc-b1-20261110-vc-23-41d00428efcb@gmail.com>
X-Mailer: git-send-email 2.50.1
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

therm_of_probe() walks the i2c adapters with i2c_get_adapter() and
drops each reference with i2c_put_adapter() before taking the next one.
Once do_attach() has started the control loop, however, it returns 0
while still holding the reference to the current adapter. The pointer
is not stored anywhere, so that reference is never dropped. This
happens on every successful probe, including after an unbind/rebind of
the platform device, and the extra device reference would make
i2c_del_adapter() for that bus wait forever for the adapter device to
be released.

The driver does not use the adapter after do_attach() returns; the
sensor clients it talks to afterwards are children of the adapter and
are unregistered by i2c_del_adapter(). Drop the reference right after
do_attach(), before checking x.running.

Fixes: 3e7bed52719d ("macintosh: therm_windtunnel: drop using attach_adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: powerpc (ppc32), GCC 14.2.0, W=1, pmac32_defconfig with CONFIG_THERM_WINDTUNNEL=m, CONFIG_I2C_POWERMAC=y (object only; no new warnings).
No hardware or runtime test was performed.
AI assistance was used for analysis and patch preparation.
Runs on every successful probe of the Windtunnel G4 (PowerMac3,6) fan controller, and again on each unbind/rebind.

 drivers/macintosh/therm_windtunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 0b2e08a1bee0..4f2581d9dec9 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -472,9 +472,9 @@ static int therm_of_probe(struct platform_device *dev)
 	/* We assume Macs have consecutive I2C bus numbers starting at 0 */
 	while (adap) {
 		do_attach(adap);
+		i2c_put_adapter(adap);
 		if (x.running)
 			return 0;
-		i2c_put_adapter(adap);
 		adap = i2c_get_adapter(++i);
 	}
 

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
