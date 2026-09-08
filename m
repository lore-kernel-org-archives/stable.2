Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE88A380FD3;
	Tue,  8 Sep 2026 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848493; cv=none; b=BcRCpr7i6hoN1439CzvGsNNGFk9hGn3YvuH8K5+pGjGivwqDdDQYwEdjJrfYJIKrnWDxowj39LEPXjltyvlHctVy3b6U4+ilNWV69u0u8pvlS50licE6Of+a7k4McmaJvlVUWxuwvSFYFY/x1ZYCcRt0GzieeN4AV4M+vwoMC4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848493; c=relaxed/simple;
	bh=VJyYuCsbC43uOqmXmSqdyHg4n55x55Qlcb08yf2LuJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VlKDJJu72ruWod53JJV6/jItf2xdXXm2CWst0RXuRgmhyck8WUhXY6fQnSDy1DrtBSf5uCtrsNF7kS6oLkJeOH1BMo5I0C/eZ8uQw75Gg04/bCCvsWdb7WIQ8ouZ4/atrElKWDUuUDJ4NATCKk76hujORvK2FhaE63wixd25S98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=AMRsJMN4; arc=none smtp.client-ip=115.124.28.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="AMRsJMN4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1788848480; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RuVvpFRUao8oUPE6bKH7FlA6weaNaSuG42KlPwHuy7U=;
	b=AMRsJMN4vNYPw/pge+YGMEYq32RjsKZmI2LYaIayoxcNkuc/t7HOHWFFe0/oI5aSZImb6kbS2fhxRPCCySVV+opW47IwNrL1HaoaWL1FV883PKLqHaV0gMbCpOI+za9FxvfGsAnlVFlJYj1q2vFV/CbxJcztfhHNm+gOlZWrbDQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07852765|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0176059-0.000257947-0.982136;FP=6645749621527545778|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.j8QEVpD_1788848479;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.j8QEVpD_1788848479 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Sep 2026 14:21:19 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Tue,  8 Sep 2026 14:21:18 +0800
Message-ID: <20260908062119.402027-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MDS decides how much inline data to attach to a reply, and the
client parses inline_len without any upper bound: ceph_decode_need()
only verifies that the message actually carries that many bytes.
ceph_fill_inline_data() then memcpy()s the data into a single page
with no length check, so a malicious or buggy MDS returning more than
one page of inline data makes the client write past the end of the
page it allocated.

Clamp the length to PAGE_SIZE so both callers, handle_cap_grant() and
fill_inode(), are covered.

Fixes: 31c542a199d7 ("ceph: add inline data to pagecache")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---

Tested in a QEMU guest with a hacked MDS that reports an 8k inline
payload for a 4k file: without the clamp the client overwrites the
page behind the inline page and page poisoning complains on the next
allocation; with it the data is truncated and a warning is logged.
 fs/ceph/addr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e598b2d42..795cd1b9e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2209,6 +2209,12 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 	doutc(cl, "%p %llx.%llx len %zu locked_page %p\n", inode,
 	      ceph_vinop(inode), len, locked_page);
 
+	if (len > PAGE_SIZE) {
+		pr_warn_ratelimited_client(cl, "oversized inline data %zu\n",
+					   len);
+		len = PAGE_SIZE;
+	}
+
 	if (len > 0) {
 		void *kaddr = kmap_atomic(page);
 		memcpy(kaddr, data, len);
-- 
2.43.0

