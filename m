Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71655372B5A
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 05:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709211; cv=none; b=e6ioa6M4TyxvN0Xzch8vYdLdROdWp04YAISc2l1I7ubAYCbbfWiEeuFaD7BO73BRKxsSRDff1T908N+KhQZb8kLYXiB2sSM+P9BbBVnS9tdsSrc9UwopFKzGQiTagSgp/FRFXwjJXqsGsOP1/T7xagq/CR1RGBrXxpBXTvxRj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709211; c=relaxed/simple;
	bh=APIgKbxej4lf31CklN2zWuAdmNbzeNaPEvKH6ti1slg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pl0XcKYucLBGOnyFTrtaiHVsMTzAVUgRoVVoW5qo715Ld/UPSfayelssr9RThrV8jmx3ObePnP1YSMluVfq3gPnfx3bm7c6lP0otLbj/fWyyV9Mkp56eQR+oybyROBVF1t7LtZla+vAODNMhpNxspsQexvXA0Lf7pHDySM/mQXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYOCBI2Q; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYOCBI2Q"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc50b9e8a45so138784a12.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 22:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789709210; x=1790314010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k9bbOXpbT7yDHFisaEGsDMS03xBQbY8+Apl0sWLLpxk=;
        b=MYOCBI2QRt0rwlyB/skNe6H3fRl6jFqn5o5jq6j4/4mLuBIZDVLps2CDwSD7XgVtyh
         fRPiFrhFSnSJorhegAiNG1aekhnhdPWeq/FpxM9umpgToQqvlSCqN3wo5KriY0OLKco+
         2bEbv+Gc1K/GRLEs7G8Ef/aofjrD6RKPeV8BfvkmODh6xKNMiIODpHk/Hnh2fzLA0NGd
         vh/xAP6ENddXC6xZsscaJiWLk8DJLW3Z8GY9ki6izX5rJAaj7J83vzD2SuQPkAzH6QlN
         0jjmuwmdOsaJoeH4wDKLN6HnR7/0N8D86bOKQ8v0UHj8HTIshl/2F2Md2hlytsG6myct
         rYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789709210; x=1790314010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k9bbOXpbT7yDHFisaEGsDMS03xBQbY8+Apl0sWLLpxk=;
        b=OXCYXwBYG1G50z+Dmhf10fu1DGVPR3izhueqvx2mXIqu1SvO3s7gasG90ADgDp2+my
         I+r1QQxZM+1ghrNBWkTr69Xf+poTGw0w8Xs4uEZ3T0gs0JroFePrSggoUo+Fb4u0KjTJ
         TfSQFQUtCion6GbCwzacF5rR4eFNaixxfHxXSQq3uxAMhWG2H3t5JVXqt+DHcixsUzwY
         GDIxJn2dwrpUXtez+Gt76rE+AcwUglTslANiuarputlhgf3MSRZ3ZzZnib4IwvUy5PtY
         PtTAYhnFa7DGmYl7gyNYpt5sS5Iiscl/oxt/K0QHERtJx8h1zAtFAMPghawTor82hRY0
         +Vcg==
X-Forwarded-Encrypted: i=1; AKwUvBy1hnkYU6I2g5QYoXHdMDgoooI8zAIENEs0mkDuw1HOppuqKbmKlRQ03qSxK8gpAKPNEiPSsWM=@vger.kernel.org
X-Gm-Message-State: AFuF++mW2biDu6ca/bxx6r8Nxk4YOZtt8XVMwDY2Cq2ousHgLV9uBUOP
	feaW4+3k9wL5fq7ZFHvnJZP5li+2Oo4wXHNR04QOtVdjqmgmkz3hKYGnRly/qg1r
X-Gm-Gg: AYBFou1nuX/jgK+gha8mljQs5khsg/cIW1UIrOpPtattXxrkSQY81tVMEBfaHb3Aife
	ZmqcrFg8dDftGSHwnK4RPXJf9ZAARCLhBhVc7vMEisfj5llMJWIWIksWVMnmj2lzdLYCtlp7GDA
	lhlHzGONMRC+2cRaogXCE4OzMQbFbK8BFyOwgGinEIbbiQB5obsLjlNRSY6dh8q/lSnpnmhx2fl
	3Yg+Z1gf7zoQ79SIfb++bzC4q8VQ6K0dGlQTTXW2P9CnyrGPv8Tew8l7p6DQyIUT8sqq5RM41km
	0npbnGMgKUe3asSC33yJ79sYJpi1qiSOLrWLlU7wraIQjkHoT+0rlt/os/WjsjZ6penwhYhtY70
	h/GS6gSpPmQI/TahIyqOGuBI68Nm6FRb5kg3/aULdjmR+yPh50pFjbMLYkZvia9ueB8VZV9OaKR
	vfIhkrEeerqBpfZ4FROvB+DImEV1NOZr3gR/p4TWhYMS8G3QqdxtEYhg==
X-Received: by 2002:a17:90b:3909:b0:39e:359f:8539 with SMTP id 98e67ed59e1d1-39e54f35cf7mr4830569a91.15.1789709209775;
        Thu, 17 Sep 2026 22:26:49 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e59e4a508sm1304091a91.0.2026.09.17.22.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:26:49 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: bvme6000: put SCSI host on remove
Date: Fri, 18 Sep 2026 13:26:33 +0800
Message-ID: <20260918052633.3555452-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bvme6000_probe() obtains a SCSI host through NCR_700_detect(). The
probe failure path drops the host reference with scsi_host_put(), but
the normal remove path does not perform the corresponding cleanup.

As a result, the SCSI host reference remains allocated after the
driver is removed.

Call scsi_host_put() after the IRQ has been released to drop the host
reference acquired during probe.

This issue was found by manual code inspection.

Fixes: 8276b58af4dd ("[SCSI] 53c700: m68k BVME6000 NCR53C710 SCSI")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/bvme6000_scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/bvme6000_scsi.c b/drivers/scsi/bvme6000_scsi.c
index 23301edf100d..0beb4a2e5a23 100644
--- a/drivers/scsi/bvme6000_scsi.c
+++ b/drivers/scsi/bvme6000_scsi.c
@@ -99,6 +99,7 @@ bvme6000_device_remove(struct platform_device *dev)
 	NCR_700_release(host);
 	kfree(hostdata);
 	free_irq(host->irq, host);
+	scsi_host_put(host);
 }
 
 static struct platform_driver bvme6000_scsi_driver = {
-- 
2.43.0

