Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C74ABBB5;
	Thu, 17 Sep 2026 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660723; cv=none; b=JJm8P1fRmKi29HhQaPSXCODsRSsJ8U1EmgdumzeM6+u2vKspj4+/9i9MAsD2nV1gK4Pp9N1wLYgybYIbbRNsgDgWCIJBGvBrjCBfbrv+X1HyKU/WKzzpbQex6CBPUre5p+mEeMNTj8XBfOkKQ/ZRyO8mzkO7wVAuNN89nCf9Awo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660723; c=relaxed/simple;
	bh=UE2kPnpE/KSANVtCidWZOTtgalw6v//bv3XK12VvzaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aglo5Kldb0/D70Hn/6YTxAcLM4NrNR3NFgowk+wy6iML058zWwGo0PO7NeDGKnbr6LfoUCXgspeKVDBJQBcCwxy8Qki7VKK9A+wIb2HL5BDGSraHIG785KKELaq6nYUXdN/XQ3foDIcztusopPyT3IYxbvFgrVuwHThALlnNk1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnF0IqDqxqnAKECA--.6268S2;
	Thu, 17 Sep 2026 23:58:34 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alchark@gmail.com
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux@prisktech.co.nz,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] serial: vt8500: Fix clock reference leak in vt8500_serial_probe()
Date: Thu, 17 Sep 2026 15:58:34 +0000
Message-Id: <20260917155834.2161361-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnF0IqDqxqnAKECA--.6268S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFW8Cw18Kw1fAF1rKFy5twb_yoWDGrbEk3
	WkC397Ar18uF4DKwn3JrZxAr9xKFWDZFy8Xa4Iv39xJF9rJFs5XFW2qrs3CanrZw409r13
	tr17Ca17Gr13XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbg8YjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42
	xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1ID73UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUNA2qr9LY71AAAs+

of_clk_get() returns a clock with a reference that has to be released
with clk_put(). If clk_prepare_enable() fails the function returns
without doing so, leaking the reference.

Add the missing clk_put() on that error path.

Fixes: 12faa35ae5cb ("serial: vt8500: UART uses gated clock rather than 24Mhz reference")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/tty/serial/vt8500_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 78a1c1eea11b..fc6fdc751b16 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -656,6 +656,7 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(vt8500_port->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable clock\n");
+		clk_put(vt8500_port->clk);
 		return ret;
 	}
 
-- 
2.34.1

