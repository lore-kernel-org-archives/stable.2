Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A425149E5C7;
	Thu,  8 Oct 2026 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464341; cv=none; b=R5sCOUfnVBg+B0JS5gLVjQSo5gEVSafphPWhAs944EpV6OBkpbz+9PenHHqPZhlp7UfMOexrT0I8Rxs7KSQ3DOdW6OYS6od9NB21/vn0yy8Ii8YCENlIRSccwMPVBE6S8aR+XX4t/Q1Rg7DIaM23ftmAiXQ/mvNrR771EyZLuoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464341; c=relaxed/simple;
	bh=DhEd5i5pKXd3AEBuOFthq56R7qyDiuJgPQI3ItLa7OM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DtFH9FpfMirFpG728D6QxI67Rw3lpNqqyxWP5DpvemKbsR+yHADazzmsB/47qImEAs8ZnPpT6NrDnx9mo9SE0ArVYiJApH8XAwiSBQeE7r48TdSL/AmZUJhaUHdW7xe+GD5s5zGyDVn7hc6adRTuFaSV7l/Wfb+ymIqfomCDEso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=LiH/tPoO; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LiH/tPoO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mr
	cCKlAt0s4Z5C37o82vZjoMrryZh2UceEpNbjZksCE=; b=LiH/tPoO5CDory7wIH
	OY5k7QYbyo3/LrWXisAIPGx7y6V77Gl3y5wDTFY8NYk6aERtO3aZrcPheJ5tFWvd
	pjFUYnDzz1iaO2h5bNGIfykj+t+1m1QTNHpYp7Wovk1ihQ9bump0b4haKSe6JuLi
	Wemt2YCuGvljS8ZxnX/01A73Y=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3v8NWk8dqh6CpBA--.7046S5;
	Thu, 08 Oct 2026 20:58:03 +0800 (CST)
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
Subject: [PATCH iwl-net v3 3/3] ice: free the VF MSI-X vectors when VF start fails
Date: Thu,  8 Oct 2026 20:57:54 +0800
Message-Id: <20261008125754.3520773-4-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261008125754.3520773-1-xiaolinkui@126.com>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgD3v8NWk8dqh6CpBA--.7046S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF43Xw17GF47WrW5AFy7ZFb_yoWrXw4Upr
	Z5Zr9xKr4kJF17W395Ww1UZas3CayftFWru340kw1Skws8GryaqF1UKryavFyxGa97Aaya
	vw4Dur1ruw1DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UH5lnUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBuHXmrHk1s3YwAA3n

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ice_init_vf_vsi_res() reserves vf->num_msix vectors out of
pf->virt_irq_tracker with ice_virt_get_irqs() as its very first step,
but neither of the two error paths below it gives them back. A NULL
from ice_vf_vsi_setup() returns -ENOMEM straight away, and the
release_vsi label only releases the VSI.

ice_start_vfs() leaks the same vectors. Its teardown loop undoes the
queue mappings and the VF VSI of the VFs it already started, and the
eswitch attach failure path releases the VSI of the VF it is working
on, but neither calls ice_virt_free_irqs(). The caller then runs
ice_free_vf_entries(), which drops the last reference on every VF, so
nothing further down the error path can release the reservation
either.

The tracker bitmap is only freed in ice_deinit_virt_irq_tracker(), so
the leaked vectors stay reserved for the whole lifetime of the driver
instance. Every failed "echo N > sriov_numvfs" permanently shrinks the
pool that ice_set_per_vf_res() divides up, and after enough retries
ice_virt_get_irqs() fails with -ENOENT for good even though the
hardware vectors are idle. ice_dis_vf_mappings() meanwhile re-points
GLINT_VECT2FUNC of exactly those vectors back at the PF while the
bitmap still books them to the VF.

Release the vectors on all three paths, the way ice_free_vfs() does
for a VF that is torn down normally.

Found by code inspection of the VF setup and teardown error paths. It
was not triggered and no stack trace or error message was observed.
Compile-tested only, not run on hardware.

Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v3:
- Correct the Fixes: tag. The leak starts at 4d38cb44bd32, which replaced the
  computed first vector index with a reservation from the bitmap and left the
  error paths below it unchanged; a203163274a4 only renamed that helper and
  moved the tracker, so it is not the commit that introduced the leak.
- Include how the issue was found, that it has not been triggered, and that the
  change is compile tested only, as netdev-bot asked for.
- Free the IRQs before the VSI is released on the eswitch attach failure
  path, as Tomasz asked for, and keep the teardown loop in that same order.
  The teardown loop hunk now sits inside vf->cfg_lock instead of next to
  the detach, so the Reviewed-by tags from Tomasz Lichwala and Aleksandr
  Loktionov are not carried over.
 drivers/net/ethernet/intel/ice/ice_sriov.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 470aec8849b6..444d05a9bcb0 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -458,8 +458,10 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
 		return -ENOMEM;
 
 	vsi = ice_vf_vsi_setup(vf);
-	if (!vsi)
-		return -ENOMEM;
+	if (!vsi) {
+		err = -ENOMEM;
+		goto free_irqs;
+	}
 
 	err = ice_vf_init_host_cfg(vf, vsi);
 	if (err)
@@ -469,6 +471,8 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
 
 release_vsi:
 	ice_vf_vsi_release(vf);
+free_irqs:
+	ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
 	return err;
 }
 
@@ -501,6 +505,8 @@ static int ice_start_vfs(struct ice_pf *pf)
 			if (retval) {
 				dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
 					vf->vf_id, retval);
+				ice_virt_free_irqs(pf, vf->first_vector_idx,
+						   vf->num_msix);
 				ice_vf_vsi_release(vf);
 				goto teardown;
 			}
@@ -537,6 +543,7 @@ static int ice_start_vfs(struct ice_pf *pf)
 		ice_eswitch_detach_vf(pf, vf);
 
 		mutex_lock(&vf->cfg_lock);
+		ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
 		ice_dis_vf_mappings(vf);
 		ice_vf_vsi_release(vf);
 		mutex_unlock(&vf->cfg_lock);
-- 
2.25.1

