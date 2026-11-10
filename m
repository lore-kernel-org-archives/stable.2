Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301402;
	b=ahNFu6wpYwSFQYIujZLyb19HaR4vjsFusUR8M9X5iMCK3AJc8F8Dpo/oQNOZ6+zaeq6a
	 xGVksIicY6YDPpZeW20pesOyBxHrQoX9BkEp8Oi7DlQsECENag75lNgKUnmOOYvmQbhyv
	 ThCZsMGAX9wEDGsCK90tsyXCmGFLgKG5Km+RU4KuQXMlvRwuGFutxOtMXJPJgexttywEm
	 rPW1ULgkya7iRPNRepUF/2+iK2StkFGyx0JMx5UjbW0BnPn1IVyuWz6La/dkVmAzuNl5V
	 /zc2G1YVcGPsk+Ie9xg6yXauKwJncjyhyNlPKo6tDIEUbutdqPOB8wtbkdKDrpUWKUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8pKo1oEO3VP8nUxaxFU+sFTw1naND9wtU7Tr0haxUyM=;
	b=l4i0A6f6ZIV7zkhu8xnR36ato/6/DF3POJgX4ArMC+1GTgZpQ84YpDASqp5NVbg4xJDb
	 uEem09evJFrg1qdcz7XwCyJ0ixwQIYWwKT1pg38iO2+0BIjs/oitRXtChv3CRysMydFq0
	 XqkpFAte+f9lr84QSNzQgg5G0ASFwko0PBilVwwk9nWT1hMFrp/vpR0UlfClmzU0rAqC9
	 xEvRlGklE8M7rNTHOY2rnOMn9xX1TfhTXn3OCp9bjE8klR/jIm/BWx4BShkVKUTQmKt75
	 e6XClmCUxqkSMBjvYbN3qUIVBTku44wsmytEgc8jhguagThMTDc6GUcAqtwsJk4vBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aQa8NbCI;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9260A260E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C9260A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aQa8NbCI
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so3515450eec.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794301401; x=1794906201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8pKo1oEO3VP8nUxaxFU+sFTw1naND9wtU7Tr0haxUyM=;
        b=aQa8NbCIL5iROR1xv9a893vuA9VKs+H4UP3noZWQVQc6eHiZUFmGQ19+107lwy8Hp2
         e9ypF7OCdmIIc25iDGMH7Xw1pnCfj/8fyNFIEb2WGQLkgvCdjP8MBZwconVQJlUXYoi1
         yDAtJErHd09SKjykRmQNmGs9Vu1Rmqu1U2+ba+1noReQUUo0c/9G9afr8Te1Yuw+iFne
         vfgEoWL045JiXncdLEqUhBzR/5xH0eTNb/e/w+EXdu/LQK1Lxo6Bxv4avKBJJd4vdbVw
         XGT0uQrgoTRt7PHMwafIP/Ur8zqyYCDaQo37i50bQO1NU1wGdFiO42y/dJp/nqvvSiit
         9ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794301402; x=1794906202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8pKo1oEO3VP8nUxaxFU+sFTw1naND9wtU7Tr0haxUyM=;
        b=mMWrI30SIvz1vddqA8seM2RbrApOR0dWJxisGpg1uwPj+fM10sFGRIcoyQ04ZQvuAB
         5NetcXeJyNcsfWtjMIqxNSi/LW4kY2dgs9JooiBgs5uJPi0qu0schcQV4qvZxlucxnA0
         UCx5K2kJivmB2pVEKpUIZkC3WfFPHefjPd/1RkilLt3IJC7pvHQ2mx9XJorWAYoowRpT
         bc0+ymBRDdRlvbV98/PE32RO3VIHXFeTSmyGCkSBamVXtvIFX/69KfzGT9WJfl61U5AL
         zZZptQ64AzbPdjtU2tD2PfnWYBTrOER55wVV//B8AWvlZMnbdnk1+vDc7q7eVsxFBCen
         VJqw==
X-Forwarded-Encrypted: i=1; AL+hErEZY5sgItiHJeAl/A8HTQ98jv9aDFijajYFhrDT0YDEeazLHPGD4dSovMst3OSyr8K0HkApnAQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9T86cQk+MWAqSWVA2EnN9wHabJiYRL18q0Nu4tJ6j7AfnHuKyY
	yaYxGglxYJ6n9W1KgSH9XCWXJ7nNhwzII3N9A1Bex9a7H3jbEt86R4CM
X-Gm-Gg: AYBFou1NPERnDyXIdqctK1412IezcfBq5R5vHf0MD5OQPFVST8jp81NoNPT3FPKPJ8k
	1Q0vWnsDMUovjYYAZ2c2AOEvUIQmxTZzcFGqmSX6hMgszu/D3ZwJVWpm87T3TDKw5umo4OKppSD
	xJIQGvsnpJL+++IMaHY3QJvQ3ZeoxjdVd8X7l3pJXGPQP8AJte3f32L1kPYVjwl7HdIK+5VqSvt
	jZ68bjTqE58D3xpslnd4kfNw4drxw3hKR9XzC4V+cTnHgH9bYs6Rrg4IVUmgFBIuY3HoTzzv2RW
	73TFkS9CYE8yOedpALrOl6DmL+Iul1QRDM7WAwIP+DJFF+R6iLLQwXEYjPlfwFLEo/ihW7edfvf
	wi2BZnbcrQB6mVkWqYtGUY+Si0e4WdNGq7+vFBj1RyCkBhoGlvA9FLiDGxnN6VyQPiDKaVBCcoT
	7Dd7tHrsAednWO34ao47CdWmkKFsBBaEmCOgSwSDeMshcceAsJhlIB7wnXRq2zdo9KIldrDI88F
	CX26rws/DvNmvEM+rSNZCBse8ji1sXRYHn6mbnVabrXjgpyKtgydwmfU03dDk615QjTJ+c+/p1T
	OU6YfY3OFKCLhfU8dcz8NLkXJRVOg40+Mze1a2HkrdFa4ggUks2i25eEm8wuhhuxv78DJQ==
X-Received: by 2002:a05:701b:2704:b0:16c:3408:760b with SMTP id a92af1059eb24-1b3b60097bemr2296116c88.32.1794301401116;
        Tue, 10 Nov 2026 01:03:21 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306e3sm5762557eec.7.2026.11.10.01.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:03:20 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v3] ata: libahci: delete the SW activity blink timer on port stop
Date: Tue, 10 Nov 2026 18:03:03 +0900
Message-ID: <20261110090303.2415681-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The software activity LED support arms a per-EM-port timer (emp->timer,
ahci_sw_activity_blink) from ahci_sw_activity() on I/O, and the timer
callback re-arms itself while the LED is blinking. The timer lives in
struct ahci_em_priv inside the port's ahci_port_priv, which is allocated
with devm_kzalloc() and freed when the port is torn down.

ahci_port_stop() never deletes this timer - nothing in libahci does - so
when the SW activity LED is in use and the AHCI port is stopped (driver
unbind / module unload) while the blink timer is still pending,
ahci_sw_activity_blink() runs after ahci_port_priv has been freed and
dereferences the freed ahci_em_priv (use-after-free).

Shut the timers down in ahci_port_stop() before the port private data is
released, only when ATA_FLAG_SW_ACTIVITY is set and skipping em_priv slots
that ahci_init_sw_activity() never set up. Because the callback re-arms
itself, use timer_shutdown_sync() so a concurrent re-arm cannot resurrect
it.

Not tested on real hardware (needs an AHCI controller with SGPIO
enclosure management and the software activity LED enabled).

Fixes: 365cfa1ed5a3 ("ahci: Move generic code into libahci")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
Changes in v3:
- Shorten the code comment (Niklas Cassel).

Changes in v2:
- Gate the shutdown loop on ATA_FLAG_SW_ACTIVITY and skip em_priv slots
  whose timer was never set up (emp->timer.function unset), so
  timer_shutdown_sync() is not called on an uninitialised timer
  (Sashiko AI review).

v2: https://lore.kernel.org/linux-ide/20261109060709.1231946-1-hj351016@gmail.com/

 drivers/ata/libahci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 001a6f5..873645c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2605,9 +2605,24 @@ static void ahci_port_stop(struct ata_port *ap)
 {
 	const char *emsg = NULL;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *host_mmio = hpriv->mmio;
+	struct ata_link *link;
+	struct ahci_em_priv *emp;
 	int rc;

+	/*
+	 * Stop the SW activity blink timers before devres frees pp, skipping
+	 * the slots that ahci_init_sw_activity() never set up.
+	 */
+	if (ap->flags & ATA_FLAG_SW_ACTIVITY) {
+		ata_for_each_link(link, ap, EDGE) {
+			emp = &pp->em_priv[link->pmp];
+			if (emp->timer.function)
+				timer_shutdown_sync(&emp->timer);
+		}
+	}
+
 	/* de-initialize port */
 	rc = ahci_deinit_port(ap, &emsg);
 	if (rc)
--
2.43.0
