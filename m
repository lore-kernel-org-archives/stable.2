Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D6379C50;
	Wed,  3 Jun 2026 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477878; cv=none; b=LSFg6bF0V48SeUqtFPb3Y91O76va4BZW+/qkD1fE+k6kmNjX3bJ1UQclXcrVJOZtds00S5XKAoifuLvFyW5cFFKqS9Idg7IWgUDbx7brf+MgbPuNYyVLsNZ0jUL2cPfaR3e26YxNhcS8bedasOZPJ/oJgcHd1o3Qe92KXATB2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477878; c=relaxed/simple;
	bh=RVXsuP055otwSc4OAxXajvPq/YxBN44okbGD0CAmTC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lqrtKhPPHkV5wZvRYvKW2gsZo/ddgsTfrPZ7qdMVEhvHoD7AXdgi88Wqatfj7F5xdVjjwwmYBedhA+FQsKaQkG5Zcd4qr/7lKBDx9cBDrErmbXyABpt+j1P/ZMgTi6twvvrTF0JIB4dmMQKR8yzGM+mO9TUaX5tWgk1SCBqPgDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABnht2s7x9qcGh8Ew--.7652S2;
	Wed, 03 Jun 2026 17:11:08 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: koby.elbaz@intel.com,
	konstantin.sinyuk@intel.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	farah.kassabri@intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] accel/habanalabs: fix refcount leak in hl_direct_io()
Date: Wed,  3 Jun 2026 09:10:55 +0000
Message-Id: <20260603091055.3730941-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnht2s7x9qcGh8Ew--.7652S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW5Kr4UKw13Xr4kuFWDCFg_yoW8Jw4rpF
	47G3WSyry5Gry29ryqkr1kuFyFkanIgry7GF1xu34Y9w1rX34xCry5u3Wqqr98CrZ5W3WD
	ZF1DGr15uF1UCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU11rW7
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCREHA2ofveXJAwAAs7

When hl_dio_get_iopath() succeeds, it calls hl_ctx_get() to acquire a
reference on the context. If the subsequent vzalloc() fails, the
function returns -ENOMEM without calling hl_dio_put_iopath(), leaking
the reference.

Fix this by jumping to the cleanup label on error, which will call
hl_dio_put_iopath() and safely handle the NULL io->bv.

Cc: stable@vger.kernel.org
Fixes: 8cbacc9a2703 ("accel/habanalabs: add NVMe Direct I/O (HLDIO) infrastructure")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/accel/habanalabs/common/hldio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/hldio.c b/drivers/accel/habanalabs/common/hldio.c
index c33c817a962a..d7dfa259bede 100644
--- a/drivers/accel/habanalabs/common/hldio.c
+++ b/drivers/accel/habanalabs/common/hldio.c
@@ -248,8 +248,10 @@ static ssize_t hl_direct_io(struct hl_device *hdev, struct hl_direct_io *io)
 	 * closest one.
 	 */
 	io->bv = vzalloc(npages * sizeof(struct bio_vec));
-	if (!io->bv)
+	if (!io->bv) {
+		hl_dio_put_iopath(io->f.ctx);
 		return -ENOMEM;
+	}
 
 	for (i = 0, device_va = io->device_va; i < npages ; ++i, device_va += PAGE_SIZE) {
 		io->bv[i].bv_page = hl_dio_va2page(hdev, io->f.ctx, device_va);
-- 
2.34.1

