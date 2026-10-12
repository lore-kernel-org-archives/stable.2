Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A127C3A0B31
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805353; cv=none; b=eKUhugBWuNprroCEUqAmTskQmlQanMH6kSSQDl83Ik4BXOsb79yXN9f05xfkMYpbaWLujvSsxEizgl3DzfegPPJ4URv6lEPccbD81RgWV0HdZcDZVd9qbsDmGTgG/Rfz1+AWtqlpUbGiNBE/D+sJApmFmcrWe6O4aLjiuXidSZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805353; c=relaxed/simple;
	bh=547NcUCppSyw2qXA3sArGnAzNQDdyK6WCfZQAy67icA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F3LE1oBc6AHXfXOXKwL44X8MY7zaRFMX5/IXAQJom/C/GXc6vmkfGNmZHRDyo5E/suD3SHCYzvRSGNLDRQcfOp5NdS6Zle7RzrWyQtNFJPaZX7eok2ccMe8NRSJbwfPsaNlKv8VZ4Z2qf23Q9oPWJnVCY62/XKxpI/338VqDmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eo4A0NYv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eo4A0NYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1F61F0089B;
	Mon, 12 Oct 2026 11:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791805352;
	bh=0tWYzAD4PoYWSQNo0bcyy2WT8Pg7cP5zM2x69dWdS3A=;
	h=Subject:To:Cc:From:Date;
	b=Eo4A0NYvRkQYngtKvodcAFzu1m2l/cHDl5eu96lHaGOjDk2bCRJLsv7V2e0JUsGmJ
	 HWUt5krXtlhoTfZcJ+R/WQD3CMokIUhTni40cx1f6+1Q2/lNjhNFaFUSCfGg/znKfe
	 GKhaNUxIRB7LOcWhq2kBvaxNvdeQXpEy4ZApI3iU=
Subject: FAILED: patch "[PATCH] ice: fix use-after-free in dynamic port cleanup" failed to apply to 6.12-stable tree
To: luoxuanqiang@kylinos.cn,aleksandr.loktionov@intel.com,anthony.l.nguyen@intel.com,kuba@kernel.org,marcin.szycik@linux.intel.com,patryk.holda@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 13:42:37 +0200
Message-ID: <2026101237-unmoral-plaster-544b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1402fc67d2f4e2e1fc7bf8ee0825b8ad994557ff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101237-unmoral-plaster-544b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1402fc67d2f4e2e1fc7bf8ee0825b8ad994557ff Mon Sep 17 00:00:00 2001
From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Date: Mon, 28 Sep 2026 16:04:23 -0700
Subject: [PATCH] ice: fix use-after-free in dynamic port cleanup

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

diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
index 2a2e56777f9f..3ede24649002 100644
--- a/drivers/net/ethernet/intel/ice/devlink/port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/port.c
@@ -590,8 +590,8 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
 
 	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
 	ice_eswitch_detach_sf(pf, dyn_port);
-	ice_vsi_free(dyn_port->vsi);
 	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
+	ice_vsi_free(dyn_port->vsi);
 	kfree(dyn_port);
 }
 

