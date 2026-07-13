Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63E064
	for <Stable@vger.kernel.org>; Mon, 13 Jul 2026 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947228; cv=none; b=mNQ/coxBspmXeiI6AGV2COR7/Cdzlw3e5AmwmXeYv9iUvCQ0nTQAUCywP8wJD0NFwrXRezE1jJ3/RsRpn4sHPPWZ6Z+uLEfhgkJeWh5237r+yslenGn89GHMrAST9yJqDkWo2GUliieljTEhzagA0dAUmoYFNlPn4oauSi6SCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947228; c=relaxed/simple;
	bh=c4sboxncqllZZm0H4vdZzEX68u8JtQ2dVM/v3c5LvFk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jcFNPQ28uVc0eWLa0oXn/sph0lbXxWUoyWE6TqywvNfFNICpB4MgDE1u8Q7Ckhznu0HdPgGdl7H/my7I+706wwd0puNyj6rJwrskgLrOnEsWjGdJcKia48P2IvseYDrUd5dc9Eof6f8yJtCrQEx7wjahi7Hkgcp1Fa/qBMmKzBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LCL/AZYN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LCL/AZYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C681F00A3D;
	Mon, 13 Jul 2026 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783947226;
	bh=rIxVWUWqy5uShXDeXOtYxUJBGN0oqzTy6ydd6803Zew=;
	h=Subject:To:Cc:From:Date;
	b=LCL/AZYNoZKFZljY8jxEmZ5rNuHNFyrE7tgcMkggfcMpsJ1dkefYFxzcxhOKvOnS2
	 TRNdaed/+JVPXS4bISWi0MGmcRgmpEEYhVmyWpeWO47ZNGieJBEKO7hjVSELsuBDOV
	 w5m9wyRFxzHlKIK8L0TN3eD/TVcmxdFZQFUOBKgc=
Subject: FAILED: patch "[PATCH] iio: pressure: mpl115: fix runtime PM leak on read error" failed to apply to 7.1-stable tree
To: birenpandya@gmail.com,Stable@vger.kernel.org,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 14:53:30 +0200
Message-ID: <2026071330-evasion-badland-cd54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x fbe67ff37a6fd855a6c097f84f3738bd13d0a898
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071330-evasion-badland-cd54@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

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

