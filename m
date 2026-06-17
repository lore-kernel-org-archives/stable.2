Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB825F984;
	Wed, 17 Jun 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707726; cv=none; b=oqipYZsUTu2TLkH54+R/jikDy8ZhXq04n9scu7qEi/TNmjU49FBRUIHMR5SHJjQxebgG2nRl5WCMtu1lytC8JQpfoPGoqShFD74/eyfvKLPn4MHIhZmkMZD6fFU7utPryG4nYwoUSr9L2frEHy55tB0fE44nT/+pY0fe3BEymZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707726; c=relaxed/simple;
	bh=n+MpPsjDxaJNzCR36ZHui5GCopQ8H1IC/W8er6O8MP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lv1jKsre9lKfEBuSpfsZNr5cabPj655YJ+v9Xj6krgJeU4jQBj50wCFnCDCWozrClcOqBZqxiJps7DPT4jIp9MFnTJQAwIIXgJrTVZbjtHevPhOfJAtnKRuy0xfmgV0Hj7ZOBscG5yDmLTLlvWy8T5yBF6E5IYJM7dFuOQ7cTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTSK+CWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTSK+CWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0B41F00A3D;
	Wed, 17 Jun 2026 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707724;
	bh=CaF8UdvZVDDussggfwjRLGsPjlTiPuwSrEK65nFYR9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YTSK+CWWyy07fQAd79Drqssx8EIz0d1umquuzvD0ZbX8Scsa+HOIG0PyZWxPcJnOp
	 YIrJZFgZSdwLv3THjsKukFxPyF7a0dDVukj1UTz8zG3dAuqxBVmOimH2rH1JWydV06
	 VZJD69fV6T7CBSfscjR1ClWWhXsxi4q7IQa0DkOyb6syaZe02+TAWtA1M2FjKZHX2H
	 UeZUe6NjuIpfz6GOCv8jMkDi1iVDG8uQWtmi1RTcx/tDdXpUndGiAFCc+/UV7H+WQ2
	 dCEdxRubeJnecn7xCBAMuWJoALKti7qqPQkLz3mC5zY7cXfzqd+CeftszHLhCwimUL
	 ln7eIPlXC776Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 07/11] mm/damon/sysfs-schemes: kobject_del() scheme action destination dirs
Date: Wed, 17 Jun 2026 07:48:01 -0700
Message-ID: <20260617144807.91441-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617144807.91441-1-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
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
index 573a40c679be3..0c0c9637b594e 100644
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
