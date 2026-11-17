Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908246;
	b=zKuLFYKLSBkcXb1pof4l3rBUXxqNdBr184q2eMdtlBfrawv1rU8NLWdJZxoS2OlZ7SXZ
	 dFTKtLaH2ZUZPYPMVLiVk0lhZamgFSHNt/neLHkxRv5ZVcsHv1XPdmuEHGunSuJBdUQBQ
	 nDK5JeqaeGvx0oia+gCA0Q3K0JqMKBLmg5Q6hOvcpKhKv5guRQwdfOVtZkU/DKOL19Tt/
	 v/opPXl2ZcYqDI3YZ1ricsoEOod2f31/1lFPSFWp98ehnyv2K9peNCv5IZIrI/Bc9YZsO
	 IPQiMLAzQ2ylWUbECHfwrbRiySFxd/T4RvgY35cnltiacDnbMk+nEqpQOkZHo77QNBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OFzWKIpfqvHsogWlMHgoDk6JLusnQb0ygt1RW9vKSgw=;
	b=nxG8dZ96ou2br9v33LHy0C8VSw6GzK4b0980nx6f4GWka9Y214s7oSjkR6QN3INKOnj0
	 qYo1biH22qe5Zt9ziCJSjNGT7VhyjGVhEUaALCxxYglEamJ8ZvWiUCEhDT+xzMH2BuXst
	 pOQHff6MYmXrrkcRTEA3kPN9QG6/ntSlGFxrjX48HE7NzlZCGHzhqSzapZ0PewS/oo2yi
	 k2GMu5pBOQnFCp72j8ILr1NAGpWqiHCU6To1sO80Kxd9W7ygjFl9LnBx5hTTdsb57PK57
	 mMVJIujPTlwHT+TuuA4EQz5xHyqZpQzYQPm3kWY5YXyVkqWQIRx/n35yfyDzy3zKiSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ket+7AUd;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA8606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94CA8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ket+7AUd
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso1992176b3a.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794908245; x=1795513045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OFzWKIpfqvHsogWlMHgoDk6JLusnQb0ygt1RW9vKSgw=;
        b=Ket+7AUdfnXGpxqEyOMcN0ibsbMUl850mzNv13fsw9jkNT0qV7qFKg6L+QznPksHGO
         EgzcFuXKWMQcE0zBKXbpjyYBZ/uNetOVouaWgJQdv610bFV2MWf1Yj0+sYdjY/FkvRZo
         D/jOQLl69uvTKIJtD4Sha4Rqv2yYrRo6oK9BOUXC9weEShuQqYGO7JveBntb5vd55VTF
         dFhh53mkuhhktS0ax9hMNl/Dr8kgOWm1SFGkOXBmbdtG/n4pxVyvIgI+maFQhTlclUq/
         rGDyc6SRSeLRc2082Hvgr2b8z3ix1qcKjdkARPKHfTzr2B6U67r1KY8cX504LQVo7EkL
         CoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794908245; x=1795513045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OFzWKIpfqvHsogWlMHgoDk6JLusnQb0ygt1RW9vKSgw=;
        b=Y65WDbtodCEVq6lF47zY6aEspr0w5FpgQust8wNJ7D1jb2rC/wW0tM+mmHH3v2G3YM
         zj7L51+G0YK7evLiHhtB5W32NlLBr0DQiAhBH8dlvviOsQbv7iEPhBiIgwZ+Iu4LbLC0
         EAZT5pHiU8r0vMnXo8g/+MU06TZFcA39ptd2v3bk0sPQ1hxdejaJLuRKFzU1G8XLPnex
         8aD0euO4DTw6Dsw9eC2RzOHHAH3uegA01pGGANSDJcDhESrbfk6mJbDZmOMJ1g4nbVwF
         z9GQpuc3Pg1eoI1/2Ej3y8eeqzLUQWmIgdiHdRMLxluvxgyKMAKSaJjcY527P8eVw6E+
         i6rw==
X-Forwarded-Encrypted: i=1; AL+hErEARwDnLj/j19oOpoY+cxAi8HumRIhnTRYavZoKBWfRAcZaYRnVO5i+W2u91y+yKY7lAIrw6Bk=@vger.kernel.org
X-Gm-Message-State: APuU4Z85QWWp03Aj/oQJVmMam2l20hW8s28AmRTz4VEePSKMVftq4zjT
	TthfIrt/+s7binjUvFnQwjmCeoqtpfpZMgFY2/wky6miEGT7RgBIwGlt
X-Gm-Gg: AYBFou1pa522efHt+x/fb6Ge1i2tVvn4Lv80Win0E/llx0VECJ2cqqA107zkIB1K3aA
	AKc6crcOst1MBinR9BOuNdyenoDzgh5IJ3ImQckTFCtKWnm8SbgP0mp1YBeoLAvht0GDfzrxQz6
	nxF63iPTvYs/MRBvorfsKAt7qpnzgv84IcZMD54sSoHc4AIyZOxadkDmzjeSPkA0zeb6buZ3Bjc
	lZ0N9IiahBmPQXtoRo/6isCRPas4LyVhT1YWBSF372u5dAWjQRttEchtHOHIcqbfi1Q9Xm9ira3
	giZTS1GjURerC901JM2B/kAbuuVmMw2XpdVVefECgezpQLMdyoF6FuJo4+AYo0yDL31OA09UKKi
	uk3zqZ8socJLBhADomYS7AKVSWDq+J8q3MMnpMuE8ClDyz9fSn+3IrLwKFyPI4PjVb4PtZQBtWc
	mHq9SxG/lkWJrlvzwE312fWq7Htsh4Bk1MqAMu6koJTth/8KzH45tHwbOrR+dwcGgUX+FF71qFh
	nuo0aRGfT504oXDeFcIhIMQ3ostKL6lKXOwWESOS83UBdv/9KBhAPrDn3ShWKKIyhBO4awqNRvO
	gjugis8b2YzyxLRI62pfZa1e+Td2jjASG8Mq5hKQRMFuE3Hq
X-Received: by 2002:a05:6a00:1995:b0:89d:29fb:b5e7 with SMTP id d2e1a72fcca58-8beb5da5bf5mr12558126b3a.24.1794908244905;
        Tue, 17 Nov 2026 01:37:24 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2b190bfsm4804882b3a.50.2026.11.17.01.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:37:24 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Scott Branden <scott.branden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] misc: bcm-vk: bound plane descriptors against the message buffer
Date: Tue, 17 Nov 2026 18:37:12 +0900
Message-ID: <20261117093712.185359-1-hj351016@gmail.com>
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

In bcm_vk_write(), a VK_FID_TRANS_BUF message embeds an array of
num_planes struct _vk_data descriptors at the end of the message.  Their
start is computed as:

	data = (struct _vk_data *)&entry->to_v_msg[msg_size + 1];
	data -= num_planes;

num_planes (0..15) comes from the message cmd field and msg_size (a u8)
from the size field; both are fully controlled by user space and are only
checked with 'msg_size > to_v_blks'.  Nothing verifies that the plane
count is consistent with the message size, so a crafted message (for
example size 0 with a non-zero plane count) makes 'data' underflow below
the copied buffer.  bcm_vk_sg_alloc() then reads num_planes descriptors
from out-of-bounds memory and interprets them as DMA addresses/sizes.

Reject any message whose descriptor range does not fall entirely within
the buffer copied from user space.

Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/misc/bcm-vk/bcm_vk_msg.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index 17114092a284..e0d57f99a569 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -1192,6 +1192,21 @@ ssize_t bcm_vk_write(struct file *p_file,
 		/* Now back up to the start of the pointers */
 		data -= num_planes;
 
+		/*
+		 * 'data' and the num_planes descriptors that follow must lie
+		 * within the message buffer copied from user space.  A crafted
+		 * message with a plane count inconsistent with its size (e.g.
+		 * size 0 with a non-zero plane count) makes 'data' underflow
+		 * below the buffer (or run past its end), leading to an
+		 * out-of-bounds read in bcm_vk_sg_alloc().
+		 */
+		if ((void *)data < (void *)&entry->to_v_msg[0] ||
+		    (void *)(data + num_planes) >
+		    (void *)&entry->to_v_msg[entry->to_v_blks]) {
+			rc = -EINVAL;
+			goto write_free_msgid;
+		}
+
 		/* Convert user addresses to DMA SG List */
 		rc = bcm_vk_sg_alloc(dev, entry->dma, dir, data, num_planes);
 		if (rc)
-- 
2.43.0

