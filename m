Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03EE1FFC59;
	Wed, 15 Jul 2026 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104812; cv=none; b=Lfjcm4ak5weK2OfwdTOrFY25HWnFctcZFNUfLE+DjeRSYg6+XQrLWcmRXYx7vcBxSkpn4QRi2zzdudvO+SrmNwjcgCVFlUZJbivQZFj9RYx2sKcoLqHAhuHHypsqpx34Y3QKWbEp4MvGdHoYSyST7lICrGqLRh0VKo2YF/u+Usc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104812; c=relaxed/simple;
	bh=DtKNGi4IZ5/I+3fMt4ih3b9LM3eNTB0Ei4iJADOBR14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lfv4bHhemczrA9+hmBFKGwdoJW3dKnvXvPPOPN7yAPdzJuu2agRBhhTfFa8V8nb/ZWUomrdKXwWS6asKFEqtNmFl68H1FkaFoXleQaQGmOGhc10JelbkCRhrditFFsElo2eVIf51PIcvy71hcI+tfSsTqKMr9M9domJNM0L0ZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowABXo8ZmR1dqRV9HGA--.10286S2;
	Wed, 15 Jul 2026 16:40:06 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Laura Abbott <labbott@fedoraproject.org>,
	stable@vger.kernel.org
Subject: [PATCH] media: si2157: validate firmware record length
Date: Wed, 15 Jul 2026 16:40:06 +0800
Message-ID: <20260715084006.34310-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXo8ZmR1dqRV9HGA--.10286S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1kKw1xAF43tw18ZFy7Jrb_yoW5JrWfpF
	W5XFZ8JFWqqF4S93Z7Cay3uFySv3yxGayUGa9xuwnYyr1YvF1kArWjga42qF1I9rn3ta4U
	Jr97try3u3ZrAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU2Q6
	JUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The Si2157 firmware loader treats the firmware blob as fixed 17-byte
records.  Each record starts with a command length byte and has only
16 bytes remaining for command data.

The existing check compares the command length only with
SI2157_ARGLEN.  That protects the local destination array, but not the
source span of the current firmware record.  A length from 17 through
SI2157_ARGLEN therefore makes the memcpy() read into the next record,
or past the final record at the end of the firmware blob.

Name the record and payload sizes, and require the command length to
fit both the current record payload and the destination array before
copying it.

Fixes: a828d72df216 ("[media] si2157: Bounds check firmware")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/media/tuners/si2157.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index d517a91e6fbc..126703e9d92f 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -13,6 +13,9 @@ static int tuner_lock_debug;
 module_param(tuner_lock_debug, int, 0644);
 MODULE_PARM_DESC(tuner_lock_debug, "if set, signal lock is briefly waited on after setting params");
 
+#define SI2157_FIRMWARE_RECORD_SIZE 17
+#define SI2157_FIRMWARE_RECORD_PAYLOAD_SIZE (SI2157_FIRMWARE_RECORD_SIZE - 1)
+
 /* execute firmware command */
 static int si2157_cmd_execute(struct i2c_client *client, struct si2157_cmd *cmd)
 {
@@ -103,7 +106,7 @@ static int si2157_load_firmware(struct dvb_frontend *fe,
 		return ret;
 
 	/* firmware should be n chunks of 17 bytes */
-	if (fw->size % 17 != 0) {
+	if (fw->size % SI2157_FIRMWARE_RECORD_SIZE != 0) {
 		dev_err(&client->dev, "firmware file '%s' is invalid\n",
 			fw_name);
 		ret = -EINVAL;
@@ -113,9 +116,11 @@ static int si2157_load_firmware(struct dvb_frontend *fe,
 	dev_info(&client->dev, "downloading firmware from file '%s'\n",
 		 fw_name);
 
-	for (remaining = fw->size; remaining > 0; remaining -= 17) {
+	for (remaining = fw->size; remaining > 0;
+	     remaining -= SI2157_FIRMWARE_RECORD_SIZE) {
 		len = fw->data[fw->size - remaining];
-		if (len > SI2157_ARGLEN) {
+		if (len > SI2157_FIRMWARE_RECORD_PAYLOAD_SIZE ||
+		    len > SI2157_ARGLEN) {
 			dev_err(&client->dev, "Bad firmware length\n");
 			ret = -EINVAL;
 			goto err_release_firmware;
-- 
2.43.0

