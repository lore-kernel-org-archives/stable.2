Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F122425B
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272660; cv=none; b=OW853++nAuNPxRF0uDXU/fp72F0yqys/s1Tqie5r46+Tw2xYhLuH4CPRcmRaJZgBQkni/EXkVtDs/W3QBVRWqLdAN5CONV8dpZ4pqmzc76+LS1gyYCWgULI+b7Nftd8k+EweVEkLPDaCk02Inss41i1Ihl797gwNMN+Z4kPsFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272660; c=relaxed/simple;
	bh=BZfvv6jZ34LXyc580speuQI4OfrnljCjkFTffZYOyu8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fZUuDhwMJP5IXtgY2xk609Q1jwK3eA7P8vTzLu12l8JqfHpKCnuX0mA5qbv+edjX+GAz4TZBvcgIGH/YQc6CMeKk+l0Cbrm0unysc3ix/Wz7iyv0iTK63Ci3CQXNgvP2RLdY4kxKf9fkrNRlLqbuqrMIx67wI62+zhfLsLUkapQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TCqlWQaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TCqlWQaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9751F000FF;
	Tue,  6 Oct 2026 07:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272659;
	bh=fHScu5id/4iqdoO+60YuDv58I1iFjEmwTTPVGxSyT+8=;
	h=Subject:To:Cc:From:Date;
	b=TCqlWQaBnr9SBqaN/CJ7MbyfT4FcCNS63umPw85WW7B4vAPw5o4GNRbbEpeM9Tajd
	 0FfhtsU18jucD+ZlwzeGcoMJHdks99u5c5iQmXJ9NKDuR1OwaWroZcHS5AchUt9mT4
	 ung6Iz2KWLaQ/ajvt6+WtKpDsI1esP2R7IIvQb5A=
Subject: FAILED: patch "[PATCH] iio: adc: aspeed: propagate reset deassert errors" failed to apply to 5.10-stable tree
To: pengpeng@iscas.ac.cn,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:44:01 +0200
Message-ID: <2026100601-tartly-curing-0008@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 95e4eb426b4bd666fa2f37886c0ddf74a0cc6167
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100601-tartly-curing-0008@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 95e4eb426b4bd666fa2f37886c0ddf74a0cc6167 Mon Sep 17 00:00:00 2001
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Sun, 30 Aug 2026 21:42:27 +0800
Subject: [PATCH] iio: adc: aspeed: propagate reset deassert errors

aspeed_adc_probe() continues to register ADC resources after deasserting
the shared reset, even if the reset controller reports a failure.

A failed deassertion leaves the hardware unavailable, so stop probing
before installing the cleanup action and enabling the ADC.

Fixes: edf7550a1f93 ("iio: adc: aspeed: Deassert reset in probe")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 6169ce28261e..452c30cf04f2 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -585,7 +585,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(data->rst),
 				     "invalid or missing reset controller device tree entry");
 
-	reset_control_deassert(data->rst);
+	ret = reset_control_deassert(data->rst);
+	if (ret)
+		return ret;
 
 	ret = devm_add_action_or_reset(dev, aspeed_adc_reset_assert, data->rst);
 	if (ret)

