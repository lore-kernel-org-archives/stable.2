Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434012;
	b=Ail74Br9DZ6ZsQVxtznSplCt7c2JJ2aHdzVXLRQg3XRMh0E4ZUhTVvLDWSmHk4qua2NL
	 myZR+QSWYOxpM77/DtRp+1Q0iWHQq1nF9ppwllcebe7nSVVvNrTkx/00uoHbZ9p9kaEsV
	 TMqQMMdTTdmLFCXK9exQAigQIu2P5ZF/We1JESR8mMQR/3LSPtxkRJlE0HrhYgICR8iwl
	 dEdviChC/KnuH1IPnz10bKXUkEee384LsDwixqGd0Nfbb6OavJx9CGp2i//p2pw9xquYN
	 8X77CffAl+1G2AGdrWxtawIbbP/I3WEybTUMWyOYSQBfougMKSyTUBldYCjvgp+9WZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434012;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TsO3/ouKFNQJFt1jkTliORU8eiYJf9DPn3a3WF9UUy4=;
	b=BtSfJWMIx0VmY5msKUa9nqxZH4mKvdDSDNQbkyeGn9a1dXjRtm5sL6zUvrgyAoXGuaTK
	 vbSfPBAbN3kO288d6hi1Mu13TbD3d0+lN3iIYIH6Cn568QLiJ186hEwBAydkDAnR3XC0K
	 H1Zach1G2SQOU/QIRDuDZw0WGnTe0+DcdF3xcX9o/4f9JkpY16fSlqXSV663kIP+Kncf2
	 wJjhhjKurl41WwthhXmWiMSOrAKLfA0uOxFoZnhMj54O9Ni2vATotqboaGztaiSvnXHnT
	 drj8CgISNjSYLhAOkMHCqIwll+rO2A2vCnGw5s8IQFh7N7SWmB2FYVXIIqXGEFf7NRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GNkE1uXG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5C606A332;
	Wed, 11 Nov 2026 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GNkE1uXG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0B71F00A08;
	Wed, 11 Nov 2026 21:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434012;
	bh=TsO3/ouKFNQJFt1jkTliORU8eiYJf9DPn3a3WF9UUy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GNkE1uXGD1HJ873enZW7pbPuPNZEFCNfy2WOW+5g3XcnawxsiuzyOJYNHsy566iQq
	 FUZo6HQdMLCpbns2qglPLjAl1IVQA+lxyzR2aK/wV/qOc8Ro8K67Knzml87uqVYebU
	 bhkcHtk/wPMuHC3zAomF32sFitE0NKBkLGRHzTkqs8jaTtBbTQKAtTcAKV4iU2xzjn
	 l0SXljYjs5GJExQ0HvJTmmMIVskNNd+V82wjRfWCFLlt97YkT+s4Lh/Sb8F9P+wOaI
	 eHhINVTUmgPzl8gwna5VT6z7dxa6tPrYDk5ailVvg3kG9UWr3SBUx9AhYc3ZnhTJDY
	 G/CHtHPBjS5wA==
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
Subject: [PATCH 04/10] pinctrl: nuvoton: ma35: Avoid leaking map when parent node is missing
Date: Wed, 11 Nov 2026 21:51:49 +0000
Message-ID: <20261111215256.1982044-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215256.1982044-1-lee@kernel.org>
References: <20261111215256.1982044-1-lee@kernel.org>
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
ma35_pinctrl_dt_node_to_map_func()") removed the kfree(new_map) call on
the !parent error path to avoid a double free, but left *map = new_map
assigned before of_get_parent(np).  Because pinctrl_dt_to_map() does not
invoke dt_free_map() when dt_node_to_map() returns an error, new_map is
leaked if of_get_parent(np) returns NULL.

Look up the parent node before allocating new_map, and release the
parent node reference if the allocation fails.

Fixes: 3fd976afe974 ("pinctrl: nuvoton: fix a double free in ma35_pinctrl_dt_node_to_map_func()")
Closes: https://sashiko.dev/#/bug/linux-ae0c2737-0408-4808-9bae-f7389beb51d0
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index 25c66b9e8dd2..4ae1d7ac2b56 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -201,17 +201,19 @@ static int ma35_pinctrl_dt_node_to_map_func(struct pinctrl_dev *pctldev,
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
2.56.0.567.gdb80ae8cd5-goog

