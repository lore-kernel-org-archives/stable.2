Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579634;
	b=cZ5ApoXlJ9Enw3DSbHYUQDvRUOUeGrJPqUdcMo7odCp4ko45ose8w/9HXCmcELoYIlk7
	 ubVWzCVI9/JwaCna6ZviF7KmdZcICuk02+ulUBSE9HwPWSdtsDxj2E6U+AwJTxfmVRl+J
	 HltwgdzNZsL5F4NBiLD5zilMxHBgsRRGckjX5uTnnv5cp1HH8DCuiz+E6ExjXyp77Co30
	 HIOdIHAgOapS7kjPpgx7m5h9Fjtt5FLnk3cv2AbydbLfZxkt+jJD4XsJfpGTG67PEK0Fz
	 H7khQ9b2cc2dflLfIPKsQfAxAbro2MLnzCZmT4s5c1j1dc9Dd+I7rG8txlexrVv9eAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579634;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ncfvzB1bc0eLJbk4Rdy9TYoyW9z1qgFzqy9U8rNq/LM=;
	b=zRlcIJuoBG7vrvIIi+oskRf7p8hAVSzQf6AcbPlRl1Fpldmez5iAN01WY0C9FFi8NO5Y
	 lJ153FQ/9eVKZ4WZeB0f9dUC65Y7AOYx+7LNK2uIlyIifewP6KYauxSX5rxLa5ed2Y9sX
	 uGf/2Aon8WtAok9GMCuHfBjM/5TLo8gi2IO3QdfgOSrOeIA1GKGlJG0NBUXR0YWmONZ1g
	 XS7mbZ+KzwCwXZCRdua90YEuEBepxI1d68MGo4H9bg5b1p+H/3SZyNYitwSm0IiVj6GJX
	 F9qRtFuY7Sle9Z+NF9+r5mA2ISiNp56QFHOLWHVnWXlnXjn+l9NfXRoXAsoMYIPP7xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MizHYavd;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D877606A31A;
	Wed, 21 Oct 2026 10:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D877606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MizHYavd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nc
	fvzB1bc0eLJbk4Rdy9TYoyW9z1qgFzqy9U8rNq/LM=; b=MizHYavdTJPKlakzto
	Xd5MBrWrRhsVlRC6iTnOkpvXxG7hFuoDAD48fJDP6D1iq5gOaL0l5/gpM9qW2SUz
	p+hBBzU9ALckN37ILrL0VIU5kyJL8pwhVIA76HUvxJI/NxFM/fOVsHOrUvZJCD/W
	rl9ssbAlLJZ62845nNjnN+qTs=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXXzcZmNhqXKxSBw--.62283S3;
	Wed, 21 Oct 2026 18:46:51 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] EDAC/versal: reserve space for injection input terminator
Date: Wed, 21 Oct 2026 18:46:47 +0800
Message-Id: <20261021104648.4105938-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021104648.4105938-1-yaojiale02@163.com>
References: <20261021104648.4105938-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDXXzcZmNhqXKxSBw--.62283S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1xGr1rGw1rGry5uFykKrg_yoWDWFg_ua
	ykXFy8WayDtF9Fyw1xCw17ZrWFy3W5Xr1kur1a9FW3GryjqFn5Xr95uF1DZw47urW8GryD
	Kwnag34fGw47GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn92-UUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xv8N2rYmBsZXwAA3I

inject_data_ue_store() caps the copy length at the full buffer size and
then writes a terminating NUL at buf[len]. An input of six bytes or more
therefore writes one byte beyond the stack buffer.

Limit the copied input to one byte less than the buffer size.

Fixes: 83bf24051a60 ("EDAC/versal: Make the bit position of injected errors configurable")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/edac/versal_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 5a43b5d43ca2..917d7d1762aa 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -856,7 +856,7 @@ static ssize_t inject_data_ue_store(struct file *file, const char __user *data,
 	u8 len, ue0, ue1;
 	int i, ret;
 
-	len = min_t(size_t, count, sizeof(buf));
+	len = min_t(size_t, count, sizeof(buf) - 1);
 	if (copy_from_user(buf, data, len))
 		return -EFAULT;
 
-- 
2.34.1

