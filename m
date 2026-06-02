Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC02248A8;
	Tue,  2 Jun 2026 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391291; cv=none; b=pur0mNSWYz4lvkyOxbj99wwVRc8qQsvbDnEj48l+51v1BxKizuMHSe2sIEmgejkzXlMVhaL66bM9/V6UfhD63uHtZ5zstXAdEfNXFHM0cAdFeSKXAHVj3ceQI2tb5T6eea5T01OHPA55DXS55+TBu32201f5XJS9qUTn46s/YT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391291; c=relaxed/simple;
	bh=RLHqs4ruFHCdEfMVhzZ4nPP3z3y2MP3bCIMu2ejcYdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZVb9d/Ls70oBxut9TOiuo5/GJIsjN6oXdVKtFVeC8z0iWylgxj8wPnFdTIE4N8XPRd+FY1fzavXwuyFiejBg9f3UisTD4l2QveTSy8NML+YMAKY6E/Glyau139e9OmzFI+lSTbAZrIFKwc/Zdpo/2WUWj+HiPuV1fs8NYiltCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADnCOB1nR5qQe5ZEw--.8153S2;
	Tue, 02 Jun 2026 17:08:05 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] ceph: fix writeback_count leak in write_folio_nounlock()
Date: Tue,  2 Jun 2026 09:07:54 +0000
Message-Id: <20260602090754.3678981-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADnCOB1nR5qQe5ZEw--.8153S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4UXF4xKw4fKrWDtrW3Awb_yoW5Jry7pr
	Wjk34qkr40vr1xGr98Cas5t3W5C3y8CrWfKF4UJF17ZFn5Xr4jgayjq34YqF13JryfJa9a
	qF4qkry8uayqyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUHpBfUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsGA2oeXMX2VwAAsF

write_folio_nounlock() increments fsc->writeback_count to track
in-flight writeback operations. On several error paths where the
function returns early (folio lookup failure, snapshot context
allocation failure, and writepages submission failure), the function
returns without calling atomic_long_dec() to decrement the counter.

Each leaked increment keeps the counter above zero, which can prevent
the filesystem from cleanly unmounting or suspending writes.

Add atomic_long_dec() calls on all error paths that currently return
without decrementing the counter.

Fixes: d55207717ded ("ceph: add encryption support to writepage and writepages")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

---
Change in v2:
- Also clear write_congested flag when decrementing writeback_count
  on error paths, as suggested by Viacheslav Dubeyko.
---
 fs/ceph/addr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a606378649c3..7fab73874068 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -790,7 +790,9 @@ static int write_folio_nounlock(struct folio *folio,
 				    ceph_wbc.truncate_size, true);
 	if (IS_ERR(req)) {
 		folio_redirty_for_writepage(wbc, folio);
-		atomic_long_dec(&fsc->writeback_count);
+		if (atomic_long_dec_return(&fsc->writeback_count) <
+				CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+			fsc->write_congested = false;
 		return PTR_ERR(req);
 	}
 
@@ -810,7 +812,9 @@ static int write_folio_nounlock(struct folio *folio,
 			folio_redirty_for_writepage(wbc, folio);
 			folio_end_writeback(folio);
 			ceph_osdc_put_request(req);
-			atomic_long_dec(&fsc->writeback_count);
+			if (atomic_long_dec_return(&fsc->writeback_count) <
+					CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+				fsc->write_congested = false;
 			return PTR_ERR(bounce_page);
 		}
 	}
@@ -849,7 +853,9 @@ static int write_folio_nounlock(struct folio *folio,
 			      ceph_vinop(inode), folio);
 			folio_redirty_for_writepage(wbc, folio);
 			folio_end_writeback(folio);
-			atomic_long_dec_return(&fsc->writeback_count);
+			if (atomic_long_dec_return(&fsc->writeback_count) <
+					CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+				fsc->write_congested = false;
 			return err;
 		}
 		if (err == -EBLOCKLISTED)
-- 
2.34.1

