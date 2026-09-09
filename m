Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA036F916
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947232; cv=none; b=p9F9OCxkdwBjYNpnuACpZSo11u7wkVbIcl2AbR39V9Mf5B4RsYNQ3Zy/x8+aOUJ7vZMGUdB78WlQhGl8ipLx8gssTaoJe6v+fRW8ia8YUfmmJuyDMNfyfPd1U1dhzpDm+aVJd4P0yh5qk3aS9l1Jo4l2kYq3RXOW+V2lXv0wjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947232; c=relaxed/simple;
	bh=WzLQijr4L9mI8AJrISMKx/YDJar26fGcHoQ8r40u69g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PH0fgQ/KWRQLTD+ic2ZsvuAL9s8pVeZkkusVd4m2FTWzOUcrOABnRIYSweI44Gt6NMjKEpvjHSCjewAELPAEJr/krzCvOBxVIfgAJz3Gmyi40X1JsNhMO1a4UwtQHnd2llJzo2kBLfiolg97+oS3Pf9uxCKL8UK415DcqZOiLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v0T7Nyd+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v0T7Nyd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F4D1F00A3A;
	Wed,  9 Sep 2026 09:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947231;
	bh=9B8rGlnNLsjl2I1D+OBI8N93wuQhgtzUVqJu/tjIzoE=;
	h=Subject:To:Cc:From:Date;
	b=v0T7Nyd+SIu/y6Jkyb9ByXjD+Ydhf3vekz7Fqtg8fz7ICAyqHrgG9p5GpFXONwPMT
	 Ybi6mhfTPtNRBxDQvDORNId6cpgry5iMPJIhPwcVFvWdmdjuk7ASpll9FTTtvAtWtQ
	 HHj2JwpcVii+63yuU2fe5Zzg3Sw65oy7nV4sAW70=
Subject: FAILED: patch "[PATCH] nvme-fabrics: fix DHCHAP secret leak on parse failure" failed to apply to 6.1-stable tree
To: raoxu@uniontech.com,hch@lst.de,kbusch@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:43:16 +0200
Message-ID: <2026090916-resurface-ultra-bfce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x afdee49a1b88ed9bb44e2b30e855297c169bcc53
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090916-resurface-ultra-bfce@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From afdee49a1b88ed9bb44e2b30e855297c169bcc53 Mon Sep 17 00:00:00 2001
From: Xu Rao <raoxu@uniontech.com>
Date: Thu, 13 Aug 2026 16:31:07 +0800
Subject: [PATCH] nvme-fabrics: fix DHCHAP secret leak on parse failure

nvmf_parse_options() duplicates dhchap_secret and dhchap_ctrl_secret
with match_strdup() before validating the DHHC-1: representation.

If validation fails, the parser returns -EINVAL before the temporary
string in p is assigned to opts->dhchap_secret or
opts->dhchap_ctrl_secret. nvmf_create_ctrl() subsequently frees opts,
but nvmf_free_options() cannot release the unassigned temporary string.
Each rejected option therefore leaks one allocation.

This is easy to miss because valid secrets transfer ownership to opts
and are freed normally, while the malformed-secret path still returns
the expected -EINVAL to userspace.

With CONFIG_NVME_HOST_AUTH enabled, the leak is reachable before the
required-option checks and transport lookup. No NVMe-oF target or
working transport connection is required; for example, repeatedly
writing

	dhchap_secret=BAD

or

	dhchap_ctrl_secret=BAD

to /dev/nvme-fabrics deterministically takes the leaking parse path.

Free the temporary string before leaving both validation error paths.
Use kfree_sensitive() because the copied option may contain secret
material even when its representation is rejected, matching the
sensitive cleanup used for stored DHCHAP secrets.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index fd5abd04e080..59f823dfbbcc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1028,6 +1028,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
 				pr_err("Invalid DH-CHAP secret %s\n", p);
+				kfree_sensitive(p);
 				ret = -EINVAL;
 				goto out;
 			}
@@ -1042,6 +1043,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
 				pr_err("Invalid DH-CHAP secret %s\n", p);
+				kfree_sensitive(p);
 				ret = -EINVAL;
 				goto out;
 			}

