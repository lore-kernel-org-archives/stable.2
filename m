Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819574;
	b=y1W78t3Bdo191HXHjA0Tv0uXJt/riAnLkCIMNxHZRVCtg24L6EypfTVjxUmWAksVIkjI
	 8cgGrbs5jnLtfw5P6uiATUn1vV1eKaIM6CrIMD3pz36TtuVW7gZ4FB3umBDl8AnV0Re5z
	 pVG2sZNbj93H8AL1X4p1A6qULgBwq+i+qoUW4DMjjajJNccPkYAgtJTYs3zIWUWJf5swo
	 6EYrVbiEzNXFGQ9UPeEn2SQ8uqmTll6Y/dbZWjAGpuVZksvLJkXQHNFUOiSiXcfvp2bMp
	 JNvC+M7MlYbAtKIzQZ3ZhYr0adBkZQHdZKoaJmgfg1fdRiHd4pdygeG3cThaH2LN2Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819574;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=TuAKrzSPoSNlrTFipnvv/aRbBCYjDWWseC2n8/QHZEA=;
	b=JhZqdQHcl4DudCKTz9IKOwu58hdz5CT44DA+mpm0Ddj57jejV0sXuN2RkKkKgLcPZTO8
	 vUgLpKPtgj3vdQ/kBVzyh1wAIj5oQRHf5HR0Y+5FYtV0PAflQudW+KmWlqGr9wm9bCCpS
	 mpY1cf1GZyPltfNqXmsI8A9jTJ3eGNMa0iu4b831jjsnhR5++tD5mdDcwpPa2YrMPQJGi
	 wkPHKT8SOILESf1lFBadjqYVH2UTPZK2PJXD6UK0Hjv2H8GOq5/7laajA9GwV5qq4Hi2V
	 sHm69P/BppWNsaYUC9FF8gSpajuPb1CDamtlnvOxgUZDjzR2okEcohrVMkk2g2Y0VgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=PAPPHrZx;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05FE606A89D;
	Mon, 16 Nov 2026 08:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05FE606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=PAPPHrZx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794819494;
	bh=TuAKrzSPoSNlrTFipnvv/aRbBCYjDWWseC2n8/QHZEA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PAPPHrZxj3CFZ8G9WW3Rw/lFao7MSmCKqwaHL9Q0O1Bi3dsUqqJQWB7CpcMyzss89
	 BRmpBJPoxP3vkin588vEjnk0llV9Wh4eUPPtYGO+P58FcDKhFPkfNzpGdzNW8SgikA
	 COCEIWx5PK6a61NHvXoscNo1ALTQb/ARlSZmKSVM=
X-QQ-mid: esmtpsz21t1794819476t3ef1bb7e
X-QQ-Originating-IP: 12GrB/oDQs91PU3TksRCuKpU/lLXJOa7V+w289pH7NI=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Nov 2026 16:57:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8451285217138424674
EX-QQ-RecipientCnt: 11
From: raoxu <raoxu@uniontech.com>
To: mchehab@kernel.org
Cc: luiz.von.dentz@intel.com,
	pengpeng@iscas.ac.cn,
	hverkuil+cisco@kernel.org,
	pmenzel@molgen.mpg.de,
	brgl@kernel.org,
	lgs201920130244@gmail.com,
	raoxu@uniontech.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: usbtv: Return zero on successful control transfers
Date: Mon, 16 Nov 2026 16:57:52 +0800
Message-ID: <4A73B66B67CF6E2E+20261116085752.2108903-1-raoxu@uniontech.com>
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nr5N425iK0yrHVWnJdGlE+UDSFxClMUk4UF/yL1YTmOxt7NN8984qY0k
	7v+pFm1qz87Olr6EQPvZI6tWvOrFMc0NYy2C0H10V5RbO8TVtSMvPCLxyP2zPZdnEMmOhDv
	zI3xAtJdu4JRKV0bvXYuj9bCZXNuGmhYg6Z8ioUILMsFUIGLLqsnhSOy/reeQ09l00UQLTe
	VaRhR7bHWdGpLZtGKsQzDXEOXu32SHOLEmN4jeQ4s53LUi23ut9HMDOo2S5g1kB0r93WmgB
	3POKfnPPaFiZrREYKUNzZz1Ie+h//3vsADjM/ir+CYYY+S+nNTcaDbIVqr8AdmxGxRsQR74
	eW3cro2jk0Iunxc1+yKX44f1ZkhL3GlPE8r8BWle81mAhadoSgPQK2P58369HHYaUbjvuVZ
	lQp0pdD2yR/sTeg1vSkdjFMXElyzbEvRTCy+hpzvCIYDADMjRHsFMJJkLcpd6nwBtLXNbMD
	nN3j7UNPkc6gSeY1TaRKjyVMj8wHgBU8McnJgcVnTHS1f2WV7VtjZgC2qNsQwNwGLr/3esz
	+B/+IgMNC7peqUxR6d0fupI6JYd2O5hNRxJDAA4loOcygvCIuAHap5tQt71Qsp4l6Cxu37e
	dYCsxTnJhVrBjTt3hOAXXEqUUW4ozPVmU/wTP8ImQH2vPAOKDN8aQ3UgtBbWrgMuDHFL+ND
	MNLNvXUr7lM/OfDXLuEYk0gJ7ZwWe/RXG5erVlmyMwsL914CALbZhluu2nmgr04Z4mR8m5Y
	gcKyku706+y0kveewgDMKTHV122ybrEds0XvK0QSBShAv+VwqZpKnn+gsWxim8unfFjIWkg
	KTxHC3cB7qb/MskBom0ZVEsBICJ2Wqr5TbQBG7EjcZpDJkt/qEf/f2VWv7DNE8xZE2bpbpc
	8qulb2Yz3U3EItSxczDlpyHYtU9cC3YKOI3x1bTxNpl9zaPpfoEDgq7tOVtk3kJb+edDkkz
	yVMAJHDOCR/X2QYzVWskpW1AUS7PJH0Z3vxy2DG32IQ4dpbGbxFKl1WgFIl4APRRezRrZa/
	zp4o8wuMEUgRezprb/XBL8Nxe9oaKVCuwJzWg52Mob8doLuCav
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

usbtv_s_ctrl() returns the byte count from usb_control_msg() after a
successful control write. The supported controls transfer two or three
bytes, so the callback returns a positive value instead of the zero
expected by the V4L2 control core.

As a result, try_or_set_cluster() exits without committing the new
control value to its cached current value. VIDIOC_S_CTRL can therefore
program the hardware while a subsequent VIDIOC_G_CTRL still reports
the previous value.

The positive return also causes v4l2_ctrl_handler_setup() to stop
after the first control, leaving the remaining controls unapplied
when video capture starts.

The regression was introduced by commit 62de7d99dcfe ("[media] usbtv:
don't do DMA on stack"), which moved the USB transfer buffer from the
stack to dynamically allocated memory but inadvertently changed the
success return from zero to the transferred byte count.

Reproduced against the running V4L2 control framework using temporary
video nodes with copies of the usbtv control callback and simulated
successful USB transfers. The results were:

  brightness (448 -> 449):
    original: S_CTRL returned 3, G_CTRL returned 448
    fixed:    S_CTRL returned 0, G_CTRL returned 449

  saturation (512 -> 513):
    original: S_CTRL returned 2, G_CTRL returned 512
    fixed:    S_CTRL returned 0, G_CTRL returned 513

  v4l2_ctrl_handler_setup():
    original: 1 of 5 control callbacks executed
    fixed:    all 5 control callbacks executed

Simulated -EPIPE and -ETIMEDOUT errors continued to propagate without
updating the cached values. The test exercised the real V4L2 control
framework, but USB transfers were simulated; no physical USBTV007
device was available.

Return zero for nonnegative USB transfer results while preserving
negative errors and the existing buffer cleanup.

Fixes: 62de7d99dcfe ("[media] usbtv: don't do DMA on stack")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/media/usb/usbtv/usbtv-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index 2a91af8d1e30..92c745d61367 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -865,7 +865,7 @@ static int usbtv_s_ctrl(struct v4l2_ctrl *ctrl)
 		dev_warn(usbtv->dev, "Failed to submit a control request.\n");
 
 	kfree(data);
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static const struct v4l2_ctrl_ops usbtv_ctrl_ops = {
-- 
2.50.1

