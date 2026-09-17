Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F94C9E1C;
	Thu, 17 Sep 2026 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643676; cv=none; b=u4Fdhk43EdzussPgOWR2YZKdB1uvBdAmYAMoJDobbJtiIwbajdsMAC2Sr24I7UFSr6R4GzKT2iyilsJWf7neRMXwLU9yCK7ttzG6ztTbqVI52v7efPZN9WmrYbfNB8q5B2BjaehdBOFo+ZLA+kSc+l7CrEX5C3DIASGixerTVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643676; c=relaxed/simple;
	bh=dEaCh1YC7IKaUfgsPKjIzoM8IKe+rzvjuY3Xfp2nswQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CIqD4SY0asSPUPSrsFGqTjAzDGrlnUnDI6PWbeCOY7yjJ1jbKDiG6P3qFCL8VakUoNfYLPjy2o4inazUSA6zbyUemFTG6+ZZ/KLDT2Nmi34e2m4lQXmYL2kM+3C0pO33k2neRvDSHHM4X4e1vXzUvOlXHvqqAR3/xLpSW/zPHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC36EKKy6tqE1V_CA--.1509S2;
	Thu, 17 Sep 2026 19:14:18 +0800 (CST)
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
Subject: [PATCH] ixgbevf: fix xfrm_state reference leak in ixgbevf_ipsec_rx()
Date: Thu, 17 Sep 2026 11:14:18 +0000
Message-Id: <20260917111418.2148632-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC36EKKy6tqE1V_CA--.1509S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr43XFy8XF43tFW5Jr4fKrg_yoWDZwcEk3
	4UZrn3X3y5KrWFvw4Ykr4fCayI9w4DWr1IqrWxtFy3try7Jr1xJ39Fgr9rZr4DXrW8AFyD
	Ar17Cryxta4YgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgkYjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
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
	vjxU7WE_DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRINA2qrq01sjwAAsR

ixgbevf_ipsec_find_rx_state() returns the state with an extra reference,
which is handed over to the secpath on the success path. When
secpath_set() fails, the state has not been stored anywhere yet and the
reference is dropped on the floor.

Release it before returning.

Fixes: 0062e7cc955e0 ("ixgbevf: add VF IPsec offload code")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/intel/ixgbevf/ipsec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index 076fd0a24858..bf3fcab3bd57 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -596,8 +596,10 @@ void ixgbevf_ipsec_rx(struct ixgbevf_ring *rx_ring,
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

