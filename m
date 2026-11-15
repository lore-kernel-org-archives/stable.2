Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743285;
	b=riufjvRq9oPPFKJusclWlH6mYayd6/MAU86NQCGXxbX+o9lS2nGxBAfL0kW6RD4eGoim
	 EvqQAKHVdy/KywhIYpCYGXBxWKmA7AMz10baVZhFIvLwO3WURdyMMSu7Jmx7lXobyvelB
	 1PmmXwg2SPHIIueJx1/CBLS15E66c0vszs5VuLtgoX+jtjMvcHMALCvLkXw2ei5jnw3I0
	 XCdDr+j1HjcZmt9cPYNF46GpjjeD8m9whltu3rvRZ6r6ELijNBCVzb5U4jYwZpe/A3xhg
	 Vwkn2YC7KkBK0ZaRvfM+AV5pGX4rsoWSjnwi/JXHoixS6D6MdSBKRoP1ybqPy4WJJhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743285;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=Q4/6Xcl3pbihX/qIA1idwhc1KCNY/vwDyWaXFbCkrtY=;
	b=lrOjUix24x5Jfi4znOlDOXlWq3dzPWc/jnkkoRsxjxhCtCI9zNrEubK2iU4TyQnxvwRo
	 E+2jwMsKwr63kYwwc4Yp0LTVINsmtqZ6WciIhHGG/q2zI/Ee0hmR+V+4QBRKHyt4hK7PC
	 eSAKyWyeUCShKcgs22icidJtJ3aJYvz83uZi+JcIc7Z85+BFgIuLtDJ0H6GRDpxnwSFTv
	 u2CuXLrwfDz2iMXFk4YXm79uEmIFnJW6H44xInQyLL/klLc+MTaM33WvOxytHvW1twJTL
	 BxOwHnP3/5MRmtbPbfiu1svUmf6W93ymX9DPRNsZI+hm4a2hZXxGtRfBMU3qo7zci3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=WTzVxPjO;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7405606A898;
	Sun, 15 Nov 2026 11:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7405606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=WTzVxPjO
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04e1;
	Sun, 15 Nov 2026 19:47:55 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Andrew Donnellan <andrew+kernel@donnellan.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v2] misc: ocxl: cancel XSL fault work before freeing SPA
Date: Sun, 15 Nov 2026 19:47:53 +0800
Message-ID: <179474327320.103840.10310873812308403660@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df0910fb03a1kunmbac61c98bf790
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSkkYVh0aHh0YTR5IQh4YH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	JKVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=WTzVxPjOukEntrKyGnNEP5kw+C4eOilmbsX9cYjzRUgcSDLriAxcTpo54l4uCdAbclkX5nLsW4+jhrFF4yI9dd+Ox0rAhserv1jFZsSmSt0kLrmAL7KrVfuVS0TA136t1ZsaeiV+ewlbKro9D8DB7hEFuBDiHIiw+GT1SnE+RQ0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Q4/6Xcl3pbihX/qIA1idwhc1KCNY/vwDyWaXFbCkrtY=;
	h=date:mime-version:subject:message-id:from;

The XSL fault interrupt takes an mm reference and queues fault_work
embedded in the SPA. free_irq() stops new interrupt handlers but does
not drain an already queued worker, allowing free_spa() to release its
container first.

Cancel the work after freeing the interrupt. When cancellation removes a
pending instance, also drop the mm reference that the worker would have
released.

Changes in v2: cancel the work after free_irq() and drop the mm
reference when a pending instance was removed, and refresh the comment
that explains the ordering.

Found by the author's in-house static analysis tool.

Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260928134110.227-1-getshell@seu.edu.cn/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/misc/ocxl/link.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index 7749dcd..a0220af 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -252,7 +252,11 @@ static irqreturn_t xsl_fault_handler(int irq, void *data)
 			spa->xsl_fault.dsisr = dsisr;
 			spa->xsl_fault.pe_data = *pe_data;
 			schedule = true;
-			/* mm_users count released by bottom half */
+			/*
+			 * The bottom half drops the mm_users reference, or
+			 * release_xsl_irq() does when the work is still pending
+			 * and gets canceled during teardown.
+			 */
 	}
 	rcu_read_unlock();
 	if (schedule)
@@ -335,6 +339,8 @@ static void release_xsl_irq(struct ocxl_link *link)
 
 	if (spa->virq) {
 		free_irq(spa->virq, link);
+		if (cancel_work_sync(&spa->xsl_fault.fault_work))
+			mmput(spa->xsl_fault.pe_data.mm);
 		irq_dispose_mapping(spa->virq);
 	}
 	kfree(spa->irq_name);
-- 
2.50.1.windows.1
