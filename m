Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046579;
	b=i1YH/y6o4t2/w2lD656g3FP2nR7sinzf3kQMdXEXmprvn3JtuUKj2l5ZkJ64gtTP7Xsb
	 wSRuFlvOvgkFx8gSRCwlXvL1pzO5r6RVOkqouJ3HhgG1m29vjwMHBTbeVXJfb5WgQcdEP
	 nHaQV/XrGbqEnyhjvpOIKDnlHD/sx1ZpCXGdtjuKsynGqvpqISvF7JNHb/e69+cdsx6K2
	 mm9iV9Z/7wnf4Nxcdrbr+O9XC9IHQIBSYBHrOMcxIkMNyqaYMSVL9cuAjs7k7aYfGbucF
	 DPsnbzUlmlvMNFV/jN9NBBkmShChDPZB0V1WmqHP2NvcKZ/yXMXsPh+RhRvDSXn5YuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046579;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kibCwU3/RjAmee76IkqvQ6sYrFavHLPvv2xWMYtWkh4=;
	b=4yM30RigtaLIzsnTlnsSYY+jsUzDdRKzirKmX8Y5FO7QdzR7Y5b+OmNZVBfkL54IX/39
	 e0+dUMSZ/VKA7MO5z86YNnzIGL2XO7yvUHWAsTZD54xStV1E3j+vDvdj0lRjdJ24jncyN
	 NSIIvEyOlcrYSNoO6YqH++SxoHgpVzeFziszr6pSh8WHbMbBNbT/EnHPsYCR1YbGXy7sd
	 m8ugZPS5pU5uxJZ3FJ8WRRjh3Oa3XwpnjUnrHjvtQeiVjWc6GrK/86rS2GIbeUEYcs4eN
	 4IDHubAdwK8/VMY/r8J9QK+SCeSyUNSRRMkkltjhiG+692gGNWv+9ltbPO44+FpP3oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6q2eiYg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA32606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6q2eiYg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114C91F0089F;
	Sat,  7 Nov 2026 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046578;
	bh=kibCwU3/RjAmee76IkqvQ6sYrFavHLPvv2xWMYtWkh4=;
	h=From:To:Cc:Subject:Date;
	b=W6q2eiYgf+AJgOU8mSrb9TXAby7bpmTK2wUBP0wLWEyFHhVTKpiwxR7ZEMnkCKppy
	 h3fB0tADIGdRELAMV3lgcmB3O0qBPftHHZFHl+fX/C13nciVHhP+sccAnWKaDpDsTo
	 5mC8x16RGrpD0C5wkQouvATILw2SFRoBkFEVWpxuuHeFhVW6Pel55BAJbvnxb6OgXt
	 Jn1AhNFFkFtAjdJMLCH4Y1OA8fUgHCPFNDlLn0uD+Te5+Im8UBJuxB9BRLVbf2TVjJ
	 y5YYWo95SNPC8b8jaH3xZeVX2VCzS53W3cynCCqKY9I4xc6Dt0Kj5DzZIOsu7x2SQk
	 DUM0zSmUF4C2w==
From: Sasha Levin <sashal@kernel.org>
To: esben@geanix.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	andriy.shevchenko@intel.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: light: ltr501: Power down chip if request irq fails" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:17 -0500
Message-ID: <20261107051617-failed-6.12-8a9bcd587d7d@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8a9bcd587d7d768e6c8e9fff88bb89645e412731
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051617-failed-6.12-8a9bcd587d7d@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8a9bcd587d7d768e6c8e9fff88bb89645e412731 Mon Sep 17 00:00:00 2001
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 17 Aug 2026 19:08:53 +0200
Subject: [PATCH] iio: light: ltr501: Power down chip if request irq fails

In case devm_request_threaded_irq() failed, we were leaving the chip
powered instead of powering it down again. Power down the chip switching
ALS and PS modes to standby.

Fixes: 7ac702b3144b ("iio: ltr501: Add interrupt support")
Cc: stable@vger.kernel.org
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index fa0d16890c8bf..b36bd10a02624 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1538,7 +1538,7 @@ static int ltr501_probe(struct i2c_client *client)
 						"ltr501_thresh_event",
 						indio_dev);
 		if (ret)
-			return ret;
+			goto powerdown_on_error;
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;
 	}
-- 
2.53.0




