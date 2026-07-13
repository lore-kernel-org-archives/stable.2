Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D897EACD;
	Mon, 13 Jul 2026 05:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921507; cv=none; b=I/I2ZrIMQrE68YaODy0p/mkwqOckdtDx/sisBwkK8gZJdtDhjIN1kg+qGlbdEcm0Km/LD3a8piaFULDKkRWTBWUhVXGrwk2wLwifS7gzUiiv+lIhDBxlgFb2azuVkrJD9PFtWtiXptuWgcKex/H91n6UNtKKPWUTdojpHHgMVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921507; c=relaxed/simple;
	bh=hT+Ooj9tgT1KwwQdt8RCridwYA1wzetFZZJ1WarZjWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxksnCRBmuKaaZvUZ1cgO4wSIM48+5rRE5WwebtkxpSCVSOmEUGihskgKoofdf5AAOV80Wm3PSlCL1fwARdQOUyeQSZcP1X631mHuR0W357GgAcd5HRq30vl/rOyLvGQ0+sJaJ+iWtpT8qbMmUNYtTXGINNR20MrRfognXCfogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MGvdVaiT; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MGvdVaiT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783921452;
	bh=xsMiDfHY3No78dLfmPMb1cw+NhSYORJVBK/d0sBYa00=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=MGvdVaiTK1Iz1CIrw/B0DDi2BHd+r4uL69ZkxCQcJr4oQDUH/rGIpYa/O68Yg/5NQ
	 8nkhjA5fLianwRHboTsE0foktSA5fgmyjrk08fggXfk5wVbmMuybWk/sKftwbpuJnK
	 XZIV6YjrEltkcdODmJTIV4bEKqOvVbOuzBTF0Ql4=
X-QQ-mid: esmtpgz15t1783921433tee904caf
X-QQ-Originating-IP: KGIqFQ6ZwelBHVBQsdz3AWi16EJ0V4fs0KzB/tMla+U=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jul 2026 13:43:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2535388820443823587
EX-QQ-RecipientCnt: 9
From: raoxu <raoxu@uniontech.com>
To: srini@kernel.org
Cc: amahesh@qti.qualcomm.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] misc: fastrpc: drop channel context ref on failed open
Date: Mon, 13 Jul 2026 13:43:50 +0800
Message-ID: <DD9C99F155919095+20260713054350.3170620-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MmIUUz9KGMMdf7ciTnOWCYhgf7Ab6BzS799SOmRs2PXr/GhaMIgUyO/V
	iGzT0/+4dp0z/PtrYJq/h2AujJ9XnJ9j+ejjlUlzR3k3DFXGNDerH+3j8SIhNzBmCsrAe1S
	3HDBB+ia32mplRtxOLJMH1cUUoxcNhaBZfF9zMeXV2ZFCQvEzkDFf2xekbaJHY2/iZh/H6N
	k9CO1DgQ8BBPUbgcN9oKN0guH8hACxaHN98mT7B2c69yw+Dtn8ZhsSLPCysF8HXrnI6iwfd
	+Dd20yPUZK96l55JoL5u4hdntdE421JIG7bMGkKGNVRE4l7ERYWZy4C2pc3VlylT6pawIYz
	uPwowy165LZ6K8mp7UbgvfSaGjA7rv6UUHGi3kOsPnVaHa0mGwDsiKNQKV4ETIfHsz5F+Pg
	t14TrPbNnAQk/Lct130ilnTJWbOw8mji0dpQ1ofkfkAY6k9ylbInO5FYwf1TecAdgcn5zjs
	/9uvgSYZen0xcSZ5e2KcFzJV8HbGLaNehqz6wOiaxSevGUkgbDdb2V6DN8HcA2tLxLxwO2c
	rgrJtsEkZrsL0bcEjPNXUCrZe4ctor6QvGr9yRVxp4Hd9S7nQvH3jLHDsLsKdIA7KkiM11Q
	56dHDYM7n6V8YxZ30ZwOzLuqPnT992NJ9Cal72Q8RZSJQad2d9lQMRwULYSVCpn6NQP6EoN
	1BFTONrJvaebjXNxiKSr2ItlFRwrM9RznnYoq3zh3VGB523TrTDhu4LqqsROB7IkacNpDmH
	T7vbeK5PioQCv1ZJ7MSQ4J+Gx1wBDXmbhFrJolJmZjlPIx/2edHB5SFOPJzL4fa7kvtZhUk
	1C6D89s/jGEBWpgFgSnhoKRQ6GZxoQJ5SX4WSmWCoUCCJByzL3UiS/qVQ3+F3k8zv1oSVqc
	suzMzY4GMXkwQU5e2FBhkccgABcmEDNb6HUcoHU885LN5N/WNVKH+HKl5xTEguhan3hk82T
	HMg0JhKaUDsWMFwOABmuDDP18gQlBNEh9ZM5jkTpp1tKGWiKguidY97HVqN0Fa6bzILeCK7
	86WSzU9MJ06I8mvSlQKCrzCU/PLQcsHSMvKPEP1NvqJi+SdKAIkkN1wmxannqCagXTLTyi4
	A==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

fastrpc_device_open() takes a reference on the channel context before it
allocates a session.  On a successful open, that reference is tied to the
fastrpc_user object and is released from fastrpc_user_free(), which is
reached through fastrpc_device_release().

If fastrpc_session_alloc() fails because no valid session is available,
open returns -EBUSY before the user refcount is initialized and before
release can run.  The channel-context reference taken earlier in open is
therefore left behind.  Repeated opens while the session pool is
exhausted can permanently pin the channel context and prevent the rpmsg
remove path from freeing it.

Drop the channel-context reference on this failed-open path before
freeing the partially initialized fastrpc_user.

Fixes: 278d56f970ae ("misc: fastrpc: Reference count channel context")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f3a49384586d..907a87d7ca56 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1671,6 +1671,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	fl->sctx = fastrpc_session_alloc(fl);
 	if (!fl->sctx) {
 		dev_err(&cctx->rpdev->dev, "No session available\n");
+		fastrpc_channel_ctx_put(cctx);
 		mutex_destroy(&fl->mutex);
 		kfree(fl);

--
2.50.1

