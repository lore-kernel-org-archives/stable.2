Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E01440643
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753955; cv=none; b=jNmsM1z/QU3JmC7Qf7ihkkjphJ3SPi8n57cLqFYOkNxwQwm2OAn0vY7+S79mknLCtcMQdp/pEgR8iAHap0qshk7CiahS+/NbVEYzLu7s3Fi5v9FLRZGwuC21PFdFY2GsooAMzu9MnG1281nlyP+fZFpB6oUwJLwSQzSlEdycRlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753955; c=relaxed/simple;
	bh=FhB3MzXvMRrT8tN3nejFN13vQ0JrcsHthrfuNz+/Pqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GV3+GUdQph32cxvTUzqOaqg0fvGEqdtXed2jt26NFHpNL/A9eiYgElTYPh9aVuYZwowmKY4SDWq4Vkw8wNybzOhV1sy3dwKsPUqUGptyMz6tdrFxYZCkezUMsujkLjeU0CC8B8FOLEjtg9ubZz1VzMvY0nNS8Vi5+DMCryapE+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/Bnb0Ap; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/Bnb0Ap"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so895582a91.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 10:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789753949; x=1790358749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kxgu93Rsz/WkmkOGG8BARMKb+vTZl3FHpJlkwcMBl3I=;
        b=D/Bnb0AptX9F1ivlBh0LoAvDI/xcCRjTSP/53jUFJtiYhAqEjfaASUMKX4pInBO2Ix
         RtRtLgw4YONzV1QHJEkuCiSLm0nhETLSx1Y3vO/Oj0gxhkcz6W3iEnHXwitxBMWmkE1s
         c44JLb0xR5oeTnzOyE9xxagB0CPQ3sGMsyhMZVyUhTK1OVYUISRH0Jgpcrnd6q6dGMNV
         VOpNX+281mXYB3A3KXJg6iPYW93L4oc87JZPqROPoj+EODklrEcweBYsbPKjarQPwYzC
         94oJqWqopH8JaB5+CRW4T8VzMuWRKrC8nAOC7ypqiWYb2lXL0SvAId7RoSDz1BfLOwAY
         exow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789753949; x=1790358749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kxgu93Rsz/WkmkOGG8BARMKb+vTZl3FHpJlkwcMBl3I=;
        b=xOJ79YMc/angVHeuFMtjT87B/nAQy8yMFW9sO6GTxCPqhaJ1pf5sIunNpFcd5nQQiF
         vRD+3UvNvP9cg+MPsfcXtu0pHMYh7qGEsK1MBNfE+sSzsk9ywZPl7DSg1RURXH21xEVN
         ffiAueGZoTrRzJNbEERTxQnbewlx5wsoYCCBiVKkSP3iwdWq99uUptukIIwzSY3CJ1ia
         +kcn5F+szwuswTW1sxMZB2a7t3vec9FZb5nuzYKM7kXEk74AoOxmXWoZDliuKXnFE0Bc
         tjcwmWXg7TNOiK2Z1AO7hCJQntEZgSDAMx/D0Xn+V9/MXsU1Qh7MVCPsY/e17iao6vre
         H/xw==
X-Forwarded-Encrypted: i=1; AKwUvBxUKMdNiW9wh/iMSIe/oUu3DuYGiN7rDVfTIoWWql947OxXDZlytF/H4WmgkfOLW643rijty4g=@vger.kernel.org
X-Gm-Message-State: AFuF++kgRZqGPoV1/XB8UxDdQFEERTEOf0G+IAIxlZztwSeJfzYAVmm1
	dfS4Sl83OsHmZwI76L9b5kVBnboVHYFs6MY2cE7phJPXKxUeXnrAgCy6fgXUQubBcH0=
X-Gm-Gg: AYBFou0rtL0DqMxRetF5t+Xcy8pW+/VBW6rNIs+Cx/QReiKQbH8+b07Q6QTN/0BsX1F
	P65gEUD7HEfiik6LyttJR75068ponJp2boQ14ElSwMPBkVXAQeq6a6lE4QBbWHL5v+1d6vFXc4F
	nGvLzfD+u7+x/wqSfR4EPvjCsP50J4fmhhDGhmB0rqX/9u5KipfOqbHet9HHt+0XbMOCvT7euaS
	kQ60yszoB6RWzI+a++PSZzw1Q0LcqE6uQe65agyA9K7ezXWRf5Mn+A1X2ieehQWxUZzq9e+caHb
	c5pHk0L9Qfwz2Rpsf9sP/TiwYeZymwbRKgIPOqN2B9H3UUXh+WFJ1oLKqzTahynclebryVJsZO6
	amaNxPy7NLgcBSEw+Ls2i8Dm6nLYTe8cGPHNOeHv5t+7guc1poySBX0Ds+MBgze2Wjj+SHDSju7
	ZfJDmnuoG2UldxH60aQMqDanDei4qVg4Mko9EC7sXWMzsFYpPncBydFMM=
X-Received: by 2002:a17:90b:2b8e:b0:39d:efa9:cd25 with SMTP id 98e67ed59e1d1-39e54c59c74mr12953197a91.2.1789753949341;
        Fri, 18 Sep 2026 10:52:29 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c3145dasm528803a91.4.2026.09.18.10.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:52:28 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: sni_53c710: put SCSI host on remove
Date: Sat, 19 Sep 2026 01:52:18 +0800
Message-ID: <20260918175218.3616645-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snirm710_probe() obtains a SCSI host through NCR_700_detect(). The
probe failure path drops the host reference with scsi_host_put(), but
the normal remove path does not perform the corresponding cleanup.

As a result, the SCSI host reference remains allocated after the
device is removed.

Call scsi_host_put() after all users of the SCSI host have been torn
down to release the reference acquired during probe.

This issue was found by manual code inspection.

Fixes: c27d85f3f3c5 ("[SCSI] SNI RM 53c710 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/sni_53c710.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sni_53c710.c b/drivers/scsi/sni_53c710.c
index b504a2cc5041..7c5b1929a6a7 100644
--- a/drivers/scsi/sni_53c710.c
+++ b/drivers/scsi/sni_53c710.c
@@ -115,6 +115,7 @@ static void snirm710_driver_remove(struct platform_device *dev)
 	free_irq(host->irq, host);
 	iounmap(hostdata->base);
 	kfree(hostdata);
+	scsi_host_put(host);
 }
 
 static struct platform_driver snirm710_driver = {
-- 
2.43.0

