Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96451A14E
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752055; cv=none; b=Ax0fpx1HB73SUFhR9mTnm0jgkqAEH9uJU1eCJxVhnHhodDSjK85FO1E+7D3Mf7INFIRi5ID0g+YySZBQADXR15dbS9LHNT2eYsc7Om0u7HUFB0mMx0CYn47S88czV7NYp7lkbeKfKZh09Y8V6NCkAYAKDRAzupiIdTPW2TlmBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752055; c=relaxed/simple;
	bh=ycTNuNghg1L9HOhDg4vLC91GWhxqeUus56xpeIdOnok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U69rKHqMt84PK+dzZB95Amfs6aYQg9tb8/ogP4XkSo+5QlgJwijGRRB7w/9AX/LxgTVgEUuX+6FGZ+bjmL0TRgHz69dGbng8uwChSZbgJWJFi6aTDgmQtXeYt6UP83VVlMd8KkvMuPsz62o132pYLgdRgLgXX7946lwRW/YB1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in8+y42w; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in8+y42w"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fdc579daso11318405ad.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789752050; x=1790356850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LGeB3qqSMA8aQqCowwE6YHw3Cnq2V7NyQcOr+BMSCUA=;
        b=in8+y42wn7r01a2hjC2vylH+FqkMzv1fhdNaTj7Y/GZGeKJ4aLa8+BkvBqopazpBP1
         uMhLAdMAwuBkKqTHXTWqcSkP3ueT/8z23RSoFO/o6PvDbFJwpEm9LAh1cXcbJpVc3hfR
         U1zQRuZ0dpjWW3swvO+q46XDPLvq5r8i5uLs5EqQJi3ei7dxVpQHe0N5k0hv27qr3yRM
         Jq2uxIBp/zNvzhI9icRXjpdzfQnQ09iMKMB3tgIyrMA5GQAPqJuNa8IGySxx7qfgeg0K
         tHQWe/OA7Xbo6EkKHD4v6uWNA97uyj4vChps1qKMms109yZSOc5uhWDN21/Y10Y04qVR
         bJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752050; x=1790356850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LGeB3qqSMA8aQqCowwE6YHw3Cnq2V7NyQcOr+BMSCUA=;
        b=hXh28Tk1ExYo/1APCJI9oUvmrK1N3hMiFztuJbN9GGJ7FbeCmTXKUhrAmU+hRtnKmg
         G8OhDSbRd6GCFYyoKQjX89ergHDZFnjB5oTPcIkbp6fWbg8380Ki/SjpGNeLb3tnjaLb
         nhw76jM81+OrqPl0LmR2ZbgFm3mHICacccIkal2ET84oTJcn4eqbMzLSNB7UNIgwimQV
         06flVymzFDvt2RTeTekuGuGMZrOEspcg2ztCy3zvRa9Ii5hcF0Gbj6gElKrB9P/WnUAh
         lQiKmOQskuJHjgCcuAXwza09Tph6PcPh11HbMGPn+EcmmjE9D/X7cLaIGcYT0xmfVdi/
         951g==
X-Forwarded-Encrypted: i=1; AKwUvBwnvToR8gmxjDi3lmxjOqLo302Dh6n8dCpsE+8vnLhs9gdXkS8/P/mNeTSGGGokXx2yTKoutXM=@vger.kernel.org
X-Gm-Message-State: AFuF++nvClb8bbrkacqW0qlDFnm49G7SZ300hwg9XOhP5XI9qHSldi49
	zeG8Mh8Vt2DnuZimAk9ec2M7bT21d/kfM0KugxA8XJK16PM8M8TVfHJOrWkwMteK16A=
X-Gm-Gg: AYBFou0jPWJbA/iI6G6jJLpezUGypIDbRQ6hc/GbyfeEkSLIBmRjit5MqveRck9CQgA
	kztjsFXh5dM17d4yE75TsoF5irlUVsjNPapj7RRPjUGZWj+DyihZT/2IYmmI/sVRFwAWLVCbuNz
	l4gKUxeaE4pcSbC+hMM7yV+cAGafdZU1nuhQDlQVMtMTn0xlMzZJHkJAkRW1XrwLsd+mJ5S1suN
	i8dRk9aFI4ALFV3lSVW5UXtNGMkLWJaHnpWj3Bv2msDQTaH7lif8i4gr0LvjwahaXjRXLiusuN6
	9OJndhjw+bJHa2r0ukcP1zFIdpLbsuQFr/i9Pg3n7iqlLawQULdhUzT/fU2DhgMv6Uxm3MIF1BE
	tQrNFaXEnbjf6Yy2Sg8Dvdf6YvRLSttUrfXJX2YPSMIbMLFBseyB4sk8Vt0FbJhlhVp+T4KVdE2
	BVwOxilp9fSeRtGG5kzbJDi/FuksW7kspM8YY4y4xeQQYRopRT4GTQ/Q==
X-Received: by 2002:a17:902:f78d:b0:2dd:c054:1980 with SMTP id d9443c01a7336-2ddc0541d21mr9604945ad.37.1789752049765;
        Fri, 18 Sep 2026 10:20:49 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc18031c5sm26255ad.77.2026.09.18.10.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:20:49 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: mvme16x: put SCSI host on remove
Date: Sat, 19 Sep 2026 01:20:38 +0800
Message-ID: <20260918172038.3594309-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvme16x_probe() obtains a SCSI host through NCR_700_detect(). The
probe failure path drops the host reference with scsi_host_put(), but
the normal remove path does not perform the corresponding cleanup.

As a result, the SCSI host reference remains allocated after the
driver is removed.

Call scsi_host_put() after all users of the SCSI host have been torn
down to release the reference acquired during probe.

This issue was found by manual code inspection.

Fixes: 506c7bbcd9bc ("[SCSI] 53c700: m68k MVME16x NCR53C710 SCSI")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/mvme16x_scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/mvme16x_scsi.c b/drivers/scsi/mvme16x_scsi.c
index f4db93c13986..8191b1e273eb 100644
--- a/drivers/scsi/mvme16x_scsi.c
+++ b/drivers/scsi/mvme16x_scsi.c
@@ -120,6 +120,7 @@ static void mvme16x_device_remove(struct platform_device *dev)
 	NCR_700_release(host);
 	kfree(hostdata);
 	free_irq(host->irq, host);
+	scsi_host_put(host);
 }
 
 static struct platform_driver mvme16x_scsi_driver = {
-- 
2.43.0

