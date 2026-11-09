Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.154.241.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220658;
	b=MhreYdRl48rtHqrxXo2JiSnha+kVx3l7Q9iXbjUs7lcOaSoIOmhj4ZNNSexlJAtpAo70
	 G/HOglDy834pmTytzM/mUWHc7/6DtlDRw8hkx2wEUSHv0S4Wek8eF0GSDHVKwTO12uNCr
	 BEKBOvFBIucGTEql1EUff4dkcjOYAvNOqwpoEs3TUJSS64COVxM/7x3jb9I63kS+bnIpa
	 +Z8Ej60FFr2960ykt90/4l+xjputNn3KWhkSzoZVz1IcYmASnIlEVpKLy2pH78og6nmKU
	 SsfV3W9cVMsBjKjwncduaIQbp3WAyUXo9Qj7aYD5zryu5uYUIhgDZ7MuzcmoSoGZ8bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220658;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Bm-Milter-Handled:
	 X-Bm-Transport-Timestamp;
	bh=DXCdZ0zqW7cyN4edtqpnghY1JVRAIFTb9zduHznDVao=;
	b=XN9z3mQd6ei9Wkp7U6lr0+7kLgBAXe0t7pW/4W9SYQfXrstLQkm2G+50yVPVfwPnu6zx
	 gntp3iXixrnHzVgKeM0UxAIetPBkaMmrnydqiPu1YdDrTLHKJQfkiQWUZ5REocxlCxD/Z
	 Pe6KpMMNV+olvW6PaFbS3jchZC2a24kBx2h0R8NvGBrmdU2SWGi4+f0gMGEizAKSiraag
	 L52YKb8P4C1/6msmbbeQjKbNajAbLWZNtiwlpcka9S1NaA1TfrI0RVn+w8OUeAYzoeFv9
	 xI131AvR4sBjN3GpUuCv6Hhnu24d9/uZdjw2Km13JuTJHd5Ze463AeLzHN77iWFAI9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lauterbach.com;
	spf=pass smtp.mailfrom=lauterbach.com;
	arc=none smtp.remote-ip=62.154.241.218
Received: from bm.lauterbach.com (bm.lauterbach.com [62.154.241.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF8606A31C;
	Mon,  9 Nov 2026 10:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77FF8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lauterbach.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lauterbach.com
Received: from ingpc2.intern.lauterbach.com (unknown [10.2.10.44])
	(Authenticated sender: ingo.rohloff@lauterbach.com)
	by bm.lauterbach.com (Postfix) with ESMTPSA id B58239B52E20;
	Mon, 09 Nov 2026 11:37:27 +0100 (CET)
From: Ingo Rohloff <ingo.rohloff@lauterbach.com>
To: gregkh@linuxfoundation.org
Cc: viro@zeniv.linux.org.uk,
	nkapron@google.com,
	me@samcday.com,
	michael.bommarito@gmail.com,
	linux-usb@vger.kernel.org,
	Ingo Rohloff <ingo.rohloff@lauterbach.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_fs: Fix mmgrab()/mmdrop() balance.
Date: Mon,  9 Nov 2026 11:37:14 +0100
Message-ID: <20261109103714.4000-1-ingo.rohloff@lauterbach.com>
X-Mailer: git-send-email 2.55.0
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
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1794220647799

This fixes commit 5eb5c72c72fe ("USB: gadget: ffs: fix mm lifetime
handling").  The problem is that the previous patch calls mmgrab() for
reads and writes, but it only calls mmdrop() for reads.  So with each
completed async IO write (via an USB IN endpoint) the number of mm_count
increases.

Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
Link: https://lore.kernel.org/r/20260901120908.14386-4-ingo.rohloff@lauterbach.com
Fixes: 5eb5c72c72fe ("USB: gadget: ffs: fix mm lifetime handling")
Cc: stable@vger.kernel.org
---
- Originally posted as patch 3/3 of "usb: gadget: f_fs: cancellation and mm fixes"
  https://lore.kernel.org/r/20260901120908.14386-1-ingo.rohloff@lauterbach.com.
  Resend because rest of the series is still to be discussed.

 drivers/usb/gadget/function/f_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index c64a268e98a4..704cfae49f11 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -884,8 +884,8 @@ static void ffs_user_copy_worker(struct work_struct *work)
 		} else {
 			ret = -EFAULT;
 		}
-		mmdrop(io_data->mm);
 	}
+	mmdrop(io_data->mm);
 
 	io_data->kiocb->ki_complete(io_data->kiocb, ret);
 
-- 
2.55.0

