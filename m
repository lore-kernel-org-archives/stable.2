Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5540D59E
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201841; cv=none; b=cdJY5mFN5jCGVPpof6J1/+GeMNK7F77kk6k2LXIV1Wm9sfjQX/u7oYpANn8WZVUDNzh6pznM8k/hlMj+UOvr9yo/JSqbgNJ6fzuBcFsQ1frymL4Q59z0dWzTx84/txb4wICl3G78uPiRjciACXa2+iCRZqx4JspkVoIgKhMqtIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201841; c=relaxed/simple;
	bh=UoZASuMtdDxK67ecnxt7/LFiDvQ1eUUjrgGpAyvLi0Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hEmGg+sV74M7jW62BN27zKQORZEJTOS4Ydc0Fk+Tp0Bzk1pdX92l/75GfqAh2YyMlhYkxmRNR2CFyl8TmKZbqFzgp6YIh9J3ZpK+XluwkbGGj0PYfyL0RsShddJaczbgVezf6nR9S0z6dndp5aAEec/Q1ecu0GbCma+9v6PieB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=El3HwsH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="El3HwsH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319001F000E9;
	Thu, 16 Jul 2026 11:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784201838;
	bh=7ioEUsCmdB9ejEaYLYy6EzIpw+sajjaJ4Ma44w0ctoA=;
	h=Subject:To:Cc:From:Date;
	b=El3HwsH6IQNiXCEtYeWVenP1SDGDDR0PCJ5VN37Wfz0J3QQRoo9YIAAt2iOvADiyb
	 28om/KHD7GDsmVMzAm+H5QEFUZGFqgnQ1Ehf7iazi1JVRUSrbKbQIGGNrgJX2gv7ax
	 pBi6Dk+pFtPx5aIcuaB0qLZ5WFUkMOwQjHhifSKQ=
Subject: FAILED: patch "[PATCH] iommufd: Break the loop on failure in" failed to apply to 6.12-stable tree
To: nicolinc@nvidia.com,jgg@nvidia.com,kevin.tian@intel.com,praan@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:37:11 +0200
Message-ID: <2026071611-prong-distrust-2ab3@gregkh>
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
git cherry-pick -x 172fc8b19825a0f5884c38f2289188284e2d45ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071611-prong-distrust-2ab3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 172fc8b19825a0f5884c38f2289188284e2d45ee Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicolinc@nvidia.com>
Date: Mon, 1 Jun 2026 13:42:36 -0700
Subject: [PATCH] iommufd: Break the loop on failure in
 iommufd_fault_fops_read()

On a copy_to_user() failure inside the inner list_for_each_entry, only the
inner loop breaks; the outer while re-fetches the just-restored fault group
and retries the failing copy_to_user() forever, spinning the reader at 100%
CPU with fault->mutex held.

Check rc after the inner loop and break the outer while as well.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Link: https://patch.msgid.link/r/336a9b6e44fe66a24199d3be777c405c85c98622.1780343944.git.nicolinc@nvidia.com
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 613024ca8f1f..1c010e691f97 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -168,6 +168,8 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 			}
 			done += fault_size;
 		}
+		if (rc)
+			break;
 	}
 	mutex_unlock(&fault->mutex);
 

