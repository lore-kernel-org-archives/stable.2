Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AAE7E792
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501809; cv=none; b=O2/uS6Hu4k2tNoiOIUTdoJ5E8eYVHyxl/K0Bb7E32Cn/sE4kjKa7SjrASfqLzKTGUxeSpqXEz98eQkNxi3fTiJhbNC7fBtSxx3Zx9GvdaKndZT8IxpiNXQd3RtMTPxNGGUVKklX5c5r3RPkdWhaVAa8Tix/xg3Y0NbN8LnB6fRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501809; c=relaxed/simple;
	bh=6NI3QwbjJNrqY1ljR2xSpQi3wYpJcnR7VxHXvPXCKP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQREmKEFbeTqqxZYzagjpgDu6lh8R6SeY5FWAfVJRyofOtrePzd6vayokTMdV9Z3FKe13bCeXMdta6P4t3Ph+RmP+KlOqTadHLE/7M1IFW//vBu9B6IS53cZUwtuIZvhZFrcWejC0sF+n4rCwo5p1zvPuKDf219hYa+mRNcTuNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVolmzMc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVolmzMc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d560775ca2so21408655ad.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787501807; x=1788106607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zluDwY8DjO8aGSzzRPO06mPMeANVP+JbMeA9IAgqyYs=;
        b=bVolmzMc5JgEPY/eatOFXXKwshBC8CreEWN0enC+qRlcNe6djieOPvRojHvT0WO1NH
         xa8+i917jkshi3EFrMyA5AUQdDL9xEudfsCYINU00OZeqWAv7LsY+AgOBkVXSC/2C3Wk
         3IeLM6D4LVpvLqCW7cN6WvCiJz1+HM8CMQUzqc82FIwX+st9d2STqmJq0yzCICVm94v2
         IyvCVhE2CByejewvokB1F9XejcUJBUSP8m0DdKlXV/CuSbGT+DanvyLRQe1+A6roVPD6
         pHrq+5VAS8OQWxaVj+n3NEEQS8H0Zwj5Swv4o8yoEG3FUIe7zVwZItpy8AQ9g9SPDAlR
         A5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787501807; x=1788106607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zluDwY8DjO8aGSzzRPO06mPMeANVP+JbMeA9IAgqyYs=;
        b=rVjlHEVfKNmdVBZQeiPCrNc9T015VA+TpKK3t4VXgEQJpCo4vK7wwfP4hhUGWkwBDw
         +hvxn3r35/moBxaSULe8uZSF1XCa9TADm1XZQXB3f8lpTt4K3gV95eh8PHpOpYxoIS7o
         pVqI6Nl48LTTVrD/rvkv9oLCN1/SBVOXNdy3MiwToLbuW/yr9qTW4ju+XcOsBffORRwE
         CAwkaO9rfRCnN8+UdL8ayAzwDWQk/UQlXA+4zxFaLNA5hX9JiffLMILgyMI3kjZnZHbP
         I9brgAyX7o0efsArC/FWHvWXMwWBmm7dqZXmGqMaHXCz+Eo5/eUscEnJFqmJZUqdnNhG
         skyw==
X-Forwarded-Encrypted: i=1; AHgh+RrN6bTzQ/XvzlZ7E+83vtJAA59mLM247/lLaNLzdGt2/sA9wYj7ubRAisAmj/UYDNr2/gaXuyc=@vger.kernel.org
X-Gm-Message-State: AFuF++mttLVC6VCVb3m3a1/VPmXYDBgYw6EcQRoDgcAlndraz6OTli+t
	67Te5Q30ydWjEiUYUtlwpB1NAHtD63sNDbHeIC7ecMMPLGmM7urzUBdY
X-Gm-Gg: AR+sD12LKMYNOOw/FxnbOSE8Zec9j4ODxHGhLRVvcue2jGffe92xK12zF6wagLZIS4r
	rWUKtntXY66p8SFT1I7eBe1Z+A5UWsC2SmKpeu9nIOrfKpAy7BCbcUl18v+V1bobBG+4NfsBu8m
	/UILYngtJE9L3814Hx7Ubf8MmG1pgGuGlJaoboS6VJ+vvUfNCu1FWUAOiDiUMvFH7yDzsn2yxCe
	GpoPGJGiv0Ifv0lt0fKsdZ320lPp2/1cAWj2JMqa1zGOS9/pCg6uAkGIxrZ/QK4JHcRo98VUBWs
	t6iyC6V8fJRoIXc5bZuboBIirEcE78jNB6NDyIS54Sj+2VpHDasFGLAQBZJEEyefMTc5X8P3h0t
	c3pkutBbpLMYCCdxGu9lVwtkfN3yOluTqQhDT69waXb7nHFzehgOu1oRon/LLAu0AaOe5QgEGAy
	/HAoN8y2+fUIS1VXrJeLdeDvvQZsiUwhYGCbzbpQp7fZSqWXiaSZivT6X7MGwQ/GScAFzffRHwz
	QwakOiQSygP5uU59p0nJjD7MbZlHi7sJuSMvShOJ8P8W3yHQE89ZP5u5+aDuEFiZ+uh402qAgeH
	TFg8Epv38cP1XaGbS6cLzaYzXlSVaUVBven5zc9bYblbb5TmeJ3+JFAoyF1Ej4L4cW9EgglM2Fv
	tzxY9G3bE+Z9V3WTLhPE5DcrkFktLsf1OsuzwZzo6kg+6X5E=
X-Received: by 2002:a17:903:2ec8:b0:2ca:e62c:9e96 with SMTP id d9443c01a7336-2d670b9ba58mr230601265ad.5.1787501807181;
        Sun, 23 Aug 2026 09:16:47 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d33dcsm22288251eec.18.2026.08.23.09.16.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 09:16:46 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_codec: validate vendor codec count length
Date: Sun, 23 Aug 2026 22:01:38 +0545
Message-ID: <20260823161638.32348-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Read Local Supported Codecs parsers consume the variable-sized
standard codec array before parsing the vendor codec count.  Although the
initial reply-size check includes a vendor count byte in the fixed layout,
it does not guarantee that the byte remains after the standard codec array.

If a controller reply ends immediately after that array, calculating the
vendor codec array size reads vnd_codecs->num beyond the skb data.  Require
the vendor codec header to be present before using its count in both
command variants.

Fixes: 8961987f3f5f ("Bluetooth: Enumerate local supported codec and cache details")
Fixes: 9ae664028a9e ("Bluetooth: Add support for Read Local Supported Codecs V2")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 net/bluetooth/hci_codec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index 5bc5003c387c..99394a3348c7 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -165,6 +165,8 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
 		 + sizeof(std_codecs->num));
 
 	vnd_codecs = (void *)skb->data;
+	if (skb->len < sizeof(*vnd_codecs))
+		goto error;
 
 	/* validate vendor codecs length before accessing */
 	if (skb->len <
@@ -233,6 +235,8 @@ void hci_read_supported_codecs_v2(struct hci_dev *hdev)
 		 + sizeof(std_codecs->num));
 
 	vnd_codecs = (void *)skb->data;
+	if (skb->len < sizeof(*vnd_codecs))
+		goto error;
 
 	/* check for payload data length before accessing */
 	if (skb->len <
-- 
2.50.1
