Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259220;
	b=L510l/JC991VJj5IpMaFCv8CaOTTQ1eHsY0LuH4vDCYcIP4BDHAHEi2/N5Rr83l3tx4k
	 U+HjnNxRp6QGjhQSielmvRzSq1O2IaT9B4U/OIEh9nAYXILSpe1ryojqdtLittop6dLpK
	 dsU/DaVyrh35MHdxzae8UaeQD4jyY9h3iWFokZU5EBnIV8QWNp4Xx8eKf5o9I4mReQA8k
	 ZVjr2AXpTrEt44jfbMc/8Tn32VJZagPOG97r+onMNK1hXYl6Otj4NkdycfvvQ/tN2m/Zb
	 kPNTEE75iKMkOpKEu9ibVHs+uYJbGnk2NYtESlLS3p9yErmjhYNGNuibX2Q3KzPDlAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259220;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=n2h7Gd+pWSukG0+ZHwnfidKQ4JBvdEMorny+52dhSJ4=;
	b=ETfWMw+0b0Fhohc75hTzKd08HdWw/ClsunTYOldKHbZcAcQfmfedBgMy4zUgQS25nang
	 Hmx3Rn9Lx6/XxwF7TAXVKqVmr+chXE17rcHdRY+6pMQzbfY3FbaWOjAvTN8iiOV9Yq6sY
	 FSwyne9aJv0yPEBf7Hgktme81fW/QwYKEckj4MxRgDdO2xtgNHg4sfzg9ytjSI+qEVgXQ
	 wE6zkFlHLJCmW7CZju0OpLFgJ/+nxAw5H7ENph6PilUFx0XkXsyy3ZKs1ZwOrDLAj1ce6
	 pGvnlHmUUfDWD5yjuC0T7CFW2+pFSaUPmQg+vDm3NCTOYb4VNi3XhfUqx4QRmTnXdZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1500606A31C;
	Thu, 29 Oct 2026 07:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1500606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=n2h7Gd+pWS
	ukG0+ZHwnfidKQ4JBvdEMorny+52dhSJ4=; b=HhoX/9PiffgxkI9SlKevSat2dd
	6DOWHZj2A4yZ1pM90k/gKLDdNW/PSQSWl/AFZ3JH7mZR2elwhRqvotGVhGBWXmYC
	h1i6mrjz7Qs3ivsn1YOO/SfBJHPKg2yIEeGNdsGz/UEhzS0r8n4OACNVsYPvE9H0
	LrK1UU3jw5tMyaK2c=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.47])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBmpfq59uJqYfL7AA--.62846S2;
	Thu, 29 Oct 2026 15:33:14 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Ruben Wauters <rubenru09@aol.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] drm/gud: avoid divide error in gud_stats_debugfs
Date: Thu, 29 Oct 2026 15:33:11 +0800
Message-Id: <20261029073311.14556-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BLQMCkBmpfq59uJqYfL7AA--.62846S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw43KryDXF43ZF4fKr1fXrb_yoW8Zr4Upw
	43Ga4FyFW7X347Gw43AayIgFy5Za4kJFW8GrW8K34fuF45ZF1rua4YgFy0q34UJr1Iya9a
	qF1qgrZrCrW2yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBKb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r
	4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8-4S5UUUUU=
	=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUBD2riEkF-XQAAsw

gud_stats_debugfs() computes the compression ratio by dividing the
accumulated uncompressed length by stats_actual_length. That counter is
zero until the first framebuffer flush has completed, so reading the
stats debugfs file on a display which negotiates LZ4 compression raises
a divide error before any frame has been sent. The wrap-around reset in
gud_flush_rect() also clears the counter for a moment, which a
concurrent read can observe.

Copy the counter into a local variable and skip the ratio computation
when it is zero.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/gpu/drm/gud/gud_drv.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 3a1b9e2a2eaa..85ddb302d2ba 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -329,10 +329,17 @@ static int gud_stats_debugfs(struct seq_file *m, void *data)
 	seq_puts(m, "\n");
 
 	if (gdrm->compression) {
+		u64 actual_length = gdrm->stats_actual_length;
 		u64 remainder;
-		u64 ratio = div64_u64_rem(gdrm->stats_length, gdrm->stats_actual_length,
-					  &remainder);
-		u64 ratio_frac = div64_u64(remainder * 10, gdrm->stats_actual_length);
+		u64 ratio, ratio_frac;
+
+		if (!actual_length) {
+			seq_puts(m, "Compression ratio: n/a\n");
+			return 0;
+		}
+
+		ratio = div64_u64_rem(gdrm->stats_length, actual_length, &remainder);
+		ratio_frac = div64_u64(remainder * 10, actual_length);
 
 		seq_printf(m, "Compression ratio: %llu.%llu\n", ratio, ratio_frac);
 	}
-- 
2.34.1

