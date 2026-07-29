Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6992488D80
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331090; cv=none; b=aHWSAzuIvUvUj4ppvcUP/Q9UKyflbigGT+PufRNBvVyPMU3wgv0iOFtYdK+cms6Eu1mCzLM+EXNG+zah70TJobcBXh4nBbv+MVsgZ/UXPV6EdwcEw6BZu3841CScEYzTYx7P+dZz4hYQdyMVAsYxnmvaieLLMWpATmqC7TslJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331090; c=relaxed/simple;
	bh=OW0Lsqt39jXI6CQerK8W/VD7ZU6RxwRqcBZ6yV7fQk0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uzhOFgT8Lo2v5TNOclteFU46PPKX9u7AsjyHGxc1Ttu8WTa9F9WINWyrCUq8e4E3DWN1qQzggVjbaMWR2uXT9CMVYYckvPcWLzHZuDeVQ2ZmjAQ6RJk5+fhHcOp0oIkkYiil4yo87Pz4kPZ07d/pER0IyQzBOJ06MEPrM0ZoBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mrziSjd1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mrziSjd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C23A1F000E9;
	Wed, 29 Jul 2026 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331089;
	bh=nkXAOgASXmHZhAh0hhojI0sYgD9oPTV07N9OSjBQxqo=;
	h=Subject:To:Cc:From:Date;
	b=mrziSjd1tHHVR0YbaO8FRhJ9h8/om8AhjzEb9tRekT9pqLW6QAmTnYnJIcN0+L2qS
	 fjzBRe+Skj/sCKJ3SokMfQqQHKTdUzVU8IQvjIWjcE6R+aYGOMW8jCtYCKF1QVm9vT
	 QEyggIOzCHcbi7s9yEnewKuvQMc9qFMegiNFMdt0=
Subject: FAILED: patch "[PATCH] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752" failed to apply to 5.15-stable tree
To: zaq14760@gmail.com,arend.vanspriel@broadcom.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:14:50 +0200
Message-ID: <2026072950-reanalyze-suffrage-96ff@gregkh>
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
git cherry-pick -x 29ab31f3f27157648f2f7e6d5e1fd9792fdf0614
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072950-reanalyze-suffrage-96ff@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

