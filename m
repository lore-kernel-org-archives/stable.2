Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749D0511E67;
	Tue, 13 Oct 2026 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903247; cv=none; b=T2PmYDf92VLDZ9EhQOi7QugM91Tj2aeacojv2GJ3xzJfKCLa6jHoEVCTuPZfqTy2FkKCBsB6XUFuY2z161mTCf5x6QH0neW7ob5Z6n9El03y8udCWk8OWxPdYMtkb1TtfCMKuT26M1L7ItCpXtNNtN841clqAAPj1F++svnknvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903247; c=relaxed/simple;
	bh=JiPFF+Flx/qVsRO7tDIGm7FjlWWXffd8m6y36BOWNEU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=lBJBvbM99W815ozFfqiaid/ZFK+6VddzP5iX4wLgiTxxRBz0IvSiEEwCgWKpVoM2/XI7I7bs092/5mDv3svcU3QFeFlEMATiZzOWuDvWEd0CQUY6Zed4wZR9UW4XNIPRkZz1iStwj7Lb/srMzaJouZU2udj3ouK5g0FaHm92g7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtLfRZUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtLfRZUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E341F000FF;
	Tue, 13 Oct 2026 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791903245;
	bh=q1Nozj5QcuRYbWx6gevQVzGKniKXSWbpSV4kU5XL8EA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=VtLfRZUIHO4WgHmmpdTZEAIJ+A9G3/XU1ARQRTuUgvPlHV57IOFIKW83QL53UFOe+
	 aHSPMee6rHgmA7MFJMwRSBJrmVpxQWS8r3tNgxW763eCbxtH5udAXtnu5AuKs3fodt
	 zxbViOxzfM2EEjbhI8RFEPfV4kpnU8/q0AeMpRl2bv4jntDGskO1Dpj+PbxqYPTMlA
	 1twZCRSKqFeKrm3wqrI1CKfYFj+HyYypUroVgXSqqB5cOm9bGBxoWIx/BDpdCyqkAi
	 cbeTufg72nCUYrUudkNWjwC3zak9i4V2ZvcizZlGahHOFYMRTi0nBoIznsCx6y62m2
	 o1FEmgxTPIA6Q==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Free doorbell IRQ on
 unbind and deinit
From: Manivannan Sadhasivam <mani@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-pci@vger.kernel.org, mani@kernel.org, kwilczynski@kernel.org, 
 kishon@kernel.org, Frank.Li@kernel.org, den@valinux.co.jp, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Song Li <songl@zju.edu.cn>
In-Reply-To: <20260905014525.420764-1-fanwu01@zju.edu.cn>
References: <20260905014525.420764-1-fanwu01@zju.edu.cn>
Date: Tue, 13 Oct 2026 20:23:56 +0530
Message-Id: <179190323635.12828.11638916253013486155.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3043; i=mani@kernel.org;
 h=from:subject:message-id; bh=JiPFF+Flx/qVsRO7tDIGm7FjlWWXffd8m6y36BOWNEU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzkYHBPkjlBxE1iS8i9acCyZogrwxYWOPj2zHm
 5R//BXjtK+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas5GBwAKCRBVnxHm/pHO
 9UPMCACmhZLdMp/Wwag0cUNlDCVa8heRsjcBG2bKcSixF6x/wxd7/175C6L1AJS3frrVxVWXH2Q
 yMWg2pIDsZF5khBXe/4KjqG83LQS2L+oJlNc8rAEmxtJWVAxQfl5DwH1TzQLsYZoqXfT0ebQx2z
 vDup2+Ve2aEyj5Yo+kXWqqlgwC3HFGWcv4fSyLcfe3VpCpruoW3NROT+9MMk/RVnOLaIF6e0gbx
 qsMxTuU9eWhVDVjLaRouc/46JO+gL2XbSFXx52jUGZR34Wyf/InRUBWpazCtpfVxusOyia1dMCL
 czGPJRiCrYbggO+Unfp2GETRo2CfkMuJFpHO6J7lR1tsR852
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-05 01:45 +0000, Fan Wu wrote:
> Neither pci_epf_test_unbind() nor pci_epf_test_epc_deinit() frees the
> doorbell IRQ. epc_deinit() clears the BARs, while unbind() can free the
> BAR backing store; if the doorbell is enabled, its IRQ action remains
> registered with epf_test as dev_id and epf->db_msg stays allocated. A
> doorbell interrupt may already have awakened the threaded handler when
> teardown starts, and since cancel_delayed_work_sync() drains only the
> command worker and clear_bar() does not wait for the IRQ thread,
> unbind() can free that backing while the handler still dereferences
> epf_test->reg[]. The leftover IRQ also makes the next doorbell
> allocation on the same function fail with -EBUSY.
> 
> Free the doorbell IRQ in both paths, guarded by a
> doorbell_irq_registered flag set once request_threaded_irq() has
> succeeded and cleared in pci_epf_test_doorbell_cleanup(), the
> chokepoint shared by the enable error path, disable_doorbell() and the
> teardown sites, so no disarm path can double-free. In unbind(), the
> drain depends on the driver's own flag, not on epc->init_complete.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index d4905aa..ab8df91 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -95,6 +95,7 @@ struct pci_epf_test {
>  	const struct pci_epc_features *epc_features;
>  	struct pci_epf_bar	db_bar;
>  	bool			db_bar_programmed;
> +	bool			doorbell_irq_registered;
>  	size_t			bar_size[PCI_STD_NUM_BARS];
>  };
>  
> @@ -721,6 +722,7 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
>  	struct pci_epf *epf = epf_test->epf;
>  
>  	reg->doorbell_bar = cpu_to_le32(NO_BAR);
> +	epf_test->doorbell_irq_registered = false;
>  
>  	pci_epf_free_doorbell(epf);
>  }
> @@ -772,6 +774,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  		goto err_doorbell_cleanup;
>  	}
>  
> +	epf_test->doorbell_irq_registered = true;
>  	reg->doorbell_data = cpu_to_le32(msg->data);
>  	reg->doorbell_bar = cpu_to_le32(bar);
>  
> @@ -1238,6 +1241,10 @@ static void pci_epf_test_epc_deinit(struct pci_epf *epf)
>  
>  	cancel_delayed_work_sync(&epf_test->cmd_handler);
>  	pci_epf_test_clean_dma_chan(epf_test);
> +	if (epf_test->doorbell_irq_registered) {

I don't think you need this extra variable to track the state of the IRQ. You
can rely on 'epf->db_msg' to be non-NULL.

- Mani

