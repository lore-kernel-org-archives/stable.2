Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12ABA34
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033404; cv=none; b=fUSPv1/x96my8Eep4/HIiOUI1fpXPbcsY01PcniZaMVFbe+ZLb7+1iLksgkUOd7lUbkkZF6IsKVLPUQyqFp9DiDIaQZbrMsJndrOA/qERHbL8zl6GboCybD+DYontBiKUTTQ4tmmYdl+YjzxtL+bVlMxqgEoZ+Jgh/mJ1d+DhHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033404; c=relaxed/simple;
	bh=Gwdtwig6eoPLr8552E4SQmYvHu0VwazPfugjBq/2mKw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pY9aseExes9J6XCkSaYsjHosHsNrzEF4tx4+jhV74c8z/lAMwWXXHG3QwdocKRsumdWo3p0VcEqQf8abuQU4bOs8U7R9gW4tcLasiFwGNtE7Djor4TPvy7nUagLJuAr7TfUh2oD95YpUZfwSoct6TZdrV7WQiRJTycaSX+nN5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nWpRtn1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nWpRtn1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8104A1F0089B;
	Sat,  3 Oct 2026 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033403;
	bh=+tuBLCp0Te04rbw+SyMy4Aib+1eIbjeccuKZ9QppSBA=;
	h=Subject:To:Cc:From:Date;
	b=nWpRtn1ugdRzX9XXcBP9IyoZTYEKSSoP9QRpA7F5x5qkKecNPRtpjnSqrjH5EXhuQ
	 +wJKBNpQe4TFggcgZv88zoJJ0Juhbl9ZsAC5Pqu7X6uSSI2sMkS9K5F0/v6DEdWQ/i
	 e3kZ81TsNAt6M50AGcr+mC/+6ivQx0MjeMpR3SSw=
Subject: FAILED: patch "[PATCH] of/overlay: only treat a positive changeset id as registered" failed to apply to 5.10-stable tree
To: abdurrahman@nexthop.ai,geert+renesas@glider.be,geert@linux-m68k.org,robh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:16:40 +0200
Message-ID: <2026100340-feminine-versus-f579@gregkh>
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
git cherry-pick -x 44081d708b5b885487bac792db78324b7b4c267d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100340-feminine-versus-f579@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 44081d708b5b885487bac792db78324b7b4c267d Mon Sep 17 00:00:00 2001
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 31 Aug 2026 18:29:23 -0700
Subject: [PATCH] of/overlay: only treat a positive changeset id as registered

of_overlay_fdt_apply() stores the idr_alloc() return value in
ovcs->id before checking it. On failure the stored id is negative,
free_overlay_changeset()'s "if (ovcs->id)" check passes, idr_remove()
is called with a negative id and list_del() runs on ovcs->ovcs_list,
which is not initialized until after the id allocation. An allocation
failure at that point dereferences NULL.

Make free_overlay_changeset() treat only a strict-positive id as
registered. The rest of the function already copes with a
partially-initialized ovcs, so the error path stays a plain
goto err_free_ovcs.

Fixes: 61b4de4e0b38 ("of: overlay: minor restructuring")
Cc: stable@vger.kernel.org
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Assisted-by: Claude:claude-fable-5 [Claude Code]
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://patch.msgid.link/20260831-nh-of-alias-overlay-v7-5-02754604805a@nexthop.ai
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 51df2ad26f83..0cc08567c300 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -864,7 +864,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 	if (ovcs->cset.entries.next)
 		of_changeset_destroy(&ovcs->cset);
 
-	if (ovcs->id) {
+	/* a failed idr_alloc() leaves its negative error in ovcs->id */
+	if (ovcs->id > 0) {
 		idr_remove(&ovcs_idr, ovcs->id);
 		list_del(&ovcs->ovcs_list);
 		ovcs->id = 0;

