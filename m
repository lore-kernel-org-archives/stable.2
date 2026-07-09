Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE52B3A9610
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575904; cv=none; b=BcAkZ8V/kSGYrfYSgiFzr/e2ytrkCoLv3IU8NOGTH0Eaig6Ai1ItZ7jsWZWryRsKKkVX2PxnWb1XXBNSeiicIa/SfMRtUhHe0zPomXo9s6Nms+RJKENGPKvHPg8+/BJ4JSvXhGdN+IXvB4vMTZoXNZnjAjp/EXMPjVirXmmTJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575904; c=relaxed/simple;
	bh=ABWJ7j5BXNJerHLCfs1teyBWIojSTl9WQXokkK8VFpw=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Pp7hpIEUevcQWYSkIAkRsL0m8uuZzALfd+3tfG03VKT4CGtgFOePP37IdH2BGsEXKNjj60FWpMsFPnVzGuFBkVCGMco2Cq0TUL/lwhhHO1VDZCiCV2aZegFIm/ZrT4EIxc8aGeOm7+68GaiRfum1HFfknBNZ6ZDi3xkbJ6MQEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLJ+26Os; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLJ+26Os"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059BE1F000E9;
	Thu,  9 Jul 2026 05:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575902;
	bh=M0x9vXMjmVB37SuVQLN1w2ZDUWStDIfPaaGWJU6gtHc=;
	h=Subject:To:From:Date;
	b=QLJ+26OsGv50/CPSXJNe1esRfMeU4F9xRyvzZPUPgO0Gl2fcbarVQgrB1Vo8714GL
	 v0ps62IsjjXQMDeKG2BiNmV9RJ1/ZQBH4kcqc8LzpFADAIZq4f4J1O/h2NQJ4Ti/NX
	 /nd0XG8duoiX5qhW7b9vMz6PQ5plPBdmvz1/I+9c=
Subject: patch "iio: light: gp2ap002: fix runtime PM leak on read error" added to char-misc-linus
To: birenpandya@gmail.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:47 +0200
Message-ID: <2026070947-chemicals-stamina-2109@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: gp2ap002: fix runtime PM leak on read error

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 38b72267b7e22768a1f26d9935de4e1752a1dc85 Mon Sep 17 00:00:00 2001
From: Biren Pandya <birenpandya@gmail.com>
Date: Sun, 14 Jun 2026 12:45:49 +0530
Subject: iio: light: gp2ap002: fix runtime PM leak on read error

gp2ap002_read_raw() calls pm_runtime_get_sync() before reading the
lux value, but if gp2ap002_get_lux() fails, it returns directly. This
skips the pm_runtime_put_autosuspend() call at the "out" label,
permanently leaking a runtime PM reference and preventing the device
from autosuspending.

Replace the direct return with a "goto out" to ensure the reference
is properly dropped on the error path.

Fixes: f6dbf83c17cb ("iio: light: gp2ap002: Take runtime PM reference on light read")
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/light/gp2ap002.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index c83f67ff2464..a8db514cca5e 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -258,7 +258,7 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
 		case IIO_LIGHT:
 			ret = gp2ap002_get_lux(gp2ap002);
 			if (ret < 0)
-				return ret;
+				goto out;
 			*val = ret;
 			ret = IIO_VAL_INT;
 			goto out;
-- 
2.55.0


