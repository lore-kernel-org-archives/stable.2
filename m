Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5304AAC71;
	Wed, 16 Sep 2026 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574143; cv=none; b=UhmdH5fWYwOdUHta1sgfdj3/+1gU7DcxT6119BxdXHAHjlhMJidtPlm+uWxGnouZIAiArE+1AXkvtbZ8ba+cHxBNsCUCH3gT+W4007Re04BPrpGOB/+kD83/Lo5aS+m2RLzarW4qLm0iu15Ni/D4YloTJJpdhthWflmS0sSyejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574143; c=relaxed/simple;
	bh=pQRTzx+jBfPJuiYwdZpTMoYV8UxF+cbSSs/jRXo3jvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ERZ9TL8N5huXUTvoc1AaGx+PrBQR7j1s+nY8FxMr1Z5U+6g4493m/ORjY2TTc3ItnjT0xs6iwoRrelMP04YKb9/XrLqtpR8ZdErofyW4meDsi6/P/7MMtjpUH4UUP1z9inTHjvk6B+A1PWgNROo54QJ20AZc2Jrr1/XorcYffts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABn0jz3u6pqiThtCA--.21964S2;
	Wed, 16 Sep 2026 23:55:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy.shevchenko@gmail.com
Cc: linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	westeri@kernel.org,
	wsa+renesas@sang-engineering.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: acpi: Fix adapter reference leak in i2c_acpi_new_device_by_fwnode()
Date: Wed, 16 Sep 2026 15:55:07 +0000
Message-Id: <20260916155507.2074970-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn0jz3u6pqiThtCA--.21964S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4kXFy8AF1kGw4UKF15urg_yoW8Wr15pF
	WYyF98AryjgF12ga1jqFy5AF1agr10k393KayUJwnIgFZYgryrtFyayrW09FyfAFZxWwsr
	Ar42ya48ArWqyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j
	6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUOM
	KuUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEMA2qqpO86yQAAs6

i2c_acpi_find_adapter_by_handle() returns the adapter with a reference
obtained via get_device() in bus_find_device(), which the caller is
responsible for dropping. i2c_new_client_device() stores the adapter
pointer without taking a reference and does not release the caller's
reference on any path, so the reference is leaked.

Drop the adapter device reference after creating the client, like
i2c_acpi_notify() does.

Fixes: 53f8f7c5cf14 ("i2c: break out ACPI support into separate file")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/i2c/i2c-core-acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 28c0e4884a7f..5efd1c406bc2 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -544,6 +544,7 @@ struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
 						 struct i2c_board_info *info)
 {
 	struct i2c_acpi_lookup lookup;
+	struct i2c_client *client;
 	struct i2c_adapter *adapter;
 	struct acpi_device *adev;
 	LIST_HEAD(resource_list);
@@ -572,7 +573,10 @@ struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
 	if (!adapter)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	return i2c_new_client_device(adapter, info);
+	client = i2c_new_client_device(adapter, info);
+	put_device(&adapter->dev);
+
+	return client;
 }
 EXPORT_SYMBOL_GPL(i2c_acpi_new_device_by_fwnode);
 
-- 
2.34.1

