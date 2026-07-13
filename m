Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4A040D56A
	for <Stable@vger.kernel.org>; Mon, 13 Jul 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947084; cv=none; b=BG1XIuwN+dIdDAJuCwDR06bH3uF6ObJ73LOP+XbaaiG8NR1rH8uCioesU8cTp0bWVDFLlOu7eUwmEO+XG0chS7/KOV8Da/sE6WRbwwwiTfr4U/rlp+MZ9+nPCr7Jo9lV0blRWCvcGHBcR/CG6epgGR0XJ9AiP37mA7zVaChys2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947084; c=relaxed/simple;
	bh=LqAv7VKnMzvRvZh7OI0eA9TVacHRhT78EzGhvLCroWg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uHq97XnhAI3hsdNgmFfAlJzWAmdCyfav49KrhFXAxIm4cNOcp+h9KpERmuzLb2BsQdsJmE7WTgWJ9AapJ5qVCmRNCUfec6Gs+YCqtIb73742fmnyM+N3KZB7dkiuiV5sv+lLvHVhSZy6Kr+1q1n7WESXwOANQF0WpFmvrayfQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZM6w7gS1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZM6w7gS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8A21F000E9;
	Mon, 13 Jul 2026 12:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783947080;
	bh=K4hb0Z64Z+xGJklQazrXduEkj4LDbRe3DTDmouLRYi0=;
	h=Subject:To:Cc:From:Date;
	b=ZM6w7gS1YIYzTn0YVNCINJPNgxoM1HVVC2JWkaVCh8VdaauAonMN/YIBHG/7pUv1X
	 0880uRMVoKHp3cUxGeuwNE5zuU/udPfgxLRwmNcz+WDpSU4M7GNwZ2uGMEnhYksgpB
	 ZtfptwviWRnJ5f3eKx4st0VXDVVMDYTDI+Nskhe0=
Subject: FAILED: patch "[PATCH] iio: pressure: mpl115: fix runtime PM leak on read error" failed to apply to 6.12-stable tree
To: birenpandya@gmail.com,Stable@vger.kernel.org,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 14:51:15 +0200
Message-ID: <2026071315-trespass-legible-97d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x fbe67ff37a6fd855a6c097f84f3738bd13d0a898
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071315-trespass-legible-97d4@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fbe67ff37a6fd855a6c097f84f3738bd13d0a898 Mon Sep 17 00:00:00 2001
From: Biren Pandya <birenpandya@gmail.com>
Date: Sun, 14 Jun 2026 12:45:48 +0530
Subject: [PATCH] iio: pressure: mpl115: fix runtime PM leak on read error

mpl115_read_raw() takes a runtime PM reference with pm_runtime_get_sync()
before reading the processed pressure or raw temperature, but on the read
error path it returns without calling pm_runtime_put_autosuspend(). Each
failed read therefore leaks a runtime PM reference and prevents the device
from autosuspending.

Drop the reference before checking the return value so both the success
and error paths are balanced.

Fixes: 0c3a333524a3 ("iio: pressure: mpl115: Implementing low power mode by shutdown gpio")
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Assisted-by: Claude:claude-opus-4-8 coccinelle
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 830a5065c008..16e112b796ba 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -106,18 +106,18 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		pm_runtime_get_sync(data->dev);
 		ret = mpl115_comp_pressure(data, val, val2);
+		pm_runtime_put_autosuspend(data->dev);
 		if (ret < 0)
 			return ret;
-		pm_runtime_put_autosuspend(data->dev);
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(data->dev);
 		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
 		ret = mpl115_read_temp(data);
+		pm_runtime_put_autosuspend(data->dev);
 		if (ret < 0)
 			return ret;
-		pm_runtime_put_autosuspend(data->dev);
 		*val = ret >> 6;
 
 		return IIO_VAL_INT;

