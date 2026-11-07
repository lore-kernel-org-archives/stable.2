Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049416;
	b=g5LKC38kvL7aNkNxjiwiKbKaGoi7HXjk9syToZY5w5blH6ejB9rHg1UmofgR1CgotiZJ
	 UAB+FXkB5CV2ZnoJra8M1H78+oESNaZR1TrXVhnrjo0RTNM027WMa2b2yZTtwRdtuOyuA
	 l3DK+glmQkxBxUQeW66wfRrMlH8OjMjploItm3Axf3u5Ym64wU+lfGGyyhyDeFoqNy/Ls
	 2i+O5JLNkeplY4iffHmqZGRJJNasWjkdXkEmkNai4x81f13Jj93LJxBnGFOqmhdq3lOvo
	 KtCDGFmz/mqJOccjt1xp/QeG/4I1aaJ5uoGvLew2o8Hfy8oEyIngJe+lBiZmSfJ8eiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049416;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7EVDxzG7eVlSPMvp5G3urRTpiZqB1cPY0/ehtcfoUO4=;
	b=bZu/2eukDjCBWdXAcw7vWHglnkP4fU14Q8lBvqfVmqRi2gKFgGz0vKqjjxHeH7I63w5b
	 te1BoZAbdg7iu1wk0qOJ1x7KyydVM9u30siNI5Q3PiJRTBW1EIi7M3a0SBzvM2GQkKkr7
	 9dnWmvWIIkIZf/1gaTQaYfhiLNyq03iS8i/zHMCGiUyKQxSjo/78ZGJCNZsKOxRu17zia
	 BPTgQhV4WBcCaVT0BktFh8beDkmU7G+tK6vqI3z1L9ziUnIpUDIMLgJwpXwMKCsCbUgx/
	 MTdGMST/RbptHHHVZ/RZT08SknP3bY4iC+NuMqUBw8DkACC1pRCQ2W4jdZOXjedsEvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mplJKs09;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441E606D807
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mplJKs09
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E221F0089F;
	Sat,  7 Nov 2026 11:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049415;
	bh=7EVDxzG7eVlSPMvp5G3urRTpiZqB1cPY0/ehtcfoUO4=;
	h=From:To:Cc:Subject:Date;
	b=mplJKs09WcaJHQjVcQrhVeXJiE//aNKAOw5neU4UMqOI3hQTiod6OjY8NGwzrqw94
	 T1Xtxh9nzjEFUsv20m1DAAmx06wDNhinTSoo1c4blNlds8/xLwoA0S00bwmcyDGXIN
	 s37PGFz/XMlk6Q92PxxlQudGCSU33vhFJPYXFXuacpMZI24JKNuQ3sIyBJqWilTcyG
	 uKn1jVx0xspfbe0d/ObdyteJeqqz1VIa5/uayHtoG82QHsSVneASOj0zzR7X4w7Z7R
	 DebBbn/Fn5+36zcf3fkk5m1NfMz8Fwx2yB5dUYeeQw2yfPAAMwLQ8+hFWPYOQ3M0jY
	 mB8Ce7VRcYU6Q==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	ioana.ciornei@nxp.com,
	chleroy@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] soc: fsl: dpio: Free the IRQ before releasing the I/O object" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:03:34 -0500
Message-ID: <20261107060333-failed-5.15-a7831c657c90@kernel.org>
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
git cherry-pick -x a7831c657c90e8f9165f6bbe0cc56262fee075e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060333-failed-5.15-a7831c657c90@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




