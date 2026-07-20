Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D5C417D6A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550701; cv=none; b=Ruw44T87lOjxmk6cDoSRvDf80SbwXjkvZP3h3PoYiOARuQzPvRhUKfbQ0S7TuBEBwB3Enmn8rd5Pohsev00go/0+NiFciDFA8TfZA7p/3ABU+KRZk4qK/NEOIjCGHcuX4xvWHi/bXAgcaSyayYYobIeItGDgLItKcQZzME5IChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550701; c=relaxed/simple;
	bh=xGZZymXsSFpOnBACgPjmr5ZcC8vcHEIkaiz8VINXXjc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aW4etiXKMeBDTpD/PfC1Hictwn2kU2CSO7Alqpq2tR1klk8WyBLtQXaLOex5sJq9hyfjn1iu1t+pTUHO2IKlr9YLrl9S27oEud59OQvQ/8UnupQwvdRFed+Lp65wi+6ke07a1TDeIvA26BahMn6qBYcGhA2Tyd56WT8jsoIaiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FFH9joct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FFH9joct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5369E1F000E9;
	Mon, 20 Jul 2026 12:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550699;
	bh=IN36xLygsJkZyL69P0vF2G3H1IYN+Vt2nbRzk1JBIxI=;
	h=Subject:To:Cc:From:Date;
	b=FFH9joctnCO5H+80Q7YeSyGYU01/FvYpN4XzfQpfd/613pmPexQvZTNqM7WEfKsJR
	 m6rjlH+wYoAuDPLHZmL2AIJjNRZjh7yfg/v0A+/lfy8cXQaIWKovdGw7VbDhQriDwx
	 WY+I0yHNbB/ncNm7mRZleacttmeMS7Ak7o9WDqHE=
Subject: FAILED: patch "[PATCH] mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()" failed to apply to 6.1-stable tree
To: vulab@iscas.ac.cn,idosch@nvidia.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:28:25 +0200
Message-ID: <2026072025-willpower-discolor-ccfb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 41c8c1d65b32beacd8d916a22457b4f6e47f45af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072025-willpower-discolor-ccfb@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

