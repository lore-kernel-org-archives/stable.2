Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA312477E2D
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628899; cv=none; b=pneT2yN1FCoGurRd73oZP3XaVKZE2MenvWQF8ls2TAQDnPYXMfysFCTyL4+n/8FUYxnxr+PLxEY46R57wZN23/6TYs7xaLofe1kUiAlF1K4+WGw5HfJUv/aK/9Jv4wJTI6/vbMhO3TV2HIDGBAxB3ady34mCwXfrVWkao9ohCVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628899; c=relaxed/simple;
	bh=6hat5+8vR6sH5hwpRtclSnvBpCW++LLkr0Bw3mrJ7YE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B62XxKVWuUfornxWkJ6h+NJpdl5CwRZnzJhuC/YaKiJuUODFH6RzeD4iICpOdwFoO3DtkTy/TCYeA9NaXRB2G3RtMdd3xln4u5T/D6jUDX2i0qha8FLM6XmFKZZkPQiPbYDDlW7kc3cXk5AVllogOy1UemoZM1FQWRjqhRxtjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnJTTwrj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnJTTwrj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c2d792c8so31292065ad.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781628897; x=1782233697; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJhUJyY1o94pDseZLihc3mmdqQnwkfgxQLMjsWZTRYA=;
        b=cnJTTwrjBqHkTIfF882c6M0EH3YcLdV9TtokEvxlXgLlnTTFiLp9Qx8kWryHDrCEaA
         U6lWLYiy9dilJgdNLOob827YOnJnxbQtm4yXZywrg5mLgb0yiKHyyz5xSL2dMYrkTeNC
         p91cH1zPl4JSPrZXpn+ARCMA0CgWgQ1jqXh9bXljGJsMCqdPhERqcVhB5jhiKZHVTpqj
         HLniqlNN2IhPFjCXiKwKqOXp3619lQOmZe+TKUeHQz2F1WSIg6pC+9HzYpfPl0iJwzkc
         QLzDcSu/UDU3bsxNuYJvxE3InK39OGC8CEln80+MAG0SBIukU7E4Z6pSLnWFdvB1ICVO
         FaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628897; x=1782233697;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJhUJyY1o94pDseZLihc3mmdqQnwkfgxQLMjsWZTRYA=;
        b=cqaDCqttHz5uN6Nn04VAB3LIxCASlhnCFOWjDNPXkIW+HmJFyBd8RwswKydxnZchd3
         nJ0W6JCdOeMusFJuFnJSOwQl0geE9Jq9Yh0foDGZyu/f6X4LUatS17QkNViOxZuGIKBu
         nxOIFtTieKoESFG+GPwX7rAWyPUtc2cp4a2ep3Swuh9ubtvVbCDj84IEX+79SnRbwfuf
         BYOzt8/kVm4j915Nh36gl9ayrbDKL/H/EXF14vhx6iGlubKQ7wXgqYt2rz8NeI0YFCx2
         Fg/QDWFw/htkGyLrw29tA/Z4kmFi1EFu1NILXSvPa+1i9GdxToSmTBnb3XcpkEKY2R9H
         aaYA==
X-Forwarded-Encrypted: i=1; AFNElJ/3DTcnS0M7oRaCbSFe2XfInmL/+pd4tEOJZU6nuCrNw0L/J23kx+szZXi8pcS92rtt99/Vrq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykXqv48IVtrKJhWF5vOnztjFEwxpNCXzGGxIZjtb1jO/2gl4/4
	7s/n1258Po/lH2/BWTOUriv7wpUD1/7t4z3FaLsu563UXdf2fU3R/n1/
X-Gm-Gg: Acq92OHIqq+6l1AZbQdeeZo6UM7e5OmU6YpIwYDuuVFCh2Fz0I8cpK9xh5GfCzASz65
	G2liIH5cTnab1HPEIAGVzA/e94dTJ1trBk7llmjItSnlbY2EJtccldy62ZNeg3l3IfFoFut73t+
	LDxHyZzt2eZcGT4JYQup3mDEdNOQ1FXVzD+dEQN9lZtf9RpdzsGm0qcykzHIzbEk0uKjdPpGV2B
	qRHDiKFecGxV4PyRiQARJJBa/EfTWFh6nEoUnMtb4hZVPuI9VwLOhCXEnYcDuopNh7yuyvxK7Eu
	v6qVDGT9XO4UP8Xqp6LbwIKnS/0+Bx06uXQjWic0Gl8Xr6JCh3Sl+9P+MRyU5hNJpknT+Q9v5fT
	CqRAiqyP0r8QNTSFfGdvvA407HJeM2KrtUkDTj4vA1tQKMpov60nlFvi6xUm9hZc6VQGvzUdFs2
	ZIiLe/EJP7eSGs+htrbSNw/Ye2QjfzX/ba2SGdM8c=
X-Received: by 2002:a17:903:1448:b0:2c6:a99a:52b5 with SMTP id d9443c01a7336-2c6a99a54b8mr20399395ad.12.1781628897049;
        Tue, 16 Jun 2026 09:54:57 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([36.21.199.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8dd4bsm144760795ad.60.2026.06.16.09.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:54:56 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 17 Jun 2026 00:52:00 +0800
Subject: [PATCH] RDMA/rtrs-srv: Reject usr_len larger than off in
 process_{read,write}
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-rtrs-srv-usr-len-underflow-v1-1-942e6414150a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAC9/MWoC/yXMwQqDMAwA0F+RnBdoC7ZuvzJ22DTViNSRWDcQ/
 926Hd/lbaAkTAq3agOhlZXnVGAvFbTDM/WE3BWDM84bbwPKIooqK2YVnChhTh1JnOYPUm1NcDH
 4a1NDCd5Ckb+//P74W/NrpHY5R9j3A9lCw15+AAAA
X-Change-ID: 20260617-rtrs-srv-usr-len-underflow-e51072f76985
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, 
 Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781628889; l=2659;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=6hat5+8vR6sH5hwpRtclSnvBpCW++LLkr0Bw3mrJ7YE=;
 b=I8094tBOYajXXPZzC8+1/pMMZbaGFlrDenRIxKdBWd0C2vZYoxSpKP1mNCIbI6fvxZiN/QbOn
 lAYI0xZ5xY7BlItEoc25kudLN+Rnk39imls5jdM7lhZc86C35DWMjyr
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

process_read() and process_write() derive the data length of an I/O
request as:

	usr_len = le16_to_cpu(req->usr_len);
	data_len = off - usr_len;

off comes from the RDMA-Write-with-imm immediate and is only bounded
above (off < max_chunk_size) in rtrs_srv_rdma_done(). usr_len is read
from the chunk buffer the remote peer fills over RDMA, so it is peer
controlled over the full u16 range and is not checked against off.

If a peer sends usr_len > off, the size_t subtraction underflows and
the pointer data + data_len passed to the ->rdma_ev() callback points
before the chunk. The in-tree consumer rnbd_srv_rdma_ev() dereferences
it as the message header (le16_to_cpu(hdr->type)) before validating it;
this is an out-of-bounds read reachable from a remote peer.

Reject usr_len > off before computing data_len in both paths, via the
existing send_err_msg path. For a well-formed request off is the total
length data_len + usr_len, so usr_len <= off holds and valid requests
are unaffected.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 6482ad859bd1..ec3f6c2fb0b9 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1067,6 +1067,13 @@ static void process_read(struct rtrs_srv_con *con,
 	id->msg_id	= buf_id;
 	id->rd_msg	= msg;
 	usr_len = le16_to_cpu(msg->usr_len);
+	if (usr_len > off) {
+		rtrs_err_rl(s,
+			    "Processing read request failed, invalid usr_len %zu > off %u\n",
+			    usr_len, off);
+		ret = -EINVAL;
+		goto send_err_msg;
+	}
 	data_len = off - usr_len;
 	data = page_address(srv->chunks[buf_id]);
 	ret = ctx->ops.rdma_ev(srv->priv, id, data, data_len,
@@ -1120,6 +1127,13 @@ static void process_write(struct rtrs_srv_con *con,
 	id->msg_id = buf_id;
 
 	usr_len = le16_to_cpu(req->usr_len);
+	if (usr_len > off) {
+		rtrs_err_rl(s,
+			    "Processing write request failed, invalid usr_len %zu > off %u\n",
+			    usr_len, off);
+		ret = -EINVAL;
+		goto send_err_msg;
+	}
 	data_len = off - usr_len;
 	data = page_address(srv->chunks[buf_id]);
 	ret = ctx->ops.rdma_ev(srv->priv, id, data, data_len,

---
base-commit: a48671671df5158a0b8e564cd509e04a090a941b
change-id: 20260617-rtrs-srv-usr-len-underflow-e51072f76985

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

