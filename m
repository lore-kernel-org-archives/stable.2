Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311070;
	b=d2kj3CsUNVpSqqEBNGIuU1vxgjrQNlhlRldbHBEShTH2gImF7UCfY5GQYDjzzhA8/UIk
	 ibrxczB9zK/K4znJeHt1Brui5+gpE+b3GkCQM/59LopxYdXjFV8fCdPZ3W6RmPU9Yh5Mf
	 FUnrKDz20K8bubpClu2gqpDg9dMKNddBOJrr06cyMqS9wNMveb3Fvh/OIEe7Zh4wFsKZ7
	 L6qgojZ0j35h8P41PnO7MNKsgwQjl5Oz3VKiP3fA+uDTuW0te1OapLV8cwbOCnnDcgZpr
	 +Z2Fh4lEGuFouNu4zQyEbjCBCRG1txJBWEm4CNLtaVB+Sbz0M+kzm58u5ZEg/UA5tfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311070;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=P2A9YuqVRwZG5vPvb90/8FnAEKZY4a8UvPrcVp6QTk8=;
	b=xQj/u5v0f5L6uoJW8A7iqaptwuZQ1rir8DaCFO5YOQBtLaPfYdBBmYJ9rlEf2hz+fEDA
	 vwW7rgACTiz7QnWCxC02KNc7kYkHC4p25N0Cjylj/LZPCJMTevc1eVTmgySdMXr7Y7mHc
	 ouippf7iAwRjVjoNARg6nX9IcZ0os7yMVi9fA4GcpHq8W7RBYsUhyUEEd9MdrBjzmxngV
	 ekYBX1tOnPW758ZcdKFvz8U+30K6ldAmUQpAGHgDzWfIgWlIKwVL6E+7G+mJ4cpIxKzd1
	 u1f8bcjCJZJRn3yknnxDFMz5a0AlfHC5W7TA6Qu8LnNyyi3BDzs7Z6O072lw17VEKPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Z4iuHNtz;
	arc=none smtp.remote-ip=209.85.214.227
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47348606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47348606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Z4iuHNtz
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2e987a2ba0cso545625ad.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311069; x=1793915869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P2A9YuqVRwZG5vPvb90/8FnAEKZY4a8UvPrcVp6QTk8=;
        b=LAscMEiIRFpSnaDDBc0Xjd5FVWlbmdHOlwy2wHwNLXd6jBVsVdF8RITwB/Bx3tEJb/
         ECEowRE68MhVRvi3OvR+Q1iIZs+91vuXwxIZ1x1qGNEWnJbbZkcGQJ4kP18pLJ+LFT2D
         DE8Uax6CnKg+MhQSOinl1EKWFpGgvr/5PfysStPYTdhxUcA/puCeMTfckVIr5rKHtntS
         Gb8Yb140CMbqsZ3+BU8lKNswl9242MD9/nj8OxMEkTUZee3Fj87jrbImyk0NuaaS7udk
         P2BQ17x9ArI8DEkGEkC11c+KOtuKHzHC59I3HzFSsjjx/XVN6TlsnQbQoLuijgMrN/eS
         SeJQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3AhcC5xUydsbK/0nvH10cgoU+uEQGWiYssBkgFTbLa8q048pjdAfWa8ewVgYq9Y3eMiXkDSs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeLFhfRWpJuJeo0OEcJc+0MwA/bn0S6BduaNXeLEL+7F2qFWYo
	Ny1CjzGumCiJubLrW9HvL6DYrVSeJ95hKgPNdW8a6foPvtStwYoFdqccJ1xiUlkA7H4Euf8tPK2
	r7tHsYf4W9Bj+fJNIFfwuOOxAzpHMux1hMSNLKI4eEtxIHP/+NPiO79w50H5/WGb7+0E9sL/kdZ
	19wx08n9XuT83N2OHheLcimtb11DBj1PF13GP980Y7EwPDyuRX/KSZ+YpKE6qGFFXUZqIQXsNXj
	9LrNRY+
X-Gm-Gg: AYBFou2BBg+hrZSvo/m8mJbL1Zc/9liI8JxkVaF7DE0qhnp/n7tlZC33lNhmPXP6RTL
	+BGZrRE8H8Jrp3lGnAU/NAVBJx9JaKhLTbCpNDJw2WAWAnEiK3u5MHLGHLQdWvocQz3DyRkmXsA
	dB/YbHkVT9Ip5u815eM9atG80OXmOLiiSVOmt7RCmJPz36b6GklzzDS65jiX9sfDBESVvu2DajL
	3pMknAw+SCFBt4X6tv9YJnFq4FOBCkeRDe6yHj3/3B/ltTKS5Gm01L9hn9FEKBQIGHChXdtV5+h
	Pqe6Z+lrSJJARAouLZ0AA67dr3BQVnAU06XayGp7VS5WbkryOee8ktaXIdTLWJDwRBEXZTmoQXx
	a0zJ3Lma7mbxnr/bVWJ4vcDKd7ppPLY66bSoEe2XPhu4iK0ZHAM8spNXSof+M6W19QhJJTFhF6V
	oR2Npl/MLVnWnEs6pMdr2WxoD815Q4sm84
X-Received: by 2002:a17:903:1cb:b0:2e8:6ae2:75db with SMTP id d9443c01a7336-2eb364c51demr5778215ad.41.1793311069504;
        Thu, 29 Oct 2026 14:57:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2eb3677ed8fsm164585ad.6.2026.10.29.14.57.47
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:57:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a1e2485fdso279805eec.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793311066; x=1793915866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P2A9YuqVRwZG5vPvb90/8FnAEKZY4a8UvPrcVp6QTk8=;
        b=Z4iuHNtz7Gad7GINbzP3/MqSt5eNYIgNmlY1T7owo4R1Nc6eBpDL2gaO+wBaCYsS1t
         rUX8HAE/v2Ett8zGdvafKfPurbGbvGfikeMZKya+hWGNpLgEAMo64zh5Z6//xma9kjwM
         iYyABHJ/cIMdqcDpqRPd4sC5xnItTw2aDor+Q=
X-Forwarded-Encrypted: i=1; AKwUvBzcwNQdG/Fvp0HrBUPo0dHd7qCrqnj0dNhyjoW5DD9pz4F0yBpUT+nIL/2T/PBKFB5e8Yc3+aE=@vger.kernel.org
X-Received: by 2002:a05:701b:4186:10b0:137:5b9d:cf87 with SMTP id a92af1059eb24-1ac4f91ee96mr587370c88.0.1793311066094;
        Thu, 29 Oct 2026 14:57:46 -0700 (PDT)
X-Received: by 2002:a05:701b:4186:10b0:137:5b9d:cf87 with SMTP id a92af1059eb24-1ac4f91ee96mr587316c88.0.1793311065272;
        Thu, 29 Oct 2026 14:57:45 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a136537sm1341988c88.18.2026.10.29.14.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:57:44 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/vmwgfx: avoid underflow when stripping short GuestInfo replies
Date: Thu, 29 Oct 2026 17:57:37 -0400
Message-ID: <20261029215738.3010276-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

vmw_host_get_guestinfo subtracts the two-byte reply prefix using
max(reply_len - 2, (size_t)0). Since reply_len is unsigned, a one-byte
reply wraps to SIZE_MAX instead of being clamped to zero. The subsequent
copy can read past the host reply allocation.

Theoretically malformed host reply can reach this path when the driver
queries the GuestInfo parameter used to enable VKMS.

Check the reply length before subtracting the prefix so short replies
produce an empty payload and cannot cause an out-of-bounds read.

Sashiko reported this while reviewing the i386 hypercall changes.

Fixes: 89da76fde68d ("drm/vmwgfx: Add VMWare host messaging capability")
Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/patchset/4ab10678a8f50053934b62b56af81f881c1d3798.1788414669.git.zack.rusin%40broadcom.com
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index fd77ab6568cb..49e04a50c6ed 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -431,7 +431,7 @@ int vmw_host_get_guestinfo(const char *guest_info_param,
 		/* Remove reply code, which are the first 2 characters of
 		 * the reply
 		 */
-		reply_len = max(reply_len - 2, (size_t) 0);
+		reply_len = reply_len > 2 ? reply_len - 2 : 0;
 		reply_len = min(reply_len, *length);
 
 		if (reply_len > 0)
-- 
2.53.0

