Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047874;
	b=bkPsgib9MN+IdBfXWHkc1tDqnSOLvd9QhxjLhmoJHNsA3HiFJlapyhglo1jMp6yd0cKd
	 6Q5+waaLj/+c25v3Aznd1uj7B+NmV7WdDIDit5lLHpRowz30pxwT2ZB2aYdr1zePpT2lT
	 YhjHJ0ACHASFYqoABNSkGaRUhtcLGwPbsNFQgSHjw5iNE9AFawU7j1pcIlVbrAAMXMWpj
	 br9eG0BXVqNueHT5TGzusUcNsREajcrxJUD3z5p22WTCdogVP0yOQEsx7SVqzBewghO6x
	 Yi9KJ6a2gVJqk79ETN9CdKRkGzkcSjJ+vEG2Z7vZ7lCp0UzlfCtjI5mK0i/Ts7Gl5iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hahsfFJ6Fg+amcJWd9oPvaZFxATmMTPyZte9LtkcCQc=;
	b=brTv5p/IEN66cMLp//p5IU06azIWmti6FkEUeGJQgUgxLWF1TDHq0oeTXzaTF5BUSHu0
	 TCBJrdrPubLBVtE/BcMXQxyOLBlxN9NQjK0vaH3Smg3SLilOrZUVitupzAMYM8PTvhS8O
	 fzl0PIOfsWQ2uAFUaJzyuLX3w9MJR3p04FB+AAucp1MBlyyeyywYdpWq1arrj4L7LwYIw
	 TJ+TtBR8SJjEZwWXR/Rq2jAxW8HoBqjkoSxe3agHS2pcz7yBYrq/26vC2bwH3S6DAxVCL
	 B3cSfN9GOz4HG5IrPwxRNT90YgPDlTX+jdFq3RRafWstvYpTGWKpui6FZwdfjfy11Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T026rvMJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E04C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T026rvMJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74841F0089F;
	Sat,  7 Nov 2026 10:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047874;
	bh=hahsfFJ6Fg+amcJWd9oPvaZFxATmMTPyZte9LtkcCQc=;
	h=From:To:Cc:Subject:Date;
	b=T026rvMJjfsJjwV2NxpfbAqsySJFbFj6+xO0gT4FG87rhR/y9Q+zXdeD0uBj9BHQc
	 iUzGhXaG5EmjUiMgH0RBwyJYf4laWi/ZfTd7JHM+b26t9r39GSVoipMKLdrMtJ85MP
	 CtSrOx7zCk2tfeIiLXxnTPUZ22UPDHkEbs5KFwl747C8PzmpsQdBqadAX6iF5ap6QL
	 QlzfQRsBImsvjNe+otYu7rZG5ASeERqxKkPDATidvj/XB3zt2IuWbHwFvbqSQzuvyE
	 PDQsbydcspHKYr20kozX//MeW01DceBZEJalSccbUL7Py210TtGfXwbioY7EC1E5AJ
	 onBvoTPp0f6sg==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: qcom-ep: Deinitialize endpoint on remove" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:37:52 -0500
Message-ID: <20261107053752-failed-6.6-ed1d71e41c7b@kernel.org>
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
git cherry-pick -x ed1d71e41c7b2e755e0ef8e9af9cab9b6b185c4b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053752-failed-6.6-ed1d71e41c7b@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ed1d71e41c7b2e755e0ef8e9af9cab9b6b185c4b Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 16 Sep 2026 17:01:26 +0800
Subject: [PATCH] PCI: qcom-ep: Deinitialize endpoint on remove

qcom_pcie_ep_probe() initializes the DesignWare PCIe endpoint with
dw_pcie_ep_init(). The probe failure paths call dw_pcie_ep_deinit() to
release the corresponding endpoint resources, but the remove path does
not perform the matching teardown after a successful probe.

As a result, resources initialized by the DesignWare endpoint core can
remain allocated when the endpoint controller is removed.

Notify endpoint functions about EPC deinitialization and call
dw_pcie_ep_deinit() before disabling the controller resources. Keep the
existing early return when the link is already disabled since Qualcomm
endpoint controllers depend on the host refclk for hardware cleanup.

This issue was found by manual code inspection.

Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260916090126.2963064-1-lgs201920130244@gmail.com
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 56184e6ca6e69..28949386b0e87 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -944,6 +944,8 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
 
 	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED)
 		return;
+	pci_epc_deinit_notify(pcie_ep->pci.ep.epc);
+	dw_pcie_ep_deinit(&pcie_ep->pci.ep);
 
 	qcom_pcie_disable_resources(pcie_ep);
 }
-- 
2.53.0




