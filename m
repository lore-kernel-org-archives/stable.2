Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217C417D79
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550698; cv=none; b=QOnC4SWvI/TX6YchTD7wXEL7mtOdi1RflRNOfUrt4UNvT1Naqny0zI5xamXrTz42A8qd7E8Iy4NIbLm6Lk0u3l3zn913RxQL1d68gcV8iRRfjwgw/siNmVAXrSOwAgS3UECN7tPzqtFjw9R8skuuFVUmAAgMixHSlgTU/ymngxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550698; c=relaxed/simple;
	bh=QE4zyqN4pgzSENArDiA0J+wf6oxfqLxGlggSasFY0qE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L2vN7CH5gdaCi3aTmSLIRhx0dDUps0uFETWHdR1MquxrmORSOYcYtwFUZyfod5YLqDuROMbfAqhEPYRqKpX08k16+aiIMYisUZeiYtFaU1FY4I3y/M39s6ptBfG9ILJITwXadRfUSNdHFcrmn82mqmyzwWAZ+1sfHGjMBL9c1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M/zFRouG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M/zFRouG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09EA1F000E9;
	Mon, 20 Jul 2026 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550697;
	bh=9BGHafjP6Xup2av4Yj3yUROUVCwgbr9xkb/mYylLKfQ=;
	h=Subject:To:Cc:From:Date;
	b=M/zFRouGDDmWLeNZK25VaYmRPWB4qrAbnD50D6lf/RKWRT0hY18XdG1sz0aLbh/Z/
	 bwsyN45oY0iQkGA0y7tCPqW6Ragkj/FqwdSfjDhsBU/EMVtsX609KuSUofTkFOVxk2
	 49P52zFsZFYU0WUEFOBJ+b8fJ9kyAViqKpr9/9z4=
Subject: FAILED: patch "[PATCH] mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()" failed to apply to 5.10-stable tree
To: vulab@iscas.ac.cn,idosch@nvidia.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:28:25 +0200
Message-ID: <2026072025-thirsting-chance-450b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 41c8c1d65b32beacd8d916a22457b4f6e47f45af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072025-thirsting-chance-450b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 41c8c1d65b32beacd8d916a22457b4f6e47f45af Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Tue, 9 Jun 2026 08:37:09 +0000
Subject: [PATCH] mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()

When mlxsw_sp_port_lag_index_get() fails, mlxsw_sp_port_lag_join()
returns an error without releasing the lag reference obtained by
the earlier mlxsw_sp_lag_get().  All other error paths in the
function jump to the cleanup label that ends with
mlxsw_sp_lag_put(), so this is a single missed release.

Fix the leak by replacing the bare 'return err' with a goto to the
existing error cleanup label, which will drop the reference safely.

Cc: stable@vger.kernel.org
Fixes: 0d65fc13042f ("mlxsw: spectrum: Implement LAG port join/leave")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260609083709.209743-1-vulab@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 1aaa75b47fe3..82569162d2e5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4360,7 +4360,7 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 	lag_id = lag->lag_id;
 	err = mlxsw_sp_port_lag_index_get(mlxsw_sp, lag_id, &port_index);
 	if (err)
-		return err;
+		goto err_lag_uppers_bridge_join;
 
 	err = mlxsw_sp_lag_uppers_bridge_join(mlxsw_sp_port, lag_dev,
 					      extack);

