Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E9313531;
	Thu, 10 Sep 2026 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789009242; cv=none; b=NPbkDq0r38n4EHC09Xv7pIdLcG48IsE7xt249IYBPFd4kP8kUUlFviF2BAKe1nsDHmwYbJbCwcK+bCnz+uvktDyCdWl3sI5uEUE57LhxOiqTibHJ3PnKLeXP1QZopGMqr678PrSNdLUGugRvLJUNRsTu35ZcU5Sl0gFlHZAfZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789009242; c=relaxed/simple;
	bh=DLa4IUKwhMz1ZucFVxnS0DYI9r3Q6V9AmXjU9DkKS1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BClGV6wPbCc8YogTgM5vC6WB+6jjeJtnqyEUmeEKtBgnu459x1q3BA5E3cuRqzKz+QGVm5Yu1aFCILaG/cNqzO4hwpEDK2AMxBCYz9WXzMbj7lrUXf9MosMDYCglB+gyXYp56AkwF3eOFMR8nD0LdYNSsTbqN1LNuBvGnEF8+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=vWwnBdAq; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="vWwnBdAq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789009237; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZTDMtZkV+xrOIsRKN1uJ2I8SuIvazu8YUdxdn3DJoOY=;
	b=vWwnBdAqEfPR8Trw7mOL5BV+vAMZRWBC5qU8wCfPrA1sJV2Lv3Y9UsG5DSCkEfF89kGWno0Gquf/368ZjmhNGnVNE7e9NXWRJzZwyPRKpYHOCsIk93l6A8RkOS70Wwa6K0TICZVcVT1Nc2f4C3HLWr5dyHJS/qHki2mjn4K2LLk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07673908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00310226-0.000220808-0.996677;FP=15700201687439524970|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jA1h9Vh_1789009236;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jA1h9Vh_1789009236 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 11:00:37 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] ceph: fix out-of-bounds read in ceph_netfs_issue_op_inline()
Date: Thu, 10 Sep 2026 11:00:36 +0800
Message-ID: <20260910030036.1045515-2-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910030036.1045515-1-zhugl3@xiaopeng.com>
References: <20260908062119.402027-1-zhugl3@xiaopeng.com>
 <20260910030036.1045515-1-zhugl3@xiaopeng.com>
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

Bail out with -ENODATA when the offset is not within the inline
data.

Fixes: 5b19f1eba459 ("ceph: make ceph_netfs_issue_op() handle inlined data")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---

- set err = -ENODATA before bailing out on start >= inline_len, and
  correct the commit message: with err left at 0 the subreq completed
  with no progress, which netfs treats as EOF, not -ENODATA
  (reported by Alex Markuze)

 fs/ceph/addr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3c7cf8a5e..dd33afca7 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -321,6 +321,12 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 		return false;
 	}
 
+	if (subreq->start >= iinfo->inline_len) {
+		ceph_mdsc_put_request(req);
+		err = -ENODATA;
+		goto out;
+	}
+
 	len = min_t(size_t, iinfo->inline_len - subreq->start, subreq->len);
 	err = copy_to_iter(iinfo->inline_data + subreq->start, len, &subreq->io_iter);
 	if (err == 0) {
-- 
2.43.0

