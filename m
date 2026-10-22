Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675800;
	b=omNZ8tbJsFdKGP9X/tio3V8p/l1L0t3dFxnrb5tnKWiq+ZrUcRt2kgLwJL+SJi8qWvIh
	 dOt1CBXMs1UMWKo7FSwwhcoieZct9Cn8iLWqfCd45ZyZ1QlxUzR+/QflDHfD8BdAgJq+B
	 PQy0HRYaCVxUDg7lsVQy6uluEfEf5gvfHd5WjKvEnsa6B1lo4l8vAZjCUsKNb3s2V6E5A
	 SZ/akbSBgn0qyAgXUq2zoHSiydGLmvUnCuOl7/9444I24tE2Q+bVFozi2p0ATPaIyNvU7
	 G8OZmAspLERgnKAm00UfbUQo5Z++CrK4mMVINYSmyCNpu+Wrq96A+hHmr6EetP/4+jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HDUAmNZcPxPev48FOk/77ScD0rraPEGB2IzDMOiukPk=;
	b=013EVCgQcZmUJdM6t1El3AawwZ/TPU3MzAG2VtGj9A0Xn0HeTs+L49a1BZvNgBxnTKDx
	 G28apMr3Lys50N7dSNpA2lgHP/TP4/0qB43Z5uHrEgyPKFS8cQwINGOn93tpSgW+sTfgA
	 vcn++XPw4uU81hE/JSr9t3fElPt1viSXG7+HeUmDE7Gaz92Ret9x8Pdot3Ryq+0bf41/0
	 aeS8SQ/l6NIO6IEjuVA+a3T9mEIsyF7bheY7wx4qcA2xwVWeqVkVtRtGw0a7JoKx4caxl
	 biExNr3oWmcRFZn+w8PC4yN0nxTavncb4KzZyyU8fIuqD4L32WsJnZWyK2fKNsbXPyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mihQV4ct;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3AB606A31E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D3AB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mihQV4ct
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so15004005e9.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792675798; x=1793280598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDUAmNZcPxPev48FOk/77ScD0rraPEGB2IzDMOiukPk=;
        b=mihQV4ctF7GgLgksS9/Md+9MgDcXfHQfbOKrD52tlOEglwuCnB+pgQRmUXixjX+qr+
         EnKdESBUS/u4VWha5ayK/H7sQeHUwKnPhYnqcOmjcLqq1q3g14GTXPdbXF8vWuEL+ll/
         TU43ZMCAeKf/ZCM0T4YVjv5px/8BxK9CwXWH3kJlM5oOv2EC8Hlu4945qa9R8WH++0Ir
         n5GQ//TXwYtZwbGKbk0K6h1ZuIkMutRCeoqHd26oR7gLvR5Onw9zkA683Bk9WrDO3+uD
         2XmPCzL9K4yJiUjn+GAYedGK4ydGmsJlPOujdirtHNkZGr+m0POrJRzP248yIUN4zOgg
         YWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792675798; x=1793280598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HDUAmNZcPxPev48FOk/77ScD0rraPEGB2IzDMOiukPk=;
        b=Wde3gsIrWwFn62hBv7SN4WBDStW6rTEDy/Bsqy3a9mH0rV8kfiWxGWAAx13/sU7Ole
         sZifHgznzRjolfSpyIOHteA12yXm3FA15s/ucXw7O5t/fzAsa57ufFFQo4WF0uvqRaFN
         xWrd3NX05Zh2CooO/w/IoUog/+8tr3sc488gTAFaAK4fqPbCf0HTy2IW1iZ2gZ/GuaR5
         MuVZ2BP3XoFbFgF07xBb7pzqe6+UV8QIBd+VMNNVchyhiSodfqkAkQRCG3jx57XJo5U6
         L8UraIB4cD2/I0aPx0FJllUxh5t1jru974sPyMca15OboAr/tUWwUUyvYxrRFDnu5djb
         wRUA==
X-Forwarded-Encrypted: i=1; AKwUvBzt42WEvjZfjs02KWH9gLX//Y/aq3AfdcRzw7uAyWkGfVzqatXpWOwEx8hI1Ji8B19p+/ekO3M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAXLsT/AZdc31mt43jNcfhtyaijY4KWzKJn0LlrtsBZjBHdUYw
	oqKXECzs6AGvly+cod/2tao0r0NR+MULwsRKl/bJ4peUu8NSCT9TAPK4
X-Gm-Gg: AYBFou2gDXS15AXGzkvYdOCoCNBMdRAfv2DjPr4La7mvb119Gub0b3o7ii8n+emsBXb
	Qy7YcVpTxGN+4A9E0nRqZSzgWRGVj58h7IRV2UP16OERSLFazpMRlLIVb7G3uj6rxJK+2qdD3aR
	31DWgtcsmcRE5lOUBggQdTwQCZQImbmEqhgYrlBZIktl8d+ioxGBFIXmDBVDcLgvZhK/WJA/Kc5
	gksFb7kPr7tw9MPH0XXnbWDZgfN1iyJMHg4zs+p9YXT5OPVlkZvPCyZdwZZ7aehx2531vwxBReO
	Jc6KC6QCWHOyd7VhbfaL1nlVspiZUT9v9B3MRc2OMcOXedLMTy/r4sLN9WsuHmNZCVq/qaAQs1V
	RzmQt3tPiyQJRQIDh89JZJ9RIKMzEzSGMXSjY431DsASaxzD/0YzftRbhwq0bKnh1sJpl+eZo9d
	8O/MmNA/zcRxNfCAhFtzYk1+1QMxI6TIIRS1Lu/m5P0RuYe18cDhRLrDx+pdGqW0B7rzP2IfKeM
	2SdJm+/LWbsNan1Yw+7Pd0YDZPD0kbSWiUPOq5A7EBDS+msOA7CGAAcWJdhR9pzMKNxT1xad0ei
	5YBTwWmh3sXP/ycM6xoqYBGq
X-Received: by 2002:a05:600c:540f:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4a1fd8cde00mr100975265e9.4.1792675798292;
        Thu, 22 Oct 2026 06:29:58 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd629bbsm108832715e9.5.2026.10.22.06.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:29:56 -0700 (PDT)
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
Subject: [PATCH v2 4/4] nvmet: pci-epf: require SGLs to match the command data length
Date: Thu, 22 Oct 2026 15:29:33 +0200
Message-ID: <20261022132934.3592924-5-parri.andrea@gmail.com>
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

The PCI endpoint target sends the host every byte a read command's SGL
describes, even when the SGL describes more than the command transfers.
The excess is kmalloc() memory the command never wrote, so the host
receives stale target memory. Any successful read can do this,
including Identify.

nvmet_pci_epf_alloc_iod_data_buf() allocates each segment at the length
of its SGL data descriptor, but sets req->transfer_len from
iod->data_len, the length the command implies. Once the command
completes, nvmet_pci_epf_transfer_iod_data() sends every segment in
full. Nothing compares the descriptor lengths with iod->data_len, and
the MDTS check only bounds iod->data_len.

Fail the command with Data SGL Length Invalid when the data descriptors
do not add up to iod->data_len, before any segment is allocated. The
tcp and rdma transports take the data length from the SGL itself, so
there most commands already reject a mismatch in
nvmet_check_transfer_len(). PRP lists are built from iod->data_len and
are unaffected.

Found by code inspection.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
For stable, this depends on patch 3/4: without it, the new Data SGL
Length Invalid error is still reported to the host as a success.

 drivers/nvme/target/pci-epf.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 099e8766f6d40..0cc198f87dec3 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1070,10 +1070,22 @@ static int nvmet_pci_epf_iod_parse_sgl_segments(struct nvmet_pci_epf_ctrl *ctrl,
 	return 0;
 }
 
+static u64 nvmet_pci_epf_iod_data_segs_len(struct nvmet_pci_epf_iod *iod)
+{
+	u64 len = 0;
+	int i;
+
+	for (i = 0; i < iod->nr_data_segs; i++)
+		len += iod->data_segs[i].length;
+
+	return len;
+}
+
 static int nvmet_pci_epf_iod_parse_sgls(struct nvmet_pci_epf_iod *iod)
 {
 	struct nvmet_pci_epf_ctrl *ctrl = iod->ctrl;
 	struct nvme_sgl_desc *sgl = &iod->cmd.common.dptr.sgl;
+	int ret;
 
 	if (sgl->type == (NVME_SGL_FMT_DATA_DESC << 4)) {
 		/* Single data descriptor case. */
@@ -1081,10 +1093,23 @@ static int nvmet_pci_epf_iod_parse_sgls(struct nvmet_pci_epf_iod *iod)
 		iod->data_segs = &iod->data_seg;
 		iod->data_seg.pci_addr = le64_to_cpu(sgl->addr);
 		iod->data_seg.length = le32_to_cpu(sgl->length);
-		return 0;
+	} else {
+		ret = nvmet_pci_epf_iod_parse_sgl_segments(ctrl, iod);
+		if (ret)
+			return ret;
 	}
 
-	return nvmet_pci_epf_iod_parse_sgl_segments(ctrl, iod);
+	/*
+	 * The command executes on data_len bytes, but each segment is
+	 * allocated and transferred in full, so they must describe exactly
+	 * data_len bytes.
+	 */
+	if (nvmet_pci_epf_iod_data_segs_len(iod) != iod->data_len) {
+		iod->status = NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int nvmet_pci_epf_alloc_iod_data_buf(struct nvmet_pci_epf_iod *iod)
-- 
2.53.0

