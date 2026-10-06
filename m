Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E63CAA2E
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273842; cv=none; b=cM7bInevth2/6rJzTrOObq0WLiiIsgJwtvppN0NF5NNynhfvhzoLiNXspE0AcllEZZbxJhV7FmJ81RLT6rhSaESCV4cxEVZdm44RJcHF3YiikTxMRP9qhO5xcdjbIi2TZYXr1/9/rWqSRxej3WOzxNzqqj11gKv8YQa5RdTsR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273842; c=relaxed/simple;
	bh=3OdA+7UohTfV5EgvbPclmpGRIlpXGw8/tI1MlapaZ5c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tvO1nwjpeY0EbHK3MSQzWuBywE4+zqlINCkeNDFYt1wjj6b1APv6RcFBcmL0ErddVWlsyhQv7JQN+uTbeLeN7azpS8MaOZdpMCc3V/ioQg0vx94vIJOcMjlKYOLG6OnOocjzDA9zqrveXSXft0+CTgn8sG4oquCH37KMFKEV54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fKsp6zLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fKsp6zLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F207C1F000FF;
	Tue,  6 Oct 2026 08:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791273841;
	bh=zZrK/8v6Fv2btRbsghIaefpw/5qW80B+ohUG6Zge5B8=;
	h=Subject:To:Cc:From:Date;
	b=fKsp6zLx7B2lB6UhAhi4GAAi2Fa8Yp99DfjL3hJjOyqX1IQPS7b3RxVzmB4MzrA3r
	 8216kfX5ySXX7FYICSki4t23S5EJAnZkJLeLCuxIt+28bX1xPMT4hSO2jc8kc4SJsn
	 HAabL0PjbOOVHkL1ZPuCAmjAoxmhQDgfDN/Qh9SU=
Subject: FAILED: patch "[PATCH] iio: buffer: serialize buffer teardown with mode claims" failed to apply to 6.1-stable tree
To: kimjinseob88@gmail.com,jic23@kernel.org,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:53:42 +0200
Message-ID: <2026100642-numerator-hurler-5b19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 84bb0fc46ccf6a545b8fdf57cda83770186ed8dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100642-numerator-hurler-5b19@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 84bb0fc46ccf6a545b8fdf57cda83770186ed8dd Mon Sep 17 00:00:00 2001
From: Jinseob Kim <kimjinseob88@gmail.com>
Date: Mon, 21 Sep 2026 15:24:21 +0900
Subject: [PATCH] iio: buffer: serialize buffer teardown with mode claims
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Buffer-mode claims hold mlock to guarantee that the device remains in
buffer mode until the claim is released. Normal buffer updates take
info_exist_lock followed by mlock in iio_update_buffers().

However, iio_device_unregister() disables and deactivates all buffers
without taking mlock. This can invalidate buffer state, including
active_scan_mask, while a buffer-mode claim is held.

Take mlock in iio_disable_all_buffers() so that unregister honors the
mode-claim lifetime guarantee. The info_exist_lock -> mlock ordering
matches iio_update_buffers().

Fixes: 0a8565425afd ("iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 902401be0b67..4294101810fd 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1377,6 +1377,10 @@ EXPORT_SYMBOL_GPL(iio_update_buffers);
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	guard(mutex)(&iio_dev_opaque->mlock);
+
 	iio_disable_buffers(indio_dev);
 	iio_buffer_deactivate_all(indio_dev);
 }

