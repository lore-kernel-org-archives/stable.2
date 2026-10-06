Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F951377EB8
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273839; cv=none; b=iTLRac3BJmYZS9HxHNA0OZBBr9d3vct6UlTO1wIkbIDEkcIbo2e6ZwBWPelKEjqZRlALTI1HHstrQcSV4z6ROMRxbS0c4HEcgCbxO6MPsdVkgDVnGz/l8Cjt04jwp8YMQoD/O3uH/CiInvFuFSMyalOSVrOkWghcK5IJ4Wk8R3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273839; c=relaxed/simple;
	bh=uL9m4kvlYxvAigBNqzPwvQ2eLs4OiZwg8wDQLcJ98G8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KNCVoF2A1jdHQDJWFDLu8XfDzUdVMmvxoVWTkea+SB+U005eGOmSe+0gLZTX4ORyd809ya2gmxmlqZ4O2IsXYqzvrS9H7o5i4uPPIFCGwkTuWb2sofq534ivVb78RCb/AvAeg2d96c5J0sCpc7Q3EcXb5wdkSeooOjHGfStoaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xIBDoCSI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xIBDoCSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0431F000FF;
	Tue,  6 Oct 2026 08:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791273838;
	bh=OLPAi9nHA9MxtdoeG2VkN4xOWckq7THu/TJuxxWEXF8=;
	h=Subject:To:Cc:From:Date;
	b=xIBDoCSIXzlBZkK/mbxOaUJq5gmgDNgBYhjTYq5YNIgFfi0FnCgIe1MT5N6wdPWT+
	 0324bFUlFzGZ/98rGoXdiPclyk1kYdzRcqNRkeiyHFO1UCiOMZ/Z2aZfFJIofM4Z2d
	 0ReQ9m8FgqDk2CXYXlFMu4HhTOuMcjrL91RwHETw=
Subject: FAILED: patch "[PATCH] iio: buffer: serialize buffer teardown with mode claims" failed to apply to 5.15-stable tree
To: kimjinseob88@gmail.com,jic23@kernel.org,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:53:42 +0200
Message-ID: <2026100642-decathlon-jittery-ce0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 84bb0fc46ccf6a545b8fdf57cda83770186ed8dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100642-decathlon-jittery-ce0d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

