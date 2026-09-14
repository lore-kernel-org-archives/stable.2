Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977047CA77
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395677; cv=none; b=uWX6FMIB/BQ+STeew0rQChfUlqp9u6zmTAvpnK4Bld2P9WFBqnVExiBCCnSN/pR3W2Is7Oz565EH560PCL1NxMMT+/FAoIXEqiY61WxEVY0/hGO1GGQwDZQVSZdlMnw14/phLYEiSplEPdonljfRcAcmNfWKULFg6VNOzuYFc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395677; c=relaxed/simple;
	bh=3534xZWAmWoeNSroRMnp1vkH3F0sWV3lUxcINo30ufE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RFwNoW1zHkFrIHLKjUNma4DVxOjJiAxWSfCM5TGB33e1oSQ7U16udnhA2NWkzL+PbY+awtaHIZWpYZdaL/XWwdbCIoZeedrI2bIdMVDuPa/2hdmTZBax614OYSmnTaSBStXL4sT+GxWRE6n/rdk176o4tC9Cepz+Dgisq9srL3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaOmouQ5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaOmouQ5"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so3307217a91.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789395675; x=1790000475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rbbbFtydZ6bg5SO9oGIYuQ91SLS9B9Wc4jISmGe2uxQ=;
        b=TaOmouQ5kvU8bAqXLvJF33iPMFf68uT3mEBOwT0qRMZHAbAnqipDcpJrSbNTHPzNCR
         CYW8yUcwue6+65tGwG4UvXT87Gd5lnqpr1BvtxWEDwJu9t1c//4ap+4qOk0wEW3cBRSd
         vdVL2WB/H7BhRo7YmQm22rk6h+J7q9newWU1Rmt3faQyu5Q+ReS7+UnupLsoohGbDiiZ
         xEdzfdwuBn2mgXWUBZ6Jt6lUpArt5cjHuqy8ydt/+/4gV1sHYq8tAJ4Ks0TWVHeYkt9h
         zAa3hDpJoXzM1F5EhJoylZQqca6BeQxOTXj++hN/w7pJe+C3vgYcfHEyQ74S7PS2iODt
         zubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395675; x=1790000475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbbbFtydZ6bg5SO9oGIYuQ91SLS9B9Wc4jISmGe2uxQ=;
        b=qvHAbd55vHHR/E+DUNnuu90dgiCFpm8xzVuCJlnh3wvhkXTa/IOulFbc9yBxL0s57/
         /cNh/lUYCOuQEx/pCDFiiPN5QpWP9fWkCKbk8T4yr+rF6gphASNhg1OyZGx1mu8AinVT
         P5S+mbSQ2g8Ad07S8FuibdRL+LBBxr2peZJ5SwIt4tjaat/uZjYz1wHlK+hFf4Myg1Km
         hdIXNVjPECsSEHQ2+Dw9ZWzzugV9IDhvuUswnU5Xw2oOQBkkBZ5p4e3WLDaK7Diy9IAs
         xYkgUti4I7KBy5Fl4JzadT+GYG4Ky20oqeWNf+r+1YBW69XUNXkfjWQ9AL2qAWx66L32
         ljdw==
X-Forwarded-Encrypted: i=1; AKwUvBwc9LozlKGb/vtitZdCr1mmYrUhkcoZWAfaw0iPo/HV+2ATqPlE3TICszHE2LKi6X+QLx7UgOk=@vger.kernel.org
X-Gm-Message-State: AFuF++kLpatRyzTVcxhRHX4NDAqXdsyF38rIR2sLVe8i18u65CCVEhQ9
	JjxPz+AbDSn4NlbMnAm63xkRViJmJz3Xc1z2aIojrRe5RTvjDx3LnEW3N5BREJrB
X-Gm-Gg: AYBFou31y7ANYSmbWEWlJ0pAXBirVnjpTdGmnHlRHG1B2wteHS2ilMTFbZtMkeHprDd
	LquFJ8aCuk71/H6BNAC1BZYoJuXulB2FpngDHdbNV0K7uDL0we0iA67/OKZiEo0I2pBl4k+Ngye
	7F+vJnfNdc3RLV9q4DiFUmxEbXxnKIJPcaPo1P/6WgtbMMBM1oPGQI8MRgKmn9+QJDgdAkvHqWT
	pdBWMiRmah4vkmSVqgWPDB661hNOMzWVMnPeU6aQEXY7dpoXP7v/nEgGQu6zoX61UilNjABSF90
	2hHwfb5d9JtKAHmDj32QBSm0o+zZ3a8OX+3HciWwhAB9L6AjSbiylaf8eb0VZeIQ/N+9Fp+YA3Z
	EDsM6iyEovWed8USZDsonGXyK8iGNdIgGSIZx2wDpDzcbGWgTT/UbPf3BjFj/7GRKgqExKh265S
	91tt4tsjgumblaFGRulWUNg2hdzIAFyIPGvlnDGpR+CgCdgEaQU3H7EA==
X-Received: by 2002:a17:90a:10d6:b0:39d:ec1f:b40a with SMTP id 98e67ed59e1d1-39dec1fe435mr4017399a91.11.1789395675068;
        Mon, 14 Sep 2026 07:21:15 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94744dfdsm22113164a91.0.2026.09.14.07.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:21:14 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Colin Leroy <colin@colino.net>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] macintosh: therm_adt746x: fix memory leak on kthread failure
Date: Mon, 14 Sep 2026 22:21:06 +0800
Message-ID: <20260914142106.1747229-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

probe_thermostat() allocates the thermostat state before creating the
monitoring kthread. If kthread_run() fails with -ENOMEM, the function
returns immediately without freeing the allocated state.

Since probe fails, remove_thermostat() will not be called, so the
allocation is leaked.

Free the thermostat state before returning from the kthread creation
failure path.

This issue was found by manual code inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/macintosh/therm_adt746x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 1ac29a5cd324..60f292a5aa3b 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -557,6 +557,7 @@ static int probe_thermostat(struct i2c_client *client)
 	if (th->thread == ERR_PTR(-ENOMEM)) {
 		printk(KERN_INFO "adt746x: Kthread creation failed\n");
 		th->thread = NULL;
+		kfree(th);
 		return -ENOMEM;
 	}
 
-- 
2.43.0

