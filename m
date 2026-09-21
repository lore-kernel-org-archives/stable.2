Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9D2194C96;
	Mon, 21 Sep 2026 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789960639; cv=none; b=GBOZWidNf4Hkgoa7KJajyvCu9DjV3gjPZOdq0VzY2pydhcpQONtbrsg/hHzL8FcOMbvAUqhm8r+T7kmTMcCTIMzSd6EC22VAxIkfBbbX2umIfIyZFMm+ngxoiuJlexDF+XucJJdw+CZs03Ik6+EQ+7rHppGhDlZQkoe8oKKm0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789960639; c=relaxed/simple;
	bh=Hs15HYxGNxqVANaNisUHApsJspGhjqP0fRA347dQl/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZyW5/P++z+WDHWmZTi5KCt/C9/Bg7qCWBFsf2m9HHO1iPmxVQzomHGm25GG+nEfna5ZWdASLj5tj4HhOGro1go2edVUmVF1j9ylTt7KPwW7LE+xrNPeHE/C/0nSBu+LYmRmkPEULiz4iHTODVid+1OKSCVHwt3IftHiL8bBsKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=E5Sxtr9m; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="E5Sxtr9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=I7
	fYR/PDwkxcuXTwn2JWJPrIY5xxFViS+7lj7SyyQ5o=; b=E5Sxtr9mv7TTHc9AAA
	LrEIXxnJfo5Yvkv5/6raj4FFU0qzpTX8CV3hMt9/4TRlCLMYlEDWB+t+kO4AErj3
	qiMPan3xkxQiW3rYzB7QwHnA9Nc69H+HueBKRJXjK8nA2hpSDqJYE0CBMJP3+7qq
	WZyGhI8NI2+JZG7rBdsHroXHo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnr6yCobBq+hKqBg--.25902S2;
	Mon, 21 Sep 2026 11:16:19 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] ice: detach the VF representor when ice_start_vfs() fails
Date: Mon, 21 Sep 2026 11:16:16 +0800
Message-Id: <20260921031616.3390259-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr6yCobBq+hKqBg--.25902S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFy7Jw4kAF4DZF45GF17ZFb_yoW5Xw4rpr
	Wvq34rGr4kJ3Wagw4Dua18u34ruayrCrWagr10k3WfCF45Jr9Ykr47KFy2yr18C3s7Cr1a
	va1q9r1ru34DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYzuZUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQNPJmqwoYNTJQAA3N

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ice_start_vfs() attaches every VF it brings up to the eswitch with
ice_eswitch_attach_vf(), but the teardown path only undoes the queue
mappings and the VF VSI. Nothing calls ice_eswitch_detach_vf() for the
VFs that were attached before the failure, and the caller, ice_ena_vfs(),
goes straight to ice_free_vf_entries(), which drops its reference to
every VF.

The port representors created for those VFs therefore outlive the
failed VF creation:

  - the representor netdev stays registered and its devlink port stays
    registered too. That port is embedded in struct ice_vf, so it ends
    up pointing into the memory that ice_sriov_free_vf() releases;

  - repr->vf keeps pointing at the freed struct ice_vf, and repr->src_vsi
    at the VF VSI that ice_vf_vsi_release() tore down. The leftover
    netdev is still visible to the user, so even a plain
    "ip -s link show" of it reaches ice_repr_get_stats64(), which calls
    repr->ops.ready() -> ice_check_vf_ready_for_cfg(repr->vf) and then
    reads repr->src_vsi through ice_update_eth_stats();

  - the virtchnl ops of that VF, which ice_repr_add_vf() replaced with
    ice_virtchnl_set_repr_ops(), are never handed back to
    ice_virtchnl_set_dflt_ops();

  - pf->eswitch.reprs never becomes empty, so ice_eswitch_detach() never
    calls ice_eswitch_disable_switchdev(). pf->eswitch.is_running stays
    true, with the bridge offloads and the devlink rate topology still
    up, and ice_eswitch_release_env() is skipped, so the uplink VSI is
    left in the switchdev configuration that ice_eswitch_setup_env()
    gave it.

Detach the representor in the teardown loop the way ice_free_vfs() does,
ahead of ice_vf_vsi_release(), because ice_repr_rem_vf() and
ice_eswitch_release_repr() both need repr->src_vsi to still be valid.
Every VF the teardown loop walks completed ice_eswitch_attach_vf()
successfully, and ice_eswitch_detach_vf() already returns early for a VF
without a representor, so no extra condition is needed.

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e04de0215596..1b563aba3bbd 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -508,6 +508,7 @@ static int ice_start_vfs(struct ice_pf *pf)
 		if (it_cnt == 0)
 			break;
 
+		ice_eswitch_detach_vf(pf, vf);
 		ice_dis_vf_mappings(vf);
 		ice_vf_vsi_release(vf);
 		it_cnt--;
-- 
2.25.1

