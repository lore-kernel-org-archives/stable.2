Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046305;
	b=rJ9rDMQnChlva7AKrfT/bO52SVikEvMzSBIux6e4UdSs2T8QZ8HgJzZ4RWSfM35c8UNg
	 lVKs+sh+mjuOVlpbccjkdAiUBDzEp/Y7RjGAlwhMAOifOP/wrEbixCQNsBDOk5/0CL/Au
	 q5mZwhK3p8waRuSlq8JfA/jnxNHVsiEHhRnbj3m/xynVhXYjTV+KYhOD0MCudN0dGj2pI
	 0YuNwN1+CMgRVdfmHkZI632Peq5N/1/SxLnkenEvqr95Ogv+vjW8wXekZdTVECQVAei76
	 IJB3lW5U2vVdN31jfqTt2pO1feJHv85aUiYBPge02S75e+j+QBYKcQ3M9iX2Z+sty6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046305;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aDdTV/YA6i1wuTlReCcWbZ07kCdRxgFW25JUqJxNqgw=;
	b=NzhMHLiqniV0Wtxby4whNZwRzqmJGNIBgBZh0WAlM2Igg/AqxpDTWyHdlmESnXQ6MvVP
	 4qDbc1LxFeMZQJlht+2G792zRxdycEzHPfcy2rXbK3JoD+lV512hCedcWamQx5CZn0Ybf
	 BfBlU2gZoxudJasGb1sUfoxZobH0GtuVXiW1vC52q/2KWLYhvrjFbondB44qSX9Be+0wf
	 BeM3el6xUf8EFopDg9OKAFT4bhKpCrl32BgX58ginfw7WZJpQz2CDfTmZ/eVNuVmPcVDA
	 azs3Uia9MsECMV3A/EZPa6sCPy3oHqg+FqwjR8j6ca7CIOscuq75O7N9+zl+5rK/Gsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQam5OBv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A7606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQam5OBv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC1B1F0089F;
	Sat,  7 Nov 2026 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046304;
	bh=aDdTV/YA6i1wuTlReCcWbZ07kCdRxgFW25JUqJxNqgw=;
	h=From:To:Cc:Subject:Date;
	b=bQam5OBvp0aN93wAOYIXrBeTz66IFy7ohUx7boac5CrTrjXNN4Y3o+akLLXCoFeqm
	 9y41GVo3SE0W3sjG1vKngV4CtchFI9ngqlJtl+vV6GJgl7r7dk2jDPiAVRGqV1Yor8
	 9+sMEkrIo7Ogp3qHZ/734XiQtPy/+OC4jhtUVu+1bMYMA5oQEXeYOo9mBukgg1kyKl
	 Jcf4ccSkvACBt3rYxFE7NFqw6gbcGQdIrSFPfRQGpp65j88eljJf4gVEQ6bpClf3DL
	 BXiJeqFYQD2stJUCJVMj/Ds2bs3VeDnaBDnUTrwAbE4T6ZB1H/Bp/X6UEJmIw7pATH
	 fcX4jodgE7gQA==
From: Sasha Levin <sashal@kernel.org>
To: au.dang.jx@renesas.com,
	tommaso.merciai.xr@bp.renesas.com,
	tglx@kernel.org,
	biju.das.jz@bp.renesas.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] irqchip/renesas-rzv2h: Preserve TIEN state in rzv2h_tint_set_type()" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:43 -0500
Message-ID: <20261107051143-failed-6.18-42bedd4af8cd@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 42bedd4af8cd50c32a1560d8744bd22d25be79cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051143-failed-6.18-42bedd4af8cd@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 42bedd4af8cd50c32a1560d8744bd22d25be79cc Mon Sep 17 00:00:00 2001
From: Au Dang <au.dang.jx@renesas.com>
Date: Wed, 14 Oct 2026 11:59:22 +0200
Subject: [PATCH] irqchip/renesas-rzv2h: Preserve TIEN state in
 rzv2h_tint_set_type()

rzv2h_tint_set_type() clears TIEN while switching the TINT source and
then unconditionally sets it again, enabling the interrupt even if it
was disabled before the call.

Restore the previous TIEN state instead of forcing it on.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver")
Signed-off-by: Au Dang <au.dang.jx@renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261014095927.635132-1-tommaso.merciai.xr@bp.renesas.com
---
 drivers/irqchip/irq-renesas-rzv2h.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 1a4703a353e95..485c3eea76328 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -420,9 +420,9 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *priv, unsigned int hwirq
 static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 {
 	u32 titsr, titsr_k, titsel_n, tien;
+	u32 titsr_cur, tssr_cur, tien_cur;
 	struct rzv2h_icu_priv *priv;
 	u32 tssr, tssr_k, tssel_n;
-	u32 titsr_cur, tssr_cur;
 	unsigned int hwirq;
 	u32 tint, sense;
 	int tint_nr;
@@ -477,6 +477,8 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 		if (tssr_cur == tint && titsr_cur == sense)
 			goto set_parent_type;
 
+		tien_cur = tssr & tien;
+
 		tssr &= ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | tien);
 		tssr |= ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
 
@@ -489,7 +491,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 
 		rzv2h_clear_tint_int(priv, hwirq);
 
-		writel_relaxed(tssr | tien, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
+		writel_relaxed(tssr | tien_cur, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
 	}
 set_parent_type:
 	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
-- 
2.53.0




