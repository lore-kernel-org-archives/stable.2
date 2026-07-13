Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6202F42B746
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950298; cv=none; b=UpiHFOlMjC8eJfjIFlBvrVJ7z1EsNxUTmsNN2mHlQNDIQY5W3cRoFA9xgelppwKP54Bnbf9xiZBS96lvzxHyFU/xAnaI1fqWDVO/I4utR58vbzmyofSEY7uk0zyURc2oWvOncqLCyVoyKQoRRkzQPrZ1XBFcNu6s3WHWHRUggtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950298; c=relaxed/simple;
	bh=FR2Sxa6kIIeJr1mL4LmNIy/cyGB0x3f09WKR8D+91Gc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F3+N7UAHn3dNwzoZFe8MevWf2OgwE0n69nh+7hhrg6ns2ySvhVQIX1vdtGMPQiIPPaLPF/2PzAcETqAiQuUGsTXtPQjAMzKYQhDeGROBpnSb1SkCXbp3k8JA/AkyFdEgFS/C9Gp+fHjm9XsCsf6MCpBnmTIpImXYn75iVtdaw8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kwpl1/5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kwpl1/5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861D71F000E9;
	Mon, 13 Jul 2026 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783950297;
	bh=sYBPLO2O3cDlmoy6UwelYNXwHOBAJ7+7EjxKSpEKEqY=;
	h=Subject:To:Cc:From:Date;
	b=kwpl1/5aTCI98IrIPtjLLUhmyrPK60w5i48P4Wm3Bov6aHfSQELQNeni/O3kq4sQq
	 m9znbWlKInCLjSGKDdh481lHZlbTWklx406tadoOC+A4OOOMGw0bOxWqrAptph5eP1
	 Mid1Aj5RwVaQkFsIYefra7XIhBBjYS5JJQxsLVC4=
Subject: FAILED: patch "[PATCH] staging: media: atomisp: reduce load_primary_binaries() stack" failed to apply to 5.10-stable tree
To: arnd@arndb.de,andriy.shevchenko@intel.com,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:32:04 +0200
Message-ID: <2026071304-opulently-outburst-4960@gregkh>
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
git cherry-pick -x f4d51e55dd47ef467fbe37d8575e20eee41b092d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071304-opulently-outburst-4960@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4d51e55dd47ef467fbe37d8575e20eee41b092d Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 25 Mar 2026 13:59:43 +0100
Subject: [PATCH] staging: media: atomisp: reduce load_primary_binaries() stack
 usage

The load_primary_binaries() function is overly complex and has som large
variables on the stack, which can cause warnings depending on CONFIG_FRAME_WARN
setting:

drivers/staging/media/atomisp/pci/sh_css.c: In function 'load_primary_binaries':
drivers/staging/media/atomisp/pci/sh_css.c:5260:1: error: the frame size of 1560 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

Half of the stack usage is for the prim_descr[] array, but only one
member of the array is used at any given time.

Reduce the stack usage by turning the array into a single structure.

Fixes: a49d25364dfb ("staging/atomisp: Add support for the Intel IPU v2")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index c6838772553d..792379407828 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -5019,7 +5019,6 @@ static int load_primary_binaries(
 	struct ia_css_capture_settings *mycs;
 	unsigned int i;
 	bool need_extra_yuv_scaler = false;
-	struct ia_css_binary_descr prim_descr[MAX_NUM_PRIMARY_STAGES];
 
 	IA_CSS_ENTER_PRIVATE("");
 	assert(pipe);
@@ -5188,15 +5187,16 @@ static int load_primary_binaries(
 
 	/* Primary */
 	for (i = 0; i < mycs->num_primary_stage; i++) {
+		struct ia_css_binary_descr prim_descr;
 		struct ia_css_frame_info *local_vf_info = NULL;
 
 		if (pipe->enable_viewfinder[IA_CSS_PIPE_OUTPUT_STAGE_0] &&
 		    (i == mycs->num_primary_stage - 1))
 			local_vf_info = &vf_info;
-		ia_css_pipe_get_primary_binarydesc(pipe, &prim_descr[i],
+		ia_css_pipe_get_primary_binarydesc(pipe, &prim_descr,
 						   &prim_in_info, &prim_out_info,
 						   local_vf_info, i);
-		err = ia_css_binary_find(&prim_descr[i], &mycs->primary_binary[i]);
+		err = ia_css_binary_find(&prim_descr, &mycs->primary_binary[i]);
 		if (err) {
 			IA_CSS_LEAVE_ERR_PRIVATE(err);
 			return err;

