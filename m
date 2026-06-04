Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD8C1E1E16
	for <Stable@vger.kernel.org>; Thu,  4 Jun 2026 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568216; cv=none; b=Ntyenm1OVtY8G8dIRmokapyePcdxKLG/VPDN2r1jfDmV0Agr3a/XlNL5yfZOZJuY96sVz0HMQTGojEuE5Oq8JqSMlL7WOQubJabPPJdvvfpwppt/EmUgZiPiohAJ5t+Ml69kIkioOT6uKjLCUdpO2UVHgnkOfjSNfssarRvUumI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568216; c=relaxed/simple;
	bh=VAKMw0ZPq0soWXuZdjSmTIpMVjSTteBkuQk8tSiABWQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cSK7KzjXOFAjDpPGtCMucXrS4rzolvqKPXCSdTRmeyyoGCwWMus4KAD/wQBovpkrper+ficKRmMEKfojUaORzfFQfEB3f4K5fCBQfkhgvx4dWkaMKuoGFfscad8SybYkej40hS09RRjI4Pmx7g9lfgROc38WRdZfA+tabacpf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZDI6Zfii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZDI6Zfii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D771F00893;
	Thu,  4 Jun 2026 10:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780568215;
	bh=li+/a9v/YjA3OYwlFOjuMPcxea+FXXANd+Nr6Pfm38Y=;
	h=Subject:To:Cc:From:Date;
	b=ZDI6Zfiipo3B++j3PTK5G6/A6eXvG4mcCFqGAknuvdRE4NQWWIGQBTXP2XXZGe4wr
	 AA1mK4RrLJ6M99uIB3QAVpFFHYmwRTdGWD6Ub5jvxhn2Um8Ml1oR+wHhVOWT78oXjt
	 YcOjC7G8BWOnBTEYkmK5E4AGWhDakDYJ3zh/8BwM=
Subject: FAILED: patch "[PATCH] iio: dac: ad5686: acquire lock when doing powerdown control" failed to apply to 5.15-stable tree
To: rodrigo.alencar@analog.com,Stable@vger.kernel.org,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:15:58 +0200
Message-ID: <2026060458-baked-charter-80ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5237c3175cae5ab05f18878cec3301a04403859e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060458-baked-charter-80ae@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5237c3175cae5ab05f18878cec3301a04403859e Mon Sep 17 00:00:00 2001
From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Tue, 5 May 2026 13:35:04 +0100
Subject: [PATCH] iio: dac: ad5686: acquire lock when doing powerdown control

Protect access of pwr_down_mode and pwr_down_mask fields with existing
mutex lock. Each channel exposes their own attributes for controlling
powerdown modes and powerdown state. This fixes potential race conditions
as those the write functions perform non-atomic read-modify-write
operations to those pwr_down_* fields. This issue exists since the ad5686
driver was first introduced.

Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 27878a6318ff..2e443fcfeb39 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -30,6 +30,8 @@ static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
 }
 
@@ -39,6 +41,8 @@ static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
 	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
 
@@ -57,6 +61,8 @@ static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
 				       (0x3 << (chan->channel * 2))));
 }
@@ -77,6 +83,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	guard(mutex)(&st->lock);
+
 	if (readin)
 		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
 	else

