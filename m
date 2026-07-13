Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61142DA74A
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947016; cv=none; b=rtjWg5qNLZlotYKIUvwU57UvECKBwqeYFyoyxeIC8UTlk3Zk31dr+5ENjWOqwvrSFz22CM3vzyUuxwrexri1cxpdvcQHfEP4ufCXZdKGapM6useaYy0jWrRo6JJ1f0NXLUJbUWlViAbS5qAPxGb6PV6dBPTwW1RpvRGVH/XXpRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947016; c=relaxed/simple;
	bh=S92pQ2C0qUV/KBqi32UApWFOvWJs4dXNLhZODPKvz9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INVgvf2Ev1vs56gQk4s1gBZ+gJt8YgJl4Jx4dqRJ3Pt0wkZI7rbMDKSAcDTKcEdPiWeDNG/47HtOlsMh+OuDhZT1VmKYlFRhpLALEgYE6eVgXKRvekmWUnkoUzzDlr3MuGZhJQVHB3x9ud9mu6lNibfqjYPdiCDsJcceDb4CDCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3LyF4yF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3LyF4yF"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccf2360620so26050965ad.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783947015; x=1784551815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TvooeHfwR2QntnuwEEpfCHr1XrT9fgk2dlfW1+7scHw=;
        b=S3LyF4yFCL8Rb/DLclSRrX8LAud28j1tN9zG8au2ig8qIULMOML73cVJ+9ZeQqazhQ
         sqV28oVOALOyyGqBIaVS3Q7TNcO9yKtf4iOcEqhzJVBPcGt6/j1XR93sYo2zCHeBjJqx
         jLrjp+PC9M9AEc3OMM24Xt3dBdgziXgOXIG3OIfaXbMVScJoJnIm0ntvklxUJs/skj4t
         kxt+Gb2DpLnVyrh9tgkJCWhSGTWFfzpXKzQJcQp7faDf6GiSioQ+JdxbQeMMR+igbq7R
         3YkyZmq0vi5ml9owV+R4O6pIX77dcEmyv23/EKjoDMj73pwCR7pJ2/+py2VzmeN35HDs
         NXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947015; x=1784551815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TvooeHfwR2QntnuwEEpfCHr1XrT9fgk2dlfW1+7scHw=;
        b=b4DhO+bJwjuM3tyZ1uzshH1ijg2WuHr5/TahMF426b9OwX9Q6gxxiGzRzJh3DgODgP
         /aYFgnMn9tZrXz0qUIECCfEK+tEiXztY91F33zKufLSdNtdL4+4jloGx1nQEvoI4WXxh
         RTeHMl1xtGVzJ4MlwBiuKI5HdFETice0Ih1FUu8z3/+ny1d333llSlDoqJzTzSUprskl
         +dbMMNzOjmxmcopsU/PrqkGBlw/KobNJAKk5Otsjo6o1jyLrXiv5Q9OizaemP/KsIa/b
         Q8qUE/bKFwbGUM4EBV+IRtGqbqRGti1JRgJlC4ZHTnsWvo0WDRsCgIIaogShwqHRzIEw
         V+qQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYmhisNwvvDaL8AHivU1EqKT+RNA0y+TcD/mGtten1axgUS+6/k2mNxjMwODbdAY8TgMI+02Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMYpwh/AfDYG7kCNHSFywRD3H2yrQMDZwy4TS6Q56/09E1/m6W
	qDle6T38uwsx+QCvoPxS2+nNlZdrHeR6o4ygTVgE0CEbYcEETEEUzB9gJ5Q+YmJS+Mk=
X-Gm-Gg: AfdE7clvj3/PN2EH4GXJJ0SEOMUEAdTLtiI/KqYQBO1hHx8OdWW6MWUMvC6nc01e9m/
	WLgkwxx9vmNPKFW/3ch00bF5mECR6cIwLqUfkLTlq1KNPcfZCe8ByoFPIpn3/Q29pbCxira4u1G
	+nXTV2NzLYe0ZtA6RC40rwTW3dSmaudnxcQDxtnuaO271CxV9V+JZIkwJoXJ0OQD/4DegXsTlJu
	D8q309KxplxFezDWtLLy94okeImcHVzPi3byI3m78RCsGcmeDKkiLHhnX7E/XU7X5mvuzEH3+mI
	R5epdhhIlDjCxEcpcaJ9J2aQ3SV3qqmSijAfEraoTbGxqq1cHg5Vgg9CkKn1XBcsXS3Ed4F2sVU
	eQK3Xzac7Kz1+5Bm1jGFF5I6i3mZR83tcer4MiKjSMEw6oF9GjYykLZItTY64xKpgcNeDxv81AP
	Xxf0/RnxLheE63ECFA6O8+amgIUHTv7T4ujpsuMykYdyj+uL5mpsTcqLqzRpOu2mc2ZIlUxGIXH
	dDFm+VI/8MlmRqo4r0utgPcYrAd8H8dkA==
X-Received: by 2002:a17:903:3904:b0:2c9:c517:d078 with SMTP id d9443c01a7336-2ce9f038f6amr81245505ad.36.1783947014974;
        Mon, 13 Jul 2026 05:50:14 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb76asm101815485ad.12.2026.07.13.05.50.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 05:50:14 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: bound local name logging
Date: Mon, 13 Jul 2026 18:35:08 +0545
Message-ID: <20260713125008.75358-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HCI Read Local Name response contains a fixed 248-byte name. A NUL
terminator is supplied only when the name is shorter than the maximum
length.

btbcm prints the returned name using %s, so a maximum-length controller
name lets the log formatting read past the HCI response buffer.

Use a precision of HCI_MAX_NAME_LENGTH when logging the name.

Fixes: 9bc63ca0904d ("Bluetooth: btbcm: Read the local name in setup stage")
Fixes: 2fcdd562b91b ("Bluetooth: btbcm: Make btbcm_initialize() print local-name on re-init too")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/bluetooth/btbcm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 463d59890bef..499e12169ca3 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -479,7 +479,8 @@ static int btbcm_print_local_name(struct hci_dev *hdev)
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
+	bt_dev_info(hdev, "%.*s", HCI_MAX_NAME_LENGTH,
+		    (char *)(skb->data + 1));
 	kfree_skb(skb);
 
 	return 0;
@@ -766,7 +767,8 @@ int btbcm_setup_apple(struct hci_dev *hdev)
 	/* Read Local Name */
 	skb = btbcm_read_local_name(hdev);
 	if (!IS_ERR(skb)) {
-		bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
+		bt_dev_info(hdev, "%.*s", HCI_MAX_NAME_LENGTH,
+			    (char *)(skb->data + 1));
 		kfree_skb(skb);
 	}
 
-- 
2.51.2

