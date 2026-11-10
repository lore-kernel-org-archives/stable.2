Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294690;
	b=HSwLmEI4cCWWb2oHuGwQEA2T6qC8lLR2lICPEpxfr4J7xEbq/+Bg9rqnb/6OerDybDwT
	 NfmOuVdT2gLHrtIlRDmVOangGSxfbnQXLOSMHQGHhOG1RoM2eY0FnvkbB0xbfPSp5PjK8
	 qtkdqyAPcY2hX25GORlxKQdwUWzfnHtdeYah6ToLC0AvH/MRA3LZrtrN+dMSaengJ22Mq
	 KREOuWKfMWqqvX0A0Kq32h8eVqQ/Pr5gf9FG31LJKCeI256HlunnuhH6iExaV/597dmdm
	 6jUdzLvCQcJB9tnMosZfnuNtwcZmzNyItWX+XKwSVyKhs1kPt4ZgjUCkG0v4CppRSiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294690;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=631AX2w6OsOwTpnELkK8iHQCOmbo8GaA/UuM5ANzR4U=;
	b=HHPYmIxHIuqREdND/YMwBG7QF2g83UEMMjoSCgwBczbnEioSMDxHKhKt64TCWdb+A9Ec
	 EPYyOuZPTIkfbEEXLow0/UH0MSccw7YRkAcdq2m+AfJVn3YrYkS1MX8vv1RUgttUHjUq/
	 gYNNUi8uJjVkAvTMazuyfS15z48789X3eDuIwn0PZ1LpuerSxcoaycHUBeEfg9MuyUmG2
	 AQr8HNNOFF5YuFJoI5IxbstuTjcyJzMXc4rexKD93rdxg1UxCLloqYFkJiRfZSZft3KTa
	 La2emp5RkQ5FFluZXccY9GFQEM9iL/auNqHedrA9Irzukv1QkkJyFmKMLPqePV9Evtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bARRQkrl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15695606A33B;
	Tue, 10 Nov 2026 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bARRQkrl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294689;
	b=Q2GNLilOqCbWQnrRLI3eHx4jDB6/YQ5ZqELYQOJounrS5L2Kg4oXpzBNcCB/qklyDnMC
	 q5IkybGiJdznk+x5N2p8kq+6VzrNm7UE0vMG4I26r+2u15W00qTDuVY9CC0PpkwEr3mxv
	 rxDdiT45d4oXkHnNdfVzXQFJdCD5TZQ58z85nomqEuHsMIs0qhw0V6GUXkF1yD9PJVMys
	 ZaWEQUGXBGJLVyh4ax6/Lg0VXP6qzVtC1bACti1KjOPpsZQ2+jFOx6fCm41S0/MSp9TWQ
	 vEkTd0Py7Dwddf8G4/qmj7oGszy0+N5HA9OVg+jJTQ8wNpWctJukdeWCTNB+egVCf2g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294689;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=631AX2w6OsOwTpnELkK8iHQCOmbo8GaA/UuM5ANzR4U=;
	b=l3Z/sPQ3Kl0GUNLMU30sCw9vd4NiZ42AZ6sjifoX5Unwj9kHnneWw4k42s8ltWCOSo0F
	 lFIxv3wGktK7j2L9O6TpRif96A3+/Hd4eaPnjkxFMbjQD3T2DsKNrCWv637lXTpx6QVsk
	 PJxDSyaLEfl97yu5he0A48i0yF9BhL2/+uok+9LwXKP6Mqz8dCqnbvcPuXz8/bUN9qNWj
	 xV/gRJ564dES+87/65OaXgKaV+bAY2v9zw/Xqlu0YGqsga6UAEtKc3Ly8GoU/I+OkyR5E
	 sFr4rx17dHK0UZkopea2Fw6OS5J8aTFArmZ1z1cUPMstIr5zlXNZJuWx9meigpMuuiA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A06AB1F008A2;
	Tue, 10 Nov 2026 07:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294689;
	bh=631AX2w6OsOwTpnELkK8iHQCOmbo8GaA/UuM5ANzR4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bARRQkrlvwiaENd7GSVHKXnynrkX9oLXu/XCEoSTqRcHcodDuIAmZJ/cpK6rjCULm
	 j0Ti8MhZJsdvaEdi3tAEG+LFshdycijnKuaqrRcpwWQS7mc0GH290yWl4S8xGDBpC3
	 TyDg/xp5kQR0009Su/XK9j2Ewq8LYX4h5srCt0mU5QA230FqA0F8iz4QYX+S/pBDN1
	 Z+7K8ubr0dB3b9vVvwZK55bhfALzw2LWkXVcHGZkzjHAmtaaahVvB7WecHKytykLku
	 agappqpFILZ7rv6O9WBa3fI0gslalnnuko7MYbYCcO5j8eCgJb/n7oBjQTLGqtJEqd
	 23otYV9AYLUZQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3502748931;
	Tue, 10 Nov 2026 07:11:28 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:11:29 +0000
Subject: [PATCH 2/3] pmdomain: rockchip: remove subdomain links before the
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
Message-Id: <20261110-pmdomain-rockchip-v1-2-6b9fa6ebaa86@gmail.com>
References: <20261110-pmdomain-rockchip-v1-0-6b9fa6ebaa86@gmail.com>
In-Reply-To: <20261110-pmdomain-rockchip-v1-0-6b9fa6ebaa86@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294687; l=4093;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=dHO39ZDWV/KiynPjCX8DIPyBCclsXy+H+T79g0o69nI=;
 b=FFzN4q78FMlY70uZGAMhsLAd44pNMH5/Fp7RNwf+nYNlyKGSPKSu/By7MPSUvIquosiNFfIVv
 eLAwEl1GuJqCDwK9Y6vYCfyPUevloLjeK0yPkHt6uxEvUgGCTNxZn24
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

When rockchip_pm_domain_probe() fails after some domains were
registered, for example because a clock of a nested domain is not
available yet and returns -EPROBE_DEFER, rockchip_pm_domain_cleanup()
calls pm_genpd_remove() for every registered domain in domain id order.

pm_genpd_remove() refuses a domain that is still the parent of another
domain and returns -EBUSY. The cleanup walks parents before their
children in id order, and on RK3588 RKVDEC0/RKVDEC1 (ids 14 and 15) are
also children of VDPU (id 21), so no ordering of the domain array lets
every removal succeed. Each refused parent only gets the "state may be
inconsistent" message, and on return devm frees its struct
rockchip_pm_domain, the embedded generic_pm_domain included, while it
is still linked on the global gpd_list. The next registration, the
unused domain power off at late_initcall and the genpd debugfs files
then walk freed memory.

Remove the parent/child links first, walking the power domain nodes
depth first in the same way rockchip_pm_add_subdomain() added them, so
that each child no longer has subdomains of its own when its link is
removed. With no links left, and no provider or devices attached in the
probe error path, pm_genpd_remove() succeeds for every domain before
devm frees it. pm_genpd_remove_subdomain() also drops the parent's
subdomain count, which removing the child with pm_genpd_remove() alone
does not.

Fixes: 79d12b7a7f22 ("soc: rockchip: power-domain: use pm_genpd_remove in error cleanup")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 3b39b231ca0e..d7df19e10000 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -957,12 +957,58 @@ static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
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
+/*
+ * Undo the pm_genpd_add_subdomain() calls of rockchip_pm_add_subdomain().
+ * Links are only ever added between a DT node and its children, so walking
+ * the tree depth first and removing the links of the children before the
+ * link to their parent always finds the subdomain without subdomains of its
+ * own, as pm_genpd_remove_subdomain() requires. This also covers domains with
+ * more than one parent (RKVDEC0/RKVDEC1 on RK3588), which a walk in domain id
+ * or registration order does not.
+ */
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
 
+	/*
+	 * pm_genpd_remove() refuses a domain that still has subdomains, and
+	 * devm frees the domains on return whether or not they were removed,
+	 * which would leave freed memory on the global genpd list. Remove all
+	 * parent/child links first, so every domain can be removed.
+	 */
+	for_each_available_child_of_node_scoped(pmu->dev->of_node, np)
+		rockchip_pm_remove_subdomains(pmu, np);
+
 	for (i = 0; i < pmu->genpd_data.num_domains; i++) {
 		genpd = pmu->genpd_data.domains[i];
 		if (genpd) {

-- 
2.55.0


