Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793162960;
	b=YLdKcmC17KFC1xn0fwNUWOTPlnsX94pVUf66eXyfy64XL17z999HCa3GgH4kSMsK0cox
	 xIFz/24s1Gla1oeIZjfLHATpUusnBggHArgBa9baG6btewXyx6c78Xv8wgosR/vpAVZtP
	 LH5kVpcFaXYsSsIvT/Nudip79rS9Xp6LVskNqkLB8lKSRJjQvm5aXJFIQ2GGQAuQyMIvN
	 e+PKp4a2f6dHlD+9T9rgCMj9a6tPCg6rK0xC9/NfLyzSmfx/IA19nRVZeOJbx0lClXwl5
	 Mw3jtVbeCq9HnSXK8diuvyKrNHTRE7s+V8w0Um+QWd0cFkC0QtK2XXLZ8jrGGbm8LiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793162960;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=seWnIYzSzE0GeAEoPpg/oh0kAurOphOg2mHhQwMN2t8=;
	b=AKuFHcO8NhTp2T6ybzSQOuM0mOH1ax6TjqpqXgB+4W+w3o7kIsUrZbK6Pi8MBlOq5Re2
	 2GXf2nnwiXA79d3vuQr2gLe6ehzlNknb7QXCK8ex71RfdOVI98aCfbiU+tMLPkAciGnK6
	 EDryUJplhG9r2RzbiBs/6iw/4mO7tb15nFhU9CkXzN08xH2DqOoSoAphG1k3DOz2GYeiA
	 n/JbVvm5qWrgWcEz0wC9mbU7pvgBUSKyJTTfpot6TDbBYyFuPorqydf1WVYYGCqlQgP02
	 EsxBBmr8MnqV8FBX+pNx0HExol+w7LY6oTw325POWmXQTf0ZRmtGN9CnzK5rVLvzeIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=j338UtQz;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F8606A31A;
	Wed, 28 Oct 2026 04:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 325F8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=j338UtQz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=se
	WnIYzSzE0GeAEoPpg/oh0kAurOphOg2mHhQwMN2t8=; b=j338UtQzqIbf2TD4+h
	hwTooXTZUz5c4wQY4MsVVX3110poNlLqxdkbER4WYiDm2tH0Y2hRXq1/o5jskhDk
	8jSgFE1XNRWfUgRgqm2qPjLy4wlUIRjgODrTgLulMny8gb2NFW4dZ+NeGF+nJYB5
	Yz861hT2E8Ip6ovu14eQZWeUs=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXXyGcfuFqI22BCQ--.35298S6;
	Wed, 28 Oct 2026 12:48:34 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Brad Warrum <bwarrum@linux.ibm.com>,
	Ritu Agarwal <rituagar@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Adam Reznechek <adreznec@linux.vnet.ibm.com>,
	Steven Royer <seroyer@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 4/6] misc: ibmvmc: initialize HMC state before device registration
Date: Wed, 28 Oct 2026 12:48:24 +0800
Message-Id: <20261028044828.96177-5-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028044828.96177-1-yaojiale02@163.com>
References: <20261028044828.96177-1-yaojiale02@163.com>
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
X-CM-TRANSID:PSgvCgDXXyGcfuFqI22BCQ--.35298S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4UWryxKw13CryktF4rAFb_yoW8WFykp3
	yag3y5KrW0q3yfuw43Jw1kXFyagF18Kay09Fy3G3WxZF1kCr1qqr1DZ345AF1Fqr4q9F1j
	qF1UGw13uayUAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn2-5UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wPaFWrhfqOIqwAA3W

misc_register() exposes the IBM VMC device before the HMC state and
spinlocks are initialized. A userspace operation racing module
initialization can therefore access an HMC through an uninitialized
spinlock.

Initialize all HMC state before registering the misc device.

Fixes: 0eca353e7ae7 ("misc: IBM Virtual Management Channel Driver (VMC)")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/misc/ibmvmc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index 6afef0788b90..d03aeb8dea8f 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -2366,14 +2366,6 @@ static int __init ibmvmc_module_init(void)
 	ibmvmc.state = ibmvmc_state_initial;
 	pr_info("ibmvmc: version %s\n", IBMVMC_DRIVER_VERSION);
 
-	rc = misc_register(&ibmvmc_miscdev);
-	if (rc) {
-		pr_err("ibmvmc: misc registration failed\n");
-		goto misc_register_failed;
-	}
-	pr_info("ibmvmc: node %d:%d\n", MISC_MAJOR,
-		ibmvmc_miscdev.minor);
-
 	/* Initialize data structures */
 	memset(hmcs, 0, sizeof(struct ibmvmc_hmc) * MAX_HMCS);
 	for (i = 0; i < MAX_HMCS; i++) {
@@ -2383,6 +2375,14 @@ static int __init ibmvmc_module_init(void)
 			hmcs[i].queue_outbound_msgs[j] = VMC_INVALID_BUFFER_ID;
 	}
 
+	rc = misc_register(&ibmvmc_miscdev);
+	if (rc) {
+		pr_err("ibmvmc: misc registration failed\n");
+		goto misc_register_failed;
+	}
+	pr_info("ibmvmc: node %d:%d\n", MISC_MAJOR,
+		ibmvmc_miscdev.minor);
+
 	/* Sanity check module parms */
 	ibmvmc_scrub_module_parms();
 
-- 
2.34.1

