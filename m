Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231D2765D7;
	Tue, 11 Aug 2026 01:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410331; cv=none; b=nXw8PADGsDmVbMgOA+n22I1MAveJG0cFSf2FyYwtlatQPUTO2uCHCzB00CLSKHtjEsM8kyQmG8rbfZtZu4ajoaRECA7InsyMsmQdWfzn3+WyVWfzR5wfDCrfEpKp+3iRryo53oXBO4upF+GGJyI8iahJ9mjqWBa/YWpmpXxI57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410331; c=relaxed/simple;
	bh=YBA7pU94gXSKyfdm2+G4u9URC43yXvMVZ/Yw5dsFT0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BE8QAvh7O9iaaidQiBtMFgsv4djQouASBPSu2qHbp9kfCPSopYMozS9DA9Ky7fosvGz2DDhQS4zFYe0X3aYIEdc2nGKNXzxOaOeXUf9Yn7ANZ6hxpM+zPl5SgcVyQ9oJgAXvjoA7rrPHdnblXGKLWS/icaborrSJUfxBCytkQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCnci4_dXpqoFKCAA--.34568S3;
	Tue, 11 Aug 2026 09:05:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn2c4_dXpqGPDCAw--.32215S2;
	Tue, 11 Aug 2026 09:05:03 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-wpan@vger.kernel.org
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Varka Bhadram <varkab@cdac.in>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 0/2] cc2520: fix FIFOP work and RX tasklet use-after-free
Date: Tue, 11 Aug 2026 01:03:57 +0000
Message-Id: <20260811010359.131381-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBn2c4_dXpqGPDCAw--.32215S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?/k+I2AXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI07LG6wnUIcpg45FTZq4xM59rMe/2+9ZL9dpEOuyDwloeLa
	PL6CJhvW84OykK4wLW6p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj9xXoWrZw1DWF1UAF1xAF4fCw4rWFX_yoWkuFX_ua
	4rtan7Ww18tFnIkFy7JF4UZ34kCFW2gr4ftrW8Gw4jg34fJrsxCFs7A3y5ury8uF42kF43
	Jwn8KFyftw17uosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

This series incorporates Miquel Raynal's disable_work_sync()
suggestion and separately fixes the registration-failure path.

Patch 1 fixes the removal path: the FIFOP IRQ can re-queue RX work after
cc2520_remove() flushes it, so the work may run after the private data is
freed.  Disable the work with disable_work_sync() and destroy the buffer
mutex last.

Patch 2 fixes a registration failure: with the FIFOP interrupt requested
before cc2520_register(), a failed registration could leave the mac802154
RX tasklet scheduled across ieee802154_free_hw().  Request the FIFOP
interrupt after registration (and the SFD interrupt before it).

Changes in v3:
- Split into two fixes (removal path, registration failure), per Miquel
  Raynal's review of v2.

Changes in v2:
- Use disable_work_sync() for the FIFOP work instead of explicitly
  freeing the interrupts, as suggested by Miquel Raynal.

Fan Wu (2):
  ieee802154: cc2520: fix FIFOP work use-after-free
  ieee802154: cc2520: fix RX tasklet use-after-free

 drivers/net/ieee802154/cc2520.c | 43 +++++++++++++++++----------------
 1 file changed, 22 insertions(+), 21 deletions(-)

-- 
2.34.1

