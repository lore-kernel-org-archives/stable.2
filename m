Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C91DF25C;
	Tue,  9 Jun 2026 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780975389; cv=none; b=Y8jRYWout1oYI7QTTHg6X8+Kr3gXPmx8hJbSH4SZ5e7hZjdudWK5LUP1dNhEUOsk03O3PVQBc5tOERc+6j/gzNjqNDLvGLxKEIe8SdSYrhFHmKvoSmPQ4mItFq5hvNwJmUQyBHgtuZvoD3TrBXROkeswrYEy/8McQ3HPMqKoW0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780975389; c=relaxed/simple;
	bh=oThvw+eoydCjYHbFKqhpnRjKOfUckczDSLi/6iCbh6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l2acnBNJPbwvSzhygeQHeMHeJS4lI4xiX3uTbil2kjVe/EHJvy/0ZL8Ge6jO/YaV4TqRK+ZGeRyYXmuxbEQkheTNCysL1pvPwA+O6e+cXUQK0ZkUNziflhNyZck01xVzBnAIYzk7Sgy9UqHJP+QqjrBRut64sWCX+eTYmDn3/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADnh9AKhydqlr_1AA--.433S2;
	Tue, 09 Jun 2026 11:22:50 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iommufd: fix refcount leak in iommufd_object_remove()
Date: Tue,  9 Jun 2026 03:22:43 +0000
Message-Id: <20260609032243.182433-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnh9AKhydqlr_1AA--.433S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWfGFyfJFWDKrW3WF4DArb_yoW8JF4Dpr
	43Kryagr9xtFWIyFWUGa10yFZ5tFZayFWIkrsxCw4Uur13JFyUXry5Xrn8WFyvyFZ5Xr1a
	ya17Crn3CFW3AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUtrcD
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRENA2onY0edNQAAsX

When iommufd_object_dec_wait() times out it restores the
wait_cnt reference via refcount_inc(), effectively
re-arming the counter.  iommufd_object_remove() treats the
-EBUSY return as fatal and bails out without dropping this
re-acquired wait_cnt.  As the users counter is already zero
the object will never be freed and the wait_cnt leak pins
the memory.

Release the wait_cnt reference before returning on the two
affected error paths, ensuring that the object can eventually
be torn down.

Cc: stable@vger.kernel.org
Fixes: ab6bc44159d8 ("iommufd: Rename some shortterm-related identifiers")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iommu/iommufd/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 8c6d43601afb..2fe790c2c69e 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -266,8 +266,10 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 	 */
 	if (!zerod_wait_cnt) {
 		ret = iommufd_object_dec_wait(ictx, obj);
-		if (WARN_ON(ret))
+		if (WARN_ON(ret)) {
+			refcount_dec(&obj->wait_cnt);
 			return ret;
+		}
 	}
 
 	iommufd_object_ops[obj->type].destroy(obj);
-- 
2.34.1

