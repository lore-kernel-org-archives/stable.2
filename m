Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050300;
	b=Yh9NY64c8eUzj9Dh9VBvZDYvHRFTKXRYss6/2XJMtEB/078tIgsej1tXxFAYL6frrPMo
	 aJkBmE9Z2JxuIaYr9BoGL1zEbyIzpG6g+hzb/ZrAsHcKejDn12nFLctiLoz5EaOR1eANA
	 vFeuagMp3ZCcYzMFl8XGhqeRto3t3oNLv1Emm08UySSWKcd5bqnuBzTGGfQN8RolC+bbo
	 qXM9GVnBn0shu1gFOR2KUV4xg9a15sfRyEDH+1UjcwCcZEKb1mN3zqEPft8zqNpYUcSDH
	 YzS8ZZ1Xnig0F/kg3xeaSUPuqWMCBGIbjQsNnVT4Y5LBBAoJHLyvzCd7dzL8QlR1lRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050300;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ipzVJLoF3c+TmFMoIIHmLddTQ1TaFYOZh+7JoeYYhDI=;
	b=B8/IG128EHdDBHkwab6n7piUAcn5yct7+HE80spfBBYzhucX7UBKXLW5wSM2IUzigStb
	 mzXRhnZVbYejzbjgIbA1GzGvXrgTmLS/mkAqtuKD3yBGi6SRp/X5pcIw0aNg0samyflrA
	 +kl/r7OWjlHXCyp6+iIz6wfuorRLqXFuXZr8XeX9AkiA4SrO72DBrnbBgc8nkHtvaTcoN
	 zfhhX7ZmvbOPeGAKhHVhOVLXIKANm1ZGTqUmolS5mLoIZxFAmJzGjwRgWeH5D37K5OGpY
	 VdqX8A1FjGP8Fw/L+LnXD113cUoDJhuXVzCi98xqOrawQFoeFLOPaSIJJBi2E7pbW9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BIuxe8pA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC779606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BIuxe8pA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD3C1F0089F;
	Sat,  7 Nov 2026 11:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050299;
	bh=ipzVJLoF3c+TmFMoIIHmLddTQ1TaFYOZh+7JoeYYhDI=;
	h=From:To:Cc:Subject:Date;
	b=BIuxe8pAPDAKMaxF3bcgZrdVL0546lRMsdMFsDoiUjseFZM+v4r/rySOJObLMBncN
	 88uv3P0Oz9NpAezJd3+NbmdQU4GtA7QJ7gyMyZyA7q9AHr4nSuQsfj5EJNFeC2Z1Dw
	 QtFIJqksTYAPRcRzs0SqQs3k+6Yh5PjB46Trzu33Mazu7e03a0oMAzsfWrLKvzkoF9
	 QTBZ+tNy50ur1ERlfD+iw3vmHswverDafi00r/JQF2vhD0b5Pbei68fnEA+ORk7zyZ
	 HE51Njasvc0WnpLPUx+GLzTDdDBX3C5fBLomoYRc2CYzG2zvgjwipvRpmA3eWKPv3z
	 28sMnSoX7brQg==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	fuad.tabba@linux.dev,
	maz@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-v3: Undo assignment on iodev registration failure" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:18:17 -0500
Message-ID: <20261107061817-failed-5.10-8a88a46b86ca@kernel.org>
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
git cherry-pick -x 8a88a46b86ca3dbbd24522760d29edfb3f24ac2a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061817-failed-5.10-8a88a46b86ca@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8a88a46b86ca3dbbd24522760d29edfb3f24ac2a Mon Sep 17 00:00:00 2001
From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Mon, 31 Aug 2026 10:10:01 +0200
Subject: [PATCH] KVM: arm64: vgic-v3: Undo assignment on iodev registration
 failure

vgic_register_redist_iodev() assigns a redistributor region and base
address to the vCPU before adding its iodev to the MMIO bus. However, the
region's free_index is advanced only after registration succeeds.

If kvm_io_bus_register_dev() fails, the vCPU retains the assignment while
free_index still identifies the same slot as free. A later registration can
therefore reuse a slot that remains assigned to the vCPU.

Reserve the slot before registering its iodev. The caller holds slots_lock,
so a registration failure cannot race with a later assignment. Undo the
reservation and clear the cached assignment on failure.

Fixes: dbd9733ab674 ("KVM: arm/arm64: Replace the single rdist region by a list")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20260831081005.41346-2-kmehltretter@gmail.com
[maz: moved helper into the sole caller]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5913a20d83019..8fb0a3eb3457d 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -818,16 +818,21 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	rd_dev->nr_regions = ARRAY_SIZE(vgic_v3_rd_registers);
 	rd_dev->redist_vcpu = vcpu;
 
+	/* Protected by slots_lock */
+	rdreg->free_index++;
+
 	mutex_unlock(&kvm->arch.config_lock);
 
 	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, rd_base,
 				      2 * SZ_64K, &rd_dev->dev);
-	if (ret)
-		return ret;
+	if (ret) {
+		guard(mutex)(&vcpu->kvm->arch.config_lock);
+		vgic_cpu->rdreg->free_index--;
+		vgic_cpu->rdreg = NULL;
+		vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+	}
 
-	/* Protected by slots_lock */
-	rdreg->free_index++;
-	return 0;
+	return ret;
 
 out_unlock:
 	mutex_unlock(&kvm->arch.config_lock);
-- 
2.53.0




