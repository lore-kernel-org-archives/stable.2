Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3DE2248BE
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005303; cv=none; b=SHYviER9JhLSV7rfQumLggKwKREzkSOSE0c29g1ob6cTCcTpIfSitR1eRz9mQkSHX9L1AbiPkg0L7uIZIxaYCYRsfkh8Z3k484hbPrOrdrkVhFLaO2bvGQOk5xNW+pOBUQ1gMx436mQsVG0NAh55ts30dKJQILmEJpk0PytCfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005303; c=relaxed/simple;
	bh=V5e8u2VA50Tvub0VJAfFNxB+eALTH+kjiklNfvfxHIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+bdypv2ZnPVD2zJn0fahYkXDz0KaiFSS/JCKXE7NJOdH6R85tQhSGcS/9EMbH25hSouQQ+561cfDFrPcyNyvfoHa3mKAG982UnrV3TL5s5CkxV5dO1+obCvVaoKjwDikgGubGMhCTnLJ1DBldACnfftvFvvkJ/VqbadF/yxXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=bD0HZQhi; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="bD0HZQhi"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33c2520ad38so10237663eec.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792005301; x=1792610101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YTmtVnXB0/abHW15B1XfjRxEOxwGtGyE9B/KC6Y91aY=;
        b=bD0HZQhi1n3S0vzqHOTs1JFCXap7n0b8+K7hoSq+Tz8Eifnq/ltGRwXSefoo9zmjm4
         f9HU8RGZLwZ+osFGAb36lD4kty0aoVr/UC/eEIJFdrSZF7Sc/8y+I3L4Z9FzsDXkWd9N
         SivmqOiBFryTv+ub+DRgX353fjmsANm4t2D72LAmOxJIsGhmVqGgnmy6F/EZ8ya7FdGd
         ykh6KXqCxq1uSh9/QJBPDELhPKAvIxnIOo/awduGqNNVj374TtGUqzFcu3OSlFSm3ucc
         cjcQEwPtMKqhD/fObjmNbB+olLwaB0uto6vr7pUMZZTyPlL+Bvx8qC81mK2TxKtCUz5b
         6HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005301; x=1792610101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YTmtVnXB0/abHW15B1XfjRxEOxwGtGyE9B/KC6Y91aY=;
        b=M54/+ZMuNRE8iwSkBs5dQ3Vc4lHWEU32WdmjwVAu8JK6Ojm+2L3ywrbbwkDjxPH2B9
         Dxh7GnVqwYwX8rxO93oK1cXFACmT4/87hDPEjNYRxv7EQ496nEMn3ueWhSeSakn1pobC
         WrFo5W8jyW8SaR9ADTs0CHEFf5Ukx5cLTSxh8mRnxj68W81n56eFfX5Mf9jFMPJZOz8i
         0D1yXttRIfMPTKzVSBKg6/cY/uYuABhMBhuYO3egTAnGBy9RW/EVjQoqFQ4yXxabKDVn
         op9xRwfZaHLqsdPu5qK0CJeRnUyzDwohES919MGNpJNeiezYSGTscLPgTL9i6Ot0y7YG
         bfhA==
X-Gm-Message-State: AFq9FYKNnuiu2Yd2uMbP4JLi4eYsxcRzi7ggMdriHF9+nbgG2I/qRI3N
	1pyxAukc3VZaG2prHz2cURN0x7UPF4w5spCfa4IC9pHgZJkiz86hwMmWhVLroPTwYhScMWZ+jNc
	ax57jxZ/DYQ==
X-Gm-Gg: AYBFou2/G9y+yI1cbbd7J/LKIenpSuQxAv/iG1S+PmR6HpBst4ukCOncvnemCxh+69s
	SfqrvT8ObwJxNBppJNZUmNnCffNYeWITgQw6y6yHQhxUxygEgPu4Rg1e34kJzan2gX53KNRc0vq
	dT6Va7+jOJHK/zWim4Jm7znx047/sWa9Da3IuvSPye8ZxOAejZE/IrKzBdq7fSqul3aiYHCu/0K
	7V4Eh3XKnZOtUe2EljY+IaY9HNeeuIHxdW7gf77wCyQhh0uuNkENmAOUix0mEEYeJ2YUwgD6kKk
	K+eEGA9bZoVnJUiNDt4HbFfEHrvGEiXoK/X81eXFIFGRT2JML0tgYnnlknUpUAak7Bxx5eC5zTh
	+nOB//p2f4WU0CD5tuOmxLbRdSbe5FKyH3OwvitfB3o+t+bJH+10mZrfwt0xI3XAD9MWml7r8/r
	2/x+oeP7qe23xt9lvGdeaf82BtuSj0yG+SwXd3QBbTnX3SdeJ80LE2DUHs9H+xJA8IMg6kLGfaC
	JL+/U1bJAOJQbcQTUWjBhVr75f2VvWRtrEt9ZITqngYzKHlliC+/enbNO5tG4O6+Ys1pZI=
X-Received: by 2002:a05:7022:1608:b0:143:3da5:cada with SMTP id a92af1059eb24-16a610ca97amr18727856c88.37.1792005301278;
        Wed, 14 Oct 2026 12:15:01 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16997c21ff3sm49019099c88.2.2026.10.14.12.15.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:15:00 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: christian.gromm@microchip.com,
	gregkh@linuxfoundation.org,
	johan@kernel.org,
	linux-kernel@vger.kernel.org,
	parthiban.veerasooran@microchip.com
Subject: [PATCH 6.6.y 2/2] most: core: fix leak on early registration failure
Date: Wed, 14 Oct 2026 15:14:52 -0400
Message-ID: <20261014191452.23814-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014191452.23814-1-artem@trailofbits.com>
References: <20261014191452.23814-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 2c198c272f9c9213b0fdf6b4a879f445c574f416 ]

A recent commit fixed a resource leak on early registration failures but
for some reason left out the first error path which still leaks the
resources associated with the interface.

Fix up also the first error path so that the interface is always
released on errors.

Fixes: 1f4c9d8a1021 ("most: core: fix resource leak in most_register_interface error paths")
Fixes: 723de0f9171e ("staging: most: remove device from interface structure")
Cc: Christian Gromm <christian.gromm@microchip.com>
Cc: Navaneeth K <knavaneeth786@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260116162950.21578-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-43317 to 6.6.y.

The code changes are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series: x86_64 objects
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 drivers/most/core.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/most/core.c b/drivers/most/core.c
index 0fbf06d34e0b968e6444877af981322a3793d406..3d1102faec8a2f37b1c4abcb99236db39b79094e 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -1282,12 +1282,17 @@ int most_register_interface(struct most_interface *iface)
 	int id;
 	struct most_channel *c;
 
-	if (!iface || !iface->enqueue || !iface->configure ||
-	    !iface->poison_channel || (iface->num_channels > MAX_CHANNELS))
+	if (!iface)
 		return -EINVAL;
 
 	device_initialize(iface->dev);
 
+	if (!iface->enqueue || !iface->configure || !iface->poison_channel ||
+	    (iface->num_channels > MAX_CHANNELS)) {
+		put_device(iface->dev);
+		return -EINVAL;
+	}
+
 	id = ida_simple_get(&mdev_id, 0, 0, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(iface->dev, "Failed to allocate device ID\n");
