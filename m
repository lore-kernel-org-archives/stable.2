Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794559326;
	b=PUEKrwxRf2ZnkuKUgPqczAd+0WVIB9CskltU+RiM/M27vdQPxAzZCP0tpfIiJDZkbR+u
	 7z/sifjqx++703nzKOWuG8R8O0UNjyJst5frnxNA+IO8rMtuKUnd2BTksPJJrlrkRYzQt
	 9XeWjAeY1/q+EOLfk1gHCBpb6QVXp/Fax5yAyrpVB26kmvBzClWGIC4fnYsGhMsN7Zax9
	 FePGRuaiJ5QVpo6gpIAjCtNIWAM54oWCoGSt8LaSmiunEREoMo81seHr5Bh/nEBUYqwhP
	 HapSf62xjQrkrOeN5aGGP49n3r58yzx+TnkiTAtARQVyYI1izfGaMW//Syi6nrhI/dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559326;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rae9V4FPwbslU8FMOU+hcXCS6mYLPzOc1lkOL01C3s0=;
	b=NeNAmqAhdIeqAHJizzsb50+Hy2H8QpJbtG8op2JzaJg5FcNRyr44IBXlxsh1NBv/uEUS
	 Ju0Rkzen9JNxhnTyml3EWL+tSkrg5SVkBxn8IN2RZcvavgAGJBwQRnMjwcSTE1+6CcJaY
	 dDbO4RutfHckLPO7B1UWz3HlCuNIEN30vfHzPRLzIFCtVTDbdQykwIiCy9O3EPr9NoSW3
	 YofQ1Jq9tr1ZHagsUAs9guIf1SAgnJfy1EK775GKG2OwT21RriNZFuiOIsnRlBKS2jjrs
	 pHXLn3fjvrboKZxJUUi8+E5e17b6rTGiIIa2SU3Xa5I4D/3qd05HsQ2Vsd9JujbfX+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYKuBPvK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5634606A323;
	Fri, 13 Nov 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYKuBPvK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794559326;
	b=sFx21Kac/fW2y4wBcvemMuR8ScV/H62nUgFIYCgOIfXZ1VFajEMDlu6bMPU41UNHD2kt
	 VzJ5KjUJM2qpH8BpE/kD/fBmxiVQi4DIiToDv5wVaV8+jmCbsr5gSjVP3WD1tV3Egadhd
	 /bYa/XbtPFwJ992bksQDAan0BCqV0FJRWoV6aRYVstDoV6iLXFtfAhnAnIjp7+kPVYVH8
	 X4VNRskyJiXEokCq7yyBzn93qHjGvgK4JI4o0jak9HXttZmLLnzRQwEGV+/r+le79HtWs
	 xsmZQyaEUKEvJwGBnVPk0D2pt7c3mIoTXQ+/Ie5gWspn8CiLs74ejNs76cSiJ37j3+A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794559326;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rae9V4FPwbslU8FMOU+hcXCS6mYLPzOc1lkOL01C3s0=;
	b=oi7xpdaZkj0s1QmDGahsqWFQUjbGQRHLCvXyD2lxU7/3ADYwpBjabw8EWvPW1WJcXzn+
	 HHaWwd7G2AIxAufSzlWN6NSEmfIuEZgkQwfWQCk3kCESn1shx1xnPLsan1nJNj4M/Gtmj
	 Av4nABytHSQr1v/h7cz2t5um2ezQrXL4WeDMIYHn2nzl0GSLtigDPoyziAiWjw+S/dvqa
	 sE9QRCfAPoyjGBUX6NeUMqNy7+X+B1zb+2aGcuIKqfaOHvyl9Ah0HJi8WSzB9GrFE7WKi
	 cYtOmFMDg9ECU4Vm3tC8CsbM70AV3GZTNa4tJKQ9AkDUuYn2QHNyR+/33jr1opoOw7A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3363F1F000C5;
	Fri, 13 Nov 2026 08:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794559326;
	bh=rae9V4FPwbslU8FMOU+hcXCS6mYLPzOc1lkOL01C3s0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FYKuBPvKHpRRRkNV7ndHM2kEo0oTSeZ8EfPSmA5ey5bD4+b+ob/VGbVLg70+IUu2V
	 oR47LJ+EVa7HVeSkz9cWPSeYruJ5/lU8PS1TV9BHfGqN0t2E3G0AA+kareod03dEOy
	 hxGa8CyejUGXVXsV4vbbMgj9OIqXctkXMH0GTnD+BMHSN5YeOqUzUtCs5VYvBlc2jl
	 eEReiQRxIRlXmGLyPQTKrSb2yk9qgP6gxZp31uP3HNZcEH1EdyN4gx+BFzL1hal6nf
	 bJlLXgvbc8ztr4gRK5L6Ik8X8QRl+vQqXWWSgrbfQiRKV/bXVZhCbCW/8i0S8t4Esw
	 MuSMB1Z+k5Mzg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B572B476A4;
	Fri, 13 Nov 2026 08:42:05 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 08:42:05 +0000
Subject: [PATCH v3 1/3] pmdomain: rockchip: remove subdomain links before
 the domains on error
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
Message-Id: <20261113-pmdomain-rockchip-v3-1-b7039ca30b87@gmail.com>
References: <20261113-pmdomain-rockchip-v3-0-b7039ca30b87@gmail.com>
In-Reply-To: <20261113-pmdomain-rockchip-v3-0-b7039ca30b87@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yao Zi <me@ziyao.cc>, Igor Pecovnik <igor@armbian.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794559325; l=2410;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=5iFWkjIpYXw+8Ro3BXPVNak7cKPCkmaVzIP2b4nraWU=;
 b=asyIT48IM4s8kSCIe3IC3jSAcinyiaFuKPPhEvft4iP7yvo+5vWaJ16gRUZRiY4AxCuoJnCps
 bNZx1FzvK8EDGzJL3KfM5MvcahRaEGh0xKWwMRDuVy1iyOH2d2taU/A
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
 drivers/pmdomain/rockchip/pm-domains.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 86b5074b0469..df3f43d0c01b 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -955,12 +955,45 @@ static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
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

-- 
2.55.0


