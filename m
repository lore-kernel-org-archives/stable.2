Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB2389453
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259788; cv=none; b=PgAZKmBunD+5i4yXFJQNzgdHYKkOyvobYlt6EN3fNVl9X1nhUR0k6C1zdqdNXyz32tOpd/Bm758zIaBsyTEK4tGLzZ04yIFK7RBdEpQyVe1YrZ/7touZyP8XSDuE5OHZca8y+m01lEFRst4yr94LEPEZXv2qwEDTo5HBVByRETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259788; c=relaxed/simple;
	bh=PbQ7VaVYc5x2weXdLWgNj+9JbFtvI6C+Awx0zQ4rjhk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=c4uh3QMVwmkiwrjL3XrXRw+Y6il+yFCeC4aVhFlSYTeJKl7TQc6gYSROVvbscDx1TJbWCR3AQYdOEZ7w3+Ep9he9kQ4X/xqIS/jLPrIL0ZJHNELYtbyyO8XGj/bSutXJ08vGvmrV5nwr25jdzrc2znk9kFTTXVdIIXvTuAXkWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fau.re; spf=pass smtp.mailfrom=fau.re; dkim=pass (2048-bit key) header.d=fau.re header.i=@fau.re header.b=m4+agnWO; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fau.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.re header.i=@fau.re header.b="m4+agnWO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.re;
	s=protonmail2; t=1787259759; x=1787518959;
	bh=PbQ7VaVYc5x2weXdLWgNj+9JbFtvI6C+Awx0zQ4rjhk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=m4+agnWOK8rXt5YMPdXvWdqut56i1DE4+uSqnkieKKKDwtyImRCvJMqwZTI6meUVs
	 U+10L8kI2+T8ZjNuQfV+Sf2pXQRR+MHzDLFV1ox9tqy7Q+NxVm9w14ClqAYbxIy9rH
	 CUADIUuIgibPLo0t0ETynyfFt/i4km7hUc4V2RIIlzJae0ReNbhw82pYE1Zw7OFaNu
	 4BMuj/ww7E7ggE4vzaw86K3G1u+anS3RYUwQtrrIOxQ7RMlaRxc5DmP9o+1TbP82FX
	 /Yk9ml2c5uNg7FzJohnp1M/kC00Nt4b7HELDfQ0RWpoteUuXo9OaoqA7CoxojdMday
	 0Dx5+BTHJnpuA==
Date: Thu, 20 Aug 2026 21:02:28 +0000
To: check-auth@verifier.port25.com
From: Boris Faure <boris@fau.re>
Cc: Boris Faure <boris@fau.re>, stable@vger.kernel.org
Subject: [PATCH] soundwire: intel: initialise quirk_mask before reading it
Message-ID: <20260820210215.217919-1-boris@fau.re>
Feedback-ID: 104543335:user:proton
X-Pm-Message-ID: fe2d7f3e7e2360ddffc25c480b8758e3a25f5a25
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


