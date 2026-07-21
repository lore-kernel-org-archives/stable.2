Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7813CB2D4
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625285; cv=none; b=Sa8Rh+Xi9Vs+TK0MNuh9i820kElc/CSGv99FCPgBGIq9wg+swa7+G63ErSaAR00OeJj7PpR0/SdmRHoasZatf/I3LlH6wPV9k29R7NL34eYVTGODvv2Mdkgdi0jE576EeAwoSXKQ5VDYY3ijsndAiu6mFinbOYZzIfwqa7ywuG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625285; c=relaxed/simple;
	bh=fKh9HoTRIvjKFUfoIO7PeiVx0EnJrmIUEmKPoJ0S9BI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o0HjCLaPU2Te3o35hNGXyEIj+d1eU6THNNaMvdK7L9AOZItm6jaP1FvQz2OmbHrPla46Mr5Fiy3mNHCO5IwgYHV3kN4T1xw/h0Htd2angeVT/h87hdVhn9Dko4vmmRJlu6CVUNPdXNMWwq4/+1FhXD2YknUXYxHkX7jlLcnXsL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jys1/kkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jys1/kkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2021F000E9;
	Tue, 21 Jul 2026 09:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625282;
	bh=k0P+Ku8IF+gYevobjOyDG/ivVbuB8ovj1yWlo7pxCS4=;
	h=Subject:To:Cc:From:Date;
	b=Jys1/kkI1Qvlc+HDCOpV292puOPa+3FwrVrLDEPuPMk+Ea39aH8yNZR3Cf0+MFZqk
	 1FOth0BYKagxM6SliADOLC2Msn9vHpwvioiNBCKVWnVJCwBBZG45UuymmTKx8i+Gxg
	 Y297XdfZ4jmYdjG4X+4ltgQhDi2Wz0vkxVmALfIA=
Subject: FAILED: patch "[PATCH] dibs: loopback: validate offset and size in move_data()" failed to apply to 6.12-stable tree
To: dust.li@linux.alibaba.com,baul.lee@xbow.com,federico.kirschbaum@xbow.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:14:30 +0200
Message-ID: <2026072130-tadpole-coauthor-d48e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 78237e3c0720fcc6eb9b87e90fd70f63eeca886f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072130-tadpole-coauthor-d48e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 78237e3c0720fcc6eb9b87e90fd70f63eeca886f Mon Sep 17 00:00:00 2001
From: Dust Li <dust.li@linux.alibaba.com>
Date: Tue, 7 Jul 2026 15:43:18 +0800
Subject: [PATCH] dibs: loopback: validate offset and size in move_data()

The loopback move_data() performs a memcpy into the registered DMB
without checking whether offset + size exceeds the DMB length.  Unlike
real ISM hardware, which enforces memory region bounds natively, the
software loopback has no such protection.

A peer-supplied out-of-bounds offset or oversized write would result in
an OOB write past the allocated kernel buffer.  Add an explicit bounds
check before the memcpy to reject such requests with -EINVAL.

Fixes: f7a22071dbf3 ("net/smc: implement DMB-related operations of loopback-ism")
Cc: stable@vger.kernel.org
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Link: https://patch.msgid.link/20260707074318.1448662-1-dust.li@linux.alibaba.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
index ec3b48cb0e87..0f2e09311152 100644
--- a/drivers/dibs/dibs_loopback.c
+++ b/drivers/dibs/dibs_loopback.c
@@ -254,6 +254,11 @@ static int dibs_lo_move_data(struct dibs_dev *dibs, u64 dmb_tok,
 		read_unlock_bh(&ldev->dmb_ht_lock);
 		return -EINVAL;
 	}
+	if ((u64)offset + size > rmb_node->len) {
+		read_unlock_bh(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+
 	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
 	sba_idx = rmb_node->sba_idx;
 	read_unlock_bh(&ldev->dmb_ht_lock);

