Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCBF431E65;
	Sun, 11 Oct 2026 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715011; cv=none; b=W6eU4r3Y1wg+oTPnD5R1g4g14RSYdYRsGjXNaAAwoRamcYFOqmI7VpYnWcpWoX7InfR/WBrX1pK5Kk+5BJyyIFtmTZhh9M/RHuwAwsAeLEHHvTrxV0TOPNFkFOKboeCsWqtxG/Tc/dOvr2UGuFdaY6xv5tOuH4TfBYmth/Y6o8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715011; c=relaxed/simple;
	bh=QFtLRMut4xI501adyJgWtrDtPHN3Hc7d6R9Nt3rKT1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IjCaKIdetZ2PKQHu481kQWGKXtr7bz4LzNSxwcWwYdaNc7CTyBexA5DoxMw894BUHmmWpKbN6v12JAK7Ud8oZcFhmHxfhhznARwr6s42FN55/Q3bdrJv68m3Jq18rR5lnp+HFloat0YmCkz2jOLqHI5bO2h+DvFrgTpEO0VuslY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lUecf4ho; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lUecf4ho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3W
	WIW5MGmKkn7S3+VW1bqH4XAcCe6FJ9KeMmujaqDsI=; b=lUecf4ho4v5jhOfedd
	E0AIClCcdIoDXQcLvUyTeABOC21AO+TOrryibCI90L1yj8t8z94aZKvudEEtWNAs
	hhSGLaPjuVOxRntGAFgT4VMMug8TVM9i0+NYLPKbCrHD4694NVxqAAuW4md5wLXX
	jEsqzcv023cIJ4EeVCoEMgD18=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3P0GCZstqUkHODw--.52289S4;
	Sun, 11 Oct 2026 18:35:50 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	o-takashi@sakamocchi.jp,
	u.kleine-koenig@baylibre.com,
	dakr@kernel.org,
	make_ruc2021@163.com,
	bhelgaas@google.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH] sparc: Fix leaked platform_device references in archdata propagation
Date: Sun, 11 Oct 2026 18:35:44 +0800
Message-ID: <20261011103544.3237228-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P0GCZstqUkHODw--.52289S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw48uw1xuryxWr47ur4rZrb_yoWDuwb_u3
	Wxua45Wr4rGrZagw15Ja13ur1kt34DKrZ8t3Z7ArZ5Jry8Xryaywn0yanYqryDWF4xCrsx
	Ja4DCr4qgw13KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRGzuAUUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC1AZIU2rLZobSwwAA3Z

of_propagate_archdata() walks the children of a bus node and looks each
one up with of_find_device_by_node(), documented in
drivers/of/platform.c:

 * Takes a reference to the embedded struct device which needs to be
 * dropped after use.

The reference is never dropped, and because the function recurses, every
child node of every ebus leaks the reference to its platform_device.

Found by code review.

Fixes: 5059625ed886 ("sparc: Add OF archdata propagation helper.")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 arch/sparc/kernel/of_device_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/kernel/of_device_common.c b/arch/sparc/kernel/of_device_common.c
index 7f2f9972b59b..0aae21c4b62c 100644
--- a/arch/sparc/kernel/of_device_common.c
+++ b/arch/sparc/kernel/of_device_common.c
@@ -70,6 +70,8 @@ void of_propagate_archdata(struct platform_device *bus)
 
 		if (dp->child)
 			of_propagate_archdata(op);
+
+		platform_device_put(op);
 	}
 }
 
-- 
2.43.0

