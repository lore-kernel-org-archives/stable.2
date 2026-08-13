Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033BE471252;
	Thu, 13 Aug 2026 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633569; cv=none; b=P28r+ZgGm8DflVNQgRi9KuG+BCOQaIl25zjnEQA006BM/SiNiXdQfJvqHxX/yxKtinJ89ICX1BgrjRKMzsghfcV/EfANroo4Sg83XNh3odds2aRZ4H3NQTHhkgQS1tuYywd5VDEbUKv+r1SjOvVu9z7ePPz5Qjh+wir+JmiHNi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633569; c=relaxed/simple;
	bh=FrKqTXe4RuZmz/MmVtW19uFgRKBmh6/15DpGP69Lz9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IYG8cDQZJjred1LFVzf4aynsgz70vE4Y3FB/PvWjEzYg/QQVVubQFtlPJeHO+FWg0o9MHgYkOR1J7PsEeyxt6TS8HqsL5PGhJLDvrAlta9kksL6Pm6kCzOswJw3cqoqYnSU1tkagDuTQM3bU5YbjgNqRajl4gMkGXasrdvGZIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowACnf_NX3X1qEOB4BQ--.64885S2;
	Thu, 13 Aug 2026 23:05:59 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Antti Palosaari <crope@iki.fi>,
	Laura Abbott <labbott@fedoraproject.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v3] media: dvb-frontends: si2168: validate firmware record bounds
Date: Thu, 13 Aug 2026 23:05:59 +0800
Message-ID: <20260813150559.15187-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnf_NX3X1qEOB4BQ--.64885S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1DAr13KFW3Kr1kJr17trb_yoW5Ar1kpF
	Z8JF98tF4UWr43CasxGay3Z3WfC3yfG34UGay3G3ZYvrnI9Fy8Jayjq3yUCr1Skr4fA34U
	ZrZFqr18ZasxJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU18sqtUUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The new Si2168 firmware format stores a command length followed by
16 payload bytes in each 17-byte record. Checking the length only against
SI2168_ARGLEN protects the destination but not the source record. An
empty image also passes the modulo check before data[0] is read.

Reject empty firmware, name both record sizes, and require each command
to fit the current record payload and destination array.

Fixes: 47810b4341ac ("[media] si2168: Bounds check firmware")
Cc: stable@vger.kernel.org

Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v2: https://lore.kernel.org/all/20260715083945.33781-1-pengpeng@iscas.ac.cn/
- rebase the unchanged source fix on current media sources
- add the coding-assistant disclosure required for this revision

The old/new firmware record extents were reviewed statically; no Si2168
hardware or firmware-loading test was performed.

 drivers/media/dvb-frontends/si2168.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb-frontends/si2168.c b/drivers/media/dvb-frontends/si2168.c
index 8bc3b6eb1dd3..182c2b671508 100644
--- a/drivers/media/dvb-frontends/si2168.c
+++ b/drivers/media/dvb-frontends/si2168.c
@@ -11,6 +11,9 @@
 
 static const struct dvb_frontend_ops si2168_ops;
 
+#define SI2168_NEW_FIRMWARE_RECORD_SIZE 17
+#define SI2168_OLD_FIRMWARE_RECORD_SIZE 8
+
 static void cmd_init(struct si2168_cmd *cmd, const u8 *buf, int wlen, int rlen)
 {
 	memcpy(cmd->args, buf, wlen);
@@ -459,11 +462,15 @@ static int si2168_init(struct dvb_frontend *fe)
 	dev_info(&client->dev, "downloading firmware from file '%s'\n",
 			dev->firmware_name);
 
-	if ((fw->size % 17 == 0) && (fw->data[0] > 5)) {
+	if (fw->size &&
+	    fw->size % SI2168_NEW_FIRMWARE_RECORD_SIZE == 0 &&
+	    fw->data[0] > 5) {
 		/* firmware is in the new format */
-		for (remaining = fw->size; remaining > 0; remaining -= 17) {
+		for (remaining = fw->size; remaining > 0;
+		     remaining -= SI2168_NEW_FIRMWARE_RECORD_SIZE) {
 			len = fw->data[fw->size - remaining];
-			if (len > SI2168_ARGLEN) {
+			if (len > SI2168_ARGLEN ||
+			    len >= SI2168_NEW_FIRMWARE_RECORD_SIZE) {
 				ret = -EINVAL;
 				break;
 			}
@@ -473,10 +480,13 @@ static int si2168_init(struct dvb_frontend *fe)
 			if (ret)
 				break;
 		}
-	} else if (fw->size % 8 == 0) {
+	} else if (fw->size &&
+		   fw->size % SI2168_OLD_FIRMWARE_RECORD_SIZE == 0) {
 		/* firmware is in the old format */
-		for (remaining = fw->size; remaining > 0; remaining -= 8) {
-			cmd_init(&cmd, &fw->data[fw->size - remaining], 8, 1);
+		for (remaining = fw->size; remaining > 0;
+		     remaining -= SI2168_OLD_FIRMWARE_RECORD_SIZE) {
+			cmd_init(&cmd, &fw->data[fw->size - remaining],
+				 SI2168_OLD_FIRMWARE_RECORD_SIZE, 1);
 			ret = si2168_cmd_execute(client, &cmd);
 			if (ret)
 				break;
-- 
2.50.1 (Apple Git-155)

