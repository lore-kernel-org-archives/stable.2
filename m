Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273770;
	b=zUfneZtRt9SmnAy2hCu7YBQ2It87vtOv89IX4Eshzdn17G0H64WeFW1SYxLGK+yb2XTY
	 44HR0Ncb9t5Kn+O7FkjCtSvS0KI6cFmfD4r7IoVrzihXaG+30xlWApHsWuALPoYnIEk87
	 J7njpzt8bTZInhwAW9F7yngmVfHOsH1pSms+20+czpP2KG/7iyAyjSbdKv2ZxCsMsUx2g
	 hKZhIkiqgIsLclr8EmAw2tEZ7kDYUoe6A8TkmyyIbKpAst+5V6OPw3ZP9HiRBaAqzqgjd
	 mITnR/G2xy4+UAAq0HNhSugr9Vh2dRkET9we0M/whqdfD58wIrRFomfVMpIoaX6GzOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273770;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2P9KBZgj2rFrhRTAih40+D5NmEE9HNLC5D8G7F3cpBw=;
	b=xJTHe/VUEfFSF52+bFK+ZeZ8as9P7rUeuBZIbexT65I/TXS0inR9bvgRJU5JRtdGBwXF
	 P8dbj0v20CPHWlTFfZ6E6Srt9gwaulzwslWo7J9N3kT4DKmRGTOlUClwbJi6sQviO8vdf
	 Dr7g4RAuiNgS3JOEvqb76cpYld/Xf/8EBgSbcvH7JsTgtDmUPgjApsMVxo+9KfgV5tDXG
	 ECkpJp3aQJjsI9rcF2thJdKs6ELPdIG7eCRJo+nOyyPNAulEzRPGwACEVXnOIRZ5RRKyH
	 ydS4QejZqsVOsv5Q6D1nVtHnVmpBh9xMzNL2qF/uTU8B0/o+QMYfA+UxZ4fuwbMoesg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9meNbtm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7725606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9meNbtm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324B61F008A1;
	Tue, 10 Nov 2026 01:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273769;
	bh=2P9KBZgj2rFrhRTAih40+D5NmEE9HNLC5D8G7F3cpBw=;
	h=From:To:Cc:Subject:Date;
	b=Z9meNbtmuThkS4+4N3kW7Y8rPNR37UuQs6s634AZu1thrvxTszZ8NZ1ieWpMvXygJ
	 B9OxN2b/njTG9oehw0QMORylz2lymsScy+zvwlY9kCxOyJreGce1QbBdkWqs9eFJDd
	 /98TKWGCFsizOXds8BLsehhCf/WdsUgnDmPLFvzQD9pAvAeXSSodlfmTeNUAtCD9i+
	 y9WY+f0s4d3CoFR++zdFws70FOflNUyN/XVrNR21tDtVHJJM6NwYMSREVgf94nBpb+
	 Iv9dJUTabl9UE0QTRbxc81qHRgGoUGAaKUcXx++RJ9UxR8VF9SKqKmS+OsHCEvTK5p
	 qI1OHnx5c+3mA==
From: Sasha Levin <sashal@kernel.org>
To: blum@kernel.org,
	prasannatsmkumar@gmail.com,
	mst@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwrng: virtio - prevent use-after-free after a failed restore" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:22:48 -0500
Message-ID: <20261109202248-failed-5.15-0f7bf47f5a0c@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0f7bf47f5a0cc26320aa4b14f4504d03a07f4b74
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202248-failed-5.15-0f7bf47f5a0c@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0f7bf47f5a0cc26320aa4b14f4504d03a07f4b74 Mon Sep 17 00:00:00 2001
From: Thorsten Blum <blum@kernel.org>
Date: Fri, 16 Oct 2026 12:36:40 +0200
Subject: [PATCH] hwrng: virtio - prevent use-after-free after a failed restore

remove_common() frees the driver data during freeze, but does not clear
vdev->priv, which points to freed memory. If probe_common() then fails
during restore, a later remove or freeze can dereference the dangling
pointer.

Clear vdev->priv on the probe_common() error cleanup path and before
freeing the driver data in remove_common(). Also reset the device and
return early from remove_common() if vdev->priv is already NULL for a
safe teardown after a failed restore.

Fixes: 08e53fbdb85c ("virtio-rng: support multiple virtio-rng devices")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <blum@kernel.org>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261016103640.4989-2-blum@kernel.org>
---
 drivers/char/hw_random/virtio-rng.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index f9982217247dd..45d87c0614a5e 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -190,6 +190,7 @@ static int probe_common(struct virtio_device *vdev)
 err_find:
 	ida_free(&rng_index_ida, index);
 err_ida:
+	vdev->priv = NULL;
 	kfree(vi);
 	return err;
 }
@@ -198,6 +199,11 @@ static void remove_common(struct virtio_device *vdev)
 {
 	struct virtrng_info *vi = vdev->priv;
 
+	if (!vi) {
+		virtio_reset_device(vdev);
+		return;
+	}
+
 	vi->hwrng_removed = true;
 	vi->data_avail = 0;
 	vi->data_idx = 0;
@@ -207,6 +213,7 @@ static void remove_common(struct virtio_device *vdev)
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 	ida_free(&rng_index_ida, vi->index);
+	vdev->priv = NULL;
 	kfree(vi);
 }
 
-- 
2.53.0




