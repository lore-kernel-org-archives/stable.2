Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC2C33C18E;
	Fri, 31 Jul 2026 02:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465910; cv=none; b=p6vaIp9+A8HCb6LNeCnj9VW77Hxg+ZLjRdYhnx/8gInvNqJrc51t7V/JAsFLaoX9GIb7SbNx9a7NT1vCz/lwtzX4sRuy482+lXqVVaTmdvwD6m1E+Oyb5MoZ5OIemFdKnI8BV0OfWd7L3CreoR/Apx4J+/6w/cgi7B+Zj1igG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465910; c=relaxed/simple;
	bh=szVPcQXMTP3fnNVA681RQaf1BfEUwcjxnUUvZq9fxSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nxf9UYVkKBhJwpXDaePj++y3M8I5esM+Db3SQ2Q4hTTFb/0fB9M84hNeAW27uvOqT+7uiO9F05bfIDpix+k+oiFO36WkvNKUozIDj0hXcFt/HD7pdhZahUC1c7yl+LGv8rv+AJQIqLWjq4DqQ9tguyW7asmhDfJhKlFfLQzI/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wA3UT0XDGxqVyNSAA--.614S3;
	Fri, 31 Jul 2026 10:44:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgCH9coXDGxq1EJjAw--.19349S3;
	Fri, 31 Jul 2026 10:44:39 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	david@ixit.cz,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuniyu@google.com,
	christophe.ricard@gmail.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] nfc: reject SE I/O while a device is shutting down
Date: Fri, 31 Jul 2026 02:43:43 +0000
Message-Id: <20260731024344.317793-2-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731024344.317793-1-fanwu01@zju.edu.cn>
References: <20260731024344.317793-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgCH9coXDGxq1EJjAw--.19349S3
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?9d/8mAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI1EDM1PB+C2j8nywt/ZgZNq5XDDVYGTb/X7qfj0EuaAm9ix
	ro3au4WYx7I81bRccaGp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxWFW8XF1DWF1fCr47ZF4xuFX_yoW5Wry5pa
	sxG3WxKr92gryUWw4vyF1IqFyY9a4DuayrCFWF934IkF9xZFyFqw4kKryUZFykCrZ5AF47
	tr1YqrWUuay5JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcUDGUUUUU

nfc_se_io() is the only secure-element entry point that does not check
dev->shutting_down: nfc_enable_se(), nfc_disable_se(), nfc_dev_up(),
nfc_dev_down() and nfc_start_poll() all reject new operations once
nfc_unregister_rfkill() has set the flag under the device lock.

An NFC_CMD_SE_IO request racing device removal can therefore still reach a
driver's se_io op after teardown has begun, arming driver state (for
example a timer) that the driver's later drain cannot account for.  Add
the same shutting_down check the other SE operations already perform; the
existing error path frees the freshly allocated se_io_ctx.

This also adds an optional nci_ops::pre_unregister hook, called in
nci_unregister_device() right after nfc_unregister_rfkill() (the admission
barrier is up, so new operations are rejected) and before
nci_close_device()/destroy_workqueue() (the NCI core and its workqueues
still exist).  An NCI driver whose teardown helper touches the NCI core can
use it to drain driver-owned state at the correct point.  The hook is
optional; nci_ops initialisers that leave it NULL are unaffected.

This follows the barrier-first teardown ordering from d2492688bb9f.

Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---

 include/net/nfc/nci_core.h | 1 +
 net/nfc/nci/core.c         | 3 +++
 net/nfc/netlink.c          | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index 664d5058e..754a67185 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -82,6 +82,7 @@ struct nci_ops {
 				    struct sk_buff *skb);
 	void  (*hci_cmd_received)(struct nci_dev *ndev, u8 pipe, u8 cmd,
 				  struct sk_buff *skb);
+	void  (*pre_unregister)(struct nci_dev *ndev);
 
 	const struct nci_driver_ops *prop_ops;
 	size_t n_prop_ops;
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 5f46c4b57..86286c076 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1321,6 +1321,9 @@ void nci_unregister_device(struct nci_dev *ndev)
 
 	nfc_unregister_rfkill(ndev->nfc_dev);
 
+	if (ndev->ops->pre_unregister)
+		ndev->ops->pre_unregister(ndev);
+
 	/* This set_bit is not protected with specialized barrier,
 	 * However, it is fine because the mutex_lock(&ndev->req_lock);
 	 * in nci_close_device() will help to emit one.
diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index 0c58824cb..3132f7a90 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -1426,6 +1426,11 @@ static int nfc_se_io(struct nfc_dev *dev, u32 se_idx,
 
 	device_lock(&dev->dev);
 
+	if (dev->shutting_down) {
+		rc = -ENODEV;
+		goto error;
+	}
+
 	if (!device_is_registered(&dev->dev)) {
 		rc = -ENODEV;
 		goto error;

