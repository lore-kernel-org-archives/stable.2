Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929792;
	b=Q6YZG46L52pIe7H4xck3e0l8VDv8rTJr539Zrg+AR1ZezfNhwbtYYhIJM24RZiLivf3u
	 dfqAFd3ZJLmQw5fefGEu+5hmcTrSWgE+d+3mQIAfQCSj4EkB62oKIi1EHlpeix+NCUNv+
	 XsmYEbQ17HO+ILuTvSdm9cNX9ZIvi669NAsgzOa6FrEiJcSWemMfRr13PHZNhvvzjeWqH
	 62279wVBmJZJzsHvT37jOIdB2CZKnNTwG8GvV/hzM+i/vSAoPDSDnkuq/MtU4LNWJ4K8d
	 ASCu9nR7bvsTnTBSf6swozt3314k91uJgYlPqSDVFSkRNdmdlwa/f8Wxjhv8dEV18AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929792;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NnTn0Ia9l5NUTREGcxxA3UJ00sB7jgz3g4XdKs+soTg=;
	b=Rr6t5o1IeYHm5BREoeNMnWSVT7UUuAuTIfjzM5DEMgoBHu06b/zMoAi7/c0NDwLjUcq5
	 vEOkUdFcdMkidR/+Cq4dccawEPZTYgez0BRXcGpofIvNBeXQj1Twhi/BJDtNyEdpvAIdM
	 aNsJCu8UCChKd+cyG9CMEv+DOStjxxYvFuzBfFwcTHq6AUtWpIxpRQ3FbZieENnb0dU3A
	 +w3RozA5PLuQcFWKf2AWUEeZYabdLzBzhBP9SY1Bk+CsZvclAKaI5/khEY79ARWFLVxWS
	 YNJkF6qAXuqniEtO/pAejPAq3BVLEWxB1NefR1KnTXrO8X0sku+BSc3z984Mg31cSjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=q2+HlJhi;
	arc=none smtp.remote-ip=115.124.28.196
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04BD606D808;
	Fri,  6 Nov 2026 01:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D04BD606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=q2+HlJhi
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793929788; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NnTn0Ia9l5NUTREGcxxA3UJ00sB7jgz3g4XdKs+soTg=;
	b=q2+HlJhiLGBterG9qGa1UJ/xmvWm1SAe/RRF+NAkYUUlgZ355yekUrpBTh+iVNHSrjtPg/RnvQFZj6McEPgLjjr+pbGJ9r3IKX4acErpxII77mXvIO9nkNyNo3SyeKiRe/O2rf/ljDOZodh0m1hw4qWRY6wzkhz03/7IT7l1UYw=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1010723|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00350199-0.000410909-0.996087;FP=3059557656939865650|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jxwwjER_1793929787;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jxwwjER_1793929787 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:49:48 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Jonathan Buzzard <jonathan@buzzard.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] char: toshiba: restrict the SMM device to root
Date: Fri,  6 Nov 2026 09:49:47 +0800
Message-ID: <20261106014947.4128799-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

The toshiba misc device is registered without a .mode member:

static struct miscdevice tosh_device = {
	TOSH_MINOR_DEV,
	"toshiba",
	&tosh_fops
};

misc_devnode() only overrides the default when ->mode is non-zero, so
/dev/toshiba is created with the default 0666: every local user can
open it and issue TOSH_SMM ioctls.

tosh_ioctl() copies caller-supplied SMMRegisters into the CPU and
enters System Management Mode via inb $0xb2. The filter in front of
the call only rejects two HCI selectors (ax 0xff00/0xfe00 with
bx > 0x0069), so every other SMM entry point the BIOS offers, along
with caller-chosen register values, is reachable by unprivileged
userspace.

Give the misc device a mode of 0600 so the node is only usable by
root, which is what a ring -2 firmware interface should require.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
 drivers/char/toshiba.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/toshiba.c b/drivers/char/toshiba.c
index 776abbfd8..bea2643ec 100644
--- a/drivers/char/toshiba.c
+++ b/drivers/char/toshiba.c
@@ -87,9 +87,10 @@ static const struct file_operations tosh_fops = {
 };
 
 static struct miscdevice tosh_device = {
-	TOSH_MINOR_DEV,
-	"toshiba",
-	&tosh_fops
+	.minor	= TOSH_MINOR_DEV,
+	.name	= "toshiba",
+	.fops	= &tosh_fops,
+	.mode	= 0600,
 };
 
 /*
-- 
2.50.1

