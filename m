Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427358;
	b=bSnwgp8/RpTE+LDjtgxOqDKjr/AvzNyitOizo/zaYEXld8wq8nfBwp8n3jxA9aIy0EGK
	 C1zb73kcP+1jv/rn1osK/NW2p3qmtGvc54sXfZc2nWhI5d1hY+ShRLBL66y7TG2PRMfJR
	 9MBpkkmbNq0PaymeyN2ClCUZB/3jrfZtwlgj+RQBxJ3iLqPYzSQQvXPniW+S7MMe47/u7
	 bg1Ry41ZdrD8hLT+XoxW7gP/Lq9ChWl3WbrrQybnrZNJQ2xQlr/waeTtXDy1RNH2aK5jS
	 3BIorVG11HhUfFRhZvOSdBf55y2IdBI3RdTmbO7rdmHeD7vUT2qKDzzs067Z1+i1bdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427358;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=5PlAEmszs4I4I295Pe06hQbjyqPhFRRqJ+vKSzs0Ya8=;
	b=BXrM5RHjWYaVDTRD1TJYdlEal2yd5U+dKyaVA0RxDbEZtAZiOhg58pgUMKFFDssREd8a
	 mf+M0AC0t957T3ec19kYKaJnC6c/oO9TgYfJkuJdsaxdIVIqqQEL8v5vy4x5pdgy6L+oZ
	 JiYsMm7JfB5DE86EBp08y6crj59yel7ofamDySoYpeyG+awlElmaF684ucSJtkQ+ktfmS
	 hhRDNO8PuB/aNvjGc9oQ8R+2BjwnCpbp1+UBG8QztkRhtMzplVo7tcd/ubXE7E6tp2AMS
	 WtiyUBcxC0ztdATuT70tbBe5li6Sqy0tnoFMtnPaeNo0d0VGZRiL7Zu4AjmRibcjFRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFBD606A321;
	Mon, 23 Nov 2026 09:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EFBD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from f3f1baf57000.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAXr7QLDARryhPDAQ--.35445S2;
	Mon, 23 Nov 2026 17:48:59 +0800 (CST)
From: liutong <liutong@iscas.ac.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <apatel@ventanamicro.com>,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] serial: earlycon: bail out on zero progress in SBI DBCN write
Date: Mon, 23 Nov 2026 09:48:43 +0000
Message-Id: <20261123094843.540808-1-liutong@iscas.ac.cn>
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
X-CM-TRANSID:zQCowAAXr7QLDARryhPDAQ--.35445S2
X-Coremail-Antispam: 1UD129KBjvJXoWruryUXFy5Aw48ZFyfury7trb_yoW8Jr4fpw
	129FyqyFW5tF1fZ3ZF9F15uFyrZa9rAry7KFyUCwnYv3sYqF4SkFW3ta4YgFyrJr97JF12
	kF4YyFWrA3Wjk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0ow
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07b818PUUUUU=
X-CM-SenderInfo: xolx301qj6x2xfdvhtffof0/

sbi_dbcn_console_write() loops until all bytes are written and exits
early only on an error. When sbi_debug_console_write() returns 0 it
stays in the loop forever.

A zero return is not an error. Per the SBI specification, the call "may
do partial/no writes if the debug console is not able to accept more
bytes".

OpenSBI can return 0 here. Its semihosting console reports 0 when a host
write fails, and SBI passes that number back unchanged.

Fix the check to use <= instead of <, so that a zero return also ends
the loop.

Fixes: c77bf3607a0f ("tty/serial: Add RISC-V SBI debug console based earlycon")
Cc: stable@vger.kernel.org
Signed-off-by: liutong <liutong@iscas.ac.cn>
---
 drivers/tty/serial/earlycon-riscv-sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
index 0162155f0c83..a8ffee389e15 100644
--- a/drivers/tty/serial/earlycon-riscv-sbi.c
+++ b/drivers/tty/serial/earlycon-riscv-sbi.c
@@ -29,7 +29,7 @@ static void sbi_dbcn_console_write(struct console *con,
 
 	while (n) {
 		ret = sbi_debug_console_write(s, n);
-		if (ret < 0)
+		if (ret <= 0)
 			break;
 
 		s += ret;
-- 
2.34.1

