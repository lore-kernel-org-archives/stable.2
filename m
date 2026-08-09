Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E1314900E;
	Sun,  9 Aug 2026 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786246566; cv=none; b=Ak0syPjqsUEV6+Nv3Iy7P8iUH+P2wdNsHX1nr+6Bi38AeCN0C3WaRNz/Pb3NO3DBNUCnBpH3TJp1GhbGQ4XSl23zJq0Nkc4QTfQ4p3oV8VHzcwjevoU3IGelrPC5lnlGE6pHdoLDYxVivAois6p52AfpWMXvw3ptBp9mKK4ElqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786246566; c=relaxed/simple;
	bh=IWPAPGy9vH7MTxWAG9zcneAboQuUaGBJtRUA2MuRx7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6+96hdVezlFektTgcxCWTrsF0czoZEFV1w7/EyigjMcw6xGAAg+cl54dD8X7ZJvXxvHWwkw3IOJaqx0UY0v/mILD3qCHx1GLyJrBoAori7wh7ZZXCmdEWhWzdmx5vQJc/Yc/GuWkF3AvV33LYbZaDjR7s+ZU9mqkF2etwDRqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAH4j6L9Xdq1915AA--.27924S3;
	Sun, 09 Aug 2026 11:35:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgDXCjKL9XdqUFEIAw--.44444S2;
	Sun, 09 Aug 2026 11:35:39 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Dipayaan Roy <dipayanroy@microsoft.com>,
	Sahil Chandna <sahilchandna@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: mana: fix reset work race with device removal
Date: Sun,  9 Aug 2026 03:34:26 +0000
Message-Id: <20260809033426.104315-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807124945.713853-1-horms@kernel.org>
References: <20260807124945.713853-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgDXCjKL9XdqUFEIAw--.44444S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?jWzTmwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZz/GESoQyYY5g5ROxLVgloiSWibBz7tv/ix5d2wiXMFtG7d
	zgFok0WJcWaj/I/E15vN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7tF4fJF4rCFW7Gw45AFy8tFc_yoW8Xw13pr
	y5Ga1kCr97W3yxG3yqvr1xXFy8Crs5Ja13CwnFg3W8Cwn8Ar15tr42qr4Y9ry7Crs5Gwn0
	vFWYqw1rZa1jqFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ructUUUUU==

Thanks for the review.

On the service-gating concern: I will keep GC_IN_SERVICE set on the
failed-resume rescan exit, so the existing gate is preserved until the
old device is removed.  A freshly probed device starts with clear flags,
so the bit naturally resets across the rescan, and no second service or
tx-timeout work can be admitted while mana_serv_rescan() tears the device
down.

On the lock scope: agreed that holding the driver-core device lock across
mana_gd_suspend() + the msleep() + mana_gd_resume() is far too broad.
Narrowing it is not as simple as swapping in a driver-private mutex,
though.  A mutex embedded in struct gdma_context cannot itself protect the
drvdata lookup, which happens before such a lock can be taken, and
mana_gd_remove() cannot take-then-free-then-release a lock that lives
inside the object being freed.  What this race actually needs is a drain
boundary: close admission of new reset work, wait for the already-admitted
work to finish, and only then clear drvdata and tear the context down.

I am aligning this with Long Li's in-flight series "[PATCH net v4 0/7]
net: mana: HW channel reliability and hardening fixes", which is
establishing the HWC teardown lifecycle model (the setup_active state and
explicit destroy ordering), so that the reset/remove rework follows the
same HWC lifecycle and teardown ordering, rather than introducing an
independent synchronization scheme that could conflict with that work.

I will send a reworked version once that direction is settled.

