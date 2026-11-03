Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700332;
	b=COmJs2H8RuqoDSM2yMcxa7NThnyIR3h5zGLPtoBP3efcDvZY3uZegtUL+m1JphckLwpg
	 2GhYTNZa7dDExYQGdAxQtWF6DNojTwBcCfGKs+WeRhAmM477oeHMxx25Bj29dW1eeCddA
	 9nIUHfxKC8XMum2VphETOzoruQfsg3UwT+qzkzrcEMGUKMfos1ZQwo8++LeROXpoSfcIu
	 ZCZiLyG0UFdb52G7I6wAfDa2QAppSQvF38dl15pG6xmdUe+jBbyLmkuIOteC2aHtQsyIg
	 XC4unKkcRgF2cdnxoDRzRWZw21UKML5nAs3L2jAzW7+k+njwU93cjqlaRBJ9Hb22cGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700332;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=rZ9WlIoFMrK8NZbiJMk1yzq1Nay459FdXX6Lq4xdVxo=;
	b=rOof5o8Kzq1nA9XrQu8nzDGy8y1GL64xy0sr8FX68YqTLTi+APMkbBnwooN2gjLP/xh8
	 oSRC3s2nTu2ws5eEjuoeyBXyOdRD1drFAz3xlZLDuuyHpY69sTlxfgPfSPHAO+OBoYWkL
	 CQB6MFCpKGQmriXvmms3g5OqhVFPDB7QGlUudnnJv+kp1ZOQXfdTANVJi6pCsbNLWeQ4G
	 i+a8bBvHS3MYmrCCZgqTzKG801MtG91RJmCUSRKieJRhX2O0/OTjhaKOB7CXn6CccT4B+
	 LVdjkaXvGUYVuW0psPx0POVk2I5BLP1F8CxJFffjM5DRdqwIHX3JB1GjTCftgq6iAmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EABC606FAED;
	Tue,  3 Nov 2026 10:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EABC606FAED
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3QpPhselqcXs7AA--.2857S2;
	Tue, 03 Nov 2026 18:05:21 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ice: release the VF reference in the switchdev trust path
Date: Tue,  3 Nov 2026 10:05:30 +0000
Message-Id: <20261103100530.1309907-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAA3QpPhselqcXs7AA--.2857S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1rKr43WFykJF4kuF4DJwb_yoWkKFb_Ww
	43Zr93Xr4UuFnY9w4Fkr13u3s29FyDWasYya9Fy393G347Cr17CrykWrnxXr4IgFZ7uFyD
	Zw1a9FWSy3WYgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JjU-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgIAA2rpnIRi4AABsf

ice_set_vf_trust() takes a reference on the VF with ice_get_vf_by_id()
and then rejects the request when the PF is in switchdev mode without
dropping that reference.

Return through the existing out_put_vf label so the VF reference is
released on this path too.

Fixes: 1281b7459657 ("ice: Forbid trusted VFs in switchdev mode")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index c49f48b5ae38..90bf1becbc3d 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1400,7 +1400,8 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	if (ice_is_eswitch_mode_switchdev(pf)) {
 		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out_put_vf;
 	}
 
 	ret = ice_check_vf_ready_for_cfg(vf);
-- 
2.34.1

