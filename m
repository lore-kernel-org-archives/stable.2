Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703339;
	b=AHvISyCVA7x1URieBxBpqSrUNObLiVfJCGc4a0wQ9gfM2k/FZbuynRo5DWJA/byHsk3V
	 5EURK0juHBTlGQObNjQqiaLL6HGyAKQ8N3Q6WfiJ3gyt63pp1VmQaupF3QZHvFnXpMd1l
	 k0IvsRj5w+wL5VyltKTSg76O4o4ayPLzmp49LxXQMPwczzRsK29MPb1/ehvsiC4NyqnSB
	 Gbrt1U+2h8Fcgs9onJLYwcBIwtqATOV/sX/wwn1lL4pV1a9E1hIa9RoGVrA8DG4ThwsYS
	 Y4yCxZyCH8fCV7+aL7OdjFLbCu58V8str8ajuqGUrdCIFRjZkfAAkjVTlEycA27OYeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703339;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=rHJQTRHhiKlouAYw5wdBD6g4hZX0Zq2vNyWCu13gYbo=;
	b=kOH6977cje9xlGzmAMUp7b1ThcPDZZVjCysycuWJPkhyAjSQTNiBhOyjmSpLVF04nhy1
	 qKNoJeYj/SC3ZSg86pqeNRCNNOdvUSxUbeskToPFAGtP/xsChXVYAkiJVfv2nSa1qtMEM
	 xxjI7JccAdHdM4FPf7GSpwjXzoxrilFspl10lOpDW9zheNWhgcaMLY8MREeSMz7q952Ea
	 7khSybvzCGjMeUYyd5r8CZxAzYAEszcYq+B4RihyJ3qqVFGzsG9AxhHpgspdRvviu5tjh
	 bzHu1Ts7SUXbu9STg0eLJ/XOeSvCqBgHptxODfydGfEb+jthwHJwG2wLEPlX7KkE6Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58938606D823;
	Tue,  3 Nov 2026 10:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58938606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3wJGmvelqxOE7AA--.2948S2;
	Tue, 03 Nov 2026 18:55:34 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] power: reset: reboot-mode: drop the device reference on unregister
Date: Tue,  3 Nov 2026 10:55:43 +0000
Message-Id: <20261103105543.1394542-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAC3wJGmvelqxOE7AA--.2948S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trW8Zr1kGw1xJr4DCr1Dtrb_yoW8Gr43pr
	WUGF9xGrZYgrWDGa1xZF47ZFyrCa12yw4ruFy7Jw129Fs5Jr93t34kXFySg345ArWxtFy5
	tFy3tw1xurZFkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6r
	xdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2
	zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07jbhLnUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMAA2rpnOF-xAABsI

reboot_mode_unregister_device() looks the device up with
class_find_device(), which takes a reference that the caller has to drop
with put_device().  The function only calls device_unregister(), which
drops the reference taken when the device was registered.  The lookup
reference therefore leaks and the struct device allocated by
device_create() is never freed.

Drop the class_find_device() reference before unregistering, the same
way device_destroy() does.

Fixes: cfaf0a90789a ("power: reset: reboot-mode: Expose sysfs for registered reboot_modes")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/power/reset/reboot-mode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 3611bed341e1..db55b71f0c7e 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -249,6 +249,8 @@ static inline void reboot_mode_unregister_device(struct reboot_mode_driver *rebo
 		return;
 
 	priv = dev_get_drvdata(reboot_mode_device);
+	/* matches class_find_device() above */
+	put_device(reboot_mode_device);
 	device_unregister(reboot_mode_device);
 
 	if (!priv)
-- 
2.34.1

