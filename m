Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71BF337BAB
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773740; cv=none; b=hJHFQSrh1YRxnN2/tVXk9qzbY7D01iRvGe6fFjs1N+RtMea/wZJBngmspB42THzRRTQ3u+jjmUOAMmUFHEOdAC6UAYx8dkQAZHB9rS4GW+HyK+EEqf3ZAqn+jP/Q9grQZQzXD/CoTu8D6jUqP54R3yW79312I1Nx/Cy2gfFiAWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773740; c=relaxed/simple;
	bh=KCqSzmQfRyCWRYoYy9bbvAKMR4bniQlpzn0Up8AqSTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjnfbH+Pc5oJ9SHQSBggJRfGvAfHuMHBhzjY55lynJXUHqH2Vg2lNWUo+lXvDyK/15UddyoxVrWwKXcjZ36YtcZ5rE3xqFB+6trcFOerKv84SfbzsgVKVv7NSRT/i87YvlwT/6lbE8s/QqBtiXL99tlgz3Fn4n5xKrNN1pevwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn7f3JPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn7f3JPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD991F00A3D;
	Thu, 23 Jul 2026 02:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784773739;
	bh=Zn1ZHA8zwTo3Zy1jugaBbxJ468rxi2SlkHq3u8eczTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qn7f3JPUIC60cPZ5Oh6T0HEmhBsn7akmR+5/CjNh7klSvkhnvgVF/M8/k16XdujZg
	 YJVd6XZVwP1laDgvq+1KFGUMYK7O5kepaD6+bXH79Kv8Zq2aKQakmwtFhoTcId+FrI
	 qhLIHp/wsFPvzwxDxYxdNYbbYGE6Kx3lz6sovtWdDcO9me8OfevxMXFfU+c0FGdgJg
	 HKPwYLOszK9YsgNAednkdqqkm3/S4LlbYkgkWocu7q+Zju7uhmZ7Djq/1kTT+0uhIb
	 DV09IdwBx3rSMyp7lQBp6r+RbhE2HrXkyydU5s5z0L4tUIkQW2txSIPix8qWaMf+ne
	 hFXAWMoZgmo2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()
Date: Wed, 22 Jul 2026 22:28:56 -0400
Message-ID: <20260723022856.2844792-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723022856.2844792-1-sashal@kernel.org>
References: <2026072025-thirsting-chance-450b@gregkh>
 <20260723022856.2844792-1-sashal@kernel.org>
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
index a7d2c59690ad90..86b7642f1668e4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3654,7 +3654,7 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 
 	err = mlxsw_sp_port_lag_index_get(mlxsw_sp, lag_id, &port_index);
 	if (err)
-		return err;
+		goto err_lag_uppers_bridge_join;
 
 	err = mlxsw_sp_lag_uppers_bridge_join(mlxsw_sp_port, lag_dev,
 					      extack);
-- 
2.53.0

