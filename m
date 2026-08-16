Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE23016FB
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 06:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860984; cv=none; b=cwEbitz0LV6lvBpuF5norTPNVrx1ACzzmR1FTsPshXatyr0nR0rRc6AuoUqh0cJNqWxhiquprxR7QooPDvhl9BdvpwGsHX+vpBsrUiEoBamgMWX/Atckcsv6WbJsQaXlI9n9R80Rekq8QGgiU2p9dBP7so+wBlN/Pt8dGa7nK0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860984; c=relaxed/simple;
	bh=PwBAtWLTBQdOhYmMRvqHmuyod5fAKCsuGd/VPX/xwMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ORLbNlRApENiDYmqrUzQrBsn+M5eELWlUGUzwMwNqVg7YoKBGu8D6Nod/H3LeqM9x2xbL1HICuV2e4Mn3xJCl9klPzgX4aaKv1VactMbNdUof1dz0CzeubusdTIS3cONrc9MwsziD56wBmoAedPe6Yzo1D08+0NR9WiJpMItio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKDfErwp; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKDfErwp"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c2a449c57so13237911cf.1
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 23:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786860982; x=1787465782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dx71Tj0Yh74N2KF4WkBSx6E9gWnoVmw5HGH3PfpwUbA=;
        b=OKDfErwpCvTgRHTuf+8/EpjXDLdgNZqDCXzjD5dMI8r54n2DmWx9Zuk77TlK85dgTP
         mUFKgNppp+YnOdTVvjo5xlwScL/eEdlsrGQPMn3j9bFjcQKZ7VI4XcAKVhzbA7FBV9Cx
         zwzT498CXUMpb/V41mjy6HSD8uBbFOnnZ2Eo4kwMNYgUy94scxQtJXYHphkZuXtbl7+v
         e/2zheg9s3mwHfddAbqwM5CRaT30tXeRY1bvLkHnmiAU593Fkd6Skw9d0LhZg2fUs+jl
         Q4YuPVZq4lZHYX4jkYmZzzisdmTdUuF7496vetmaQBOEePSHyVH7mgp7nMl98Cobq7st
         MZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786860982; x=1787465782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dx71Tj0Yh74N2KF4WkBSx6E9gWnoVmw5HGH3PfpwUbA=;
        b=Kh17ywB6cFhsC6LQd711u+z4zvgbG8y24kyN19dtADu9EgJ75orqxcPpX2sJPq2s/Q
         nxbzJGhUVIdh/vcp/fSEzAiGSHsce9NlA9QzYCUBqXJnzrJm92oMx5ci28IQ2OWX2cFr
         VthZS77elkv+TQJdMYQi/0xERzmRUJmeWY+IFYnbbQVVtEzzKg9NsHKkEydD9ovhJ33i
         gtIkEeuUxbTWGjrlqdG1qJ2Hegh/ZO0TGBZSzu9ZKofb9PAIsmlMobgSJt9Hcg9XSqjL
         JilTjH6jqzUJIvMHKMdrVU6vDUfCE13Z+m75m7IyXuQ6Mcj1AIvNG0blBKJc228B5pu1
         zGwQ==
X-Forwarded-Encrypted: i=1; AHgh+Roa2X8ONwb884mcOzX8jH5VsKTh3kBdXFzPYJop9vmroNoE91a4qbqvAJSS2w5k2zEiXYCFN60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlomLX2CK3rHv+Qt/sXLW9wO6hA46nzF80zb0d9+K2B7vMQA+z
	SQnFa0HnOvWnYa73wDPe6zm0TdfsegZqQpi9QU5TsSLGV/P8r7q4opj7
X-Gm-Gg: AR+sD13D9g01dtawsS2TMj41fi2QKJlLRVq7RC326MaQEebVL2vlD2WUPbkYVzBTE2J
	UI6PGHt7+Gnz6C991zHsNzFpbTwNxTj8ixkVnfVjRz63rSQyi276BcwvkJo5KNbMLPOUkJNvgF6
	Juy1KDgKbc1NnS69rcXFeLE4nuB7sBotxi2JwI/A+iW8ndsMlnp1WcEQLywD5XWbL5E0NJyH1n8
	MkhLThze30D7Wk5sXtvamoyXuZbD5OkGUXCfvJkFC3qVEJzq95bQUrkt/ADYI6r1soGosk8kdJ1
	ZldvM0EDSr+5f5ilUA5pEVKrqip4etAmHEzhKGfCOmWl9hhAbgUbXlj8/RMOOiPj646i+/kKlni
	250IiNd7xIAO+aHHhP29i1JOi4xQuCKlCPOxezaKnZMpBQMqcyQUyC7QhGsrjBWGYzyiOnwqczr
	Bw2NfS/csq8ctNTzRN+jRcY9RDfslWKq9FfGWxtjsdzgyH4dsxJTmR75W55dQq1RR+077HnqvJc
	uyXhpNy3OP6Ceky3A==
X-Received: by 2002:ac8:7fd4:0:b0:519:8b76:2ce0 with SMTP id d75a77b69052e-52d85538e0emr189855501cf.37.1786860982216;
        Sat, 15 Aug 2026 23:16:22 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d84043241sm54126611cf.16.2026.08.15.23.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 23:16:21 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: bernard.metzler@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH] RDMA/siw: Fix CEP reference race in siw_accept()
Date: Sun, 16 Aug 2026 02:13:53 -0400
Message-ID: <20260816061353.4059242-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

siw_accept() associates a CEP with the selected QP while holding
qp->state_lock. If the transition to RTS fails, the error path releases
the lock before detaching that association.

The cleanup drops the QP association reference before clearing qp->cep.
A concurrent QP destroy can acquire qp->state_lock in between, observe
the stale pointer, and drop the same association reference again. This
can free the CEP before siw_accept() releases its remaining reference,
causing a use-after-free.

Serialize the error-side detachment with qp->state_lock and clear qp->cep
before dropping the association reference. This ensures that either the
accept cleanup or QP teardown removes the association, but not both.

This is a follow-up to commit a93949718259 ("RDMA/siw: Fix
use-after-free in siw_accept()") and addresses a separate race in the
same error path.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Link: https://patch.msgid.link/20260801213632.1086548-1-shuangpeng.kernel@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/infiniband/sw/siw/siw_cm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 0245b25e7271..da1b953f3fa3 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1751,11 +1751,13 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	cep->state = SIW_EPSTATE_CLOSED;
 
 	siw_free_cm_id(cep);
+	down_write(&qp->state_lock);
 	if (qp->cep == cep) {
-		siw_cep_put(cep);
 		qp->cep = NULL;
+		siw_cep_put(cep);
 	}
 	cep->qp = NULL;
+	up_write(&qp->state_lock);
 	siw_qp_put(qp);
 free_cep:
 	siw_cep_set_free_and_put(cep);

base-commit: a9394971825933074032794a5feee5211509c774
-- 
2.43.0

