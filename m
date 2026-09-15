Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42333D0900;
	Tue, 15 Sep 2026 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445325; cv=none; b=FyFdqEIrJ9RM5cZMwXhoqt37IvSWgyAj+YvBcafm6DZrmAxlO7YwV06/4TCIHNB8GXJg4UArd75mMkl5WpTmE6tllX5jgV33qUb9Xgm1PW3MrcndwFIevo3Ijyiz4RSJQRLt5yHHZuN9jyaOdEPJEJVCsAziY1my36AtzOjajOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445325; c=relaxed/simple;
	bh=RA1bTM7mXeLI4gDcroHUteQG5DGlkm2hWIvDoYTss5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AdO+zk2e+hyZqP7NyqS2Re26irkHXmZaUJudrGyI0ACAYut8DzYx/MXKczUMTBlw/RihKXe0gb40TJAFh3G267Nhq8vZSi4gZqL0kZVqWGrNGwfBZiNKvZZ5Ot9HyIxcNdLUm6MZ5cqzakwERPTseGd5tmT91j/93V0/alwaqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAB3TvLExKhqehYICA--.49463S2;
	Tue, 15 Sep 2026 12:08:37 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dri-devel@lists.freedesktop.org
Cc: farah.kassabri@intel.com,
	koby.elbaz@intel.com,
	konstantin.sinyuk@intel.com,
	linux-kernel@vger.kernel.org,
	ogabbay@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] accel/habanalabs: fix ctx refcount leak in hl_direct_io() on vzalloc failure
Date: Tue, 15 Sep 2026 04:08:08 +0000
Message-Id: <20260915040808.1724806-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3TvLExKhqehYICA--.49463S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4DWFyfAry3Zw18Jw4DXFb_yoW8Gw4DpF
	WDKFySyr9xG342ga4jvF1kuFyFkanxKry3GF129w45ur1rX34xZFy5u3Wqqrn8CrZ5C3Wq
	vF1kGryru3WUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1go2U
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwELA2qowpAKpgAAsy

hl_direct_io() takes a reference on the context through
hl_dio_get_iopath() before allocating the bio vector.  If vzalloc()
fails, the function returns -ENOMEM directly instead of going through
the cleanup label, so the context reference taken by
hl_dio_get_iopath() is never released by hl_dio_put_iopath() (and the
inflight IO counter is left incremented).

Jump to the cleanup label so the iopath reference is dropped and the
counter balanced on the failure path too.

Fixes: 8cbacc9a2703 ("accel/habanalabs: add NVMe Direct I/O (HLDIO) infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/accel/habanalabs/common/hldio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/hldio.c b/drivers/accel/habanalabs/common/hldio.c
index c33c817a962a..0577dd8ec59d 100644
--- a/drivers/accel/habanalabs/common/hldio.c
+++ b/drivers/accel/habanalabs/common/hldio.c
@@ -248,8 +248,10 @@ static ssize_t hl_direct_io(struct hl_device *hdev, struct hl_direct_io *io)
 	 * closest one.
 	 */
 	io->bv = vzalloc(npages * sizeof(struct bio_vec));
-	if (!io->bv)
-		return -ENOMEM;
+	if (!io->bv) {
+		rc = -ENOMEM;
+		goto cleanup;
+	}
 
 	for (i = 0, device_va = io->device_va; i < npages ; ++i, device_va += PAGE_SIZE) {
 		io->bv[i].bv_page = hl_dio_va2page(hdev, io->f.ctx, device_va);
-- 
2.34.1

