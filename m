Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EF1488747
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101011; cv=none; b=W4Bczr6fMkEZe4XOOJiQ8bn4gH9kHty8JuzAZN32pFF3lZjkPc3KD+YUyftcrxMuFv/5bcU0OTXangLIhwLQYYIiiJAu9Qdzfssin3/ITZBBu28MnBXI9qVR2IgZ3xru3KkZG/bitYdLNfpj4pD8+XJ9tanXUqKxmDpDqa9EpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101011; c=relaxed/simple;
	bh=7o+xQTati0WzfD3PV7C5CB34jTaauNMD3iGtt4c+Oac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONk3BFyZr60fVNlcGvMHs7AtjC+gVX15yixTiiKlc/J1fyBz5sOSpGZ77jvKnR+EBNN39YQOzRVqqr5QhSlRRL0VuHpGdbdMsF6HFqLBgBYFahmdP7CPC9PdCibbYASxloaqkRvt1tvcr8yUxiJsYNjGVN44lNGkq56UHZ+hHos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/gU4n4r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/gU4n4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6676F1F00898;
	Tue, 22 Sep 2026 18:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101010;
	bh=Og0bsNk51VxcOusHSBhNpF9GQ0Y99zGeEv4k7FfWXvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E/gU4n4rlRJthHjuWQ6Pp7/HJovTCoe5wPnBDS0pJPQucwiOIcKWAKUqYiPhZGCro
	 G4Jh6gRbH0u5JXrQ81OnLlmJfVjE6szpkNEPfpPGLPcmzTPHCWqvLgVAGvcpm4c3r8
	 3g9inczauhfjvkODYH2CwCbM4UmHpAeLmdfGStiYrBfpyE1u2z+QBr686puuzVuIC5
	 Oip6BKVFtWq+VvxPHUuIVendJsTC0UI+0bDw0V7O2tEQrVVhbluL2TFC1tMf3ENT2f
	 vj9W4SuXfJ5UL5fiKMP5t4Fq1sT6nK4S24r2HhM6zbU296GYbvkyDfGXfEpwTCE3qg
	 3kgFyBhWwBg7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] devm-helpers: Add resource managed version of work init
Date: Tue, 22 Sep 2026 14:16:45 -0400
Message-ID: <20260922181647.3522363-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922181647.3522363-1-sashal@kernel.org>
References: <2026092257-ranger-harmonize-17aa@gregkh>
 <20260922181647.3522363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

[ Upstream commit 7a2c4cc537fa9f05fe90812e7d789b9faf7eb869 ]

A few drivers which need a work-queue must cancel work at driver detach.
Some of those implement remove() solely for this purpose. Help drivers to
avoid unnecessary remove and error-branch implementation by adding managed
verision of work initialization. This will also help drivers to avoid
mixing manual and devm based unwinding when other resources are handled by
devm.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/94ff4175e7f2ff134ed2fa7d6e7641005cc9784b.1623146580.git.matti.vaittinen@fi.rohmeurope.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 5d132990475f ("mmc: hsq: Fix use-after-free in retry work")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/devm-helpers.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
index f64e0c9f3763c..50557f04ce802 100644
--- a/include/linux/devm-helpers.h
+++ b/include/linux/devm-helpers.h
@@ -50,4 +50,29 @@ static inline int devm_delayed_work_autocancel(struct device *dev,
 	return devm_add_action(dev, devm_delayed_work_drop, w);
 }
 
+static inline void devm_work_drop(void *res)
+{
+	cancel_work_sync(res);
+}
+
+/**
+ * devm_work_autocancel - Resource-managed work allocation
+ * @dev:	Device which lifetime work is bound to
+ * @w:		Work to be added (and automatically cancelled)
+ * @worker:	Worker function
+ *
+ * Initialize work which is automatically cancelled when driver is detached.
+ * A few drivers need to queue work which must be cancelled before driver
+ * is detached to avoid accessing removed resources.
+ * devm_work_autocancel() can be used to omit the explicit
+ * cancelleation when driver is detached.
+ */
+static inline int devm_work_autocancel(struct device *dev,
+				       struct work_struct *w,
+				       work_func_t worker)
+{
+	INIT_WORK(w, worker);
+	return devm_add_action(dev, devm_work_drop, w);
+}
+
 #endif
-- 
2.53.0

