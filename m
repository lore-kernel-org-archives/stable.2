Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A4E3F99E3
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597298; cv=none; b=XuMEL4INr5cX8G71J0TrHINqm9/k+ACPphLnb7G6Q2u9LRduv23LFfCXzzCL0LEncUH6JQEvt7n9T+Gn1VDfWoxjLlgtizZNlfK/UJOMV8v4Jcexbpb+pfIuc4i1KSngwxCYNBonalDqKSuj6EuUBogasUZ2BxEnU4qi7ACZKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597298; c=relaxed/simple;
	bh=RzeV3/pNepAlOmUcNIVNuYFj+Z2eb+mx5eokueXDmb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGOrlYp6RXrF6xR5nH/Ai0NPGmgRmzbyEMqPxCE+tRfBYuYqBWn6zyPtIt+4R+SFbcGZOMkiafXJLHdiyPP3BZOQhxImb3I/+6sttjfrCMcZ+pHC1s8MJatO+f2v7ZXR9zsp7Ph0tKQMl25qJF+cSIskEacXHHXLJsKDSNOxd/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/ZOKfaS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/ZOKfaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01B91F000E9;
	Tue, 21 Jul 2026 01:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784597297;
	bh=G3Ok3Hrt64oJmppWa0Nwim3acIW/itMD2PIzVYY0fYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b/ZOKfaSNrywWk7p6HxMQOFzXV4RuBiMDIt7io2QMAymuFG2m2DYXKju/D1w8SUVp
	 SywDezXgUj0XBllawaMTITKM5tcl44sAEBhVSfze3s+tiW6n7zNBeKVwV6NpOPNMWZ
	 D5Vd4G31mLX0hdCm63GuKqff+AmEDF/fiGyyXP0ZZGu6hOe8/LuzwsOqu9I7FPz6wx
	 vnfRe629YK8hHcY8qE4v4PcBT/tkqp8C6gXIdRw0MvRNznDcj+fzXPv/dqmTBULatx
	 RUd0lBlp5rKopD+94n7ji7sidkTIT4lOACUge6xI1ef3+BTfBQX5CnZSFJwJ9nK7mH
	 E0H6XGh2rcXew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] regulator: scmi: fix of_node refcount leak in scmi_regulator_probe()
Date: Mon, 20 Jul 2026 21:28:14 -0400
Message-ID: <20260721012814.3459151-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721012814.3459151-1-sashal@kernel.org>
References: <2026071525-sudoku-chapter-20d7@gregkh>
 <20260721012814.3459151-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit fa11039d6cdff84584a3ef8cc1f5e1b56e045da2 ]

scmi_regulator_probe() calls of_find_node_by_name() which takes a
reference on the returned device node. On the error path where
process_scmi_regulator_of_node() fails, the function returns without
calling of_node_put() on the child node, leaking the reference.

Add of_node_put(np) on the error path to properly release the
reference.

Cc: stable@vger.kernel.org
Fixes: 0fbeae70ee7c ("regulator: add SCMI driver")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260527104850.872415-1-vulab@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/scmi-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 78f62f88a39c1c..4bc0bc55abe64b 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -349,8 +349,10 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 	for_each_child_of_node_scoped(np, child) {
 		ret = process_scmi_regulator_of_node(sdev, ph, child, rinfo);
 		/* abort on any mem issue */
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM) {
+			of_node_put(np);
 			return ret;
+		}
 	}
 	of_node_put(np);
 	/*
-- 
2.53.0

