Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA639FCCC
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790047453; cv=none; b=H0r/InUJEpsb78QkxVYA3APQIJkvirCDZSFri4ZzAeZWAA7trp+QExx7HXWEs9iofZkr4fHT0e6nD7HXpTr8CdV/g/8oR2E/XcfgDDQTUCdHgmfGswRsMQRqaIdZ4qb7Mmd9rKInyAjdPHP5KVO52KOldowo/k2aHbnNjmrOnrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790047453; c=relaxed/simple;
	bh=ncRkxkkeAIbVD1Fahz40xlau2ePXTrC1LaSC/1ZaVZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NxC3FwmwmG3tZgZQvnmBedPBejvm3tj95aKhiXXMGa+CzG5j7eX/hCsH6B4OmSvAJw4785V2IeO/6roA6ZdmFEXskgSq8+OakO1hGzpaMqHj9qJr4a7SOyD1gj0ITU6Jr0qn+VH6GbDSkHEuY/CQNh3dtOJ8IWdZXXLfLbb6AHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=armXNzHc; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="armXNzHc"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76ef19aso38488281cf.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 20:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790047446; x=1790652246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JDp7kCvGQJv7Gj/mubADb200WD9R0dbypDFk/xuiIQw=;
        b=armXNzHchuMt3s6lUUeJUD9lf+AKr1CRTU3NCvj06ezAF054Wg3nEIJiDwPuw817Ok
         7+I+X0WtnPtrwZeGB2Fx9smegxeCS2DmLe95feLbvfZiaKFSSqgpWixfouDQuDc0+6wE
         GCYqO3C4syFsZrCazgk+55BAfqRm/q4ZxXUFUNOKzsLtdgGnW7f8JKvpVUTqyU6/PYXS
         Qsrse8XlJY3o4Ry0+g23PW/Y/OIxPUTbX9+ED4efGOGCYUFVAvB1VeRvs4Ki5lmGL1oG
         1D+F0wRBW7Pc9m/nLMInpoD+aJZbl3iOUCUv5FNqjALVPNV5ww9/KnIUTCGiaCBM8wU7
         +V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790047446; x=1790652246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JDp7kCvGQJv7Gj/mubADb200WD9R0dbypDFk/xuiIQw=;
        b=ZNIn7ft2pMsjtAcSy/PrgxHOJbsKBBPG2nNnn0EyyRtri2kdWqtZ9TNrnYk9d7w8aU
         IqeLLAJob/mJgUfFv1rp2NbvI6FwOWumUwVzjkCJ3DwMVcPksMYsXJi21GsEeWo6LQ2y
         TEcGWHElkrQ1RD/Vl6mSz0Yw4LgOQx3VJ7VTZza5cuV1nhDUJxi0eAT5lTBOUj8qfgwC
         OaAxYfMG+AW1ZZJlyV8YAmTEc/Ep5gHx5PWV18L0QSz2NHLRDI+VqP06UBCQnRNsnY8i
         nqPtl+ybK1roYyFDjnpYJw+JI/g5HEVoZGTsfLOb5D+d5dO2IkwQdbelvqXDcMYbIgiv
         r1lQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+lhAuBn4s8x87wOShvtvEcp4M+8nuCSyNpQtpBxiiSSQbrMPki53xUhv4+nhw1m/fmmyBf/Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lOglluyWUgi3vvKVlJdQkypA/+JdXI4vs7BsMt+13fuC6cDKGK
	5ZCUGfoWjdC/ZElIuQw2JBcIfjds2Pz1t0/qp9ogCqS6bBF3BAr77LI=
X-Gm-Gg: AYBFou0fjZSeTTPXmoEz8oGNBHKDy1NW3sH+M/7pYgZO4MbBRzqrWZYC57JDPYvPx5a
	YUwbfERgdla4q5obZF3FuqtKDg6N4RMsmiLGPQPFlGkUtAOYUV5w293yDXk5NVQxccVSFGyLTrd
	IatJ/RTpGbjces7BlCPHPHFPzO2E/gLwehVPWtU2V/w7bvnuwQQdd9DLEQfhn8OsVmzYOut4+k1
	phFzDWLarSJyoIwGCXxcyQTJunGbM/tN7SEjZP5+yThH66xRxghS1G35mWqD1/fKtSiULWkoSI5
	hfu8x8YkqUxub1wkL2rNDnX5Js6UmvEzV0nec+zubuhZDAk9GgNN0Cw+SgX3EACDSaSzVUnfBB5
	1AAqF0jEbiYlGi5ooLZV+nu6xCR9llGtOromtNC8b7Ad0Bmg98ACZ3uyLZI8rnqJVGA5d+DmPJe
	TEHtrDJ5q3qhgVNrszw7AVGtM3S2y3EV9TwAlyd7oyI806IgqihIn/KNP87Iy0UlZ2V53/JA2Ww
	fXoTlu8T9I0RmTYEYn44HTXL4FLBXylIrzaW5JFLKwzwSwvnwL5JJVjJXnxQp4BfmzR1Hn9uV4+
	FdoLvPPnUSTQFuFe0qE9q/QnXeKSMdYEFX0VcK8=
X-Received: by 2002:ac8:5a86:0:b0:531:d21:5021 with SMTP id d75a77b69052e-532d8d35f7dmr36423011cf.13.1790047446387;
        Mon, 21 Sep 2026 20:24:06 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e196ef4csm2429671cf.28.2026.09.21.20.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 20:24:04 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] usb: mtu3: Prevent dr_work rearm during teardown
Date: Mon, 21 Sep 2026 23:23:59 -0400
Message-ID: <20260922032359.687286-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ssusb_otg_switch_exit() drains otg_sx->dr_work with
cancel_work_sync().  A later queue_work() from ssusb_set_mode()
arms it again.  Callers that outlive the cancel are the role-switch
store, ssusb_id_notifier(), and the manual-DRD debugfs mode file.
The role switch is unregistered on the next line.  The extcon
notifier is devm-managed, and extcon_sync() invokes it after
dropping edev->lock, so unregister is not a barrier.  The mode file
is removed only after ssusb_gadget_exit(), ssusb_host_exit() and
ssusb_rscs_exit().

The late work calls mtu3_stop() or mtu3_start(), writes IPPC
registers and calls pm_runtime_get_sync().  dr_work is embedded in
the devm_kzalloc()ed struct ssusb_mtk.

disable_work_sync() rejects a later queue_work() and drains an item
already pending or running.  Exit does not enable the work again.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 18cfd7b85ced ("usb: mtu3: rebuild role switch flow of extcon")
Cc: stable@vger.kernel.org # 6.10+
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/mtu3/mtu3_dr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index ffa5b9401dad..262922057b13 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -326,6 +326,6 @@ void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
 {
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 
-	cancel_work_sync(&otg_sx->dr_work);
+	disable_work_sync(&otg_sx->dr_work);
 	usb_role_switch_unregister(otg_sx->role_sw);
 }

base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.53.0
