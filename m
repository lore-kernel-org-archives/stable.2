Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B4135836E
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125628; cv=none; b=JMsiNv9kykb4qwAikMdbm8sCR0rKffGk+1BlxY2Ais9uOJ0Q7zQWtgzfM1uYushRbep5s4zRF7zHPBuPj97EvJi3Mc601jDeOq0dDhq14YZj2FK7mjcRWBM99TgJQe787CS19a7EjqkEqEp8Gg72SlxvEaVIdYuwUwM2Fdr6wGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125628; c=relaxed/simple;
	bh=pVOj7OIuVqdGB6+4wBPw7JoTqyTJbcpZZCXu5S1QkBs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=RSxg7z7Pt9iHhU59vWP60zBxcpDQqusD2WvcDOZEbgHbe/fCUeaAgCyyAcGSUDMfHhu0ugL2NOXC30KczJABq6UasGQfHAOLMdfbKpOg2Mxg2IH/S0uE8HS04jifmLGnxnoqyO7xHOJ7dcD9uvXmN7ejOounfOF+JTy1JYxZbEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n0rQQyTd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n0rQQyTd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C8A1F00A3A;
	Wed, 19 Aug 2026 07:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125627;
	bh=70uIzEAWjXFxDhO7e586W+TpiLbq7cDeYhvztpB4q/E=;
	h=Subject:To:From:Date;
	b=n0rQQyTdMEEbpuXX91H2p4zD5OZgMWfSeGepqNkrlpwOT2t7IfLZIKuBXE2F3SJJM
	 SOQ5XPS7LBsZQVPpzZqmV7w0/vkgslPnN7wzthRDdMWbCEIq7bCwHGcaYKeR7h5CMM
	 UJX/MLT3CEUOhRSGQiTZhjfAj0gfwgGiyqjwbxP4=
Subject: patch "iio: dac: ad3552r-hs: fix scnprintf() buffer bound in data source" added to char-misc-next
To: bbnpreetsingh@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:35 +0200
Message-ID: <2026081935-sterling-duress-d55b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ad3552r-hs: fix scnprintf() buffer bound in data source

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From f2c5c76306fadb834dd5ea76cab0b7cd447e6035 Mon Sep 17 00:00:00 2001
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
Date: Sat, 18 Jul 2026 18:22:36 +0000
Subject: iio: dac: ad3552r-hs: fix scnprintf() buffer bound in data source
 show

ad3552r_hs_show_data_source_avail() formats the available data source
names into a 128-byte stack buffer, but bounds each scnprintf() with
PAGE_SIZE instead of the buffer size, so the bound does not protect
the destination at all.

This cannot overflow today - dbgfs_attr_source[] has two entries,
"normal" and "ramp-16bit", 18 bytes formatted - but the bound stops
protecting the stack the day the table grows. Use sizeof(buf) so the
bound matches the destination.

Found by smatch:

  drivers/iio/dac/ad3552r-hs.c:593 ad3552r_hs_show_data_source_avail()
  error: scnprintf() 'buf[len]' too small (128 vs 4096)

Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/dac/ad3552r-hs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 6bc64f53bce9..5d6c2517a7a8 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -591,7 +591,7 @@ static ssize_t ad3552r_hs_show_data_source_avail(struct file *f,
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(dbgfs_attr_source); i++) {
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
+		len += scnprintf(buf + len, sizeof(buf) - len, "%s ",
 				 dbgfs_attr_source[i]);
 	}
 	buf[len - 1] = '\n';
-- 
2.55.0


