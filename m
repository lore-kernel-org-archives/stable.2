Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795687290;
	b=3r+sHWaECMTAEq2ndABkGX8ttyK22uiuh35mR8sa6lfkuyAW2ELZxLtoaeYwWKD5uqcU
	 xC/H93p/RivESMMKGt5GbRBS+0w7KTMuXNcLCjT6YIlLAB9cFSk2vr8/Ejt/4C/h1Frza
	 L7NeTEGiAPgy05uNfarfT6L2Ja/pnQi+yQcXgUSthXF/h3bHKM1QqZZ7mVSOq7ejXQRfR
	 Em4UW5ncZ+rnYXiM/knVudSSJkyEHA0lPTNvc07ROR2GneONkjQPAD3jLdBsr5DMX1oea
	 MsKbt/T+cxNk1+9wWdvvWpSOQ+SU2WPjheTN/dAaHYPBwUiWG+Uv9Fc1r3t53ZwBasw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687290;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jg4iEdjG/KwSXIdR2yz4+2QshqnGAJLJBk5W8ikNKtM=;
	b=CIuaW+sElQM8xR0xvGhZo4lLbjPFfbyM3dfdkXL0cMMv8V+jfg3XwcCPkNsnmBBM+rII
	 CBOBvdIV8kB+VkR7y0ygiTZD2OCGbIr6ibqwiK4GK6vdxUQs3x1y89NEj9kb7RmqcJsph
	 jTPYcM49S2060g05MDsGQ0B80t5gbLWPlsAVIicEf7aCcmyFbns19o6KDaNbiuYgD54Nd
	 +dyIId5KkICH2H3lzaoJc7P59sBd69lvaAk5tsqA+yqlzNmvlLYt01vXDUPJ/Eu2NM1FG
	 mZ80IsaP+do6DpaGPwfKovaZtYGR/CW868A0lKvLPq8WSnKuVngvJF9e5OHtm4g2/zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0qQu502;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E4606A326;
	Thu, 26 Nov 2026 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0qQu502
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795687290;
	b=shzgSzcu6uVeJNuPP+cr0dNFn5zwx6Qjt1DgyKcdNRgtbnUwjA7NhIJ0tfEeVkRDp+90
	 j165Xfhn13JuQYw5QPM1DswI5fQf2IrxbGjYhonuGbnpwgVeMskNC/rQDHCHB/Am7E3In
	 HBU69j0bty0If61oQA5hZlr5b19O0aSTBaYfTwRF62XjqNs3sotBXlLPmkqkSNfCl0BC9
	 KB/X8DdKHUspfhjm4ksamanWJKuc3Hh0Xr7dDsvBIxc/z+q0PhipPhPYt3CQfxV3LvXRU
	 Y6XkLSlLxCKdm7dl7u7p77jPhEG55p5uotte+3pxwLBty+aLFi63rj3pw1SCzW4ObdQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795687290;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jg4iEdjG/KwSXIdR2yz4+2QshqnGAJLJBk5W8ikNKtM=;
	b=0WL6XQn0AUiRBmE8pCBhB9zDDNoTQLD8o3ocYq0KFUEBPwtorO5gUVcEiO5IsFn3twy6
	 UtFsuhzPQlaHyS66A0Lk0N1tUMQkdxJgbV4ZNsOpqWjpgmMKH0i5/VuYcwoVBF5cmiXoO
	 o0OxQHmJZviIirYdAvy70VAsYjcpJo3NEbTC5tUv6L4Dw0o0q1SH41XuqPiO7zFqAH9Ux
	 aZV3oMdtAsh7mE1s/+W45zk5qRWvb7xsUgGplsQuciqmNfQ+uFSYsFRo7bNJbaT0M1z6j
	 EzCLWUX1XGLZ9RZgP5pWO+k6yoJrAGw2sHieZDHKmHv1bVB3Q0+8jYMKTOqXu+1l51g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 776ED1F000E1;
	Thu, 26 Nov 2026 10:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795687290;
	bh=jg4iEdjG/KwSXIdR2yz4+2QshqnGAJLJBk5W8ikNKtM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Q0qQu502pv09u+AVUfCBBs8cQWAj4XmhO0yp60nsTZzivrEchPMnhxTTcYeYH7Amx
	 bWJGSKl6mMe3Q/y9ig7L6fy2rmcI8snZgHuANO63y/RT8Z13/tPj/4vuEanRHCOV+X
	 ugrb1aOeLfnI4VZK4rn9N4wDzHDPELr8J6rJEY3eeqLYBxsyvYHQUgF3hz6raGEW2+
	 H7ZHo9bHIlN1XZLfCBDYsfG+po/gLheYIyemj/9Uz7BHrVkDk1punkO8p5URiTwuv8
	 1GTJQW8HrY+wyxW+gIyHE20q1mvYpFiRmY0pkxNrjZ5QNx6Yw8NsTUc0zoe2WYYp+3
	 vH6kwiVeXy4nQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C8FBC4D336;
	Thu, 26 Nov 2026 10:01:18 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 10:01:19 +0000
Subject: [PATCH v4] pmdomain: rockchip: remove subdomain links before the
 domains on error
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-pmdomain-rockchip-v4-1-c793cbec970a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NyQ6CMBSF4VcxXVvTgdGV72FcdISqUNJioyG8u
 y1u0BCXJ/nvdyfglTPKg+NuAk4F443t48j2OyBa1jcKGhk3IIgUGGMEh07ajpkeOituojUDpFl
 dMqJKLXUO4t3glDbPxTxfPts/+FWJMUGpaI0frXstTwNO3T8/YIhgwWvNCsUZq4pTE4P7QdgOJ
 D+QtUC2BBKFXMg6I4xQqctfga4FuiXQKPAS0Vowinj1Jczz/AZU6LbgSAEAAA==
X-Change-ID: 20261110-pmdomain-rockchip-3497a2e7fdf5
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yao Zi <me@ziyao.cc>, Igor Pecovnik <igor@armbian.com>, 
 stable@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795687278; l=3318;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=uck8uxhwuf0y7xOwjlHVWqB3IaYYgJtnjsA3v9+m38k=;
 b=sRUvDBPRpSUbm6kCsepTLQEUjX7F+fdk2Qa4Tux6yLrT9dKMKjvPTx94+soL/DDWuCHWOxAnQ
 570nDuozAeOCmeA3ljSrNpMaWT3yMRspv7kTsM6Xwuj1oruD9RhePPd
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

When probe fails after some domains were registered, the cleanup calls
pm_genpd_remove() in domain id order. That fails with -EBUSY for every
domain that is still a parent. Reversing the order does not help: on
RK3588 RKVDEC0/1 have a parent with a lower and one with a higher id.
devm then frees those domains while they are still on gpd_list.

Remove the parent/child links first, depth first over the DT nodes.

Fixes: 79d12b7a7f22 ("soc: rockchip: power-domain: use pm_genpd_remove in error cleanup")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Tested as v1 (same code) on an Orange Pi 5 (RK3588S), v7.3 based
kernel, with a test device tree that makes the PD_FEC clock appear late:
no freed domain left on gpd_list, and the controller binds later with
all 26 domains. The rebase is build-tested only.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.
---
Changes in v4:
- Rebased on the pmdomain fixes branch
- Fix only; the pm_qos error code and dev_err_probe() changes go to next
  separately
- Dropped "don't report probe deferral as an error": Yao Zi's patch in
  next covers part of it, the cleanup series the rest
- Link to v3: https://patch.msgid.link/20261113-pmdomain-rockchip-v3-0-b7039ca30b87@gmail.com
---
 drivers/pmdomain/rockchip/pm-domains.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 563614a7bf66..81a9163b43cc 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -993,12 +993,45 @@ static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
 	/* devm will free our memory */
 }
 
+static struct generic_pm_domain *
+rockchip_pm_node_to_genpd(struct rockchip_pmu *pmu, struct device_node *node)
+{
+	u32 id;
+
+	if (of_property_read_u32(node, "reg", &id) ||
+	    id >= pmu->genpd_data.num_domains)
+		return NULL;
+
+	return pmu->genpd_data.domains[id];
+}
+
+/* Remove the links depth first, so each child has no subdomains left. */
+static void rockchip_pm_remove_subdomains(struct rockchip_pmu *pmu,
+					  struct device_node *parent)
+{
+	struct generic_pm_domain *parent_domain, *child_domain;
+
+	parent_domain = rockchip_pm_node_to_genpd(pmu, parent);
+
+	for_each_child_of_node_scoped(parent, np) {
+		rockchip_pm_remove_subdomains(pmu, np);
+
+		child_domain = rockchip_pm_node_to_genpd(pmu, np);
+		if (parent_domain && child_domain)
+			pm_genpd_remove_subdomain(parent_domain, child_domain);
+	}
+}
+
 static void rockchip_pm_domain_cleanup(struct rockchip_pmu *pmu)
 {
 	struct generic_pm_domain *genpd;
 	struct rockchip_pm_domain *pd;
 	int i;
 
+	/* pm_genpd_remove() refuses a domain that still has subdomains */
+	for_each_available_child_of_node_scoped(pmu->dev->of_node, np)
+		rockchip_pm_remove_subdomains(pmu, np);
+
 	for (i = 0; i < pmu->genpd_data.num_domains; i++) {
 		genpd = pmu->genpd_data.domains[i];
 		if (genpd) {

---
base-commit: faa6cd23f6269990b09ec63849239aae5cdb238b
change-id: 20261110-pmdomain-rockchip-3497a2e7fdf5

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


