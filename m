Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486093DC84C
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125537; cv=none; b=EzilsgUcREJMhEFR6EAfoKrysxoGpCzJ3g+h+wKhP4Uq8VfTv3071ei/WKnp3N7SmLv1ypXc9kJyLhXKC5Av8+tYgLRpoBMFjtpNVIUA+UivPeGu1mvC5a7TTqOiCPYV9G06o7NgmX1Z9dI+Y/vRWOVjaPkZq46sm5SI8lBpqKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125537; c=relaxed/simple;
	bh=f9sb3Yg25Bjak4hg5aWoE189LGyYLinp8DX5HciNDSk=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=LAaBn7OKUDOpE3uFXpu+cHit+d8tHRC4ikD6LoL6G+fW1WXur2DajyoToFNdkwRAkxzyAyTiZ+8Igszjb58LYzEHvksLBxD0YrvL0smyiyiusuBY7JJ9ltRyu3mzBMAYIZPljaMspcg2z6PojkuM4pvkwtnkrOpwz93s/BGA55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X29hhVey; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X29hhVey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59791F000E9;
	Wed, 19 Aug 2026 07:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125535;
	bh=KKiLxssHqcmTOFltNUy/mBXZoiF+xJbpiQNLSSdoPG0=;
	h=Subject:To:From:Date;
	b=X29hhVeyyEBHJvg2/Wz49b20MUVz5WZ9qXzdP3NipNJbuXUM8P4ZbSFySwoLU3BDO
	 CRUs7kqYB7zTz7ekUrVWG8k46TO+47e5GrDkVx/tKUKEm2uJyOTC87KcUbOAtr870J
	 L5pAZ3ufAjbmVgSeSZ2y3VgxBQ0cBhYbJawsG3KA=
Subject: patch "iio: light: opt4001: Fix reversed GENMASK() arguments in fault count" added to char-misc-testing
To: nikhilgtr@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:07 +0200
Message-ID: <2026081907-omega-crux-2e3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: opt4001: Fix reversed GENMASK() arguments in fault count

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From d64bfd9f3352b9d9bdeca06de1a0a1c1bd47b896 Mon Sep 17 00:00:00 2001
From: Nikhil Gautam <nikhilgtr@gmail.com>
Date: Tue, 14 Jul 2026 17:01:34 +0530
Subject: iio: light: opt4001: Fix reversed GENMASK() arguments in fault count
 mask

GENMASK(h, l) requires h >= l, but OPT4001_CTRL_FAULT_COUNT is defined
as GENMASK(0, 1). The define is currently unused so there is no
functional impact, but fix it before anyone builds on it, and add the
_MASK suffix for consistency with the neighbouring definitions.

Fixes: 9a9608418292 ("iio: light: Add support for TI OPT4001 light sensor")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/opt4001.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index 2448d6330489..aa3d87995b7c 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -39,7 +39,7 @@
 #define OPT4001_CTRL_OPER_MODE_MASK      GENMASK(5, 4)
 #define OPT4001_CTRL_LATCH_MASK          GENMASK(3, 3)
 #define OPT4001_CTRL_INT_POL_MASK        GENMASK(2, 2)
-#define OPT4001_CTRL_FAULT_COUNT         GENMASK(0, 1)
+#define OPT4001_CTRL_FAULT_COUNT_MASK    GENMASK(1, 0)
 
 /* OPT4001 constants */
 #define OPT4001_DEVICE_ID_VAL            0x121
-- 
2.55.0


