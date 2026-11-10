Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273470;
	b=RhaXYAtAAqmpEPGtFII2kJryZbx1VXyHCoG95pkLE6BYqXE1mtz7nyd6I2V+E4xumc6w
	 Ap0yddWEL9Ipw4UJKPIsQA0ZRvcWwumWetARu7DzJFJv8zhbeWdPa/bR9XVuZVd0qWvlw
	 X0JIl2A8upEadAhcVeZhBVEroh4+2JvFxXmw8Ba+aVdwQopGrRkVhIM4O7kiUm3wm79UB
	 OvH2hUz9W36vfXR4yjgGvuhUvb08seoQ5qOtP2Jx+TGNbmtttz4xL3G0eP/x5vYRqYT7j
	 MLZZqXsQglBgIsFxD1uBZaLG34rTC7aupFuolHJYydRqB5XgKFdPsFEUUQScJXpl3DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273470;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CH6FgxhLL/CnX6qWaZNLz8RZlltV56a2FxOaDEQYev4=;
	b=hAa3ekFinryOIe8g9zcv1iibCyS5nn0N759I1QqTo+jjJ340CC6wsOyzE/0xPSXhCmh4
	 ebVTXQq/TeisJr0BMUfCQI/iJZiAIvqvcrHNSDblvem5SZ1D3+tXEENejYkkxh/ZnSdUP
	 Via5j4pUPf0FlxM2825HtwVYEIyOPk+Pq1wLUky6cYBpAQzkbJWtj7y+XE2GUnSqAZE0T
	 qTGyElEOyyxVaCkEg59eiyEDD6lzPVnm4xZEBiiFJFMLH6yihnii9AIUa3bEfh7DfhTlZ
	 V7E9QRYKRThsB3goxRsJa9zXluglOD9yQem5u/9KLDgjpPxDx2P8FR4xGaBTIbbldxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMEPRtde;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMEPRtde
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BC41F008A1;
	Tue, 10 Nov 2026 01:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273469;
	bh=CH6FgxhLL/CnX6qWaZNLz8RZlltV56a2FxOaDEQYev4=;
	h=From:To:Cc:Subject:Date;
	b=OMEPRtderNZSETxDC9MlcN66LKVk9ee+1dlzLN2lf03h9lbMJKS+V9ZsAEYai0V+R
	 4qGV/cT6z2Amz5cKzCpDnWcTrAbvcMN0s7pVELqrHPrVsIUfVBtkaCIZFngTaUrIcN
	 Eb6d3ZCJAGbIWpXbrFPi6PP5FAvaeaIqCvl/ilgfFt4yyMnWtxtLxiYqz8fjoOr5Al
	 CUYEDcSNQDMdOgggOoumZxUPkoN46EGYCtnax+eD7k0Udo0xG31yOdb+6wSYxdlQla
	 1MhbQrt6sKtX2Z1tfYgGRs0MmByF+cR2MAHjbfCPttdA2z+bXzkx0ZLWjdyCYigerQ
	 O3WfCYRNK0ljA==
From: Sasha Levin <sashal@kernel.org>
To: blum@kernel.org,
	prasannatsmkumar@gmail.com,
	mst@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwrng: virtio - prevent use-after-free after a failed restore" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:17:48 -0500
Message-ID: <20261109201748-failed-6.1-0f7bf47f5a0c@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0f7bf47f5a0cc26320aa4b14f4504d03a07f4b74
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201748-failed-6.1-0f7bf47f5a0c@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




