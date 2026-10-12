Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976853ED132
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804762; cv=none; b=lIXw65bKxsO53yvJTUb36EOybYMpUzeIhAyHA/F6iMdPbB8OulCuRmzNwXC43qk/BB4L3V8X0V96NETFKvsv5yOIv7CDSjUjzYgbUoTRLwYV0Hc0xcBLgKXe+G/2sAA/pwEbilKYV2+nqCalyurjVCIEYTmQLYmkbVHwEvyShJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804762; c=relaxed/simple;
	bh=vZWKAEs7iT8pZRQCrlf0uHjIQHvdO/8ArXwPMsT6ihQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jcQD5Za4flYFeQPgUgj7yqk6jL7yY8929tf2OxNthlKUyw2ymHedjy0pS4GME9AHsrmb9OOPuS3ufwhx8nTv5uVLlOvcEMp+Lq6ObZz0Rw7zrcelRqFrOuNH+TakOMeg9KWfGXx6ePZQVjko8vOgFEOqPwY8Jbx6qgqJHIwDyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AtaCLVas; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AtaCLVas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917B11F0089B;
	Mon, 12 Oct 2026 11:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791804761;
	bh=HKH2+CniKGfwPuV357DqvqEmYBza10jEWn7PfTzFApQ=;
	h=Subject:To:Cc:From:Date;
	b=AtaCLVas7hhU33tmupAdnwRDM43BfZupkOMm7XMh8SCDVD5yFSm4w7Cj+JVp0rp5E
	 ORxdWNK2MY9j3oDSL77FQAqH+wItm3mfK3efQ2cZ+onTl4mPCkAI526q3iFmcDeizi
	 iNsyd4nIOlLhJprzLb4/jMxpSUBX43YQhs4onpWY=
Subject: FAILED: patch "[PATCH] ALSA: hda/tas2781: Accept V1 calibration data without CRC" failed to apply to 6.6-stable tree
To: med.jebabli@gmail.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 13:32:38 +0200
Message-ID: <2026101238-chrome-recount-a048@gregkh>
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
git cherry-pick -x 408249089c48df1a4d23f60b831be3f3c311e6d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101238-chrome-recount-a048@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 408249089c48df1a4d23f60b831be3f3c311e6d1 Mon Sep 17 00:00:00 2001
From: Mohamed Yassine Jebabli <med.jebabli@gmail.com>
Date: Thu, 1 Oct 2026 12:24:42 +0200
Subject: [PATCH] ALSA: hda/tas2781: Accept V1 calibration data without CRC

Some Lenovo BIOSes (e.g. Legion Pro 7 16IRX9H, SSID 17aa:38cd) store
valid V1 calibration data in the CALI_DATA EFI variable but leave the
TimeStamp and CRC fields zeroed. The driver rejects such data, so the
amplifiers always run with default parameters on these machines.

The rejection was silent until
commit 4fe238513407 ("ALSA: hda/tas2781: Move and unified the
calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
turned it into "V1 CRC error".

The stored values are consistent (R0 = 3.82/3.83 ohm, 1/R0 matching
within 1e-4), so accept V1 data when both TimeStamp and CRC are zero
and the first device entry is non-zero, and emit a warning.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Yassine Jebabli <med.jebabli@gmail.com>
Link: https://patch.msgid.link/20261001-tas2781-v1-nocrc-v1-1-ff0c1032ce76@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda.c b/sound/hda/codecs/side-codecs/tas2781_hda.c
index b22f93424c62..e0da299df780 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda.c
@@ -139,9 +139,21 @@ static void tas2781_apply_calib(struct tasdevice_priv *p)
 		 */
 		crc = crc32(~0, data, 84) ^ ~0;
 		if (crc != tmp_val[21]) {
-			cali_data->total_sz = 0;
-			dev_err(p->dev, "%s: V1 CRC error\n", __func__);
-			return;
+			/*
+			 * Some Lenovo BIOSes (e.g. Legion Pro 7 16IRX9H,
+			 * SSID 17aa:38cd) store valid V1 calibration data
+			 * but leave TimeStamp and CRC zeroed.
+			 */
+			if (!tmp_val[20] && !tmp_val[21] &&
+			    tmp_val[0] && tmp_val[1]) {
+				dev_warn(p->dev,
+					 "%s: V1 data without CRC, accepting\n",
+					 __func__);
+			} else {
+				cali_data->total_sz = 0;
+				dev_err(p->dev, "%s: V1 CRC error\n", __func__);
+				return;
+			}
 		}
 
 		for (j = p->ndev - 1; j >= 0; j--) {

