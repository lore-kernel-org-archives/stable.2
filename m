Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792892293;
	b=EJsG0hTyTn54+Jz8uF6eApkqCGOpietnRHEnpIuv6iMzLdNN95vWCEJKLs/hEIBMn3sf
	 /PxCV1PG+ODSb6DO0SOPFwRRqN2r4O2/6fbsaCHNDVDeazdT36EDESrgMFX3su0uXKk4j
	 nmL9PRsmz4WSlkXN1RWZQZ8HTziX282hktrpJ2OhBIw1GJEjXLbavocRIYuuHntbt3RP4
	 uTJAl+BRbVfzNIjGUYUHD1guZ0X0vAGZxXdfgYHUZqcGXjVVFPT0hX5+9wNkzTH72ZvFB
	 7RUHPpATFyrz0QsqTudS3Pc3N1P63vaptUmbt6BsAbuSuJ/9Ub194HF3EWPN9WXdgOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792892293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dyBv9Dc6Qhx1XOQaA7oqdIJfObyTsj1C7Q26W9Ag+os=;
	b=0nl/XC76kU9cLhsfiN2ac/hlzUJg8R9lzNPB48WgXL/h/ZPW7AwIjhn8bf89ymSXmDIY
	 wRrk4a0gbho8BKHc6I55oY0crz/+C/AY0ZWEcUVmNNxa0G++8Ln5UiNLh0z7J95vEBj+M
	 b6jd/Pl2l/CJDXwoQD+Q7o82mtnPuQo1md2zRjD4sjKVkthzzoiHg76faD83P7Pq7iRL5
	 dQMCtwB9KAUPk1P6dEN7ZD47BL1lgtRVHzUOocySUEvSHMcQZZ33XOeDSwD5z8dkpb88o
	 n95wj+8uoVhy04IrFQEMkDfjG3ex4q/y9rwNF0FQrWlozYwp48vWvnQ8Ob0fdwgcNwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=iQHI7mA7;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544F4606A327
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 01:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 544F4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=iQHI7mA7
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33fb4680717so3193264eec.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792892292; x=1793497092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyBv9Dc6Qhx1XOQaA7oqdIJfObyTsj1C7Q26W9Ag+os=;
        b=iQHI7mA7+ZzOl9CK0wtM3zFhG196uutFD8us38y2LTGi8QugKaq2lzH6OukKW9FGTM
         misApk5qzZFKUhZo8t5MWvifMvUMyOfT10FQBGQ/OFe4rBpJdEk+OCqn3aLovyWiszmn
         2FTg5YCDH5ndZazMmzgTwtOylV1NFVyRCeJ8edC5fqTZ904MTHeUmYctHSXGtu+xTblw
         z5c8CULHZYO8Sbwu/mZ68/jwBq91jem/Fl2DBqpR6s4VVYqwSGxpfDnSKTupdXSu0D37
         mmaw3E14HbQneLYcjm7uJppGomjpEXWLXbdaK7uUKQNcMqYlEL0nzX40P2oIK3Xsj9Eg
         BdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792892292; x=1793497092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dyBv9Dc6Qhx1XOQaA7oqdIJfObyTsj1C7Q26W9Ag+os=;
        b=lGK8OLvU9ASEwDY2THLbsIhCi31zisjx07coFqYG9tXHVdn4i1SftnqD8n92ym9BFD
         TMBf902suzFYmqDjd2o1I2zH4ZGptCrWgMle648x0VZ0e4PwujO+gzsqMsM13WmJiYmE
         lJELVs4Qh8UsqdawsmF8vn2azZjCVEiotvKKE9vJAM1BEXNsBC7qpMI003xJs4jvburE
         5tDmGNIcu8cNhg5OtMLQbpnwQ3STmL/LZ2C6ickhyfZQVvTze9iKBjetA+1sy64Ij8V2
         QmKhH7ZPicVJ2lSEUnPP/0+X4ujeYPbt36bQ15wQTqVTmKtAPgyu7kGVBwX3nJMF5XVH
         ik5g==
X-Forwarded-Encrypted: i=1; AKwUvByxQ/sXEkxF1kFoVlDhlHJynWMYhSeGjxnp1T5UE1yV150BTgeA5UaKwMilzHkQowBAbV31yHo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLByjK9uyIMIVpRa8Rqn1CEamuPt2ac/Ado8i7eUUHhOSUVCfyM
	r8ZLiyeeRFPpL/UyiVoI2WRULfJ4wkH1q3AG+unU35C466hJZHCuYy1mcyFy4Z3Vloll6Y0gYT6
	RB2+v
X-Gm-Gg: AYBFou1QobjpXZrN8VQvzLLHXLpWEg8T4bAzkGnpG7ehFzh1MCmCunMqikSVQ+Eqc9v
	3svaGLokUp2pe2wuJyfR+tiE/23vcKURgzGGrj+6SWHLNAXUyp/bD3ScOhPeOh2LDOfbrrTB0J9
	6wLclfYAP7JGeDlZc6B3uXS3KpCtqV/TvQbhDACX+W8vmUQBuKFZyfTrjCE22dSTHH/8PwnT5EA
	QSdWzwUbUveuMXEZabDtrDLH58ovSc/Jz6t+3+i74tFqbyERzv8ZZrLiFkMcUItJxjhvcQoohYk
	G9a5DFGW6xq4tE9xvJ3DT4ShegmdJN3wvDxO6lgcYyQx79zZczw5ctZNrKmTNUC+iTnSdZZRpQW
	13zy1X4ZI+Uw0tYqd/4QpYJKqY0jn9AClcyVHUMorlNVgnCIH8rtq8PKXGnh/lUngZBc462GLcV
	MWU5CalVABM1NsvnZig0D9dw4yQZ7FJPxFD0DfNGEwgF22Qb+Y4fE+6P+YROZyncqM5qgx/JFW4
	yVDBuWKtGUASv/H9LV0LZ8sxt+YVDHm2KlYzLdlJ09suPQq+mO6wiHp2LQLQ46f9DZO3A2oG5St
	QcAr+JAiku8mNig0RR9J15tjBggpzxFtWz6wympjawAetVwV4OdwPwBy6avKY9M3+A==
X-Received: by 2002:a05:7301:4711:b0:369:4c3f:8a5 with SMTP id 5a478bee46e88-369e84b7d3dmr5194521eec.14.1792892292449;
        Sat, 24 Oct 2026 18:38:12 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:dba3:be57:a674:a67f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8dbaa42sm13724329eec.21.2026.10.24.18.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 18:38:12 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v5 3/3] RDMA/srpt: widen the indirect RDMA context counters
Date: Sun, 25 Oct 2026 10:37:48 +0900
Message-ID: <20261025013748.3755639-4-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025013748.3755639-1-yhlee@isslab.korea.ac.kr>
References: <20261025013748.3755639-1-yhlee@isslab.korea.ac.kr>
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

srpt_send_ioctx::n_rdma and ::n_rw_ctx are u8, and neither of the values
stored in them is bounded by 255.

n_rw_ctx counts the INDIRECT descriptors a command carries, and the count
guard in srpt_get_desc_tbl() admits data_out_desc_cnt plus
data_in_desc_cnt, so up to 510. At 256 descriptors n_rw_ctx wraps to
zero, and srpt_release_cmd() frees the contexts only when it is non-zero,
so every scatterlist and RDMA context the command allocated leaks.

n_rdma is not a descriptor count at all. It is the sum of the
rdma_rw_ctx_init() return values, which is the number of work requests
each context needs, accumulated by ioctx->n_rdma += ret. A handful of
descriptors for large transfers can pass 255 on their own, with no
unusual descriptor count involved. A wrapped n_rdma is then handed to
atomic_sub_return(ioctx->n_rdma, &ch->sq_wr_avail) and tested by
WARN_ON(ioctx->n_rdma <= 0), so the send queue work request accounting
drifts too.

Make both counters int, the type the values they accumulate already have.

Fixes: b99f8e4d7bcd ("IB/srpt: convert to the generic RDMA READ/WRITE API")
Cc: stable@vger.kernel.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index dfcecbe3a47c7..a2af0882eff5a 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -959,7 +959,7 @@ static int srpt_alloc_rw_ctxs(struct srpt_send_ioctx *ioctx,
 	struct srpt_rdma_ch *ch = ioctx->ch;
 	struct scatterlist *prev = NULL;
 	unsigned prev_nents;
-	u8 n_rdma, n_rw_ctx;
+	int n_rdma, n_rw_ctx;
 	int ret, i;
 
 	if (nbufs == 1) {
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index 506c11b843593..d9061aa65c1a8 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -223,8 +223,8 @@ struct srpt_send_ioctx {
 	struct ib_cqe		rdma_cqe;
 	enum srpt_command_state	state;
 	struct se_cmd		cmd;
-	u8			n_rdma;
-	u8			n_rw_ctx;
+	int			n_rdma;
+	int			n_rw_ctx;
 	bool			queue_status_only;
 	u8			sense_data[TRANSPORT_SENSE_BUFFER];
 };
-- 
2.43.0

