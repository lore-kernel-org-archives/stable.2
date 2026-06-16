Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF67E43DA35;
	Tue, 16 Jun 2026 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622542; cv=none; b=SKh7RpXvBYKGHfmIFoX5r92kSNSxu6NRCVmP+1pzX8TINRgIY1tN5lVF4WVyM/UNOYnartKItcFIioRB3Yu2JRjKsA1g/PIDQCoVZJSfmUWdLcobfMvbnwdgM7VWFUNxEgnGttl2qCvw89RPwD1KuuWoXPFvtTZKc76msghpnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622542; c=relaxed/simple;
	bh=axuln/tpi0HRr1x0QzwX+Gh3AZ1DBP1Jyz2a7F1Ej/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPp3xMBDMrtLMaey4iBOEwYLuTyRJ5IptMq2kmDGc9h7/yn3qsqKH+/KX/I0kMeKo5hsEufaNZxCjJHvdHdafQJ1tOpFH/8LVKpnXHsKxziO9YNhwu6qVGG6y9KWMHufaKUSPL9UxVSg9tNtE/AQhp4H45Eh/d7wxCKDjz68mWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwyeCJDZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwyeCJDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549761F00A3E;
	Tue, 16 Jun 2026 15:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622540;
	bh=0szVMs69Uu2eAbLCAOXCLc5i2YnWrEQ3PmDutKfaOgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NwyeCJDZzBpee8okpdb2TWe1r4JVbWLJdLqjGxcHtHjVhvyGgwkm6g+7FhSg1YNrh
	 o3VXNGOV6H/r0kPCTl8lKhSkoesda7CUC2JdNfYaLZ3My3pfdkKxkH9ZoB6Wc5KvwT
	 S/qnloRzUcZbcasS/nv/xWEr+zbOzOjCHsOVo1Q0lrAYPC2Th60vVz/g9IsCHcfJRc
	 oAEnTQbbiqbpws2gOkLbeZWZthdB1WRN2oy90AZIobeCdUeZVVYd7Y4J89Ez8oglMZ
	 ZkeP613l/DtcGsYhI4w072La1njLE10y+HElgyg+iUgeCeLaOW+FcDFXccbnV/uyHB
	 sdnoVxYmAJinQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/9] mm/damon/sysfs-schemes: kobject_del() scheme dirs
Date: Tue, 16 Jun 2026 08:08:37 -0700
Message-ID: <20260616150844.88305-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616150844.88305-1-sj@kernel.org>
References: <20260616150844.88305-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme directories by adding kobject_del() calls.

Fixes: 7e84b1f8212a ("mm/damon/sysfs: support DAMON-based Operation Schemes")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 329cfd0bbe9f3..37cf6edb54f17 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2686,6 +2686,7 @@ void damon_sysfs_schemes_rm_dirs(struct damon_sysfs_schemes *schemes)
 
 	for (i = 0; i < schemes->nr; i++) {
 		damon_sysfs_scheme_rm_dirs(schemes_arr[i]);
+		kobject_del(&schemes_arr[i]->kobj);
 		kobject_put(&schemes_arr[i]->kobj);
 	}
 	schemes->nr = 0;
-- 
2.47.3
