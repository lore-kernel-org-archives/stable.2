Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5133F19EED3;
	Wed, 17 Jun 2026 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707720; cv=none; b=ugfiagu5pS14pt2FcZUpJ4XYtFVuVpq3Ru2yA1Add7aO8/WhgTg4DxTNKy7/EMEBUlUUNSWCug1jthaeUyBUOO42g91JI5skQAS1YKFixR9mp1DuTizMnOwSINHw7qq6JjMqitL/3h4mwUI5jyfR8Rug0te2F52+m/9z+gAxPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707720; c=relaxed/simple;
	bh=P/YRtZaOARgw54Tx+SEjBI9kxicLKAlJR6FWI+U/JuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHFBuSZjqG3dGtBjxuW7Erp5srOAOyLpYu7hWM0dp3HV6TQud9HG2OGeL5owvHLvlklzP9WGN4Dvn7tJtPCtuVenbfNucllkOQTPs1/Xsa0f2JYs3IuXBlIwkkHvdEHKi04no25rMjl5Lzw70xAI/nF5euZFZ4eRSsbfJ4jwvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=newO6kd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="newO6kd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FAD1F00A3D;
	Wed, 17 Jun 2026 14:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707717;
	bh=YtuACU05uWFEz+Ei+IYVVZbkflRFGPIDankdmmStN+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=newO6kd61rxUta9sxfOW/31k4cJ7NC+z7HUfEnbvZE8UgaW1nrLrktwr3chXpFcsm
	 dzdlN4eHn8jhYQsWOP3Jj1CJAb1CBco3QnpH6DKglf6vNQMypJLg2NZdQn8z6P5AZR
	 wSlSEKkGLc9DUo+Lex+3ZloUY0cdJoiNB4ZQl8f3LVUr2uvup9ADPAcQudhzE0FOzZ
	 Rn5+9uZEZum7JLeV3YQLrz5e4wNCBfx43sQJ8ompkyOIrLsSWA0d7CRwXl0WwLss89
	 C/uDRIA2ueWQcgS9OumJon6hYbA1MFUJbW0mCyY4EgitmXOCLG2C8q00Sxpnbjx1Y7
	 DRj0FwuCfpctQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 2 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 04/11] mm/damon/sysfs-schemes: kobject_del() scheme region dirs
Date: Wed, 17 Jun 2026 07:47:58 -0700
Message-ID: <20260617144807.91441-5-sj@kernel.org>
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
those issues for scheme region directories by adding kobject_del()
calls.

This issue was discovered [1] by Sashiko, though its analysis was
partially incorrect.

[1] https://lore.kernel.org/20260517205828.6204-1-sj@kernel.org

Fixes: 9277d0367ba1 ("mm/damon/sysfs-schemes: implement scheme region directory")
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index debf2a3a0d8fc..604b77a47a463 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -334,6 +334,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
 	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
 		damos_sysfs_region_rm_dirs(r);
 		list_del(&r->list);
+		kobject_del(&r->kobj);
 		kobject_put(&r->kobj);
 		regions->nr_regions--;
 	}
-- 
2.47.3
