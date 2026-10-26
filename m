Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019488;
	b=wt73UbmQK48N9+0/Z6g9OOTeIKTuHPOEJJLiCb5qOX1XiLCWhZvaXht56PHLSWjPsRBk
	 U4pEqtk3PZxZ/HhcThPc+VD47AwHqoCYpkh7ylxgruwoBm86c+ZLZ1mp/aQKYmhPFj3fm
	 jbZzdRCwf6W1AZacuaWWO533Qc1naxvyBWfTSdfw4CFovetPpxuA/OT4LNcTq16YQwpT8
	 KfYshEqNKz2h8Njx6q9sFwhER46GCRLiBg/ZnGQWE3DMWJ3Lv/0Mm9EBkoxMns68Qn+a6
	 5Xfi0sAbtZM6WJsFfsNjZgLQyRB0E+cjb6xrPCyZgWrwjpcrXm83UYlAr0VMFTu2EJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019488;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ToZZD0Obeg0Xa6g9HYqT7uDqMstDkR4DubuPZKlx2ys=;
	b=vG3JJCtR7RObYuOAF7R4aT0ZCNXJFvg6LcimWSDqV925czVO/LpqYyPZf+Bz9cq/KtBG
	 u2mNUSouqxky0K8BRbigfv1IJx7mXv8o4WLC6a6sNT53j+gra4jfaDJz8q8Z63TKokiDJ
	 uFCf/WA9XFWXQP856WJGr8l5jrWBrIie2500x03w3lj7QlUkH0HrvyGx30tWBsEyitEjf
	 pcLsJkvkwz4YcNVUS6k+TzJDXPs0A4q2D77ixia/76RApIUaQMPA26ucA1YjYq7KKCMkH
	 85blnXRl/plyQ8psxQQiFdXO2E/feuLF1SACQ7UzJEEXx2ch565PalXVwLKltDXddMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7361606A31F;
	Mon, 26 Oct 2026 12:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7361606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=ToZZD0Obeg0Xa6g9HYqT7uDqMstDkR4Dub
	uPZKlx2ys=; b=qraZ2Z/CNbiVrHZF6WfvxgQXYiqWkY9CpRQypuQqUT/K5T/CmF
	Da8Yfsd1E3eUtPvJN7N0IQ1Ek2mm0qbBqclYdQLdsYGO0x+bZzFpb5/nPSsbnMwD
	1JYUI4fF7VKISEpupRqEhIMJIxqnVElaheylsjkEel0U/5UPTQgEvHSNE=
Received: from localhost.localdomain (unknown [113.200.174.126])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkDWGwFJTt9qbqzpAA--.7289S4;
	Mon, 26 Oct 2026 20:57:52 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Anssi Hannula <anssi.hannula@iki.fi>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] media: rc: ati_remote: fix NULL input_dev when mouse=0
Date: Mon, 26 Oct 2026 20:57:31 +0800
Message-ID: <20261026125731.1952-3-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261026125731.1952-1-25031212351@stu.xidian.edu.cn>
References: <20261026125731.1952-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkDWGwFJTt9qbqzpAA--.7289S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4ftF4kAw1xZw48Cw43trb_yoW8Ww17pF
	W5AFWF9F98G3WUCa1xKw47Z3Z5Awn3XF9xGw17Wwnrurn8uFy7CryrKa43Wa4UCr1Fka43
	XFy5tw1UCFW5AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmSb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26F4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62
	kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2
	z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I
	0En4kS14v26r126r1DMxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07jaQ6LUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUSD2reG1O7tQADso

The "mouse" module parameter disables the mouse input device, but the
rc device is still registered and opening it submits the interrupt URB.
ati_remote_input_report() translates scancodes 0x70-0x7e through the
mouse table and reports them through ati_remote->idev, which is never
assigned in that case, so input_event() is called with a NULL device
and dereferences it.

The driver used to return early from ati_remote_input_report() when
there was no mouse device, but that check was dropped when the scancode
handling was reworked for the Medion X10 Digitainer remote.  Restore it
so that mouse events are dropped when the mouse device is disabled,
while remote key scancodes are still handled by rc-core.

Fixes: 9d454d48ebcd ("[media] ati_remote: add support for Medion X10 Digitainer remote")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/rc/ati_remote.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/rc/ati_remote.c b/drivers/media/rc/ati_remote.c
index 8543612d5a60..5b33097c59e1 100644
--- a/drivers/media/rc/ati_remote.c
+++ b/drivers/media/rc/ati_remote.c
@@ -551,6 +551,9 @@ static void ati_remote_input_report(struct urb *urb)
 		}
 	}
 
+	if (index >= 0 && !dev)
+		return; /* no mouse device */
+
 	if (index >= 0 && ati_remote_tbl[index].kind == KIND_LITERAL) {
 		/*
 		 * The lsbit of the raw key code is a down/up flag.
-- 
2.34.1

