Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CBD3976BE;
	Thu, 20 Aug 2026 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261002; cv=none; b=BZIenmaf1t5LgCuJB1Jyvi7MeJhlY4wrA2sF6pC/bKhq79lwTxdQgmKMh7y/9iGBJGxe8Dlw+eKPDK6QHGUqHnaA/qvku1s84UeqgnH2KRwgh9+nWTlxwFCeK1e920Dxv4IvSf7Fhrv0wv1Bc2Z6TN8u+VjTOJ1Y4iatY9RmZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261002; c=relaxed/simple;
	bh=zi3Jzm+5iWnFAyPYj2lRWF4n32UXAZhti363qj903Cc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oxTW7zfUqTWh2Y3CQn1uTfmnIM9LjpkBctL55PEKvmbHqNcEzHphyqRhksUWdL0Sj5lmtc91+tX393LO1kjI8o1oBvvaFFDErcE4iKAgwH3PAhZ9EST+hRPSelpblDYpdIzSDkfpm3VKwvz0BQGfsrUPgd4GhEPF+Uc/S90Bt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fau.re; spf=pass smtp.mailfrom=fau.re; dkim=pass (2048-bit key) header.d=fau.re header.i=@fau.re header.b=oA2BZsvV; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fau.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.re header.i=@fau.re header.b="oA2BZsvV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.re;
	s=protonmail2; t=1787260983; x=1787520183;
	bh=zi3Jzm+5iWnFAyPYj2lRWF4n32UXAZhti363qj903Cc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=oA2BZsvVHvFRo8q4rKqokEejvZOSD/zO4Tbwc1hlYOU+es0HeEcQFWJT0AYwfm7ux
	 gsPQ3Gf+pN8QYKjTir9BZYQsfoKLu1L0BolJKue/L3ZSjeXFH+vVojqWfOLA19pOaQ
	 vHvPEj0Z/Lh0LWbms+Tu6C7dDM4n7pDHszXlYWJvSiedO1qij0lU5nXYfsCJOHAB86
	 Q/cgHex9L868SWyTcr9mLSUqcWw+wVs5o9w3WgJN+nDaf1S6PX3MPpCP76DfV4aVW5
	 iNxEyJGMklBJdCUkQ/ilMUtLpXMYQimclgIdATLeDQ+oyWkuFkyi7uD+S5XNRi45H7
	 q/3CAwGSX2Ijg==
Date: Thu, 20 Aug 2026 21:22:57 +0000
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
From: Boris Faure <boris@fau.re>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Boris Faure <boris@fau.re>, stable@vger.kernel.org
Subject: [PATCH] soundwire: intel: initialise quirk_mask before reading it
Message-ID: <20260820212220.226912-1-boris@fau.re>
Feedback-ID: 104543335:user:proton
X-Pm-Message-ID: 75d164a4bc22dafc0d7c1ca72548a2b5c1e991c9
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

sdw_master_read_intel_prop() declares quirk_mask without an initialiser
and ignores the return value of fwnode_property_read_u32(). When a BIOS
does not describe "intel-quirk-mask" for a link, the property read leaves
the variable untouched and stack garbage decides whether
SDW_INTEL_QUIRK_MASK_BUS_DISABLE is honoured, so the link may be marked
hw_disabled at random.

Initialise it to 0, matching is_link_enabled() in
sound/hda/core/intel-sdw-acpi.c.
Found by code inspection, not observed at run time.

Fixes: 395713d8ca43 ("soundwire: intel: handle disabled links")
Cc: stable@vger.kernel.org
Signed-off-by: Boris Faure <boris@fau.re>
---
 drivers/soundwire/intel_auxdevice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_=
auxdevice.c
index 0b8107bec9ab..26bdca95c7a0 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -158,7 +158,7 @@ static int sdw_master_read_intel_prop(struct sdw_bus *b=
us)
 =09struct sdw_intel_prop *intel_prop;
 =09struct fwnode_handle *link;
 =09char name[32];
-=09u32 quirk_mask;
+=09u32 quirk_mask =3D 0;
=20
 =09/* Find master handle */
 =09snprintf(name, sizeof(name),
--=20
2.55.0


