Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C46E25B0B9;
	Mon, 22 Jun 2026 05:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106012; cv=none; b=aI/J0eZCigFtq/+cDK6fyDsVv8qZCRxdYbN05WJthbZpXAYNUiHOmFeB/uBBFOOvxHoJUeO78Of7JGrAO/G0BKz1RdO/d74oexLp1Ehzv5utec1v3W6gNjXCkAfuIqnZNGTo/Cnq2DQ7RdHcSLqvi5asNstMdDkeW6sPmJDrhLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106012; c=relaxed/simple;
	bh=zkBrmxXDRdlfvvvpT4AGHF7lIy1EPOMJ4eNfxvt8MjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ts0DGWzIcYFokyHrmFKBshDXWQQLrXIrCz34Iz89Vj2U1uEoyLImGZaCNRVffo/I9xPQT9mxH/minjMfoH3YeeqHLvnL5RxEbk7q6ZcOOxn+297LYwd/gx6CSHxMCpKgZPzu9/fn2QTfaYImBljBmJXAbPXvtN1kPDGgcnEykuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bwP1AA//; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bwP1AA//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=m5
	hOQO+g/fQV44xgb0eCTwyiLjaZQvXO2Djl5M5BQZo=; b=bwP1AA//l1bYEDunL+
	t96KBaMpccp/pKBsguS2oIRBkX3aOhUyFGo7OAc/ECn6GXVHX0AYIQ/VPBDnTfam
	Xv/VFlIf7JCpZGhFO5+1xkewAIooIVEPYTETAQ4X9TlpkFGQLBzwSf8mu0qEq3Lo
	8LQWNRz1ycfuSGPwnAwmCLDz0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBnraCExzhqky3rDg--.47924S2;
	Mon, 22 Jun 2026 13:26:30 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: pawell@cadence.com,
	gregkh@linuxfoundation.org,
	peter.chen@nxp.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: cdnsp: fix stream context array leak in cdnsp_alloc_stream_info()
Date: Mon, 22 Jun 2026 13:26:27 +0800
Message-Id: <20260622052627.696373-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBnraCExzhqky3rDg--.47924S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr15KFWrWw1fXF4kJF1DKFg_yoWDurcEkr
	4a9rZ3WF12yr4UJwnYqr9I9rWUKr42vF4kWa1aqr1fGFyUuryrZr1xZr4rXr47Ja15Ar4D
	W3W8tay5urn7JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRGzuXUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7Qa7Kmo4x4YgSwAA3C

cdnsp_alloc_stream_info() allocates stream_info->stream_ctx_array with
cdnsp_alloc_stream_ctx(). If a later stream ring allocation or stream
mapping update fails, the error path frees the allocated stream rings
and stream_rings array, but leaves stream_ctx_array allocated.

Free the stream context array before falling through to the stream_rings
cleanup path.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/usb/cdns3/cdnsp-mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
index a2a1b21f2ef8..880097f1007d 100644
--- a/drivers/usb/cdns3/cdnsp-mem.c
+++ b/drivers/usb/cdns3/cdnsp-mem.c
@@ -631,6 +631,8 @@ int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
 		}
 	}
 
+	cdnsp_free_stream_ctx(pdev, pep);
+
 cleanup_stream_rings:
 	kfree(pep->stream_info.stream_rings);
 
-- 
2.25.1

