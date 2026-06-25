Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4792EC0A4;
	Thu, 25 Jun 2026 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366190; cv=none; b=rmk8MSwFSp301Bfb3uj58E5R1ZDOst9inTBnh1clK9+rYTf63hdi2OIjZHuROzn2kUPU0g1oug2TkyF0FnsgURM+7n/fhdR/OC3bHxST6/q3645uo+MgunHK8WpK1+sq7yDloPkxJWvIsePHMObWkhN6njxwQOUHQ8/Bi1Uuvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366190; c=relaxed/simple;
	bh=hil6rLeStOccVQWYk0eNYY4GKUYDjiNJ+LAhNi+7UbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ReKtkUbIYNfyRguNFnk7Do7mf/eFPYdssxVXsa2zSsvOblgdTSrlB6sfjBhKBsgnvoqIFkoL3PcdNNPPtw9vsjy6eGNhCCwM/IkBsGHyM0K9xj1nS0E5q31m/DPS5PCkUMTFoU3waJZrboITLiaqP+YNzA6+k+w4Wj267ykE5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAB3zhHlvzxq248nFQ--.8577S2;
	Thu, 25 Jun 2026 13:43:01 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Crt Mori <cmo@melexis.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: temperature: Build mlx90635 with CONFIG_MLX90635
Date: Thu, 25 Jun 2026 13:42:59 +0800
Message-ID: <20260625054259.76774-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260624081309.77805-1-pengpeng@iscas.ac.cn>
References: <20260624081309.77805-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3zhHlvzxq248nFQ--.8577S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4xKF1rtF18uFy3CFW3ZFb_yoW8Gw4xp3
	WrJrWjkrWkJr1UJ3yv9FZ0kFWYqayFv3yUXF15J340yrs3Jay5ZrsxtrW8KFs7Wr4rXFW2
	gF9Fqr95CFy5AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0J
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

drivers/iio/temperature/Kconfig has a dedicated MLX90635 option, but
the Makefile currently builds mlx90635.o under CONFIG_MLX90632.

This means enabling CONFIG_MLX90635 alone does not carry its provider
object into the build, while enabling CONFIG_MLX90632 unexpectedly also
builds mlx90635.o.

Gate mlx90635.o on the matching generated Kconfig symbol.

Fixes: a1d1ba5e1c28 ("iio: temperature: mlx90635 MLX90635 IR Temperature sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes in v2:
- Add the Fixes tag after Andy asked whether one is needed.
- Add stable Cc because this is a released Kbuild symbol mismatch.

 drivers/iio/temperature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index f046bb2f8a98..192b65965a27 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_MAX31856) += maxim_thermocouple.o
 obj-$(CONFIG_MAX31865) += max31865.o
 obj-$(CONFIG_MCP9600) += mcp9600.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_MLX90632) += mlx90632.o
-obj-$(CONFIG_MLX90632) += mlx90635.o
+obj-$(CONFIG_MLX90635) += mlx90635.o
 obj-$(CONFIG_TMP006) += tmp006.o
 obj-$(CONFIG_TMP007) += tmp007.o
 obj-$(CONFIG_TMP117) += tmp117.o
-- 
2.50.1

