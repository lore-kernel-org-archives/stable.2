Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC673F9263
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805280; cv=none; b=YoMsyg8YrPeSpYMa9QrJDsVU+BKsI2BLXWBs4CnNBXBLmMzOTcRA1UsG9gSeXts9vhoL0KCqkfd9U6vKI+yHC16TtXWfzQ+R/7DZvhMfBVjZ76Hd6MKFl1O49XPjd/ctf7kd3s5UtWWuiM0PHV4OV2bhKtXh78Ta3v9JQxleZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805280; c=relaxed/simple;
	bh=hdWS0bL0ioWLW/qCP4JB0O8GT1aJo864XAANlHKr00A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VJi0XLPOIrFm1wIsbBWQGkv1tF7PMBJU/3rbPkL9NMGijRgPFgA68boPj7kbbBHnso3T7uRo6Zdx4fjC8aIaugNoygOloum3JU8mgF8AlFdGbr8BSyFZrDi3NGSXxXOJrbx54bQ9oJ52m2yMkTpFtsRi11T252SK1MP3qSgDKRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q3fCSu6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q3fCSu6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72211F0089B;
	Mon, 12 Oct 2026 11:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791805277;
	bh=SgPe3RqHUlz0BaTFVS8nXWtZoD6iMrhP+vAqf9BrHzE=;
	h=Subject:To:Cc:From:Date;
	b=q3fCSu6lJgWFDdp/j2k6eZ1eAa/XG1OmpufD+P08GdGnU2Y134rg/K8C+xdlm4OuS
	 GmClkHax6r24cMgums1r7ZRo7Ybzawi/d4JK+fv3yV5NoEX0Po1XLaX9M0UfsxP1Qi
	 YlzefdO0IBs9aFnF2+5+wswPs1TF4+R/QXPwSwnQ=
Subject: FAILED: patch "[PATCH] EDAC/amd64: Mask UMC chip select to the four implemented" failed to apply to 5.10-stable tree
To: Vishal.Badole@amd.com,bp@alien8.de,stable@vger.kernel.org,yazen.ghannam@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 13:41:12 +0200
Message-ID: <2026101212-ascension-flavorful-abed@gregkh>
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
git cherry-pick -x 7484bc43ba6b8e189b482db5b75e7842890a82b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101212-ascension-flavorful-abed@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7484bc43ba6b8e189b482db5b75e7842890a82b1 Mon Sep 17 00:00:00 2001
From: Vishal Badole <Vishal.Badole@amd.com>
Date: Fri, 2 Oct 2026 17:02:03 +0530
Subject: [PATCH] EDAC/amd64: Mask UMC chip select to the four implemented
 selects

For DRAM ECC errors, the chip select value can be found in the
MCA_SYND[ErrorInformation] field.

ErrorInformation[2:0] was first documented in Zen1. The 3 bit field
implied that up to 8 chip selects may be used.

However, all Zen-based systems have only ever had up to 4 chip selects.
So only bits [1:0] would contain a valid chip select value.

Future systems are redefining the field to ErrorInformation[1:0]. This
matches the existing 'up to 4 chip selects' implementations. And it
frees up the extra bit for other decoding.

Change the current chip select mask from 0x7 to 0x3 to prepare for the
decode change.

Fixes: 713ad54675fd ("EDAC, amd64: Define and register UMC error decode function")
Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20261002113204.3358815-2-Vishal.Badole@amd.com

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 475235c402e8..0c0d11c72925 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2796,13 +2796,13 @@ static inline void decode_bus_error(int node_id, struct mce *m)
  * the instance_id. For example, instance_id=0xYXXXXX where Y is the channel
  * number.
  *
- * For DRAM ECC errors, the Chip Select number is given in bits [2:0] of
+ * For DRAM ECC errors, the Chip Select number is given in bits [1:0] of
  * the MCA_SYND[ErrorInformation] field.
  */
 static void umc_get_err_info(struct mce *m, struct err_info *err)
 {
 	err->channel = (m->ipid & GENMASK(31, 0)) >> 20;
-	err->csrow = m->synd & 0x7;
+	err->csrow = m->synd & 0x3;
 }
 
 static void decode_umc_error(int node_id, struct mce *m)

