Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5C4DA9C9;
	Thu, 17 Sep 2026 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644770; cv=none; b=a6gEwqbze0JQt7pL1YyyB943rPfQdDiP9y0kN6Zi1zmjS+psPM42bPY61nlG/pOMSOcstzZd3Dc8Qw8MuOQR0HdAdxPBWjN4mcwsDZuqPN1Rumr9m2hQI4OItcitFdgw2yh0mTd3MZx2OqI3O5AHHLXYf+rd3zrlSZgKi7Y4Uro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644770; c=relaxed/simple;
	bh=fbHXvmKOQi7lptd0zwotyyxzeNLMMJRcpctqvdc/Y2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MmP0r9Rtf3+V10AF7VtIe1PgsfMbj5kFDoY34YFGzdL0/1ZTKTvMasfR01J3sC+0TotGDqjM6vQkchy6q1/fGhXp02ySwYQC+tQh1uN7k47Jxug/jcItRbs5RvcXGAipl+iGXfaafxoy3SJCb5N5ydxNOrEtC+coKBzlB7imTGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB34jzUz6tqHKF_CA--.1763S2;
	Thu, 17 Sep 2026 19:32:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petrm@nvidia.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mlxsw: spectrum_flower: Fix port range register leak
Date: Thu, 17 Sep 2026 11:32:36 +0000
Message-Id: <20260917113236.2149095-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB34jzUz6tqHKF_CA--.1763S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1kWF4kZF4UGFW8ZFyrWFg_yoW8XFy8pa
	17G34jgr93Xr45Za1Dta1FqFyrKw1Iq3yruryfKasxZF1FyayakwnrZF4qkw1UKrW8Ar95
	Xr12va4rCF1DC3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x
	07bnXd8UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMNA2qrq3Z0XQACs8

mlxsw_sp_flower_parse_ports_range() acquires the source port range
register before the destination one.  If the destination lookup then
fails, the source register reference is left behind in a partially
filled rule info, and callers that pass a stack allocated rule info
never release it.  Release the source register before returning the
error so that the reference is not leaked.

Fixes: fe22f7410527 ("mlxsw: spectrum_flower: Add ability to match on port ranges")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index 353fd9ca89a6..4cad6c46b07e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -486,8 +486,14 @@ mlxsw_sp_flower_parse_ports_range(struct mlxsw_sp *mlxsw_sp,
 
 		err = mlxsw_sp_port_range_reg_get(mlxsw_sp, &range,
 						  f->common.extack, &prr_index);
-		if (err)
+		if (err) {
+			if (rulei->src_port_range_reg_valid) {
+				mlxsw_sp_port_range_reg_put(mlxsw_sp,
+							    rulei->src_port_range_reg_index);
+				rulei->src_port_range_reg_valid = false;
+			}
 			return err;
+		}
 
 		rulei->dst_port_range_reg_index = prr_index;
 		rulei->dst_port_range_reg_valid = true;
-- 
2.34.1

