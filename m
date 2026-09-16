Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E0277818;
	Wed, 16 Sep 2026 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575161; cv=none; b=b1YKa/MSmU+oXPShDX5rmgioVlxYOsy94Y6qI183XSUqW1lyu39ZvA/LeZvbsE/dT2vX+bPMH5QjKyrD/URW14IL2ASnhO3+HZjPi0Es8bXsyI9RC7UKFKk2IkKW7z3if/uXdEn3xC4EqinXDHUdQOiUPu2TXdrZ329Rcs4U64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575161; c=relaxed/simple;
	bh=pAcp/PWx/belsdbnp48YTy+oRAJtS3jC1L4nfrh2hPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OUGGJbadkR7GREX3tPo4I3X6HkwGrtXzke1rU856aikvES6QitUMyxjjEm7WtUhziYNADjY/I/h2NEmjwgAMEewx3xFhRdX5b+KuHe3w0Hvagq/SvPu6kyJkx9CpZovJFPkL5GotfmTzpAdqZRlIMCE56p/3UAaO9a+jZ0VMDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHKkPxv6pqc3FtCA--.21525S2;
	Thu, 17 Sep 2026 00:12:33 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy@kernel.org
Cc: dlechner@baylibre.com,
	jic23@kernel.org,
	linusw@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: accel: kxsd9: Fix runtime PM leak in kxsd9_write_raw()
Date: Wed, 16 Sep 2026 16:12:05 +0000
Message-Id: <20260916161205.2082579-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHKkPxv6pqc3FtCA--.21525S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw17Jr4rJr18Wry3ZrW5KFg_yoWDWrg_Ga
	s3uwnxXrWFvF4qgwnxAw1fZryF9ryDWF1xWw40yFW3GrWayr1vyrWUur95Aws7Xr42kas8
	Xa4kGryfXFn2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOuc_DU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQMA2qqozVKwgAAsM

pm_runtime_get_sync() increments the usage counter even on failure, so
every successful call must be paired with a put. Rejecting an invalid
scale value returned early and skipped the paired
pm_runtime_put_autosuspend(), permanently preventing runtime suspend.

Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/accel/kxsd9.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 4717d80fc24a..1186d711f4d3 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -146,8 +146,10 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
 
 	if (mask == IIO_CHAN_INFO_SCALE) {
 		/* Check no integer component */
-		if (val)
+		if (val) {
+			pm_runtime_put_autosuspend(st->dev);
 			return -EINVAL;
+		}
 		ret = kxsd9_write_scale(indio_dev, val2);
 	}
 
-- 
2.34.1

