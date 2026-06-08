Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6502387363
	for <Stable@vger.kernel.org>; Mon,  8 Jun 2026 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947747; cv=none; b=mHjgVyQbUbPPnyLdLpyz53v9yF5P/NpyUYhpQOwSOEEirSbiig/4ZKU+KlAlSlq1cdTd0KfjEaoay1KwQgegbi5sep8bImPA0ZSGBlrjeuHXtCAMUY9cwEYEgnH8EWZcgH6aBILDRH2wxWgMPMaGRwtMZ7/klFiySaWcDXW6McU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947747; c=relaxed/simple;
	bh=kkR11O5JNerz44GLs76rgb1MOjWu0AQL34WKmDAxbTE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=p82n6PbjwQYuMlilUreYlEm7bWcfYKZtEeIskXI8olprs7Kg08ieex7RdpZizkp3ma4/oS5DU3DDU355FvCPGnQaUeAZCcWzTYk0vtpWuI2WssrUpw9uwsV6aW3X8DawbOoeJwjngPgDSCCEyXj7yFcdgsITF2lResVGjmEOguI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QSn3IHpf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QSn3IHpf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A901F00893;
	Mon,  8 Jun 2026 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780947746;
	bh=CwFSpyUsjPQcAGifiwGPjyNNXwU0CdD9LCCP/L1m8Dk=;
	h=Subject:To:From:Date;
	b=QSn3IHpf1h7/q2YNaNZ7bBh9vOdWIe9t8hjyODQSbRw2weZ8LJR7itdFv3fnJQpSb
	 ocB10NzngWzx+cXm7S1rDinO6TzWQpEW54qGG+wXfReSchQ9nJTytjQrnWKYq+fbYw
	 dVRRO4pEuw5CLnZXORHaQ1+2wexMdARPlPQJ1/qM=
Subject: patch "iio: magnetometer: ak8975: Add missed pm_runtime_put_autosuspend()" added to char-misc-testing
To: andriy.shevchenko@linux.intel.com,Stable@vger.kernel.org,jic23@kernel.org,joshua.crofts1@gmail.com,sashiko-bot@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jun 2026 21:30:32 +0200
Message-ID: <2026060832-elated-busybody-1b5a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: magnetometer: ak8975: Add missed pm_runtime_put_autosuspend()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From e94944d7364d3ddb273539492f9bd9c9a622549a Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 6 May 2026 10:27:55 +0200
Subject: iio: magnetometer: ak8975: Add missed pm_runtime_put_autosuspend()
 call

On the failure in the ak8975_read_axis() the PM runtime gets unbalanced.
Balance it by calling pm_runtime_put_autosuspend() on error path as well.

Fixes: cde4cb5dd422 ("iio: magn: ak8975: deploy runtime and system PM")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260505-magnetometer-fixes-v5-0-831b9b5550fc%40gmail.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/magnetometer/ak8975.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 44782c26698b..e70101abfcd3 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -784,6 +784,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 exit:
 	mutex_unlock(&data->lock);
+	pm_runtime_put_autosuspend(&data->client->dev);
 	dev_err(&client->dev, "Error in reading axis\n");
 	return ret;
 }
-- 
2.54.0


