Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB5A48F84D
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818301; cv=none; b=bG2EtMfCM7XjXK6m9HJ6hWTjTIPl6izWaoOZ9MfxYIgnmsGVNbw1H+7cxkdEdEutj2viLDsn4A6rLmn55CXWf0oIweZoRgRNKDIYtCYYQLSCnjfIGQHaczxte8Hya4z0VC9plWM4UBAeqo9VpqLjbdNYIijDKinOox5uCBokBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818301; c=relaxed/simple;
	bh=0wlR1ozMfHK4oK7f5MRxVxVLWpZXOQel28CyAwDrrsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCq9VspT5y0UumXrlGPyhMzEklJ00D/5Vo7QSERuI1eAuwGaHIdNxrmVOg3A8OWtkFh0SRpjVlYy6sjZaQHlPSnH8I9rWRDyplv82nGxCkgmvKBMu9wzGdnF+SN81Pu3kJJWf2SNKnpIy7tydnLeln/4Xnpkh7EQffQkmkpvPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCqJ1lRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCqJ1lRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF2D1F0089B;
	Mon, 12 Oct 2026 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791818300;
	bh=CRf2/Ww4PTTVzNutjvqjGlClYKbGV56gZVUy2B4dXoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QCqJ1lREzA9GG+DavuTinhadCClaAj4v/ECmfBK83MvKX7vTo5X0p2sNZC18cjjVs
	 3H/MgCpVhQPdLC+Xg+WNsvnNN9sqFaEyse4xAQxjmRGJK6lWz9x+dBDwcCMtpAaml9
	 xOpuk0gGFILnPmJTgekSGEMVR8x4akrpQ91Wk81JAqlvJ4xgIGUTmfhw7/1xKBFx+8
	 NqLjFX1jj4re8Abu90SvSDWw14loBNHB2hFQxUM7vERJGOqhRKD0vdVH3ksUpjinTn
	 lAbb0uZNsjWvhiz2OqhAeQBjicDFtj4zGUYR+RqS+18aJqtDfRwiWKsWnDxdOrc1uv
	 S35nWZ7OGhl4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Patryk Holda <patryk.holda@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ice: fix use-after-free in dynamic port cleanup
Date: Mon, 12 Oct 2026 11:18:17 -0400
Message-ID: <20261012151811.892517-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101237-unmoral-plaster-544b@gregkh>
References: <2026101237-unmoral-plaster-544b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

[ Upstream commit 1402fc67d2f4e2e1fc7bf8ee0825b8ad994557ff ]

ice_dealloc_dynamic_port() uses dyn_port->vsi->idx to erase the dynamic
port from pf->dyn_ports. However, it frees the VSI before reading the
index for the erase, resulting in a use-after-free.

Follow the reverse of the allocation order in ice_alloc_dynamic_port()
by erasing the xarray entry before freeing the VSI.

Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20260928230429.495442-3-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/devlink/devlink_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index c6779d9dffffd..a5859fcc10e68 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -588,8 +588,8 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
 
 	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
 	ice_eswitch_detach_sf(pf, dyn_port);
-	ice_vsi_free(dyn_port->vsi);
 	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
+	ice_vsi_free(dyn_port->vsi);
 	kfree(dyn_port);
 }
 
-- 
2.53.0

