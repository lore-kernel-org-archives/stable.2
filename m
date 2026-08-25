Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1EC33065D
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678046; cv=none; b=histf8EXS3UGdX61r4ILInWLqJhqy6h0+Dp4K0kekH7r/lb7kScXp/U9uS9RVSZQ+u4N+qfz6PMkErRLkAajbN4rK2JyznHCSfw6bmLCktoyn4aEdMTemO0788gEcgMbJyMo1AjQYolLLruL9PJtJMDYgIOLoE3DAoxvxcvbJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678046; c=relaxed/simple;
	bh=OpUMRyvqO2TDh2Ehviw+eNrQLEvp9w5X8kjywsJwnKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzdPMRJK13Q2jQG/vhxNv37/C1ytdZjGNqKbuPPDu+193QB7CaqU+n3187nQGgUUgyNm0KRQs/Exsr+YCi5kFbD2jm5H+ldwDpRs2kGaDQHQT8+2G5Ti3nW8O1OoR7NdonOlcHYiq4xo/PaYV9yz7V5kuGsCNtltJ2CAu58ulb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kbmr7+V5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kbmr7+V5"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84874b52eabso115874b3a.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787678044; x=1788282844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zoBAAmieSvGKn/+PaDydAv9C08pg8BuNAhdnqlHhZz4=;
        b=Kbmr7+V5uPLxviMFdv6Pczrh+v/Tl8QWZC3mfX3fc7+QTpL3cYzbSgyQjm4MaEtMdU
         ulVXYQ3XF00guvsbuz8EXG2pbjqLV9rNfUBY4JfK1qzWCnfzN+njoz1BhsPxNMKgvRn2
         dnqOJFdTGGLsVXhqMU9p/9uuY/OJ0xvI9t3vNwEi8roT2IJe1IUudTsqt4+lVXOwUOyQ
         69j4yV9JrJTRUvJB0/TFpS296S3nIH3R32f4dGVWwEfymLj62sG4e46e78jJvzot/Pi/
         wNhLEdmtBtFbRhV5ib6uZ9tRIJcEqoSwPTvGAkes6SMkCmOqPbl7yTnst42a7SZchqWT
         bYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787678044; x=1788282844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zoBAAmieSvGKn/+PaDydAv9C08pg8BuNAhdnqlHhZz4=;
        b=pMfQiKLOP3hRALKX0y3ut/Bmd4E+oNY+PctFtE0heyD3r+Fdma5y3c14ixmmPlQTob
         dJvu5RTDPErtyaiVV31w3hKc1Dzrrna70Pd2FLmu508XrgzkqIFP0/GdS4inXfXDrCOJ
         Oc5JF5xPcUqyeHUyndJNcKFGx0v+qkvrPZyJFzFYrHU8wZgsfd6+KvBpGwAmGlHUPAcj
         +cCIqb8JEWCebA7oOjFlYKxeyHJnOrsLszP+AZ3wk435V/GP0Dj30NgLG88JwswOZBHP
         arVCtJFGh2+VM8RusXSiXFb3+fK2aidoV9VDkGp9k+RmNvTqfd+PJyUL/5AmxAJdV6Cu
         RdFw==
X-Forwarded-Encrypted: i=1; AHgh+RqtoyFPMwGATNuGWvauISnScFMxg8IBNj/3SlhRaaYGYw2O0d+BcBtiP2C+UhbVnsmXofbbVoM=@vger.kernel.org
X-Gm-Message-State: AFuF++n3BGy8+/RIdbQsIJC8iwbY0Lime3cBzSPTH9URMU9P04lADNSC
	MQBebAyYx8Ay1+P7qgS04DoHEAcXJgjiqIa9K1t8aEEbLDWDLXBR6b/6
X-Gm-Gg: AR+sD13aoWEUTxj8mYgtu0UUJD8k/8a0KNSh449RLeL8P0crM2mf3QIBmlZ4COpCvwT
	MBhKAQdEIlyCXPwlJYZ/zBkS8scANBWldnTfxS/ZnqGrWID0DNy3HA6sJ1L5UIKQpK0V0y7GxaD
	wtG5dgJ3objZAlia1rgWw1vCa3x0dPc7kqqNDIUnKYVGl6eo+5btyibW30N34VIgHcNYEYNuxlq
	ZUrVyyAyFDZpvaD0L87xuaao3VC2OHvSzjhJmVM+6PZtk7BODP/FqThqot3OsEm/IJLwdlugJf0
	JmlkPZXozp1s2LO/Z/AaA1nAMWeOdcpkDWLdRP43CHr+/0cBPu0em/D6GWidq668i1QsqzAOY/r
	5WVCRBSWkf7LQKl/FieSBGYBymT8s7GWCpGd7C404zCpvs1B/CRoOks6p+NuWseGuXrGWulXi6T
	pEXAkcm1lKSd7m+UzSrBzD7/WMHnFudy/u9oU1jLwzbgVxm4fV8jkrl1ezytmEE1Ob+eRfuvVIU
	JyCz8PJkw25msJOYuIJneXlzRVQbsoo+A==
X-Received: by 2002:a05:6a21:497:b0:3c0:278c:6a31 with SMTP id adf61e73a8af0-3cd9129966bmr18069644637.11.1787678043727;
        Tue, 25 Aug 2026 10:14:03 -0700 (PDT)
Received: from localhost ([2409:40c4:13d:8046:4d30:e4cc:47a7:83a3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f20095sm664742c88.6.2026.08.25.10.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:14:02 -0700 (PDT)
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: stern@rowland.harvard.edu
Cc: jjy600901@snu.ac.kr,
	brauner@kernel.org,
	eulgyukim@snu.ac.kr,
	gregkh@linuxfoundation.org,
	jack@suse.cz,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mjguzik@gmail.com,
	viro@zeniv.linux.org.uk,
	stable@vger.kernel.org,
	Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Subject: [PATCH v2] USB: gadget: fix NULL pointer dereference in gadget_dev_ioctl()
Date: Tue, 25 Aug 2026 22:43:43 +0530
Message-ID: <20260825171343.459630-1-lovekeshsolanki00@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gadget_dev_ioctl() reads dev->gadget before acquiring dev->lock, but
dev->state is checked after acquiring the lock. Therefore a concurrent
bind can change the device state between these operations, which can
leave ioctl with a stale NULL gadget pointer and causing a NULL pointer 
dereference at gadget->ops->ioctl.

Read dev->gadget while holding dev->lock so that the gadget pointer
and device state are sampled consistently.

Cc: stable@vger.kernel.org
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Link: https://lore.kernel.org/all/20260824113510.1141236-1-jjy600901@snu.ac.kr/
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Link: https://lore.kernel.org/all/20260824113510.1141236-1-jjy600901@snu.ac.kr/
Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
---
Changes in v2:
- Fix Link tag pointing to wrong bug report.
- Remove the unnecessary NULL check.
- Reword commit message as per Alan's review.

 drivers/usb/gadget/legacy/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index d87a8ab51510..12819e8c265d 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1251,10 +1251,11 @@ ep0_poll (struct file *fd, poll_table *wait)
 static long gadget_dev_ioctl (struct file *fd, unsigned code, unsigned long value)
 {
 	struct dev_data		*dev = fd->private_data;
-	struct usb_gadget	*gadget = dev->gadget;
+	struct usb_gadget	*gadget;
 	long ret = -ENOTTY;
 
 	spin_lock_irq(&dev->lock);
+	gadget = dev->gadget;
 	if (dev->state == STATE_DEV_OPENED ||
 			dev->state == STATE_DEV_UNBOUND) {
 		/* Not bound to a UDC */
-- 
2.55.0
