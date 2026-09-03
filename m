Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EFB4B5CC0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447891; cv=none; b=YiucwcMrramqq2XWo6i4F9D7bibXl/7Po65sGkwzLPdh/AXeLKuCtZluMFwTDG2jsh/zd8TYJG7cquS9y0CwAcuzvSEak/jKMEfPNC6QwoDhDnW30o8YHD0gm/q1v5lSGZKdQbQ3M1IjcUv3RFl+n69obA4yIGezRsMBegvcMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447891; c=relaxed/simple;
	bh=qLKfAOuBT0aEYix2gFfCAy7GZHf6T1mr3Im6b2egiOQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eN1kXWXP3XODfkvOy3mhthZy3vwdiRXyzxGGAQZzM2cO1kkcKQ4Ad8culatnSS+s5bKmem1Eb8E0QuCcAOgwxWjkCmxyRstLIisSWkTS5Ce0RUNMnUubYYEdjAgV5ts+ha5BQO0m6UOmpr/lD2V7S7Cxq4jDxpdo99bdj+5aRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X9vX+SM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X9vX+SM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773D91F000E9;
	Thu,  3 Sep 2026 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447890;
	bh=BUss5h2TNL/dr0tWVAY0r+E4ZbzQvl4Ngjtnh6dh5Gg=;
	h=Subject:To:Cc:From:Date;
	b=X9vX+SM61c7ZgagBsRIIKHnsPW3VDdLoBAcL58fuagee4KzQN26x+UgxUiPujuVkU
	 8Oq+ZNvLLaNqfPLkar8xNot0BCLWlLjfIfRGIRN7R81qNxokdATZNnKTQkfUNT567h
	 pSEmEvy/BeXs4uXsSVRfbzAb9FbtbLuHHobt39/o=
Subject: FAILED: patch "[PATCH] PCI/AER: Emit TLP Log only for unmasked errors" failed to apply to 6.1-stable tree
To: lukas@wunner.de,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:43:27 +0200
Message-ID: <2026090327-figurine-worst-aeee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a8bf2dd750de7d682fdaa2127f4e3217ce9c4a82
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090327-figurine-worst-aeee@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a8bf2dd750de7d682fdaa2127f4e3217ce9c4a82 Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 24 Jul 2026 17:24:04 +0200
Subject: [PATCH] PCI/AER: Emit TLP Log only for unmasked errors

Per PCIe r7.0 sec 6.2.5, the prefix and header of an offending TLP is only
recorded for unmasked Uncorrectable Errors.  Yet when the AER driver
determines whether a prefix and header has been logged, it does not take
the Uncorrectable Error Mask Register into account.  Fix it.

Fixes: 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org # v2.6.19+
Link: https://patch.msgid.link/2e712b96ba5bfc729d78bfc23f7fb7d285aa3d6d.1784905909.git.lukas@wunner.de

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c21139b9079b..4d1d99662086 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -954,7 +954,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		info.level = KERN_ERR;
-		tlp_header_valid = tlp_header_logged(status, aer->cap_control);
+		tlp_header_valid = tlp_header_logged(status & ~mask,
+						     aer->cap_control);
 	}
 
 	info.status = status;
@@ -1343,7 +1344,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
 		info->first_error = PCI_ERR_CAP_FEP(aercc);
 
-		if (tlp_header_logged(info->status, aercc)) {
+		if (tlp_header_logged(info->status & ~info->mask, aercc)) {
 			info->tlp_header_valid = 1;
 			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG,
 					  aer + PCI_ERR_PREFIX_LOG,

