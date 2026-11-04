Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799518;
	b=gQ5DnOATpZMX18pxQU7xJA+X/nMOIJN9LMB8hhgXa/LOYOGmRf/z4OwTjFkftinPTk9u
	 I2E6nlZ6fe3ZioM/Qa02jhDbxlOL1/tI0MdiYUY1KZplx7Mcm/Vo4HqzF2aEGUDKmn37l
	 uiOi0DQnmhqiOLIFdR9vjT6vIo6B0LX4G4atWT657FgtdYgnUsv1H+0XfDyIpg+IoY/b0
	 Ee1fx6PPWyP33SZ3zxrw7eb6mInhnXg8dG0LdS8bDYtmPcSWebhdeKg3loz8t+AwvQRmM
	 5/JvraeaWREdMR17dx6hNHJ4z9Yo6kVk1jVuHUfJQuyH28f/LFXYxpgq7fjyBw7OWYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799518;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bEPhvItO4FruvGDZ7a/i/w7kNY1qJV9EWLblnL+FPOQ=;
	b=qKvIVdF9xMHr/7e9IUJWaAzRb3ZJCJfzkTFSidGX6/UJnDwkvIa0oAO/pu0PtyoWtMiG
	 wT9rY+jWKJY9/DaEG2SGVRU6qtayTiRsGvrrG7W9lKJP2JE9hevA1N670Ke+tACOaTv8i
	 SxXYjUhwtxNsB2YxWs3rGYvdDGatfBflz9VQTQWrJQyELCsXgQclOPLE8ozR+ymjA87vI
	 PUiZ5D9ZU0TriCrud2VawChTY2xeoa7AyENNgWOQ7C2pBGz6TOj42vNr7j/3uojhnfCeM
	 j12wb3wRqlLNj4mu1Da/GRC+PH21J206oD6ibbaq10ySO2zC17JjTHEPjWlj0lUha7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gphvtl9F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038BB606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gphvtl9F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1747E1F000C1;
	Wed,  4 Nov 2026 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799517;
	bh=bEPhvItO4FruvGDZ7a/i/w7kNY1qJV9EWLblnL+FPOQ=;
	h=Subject:To:Cc:From:Date;
	b=gphvtl9F8BFYhJ+XPG6D/7qneXUk8bzh7TSERteEyKiBYM8fVs3DVnf5fK/L4Gbq4
	 ncYiUGGWsU5KXhCOcR3IVlsyISrdIiijNQ009ZwI5UbgXwlueGN5vWsdSl7FT2v5mG
	 +LYvrN6nVqCBIF53v3C5gtoyKE9MM3Hi+H/Dwb1w=
Subject: FAILED: patch "[PATCH] iommufd: Fix event queue release use-after-free" failed to apply to 6.12-stable tree
To: nirmoyd@nvidia.com,jgg@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:38:35 +0100
Message-ID: <2026110435-fastball-maroon-2fc3@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 440ca8a4b69f40088065b9e05ef11373292a254e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110435-fastball-maroon-2fc3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 440ca8a4b69f40088065b9e05ef11373292a254e Mon Sep 17 00:00:00 2001
From: Nirmoy Das <nirmoyd@nvidia.com>
Date: Wed, 14 Oct 2026 06:36:32 -0700
Subject: [PATCH] iommufd: Fix event queue release use-after-free

iommufd_eventq_fops_release() drops the file's users reference before
reading eventq->ictx. Once that reference is dropped, IOMMU_DESTROY in
another thread can remove and free the event queue, so the later load
accesses freed memory.

Read ictx while the users reference still pins the event queue, then
drop the reference and put the saved context. The context reference
taken by iommufd_eventq_init() keeps ictx valid until the put. Fault and
vEVENTQ file descriptors share this release path.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Cc: stable@vger.kernel.org
Assisted-by: LLM, Specula
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
Link: https://patch.msgid.link/20261014133632.3440297-1-nirmoyd@nvidia.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 747dd5155121..b8a54454dd17 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -396,9 +396,11 @@ static __poll_t iommufd_eventq_fops_poll(struct file *filep,
 static int iommufd_eventq_fops_release(struct inode *inode, struct file *filep)
 {
 	struct iommufd_eventq *eventq = filep->private_data;
+	/* eventq may be freed once the users reference is dropped. */
+	struct iommufd_ctx *ictx = eventq->ictx;
 
 	refcount_dec(&eventq->obj.users);
-	iommufd_ctx_put(eventq->ictx);
+	iommufd_ctx_put(ictx);
 	return 0;
 }
 

