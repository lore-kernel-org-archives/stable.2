Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994819;
	b=IVjviD830DpJcEtQpz8xwtdQcvM/7LceeDkf9AhvJKH+09y2G/2Atwbc7wGH6+xCNz3y
	 kccBkl5TofKdZykdlBbZEfXTZ7UiBug/5sOtFPr+xFOD1+aSLOJqlqzUBGJatd/8BMMFh
	 CM3EtwJlOmbx8e3DnawxhkfAyKBiwQFzz4rKTtY33M/S1hzZSQQSc0pL8vWktUnKfnYkf
	 cY3rqcxSV0DUzUDGa9I/que7Vdq/NBl/v6SIQDPJ4XBzKrDq4cSAXjODnjSYxRUGdOSE6
	 X32M6228FID3/5bW9l9fDGhbrMqurFT0Bqh0UrNYCYt+Vc6LvDo9T1jdeoViK7EuSIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994819;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K6C3KealrE9nPWRbh4Md0/lee3g/VCnP6sGbAQQZiOw=;
	b=1nbYYLyuEPBCRiIij9hrCRopz5ZHQKQcvK0bxJ4mOI9K1BmLfV73q9XgD2V5rpxy11NN
	 XhSQfYsYzOidg5gV04VSRe9Sf5Lk3TvPLOAwz8vYSUXN/Ze/DnoRzgKzp1UVgCl362QYv
	 cLEzMWIa9YWW7cSSVGkTdUZiHA/JVH++A06o6x+DnK+jmWaLIywAvL/9ncOheI0DXoXfr
	 /6aIFGiIsj41s2V9xyuROeUWWYlroB5Xhofs9EpskwDwW+d5BaOjCbeWSwLTssC6O5hJY
	 0r0kp83RCiK5eeNxrU/XJimj67OBSWj2G+v4tMgKa92ykskMHACqfEyJqm+ce+Z91Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=IEuJqGnU;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61D1606A320;
	Wed, 18 Nov 2026 09:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D61D1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=IEuJqGnU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=IEuJqGnUnwltx1CBnurSogcZrX5F+hHsGiRYgtr2XY2Kl5mNFhkGmoD+Ld0/YqfapkyCycsvz/p95
	 g2GlyZ5tbQTJ7Q/iJkhrqDL58EhTIwG8zQr/ZUcjzE4pXeXKou2f+gK2A8549GvGQAn3ppst8DxQQR
	 A9Xa/pn6gjsqhnH0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86afd727edd8-b33f0;
	Wed, 18 Nov 2026 17:40:14 +0800 (CST)
X-RM-TRANSID:2ee86afd727edd8-b33f0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181454368174 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26afd7278c69-d25f5;
	Wed, 18 Nov 2026 17:40:14 +0800 (CST)
X-RM-TRANSID:2ee26afd7278c69-d25f5
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: ljs@kernel.org,
	david@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	kas@kernel.org,
	dave.hansen@linux.intel.com,
	mirq-linux@rere.qmqm.pl,
	arnd@arndb.de,
	sfr@canb.auug.org.au,
	usama.anjum@arm.com,
	avagin@gmail.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH] fs/proc/task_mmu: fix uninitialized read in pagemap_scan_push_range()
Date: Wed, 18 Nov 2026 17:39:58 +0800
Message-ID: <20261118093959.1728-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

PAGEMAP_SCAN ioctl accumulates struct page_region entries in a bounce
buffer before copying them out to userspace.  The bounce buffer is
allocated with kmalloc() and only the first entry's ->start and ->end
fields are reset, leaving its ->categories field uninitialized.

pagemap_scan_push_range() decides whether an incoming range can be
merged into the current entry with:

	if (addr == cur_buf->end && categories == cur_buf->categories)

A scan starting at address 0 is accepted (arg->start is only checked
for page alignment) and page 0 can be mapped when mmap_min_addr permits
it.  If the first matching page is then reported at address 0,
addr == cur_buf->end == 0 holds and the uninitialized
cur_buf->categories is read, so the merge decision depends on stale
slab contents and KMSAN would flag an uninit-value use.  No kernel data
can actually be disclosed, because the comparison only succeeds when
the uninitialized value equals the categories that would be stored
anyway.

Fix this by zero-allocating the bounce buffer, which also makes the
manual reset of the first entry redundant.  The buffer is allocated
once per ioctl invocation, so the additional zeroing cost is
negligible.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Cc: <stable@vger.kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 fs/proc/task_mmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 22361607020d..4e552f9db8ba 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3082,11 +3082,10 @@ static int pagemap_scan_init_bounce_buffer(struct pagemap_scan_private *p)
 
 	p->vec_buf_len = min_t(size_t, PAGEMAP_WALK_SIZE >> PAGE_SHIFT,
 			       p->arg.vec_len);
-	p->vec_buf = kmalloc_objs(*p->vec_buf, p->vec_buf_len);
+	p->vec_buf = kzalloc_objs(*p->vec_buf, p->vec_buf_len);
 	if (!p->vec_buf)
 		return -ENOMEM;
 
-	p->vec_buf->start = p->vec_buf->end = 0;
 	p->vec_out = (struct page_region __user *)(long)p->arg.vec;
 
 	return 0;
-- 
2.33.0



