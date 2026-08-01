Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379D126B971;
	Sat,  1 Aug 2026 05:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785561133; cv=none; b=J84ZFeWNEAnuKQ7/q0vNw5TmDUstBanSANgA/ecfZ2EfGiXq5n4mgjbHCgKfaZY9WdCApASIwS2ORILrPsDlICyMddfmWqBElGxQOmEUdaQGjlWq0xFW/EAbU1iGTH01nKH0jjBBMwXe6uEhGfoGLJuvdQQAnf/sWwLIE+EbLJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785561133; c=relaxed/simple;
	bh=emLeZnw4OIjThaxhqA/LDyYQqQAnTWcFZ2CC2sUoLC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pHnE7cC1l/GSNhwlgWlKSEegPCITcXhorjOR7dbum/VmvY8Cq6640NO0020k0KaTGan8DxyT+h88V3qy6jOGYWlNeXfPlutnJ7atK0+H54SaZvFrUYXxpEgiX9TKG8bLpGuyqAQe0HhT/2d+oQVENxxXto0/OcP1nEhXD5hOPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wC3HzwbgG1qXSpWAA--.9036S3;
	Sat, 01 Aug 2026 13:11:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgAX_DQZgG1q8hjIAg--.52348S2;
	Sat, 01 Aug 2026 13:11:53 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	david@ixit.cz,
	mgreer@animalcreek.com,
	oe-linux-nfc@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH net v3 0/2] nfc: trf7970a: fix lifetime ordering around IRQ setup and teardown
Date: Sat,  1 Aug 2026 05:10:56 +0000
Message-Id: <20260801051058.354165-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgAX_DQZgG1q8hjIAg--.52348S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?dDTSsAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZyI29s4XPrUUoM/I4cEgQRhL2gcCEq3jlm1XGvHysDteGCc
	gEgLry6tynhUH1djB5ep9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxJr18Cr1ftw17Xw4fXFyxZwc_yoW8XFyDpa
	15ta1UKrWvyrnF9w43u3WxXFyrAa1rXw47uwn3Wa4xCFZ8CFnayr10g3y5ZF17Gr4fC3WI
	yFyvvFy8Wa4DJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7ID7DUUUU

Two lifetime-ordering fixes for the trf7970a NFC digital driver.

Patch 1 sets up the lock and timeout work before the threaded IRQ is
registered, and moves the lock to devm_mutex_init() so its teardown is
part of the devres lifetime.

Patch 2 depends on patch 1 and drains the timeout work across removal:
it marks a running handler to skip completion, handles LISTENING_MD in
shutdown, and cancels the work after the digital core stops issuing
commands and before the digital device is freed.

These were previously sent as standalone patches. Per review feedback
from Simon Horman they are respun as a series.

---

v3:
  - Respun as a 2-patch series with an explicit dependency.
  - Patch 1: switch to devm_mutex_init(); remove the explicit
    mutex_destroy() calls and the now-empty err_destroy_lock label.
  - Patch 2: set ignore_timeout before send_err_upstream; handle
    TRF7970A_ST_LISTENING_MD in shutdown.
  - Patch 1 was previously sent standalone.

init-order v1: https://lore.kernel.org/netdev/20260728031021.230831-1-fanwu01@zju.edu.cn/
teardown v2:   https://lore.kernel.org/netdev/20260728030716.230626-1-fanwu01@zju.edu.cn/
teardown v1:   https://lore.kernel.org/netdev/20260721133539.3195899-1-fanwu01@zju.edu.cn/


Fan Wu (2):
  nfc: trf7970a: set up lock and timeout work before requesting IRQ
  nfc: trf7970a: quiesce timeout work before teardown

 drivers/nfc/trf7970a.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

-- 
2.34.1

