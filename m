Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047466;
	b=OxydB0qZk9awDjwCYruFUx/kMXmJI4AbuQboaGWHLN6NNp7FQe/wPTlEQ8GE1JFGY3Ki
	 lM+a9AXsCLahAOEdZEAVba7WJScS48VP2phHX5M3uLhE5Fgm1T69Hbz5fb4VJyv4RBrrJ
	 qQRP6sBNmOhnTl8nNEnycBt/rGJSZ+y7ZQKWJ8wXCJlBrnvbHv39msQzJPOf/KNr3eIa2
	 CoX26C3H4ZdpW1a5oof9Y1CzdyH3BhNjOe6x8aSS8M0ZuxEKK0kjgz13TzpriFIFnVgAr
	 cjq0eVv3cYcA/0Kf1DY/2mAa+NPfImca2t4rcyAGv6y4718c2yLEnDFssxJNkiAl3MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047466;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WLLvVAD+2DL2ywrgztGcSouXIPLIgtQxR6COvr4V91Q=;
	b=2z/dR1T9MM+6YE6zxZqCgmHj61js4U7UEtomPo5+FowPz6PbVKmWqoYO4/X4bfQnGQbe
	 IK+8xhZrUh0jyYRY6pWRUm8lUT2hpbVSGJpOwTGh9cTbKGWhBb561mOfa+xfM2pfS+gtI
	 /+ftEJJo80LVM3DsUFYa5dGDROlkMd4slaoD12UiyVwnAYZGSVxESd6x2XVO/mPBQ3ySg
	 gXy0zqdv/nMCzOlFUmj1pmoRKOmIX4RBmk69SDSVwOkhPwjkSiEA28MJkw7AFIaQ7rS6D
	 PC07xcd/xD9o6SfTGy8xCCDy+r1AwUPJVNR9R1zjUqaC3yWno3vGbqa2Zs/3eM8zHUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tu4T24Mo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986F606D80A
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tu4T24Mo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21CB1F0089F;
	Sat,  7 Nov 2026 10:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047466;
	bh=WLLvVAD+2DL2ywrgztGcSouXIPLIgtQxR6COvr4V91Q=;
	h=From:To:Cc:Subject:Date;
	b=Tu4T24Moq1MnSlLo+FiObz8yrypwLVzd0M9dzMmR5I77DImbBosAbmmcjsVhQoen2
	 zruOQvbvQ5gdxwLu2dIPfS7PnKO22M/lFktTRsFYqWPChxiqfPxXZ+3Qk/DhOJ2ks6
	 OoHHW7S0lY1X1mT5iYgR6TgNHn8iUCPDQ4ku63Joc/2q/1g9CKKD7xEJYnB2VJMxZO
	 EEgkkM8BsEHSygdoDXjV9yWiOnUniDHk84yuVdS3JY0UzAczoxDDUA7de3bYTztleu
	 q1WPXoG2E4Tth9u3nidNTz/UIxuFCpNms+WrFU2tN9gzhqTbz8jagSqXNZCfzqvbr5
	 hKi2Va7EjEprQ==
From: Sasha Levin <sashal@kernel.org>
To: vdonnefort@google.com,
	fuad.tabba@linux.dev,
	tabba@google.com,
	maz@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Fix MMFR0 TGRAN advertisement for pVMs" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:31:04 -0500
Message-ID: <20261107053104-failed-6.6-6c29285e78b5@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6c29285e78b5e4811145ebda382ac0ba732ce56a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053104-failed-6.6-6c29285e78b5@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6c29285e78b5e4811145ebda382ac0ba732ce56a Mon Sep 17 00:00:00 2001
From: Vincent Donnefort <vdonnefort@google.com>
Date: Mon, 28 Sep 2026 10:54:50 +0100
Subject: [PATCH] KVM: arm64: Fix MMFR0 TGRAN advertisement for pVMs

Protected VM ID register emulation leaves unlisted fields at 0. This
creates two issues for TGRAN:

  * TGRAN16: 0 means non-implemented. It prevents 16KB protected VMs
    from booting even when the hardware supports it.

  * TGRAN4|TGRAN64: 0 means implemented. This may falsely advertise the
    feature even when the hardware does not support it.

Advertise all the TGRAN fields in pvmid_aa64mmfr0 so that the hardware
support is properly propagated.

Cc: stable@vger.kernel.org
Fixes: 6c30bfb18d0b ("KVM: arm64: Add handlers for protected VM System Registers")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Link: https://patch.msgid.link/20260928095454.3255918-2-vdonnefort@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 8758c68017765..ec469d96516a5 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -121,6 +121,9 @@ static const struct pvm_ftr_bits pvmid_aa64mmfr0[] = {
 	MAX_FEAT(ID_AA64MMFR0_EL1, SNSMEM, IMP),
 	MAX_FEAT(ID_AA64MMFR0_EL1, BIGENDEL0, IMP),
 	MAX_FEAT(ID_AA64MMFR0_EL1, EXS, IMP),
+	MAX_FEAT(ID_AA64MMFR0_EL1, TGRAN4, IMP),
+	MAX_FEAT(ID_AA64MMFR0_EL1, TGRAN16, IMP),
+	MAX_FEAT(ID_AA64MMFR0_EL1, TGRAN64, IMP),
 	FEAT_END
 };
 
-- 
2.53.0




