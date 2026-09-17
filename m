Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F32248B3;
	Thu, 17 Sep 2026 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649492; cv=none; b=kINi0FdVIHILbyQgSnyY2+yMFtqiwZe61KQVSlc7D9VPLGN4ndX/B9cmIMq//AaGN14QsSlwuKzEjZk2lGsJfTIfUReBKVbbkU/ddsScncsRVAmhuOk8BSwX3hYXSlk0brPvosQjPCPOk1xIE6lTXPY7+INKfQQVt4YJaVvYBXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649492; c=relaxed/simple;
	bh=Lrj4RPSSxPTbvdSjXeJTauHCrCiDvBfAkbYNS2Ztjz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iCNfcoq3Sr107b22+cdE2Ld7d2ByX29MCkiGx3zXALgDg2t2qu1Wbv184FotOQgcJPD5pSCJvXZlzCwq4jmh4WjesmGqqrI7UJlwzMT0tfpW0emxqiF3XoHhpg6bGq9Y0sFR6FlAFLKlNWKPF4e4ZhNPqd4vK4NcZmW0STqeoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACH7zk+4qtq1N+ACA--.3070S2;
	Thu, 17 Sep 2026 20:51:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: catalin.marinas@arm.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nsaenz@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix np reference leak in of_unittest_dma_get_max_cpu_address()
Date: Thu, 17 Sep 2026 12:51:10 +0000
Message-Id: <20260917125110.2152065-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACH7zk+4qtq1N+ACA--.3070S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JryxGr1rCw18Xry3tF1kXwb_yoWfuFb_GF
	9ru3sxGFW8CF1UWw1fXryfZFnFya4UXrW8Wr1jvr9IkryavF17Jr1S9rn5Jw15Zw4a9F9r
	Kw1Du340krnrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07jngAwUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAENA2qrrJqljQAAsc

of_find_node_by_path() returns a node with an elevated reference count,
but the function never drops it. Add the missing of_node_put() before
returning so that the reference is not leaked.

Fixes: 07d13a1d6120 ("of: unittest: Add test for of_dma_get_max_cpu_address()")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 5259c45e355d..d1a88a043300 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1110,6 +1110,8 @@ static void __init of_unittest_dma_get_max_cpu_address(void)
 	unittest(cpu_addr == 0x4fffffff,
 		 "of_dma_get_max_cpu_address: wrong CPU addr %pad (expecting %x)\n",
 		 &cpu_addr, 0x4fffffff);
+
+	of_node_put(np);
 }
 
 static void __init of_unittest_dma_ranges_one(const char *path,
-- 
2.34.1

