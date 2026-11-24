Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533093;
	b=noUFOUKZ4V8L73KAjj6BhYI8fZSj9h7+Vp6Fen+LCMQRMZ2wxZN4GDu/Z+LBd7a7NBo1
	 szd5Dgu5QDZV4I6A/tIwt50UeeBKC8gmI4RiQm+Ffx5vBshXrjLlGZ/OV1scfMwDlIlD0
	 /FDNWN26oBuDX/gkpCxOpnxbSCO8GEsscQuzdTMMn1yzruxsTvh8UBIq+sqKvdUIWsRjU
	 mHgvKS8hQ+IXIFJez6//qkwx2O5lRksN4ef1zAJbDAiWWM9TOqByXLOJC8fTD893LGfk4
	 4UDoUZhbaOCz2n9HSG48rBcCD9TFEUlDOTyGiXlFOkYDGim7FzRDwoA7IdwiM6wUHmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533093;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xdLFDDyXWcibJZHGrGh+m6z0K1i2hrm9xA4ok8E5+es=;
	b=LjZxewdx3wUPuWjDN06rrR9fjz7EuDhaIuhzE4niweOmt9LujaIk2mxvURKcvW/M3tiz
	 cid6KBK7LNybN7Y55sLqo33tLsxNU3O/rJyjlKwW+0HH4Tan0nHAzfFcChn4byr6VDfyT
	 xnbsKxzgi4iAal+NAjjpgD6OWqTjkwhdU3ajnW9UArXKVQNh3ufvk1TXUGoFj/TtutwNS
	 gtaLXpVcnYYLBicX16Yw0KeZQXoBvuSXgv/N4j5I5LJWzXntLyJaWBCk8H/NQBrZnKZ/m
	 Cz3B7xdFa+CXdUK/tM0QZtElUMkAU6lJIaxMmQDU5wKJvaEd47qZX+nAg8yUYxZso2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jYdEf12X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9947606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jYdEf12X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCD01F000D2;
	Tue, 24 Nov 2026 15:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533092;
	bh=xdLFDDyXWcibJZHGrGh+m6z0K1i2hrm9xA4ok8E5+es=;
	h=Subject:To:Cc:From:Date;
	b=jYdEf12X88VCHXpbw7t1tCPZXeR/LRS0RaJ6RluvlzZFL0VmXY7hfxflTojXTXmO9
	 /dXhasD8D9EW98gFYjmFxoXK3lFEaoUooH6UyzGutW7NG8HBM+vnbFDmhRrK9z+wIg
	 98QD4BeoCSYFzc3hji5bLhBnXuEKN7mHydAl5iws=
Subject: FAILED: patch "[PATCH] mmc: sdhci-esdhc-imx: map unsupported driver type to Type B" failed to apply to 5.15-stable tree
To: ian.ray@gehealthcare.com,adrian.hunter@intel.com,haibo.chen@nxp.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:11:45 +0100
Message-ID: <2026112445-decent-yeast-d230@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x d35d93c2902592a84347a15deac4d67a323694c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112445-decent-yeast-d230@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d35d93c2902592a84347a15deac4d67a323694c9 Mon Sep 17 00:00:00 2001
From: Ian Ray <ian.ray@gehealthcare.com>
Date: Wed, 7 Oct 2026 10:03:12 +0300
Subject: [PATCH] mmc: sdhci-esdhc-imx: map unsupported driver type to Type B

Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
for fixed driver type"), the eMMC driver strength is passed directly to
mmc_set_driver_type(), which propagates the value through ios.drv_type
all the way to sdhci_set_ios().  For value 4, SDHCI correctly warns:

  mmc2: invalid driver type, default to driver type B

The host driver type has no effect on this controller: esdhc_writew_le()
never programs the driver-type field of SDHCI_HOST_CONTROL2.  Hook
set_ios() and force drv_type to the always-valid Type B, so that SDHCI
never sees an unsupported value.

Tested on i.MX8MP (usdhc3, eMMC in HS400) with
`fixed-emmc-driver-type = <4>`: the warning is gone and the HS_TIMING
register contains 0x43 as expected.

Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixed driver type")
Link: https://lore.kernel.org/all/20260926122908.866-1-ian.ray@gehealthcare.com/
Cc: stable@vger.kernel.org
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6ab59d3e346f..931e383748a9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1142,6 +1142,20 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 	}
 }
 
+static void sdhci_esdhc_imx_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	/*
+	 * This controller has no driver-type control: esdhc_writew_le()
+	 * discards the driver-type field when writing SDHCI_HOST_CONTROL2.
+	 * The programmed value is therefore irrelevant, but SDHCI rejects
+	 * non-SD values such as 4 (eMMC 40 ohm, from fixed-emmc-driver-type).
+	 * Force an always-valid Type B.
+	 */
+	ios->drv_type = MMC_SET_DRIVER_TYPE_B;
+
+	sdhci_set_ios(mmc, ios);
+}
+
 static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1952,6 +1966,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->max_timeout_count = 0xF;
 	}
 
+	/* No SDHCI driver type control */
+	host->mmc_host_ops.set_ios = sdhci_esdhc_imx_set_ios;
+
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;

