Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797339AD2A
	for <Stable@vger.kernel.org>; Fri, 11 Sep 2026 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120623; cv=none; b=pdfZ9oE4U0POH5NtNQqnV8/ZyQEO2zH91i+pzZrYzn1kAMpmkMay//pfqLS+oCiYlrffRvnUjqMFuQR42yhtn/hQkUdtK5tNYFCllGyEyp1YnN3R1BwrZUnv2e20TgiZFRQX/uH5xOmSJk2eaUFugcwC+fkSXiaG73dIKENPZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120623; c=relaxed/simple;
	bh=+h8q/+iUHrQcxkOPe+cx3+F6Cf3JV4T0GwnrlTKqmHE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=r9oO6TNtnpidcUOzdKvAZPmUplVt3cUQg3Zesa4VbzBaT8O4cReuHgOxbt+5FUWXb2H7X5oKUBCiVi/MEscrwfP+Fb8QFvmwG1GJsyswzHOhdDB1E1blL27+3snLPPovWTIbIGQ3IFYi60OKJfvwVBD/FPl8sfEBYYD8gxueSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Js9FAVMP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Js9FAVMP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9151D1F000FF;
	Fri, 11 Sep 2026 09:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789120621;
	bh=MVgC9HN3iNyeNqBX6VNzv4CcKDZ7jPhMZhXfbvB4iKU=;
	h=Subject:To:From:Date;
	b=Js9FAVMPK4r8XYUWgs88XUbHU6d3t1iz9TsI0fc5rfMS7OEBF6ZxqeV4kbMCJEZO/
	 zXp4hIRFdAWnF0Ir1mgP7Dimze94/Zc/gI4gImf/jiCi9Z+nJj91Odq1LSuwT2y+s1
	 WyYG+zTe+1sXt2p63qFU4TUjde4/aiSrGQ1xjoqM=
Subject: patch "iio: frequency: adf4377: Fully initialize clk_init_data and" added to char-misc-linus
To: geert+renesas@glider.be,Stable@vger.kernel.org,bmasney@redhat.com,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 11:55:35 +0200
Message-ID: <2026091135-strode-sandblast-6148@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: frequency: adf4377: Fully initialize clk_init_data and

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From e787fd23d5063c61582c3c27522240b6e6703fde Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 20 Aug 2026 11:19:52 +0200
Subject: iio: frequency: adf4377: Fully initialize clk_init_data and
 clk_parent_data

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

adf4377_clk_register() fills in init.parent_data, and assumes that
init.parent_names is NULL.  However, the latter is uninitialized, and
thus may cause a crash.

Similarly, adf4377_clk_register() fills in only parent_data.fw_name,
leaving other members of the clk_parent_data structure uninitialized.

Make sure all members are fully initialized, to fix such bugs, and to
avoid future breakage when converting drivers to a different method for
specifying the parents.

Fixes: 60e5448ddbec2dc2 ("iio: frequency: adf4377: add clk provider support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/frequency/adf4377.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 4dd19a9aa994..7385be62fa6a 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -988,10 +988,10 @@ static const struct clk_ops adf4377_clk_ops = {
 
 static int adf4377_clk_register(struct adf4377_state *st)
 {
+	struct clk_parent_data parent_data = { };
 	struct spi_device *spi = st->spi;
 	struct device *dev = &spi->dev;
-	struct clk_init_data init;
-	struct clk_parent_data parent_data;
+	struct clk_init_data init = { };
 	int ret;
 
 	if (!device_property_present(dev, "#clock-cells"))
-- 
2.55.0


