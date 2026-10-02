Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8242046F
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974022; cv=none; b=SeSJCAKgUnuG2eBlpNBROlVBg15Cly9tq5c8do2amWY5llx/n9vq4DbbwgsIE7KzXcKwZNJaIrda5Zl7+uisTPYZ18OPmzEOpFf9DtYC2+3PoVKYOAiyL7N52GJkQc5ENJvXWEa8xDe3s4XAjlRk892hbueA5JWqBDMRxJM4J7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974022; c=relaxed/simple;
	bh=b6L8pOpoUYnSO1ee7ph6hu8yoybFfnNKeIpOYsMzaPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G10xsVl+gDZluxzGYC9rPGRVPPIFrefW4sQaPUwiywQuWLtoQQo8JK7x/ltzk4yl9o/jMIeCSmq5pxLpdih87ejcTehJeBGknSI8ozKqaAf9DpLuxqZYqCXZJoFeAg0k1p00+Qe2VN2c4jIYrXlOPZwRZPBvy/e1KyPoNqC435U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Y1SZWDLA; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Y1SZWDLA"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-340f56c44b0so4909eec.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 13:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790974011; x=1791578811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XQAG52tLeZ0GNDhAmphKWmCU33aC81o6qoj3pL6Jx8Y=;
        b=Y1SZWDLA6fSik8wn/yJr32tOoT0P83mciGg17Vy5s2tbiXlVqT1zYBUyS44WLe1JYM
         4ntvJwjVsn9YtWeUbkwuY3KMHuWjBr5jKQbFyc/7ryh1UD1kQX62dbaApbZY2OdEXbjX
         gqKf+J00pAPMEDU2bg5HuwHqkbUHZr6+PN7rSmpFWtXeSGaj1y1SVl/WzPuE8R0GD18H
         /o2lj6x9Op/ZSbIDYSsdDiCWKj/Ek4G3if5cPOPQHZ9OgUaR9X8fUxVw5xoz4KwnKUH9
         28ElmtD5rWnfPzgHhTM0x01ttiXBp/NG5Fuss1I+f9O6B8pCmAnxNGK4FssOVuFCl3JL
         7uDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790974011; x=1791578811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XQAG52tLeZ0GNDhAmphKWmCU33aC81o6qoj3pL6Jx8Y=;
        b=xsh7xJAbqCE6kUQL2TcRndcZ6Gwxl9R8wqA5ab7pr7ZNZ1WhP/rnjHvWgaPwh6WUGa
         /bHiisSbFhyxG62Xai3S4pGV7TfJNPdei0fTr3hkqcMePSlIOKN2NVJIiGkix0PZtu4l
         GInW1jAwXVm9q+LNNiYk+EZWzZWLL5ajVy91eG+G84JLu+iy005COzRZq0fZEhfEKL13
         +QgQGDGsOjc4bQIqGYx17QDkC80e2BS2EeH4p21KfG9jNnjLPOl+B/en1Gqh+rv/xiRw
         KnUmRVGHzMWu8cDVbIS9iMQQr4dvUfZEsLjYMus/6h98oFFUQ+p1KMSAS6snUYUMGs4Z
         Y63Q==
X-Gm-Message-State: AFuF++nbKuE/nqbCCP2U1k+RPj4EI00lnOAdV300RzFu/E8cNxbb7FyP
	r40gnal9psLC/xSuOx1JjpmvP5GjrL0fdN/o+4X6suURaA/NvFfBsQcU9iOCOaCWGqiq5m8xgCm
	D6OhSDu9eEg==
X-Gm-Gg: AYBFou3azoKt4FxULdiWKfNaf61gvTT5WWTcN9FbbXqgGqz/1aMpCTRpNG0AF3lFdjg
	a13XnAYTAYmacOXhtX8dMZ4Mmr658a8yMW1s/ti6U2z/WUj2FQmOoX6CDW0rXFd9PanL8IjMXKQ
	vXapBy3Hcu5D8SbK38N6+WlJyr3et8H/yKGDvf/xtwAFDKtO9RB+mXPPBoXJjZOHRuBcEyPe0F3
	0C0Pk5tDZOaIPzABlogZETeenoXLkYsGyATjl1R6Zu6jf2QG2tiwPEWm/oGGlGaYJP/pGbNgeNK
	i6axI/QXCEVSGlPjY/cNV8H/SZ5npP50gyucJ28HqqiM+xh2HEtDxZFeLZMg5umZUSMkiK+n2gH
	tqXbsdv7VscnK08qlMJatg40eMbvIzUvfHLHhUdFXRCP6a1fncz86BiLu+gz9BUQ1zZHof+e8mo
	A1wncz0s2sW+UdwhVZa6NKeQB6wHKX09LYOKF59kx3Wc68NP3XTTLQjy0EXIYtJMPMo/MZ6HekJ
	VxaJalHwgnV7Tkup53XocIBxCzctBP7i7l7wFj9GQ3M8TGq0p4T+SvJGGIIw4W3TcMLu6E=
X-Received: by 2002:a05:7022:f503:b0:14e:9cd7:92f5 with SMTP id a92af1059eb24-14f5bbfa0fcmr4281433c88.16.1790974010316;
        Fri, 02 Oct 2026 13:46:50 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:a1e3:ffe2:b35a:69a4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f4766f92fsm8317213c88.16.2026.10.02.13.46.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 13:46:49 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1.y] nvme-fabrics: use reserved tag for reg read/write command
Date: Fri,  2 Oct 2026 16:46:45 -0400
Message-ID: <20261002204646.26451-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunguang Xu <chunguang.xu@shopee.com>

[ Upstream commit 7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa ]

In some scenarios, if too many commands are issued by nvme command in
the same time by user tasks, this may exhaust all tags of admin_q. If
a reset (nvme reset or IO timeout) occurs before these commands finish,
reconnect routine may fail to update nvme regs due to insufficient tags,
which will cause kernel hang forever. In order to workaround this issue,
maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
tags. This maybe safe for nvmf:

1. For the disable ctrl path,  we will not issue connect command
2. For the enable ctrl / fw activate path, since connect and reg_xx()
   are called serially.

So the reserved tags may still be enough while reg_xx() use reserved tags.

[ Backport to 6.1.y: used the older BLK_MQ_REQ_RESERVED request flag. ]

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and nvme maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-41082. It reserves a request tag for
controller-register I/O during reconnect and reset.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-41082
Upstream: 7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/nvme/host/fabrics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ffe433c4708941..2d0dace26d8f78 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -153,7 +153,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -199,7 +199,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -244,7 +244,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
-- 
2.39.5

