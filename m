Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D03134CF
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780769605; cv=none; b=bW9m0pG5Vuq85xQ3sNz2mzWwCaUI0c+BP9L0+pKbJq/vlclqs5w3zHoCvwBrc6GRjgY29mFWSbZ4b8AuFTf0xGC/kb4GKYjOY90Wep2dYzJ7C5qgpvz2CXKYs3PkAPIkM6Xqn4ssQJZ2DCLvS3+WZo6kya6TLEBjmFNkCuUteUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780769605; c=relaxed/simple;
	bh=Tquiso9GPvwfaj1fp91T8xlb/7amivqMBSTUJFBrMKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q72F34zohefLsWdCEHbY86cBcnzpL3e2i3R3zmYtzUJdVDI2ep/5qllXKsGjKdFiALGgOSNl/f/+Y7ADgZ1lt2iWGmhlNWTYFq+rYZsxbwICI+Z6NgEpYdH30bfOlQgWrOSIBqT190GYkQkvLGbeXqk4jpMD8c+BoEGapzw5Pfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pq3SS6jn; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq3SS6jn"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-517a5cafc3dso7060111cf.3
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780769603; x=1781374403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vs9sOPs398rODDZTFwVgFO5RKpuWAqMg6hg4GuJ04No=;
        b=Pq3SS6jnGZJ7y6Q3DKF6JCVcAbUekn2BrsqFGEepDI8ENLkA8Y5SZfc/BthDTOBO8U
         fcwcLxdN71Yqahx67Y05Qv31zlRzDwb0+cLda39df3IgitVdpd9QWw5B3bD7uf2h3iyY
         21hw+X+Sgn8pYXwQWTor5yVlF7uOHWyUFLERVe1p/p1vcvA/pIQlBBzSRp9fhvnwwFhF
         pnM/F15iD+CkZpKpI3KdHnDPPbwLgnmGaSeh2BBhyvE0BlJjjMjSxPopPFhbi1gjXSA+
         LdpQ5pnHKl33e9uSt3iNQDTMXQfPEjEBDxF2kBsij3QsOIrmozztc9FhX49NhZdrw2mO
         lDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780769603; x=1781374403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vs9sOPs398rODDZTFwVgFO5RKpuWAqMg6hg4GuJ04No=;
        b=pxqlpmBRO7np2kRoA6LxwVtNiNi36NLYAVIM3y2AQ152irnjOzZZmdmBX/3DRnxtPK
         AirMjwWkmMamsyn3rFQYRvzKInHFXdJh91dyj6Cm9XplrwcDNsLhE2aB0U/PbZRoqQd3
         g0vHvmv4KsH/sz/9HQjimsmWXDGTpS5MMBfnEumVVmka0JDezu6zuABaAt/WsbV7c3Ec
         vIzrNu5XVMhmZrMa43UvAbW1PS9a3KC9mANgUTbSAH7e/auxL1iaN1RDMP8rWinNmwzG
         ItUaSyOJ/V2CCmVAPVOXexDN18YUzCXEkXSIvbhGDoNzPkJLsLrmn4SeanaToNRcq7+0
         kPYA==
X-Forwarded-Encrypted: i=1; AFNElJ8bDmO/cBAbi5KF8uU3GWI8HP47tSL1PMxKQeNyDxiHBRisX2myIEbhHI80wQbMaXoY0mWmYrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM6zlD0s2wJMYyN1Yeobg27gk0SCCkQ69bj8i31O0VWs7Vlos7
	1DOXywKRHsDnXjt53ixkMzMWh8J6p7kGMXKrOjnaXMpM/2qeGK+uYLvL
X-Gm-Gg: Acq92OH4cPmprD/8tscCPb+iHavELIBciwIPM9Q7IvJ2TibP/Fjn0glA9yypbkXDswy
	Uh/Rogi/fsf4uL1jdKS0VQBSDvrjW5uaIwJ64/D/gCzVJ2LOP09suhGU8DuADee6ZQg9oBiSken
	7k5wGWw9VZyE8LqNV6SOa0EWJj3KtpdVfXVVD8WOcMtr60SYG9WcayK9wQu88EBkuv5dKqvYQfc
	BrHYLdoXuYu8RwpXhzCtLuELM9vA9kwhhelUrmGreZ+Jy+TSnrFtcXV7wDrhhBACH1GwBC7XTLL
	pmDexy7+1TNODyGDKSKmtGHkPfPEGOAs9qpgIoQ1BcVI/y0wvuQR0Cq3OjJPwvIQ6vCHsJcTZAH
	29zGsL0QHJTEBq8HfB1t2Dg0TlWSvXXpJ586+8dvRBfUY9bTVdt8ZabdS3jMTf8GgC36kn/syFr
	Wd7L3r3AhyGNCV7btM1CSq5gx/7s87R+dchHm+Q9TE5RAG+C3acnkyemSTHx74MRQMPTo1XGw4K
	3QYsFzmJ9f2FAAUBLrnfAAvY4gXMog=
X-Received: by 2002:a05:622a:4d09:b0:516:e290:991a with SMTP id d75a77b69052e-51795be8192mr140592791cf.40.1780769603612;
        Sat, 06 Jun 2026 11:13:23 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775da6f41sm104769301cf.22.2026.06.06.11.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 11:13:23 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-auth: reject short AUTH_RECEIVE buffers
Date: Sat,  6 Jun 2026 14:13:06 -0400
Message-ID: <20260606181306.1651139-1-michael.bommarito@gmail.com>
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
In SUCCESS1 and FAILURE1/default states, that lets a remote NVMe-oF
initiator reach fixed-size DHCHAP response builders with a kmalloc()
buffer shorter than the response, so the builder writes past the
allocation.

Reject AUTH_RECEIVE commands whose allocation length is shorter than the
response for the current state before allocating the buffer. Keep the
existing CHALLENGE variable-length guard in nvmet_auth_challenge().

This is the AUTH_RECEIVE response-write counterpart to the separately
posted AUTH_SEND read-side bounds fix in nvmet_auth_reply() [1]; the two
paths do not overlap.

Link: https://lore.kernel.org/all/f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev/ [1]
Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
A temporary KUnit harness, not included in this patch, ran under UML
with KASAN enabled. The stock run crashed in
nvmet_execute_auth_receive() on the SUCCESS1 path with "memset:
detected buffer overflow: 16 byte write of buffer size 1"; the patched
run passed the same harness. The harness source is available on
request.

 drivers/nvme/target/fabrics-cmd-auth.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index f1e613e7c63e5..77c7b412a8691 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -487,11 +487,30 @@ u32 nvmet_auth_receive_data_len(struct nvmet_req *req)
 	return le32_to_cpu(req->cmd->auth_receive.al);
 }
 
+static u32 nvmet_auth_receive_min_len(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 hash_len = 0;
+
+	switch (req->sq->dhchap_step) {
+	case NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE:
+		return 0;
+	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1:
+		if (req->sq->dhchap_c2)
+			hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
+
+		return sizeof(struct nvmf_auth_dhchap_success1_data) + hash_len;
+	default:
+		return sizeof(struct nvmf_auth_dhchap_failure_data);
+	}
+}
+
 void nvmet_execute_auth_receive(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	void *d;
 	u32 al;
+	u32 min_len;
 	u16 status = 0;
 
 	if (req->cmd->auth_receive.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
@@ -524,6 +543,14 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 		return;
 	}
 
+	min_len = nvmet_auth_receive_min_len(req);
+	if (al < min_len) {
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		req->error_loc =
+			offsetof(struct nvmf_auth_receive_command, al);
+		goto done;
+	}
+
 	d = kmalloc(al, GFP_KERNEL);
 	if (!d) {
 		status = NVME_SC_INTERNAL;
-- 
2.53.0

