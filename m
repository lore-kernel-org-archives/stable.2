Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675797;
	b=MLkdt0URqLnunmKh+y5fQbnhsLrzGyRbW1MJMy3AJTWFFQyJwQTHbOfjZ2bmaeoteBgo
	 JXsDnKlh5EEeSz9ygA/sMuA9qYqkcGOCsh7ca0qbTvNbLysJV7a1gmM/Z6h2/bP0OeG39
	 FbUIm30AF9AGc1OAPhrhYPTjp4yp0PoXt7XOu+UuqfO9yN/4mVDcXIKK1d67tvTvjq2Fq
	 MRozr/OAywQQEzGRCaGmYP4o+2xFsXiyMkC5UvB9z2P1UkQC+H+KJg1XQXCyihp/1kZ6A
	 qFoGfqVy5IeFX4SjswZP1XG16lwOIM5Cyc3yWEjnKtF97zc4tTw4Jtr/mjF8+zUk8Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bhcOKx3y9myNmTpXc9YX9Stk2q4QfYaHlPOapeiAi1c=;
	b=N3t5wOEpejyOD1sWSylta0Ar1Kr89VjQV0tZsyAHEUe9Ej7htPgVk+JEjbLBFycVvExr
	 PaA1xdSgZm08t+d/M+nirMZxUzGQhDTvE/LCIC799myfp2OOU16T5ct7rE6VV+zxJIuHi
	 5wC6W2Myzzvl17VAQFFUYVSxxZheVyr+fNZmzRuhQqD5Sicc7njWLLPkKY5ZGlhAj1Zgl
	 /VPFOGvLEK0aMNZFCrk5NM6i1b15pV5YCcjAcPa3CpxGKNOLHkbnt7fG4WN7UBlrnmjN2
	 Zj/Ts8yX6gBQ35azo12MD5cxDEvRkA2R6625NCnJkANEH7SUIcMVitCHkFtmEe6z/fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V4OXBO7p;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8CC60A2639
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC8CC60A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V4OXBO7p
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a208d93758so7038725e9.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792675795; x=1793280595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bhcOKx3y9myNmTpXc9YX9Stk2q4QfYaHlPOapeiAi1c=;
        b=V4OXBO7pad/WHmSUYZkbDd374omgJ+uy+HpdU4tytFK/4k5pNmgkn5lIBqOe9svsji
         +hP6G5NNwEydF34EhoOPeAKCNdXyQJCE/s5IsskM6TswBL0CXP8w+RL1fB2jrzF5MPdr
         KW/gyRFF7tlgiUbsStRjnfRhaD3TEOkbBvroLmk9lcWLv/NOl9TXjZHsogQC4cY6x+j2
         L8Rt2YrxZWpD/8hC8x4hWSnKtgqepqts9oSgT8U+DNTBRShni/J6UmUGmxeAx4nXNApI
         HYu8yF+keScZkMqFsQpBcZBjinR+EfIVi75Yca4TZ1Mst0FhFG2A16lPsMOL4iz0NnAq
         JeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792675795; x=1793280595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bhcOKx3y9myNmTpXc9YX9Stk2q4QfYaHlPOapeiAi1c=;
        b=giFgu4GCx30uo7n1hHisOHGd90Hn8H4N/2lfBT+M8PIZ7uQbA0BCjDKYdYF6RN/FXq
         e1LxQC5vhAQbjhIPdNhdRXfbKfNVVr2HbvQIAilqpwqaQJ6oKkSR17uQIQYi1q6CrGdm
         pBX9vrCNiF8DMvNFk1zeEymfDkNj9CbuUeRPU6hFWYrPEVqZXZZS9ngqdF3+8S2NLZM0
         hDQx1aq1D47VZVLBiyJ+RTSSsbU1gPzBwkmzVpu78qYj2AyziukW8WsLDy4TQQaTPml5
         /AUGBzgDjDqcQrJ5ZIMLzMHWHBth1w/ADzbroTh1Y22PKVLCoMKGc3l6I5s3EN8e9t4R
         UG2A==
X-Forwarded-Encrypted: i=1; AKwUvBz2h9fKkMEQg3CEpOCRj+pfQz0krCVK/QovLn8ceg+WX0OO9SV3b/CNq8gQ+vJgE1iyvmh8HTg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlTXR4N6c59MGFEkqYXGNlcnnmKQ6Bm2GYpmPmsIfZC94T5Te0
	rsRQmM2N3xJl1p1x13G6Et8a5UYagWjUTWrN4fU4IJMbi94gkNlZWPB2
X-Gm-Gg: AYBFou3shmI3BvX+5j8e6iNN+P0GNmp0cjovHZDaMB+tVSqTCaOJ0UcyiiGpWY94lFH
	iiBupZRdClX6/pGTaGFZYD38cuLBcpantAccSWGy1dnWf+qlYOpVxhWOlIxMeVq0S8w1g1hmh5f
	JgqwZqW8+YN7Oyi67cX9DnebgYw1PAAdrfxMsLK7zwkqkbGFpNwR8rGd4RTuNSIVPNYwjzDSDNS
	ab1tDuxbf/urC42T1J0N3iltfTtpZnINiAj8bE/ocHN/Mv26+mvrVcj9w+qp8yllnOJcSEmjVp+
	2jQRDTm4jBFTwzROlQhHA6lqpJ/q+e6MIwaPYifgDcfnQ4mg6eRdUml9JrPxJkt+XMWsiJIUBJU
	eAdU2ok6S1emrLmgwFKRo032Vss1hevrFj4/3Hw7hLWkowb9UUx4hP4Uy6wMrDJSrucYxNXfwyx
	l0JrJewsigIPtqdVsaSFslY26W1dVtT5qzdWvmErJ57+EYRUcplinvRiJubaCO8KUjAudq49lyn
	gNOVZ5cuN+V5CGGbfFLKUtkz08MgyRx7Y+BjID7qeJDXIdguoGIDQfKeoPP9RoRoqjS4C0BcMe3
	dLVhkFtx4dk2hFIC9EzwN+khDJBnKsBK42ioP0qkabHMUw==
X-Received: by 2002:a05:600c:3b17:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a1fdd31aebmr113093645e9.16.1792675794933;
        Thu, 22 Oct 2026 06:29:54 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd629bbsm108832715e9.5.2026.10.22.06.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:29:53 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] nvmet: pci-epf: report transport errors in command completions
Date: Thu, 22 Oct 2026 15:29:32 +0200
Message-ID: <20261022132934.3592924-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022132934.3592924-1-parri.andrea@gmail.com>
References: <20261022132934.3592924-1-parri.andrea@gmail.com>
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

When the PCI endpoint target fails a command itself, the host receives a
successful completion. This happens for a data length above MDTS,
malformed PRPs or SGLs, a buffer allocation failure, an SQ that is not
live, and a failed DMA of the command data. A write whose data cannot be
fetched from the host is thus reported as written, though nothing was
executed.

Each of these paths sets iod->status and calls
nvmet_pci_epf_complete_iod(), which then reloads iod->status from
iod->cqe.status. The nvmet core only fills that field when it completes
the request, which these paths never do, so it is still zero and
nvmet_pci_epf_cq_work() posts a success status to the host.

Drop the reload. Every path already sets iod->status before completion:
nvmet_pci_epf_queue_response() copies it from the request's CQE, and
the transport error paths set it themselves.

Found by code inspection.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/nvme/target/pci-epf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 9c28367435a59..099e8766f6d40 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1149,7 +1149,6 @@ static void nvmet_pci_epf_complete_iod(struct nvmet_pci_epf_iod *iod)
 	unsigned long flags;
 
 	/* Print an error message for failed commands, except AENs. */
-	iod->status = le16_to_cpu(iod->cqe.status) >> 1;
 	if (iod->status && iod->cmd.common.opcode != nvme_admin_async_event)
 		dev_err(iod->ctrl->dev,
 			"CQ[%d]: Command %s (0x%x) status 0x%0x\n",
-- 
2.53.0

