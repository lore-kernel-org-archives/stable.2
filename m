Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CCA48986B;
	Fri, 31 Jul 2026 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488429; cv=none; b=SaAXqxp3tbiFVbOMOxResrB+yM8BtgyNxVHl0rmHBcOEmVzCAPwhxIw9mDf/r4weTYwoI8X0MqG3a/64pyFwKyDKAW/IYUGB0+DN8a37xCqdw5tojGnxqrlvJYlvGAtnmgrUctYyBBqwe+KVHTZQlRKcMF4W+hE61ZTsOYgbWIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488429; c=relaxed/simple;
	bh=0ii7Rhc0O9S3lkjf50jLi7eII+vtGnAD1xO8gVzulqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AjH6oP9VsultBi1ycHZ97wh+g1wYoIa/fRZ4ajMSHigHnA38XxBVVTj99sJRrb2oB65N3p8PmU17xrHp7B6bgMdt0jy06MmOaUdhiNf88nRyL1t+dSTk7dVFoKzhQEDwtBYwlFq5kwzjrJUtvZ17TcOTyUiXVsjH1+ouC5Z7W+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wB39jwdZGxqJWpTAA--.3193S3;
	Fri, 31 Jul 2026 17:00:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgB3fDYaZGxqvp_CAg--.43373S2;
	Fri, 31 Jul 2026 17:00:10 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux@armlinux.org.uk,
	gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2 0/3] serial: amba-pl011: fix RS485 and DMA teardown
Date: Fri, 31 Jul 2026 08:59:12 +0000
Message-Id: <20260731085915.326775-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026073047-unsorted-stick-b16f@gregkh>
References: <2026073047-unsorted-stick-b16f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgB3fDYaZGxqvp_CAg--.43373S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?IzdSIwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZyCNRWVXrNC7CTxYrZAaRa6LJLLPouM96QrQijSMggK2sNA
	M5gF6rFEcLAFruHL/Wip9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7uw1DJw17Zw1DtF18Xw18JFc_yoW8WFWUpr
	ZIva9IyrWkG3WIvFsIyF48ur15Ar4rJrW7Ga1fKw1rCF13CF1rXr1IkF4fuFW7G393G3W7
	Kr40ya1rWry5JrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8TEEUUUUUU==

Hi Greg,

v2 shortens the changelogs and reworks the RS485 fix as you asked.

  1: fix an indefinite RS485 post-send-delay hrtimer rearm
  2: fix a use-after-free of the RS485 trigger hrtimers on teardown
  3: fix a use-after-free of the DMA buffers on teardown

The hrtimers are embedded in the devm-managed port. The IRQ handler can
arm a timer, so patch 2 frees the IRQ before cancelling them. Patch 1
goes first because the rearm it fixes is what keeps the timer armed.

I read the sashiko.dev review [1]. All six points it raises are valid;
this series addresses each:

  - the lockless pl011_rs485_tx_stop() in shutdown racing the hrtimer
    callback, and a TX interrupt re-arming a timer after it was cancelled:
    patch 2 stops under the port lock and frees the IRQ first.
  - cancelling the timer before it fires left rs485_tx_state stuck at
    WAIT_AFTER_SEND, so the next open skipped the RS485 TX setup: patch 2
    finishes the stop with pl011_rs485_tx_stop_now(), resetting the state.
  - the post-send-delay timer rearming indefinitely: patch 1.
  - the RX poll timer and the TX DMA callback touching freed buffers:
    patch 3.

Changes since v1:
  - split into three patches and shortened the changelogs
  - free the IRQ before cancelling the hrtimers (v1 cancelled first)
  - add the post-send-delay (1) and DMA (3) fixes

v1: https://lore.kernel.org/all/20260721042858.3187311-1-fanwu01@zju.edu.cn/

[1] https://sashiko.dev/#/patchset/20260721042858.3187311-1-fanwu01@zju.edu.cn

---

 drivers/tty/serial/amba-pl011.c | 45 +++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 23 deletions(-)

--
2.34.1

