Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944323CF21B;
	Tue,  9 Jun 2026 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994871; cv=none; b=PHbRw16En1UFH+a+RsutGrwp7BKxvDRTnjkwb/52Z8h1mkp1qxe5zysUI2GEtaFNN5rUYPtOfzZt0BO+WGeOUJjRk5XRjhpOzWY9607YJayN9oJkdzV99g4geeFzEu1rXOSfmqDefxhgA3aC1dEqJmkAZPGiIxrM4NPfCpmCsQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994871; c=relaxed/simple;
	bh=LG+aoINgJAC7Y/fvo/TMBUo1dY7QqneuDuaM8unT4cc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=osucQNyg0XWXORzRRxR+X2cOv6PrPdeAL9ucCJWTGlG/O+uZX3gsI3XEKo7aurND/8ps8uNGLKY6gbJMfkwps1hXgFTBUEAE33HxDdARk+V7VIB9YHXdDnSi7pSRt0imMvg4zNI8QZKuAhAc9Acv1cGB3JOLVnXZtguxj1KBLkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3zhEp0ydqLCTPEg--.48075S2;
	Tue, 09 Jun 2026 16:47:37 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: idosch@nvidia.com,
	petrm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mlxsw: fix refcount leak in mlxsw_sp_vrs_lpm_tree_replace()
Date: Tue,  9 Jun 2026 08:47:30 +0000
Message-Id: <20260609084730.215732-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3zhEp0ydqLCTPEg--.48075S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrykuF4rJw4UAry7Kry8Zrb_yoW8Ar4kpa
	1xtryj9rnrtr1Sqw4DJa97Xr9xuwnFqa1UurZakw4fZr1vyrWfAryjvFyUZw1UKr48JrWF
	vF13Z3s5Aas3AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbbAw3UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRANA2onp3SzmAAAsi

When mlxsw_sp_vrs_lpm_tree_replace() fails after replacing some VRs,
the error rollback loop does not correctly revert the preceding
replacements. The loop decrements the index but fails to update the
vr pointer, which still points to the VR that caused the failure. As
a result, the condition and the rollback call always operate on the
same VR, potentially calling mlxsw_sp_vr_lpm_tree_replace() multiple
times on it while never rolling back the earlier VRs. Those VRs
continue to hold a reference to new_tree acquired via
mlxsw_sp_lpm_tree_hold(), leaking the reference count of new_tree.

Fix by reinitializing vr inside the error loop with the updated index:

	vr = &mlxsw_sp->router->vrs[i];

so that the loop correctly iterates over all VRs that were actually
replaced.

Cc: stable@vger.kernel.org
Fixes: fc922bb0dd94 ("mlxsw: spectrum_router: Use one LPM tree for all virtual routers")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 7bd87d0547d8..3d6fdbab05e0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -1018,6 +1018,7 @@ static int mlxsw_sp_vrs_lpm_tree_replace(struct mlxsw_sp *mlxsw_sp,
 
 err_tree_replace:
 	for (i--; i >= 0; i--) {
+		vr = &mlxsw_sp->router->vrs[i];
 		if (!mlxsw_sp_vr_lpm_tree_should_replace(vr, proto, new_id))
 			continue;
 		mlxsw_sp_vr_lpm_tree_replace(mlxsw_sp,
-- 
2.34.1

