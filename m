Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243730;
	b=SOSl3Hr6e7GJ/f8gD1U86ZE32+8XZ57OlkNJd9sf/FRGPId9IoSRYcvrM9dg1NCPHoIF
	 eVFfKsFeHWYB0Olvlod8y381Txz1z37CjPbM0u0c0tBXd4tNUNdqWj73bxjEOSB6hL1ns
	 YMSHII1iuthgX8iURf9LtiPGtIbcQlpYGaJh7cZeXXH2OGAXLK6mwGP+i0xTU2U83saa3
	 xzypIhy6iFIc9OqxpV/QC02PHOrsSP6zPwwckkg7cGJr/CoDsQV9o0ylHABJ4BDYeIlAZ
	 wmtf6OkcwSpVANJw8rvgIlEtR+cj2GuuUVCABkxnHkPJFQNQHViBIrY2ElAnDuzu7dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vIlFLNw+m47ftNTJxN6Q3ULvJUFPP52XPh/0+wF0w7c=;
	b=EhI9fqWqEobWvqmOkkjJEjNDte4MyZPNh6z3JRq6rVEaKAt/3qhIlHXLyWek97CMhUuP
	 XE2nihTOc7wPg/JYRywNtKPwX1qXxWx02STD/Lm6yybLYLvqVKPLNmyRhHGCbUzRff9nO
	 nQGiGa8VA/5AYYaieyAbob4b3zCAOoWJnhW9tigDyZfSfc+7qBHW3hkMmb2Ny7MpkX4cW
	 x6WwVDJFXF/IRqncdFau+2KRUmyVXIarJ79c+iKHHlmEGu2sNjri4ysrS4kpNymsBpT6E
	 ngHYoQ0hw7Id+zYkDFghS+O8MlRrzT/2LjeEI7Wdl4Ihz1VHE7gZTRYUXjxtsVQkLTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HgTLzsYq;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FD606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A64FD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HgTLzsYq
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso17592345e9.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793243728; x=1793848528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vIlFLNw+m47ftNTJxN6Q3ULvJUFPP52XPh/0+wF0w7c=;
        b=HgTLzsYqJ0ACAnT11wIKT/gnfZpTvUQScjfZ1A4XwQd8x8jGmHj/L51vUbbz9Fn0AW
         lYSifd8j/HZZrvAYI4OG6INoslA2/Z9lWxZCgmHwcAv8cKAsrWEtG2p5R+lee9WvkSCo
         97/U01mVAepiFLsYwm6Fb5qaXxgF/MC4bh4mHJi79P1l8DBTFexnfIDVY4MnBEgs7bUj
         VcPrMy29hozz1q80y+ULLl/L3I7yDx8KDoPIja+4CS86la3AKNu28ZWn5nbcbj08mzxW
         +QMpN0P/0I994NiP7BIDWhQbPIu0U3e8PGJiQ2mvN/3huybIN1mPYCnHeUEBWd51hyS+
         L46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793243728; x=1793848528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vIlFLNw+m47ftNTJxN6Q3ULvJUFPP52XPh/0+wF0w7c=;
        b=ls2ZdTzZk/jjid/UNMoINyqBEm1Qa1nLm4Pg2x1kI/QLgVo3O/CqSpUMWfuTCbQ2F+
         OkaP7znv/AiWp4eyU33AAEipP2ncg5H1sVbOJYeWnaBvU+jLhhaWSz5xZODBjPW3M1Ss
         rlhQeQ0P4ES7M0WnUmJinoI38fQ9QQ3y9CIw1/lyJbc5YXNN+10eHEB4e2VUn6mku09G
         iN+YDSiaHCuBngpQwVgEzo0mlpl20+j3rJ4gJ7dLnIanIRtUqyotxo+jD2jItfVlPFMP
         bgtplbIoSSK1N5qLpSxrCKZZ3g7BIVCExDrAzMrmZra2mqDC8iSjSlXqbRWkphL6Y8QE
         39Dw==
X-Gm-Message-State: AFq9FYLZXMrMnCe6AFhUdqfU+fjSGwpyVzzg1Wr9Bj79cpur0fonzyON
	F+QjYXWmp7GMJy5HYx8kCUuNbJQ5OLrVCgBc/Ej4DcK4QAKPjDX+KZCw/g+thuf6+ss=
X-Gm-Gg: AYBFou2xG9csx4BS+BeudN/hjctDBXyJ2ckjEG0vopKG8Aklsd9RCG9BsdEPsjh1L5I
	/R7ehVymXyQS2ioz7Dj9oVEUnE4G1lV7/LZmWZn6q+pa122zWL3i43fuGAmye+anIia/iLRf0+Z
	hkK2mWQUjuG7Gn9pV1/eUi8QtXEE0NfbKS4tll4DIY1M3bA6Pf2JBvvehdV12fo4/p1h9XzmTMr
	6LnVhhYBpq0Q7uhBwr3V2UHC2KASksiTteErS+YcK9WVGILziia9jWs2ok4DpAjJh048vTE4DkN
	52kYHx/efVi37k+EZ6rkEYobnqPcka/LN55lLpRbrP/8U2FVFUS86utTe3i9FAyjpyLkt7cpRSP
	uxLjryWFsOo6rwplvi1ALppnYRHYCM/qYLbIjJ08+aiBmaRgnalWQFseBwQIGrhV1rYV2Ri+JGs
	e2AXlOcABjNw2+DuGyhn/0rTojsMfYdcu50GSk6Vra9ls//t+GVDhjZtSGnmb5bB5HpWrLHlHhJ
	CoKM6IFUMm2/qudtQGrWZzQqJWdADGujYBknt8Gx/8k3q5Xz6DTuWzqf2QNLOMucig5rRvFx3GF
	KhR0gDw3FT017svPCBCb1vCkGQGc8dZXBZ8TgO1lF6/iqhWbzA0NTstt8LPyCNPWssTO0WcKQgS
	lFi0Y+iLTg3pgON+P1f1+h/U3nCpA8+sTafAvYqHxvokc4xNP4hLZqeirqFyT9vo/PXjkMbpbFg
	CKapYVOeKXwur/rQ==
X-Received: by 2002:a05:600c:8715:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a967ab1ce3mr94468935e9.33.1793243727833;
        Wed, 28 Oct 2026 20:15:27 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-226-156.77.7.pool.telefonica.de. [77.7.226.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm35478505e9.5.2026.10.28.20.15.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 20:15:27 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 5.10.y] nvme-tcp: fix error codes in nvme_tcp_setup_ctrl()
Date: Thu, 29 Oct 2026 04:13:52 +0100
Message-Id: <20261029031352.56096-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 522af60cb2f8e3658bda1902fb7f200dcf888a5c upstream.

These error paths currently return success but they should return
-EOPNOTSUPP.

Fixes: 73ffcefcfca0 ("nvme-tcp: check sgl supported by target")
Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
[ Karl Mehltretter: Omit the SGL-check hunk because 5.10.y lacks
  73ffcefcfca0 ("nvme-tcp: check sgl supported by target"). ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
The fix is already in 5.15 and newer.

Tested on the 5.10.273 review queue (6aa0165f18f12) in arm64 QEMU,
using a loopback NVMe/TCP target stub reporting icdoff = 1. Without the
fix, the connection write succeeds and deleting the remaining controller
oopses. With the fix, the write fails with -EOPNOTSUPP and no controller
remains in sysfs.

 drivers/nvme/host/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9e1c45d7cc999..6c52e7fc2bf46 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2116,6 +2116,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		return ret;
 
 	if (ctrl->icdoff) {
+		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "icdoff is not supported!\n");
 		goto destroy_admin;
 	}
-- 
2.50.1
