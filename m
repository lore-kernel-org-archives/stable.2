Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D12C0F91;
	Thu, 11 Jun 2026 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188454; cv=none; b=eP6TdTZ8BMEqTtfBSMy2xwoE6s/d8P5bIwD9Dl0PCkUDoFGefzipRyNkGyyYTe2ZnBrQQRXcQIj8ZnQvZ7oTOERoHJVFPMPgkBOB79DCLllo96cT8XpQNpY2nPWB2/16lWeM3u0To8UHm2pNMZEf94anp6R8S3EOY2LAy/8EiiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188454; c=relaxed/simple;
	bh=Vf/yQ8byq1UO9GA/depm5GSnhhe0As4UmxhoMyh1J4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnnohlmrpJZdTmg3Ukp8BYbW9kUGSxm0iXXRC0F3kinvPi9b2M2FhDbdn3Lkdb41mlO1OnwaadKMO40RgB4DiCYLJrq/3XtGzY/8+y8kFcNzsq9JjIUnXpwHlxTXe7DKhNFWq4hK0Kwrl15RuXkcfv9EbF9DqSEyim052z8ZeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowACnHvJexypqDZgXEw--.1018S2;
	Thu, 11 Jun 2026 22:34:07 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: fix refcount leak in write_folio_nounlock()
Date: Thu, 11 Jun 2026 22:34:04 +0800
Message-ID: <20260611143404.88190-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnHvJexypqDZgXEw--.1018S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyxuF4xCFWUKFy8Jw15twb_yoW8urW8pr
	Wjka4DKrZYqrnrGryDG3yFvF1jk342yryakFWUWF4I93Z8Xrnaga4jg34YqF43AryfGF9a
	qrsrurW8ZFyjyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvXd8UUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsPA2oqhtHL4gAAs+

write_folio_nounlock() unconditionally increments
fsc->writeback_count before allocating an OSD request.  If an
early error causes the function to return without queuing an
active write, the counter is never decremented, leaking a
reference and making the filesystem appear permanently
congested.  Three such paths exist:

- ceph_osdc_new_request() fails: the folio is redirtied, but
  writeback_count remains incremented.

- After the request is allocated, the fscrypt bounce page
  allocation fails.  The function ends writeback on the folio
  and releases the request, but does not drop the
  writeback_count reference.

- The write is interrupted by a signal (e.g. -ERESTARTSYS).
  The folio is redirtied and writeback is ended, yet again the
  counter is left elevated.

Fix the leaks by adding an atomic_long_dec() in each of these
early return paths, balancing the initial inc.

Cc: stable@vger.kernel.org
Fixes: 6390987f2f4c ("ceph: fold ceph_sync_writepages into writepage_nounlock")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 fs/ceph/addr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 0a86f672cc09..dac2b0ae7d37 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -790,6 +790,7 @@ static int write_folio_nounlock(struct folio *folio,
 				    ceph_wbc.truncate_size, true);
 	if (IS_ERR(req)) {
 		folio_redirty_for_writepage(wbc, folio);
+		atomic_long_dec(&fsc->writeback_count);
 		return PTR_ERR(req);
 	}
 
@@ -809,6 +810,7 @@ static int write_folio_nounlock(struct folio *folio,
 			folio_redirty_for_writepage(wbc, folio);
 			folio_end_writeback(folio);
 			ceph_osdc_put_request(req);
+			atomic_long_dec(&fsc->writeback_count);
 			return PTR_ERR(bounce_page);
 		}
 	}
@@ -847,6 +849,7 @@ static int write_folio_nounlock(struct folio *folio,
 			      ceph_vinop(inode), folio);
 			folio_redirty_for_writepage(wbc, folio);
 			folio_end_writeback(folio);
+			atomic_long_dec(&fsc->writeback_count);
 			return err;
 		}
 		if (err == -EBLOCKLISTED)
-- 
2.50.1 (Apple Git-155)

