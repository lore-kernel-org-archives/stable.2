Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1084AC156;
	Thu, 17 Sep 2026 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643615; cv=none; b=bHsD2yZ3BL21AJHz3iXEcb8MgneiEbUZ0e5GT26Dsz2srZBs2M21ef/ZtAt9o8/bgirMTVKvNafTCAlUygZUJbJIh1Qj2d8mfc+qlwzKNSmvlZ8v00i4uSgGq5GfPbjv1yjGi+4/lG/IOuc5tutDm8wQIWES8NV0uBM4hmDaY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643615; c=relaxed/simple;
	bh=eouKk0qWlc161hhFKqiVOFPV89ASqR7w2m/KKgZrmVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iPqLsG7jyjIeP+zmBHRNGwbmK+ejxEIQENH/m2pMTWCy2ClZFkQd0freFB/M07W5wCkSMYrLwsruZZWSscSqYN8dw0tqdzFNsMZtsSDwc0XZL1foMnztg/CS5Uft+di/6WrGDtSnt/CNVFx5pMCxmEOU2UnkPkHHudKkWYoBP8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnFD9Ny6tqSlF_CA--.1399S2;
	Thu, 17 Sep 2026 19:13:17 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	sln@onemain.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ixgbe: fix xfrm_state reference leak in ixgbe_ipsec_rx()
Date: Thu, 17 Sep 2026 11:13:17 +0000
Message-Id: <20260917111317.2148568-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnFD9Ny6tqSlF_CA--.1399S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr43XFy8XF43tFW5Jr4fKrg_yoWDtFgEk3
	48ZF4fJw15KrWFyF4rKrWxua9agFs8XryxX3yIyFy3try7JF1xJ39I9rnxJrsrXrWrWFyU
	AFy7GryIya4YqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgkYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxU7H7KDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUNA2qrrRlfVAABsz

ixgbe_ipsec_find_rx_state() returns the state with an extra reference,
which is handed over to the secpath on the success path. When
secpath_set() fails, the state has not been stored anywhere yet and the
reference is dropped on the floor.

Release it before returning.

Fixes: 92103199f10a3 ("ixgbe: process the Rx ipsec offload")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index bd397b3d7dea..e44d5eed9ab5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -1197,8 +1197,10 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
 		return;
 
 	sp = secpath_set(skb);
-	if (unlikely(!sp))
+	if (unlikely(!sp)) {
+		xfrm_state_put(xs);
 		return;
+	}
 
 	sp->xvec[sp->len++] = xs;
 	sp->olen++;
-- 
2.34.1

