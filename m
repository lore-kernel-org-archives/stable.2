Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC73D47BF
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127700; cv=none; b=L0/I1UEVctEniMmeF+6ZO1ziKvwtf+JPCm+E4rRfowxkndnX2uWtmkCmc9A9wwG5MTWxHRgL7jGhyjUH3gNfWOSDgyojuoRXqnbUiGj6i+lc7D/FwVWNa6qZBqyoKlsFSEgmVKOlwhmMqJuYWKkvgEY7VYb+Lw1j0sdW+Yv0ZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127700; c=relaxed/simple;
	bh=iaNwu5zbb7vOw6/ovif6ci68KsH2VGvPrNwkO2GQCXU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=PRAyK5dui6DK1IGoCHdJ/1jW20MybRGCLiJoUy2WXxyn6pJQM3MK6ol0oRHfQFpzDpieyGCtalICRQC9sBXRvGH51QGHM4M0ArSxF42qi0nvL9Wo7YeI4GqcV+Ik2XITdtBn8b6s1llVKP7Szbk/GqmZ4FuZjQGOm71SvfzKDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IQA4PRqw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IQA4PRqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08181F000E9;
	Wed, 19 Aug 2026 08:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787127697;
	bh=xhvwErCZjyeOx5wlwBTa5hWr5ocGH4/24wj2i2Z6JA4=;
	h=Subject:To:From:Date;
	b=IQA4PRqw2RU+Ai4XdlQEkgB/tQ+JBr4IgKdOgBGkPAs4xeemFf7MGrqx52qrq34Ul
	 6GucunlydHQeVJ/Auid289JwPpBlZ1+5L3X7eeQTPAsUHxuQAja8Y7mF41gKKKwUPe
	 xS+mQQQtuuHnHEKrK9UgN0xuzVq939M2ZpWpoclw=
Subject: patch "iio: chemical: sgp30: Handle IAQ thread creation failure" added to char-misc-next
To: lilinmao@kylinos.cn,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:49:11 +0200
Message-ID: <2026081911-request-sterility-144b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: chemical: sgp30: Handle IAQ thread creation failure

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 1135d6875d2dbda3f6ec718f3421a6ce4378bd63 Mon Sep 17 00:00:00 2001
From: Linmao Li <lilinmao@kylinos.cn>
Date: Wed, 22 Jul 2026 15:48:37 +0800
Subject: iio: chemical: sgp30: Handle IAQ thread creation failure

kthread_run() can fail and return an error pointer, but sgp_probe() stores
it and returns success, so the device is registered without its IAQ thread
and sgp_remove() later passes the error pointer to kthread_stop(). Return
the error from probe instead.

Fixes: ce514124161a ("iio: chemical: sgp30: Support Sensirion SGP30/SGPC3 sensors")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/chemical/sgp30.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index f10bbebc29e4..379c1c4af8d8 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -548,6 +548,9 @@ static int sgp_probe(struct i2c_client *client)
 
 	data->iaq_thread = kthread_run(sgp_iaq_threadfn, data,
 				       "%s-iaq", data->client->name);
+	if (IS_ERR(data->iaq_thread))
+		return dev_err_probe(dev, PTR_ERR(data->iaq_thread),
+				     "failed to start IAQ thread\n");
 
 	return 0;
 }
-- 
2.55.0


