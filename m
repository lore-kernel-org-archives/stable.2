Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B76D2D8796;
	Thu, 18 Jun 2026 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795737; cv=none; b=EWN+RmppXQTIPNCMQ6Rvb7N1Hw6LWjCKqgMe2LK/dfRxCDF7/fH8qbHJXhyQTnMwMp6oCQm+NV6aQRtwPEHzW+jAY3Pn4gJNZbUGcScjAyIrg6cMeBVJ+VyYbCeyTyEZcmezZKB5pA+B6t+TqlsJXjjnCcqj6Vk3dgt6/njYvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795737; c=relaxed/simple;
	bh=loC2N2mM90PzKsTonVYcxtp3tGXWaP5n/AH+alrg+Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucUsWh8+QjvQhE6mlESgrWWi1u64tIvT008GAs5RLI2uvWLWsHb/tjRm3NpMZOr4x8suPSIrOA9CImIB0gA9BJWKK+CgbvKJXm1OEr+pAL1EvPBx1Ahmzfy1nb+zfoCG+S1oaMiMv06L87+5Q2bTelMWzeO/127Rn2UC+ktimUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta8XHsh4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta8XHsh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28CB1F00AC4;
	Thu, 18 Jun 2026 15:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795736;
	bh=vlWdmraLtKsn8tRuLUEVLShK1HHadraHOlLBzHm4x14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ta8XHsh4ZHuRNEUZdt7JrNFh779wrIFav3dd9IOrXmxRqhFeYwK7mKPUIZaXY1flJ
	 A0laymTf5Hiw97z6zFeoG4R9QLk2wPIAPDa7Ytz/QL12x4I00yd3KznkPCN8zdJz65
	 /MZyYiBS2Fldzm+hXAoxrys1gYPxB9m5pzNv+Tr7jamLe9xmfHC2jQiV045x3QobUS
	 QSgCmR0e4e/1Hp/vrnsoREByWnroZOnsqz+hx/ZWe7D2jy/oL3OrpjcP5KtZPPbCli
	 IRtWYLnfARRFSbihQbTjNosP5/+hd+QebnSvKhg/vnvaM1+iEVZYkAc0e10XlrdgI8
	 0UNzA3Z43B6zg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 07/11] mm/damon/sysfs-schemes: kobject_del() scheme action destination dirs
Date: Thu, 18 Jun 2026 08:15:11 -0700
Message-ID: <20260618151517.5366-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618151517.5366-1-sj@kernel.org>
References: <20260618151517.5366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme action destination directories by adding
kobject_del() calls.

Fixes: 2cd0bf85a203 ("mm/damon/sysfs-schemes: implement DAMOS action destinations directory")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 306c1d3d357c4..0d4e9b053e381 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2145,8 +2145,10 @@ static void damos_sysfs_dests_rm_dirs(
 	struct damos_sysfs_dest **dests_arr = dests->dests_arr;
 	int i;
 
-	for (i = 0; i < dests->nr; i++)
+	for (i = 0; i < dests->nr; i++) {
+		kobject_del(&dests_arr[i]->kobj);
 		kobject_put(&dests_arr[i]->kobj);
+	}
 	dests->nr = 0;
 	kfree(dests_arr);
 	dests->dests_arr = NULL;
-- 
2.47.3
