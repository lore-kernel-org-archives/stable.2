Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF5F47D94A
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029500; cv=none; b=cW4U0+mTk88nM8xy8G6zfPYZK8UhzaSPvSD5m40SuwOhWnA5PRkKnnOqr6rZ7vzx+AX+hEJaaaPFacYHpWpmslLpXdKkC8283TS2kStkkwR+hsb2wJkl+q/TpVV7abRXKVH9hEX30jrMYw+Xl4W96SqXjaqh+n9u20nYj+d20i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029500; c=relaxed/simple;
	bh=h0qC/g9qPH8A8JOa7KFM7TefdBMjpjmgavOU87MHIc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9oRuF2XaMnxFJdJHyqCvPCesmEmWxNukpcNBWPV/wgAu8qZpPJTx1lWWInw3zEHU96LWeLiBTTnEUa3itPyOrIspY/eUAniPhTyG3V1fPSttXuP+dalA2Z03i5dbfpWWWgFUaBfhkYkJ/gsBaPns8q9HK2+mx33xqKA13nXsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILjsDpWY; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILjsDpWY"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5176d4c14f5so47886811cf.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781029498; x=1781634298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ4xsWjsbWnXm3RQEz3hdKHfG6kaTnLOtHhVB+yWDzM=;
        b=ILjsDpWYls4dMSkkCiN4rY85z5vESHBIPD7cx8z5PEY3IXlz3xNWjVet76nnEV2YRJ
         5VaqI+DajkNSHUIqCV/yl8kGCnv71+jLLckO4R/3nRnnBG7IE5BMppzJuGRxJJIZOWm1
         iwlwYo5ZLTt/fs36jNV5pRIWAbpD8ldHSKn3wt3dbbHuwHzRHemJ2nBcXdWXYQgFjV9v
         yuDAf8Vy9DTaCNaWlqMS6iQkJJWkj+CzSbgokwm0pRwWNSD9JDIC+dm+Xtl6H22d/Rr0
         BijNjRBpmaFw6MY7e1/ZLRAFbgAN90Zg7w0Q1EmOnnw4gjykFfpXOyY8DPJ/uC0pYSlM
         wGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029498; x=1781634298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ4xsWjsbWnXm3RQEz3hdKHfG6kaTnLOtHhVB+yWDzM=;
        b=FJvpj9qLZlUrARD+MCorPrmF1UdquQW13/rIlbNjydnLwSHZqjCjmTreH4tjOdHRCg
         nMLl/jHLFY0k+87wgQw0EfHmavns9pkYsxTWruaMzqARggSA9FUYBP4B6soKaLVSgr7Y
         FoX0pkj1seAjOjNB7BWWbRXXgjzVZwC3i/3Clmf5Ju4wK0nN60nYkxX/YY390uoaaPGm
         12LrUkOq0hmLlmGvSS6w8e6HeGmXmMcs9e+rZg2q3JV1IUs2AuGkro0NRIWjsxGdfNrs
         /PML+l40yHHj02YktluFNW5LjmCEsJXqBPQ7NylrWf/5ghsdx/w3Lfhqk0iin0qkbDcM
         XMng==
X-Forwarded-Encrypted: i=1; AFNElJ9s6TnFGDFhm9U4df36h3PbfJNuWk9x5IrOU8MtPZAFQIdEUEcQcpd10UVbPTzFX0Tz2sa3v4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRt483reDIGofHbs96YdnN1iDghfDbeNqZXuOKOrSNx3xh4/a
	X5lPW4i9LD8Wpiuty2FsZVkmSqeZGaMxHlg2+UtB+jv4nUfAgGXhhxO0
X-Gm-Gg: Acq92OGM2GF9Gdk4llQhh9aZoZLD2bs7OSC050LUGxM9AHTDZr4NaDncLRsWI8nVokV
	JIWuO5hO/rUrSI30ck9cyDdp5/2pC5wNB5R4NZjnE3LquqOYQS8xVO3uy1v953+MMgJpxr0fnYe
	Kcui1w5I4n8gfzMzJipqvHXwULWgV4BRYqKtGmBiC/5rX8QhVGh45oNEuOYiRCQNME9JXZv1Fhl
	uEQtp4RLd44ZYQq+Ngc0JQ5Op8nt6TD1uA+jSPUuH/OMBhYGHqnHdwq+10ZsUswz3z/j4kjetmE
	fNvN5EfGXlnd6h9bhK8GECqIS4kNEuhd9oAJAx6JbvWaq2GICHEp4mBqgStawgwBUbNRdJaFod/
	dsVwsYmGuG/G2QvzlqcOOEqfMs1+nsnI+Y6y51y1YAay3sOdGb2XCqTJ6jj67K4/tVUNv/PlaN8
	zvuRcCKvn3rJWXQ/jqs2PipRMqYpaj0AnWEQfi4tBDK8cpv+Q+HSsrbz+aMIEG67S7Nv2ge/l3P
	5pRGBx7+i4t+OszldOGN1BuP0+SRLQ=
X-Received: by 2002:a05:622a:4818:b0:516:e01f:523a with SMTP id d75a77b69052e-51795bf3cf3mr319055121cf.43.1781029498000;
        Tue, 09 Jun 2026 11:24:58 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3e0d55sm2174297385a.43.2026.06.09.11.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:24:57 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] nvmet-auth: reject short AUTH_RECEIVE buffers
Date: Tue,  9 Jun 2026 14:24:31 -0400
Message-ID: <20260609182431.2437882-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

nvmet_execute_auth_receive() trusts the AUTH_RECEIVE allocation length
after checking only that it is nonzero and matches the transfer length.
In the SUCCESS1 and FAILURE1/default states, that lets a remote NVMe-oF
initiator reach the fixed-size DH-HMAC-CHAP response builders with a
kmalloc() buffer shorter than the response, so nvmet_auth_success1() and
nvmet_auth_failure1() write past the allocation; both only WARN_ON the
short length and then format the message anyway.

Impact: A remote NVMe-oF initiator with access to an auth-enabled target
can trigger a 16-byte heap out-of-bounds write via a one-byte
AUTH_RECEIVE allocation length.

Compute the minimum response length for the current DH-HMAC-CHAP step in
nvmet_auth_receive_data_len() and report a zero data length when the
host-supplied allocation length is shorter, so the existing zero-length
check in nvmet_execute_auth_receive() rejects the command before any
builder runs. The SUCCESS1 minimum is sizeof(struct
nvmf_auth_dhchap_success1_data) plus the HMAC hash length, because the
response hash is written into the rval[] flexible-array tail, so the
minimum is state dependent rather than a flat sizeof. CHALLENGE keeps its
existing variable-length guard in nvmet_auth_challenge().

This is reachable only when in-band DH-HMAC-CHAP authentication is
configured on the target.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
  - Move the length check into nvmet_auth_receive_data_len() and reject
    via the existing zero-length guard in nvmet_execute_auth_receive(),
    per Hannes Reinecke's review. No separate helper, and
    nvmet_execute_auth_receive() itself is unchanged.

With CONFIG_FORTIFY_SOURCE and KASAN enabled, a short al (for example
al=1) on the SUCCESS1 path aborts in the sizeof(*data)=16 header memset
in nvmet_auth_success1() with "memset: detected buffer overflow: 16 byte
write of buffer size 1". After this change the same input is rejected
before allocation and the abort no longer occurs. Validated with a
KUnit/KASAN harness under UML: the stock kernel crashed and the patched
kernel passed; the in-tree nvme-auth KUnit suite still passes.
---
 drivers/nvme/target/fabrics-cmd-auth.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index f1e613e7c63e5..d4271fc43a95c 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -484,7 +484,31 @@ static void nvmet_auth_failure1(struct nvmet_req *req, void *d, int al)
 
 u32 nvmet_auth_receive_data_len(struct nvmet_req *req)
 {
-	return le32_to_cpu(req->cmd->auth_receive.al);
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 al = le32_to_cpu(req->cmd->auth_receive.al);
+	u32 min_len;
+
+	/*
+	 * Reject too-short al before kmalloc(al), since the SUCCESS1 and
+	 * FAILURE1/default builders write fixed response headers into it.
+	 */
+	switch (req->sq->dhchap_step) {
+	case NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE:
+		return al;
+	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1:
+		min_len = sizeof(struct nvmf_auth_dhchap_success1_data);
+		if (req->sq->dhchap_c2)
+			min_len += nvme_auth_hmac_hash_len(ctrl->shash_id);
+		break;
+	default:
+		min_len = sizeof(struct nvmf_auth_dhchap_failure_data);
+		break;
+	}
+
+	if (al < min_len)
+		return 0;
+
+	return al;
 }
 
 void nvmet_execute_auth_receive(struct nvmet_req *req)
-- 
2.53.0

