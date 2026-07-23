Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E167E21FF30
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769408; cv=none; b=lPQT3ZpBME5dx3nnfKq4r/ogc8D+rPCf9x48XfV091NLu+6NyOLV8MNcLieKpVnCo6QDD3dBf7Pe8+NkjW+xLFEnusyOWDmtoAHXAnwyel7YLKwt5BKjUWBW6xZQmJSE54j90Vv9cUwi/9AutF6FrJhZBVJCHCgFNzzo/22WFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769408; c=relaxed/simple;
	bh=22ZPFWEHv88L9cCQ16Qfx9qSBGnCHWSOzr8VdLPd8DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCzbqVgzfZK8/K167tA2HChxB6OMrl9wzwX/dPYJ7z3lnLxkm4GOwUERZHgywuAZWMImH+YBYr+YN8Q0SjpQiHrVcGBLwyARZKYMiQn1K5DX3Aux59pi30Dq5uXI3iUYs19iFVwE2JH4l9Ki8HlduOOPHcoI4KFnIGmXYXQg8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU+MMt06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU+MMt06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB881F00A3D;
	Thu, 23 Jul 2026 01:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784769406;
	bh=/GtqrXNjsWhwfxvdwN2FCqMxZco97e9g35nsSQNQ5Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AU+MMt06LjiRFB5pjxoUAY6ev8jibsS3OMWsw7rV4dr9/b57/ZyzfpBCa70Gpa5vY
	 GfHHUtvw8IBeyWBpgGULuJ6mw4RtflZ9o17ClhLcfZLn9vGgA8JReji8AjHl0MBmU+
	 YkDkU6mrfuIgahvUjK5oEIcRNVP4P3p1NqgzLGIOUKQCqIsE582YyFGWuK59/y8Xl7
	 w4cZ3hrZRN1KMUgfJnQZn6w9ssYUMhOPi2UaBlLntn7HOb77CUT5w4Z6xiKXp7YeeG
	 PBjsHtjInnx4+iJ9Rvix77R74Q/RCrkKzBOlfQPKMdATfproWnF0qdibfe8AAFVeiK
	 yeFy2igsbUGOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()
Date: Wed, 22 Jul 2026 21:16:43 -0400
Message-ID: <20260723011643.2779021-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723011643.2779021-1-sashal@kernel.org>
References: <2026072025-extended-consumer-8888@gregkh>
 <20260723011643.2779021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 41c8c1d65b32beacd8d916a22457b4f6e47f45af ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 8d1e7b018e9ac5..6fd3fdab1c2855 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3942,7 +3942,7 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 
 	err = mlxsw_sp_port_lag_index_get(mlxsw_sp, lag_id, &port_index);
 	if (err)
-		return err;
+		goto err_lag_uppers_bridge_join;
 
 	err = mlxsw_sp_lag_uppers_bridge_join(mlxsw_sp_port, lag_dev,
 					      extack);
-- 
2.53.0

