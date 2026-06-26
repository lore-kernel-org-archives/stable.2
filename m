Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6699A1419A4;
	Fri, 26 Jun 2026 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782440845; cv=none; b=Nz0Y4rnyyWywRC8nXARgAOyddbOX1ZYzZy76updPGimX4jNmjq+gT2PNbElOVB14dZuyycxwo5d0pw+eM0OrIQPkRtSSt++rBglLTVzUEzS/4j+8IlUnQmcEWVCSEYpCbDeImjsc77tn16ToFv0zBysWhxAeds6W65xQtLQg4A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782440845; c=relaxed/simple;
	bh=pucuPKYeEQsDEIUZdJKJOC9pWrmnuAkB6Se8YHDWU8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAqxbSMgNRjhSpvDncNlmSsKkxd8iqx0fRb7FXhaA05HKsJMcdNySGKXZFD9F/ZsqMjtH1rJ+7CcMHX9vhCdNXsYegcgZY02NJCKEC8uXKDZaQcnHBtyE1kQVz4JGdnGmzBdMG268r5uj4GKS5a7pDSiL28HkbNVsIf/okXozG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.155])
	by gateway (Coremail) with SMTP id _____8Bx+HiJ4z1qvzAYAA--.37489S3;
	Fri, 26 Jun 2026 10:27:21 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.155])
	by front1 (Coremail) with SMTP id qMiowJBxSeCC4z1qim2zAA--.12873S3;
	Fri, 26 Jun 2026 10:27:18 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Keguang Zhang <keguang.zhang@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 1/9] ASoC: loongson: Fix error handling in ACPI property parsing
Date: Fri, 26 Jun 2026 10:27:03 +0800
Message-ID: <08e44a54708eae053be148524346bb8dfcd55b03.1782439646.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1782439646.git.zhoubinbin@loongson.cn>
References: <cover.1782439646.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxSeCC4z1qim2zAA--.12873S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEKCGo8wzAaFAAAsq
X-Coremail-Antispam: 1Uk129KBj93XoW7CFy3CFyrAFy8GF17Kw13ZFc_yoW8CF4UpF
	nxAa90grW5trn2ywn5XryrAFyay34ruwsrJFZrGwn7K3s7Awn8ury3KF1YqF4SyFy0yFyj
	vFW8GFZ5Ka4UGFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EPfPUUUUU==

In loongson_card_parse_acpi(), the return value of
device_property_read_string() for the `codec-dai-name` property was
ignored. If the property is missing or invalid, an uninitialized pointer
would be used later, potentially leading to undefined behavior.

Fix this by checking the return value and propagating the error
appropriately.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/cover.1780538113.git.zhoubinbin@loongson.cn?part=5
Fixes: ddb538a3004b ("ASoC: loongson: Factor out loongson_card_acpi_find_device() function")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 sound/soc/loongson/loongson_card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/loongson/loongson_card.c b/sound/soc/loongson/loongson_card.c
index 7910d5d9ac4f..ea895fe6b5e9 100644
--- a/sound/soc/loongson/loongson_card.c
+++ b/sound/soc/loongson/loongson_card.c
@@ -91,7 +91,7 @@ static int loongson_card_parse_acpi(struct loongson_card_data *data)
 	const char *codec_dai_name;
 	struct acpi_device *adev;
 	struct device *phy_dev;
-	int i;
+	int i, ret;
 
 	/* fixup platform name based on reference node */
 	adev = loongson_card_acpi_find_device(card, "cpu");
@@ -108,7 +108,9 @@ static int loongson_card_parse_acpi(struct loongson_card_data *data)
 		return -ENOENT;
 	snprintf(codec_name, sizeof(codec_name), "i2c-%s", acpi_dev_name(adev));
 
-	device_property_read_string(card->dev, "codec-dai-name", &codec_dai_name);
+	ret = device_property_read_string(card->dev, "codec-dai-name", &codec_dai_name);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < card->num_links; i++) {
 		loongson_dai_links[i].platforms->name = dev_name(phy_dev);
-- 
2.52.0

