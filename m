Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121451;
	b=EQetHNaJ2rg/rQCICBKD/8kLTIrKEax4WF5urckg/0pg5HGbEjJrzHeI/66EUYlmxt5c
	 cntsGLcpySDDJ7yfOkfGgi8Dt/mQ+69LbmNVuKAwUKpen4Jc0MYORC0X5dxlYk4U+If4t
	 CF/6dUrIlzDFmWsVaWZ3dAndIU1lu+W+og/1cnLvrply4M0EL2h/p926/d85LeBYzMJhS
	 ajPMWrzN++5uehnVq6hWOsExCsZXC0PWTPQfPGLm1sMbDiwXzyGT30MOR9kAUwZQiaMMR
	 HcWGgA7EwmgCpCUhKUNSIWmf06DINqPKtCcltIUlc3sxqZxSE9DSFmwpcA5IK000agA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121451;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NAbaLn8TdjdIV7Xo1u11Mt4D9oXgJ+jd79pxsi7Y87k=;
	b=N+GmuWBbu59GJqv+rwqSc3K90BYJQBOo8JkwvQ5AmrDQqPGXXwEH5rdQsAqQ19GQFK1G
	 J/hMABfSMOrQcsjHdSHcUQlzsp9U+M6DbOPSjXDDi/enlPh4vPsCwBamnrSYNvm1C8Aqc
	 7xmA1ZVSBhVq4gqOPIly3jqlMd2mSdWwQK3cCp88wI/pTMZ7/6UHIhL7+UE+qJ0rHKq83
	 IPiBIQ79rF63ei97IRNthlpjKDI7wIkWi6kpgPVHebCoAi/TVz8/2B9HZX5QxJofmp8m4
	 QTKuOqrVpYO3jDhqlZDyPBoMaEL3AjhzXwHVXrD9mn1ZgRYDWCBpsVnlSLlnUpuxDMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgWgPwRF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE30606A929;
	Thu, 19 Nov 2026 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgWgPwRF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E9D1F000CA;
	Thu, 19 Nov 2026 20:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121451;
	bh=NAbaLn8TdjdIV7Xo1u11Mt4D9oXgJ+jd79pxsi7Y87k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CgWgPwRFr2ako7TveUhLXhNrzitfBeCb2Y+IMK8imEzw8ylJXdOOrq5eK26ZYSeEX
	 pZjCZSRLCgKgexHyFivzzejiaBRoR6uuxdEy5/DvrIOwtLvrFm3Nl+bvFVpxjTd68c
	 Fr3WlTdRm3M4JGY65SQsGoqsa4q77Ts+U7y+bsVOLyLHbXk8ssM2kadikIWfBUwHyc
	 fb/mVrFk2pEaP/C49Y43ukSrdoMj+Y3/aMX8hdunexdNrBmO5HJB3zIsMlkFw2B/n7
	 7RB9Va/YG6u0SZkPNVRKH4rjvKieKZ64Zja2DDxA4a96QFtFpWaHzm/qwUxqui4foh
	 o6iwI3d+QpGyQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 05/12] pinctrl: nuvoton: ma35: Avoid leaking map when parent node is missing
Date: Thu, 19 Nov 2026 20:49:01 +0000
Message-ID: <20261119205013.2563811-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119205013.2563811-1-lee@kernel.org>
References: <20261119205013.2563811-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3fd976afe974 ("pinctrl: nuvoton: fix a double free in
ma35_pinctrl_dt_node_to_map_func()") switched new_map from
devm_kcalloc() to unmanaged kcalloc() without freeing new_map on the
!parent error path.  Because pinctrl_dt_to_map() does not invoke
dt_free_map() when dt_node_to_map() returns an error, new_map is leaked
if of_get_parent() returns NULL.

Look up the parent node before allocating new_map, and release the
parent node reference if the allocation fails.

Fixes: 3fd976afe974 ("pinctrl: nuvoton: fix a double free in ma35_pinctrl_dt_node_to_map_func()")
Closes: https://sashiko.dev/#/bug/linux-ae0c2737-0408-4808-9bae-f7389beb51d0
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Correct description of commit 3fd976afe974 in commit message
   (Sashiko)

 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index a92945b7821f..92c1c40339f1 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -202,17 +202,19 @@ static int ma35_pinctrl_dt_node_to_map_func(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 	}
 
+	parent = of_get_parent(np);
+	if (!parent)
+		return -EINVAL;
+
 	map_num += grp->grp.npins;
 	new_map = kzalloc_objs(*new_map, map_num);
-	if (!new_map)
+	if (!new_map) {
+		of_node_put(parent);
 		return -ENOMEM;
+	}
 
 	*map = new_map;
 	*num_maps = map_num;
-	/* create mux map */
-	parent = of_get_parent(np);
-	if (!parent)
-		return -EINVAL;
 
 	setting = grp->data;
 
-- 
2.56.1.750.gf70dc682cf-goog

