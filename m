Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A941A4E9;
	Fri, 14 Aug 2026 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694811; cv=none; b=NyO1wZqYG+xmRmbsVLRp54AdzrPq7exrMPhXgY4zxeBmnSz80nD33GA1HVsZW5GyTQghXxmxM4sbeYDPU6uvPkIixzuhDHKOsEr167UXSUy3riUC2K9phQYvSCweogvAql8ZHIlkjhZhNC45RI6liyjWsnMNEPD45nyhYQ9gS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694811; c=relaxed/simple;
	bh=WDypw1N9FaxzUuMHKoGc7A/gdFXl5cXP9B3uJW+NcGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bhTVcc90cTbwJNLujlgE4ysxM0ecxfpZnw9P6/U/bvRsQZksiKYiDDCx/OGCC+/pRypp54QjDr7eSlSrg3HOM2iPhE5Z80EN3m5rT/8EneCFOH5WPCmbFtNahk+BzhqgIStrfDm8grQ6A+z0a+S9TBWLxJwF15k8vJjD64usuCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowAAX6+6VzH5qmuOeBQ--.5906S2;
	Fri, 14 Aug 2026 16:06:46 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Laura Abbott <labbott@fedoraproject.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] media: si2157: validate firmware record bounds
Date: Fri, 14 Aug 2026 16:06:45 +0800
Message-ID: <20260814080645.23657-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAX6+6VzH5qmuOeBQ--.5906S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyrKr4rtF4kJFykXrW5ZFb_yoW5Gw1fpF
	W5XFZ8tFWjqF1Ska4kCay3uFWav3yfGFW7GayDGwnYvF1YvF1kJ3y2qay2qF1S9rn3J34U
	JrZFqryY93ZrAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8-
	B_UUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Si2157 firmware is parsed as 17-byte records containing a one-byte
command length and 16 payload bytes. Checking the length only against
SI2157_ARGLEN protects the destination but not the source record.

Name the record sizes and require each command to fit both the current
record payload and the destination array. An empty image does not enter
the record loop, so leave that existing behavior unchanged.

Fixes: a828d72df216 ("[media] si2157: Bounds check firmware")
Cc: stable@vger.kernel.org

Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260715084006.34310-1-pengpeng@iscas.ac.cn/
- no source-code changes
- clarify that an empty image keeps its existing behavior
- rebase on current media sources and add the coding-assistant disclosure

The record layout and both bounds were reviewed statically; malformed
firmware was not exercised at runtime.

 drivers/media/tuners/si2157.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index d517a91e6fbc..340df0f99a11 100644
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
2.50.1 (Apple Git-155)

