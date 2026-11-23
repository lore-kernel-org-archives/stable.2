Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454558;
	b=XFrxwfFe6jFtIBXRbMTN+HJEon1qWw4rIfN2IiyPm+cbG9squ0q3ziG6vB5f9ipCdXlF
	 ms9FMoID9wCxsuUeyuUDYvd4tOvItjujmRkagwgRHUEC/UpkF4euaxgO2Ae7G81z772Kc
	 mw68nWgpbwACV/1OOt782XsNGgl8C4b0wpygcwn15iJJN92+lufGXwhL3NFgUu12WyX3Q
	 F8OwrVJBTBGu6N/97r5KRwGEDT4+Asa5mt7ff7KY89VyUjVOAba4uO83uKSqy823Ta2Ig
	 vPjIO1aytdCe15A3NOgXG5qNXx2DZR6SnsPDnZQlKMycaf2rQs1YhPUOu4DIFi0DxlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454558;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VfHO/K1864+rTaeCJNsLRlFUOx+CYIsmLqTMx2DdQDc=;
	b=qlcNADPxRXNfbOwdPvdaehxe1HKJYDK0wBhN7pSZzZoGy0hllvTWLfz1BYBhNlC16lUO
	 Ne18bYkPMAntQ4Q120wwmIe15DV1Z2PO4gb1RW6kyPUNN4+gbKAY1wM/AAES6xWjY/OqP
	 LRuC1jc+5B+PVWEem6OKOSPezvH+xheK8dUd8h3raKPt//qA48c0Or5CnGb0BJmmJHnFQ
	 /du5m7sBslhU4hNTEkaSd4ilzpBEOBnHcnYu/qeq+Iv/dnc5bUgdaeLr+730wkuH65q5q
	 LUcwomK4EuuQsHjlWlga/Z2wQvr3aZ6t8PyE653e/PghPub9e4+M3sIWA4/UK9Y+AgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSb+hdEY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4D606A338;
	Mon, 23 Nov 2026 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSb+hdEY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024951F0156E;
	Mon, 23 Nov 2026 17:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454558;
	bh=VfHO/K1864+rTaeCJNsLRlFUOx+CYIsmLqTMx2DdQDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FSb+hdEY0XoXOZmpqBTuf8iSRClVRXDA9cKrC4vlmBVhd7jmyRzVu+6Hggjn2owr8
	 G6SH3sPZttJVsYlE9KMSTja0xpguw3fDArnDJQieLbTN5ZjyKvfsC/mVUsjLxreqWZ
	 mvrR2b344hrLu4lJ2iKyD2KvzKZ+wIoq+FpCPfpldukqy8LPlrc5GNsN6Jxh40G1TN
	 Pv5+s5Rhm3I45NFs5+9lU9dNZpytrWYP/KDwyr94pzythmoPKjpX0sn4W4bQooO648
	 NWMrn/+Rb1KvcATLGU4PUG5Z2hpXJfH0UwqTubicsJkPGkBaNhLc1RCXMpvWMNhTot
	 SBo0+tgk0fqnQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Uday Khare <udaykhare77@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/10] remoteproc: qcom: Clear glink->node on allocation failure
Date: Mon, 23 Nov 2026 17:20:51 +0000
Message-ID: <20261123172140.3547896-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261123172140.3547896-1-lee@kernel.org>
References: <20261123172140.3547896-1-lee@kernel.org>
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

When kstrdup_const() fails in qcom_add_glink_subdev(), the error path
drops the device-node reference via of_node_put(glink->node) and returns
before registering the GLINK subdevice, leaving glink->node non-NULL.
During subsequent teardown, qcom_remove_glink_subdev() checks
glink->node, calls rproc_remove_subdev() on an uninitialised list node
resulting in a NULL pointer dereference, and drops the device-node
reference a second time.

Reset glink->node to NULL when releasing the node reference so teardown
leaves an unregistered subdevice untouched.

Fixes: 44f4911ab8e6 ("remoteproc: qcom: Fix glink->node reference leak in qcom_add_glink_subdev")
Closes: https://sashiko.dev/#/bug/linux-eb8cc93d-8136-4bff-a5e7-3698dbe185ae
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/remoteproc/qcom_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 5294e327f158..c53190f0c537 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -255,6 +255,7 @@ void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink,
 	glink->ssr_name = kstrdup_const(ssr_name, GFP_KERNEL);
 	if (!glink->ssr_name) {
 		of_node_put(glink->node);
+		glink->node = NULL;
 		return;
 	}
 
@@ -280,6 +281,7 @@ void qcom_remove_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glin
 	rproc_remove_subdev(rproc, &glink->subdev);
 	kfree_const(glink->ssr_name);
 	of_node_put(glink->node);
+	glink->node = NULL;
 }
 EXPORT_SYMBOL_GPL(qcom_remove_glink_subdev);
 
-- 
2.56.1.750.gf70dc682cf-goog

