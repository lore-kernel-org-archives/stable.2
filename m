Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050416;
	b=xs6IA+cqfuLqhIcH+PgEFkmgCzYVJytpeqf9PYelrysf8fOfWv7wsTE2wmb8oB0sautf
	 ZWngf/paN1J0MhCwTEQBkNSIFAwEmQ6Jp2rLvaM7gp91t6Boqaw5kJKR2dfKQssMbMIkn
	 c8VG+RLAeWPFSxG0ddW7i4eZO/hX6pW6a4DukiFxekCZ/z9as4kXTDTsi02/QiSqoR4US
	 qdEklGa+HH+pYekcGIr+ptcNZi4iIUtlz/gerg1uz1aATBWRaQzOb9E1o/FdwenKQ11Rd
	 s1FRIDnFCaGBpZNkkmj2/BMjw52RQZAwzx2vW+4Z1TE+D4jip5Qimaq2xi0OtqjUFhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050416;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5cq+x199Q7zss5f974peS1JfdI8iaQXMOg7BqwAmuFc=;
	b=ZlqDRnx6UNNayxZ/AiBmWUXEyONPCvOyHqGJqPU4sEz1vci4fwOrH0dAK4L2yn2T4Ksl
	 DNIKileDYvTEr0vKq4lLIk/S5atOM/SCeyqvXfT8snlJyQ26EKV9z2BaYqf9XKqfVHep/
	 CC1oHCCsfvfIgFSf7xiAj9pCwRYgMeKNbmAB9Ebip3TY3vSzGwy2dBS0K3SfWIjaijxGM
	 +uA0kgNkMOeXuooKf+skuaJYGzvUHxK37P9KVLikXxsn2I6Zx9OcvpXs3zdCyU10s/n6b
	 Fjh1WwNvE9qJxyJAQeY8empC0IXiMuYQ9yN9bnKTH0eFj5EMfjpyyZKZ7uNz1u8u+7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2EgFVMM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2EgFVMM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AB21F0089F;
	Sat,  7 Nov 2026 11:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050415;
	bh=5cq+x199Q7zss5f974peS1JfdI8iaQXMOg7BqwAmuFc=;
	h=From:To:Cc:Subject:Date;
	b=f2EgFVMMs0G3bzlUz0WHw+5wJV2uR7jd4JPyn1g9JjoDIAUTZp3cb1S1OnK3PZH2g
	 TJi1qhygk7FDdJnHYj5CpEKiv/+12+Bv3epg9SPpZYy+D1V2QBxdSW0VWPoO0i/KMq
	 QE9aAzvMjdBWv9KnngbC36IbF/UatKEYfqTrf6/DSaUcH3NYCLwDECVeIB7j0aiMjJ
	 yMsedocswJ26gYi0jzUgvjKSEt/m5ubWJ2wy8226wnotIDhh7frbYFeSSJDWsfjqDH
	 M0NBTvz0o2Azua0/vls0juADiW86OpWVHZwsf6FrGLACBKrcbQfimLUa0HIDugOOQb
	 tlc+Da295EA3Q==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	ioana.ciornei@nxp.com,
	chleroy@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] soc: fsl: dpio: Free the IRQ before releasing the I/O object" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:20:13 -0500
Message-ID: <20261107062013-failed-5.10-a7831c657c90@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a7831c657c90e8f9165f6bbe0cc56262fee075e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062013-failed-5.10-a7831c657c90@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a7831c657c90e8f9165f6bbe0cc56262fee075e8 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 2 Oct 2026 15:48:02 -0400
Subject: [PATCH] soc: fsl: dpio: Free the IRQ before releasing the I/O object

The DPIO interrupt handler accesses priv->io, but dpaa2_dpio_remove()
releases that object before tearing down the interrupts. The IRQ was
requested with devm_request_irq(), and unregister_dpio_irq_handlers()
only clears its affinity hint. fsl_mc_free_irqs() returns IRQ resources
to the MC resource pool without freeing the handler. An interrupt can
therefore access the freed I/O object before devres releases the IRQ.

Explicitly free the managed IRQ in unregister_dpio_irq_handlers() before
returning its resource to the pool, and perform IRQ teardown before
releasing the I/O object. This also waits for an in-flight handler while
the object is still valid.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 993fec7e11ca ("bus: fsl-mc: dpio: add the DPAA2 DPIO object driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20261002194802.375497-3-mhun512@gmail.com
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 drivers/soc/fsl/dpio/dpio-driver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index 8d3134622a285..d8f28fb7c37aa 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -88,6 +88,7 @@ static void unregister_dpio_irq_handlers(struct fsl_mc_device *dpio_dev)
 
 	/* clear the affinity hint */
 	irq_set_affinity_hint(irq->virq, NULL);
+	devm_free_irq(&dpio_dev->dev, irq->virq, &dpio_dev->dev);
 }
 
 static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
@@ -276,10 +277,10 @@ static void dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 	priv = dev_get_drvdata(dev);
 	cpu = dpaa2_io_get_cpu(priv->io);
 
-	dpaa2_io_down(priv->io);
-
 	dpio_teardown_irqs(dpio_dev);
 
+	dpaa2_io_down(priv->io);
+
 	cpumask_set_cpu(cpu, cpus_unused_mask);
 
 	err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
-- 
2.53.0




