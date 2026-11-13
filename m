Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576499;
	b=H/7yVNp7a1SC7nmXwKjB5fYgitCMjuegVuc4Ookp/EU9V96SnEUp5nweFPkOfKZO/ANe
	 5Ce5DBbb/GRkmrVDecG2Q1hRGMQylPbBgoZu1QdSX91U8S7zhlnA5P7zm9uT50aZR6RGM
	 E3E+O6f50er9uKS6tEOQrPMSrcxrMJdfbScrY2GQ8l2pMECvAomQ6Cx9w0zBC8Mye9ByM
	 Bp014Aw2xkRVmBSG7WxE53vzValH8Sn6Cgdmyt0/GXYc5A5NKVOXmMnvFd6pueuo7q4f+
	 WeLWlqwntw4OEUd6W7QUaRJQ9sR/5HwvNuDCw1AyC1LipxE26NQaAg7N8ByG4ZdmoEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576499;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=S1HICe8OiPhU0KS07fnk5zSLJn2HTPk/bhen74c4PCc=;
	b=b/8+ybv0eGJUR/LzzPJsf1MOX7Y9xNJCghTqQL8XdXIkn5XRZ95KThWZqb3HSSo2zd2Q
	 Msnk8RY1b3U/7Met/L72SEVMCor7q6MtGon+fOaO8E8eqTdZVXHpQKeMp0M7YiXNR9a5M
	 HfAeVBOoFGo3EblrelZUWUuegcVG0VekHQG4mOwNDO7mrZWG6BXu9iKu2ejgpgzmNkVD/
	 kH/U5vN3OX2gsJr/HvGtOc6BwQaWhmwDEH3olK75ET7P/AUmb5RzA1aZHlddUMLP1Wbfc
	 ML6Sih13IfdCjt8IhC/C1rc2vog9WmfPAbcZI1X7bJD7aj43iWDAlxIxNbDseOGBzPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnbbWgZr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29FB606E428
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnbbWgZr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0901F000C5;
	Fri, 13 Nov 2026 13:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794576498;
	bh=S1HICe8OiPhU0KS07fnk5zSLJn2HTPk/bhen74c4PCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nnbbWgZrNMUOxj6svnmzFxZD9lqlvDt/x42Tw9JswIEL+ePf8NPfZmM4wLMzZXIO6
	 OeXe35YHalE20kD4jTfL8gT9s/zyX36qD/gs6NBZq05JBmK+KKY6iBI2QBt725pJNI
	 b5viG+ooKOtweN9kKXfD//FvNQTMxzw/bQLiyOrxPdid/h5WgJ4t18SGjDFd2DLPxn
	 EUUp2rAlK/4WXpds5wROjASEjKBh5Dl6Q70rkI3QiQHkDPScEXk3CGDVmHxAxmLFnf
	 a3qGhucKNC3iJSbn/T1P3yyerwDeeExAbJFHc6h5oAFxpYYuhWBZ8nk/kZ136M8YKO
	 PVwuAVLSnfRWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] hwmon: (coretemp) Set nr_cores only after core_data allocation succeeds
Date: Fri, 13 Nov 2026 08:28:16 -0500
Message-ID: <20261113132202.1216623-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200726-failed-6.12-95638f1f05ce@kernel.org>
References: <20261109200726-failed-6.12-95638f1f05ce@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 95638f1f05ced75a82e83f610cd01b636d2a21b1 ]

In init_temp_data(), pdata->nr_cores is populated from
topology_num_cores_per_package() before allocating pdata->core_data. If
that allocation fails, init_temp_data() returns NULL with
pdata->core_data still NULL and pdata->nr_cores set to a positive value.

coretemp_add_core() logs the error without failing coretemp_cpu_online(),
so the CPU still comes online with pdata->hwmon_dev registered. When the
CPU is later taken offline (or the module is unloaded),
coretemp_cpu_offline() calls get_temp_data(pd, cpu), which loops up to
pdata->nr_cores and dereferences the NULL pdata->core_data pointer.

Store the core count in a local variable and assign pdata->nr_cores only
after pdata->core_data is allocated, preserving the invariant that
pdata->nr_cores is zero whenever pdata->core_data is NULL.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 1a793caf6f69 ("hwmon: (coretemp) Use dynamic allocated memory for core temp_data")
Cc: stable@vger.kernel.org
Tested-by: Asaf Nuri Bertizlioğlu <ycistak@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ sashal: used kcalloc() with NUM_REAL_CORES instead of kzalloc_objs() with topology_num_cores_per_package() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index cc81b849c09ef..7f8ff6dd16bfa 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -497,11 +497,13 @@ init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
 		 * Will replace hardcoded NUM_REAL_CORES with actual per package core count
 		 * when this information becomes available.
 		 */
-		pdata->nr_cores = NUM_REAL_CORES;
-		pdata->core_data = kcalloc(pdata->nr_cores, sizeof(struct temp_data *),
+		int nr_cores = NUM_REAL_CORES;
+
+		pdata->core_data = kcalloc(nr_cores, sizeof(struct temp_data *),
 					   GFP_KERNEL);
 		if (!pdata->core_data)
 			return NULL;
+		pdata->nr_cores = nr_cores;
 	}
 
 	tdata = kzalloc(sizeof(struct temp_data), GFP_KERNEL);
-- 
2.53.0

