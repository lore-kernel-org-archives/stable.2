Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888104;
	b=o/0VNrHPIoh1FJ+ds+YNdVXmrXMVhMMX+9rFt+IIb9+AQKDl7mBa2ds85Ho2nirlBz0l
	 EByYZUXhxnUZ2V3Gn93dNPRFBUJADJCpWzNrkuoe0UAaG1FNIXn5/HeC1/Xb6mmLkD4vD
	 +R0kpdprmSlNqMqvpVXqZrn3Hvi3HBs2F+j5qZb+IIivpyf6jYnYB0PPqkmbWDXppoxy7
	 IhZP/zyhKvx2AkVIP1XBGRIH8HxtBFjXwMi5Zx9tYD0SpfNAnx7m9jTzxrejXUItehVzJ
	 vPOlouOC7dh4EMzUi8GvXyBR+G9Rm4omFpYOKicCikvU1VHw53zbq5NJnvTbl1oOo+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888104;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=hhYHORyyMEe9WzmKHSw5na7G0AtsvbFkX50GoyW9BPo=;
	b=J1W//O8N42dq1X7QXkKPYVyKF47aUMTIsURcwQBJDunEW/LByhNJWDfhqHMK8wARb8tu
	 wS0diISZQtBmzlE+BpGr9h0ng0ALSGiGI8d9MPBFbxyyYuTh2EohVPzk4M2TGbUpyHMmf
	 PyrErQ8A1yQyV3I4ylvuOA9e5eCQP8GJ7A5HDsCht+OAEnnB+Rb3tDax9CkJF4Ex4VbTt
	 OYE6lR2DfDD+zwqGC3Q3G2QvqbH+pbWPQPJLr9E9tQVUpEN42wkE4SIzjuhOfngltcb6t
	 Mh35F0eZOSf+RznYPE8givNJ/WDiiBlixJQH5M/O4WcjHTefRG/TROiVXSNikkbSuwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B35606EEB7;
	Thu,  5 Nov 2026 14:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CD31F00919;
	Thu,  5 Nov 2026 14:15:03 +0000 (UTC)
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] PCI: mobiveil: Fix device_node leak in
 ls_g4_pcie_probe()
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Vishal Satle <vishalsatleit24@gmail.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261027094427.143733-1-vishalsatleit24@gmail.com>
References: <20261027094427.143733-1-vishalsatleit24@gmail.com>
Date: Thu, 05 Nov 2026 19:44:57 +0530
Message-Id: <179388809743.2730.8434004843297816557.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=GsF7syF+nFLWXE9m7kFav4xxaz1L9DMmDNF5rgbPuko=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq7I9ielNJs9cOVzbu7dfV03fSaAXcVw3Efl3/5
 MGgqL6r9OaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauyPYgAKCRBVnxHm/pHO
 9fY2B/0UPbAnwhZVOulWyTLwWcwDtH8wPKAnl5TZjBlx3KJzWpzJ8vD6Z65kcgD5Nhy2kAh15mh
 kcX3dJ6RX16WpVlt/j8mjwHCI9X9edGJzjZkxEpZSF0STCMpQRqbaeQ26kd4djn6c+NTDXYWhcL
 O/ESpuFr3emaYHxI1XySbdSiApOfTLYBhhg2z43KuQRQ9gxqJd1FxR4ntrc4TIUCl2Rx1GisfXP
 5kybBO8xDPRfApUElgiIyhD9uvYJCkqEDKjQVDkJtIJcU9YCIV0JRWS6vLy9J44vMhiZ4kE21Zr
 4JUqyBfyU+RGlGwKbRM3yqZYGx+uwUPonaIe2MV8tzOGrd87
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-27 15:14 +0530, Vishal Satle wrote:
> ls_g4_pcie_probe() calls of_parse_phandle() to verify the presence of
> the "msi-parent" device node. of_parse_phandle() increments the reference
> count of the returned device_node.
> 
> Because the return value was evaluated directly as a boolean condition,
> the acquired reference was never released, leaking the MSI controller node
> reference count on probe.
> 
> Assign the resolved node to a local variable and call of_node_put() once
> the existence check is complete.
> 
> Cc: stable@vger.kernel.org
> 

Why? This is not a critical bug fix to backport.

> Signed-off-by: Vishal Satle <vishalsatleit24@gmail.com>
> ---
>  drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> index 4919b27ea..5b1862fe0 100644
> --- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> +++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> @@ -199,12 +199,15 @@ static int __init ls_g4_pcie_probe(struct platform_device *pdev)
>  	struct mobiveil_pcie *mv_pci;
>  	struct ls_g4_pcie *pcie;
>  	struct device_node *np = dev->of_node;
> +	struct device_node *msi_node;
>  	int ret;
>  
> -	if (!of_parse_phandle(np, "msi-parent", 0)) {
> +	msi_node = of_parse_phandle(np, "msi-parent", 0);
> +	if (!msi_node) {

You should just use of_property_present() and be done with it. The driver is not
using the phandle and it shouldn't care if it resolves to a proper node or not
as it will be verified by the irqchip layer.

But that being said, I really doubt whether we need this check or not. None of
the other controller drivers are having this check. If this property is absent,
then MSIs won't work, but INTx will continue to work. So the controller wouldn't
be broken altogether.

So this check can be dropped.

- Mani


