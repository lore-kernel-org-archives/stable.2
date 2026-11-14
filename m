Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633159;
	b=qWALw7r6eRAXYFBDY4oRo0Ni24AzZOIrQ52mYtmg6VVxJklBcx0RqXFP1Uda2pUcAI4e
	 Obt0ZSI8CFjZ0CXz2KIPndSt4UtnF953u27LSRIysdxmVxMDMxPUtCj3Tf1kQ+DmESh+4
	 k1JBirmOntz4BWsVW8q1kBILhZJXkBArPq3QSnaEFGAV/UMcC966V/ZqOIkNj1LwluKrz
	 dbL0p45zKWONxeQN+kggI+l/bT3RhQMVpQAwUGIBnCLnlJRU2z2YFDE90xx2BHKRUnjFp
	 bmhpI3YJw63T9ZaLw6pxA6teiTBH2nfdy69RU1FmZy10uY66a1K5eqn5p2bHnBGtSFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633159;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VPvgsVjJBvQZHd1Dpf5O6iMHcD5W3kdhrUaJtUSMJKM=;
	b=fr83m40iZyPN1VmaukRrvIK+p09JJiWD3/8kzv70m4q50GIG83tp66RrolTrDkpILD3O
	 XB70HCitbF6LoHTffZX4hQFCJI6GW7rtTDMLI27qMj1GZPAOUOr4bDrMFZDWT702USZA/
	 ypoCgn80ZuLLyQc2X0NQYWMmtwMa90JI37uTCy+f8R0/RjSze+a1Xv3yA00CaD1y2d4/w
	 RiB9FAi/7kiPsPbunEYIYA8J6CinUBoAeGAbpq3IKCynY/tudZbk5lyd3fuM5vFJaxTOL
	 U+htON7N4nivkciNJZvKoSNaCmb51bzDeWWixx9Aa8RcLWk5AWWN9emGgXO84NdVBGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ML+kppzn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C3606A332
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ML+kppzn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EEA1F000C4;
	Sat, 14 Nov 2026 05:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633159;
	bh=VPvgsVjJBvQZHd1Dpf5O6iMHcD5W3kdhrUaJtUSMJKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ML+kppznB2svKwIslF+lKUrogpvLyPbFVDdAUYLJdfNaj9V220PmzMY+0JluM1ant
	 ZD6Zh1EMw4WGTmV7SeFfc32e7ltRTeCNgqmS3XIypzP94ltcvaBIPpOK5qQZRUY4+w
	 AtSK+Nj0UB+QVCyNSV1gN5U3FMsmZSmwLoCwgX11L1pMKY4TH5EYoF59Yn440SSabR
	 t12XpmAyLKfHxssFZ/Bpu1qcSbEHfwg+zjIbIsQ35Gw53C++uIGseMGrWgXXtFMEmz
	 DdiNiZk68LRG0gTUsZohVgyIqHHr9WetEUckG8pegqSZJXfpwN44ZnIiZMY3gCwcc9
	 9M+EiyP2kYLhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <blum@kernel.org>,
	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] hwrng: virtio - prevent use-after-free after a failed restore
Date: Sat, 14 Nov 2026 00:12:37 -0500
Message-ID: <20261114051224.3056271-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202722-failed-5.10-0f7bf47f5a0c@kernel.org>
References: <20261109202722-failed-5.10-0f7bf47f5a0c@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <blum@kernel.org>

[ Upstream commit 0f7bf47f5a0cc26320aa4b14f4504d03a07f4b74 ]

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
[ sashal: replaced virtio_reset_device(vdev) with vdev->config->reset(vdev) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/virtio-rng.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index f6c0de82c22bc..72c99fa35e78d 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -186,6 +186,7 @@ static int probe_common(struct virtio_device *vdev)
 err_find:
 	ida_simple_remove(&rng_index_ida, index);
 err_ida:
+	vdev->priv = NULL;
 	kfree(vi);
 	return err;
 }
@@ -194,6 +195,11 @@ static void remove_common(struct virtio_device *vdev)
 {
 	struct virtrng_info *vi = vdev->priv;
 
+	if (!vi) {
+		vdev->config->reset(vdev);
+		return;
+	}
+
 	vi->hwrng_removed = true;
 	vi->data_avail = 0;
 	vi->data_idx = 0;
@@ -203,6 +209,7 @@ static void remove_common(struct virtio_device *vdev)
 		hwrng_unregister(&vi->hwrng);
 	vdev->config->del_vqs(vdev);
 	ida_simple_remove(&rng_index_ida, vi->index);
+	vdev->priv = NULL;
 	kfree(vi);
 }
 
-- 
2.53.0

