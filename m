Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050486;
	b=Y0ztxCtVccxbBtjVPCDlJe43VLIcl8qJTgcuxlBToIeR6mCCk81fzo1dBJCLFxou9iw9
	 TxWPPCcCVi0+9G1tjAJ5AIrl9itkQKgDHL3tcfCqvnDKSQHvtfAyVGLRfIXQD1cYnKCC6
	 kCKJIcY8gVOtycM5g4/f53+JRRGCrKKVpazEomP4KOhM+rzRxiW8TCs6QiYBoXsiXW35t
	 9pwoFAATr5iYx4giGkapc3BmOZjaAVnZiy1TsLbRfahGq+WvZb8fguQPLcMcaz0QLD+dt
	 ATbFaiViopEts2nls4/HQw7HU/2yD8XE3QDuL6FRZNpeTB7EmG7huS5BTYNZgZMLSIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050486;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NrLf09UiP30LAK6nZ/RxETJbUteTvWMvllR6ZzFZVt8=;
	b=TLo9YornO1uGWPYNXdRvNnOVWMw8k0cesQyBPRkSXTVfkRPNGdvCQMB+FQoXo+ZoztNE
	 25OeMkM2l/luslINfJcDRqHUFZ1FMwZfHJsGLpFCmEcV/LY0y0dZ01J/di5XTGYNuG8YQ
	 S15LD4TwF+m9xoOd7PI2U/nMWzAoosllbalqJZ2GcPhXLz9Jp67sEe1k4ZDXr3vrvN69P
	 X74k4fDxIHY+iMmxdrR3gfJHCyH0xP6oWCWASDog9CbVlIgs7cyx95FURFhLgA9k61W7t
	 mJThaNqbZdGUpPOzIoh74xYAPnTLBedq1qNrwKnBhsPjk0jdXhDL4I1duVDoCSar2bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvmCRdjA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9303606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvmCRdjA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234431F0089F;
	Sat,  7 Nov 2026 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050485;
	bh=NrLf09UiP30LAK6nZ/RxETJbUteTvWMvllR6ZzFZVt8=;
	h=From:To:Cc:Subject:Date;
	b=cvmCRdjAnTH1y4Fj/7C6XY7o7SEL0ZeCoHhimFxNQIWYrZnjZD3oIc2jl+VHltDmp
	 6d1E8IgDXvXxj0/QUYTX1j/MnaRkQE57XU+I+grye5IbcDrBWHRGJImBENoMFM31n5
	 EhWwexLp0tVNYIj88kzrXPg7HzDYabsdCMiHqEFQ0rDEJewDRRs+zS+CVIEA0APgh/
	 yTggs4uuyvLHDpKbtFDWmfZydKJbAMD9WC1CK4OrTpw81oHK3ckfoUaepYXsiFfBlC
	 x9KiouAiJ2NMADPKlDJCPxpi3SdggT9ciA632gZyl11y05vBET3o2l12ooMXnlfQ7e
	 xDBUUYx5gxnyg==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: drop centralized filter range arg validations" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:23 -0500
Message-ID: <20261107062123-failed-5.10-1d2397b2c414@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1d2397b2c414e3f1fb536666ccc21d4065a3d9a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062123-failed-5.10-1d2397b2c414@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1d2397b2c414e3f1fb536666ccc21d4065a3d9a6 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 14 Sep 2026 07:23:22 -0700
Subject: [PATCH] mm/damon/sysfs-schemes: drop centralized filter range arg
 validations

DAMON sysfs interface is validating wrong range arguments for DAMOS
filters.  Now the core layer is doing the same validation.  Drop the
duplicated validation in DAMON sysfs interface.

Link: https://lore.kernel.org/20260914142327.92510-6-sj@kernel.org
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/damon/sysfs-schemes.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8c8ab82c8facc..a4ec5d54cfbd1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2832,27 +2832,14 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
 			filter->addr_range = sysfs_filter->addr_range;
-			if (filter->addr_range.end <
-					filter->addr_range.start) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
 			filter->sz_range.min = sysfs_filter->range_min;
 			filter->sz_range.max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.53.0




