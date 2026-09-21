Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086E54A0136
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000147; cv=pass; b=JUD4XktaSSxLfhBkahmMxW5azQZ5Rjrp8mNEtDbj27cq2KGbvCNYa9Jx0W/SS20DJb2Gk9+Xs5DoIu9K6nUtUmOxjJVmprWtJmr21xPG9DzUzMDzluPnOmE31kp6wgyjlWpX92QtGTT3NHwQ769faKjHT2Ujou7etspKdf3gcek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000147; c=relaxed/simple;
	bh=QLsW3OZgiOoo2/OqYWoiGLDpHxDhmxkLwSkqyStuBVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xans+VK6x6ut2L3/MVfXwqCHB4QmwX2DpFIF/ZeaOtCjosZy9WIdG1AXB5qlvaMkxxwfuA2/lSUSJdn9js4jU3JypWBLksfUZisQyc0TzBDrp9oYQWpuCccE5Uo2PWEp1YvlXGmWs4+jjvaTmL7VfrfwRJdL8SrjyTiMZ1S6kmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEweTyfZ; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEweTyfZ"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab19125so2910094d50.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790000144; cv=none;
        d=google.com; s=arc-20260327;
        b=mpRgtRo2f+yMJn+EcxNX8vwsU0h4h7djwAzDSacyX7Z/mg9aON8LJMBvpO5tDCd61R
         sIvlmOJAnxS+0KcHPjUyqx3mT8W7vRObXgTZ+qnBVL+fmq0kEk30c/XyRxN/kvi5Hmzs
         9gB9CBlSRHPQwzgg+/eQVLplf1wYFAzoRjZEThdnwY3Lu7opwS7OM18X2cMoGJaIl0GH
         9lE/lacGEr6tPFQc0A1bds7vz6w8BF1zIeNMudQej2n53nOFWqxh/UFbZgdEi9yMK1CE
         g3Xhe9Gpc/JBGAI4KlMzupz4iSoWwci+H2daLapk32h2++nc/gqNuviHewnCKcLfNu3v
         +EAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HvT37my9dta34DYQuaVV9y1xeoKj9pu6IBKBeJIjvCE=;
        fh=O5nmydXOOTE7nVv/rG8qRjAx1QDfUe4Xt7pOHntEBRE=;
        b=dVyRatFDeRDwr/OM5WKb/jeZYj3AMuwO8alrShOjrhlmg0NWVQFfSSPArVksmYFyp2
         UR6LNgPdOTDklmdXgZziyVVQ9RscUVSbm9kt1EOG2Vk0xozi7BuH4nVOiAnqJE1jvBEy
         noZAOTJsIP57U7vc9s39KLusrKHYy3ZKH8bHQqP9W8lPfVGQ8kY0yd0QCP4h46P1L0Mx
         k5W2GrLKIMgiMFxxkGB2NxJS1y+ShJeIMl69iJhyd7GkuTJ3ZE9bqDb17JXula6xEMcl
         0H/9A0bjifI67ufooECPaF0gdKz4YuAjTGiAAtfdVwuBwnKhgxjC9x9NvVjvOs6Sr0al
         k3xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790000144; x=1790604944; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvT37my9dta34DYQuaVV9y1xeoKj9pu6IBKBeJIjvCE=;
        b=EEweTyfZQ32qQ9tfWdmJMOqOWI7AILIpu9vOY1QhgDM1z0jNsl3NaqD8BxMP76CV3X
         vazogd2n7BGMx03d4WphSIthj8PbzJAmIFTHFE4q/9WXf/9Y0rv+6iIHvL+OoKkvZuTI
         ATEZ1iaUDLohZfIlJ3IiB0X1RVYj5KYya/kNOLb7Hyz33z5HkR24bKpDwtlzHAusqxYa
         X0J/xaQiFF/iZiyVNfutjwid+lJUzPYZLpAPj5TiBr4u1rrp8wVAiwFxhAk1mKTNj8hU
         pTC/T6w+7+3QmE72IBEjgDd1i+kiwUdb2XevKQWnGuI+AA848mgtW5A44B7PXMWe1cua
         15IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790000144; x=1790604944;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HvT37my9dta34DYQuaVV9y1xeoKj9pu6IBKBeJIjvCE=;
        b=KjiJqBU54+ZuK0kYFM49nE2DwJeuj4CPk0jZVS3QQDTt7dHec51VTjU/ziFcE4fsuo
         Jtz0x2gHOpEAfwih1PX3736ed2HIeR4H0aQyfvubsG3p5FjRxig0lycFmD3v9K5LlHpy
         07fsv4PBuWtifBbZL1pfSCkWf5FP07qSgMSBDukVlLWSnGepOX1yzIR4/KkUPfMi/0fd
         vcfJnECpbmv9FO5IsbYe2nj60N/D57EW/1f2vT5IENlagimb05ExlaWzT9URmHnqm7h/
         t35g2J0vjTQkFpEzBnDlOKCwdEZrn/qez3UGGTeXrIRkj2a7pqpBo+/5sAJYzlWojsvv
         /oxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWE/ZOueKw1dm0Y5zeBIGxLyQzjIgbsz99Ws42HlcpdOzDNCeWE5PxluHOJ6N77koIqNdVR1I=@vger.kernel.org
X-Gm-Message-State: AFuF++lKVjeO0QvYvNXWQreijUAPs+fJyiuzT/AyIo6kpePMxfE4c2ol
	QgR1ctg9JaJk8kfeA/iNiKuN10BRr0iIZ2uucVeupVc8he2JRW1Dgz3YAboYIREmeA5HCAM5m3s
	6ffMwZT1IwJj4+sXVgFAi1Q7aYJX5HDE=
X-Gm-Gg: AYBFou0sNTJ15g+2ds8tiC+0GvBCdl6KuzB/+eDo3Ojm7Qq4XiLChKsHQK1bEAqDpNg
	r8jPSqLWXK0caSfTHA92y7SjQKsVPC+2oaj1YomU9wQSYJ0bH29JkCrn5hsQj5Tjwb7dtrJo7NO
	/fxDKFB2/6ZfqlAFupFoyitc/RSlhX5qOUjuKBOiJwm+P/oHtiLKyU7vWQucsT1QQ8+5t/guT2Y
	7yqySqEdl+yazB27iRUom1F9urd2x1W61t3PMIP1Bfuw01P5REOBMS5ayQE/cQmMcoEyw/vHe+Z
	+4cHYHRW7efQ5mCFX4IeCFBsRr9RsZhdSX1QBiT8waPR24HijFwa0uoGJQ==
X-Received: by 2002:a05:690e:e81:b0:66f:9564:7827 with SMTP id
 956f58d0204a3-6717fc61321mr3128893d50.22.1790000142000; Mon, 21 Sep 2026
 07:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916080030.2960608-1-lgs201920130244@gmail.com> <736ff398-98fa-43bc-9771-1b0d4c2a591c@mailbox.org>
In-Reply-To: <736ff398-98fa-43bc-9771-1b0d4c2a591c@mailbox.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 21 Sep 2026 22:15:29 +0800
X-Gm-Features: AcwNN1XP7xc4w6JUo1lwgUr1iIYbKG3Cq0l_NU90yLcFM11w-KyBFtXZVHMUFrQ
Message-ID: <CANUHTR_AAKH13fRAwLY5wzMjhWuzwET=-359ZMNh0VU4tULrKg@mail.gmail.com>
Subject: Re: [PATCH] PCI: keystone: deinitialize endpoint on remove
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Yuho Choi <dbgh9129@gmail.com>, Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Koichiro Den <den@valinux.co.jp>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

Thanks for the review.

On Thu, 17 Sept 2026 at 06:56, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 9/16/26 10:00 AM, Guangshuo Li wrote:
> > ks_pcie_probe() initializes the DesignWare PCIe endpoint with
> > dw_pcie_ep_init(). The probe failure path calls dw_pcie_ep_deinit()
> > when endpoint register initialization fails, but the remove path does
> > not perform the corresponding endpoint teardown after a successful
> > probe.
> >
> > The successful endpoint initialization also calls pci_epc_init_notify().
> > Without the matching teardown on removal, the EPC initialization state
> > and resources allocated by the DesignWare endpoint core are left
> > active after the driver is removed.
> >
> > Notify the endpoint framework about deinitialization and call
> > dw_pcie_ep_deinit() before disabling runtime PM and the PHYs.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >   drivers/pci/controller/dwc/pci-keystone.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index 602516239a57..35787e727c5c 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > @@ -1349,9 +1349,17 @@ static void ks_pcie_remove(struct platform_device *pdev)
> >   {
> >       struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
> >       struct device_link **link = ks_pcie->link;
> > +     struct dw_pcie *pci = ks_pcie->pci;
> > +     const struct ks_pcie_of_data *data;
> >       int num_lanes = ks_pcie->num_lanes;
> >       struct device *dev = &pdev->dev;
> >
> > +     data = of_device_get_match_data(dev);
>
> Could you maybe cache the mode in struct keystone_pcie {} instead ?
>
> > +     if (data->mode == DW_PCIE_EP_TYPE) {
> > +             pci_epc_deinit_notify(pci->ep.epc);
> > +             dw_pcie_ep_deinit(&pci->ep);
>
> Would it make sense to make dw_pcie_ep_deinit() call
> pci_epc_deinit_notify() , to avoid duplication in controller drivers ?
>
> > +     }
> > +
> >       pm_runtime_put(dev);
> >       pm_runtime_disable(dev);
> >       ks_pcie_disable_phy(ks_pcie);
>
> --
> Best regards,
> Marek Vasut

Agreed. I'll cache the mode in struct keystone_pcie and move
pci_epc_deinit_notify() into dw_pcie_ep_deinit() so controller drivers
do not need to duplicate it. I'll send a v2 with those changes.

Thanks,
Guangshuo
