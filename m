Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFBE37DAA9
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575906; cv=none; b=Aj0G3avDjEif09c7Zdljo3sGgvn8hNX6epg+NxTNMN9h8GiRodnS6ia6rzLmI/MJyOILT/Gxha2idgZ18c+R5K6r6zitxYvIT3qg/ZMQ1EGHbQvgCw0WGHMn03PyNyRgZbaJALwYIur+DWHPmtGzZOb2nO7WTDcCHtl35TuQkc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575906; c=relaxed/simple;
	bh=8sdImcqfeJKi0y5y4+EyWY+UlYC84gq0RWZdG4R7lL0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=odxNJFtQ4cwBZ0rgwGa05eeTlh3gafszONU5MskGJwRPgojjgqv2jcqIe/nvj5C6RwFQkFNwNLosrAbuiDPxi1Q9EGVmSZQOmJxYMvL/+OBOZx1srl5Khl8KgqSS0hFEil2zOBON3Kv4CXti1VBYTeGJ5vgwHsGAiVxywTf4RL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qIviK5VQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qIviK5VQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47421F000E9;
	Thu,  9 Jul 2026 05:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575905;
	bh=Zd5EJjLzKOJl4zr6Fgxe1L69FEZ4O11WIA0lxP9Ot8w=;
	h=Subject:To:From:Date;
	b=qIviK5VQaovlVSa/g0/NH39ZVID9VUScVlKI35IDejuIT1XecWgnev+aFI4tThH1t
	 TpJRc1ryCqirjyxW6bksgkZOZrMj/W1a1OFXioZbCSY+j1EL+jcWI1ezurBgDr0uXJ
	 jyGNZjHHQdllVSFbAr8UjF+c6TZwAvYlfMZ20qyk=
Subject: patch "iio: accel: kxsd9: fix runtime PM imbalance on write_raw() error" added to char-misc-linus
To: birenpandya@gmail.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:47 +0200
Message-ID: <2026070947-granite-omit-19ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: accel: kxsd9: fix runtime PM imbalance on write_raw() error

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 44a5fd874bb6873bdaec59f722c1d57832fbc9df Mon Sep 17 00:00:00 2001
From: Biren Pandya <birenpandya@gmail.com>
Date: Sun, 14 Jun 2026 12:45:46 +0530
Subject: iio: accel: kxsd9: fix runtime PM imbalance on write_raw() error

kxsd9_write_raw() takes a runtime PM reference with pm_runtime_get_sync()
but returns -EINVAL directly when a scale with a non-zero integer part is
requested, skipping the matching pm_runtime_put_autosuspend(). This leaks
a runtime PM usage-counter reference on every such write, after which the
device can no longer autosuspend.

Set the error code and fall through to the existing put instead of
returning early.

Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Assisted-by: Claude:claude-opus-4-8 coccinelle
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/kxsd9.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 4717d80fc24a..7ac885d94d7f 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -147,8 +147,9 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
 	if (mask == IIO_CHAN_INFO_SCALE) {
 		/* Check no integer component */
 		if (val)
-			return -EINVAL;
-		ret = kxsd9_write_scale(indio_dev, val2);
+			ret = -EINVAL;
+		else
+			ret = kxsd9_write_scale(indio_dev, val2);
 	}
 
 	pm_runtime_put_autosuspend(st->dev);
-- 
2.55.0


