Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AF43CEB8A;
	Fri, 26 Jun 2026 06:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456428; cv=none; b=ITjTZNC1dNY6duVprthauUSWGlmIRPXVDVKhaFNahOO1MuMuEgXfv2a6Kn5pGLQvIFD0D1UgQ3klb1iTYvSeWjcO54mH4Mbukl2PC1SK4lJ1DfPx434pBPUDbb4vbX5Yw/BwFQW2/Q2Bzh9MDtv8RXDQgBg5bVBAnrN6NcxfXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456428; c=relaxed/simple;
	bh=8V37NypHK7R6XvN+Th5Z4WG2AVo1np0/RNX4wWXKg74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFwXZDeAJJvaDVLU2IhhMEKv15ho8UfXMhw5SwUs8muGS0D636JsA3loZ+BvSCy69A94tyOyyPflHvLZdCqWI3E2bXCTygBct98Piqz6zIsaVWohuYqBi6M2dZXobFg7ykMGhsvmKUA3kUW4B/NNJzRaGSiVkbf2PVvdgyOVK54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fEEpb8/1; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="fEEpb8/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782456396;
	bh=tnLnFYCtOzBz6nmdK/bR6bVt53nUxSinAHQUyvhZLsE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fEEpb8/1XCYZVTlSKD21snmG7GduqWjOyQKLlrj6SpfPjxBdz+/F6mcrYMTvgSHD0
	 5gOO8dQFJojJlvqrI+RQjutkT0uquYQ5h/o5yzfQ2mSWZw6im8KMfVF3yHTC1lBiZS
	 6yiVRsY6dIIpyA2ThbLJBlsZvp1bSgRaTarUaiYM=
X-QQ-mid: zesmtpgz3t1782456380tc9da7d66
X-QQ-Originating-IP: DGVO9sqbos913dc5uCpwEpjkfXxzYnQOZ3faqwyBH/E=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 14:46:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10800267307979064095
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: kees@kernel.org,
	raoxu@uniontech.com,
	christophe.jaillet@wanadoo.fr,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_printer: take kref only for successful open
Date: Fri, 26 Jun 2026 14:46:17 +0800
Message-ID: <80295742B820DA9B+20260626064617.4090626-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NQPIPhQO7YRQynSLXVtsX6rkqkJzB8l2hjaK47vtkXt9E7RUw33PZ/b8
	+lOS8r0C8bicHYMTrWYbGc2HAIVnvWpbDlXc7oUaasIWO+97ihdhRzBpunbgWTSx39bbLv5
	1kjy7nr2l/wb4mpCpaPKuv+K1qhV6ejNTfB6cdVfUIZq43vZ+jB4K9TyMCrCuKIvPsPlyxE
	as/+Ew/AAa7t2CVjZ8oTxN5APbNRcFN/gAmKEErZ/mQQsrpQPy6d6fgoEyAWVtbLpc4c38O
	g5zdTCmYfMdEotqT8LKjpns2IshUkULX15Yaz6+JnAWHoP9cv7aGGIJXRSLgN0ICcJtKmTP
	KcylH8yJCpiAiHzPzmsMibOgaVtbVK0DhWt2/RAvhc+gEYcuulhrAmccbpm7luLuEbt4sPC
	AqeV8g2w2u2FCzcmSPlLM1F9Z8uwaZY6kbyrIsc1i3BcfZVYrykEt6l0aPR0qsqoLiHV1sv
	b8uzeU1pcObWsNiYCyhNqaXUR8397qlhnWXVZNayar65DtPM6dpG1nfFUsJWn+2PCz3lsAn
	MiZgBMYA0qZoYBao6poo9mZL7PMzPX8XUG2BuEvUkzO7D8AvBr1Qqxc42OhNqOcvJ6Cvk0Z
	BygAWkFW9S/+jotP30uL7nNGY6Dnn2OcX/I0ARL3ml7QbS5dXJd7+6hzAiDdorQou9MYt85
	oxVCUSDUtKmrZooNxPHVdYDg1bsv3Io3R41N3Eiq/s+o5I5uXPpJXz45m/lVYZ5Xq94J/eM
	+7byO0tB73WzHuLm3n+Jq5/TTuGyjxmJ51jk0n5TBzjDWFXGEGl/RabEjSAxB5trI/pIa31
	2k6KKc6ZQFo3t7w+wnWOyCIQJXNjBw0CGsGGZPtY8hwcK9gLhoFC9+/W1cFx7UjaC10+s0w
	F3NrzluhumAfhtMZUjupAt/okoeS7+WsdX3tCS75Ds3SdGMJjVCqU6Sb4yNPGdim9446Pri
	9tucC4kyK7mEWbb+9RNlJJX3PjxW2iNhWMPyVB2G5zBaWMImQtSBIDr9ZYSUDkoguDcsWxy
	/Dguqaqyg3/7WPijaWdxLFbPEfr/oI1sabflBZS4Rkq0GZ8h/BtYAcX61XCXMHSFuREmx8s
	A==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

printer_open() returns -EBUSY when the character device is already
open, but it increments dev->kref regardless of the return value. VFS
does not call ->release() for a failed open, so every rejected second
open permanently leaks one reference.

Move kref_get() into the successful-open branch.

Fixes: e8d5f92b8d30 ("usb: gadget: function: printer: fix use-after-free in __lock_acquire")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/usb/gadget/function/f_printer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index e4f7828ae75d..837f753d0cae 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -363,12 +363,11 @@ printer_open(struct inode *inode, struct file *fd)
 		ret = 0;
 		/* Change the printer status to show that it's on-line. */
 		dev->printer_status |= PRINTER_SELECTED;
+		kref_get(&dev->kref);
 	}

 	spin_unlock_irqrestore(&dev->lock, flags);

-	kref_get(&dev->kref);
-
 	return ret;
 }

--
2.50.1

