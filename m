Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A633346A8;
	Tue,  8 Sep 2026 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848487; cv=none; b=qm4vnUbl5jrEptB7fczWTJx3X3zVrRhO3l/xocjZWOXbnj9DCI8fjRHKgCnyI7S/5xFimnfI9Ac5SuEKu8mWOodCX2jwqpL6AFRhddBkQb/YNNcbAH140ELFFW48teFCH0/o3CIasP+PgufDmUMRmi2cpg1uU1birkf8WTXQEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848487; c=relaxed/simple;
	bh=Cm5qK3Vj+cU2dLuXUm0klD6gAxSdc3reZwucTYLCSCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBUJ5Dk4zFbTmSFnJx8H2iIUhaz1pOzgpB+6QsenmWRrtFG4yBLj1NQU98y6Bn16z5O3yoLayFkl3oi5JsMQbxab2/kmLHPRqWUk+hCIHu2UscVwxHzg/85HAo55mThpTd1Xnv3pT7ys5aywmua8NTRRY+hmJ71RyGEiX6YEd2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=ZrXwdEKu; arc=none smtp.client-ip=115.124.28.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="ZrXwdEKu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1788848480; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qHHFO6551s6+4U4QVrIdvzDFd7dOXOTJcOI2kUTZw44=;
	b=ZrXwdEKuVj2k/RJJ4pXE61aUMy6HZrLjzbrPsD1/3IDU3uxTtD37bBhH93oQdoht2mrCEzFzvvNRb18chVXBbyiF19XZo3w4gRRWyxoOcyLkZsgXFfIFHa4Zi/8XujLqUObcOJnrhyVR8nF51+ph6fEw3+L7fbC9s80MPs3zm70=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07684246|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00343695-0.000161905-0.996401;FP=15701046112369648747|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.j8QEVpl_1788848479;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.j8QEVpl_1788848479 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Sep 2026 14:21:20 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ceph: fix out-of-bounds read in ceph_netfs_issue_op_inline()
Date: Tue,  8 Sep 2026 14:21:19 +0800
Message-ID: <20260908062119.402027-2-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908062119.402027-1-zhugl3@xiaopeng.com>
References: <20260908062119.402027-1-zhugl3@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The read offset is validated against i_size but never against
inline_len, and the two fields come from the MDS independently.  When
a read starts past the end of the inline data, the subtraction

	len = min_t(size_t, iinfo->inline_len - subreq->start, subreq->len);

underflows and min_t() ends up with subreq->len, so copy_to_iter()
reads past the end of the inline buffer straight into the user
buffer.  A malicious or buggy MDS reporting a short inline payload
together with an inflated i_size can thus leak kernel heap memory to
userspace.

Bail out when the offset is not within the inline data.  The subreq
then completes short without progress and the read fails with
-ENODATA.

Fixes: 5b19f1eba459 ("ceph: make ceph_netfs_issue_op() handle inlined data")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---

Verified with a fault injector on the reply decoding path that
makes the MDS report a short inline payload with an inflated i_size:
the unpatched client trips HARDENED_USERCOPY on a read past the end
of the reply buffer, with the check the read fails with -ENODATA.
 fs/ceph/addr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 795cd1b9e..0db807abc 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -322,6 +322,11 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 		return false;
 	}
 
+	if (subreq->start >= iinfo->inline_len) {
+		ceph_mdsc_put_request(req);
+		goto out;
+	}
+
 	len = min_t(size_t, iinfo->inline_len - subreq->start, subreq->len);
 	err = copy_to_iter(iinfo->inline_data + subreq->start, len, &subreq->io_iter);
 	if (err == 0) {
-- 
2.43.0

