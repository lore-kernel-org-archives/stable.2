Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948F3B4E8C
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272807; cv=none; b=IeaujFL6grW7jzOwhScjKK4rawTcO3r+YWiL6mPhex+CuX+R99BKq7uxtdpCqBBm/dfuafvDpSdDPNje/Oo2V0E2myJl/gBvTxG5nWK3IjNZkD6k8Cobl96zivKcfiFHdsxJTrJv3yzZrRF0awTRvSmzmKlJJ2UAREvXWfb3qao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272807; c=relaxed/simple;
	bh=JuQ/vhtCXGRqEucB83p+HgeteOg60Vb+vj3QPMCjzfM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AGoLO3k3b0OAnQTf949jdu4jCr1Fpw/xL7lbK9AzxcRVfucHqkxTXYTeorgI6wI7YXRW5VYT48v9tZzrxbLHZbtKQXz5S1s6zutCr6MGgsAoUw8MyhGmow4Q+60UgkvFLGQLMBCI0l3pCplDZjeKT7iLRYgclcXsSi5NzgLHurw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ff6NyHZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ff6NyHZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06A51F000FF;
	Tue,  6 Oct 2026 07:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272806;
	bh=aqJ/p4CFNbIsicJIQLdJ+82RnYXu3+HMT34QnnJKZSA=;
	h=Subject:To:Cc:From:Date;
	b=ff6NyHZwFnWqHmbEE2QAoOqS8vdRLjIgcqwDXutfJZuwQxtBE7aji78mUk8JVnSal
	 0azIjEH4cbh/yvyT+vTg8QWR7OpfJV0v47KRXjbmQziOfRcbglOCAoowvYvU1in/YJ
	 U5SsBh/SjvudquFRu7Q/qFn1dQli+jAGAd6J85Eo=
Subject: FAILED: patch "[PATCH] iio: cdc: ad7150: fix OF matching and publish module aliases" failed to apply to 5.15-stable tree
To: hppiscas@163.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:46:34 +0200
Message-ID: <2026100634-lifting-faceted-daeb@gregkh>
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
git cherry-pick -x 52da294027f53e7084c18dd4b4f73354a40382f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100634-lifting-faceted-daeb@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52da294027f53e7084c18dd4b4f73354a40382f3 Mon Sep 17 00:00:00 2001
From: Pengpeng Hou <hppiscas@163.com>
Date: Sun, 20 Sep 2026 11:33:03 +0800
Subject: [PATCH] iio: cdc: ad7150: fix OF matching and publish module aliases

The OF match entries use positional initializers, which initialize the
name field rather than compatible. Consequently the advertised AD7150,
AD7151 and AD7156 compatible strings do not describe OF compatible
matches. The table is also not exported for module alias generation.

Use designated compatible initializers and publish the OF table. Keep
the existing I2C ID table and its device-variant selection unchanged.

The issue was found by our static-analysis tool.

Fixes: 89f2d5b080bc ("staging:iio:cdc:ad7150: Add of_match_table")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index 2f35c6d2f9ce..b36ac4e2dae8 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -636,11 +636,13 @@ static const struct i2c_device_id ad7150_id[] = {
 MODULE_DEVICE_TABLE(i2c, ad7150_id);
 
 static const struct of_device_id ad7150_of_match[] = {
-	{ "adi,ad7150" },
-	{ "adi,ad7151" },
-	{ "adi,ad7156" },
+	{ .compatible = "adi,ad7150" },
+	{ .compatible = "adi,ad7151" },
+	{ .compatible = "adi,ad7156" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, ad7150_of_match);
+
 static struct i2c_driver ad7150_driver = {
 	.driver = {
 		.name = "ad7150",

