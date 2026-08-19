Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238CC3F2113
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125656; cv=none; b=B6k1FAA4i8ulkqLJq4EPP81+5Li+DVArVq4p5vsaZ3CcrG9+b6oQVtiAqhiC1yV2cLwApo7MRjxFSThTi90bYtxdag5cTs+2v+S9iL++ySbQzvM0uNjMtZzm6aX6OKk7x6t+b+lo0rUQqz87sJptDSe4JudkAZoILg0MlLLawys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125656; c=relaxed/simple;
	bh=+Hi6780Kv5VmSIKC6qy2EAXIan5Vh6UN8yxK7Ra3YD0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=KfSPJPurgzLI4dDVDKD7KrE4KzlDOCkuE47fWA1ZYwCDt+rykm+DurH1Ma43Pm0dsczVvPrG/5ng3f3vYquN5pkJe7KUCEEK1+TvpQoV2MG/CEaXXlxEfOePtoK7J7uEcArfF92PKmCrjtmzf32cVy6CzX8xySWdmSh/qZNfZ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b3tUpNqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b3tUpNqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142FE1F00AC4;
	Wed, 19 Aug 2026 07:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125655;
	bh=D6P4pEMtSeIe6QqEdrgO7ddsuowuna2fe3urrv5dtug=;
	h=Subject:To:From:Date;
	b=b3tUpNqGpKPFW189b/b5vVWuUs0EANh4eGA9zlqB3Cu7FGDmLPbGvfp1bR0LWwG9r
	 7FogOktq+QJIQK4eBUVqltk11cvSO64/1iTFOyRwpz82MBiqm13oNnRPq9860onxkQ
	 6UloHFc3r0J3rsc2M2Y2ESqOy1JOMsLvlCWxsKZs=
Subject: patch "iio: light: opt4060: Reject integration times with a non-zero seconds" added to char-misc-next
To: vidhu.linux@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:37 +0200
Message-ID: <2026081937-sulphate-phonebook-2bdd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: opt4060: Reject integration times with a non-zero seconds

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From b7e6e9af0d723afdec92364d5e7e064eeef44c8e Mon Sep 17 00:00:00 2001
From: Vidhu Sarwal <vidhu.linux@gmail.com>
Date: Wed, 15 Jul 2026 06:45:42 +0530
Subject: iio: light: opt4060: Reject integration times with a non-zero seconds
 part

When setting the integration time, opt4060_write_raw() only uses
val2 and ignores val. As a result, a write such as 1.000600 is
accepted and programmed as 600 us, silently discarding the whole
seconds part.

Since all supported integration times are less than one second, any
non-zero val represents an invalid input. Reject such values instead
of silently accepting them.

Fixes: 0c6db4506ad0 ("iio: light: Add support for TI OPT4060 color sensor")
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/opt4060.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index c391ad3271c6..cf6f69e5be35 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -632,6 +632,9 @@ static int opt4060_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
+		if (val)
+			return -EINVAL;
+
 		int_time = opt4060_als_time_to_index(val2);
 		if (int_time < 0)
 			return int_time;
-- 
2.55.0


