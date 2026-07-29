Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8D227280A
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785303989; cv=none; b=QwAlX0Y/uZUBJifJCb4SO4vp2aX1ZX2YK2QHK7JfJ3Ucon/xJNXB3xNnHhHyYSuJ57fZd2MbjV9VIy1uU7kJKQFK6oejRcONI5TeYAW3ynog1SGXyEB/dLBU+TMMIwmmKRTG00lC9hLpF2fhQuxI3k5FnvQau+rOqM6indJl39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785303989; c=relaxed/simple;
	bh=HVaiWdHWc+xF74J816n1HAl1ifPsYvkHezSJeMUW+kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iuTMDCFb3dfXMF59/bGIEDFZ1EvHlhfn7Zeshh6YkVulrHGMlhG0noDoSzkz/7TVdP1MGiVBll9oPVOI/ZvTCoXgy8xgLZiFMVfOfSi5ZKtw2PWaLxhZGQtyrV5U32aTcKZvntGAON7qIYwiTEApn+nHLCWtK8LEYX6/JosmG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=j3dz7Bch; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="j3dz7Bch"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cfff5f88dbso6544355ad.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 22:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785303986; x=1785908786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2OUE4XFPbIApySv4cd9+4/cmn0pHnKsOVRWx7UtEcY=;
        b=j3dz7BchzMx3jECSTV6wrozRajDg8riyxup2iag1/PwXb00ID434B/0LYd4DzEzbZ1
         6wUmHLjKwDS5xn0Qi/TeZnAsm9o/sf6uQVMdb2Q79e8ZzKq9ACZvWIZTW0mfd2gZgd47
         ujamIDab0sL+2oLM9BR7jn+kYbjjvVvFXLn5Q/tG2gi6Jwkc9jKKuvUxItxEzys74h1J
         Vc9PBZgUCbssp8YznK1qfSDSbJyG++N0OOTZgEvR2LvU25pUBqR5Lz+LHtQpscTElcfN
         DaI3bD0PSrpBhNh0p6zBbfI+6zz1IFNe6qAoEIeFhBtcjhtk4dZxZPH6I105oUc45JqB
         /v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785303986; x=1785908786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2OUE4XFPbIApySv4cd9+4/cmn0pHnKsOVRWx7UtEcY=;
        b=AM/kTnqKgSGlcEwBZ9YGIp6aD8LOEx+RO4WESnL01tYWk2eLa4JFEX3tOWqFQyAmF6
         KSbHfs7LPaJQeBQtflcFkz9dFG7XnRNfLFSQYV7cNWKDxrAAi87A7euGgj0U5JMgDsPA
         1VvSC2XAQfsNo9/zChAWKY3R6+yr52lPY+rN9qDmAINKRHDPEwPjs5Dwt8hxloL2Swrn
         aOCM7sa/cK9PctRr3yPRSO+wflCcCStC81PzJMgQp3JCOkZVNv6VDz10Q+QanhdndOY4
         t58yJ5qoieeVaUisgBklkeB5Dsajqz1H2EAV5q3zt3bN+4qqDGPKQxjlhNYtGMFvppoA
         NmAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpw+nRMTAj8eOm8HpSnohAmBhZVTsk4V4upZ50uZyVDaBJKlnMwkZLRrea1FgyisWYgix/A7TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4Vx641lxex6yaMcpvg6ibMAXWv0uwNg3f/SrJIFo/6Y2f1Ae
	NXfHTr6ja9k5bZmy4FVqFdVTP4L5qiis0RjaxQm9kSlz4yD9KfTazNIFKLN86i/Pwec=
X-Gm-Gg: AR+sD12uF7uHNYtnlaGgOqSMWUXnMwAcMkGL9woOiwDwNNqB91yzEerZ47xc4rog/ep
	uBDW0rinr7/49U4tTQ/iSsAiXZ/TQg7gdaDW6W5jU64URTRiBJyoYmQ595rNULQxlVouEy+edJ8
	Mz4NUNtyhVCq2KyDWBu1hcaWU4qfYuJPatvs365sLFgwHQhmyQClSRhzM4SR+mdeGBF2EpB1NZX
	HeW4AwU7YNx0i79VgC9hNmiDr+BiZ1X0FLzp8Bies5S16cQhC4HadRDmIAZdfH4PcQeyceqN+Ni
	pXrxu3+N8cNcq9ueX/GNT2xyefPSohUSNbi9XCS5UwecJ0JKz/p6IsTigMGKJ7GSxNEKYkIm70T
	NxIYtrASKLXzlz5Rg6NCj7mnKeC4aDmttXFHc+VfQH+UWBErs7EcDv7da454c3uN6Sg605zBax5
	fSeVi9HZUn3OeldiWy9bHthKHHcnivpb3/IMiNFZAf9/oP0ELgk5K/2bkPkgiF4lUTRKWNQ8Gjj
	dfOAB4=
X-Received: by 2002:a17:903:2d0:b0:2ca:bb7e:29a7 with SMTP id d9443c01a7336-2d015ec9f0amr61452225ad.41.1785303986436;
        Tue, 28 Jul 2026 22:46:26 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a45979sm5817845ad.18.2026.07.28.22.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 22:46:25 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org,
	Solganik Alexander <sashas@lightbitslabs.com>,
	Roy Shterman <roys@lightbitslabs.com>
Subject: [PATCH] nvme-tcp: fix host memory disclosure on R2T for a read command
Date: Wed, 29 Jul 2026 14:46:02 +0900
Message-ID: <20260729054602.1237120-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_tcp_handle_r2t() does not check the direction of the request the
R2T refers to. A malicious controller can send an R2T for a READ and
the host will answer it: nvme_tcp_setup_h2c_data_pdu() builds the
H2CData header and nvme_tcp_try_send_data() sends the request's data
buffer. That buffer is the READ destination, so its contents go to the
controller.

The command then completes normally and nothing is logged.

Against a test controller that answers every READ with an R2T, a 4096
byte buffered read returned all 4096 bytes, split over two R2Ts. The
pages contained stale kernel data, including an array of struct page
pointers.

Reject an R2T for a request that is not a write.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
c2hdata has the same gap - nvme_tcp_handle_c2h_data() doesn't check
direction either - but a write's iterator is ITER_SOURCE, so
_copy_to_iter() refuses the copy. It does that with WARN_ON_ONCE(),
which a controller can then trigger remotely. That seems like a
separate problem; I haven't looked at it properly yet.

Tested on v7.2-rc5 with a controller that answers every READ with an
R2T. 68 of 68 H2CData PDUs came back with the read buffer before the
patch, none after. Writes larger than the inline capsule size still go
through the normal R2T path.

 drivers/nvme/host/tcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..07cda97ffab6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -745,6 +745,13 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
+	if (unlikely(rq_data_dir(rq) != WRITE)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t for a non-write command\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
 	if (unlikely(!r2t_length)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len is %u, probably a bug...\n",
-- 
2.43.0

