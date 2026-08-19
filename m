Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CA3F54DD
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125651; cv=none; b=adYoGa4Z5LRI4pKBkpWLhSM6oREAtCGbUHSzdgZ2qTMKbCcLc6lnjT2PWnu7z9FsDpbvtKF5hx+92tYsbRr3S5pTyoQ0ZBl/DzBOGAGP0fHga9lZGQFcoAW7fKLvTHKi0ap6zvgdh8rkbMvx8+nLhcutKtRoG9OFgG1iEYeukbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125651; c=relaxed/simple;
	bh=TouhOspaZhIvvCHx8LUeBeEvFTvCKXfQrLkgV56KyqM=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ZJAfK17m8+uj40fT27HzA/t+wPxS8EHB/MsY00kNobCt0xkwfVF0VIPqLbHtwXOjzWgpDvOXsZGakis5MgSUn6WVDxuK0hSLXuB3JnTlYU/ubv9Bs6pEHFePrax01/7oedwCJHPw6D7uURNC0PMyuEUt2ClI+mqOjrEskxpfMjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ft9Wxg29; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ft9Wxg29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90C41F000E9;
	Wed, 19 Aug 2026 07:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125650;
	bh=1fMPK5mCMQm7kQ+7Sdc/zGYTHfh+7ZgscFeJ3hDR46w=;
	h=Subject:To:From:Date;
	b=ft9Wxg29SdBLKpyGnr9LFTLXiwPe5cfvihrLAlv9zisDU8HkNU9RqPFDTbnCfdoSn
	 Te0vd4Hu1jGHUqN0pbt98LtjPtUNC31DyJ81iSE/wBZWXBCmLJ6IIgsusNSr3RS7Kq
	 MslxIUL9bN79M46qD0cVDMTQdQ3vXpeGrUX9UtD8=
Subject: patch "iio: light: ltrf216a: fix runtime PM reference leak in error path" added to char-misc-next
To: vidhu.linux@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:37 +0200
Message-ID: <2026081937-overnight-component-ccc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: ltrf216a: fix runtime PM reference leak in error path

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From c132aef0e757a39036b1d40faf0569f2e343b13e Mon Sep 17 00:00:00 2001
From: Vidhu Sarwal <vidhu.linux@gmail.com>
Date: Mon, 13 Jul 2026 07:58:29 +0530
Subject: iio: light: ltrf216a: fix runtime PM reference leak in error path

ltrf216a_get_lux() acquires a runtime PM reference by calling
ltrf216a_set_power_state(data, true). However, if
ltrf216a_read_data() fails, the function returns immediately without
dropping the reference.

This leaves the runtime PM usage count unbalanced, preventing the device
from autosuspending after a failed read.

Fix this by releasing the runtime PM reference before returning from the
error path.

Fixes: 83f0bcd40d5c ("iio: light: Add support for ltrf216a sensor")
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/ltrf216a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index aad96fc91565..dd8f3260b1d8 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -248,11 +248,10 @@ static int ltrf216a_get_lux(struct ltrf216a_data *data)
 		return ret;
 
 	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
+	ltrf216a_set_power_state(data, false);
 	if (greendata < 0)
 		return greendata;
 
-	ltrf216a_set_power_state(data, false);
-
 	lux = greendata * data->info->lux_multiplier * LTRF216A_WIN_FAC;
 
 	return lux;
-- 
2.55.0


