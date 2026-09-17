Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C061D86FF;
	Thu, 17 Sep 2026 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649052; cv=none; b=s6vaeIcrjbRHhHI07ago1f8EczZvd60MGvTfD6f2C5dCNGx/Uf7LrK6lL2NsSH1itCiFc3Rlm8oj2fEwArE+tGViGU6zwFeF+UHd8mJYXF49uANToL4ue8YLM+/tWajrG4jHTUMQcvsiAjsmD1q3oPGpiBQDjpk6K7Xi7DoR0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649052; c=relaxed/simple;
	bh=BO1pOyd2mSHKq5WFDL+5mtxfGZAZ8PqaREwoGsapXyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KaIZLCDxMZe4l7t2y9IZK8UNDPZc0Sy/BCduth/TkWTVAZuUZPnaokZyRlQaq8tYxzrrczPRPYb65giBZpwDrM43EYGeOOZA3wx6UOaN9r8UWvNmhes6MRfbr+wEshlAhGBGXJ6fnEea9X/6ga7sCuiqxMwKcefVqfCVl+iro2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHcz2K4Ktqy8OACA--.43459S2;
	Thu, 17 Sep 2026 20:43:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: devicetree@vger.kernel.org
Cc: gaurav.minocha.os@gmail.com,
	grant.likely@linaro.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix dup node reference leak in attach_node_and_children()
Date: Thu, 17 Sep 2026 12:43:54 +0000
Message-Id: <20260917124354.2151738-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHcz2K4Ktqy8OACA--.43459S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JryfGr1ruFW5tF4rGFy3Jwb_yoWfXrX_CF
	yvvr92qrWkAF1kWFZ3Xr43ZF9Iy3W8WrWkJw1Iya1Sk34YvF45Xr1Y9rn5J345X3yF9F9r
	tr1Dur1FkrnrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
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
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07je0PfUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQNA2qrq02o6wAAs3

of_find_node_by_path() returns a node with an elevated reference count.
When a matching node is found in the live tree the function updates the
node properties and returns without dropping that reference. Add the
missing of_node_put() so the reference is not leaked.

Fixes: ae9304c9d311 ("Adding selftest testdata dynamically into live tree")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 4078569a0f96..c4d4c10ceaa2 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2072,6 +2072,7 @@ static void attach_node_and_children(struct device_node *np)
 	kfree(full_name);
 	if (dup) {
 		update_node_properties(np, dup);
+		of_node_put(dup);
 		return;
 	}
 
-- 
2.34.1

