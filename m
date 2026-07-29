Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3B48874C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331085; cv=none; b=GRB7RqgiE3OWIizcs069AlvXLiOuXluIcVdc67q54I6ache6tirdGAVG4MuNm74rt6taXgi836zuHne+A5UdhkeAX18NL2u7pS7xmW3Zh8yb34w0kPNKISGbyGTS0pXBr6tB/e+LB1i+X7dv7oH+FH6WbV8u52XlVHb5jTAGFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331085; c=relaxed/simple;
	bh=+4hhC8udPNSgcjQEzqvFFueV4thN2T3fuZC0bqhwZk4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WNjpUyPEtUt9AogPV5AYwpPKObfEY+lebxE8qGYv03vwtT6SmYOLPyqvuoj5G8X55Jjuq+VM21qmlg+K5w62yxhPVmyLh19we4/8kvYltwsFqBkTgIet/WJTm0v1Jk4Ox3tKL4zakFx8vxSL+DNY/Qf5p6U0TkbkmawInP/8AWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hhB4/RBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hhB4/RBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA3D1F000E9;
	Wed, 29 Jul 2026 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331083;
	bh=Oy37FkzPBxGcy6eotAiceX7Iv6T/jcaQsER1VFO643s=;
	h=Subject:To:Cc:From:Date;
	b=hhB4/RBLmdAu6E/ldH2rpQLetrRgf30Ca0+Divru1WFQIEXLR5tMKv6v2kB51YXBk
	 d/W+v1yQaavC3jjV+jeOOCiTRZ0ugLP1VXMi3pybg2jukQKm6VAgUrzl21eonA7q4v
	 rJq82gI5inpeUpipSuD359Y6SpBlU+kH1kAlCqGs=
Subject: FAILED: patch "[PATCH] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752" failed to apply to 6.6-stable tree
To: zaq14760@gmail.com,arend.vanspriel@broadcom.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:14:49 +0200
Message-ID: <2026072949-theorize-monogamy-e1ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 29ab31f3f27157648f2f7e6d5e1fd9792fdf0614
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072949-theorize-monogamy-e1ff@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29ab31f3f27157648f2f7e6d5e1fd9792fdf0614 Mon Sep 17 00:00:00 2001
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Wed, 15 Jul 2026 14:49:38 +0800
Subject: [PATCH] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752

The BCM43752 is not reliable with the default 512-byte SDIO function 2
block size: on an i.MX8MP board with an AMPAK AP6275S module at
SDR104 / 200 MHz, an iperf TX stress test kills WLAN within seconds:

  mmc_submit_one: CMD53 sg block write failed -84
  brcmf_sdio_dpc: failed backplane access over SDIO, halting operation

Commit d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
set up the 43752 like the 4373 for the F2 watermark but missed the F2
block size, which the 4373 limits to 256 bytes. The vendor driver
(bcmdhd) also programs a 256-byte F2 block size for this chip and runs
the same hardware without errors.

Group the 43752 with the 4373, matching the F2 watermark handling.
With this change a 10-minute bidirectional iperf3 soak completes with
zero SDIO errors at ~270 Mbit/s in each direction.

Backporting note: kernels before v6.18 name this id
SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, so on those trees the case
label added by this patch must be adjusted to that name. Cherry-picking
the rename commit 74e2ef72bd4b ("wifi: brcmfmac: fix 43752 SDIO FWVID
incorrectly labelled as Cypress (CYW)") first is not a clean
alternative: on trees before v6.17 its context collides with the 43751
additions, and trees before v6.2 lack the FWVID framework it touches.

Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
Cc: stable@vger.kernel.org # see patch description, needs adjustments for <= 6.17
Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260715-b43752-f2-blksz-v2-1-f9be49856050@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index ec487c6f2e38..869c4872d399 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -911,6 +911,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 		return ret;
 	}
 	switch (sdiodev->func2->device) {
+	case SDIO_DEVICE_ID_BROADCOM_43752:
 	case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
 		f2_blksz = SDIO_4373_FUNC2_BLOCKSIZE;
 		break;

