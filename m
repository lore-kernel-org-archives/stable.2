Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4432F515964;
	Wed, 30 Sep 2026 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787734; cv=none; b=rqKrMH7U5dEIAd2VMWY2SoafyeRSPs150HOex14YQH6DxiGJ8WFBcIANNi1a4LA8cfml3JtRMn0DFnV1hNCGwr3Qj7oVIaHhNbGMRy0gYERFu5XPyh3Rx/QBvviDnZSkg5g8kh0E+K3eoMiof73jEoEm2brBvcJvL9LjN5iOxnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787734; c=relaxed/simple;
	bh=9lMV5dgcBCBmAm7tn/MclC+xRIeMw2vFnKEJ5c6rgFg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Disposition; b=ZN0S/eOMxBT3GLyElhXYmmqnxqJ/N9SNByMKoHk4xwD7JWrfrN2s7LBYpAzLRs+t60SMWrFKwz2pFZzSzcRAeGVVr9fYoXj2oxZY99Av8YA9mP5mfXxARtx8is6N1pugxrZ/0U43T+0uS9cz3TreM26WaAyeXtafj/pJIdcpK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fqJB8AnY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fqJB8AnY"
Received: from [100.96.208.60] (unknown [52.179.129.152])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3A68720B7166;
	Wed, 30 Sep 2026 10:01:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A68720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790787680;
	bh=J4FHysKmL3sST3B6JYnWBExkNR6TyUEiXRkB5SFBJQA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fqJB8AnY0C0Mq2QOcZ1YCLFv0XUWWYTx2I86zAQN0rU1/2quofja7K/tU0ZKhk715
	 MiLXiQue02RBuXUNUXvWpKyWTl2ECXmL6J5pjVxxqDP3b8/eyTxoei4k09x29s1P6N
	 fBYGiIrKjlCDCa6cbNAiEzSLmOrUJdKEbhL2U/YI=
Date: Wed, 30 Sep 2026 13:02:08 -0400
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: "=?utf-8?Q?linux-pci=40vger.kernel.org?=" <linux-pci@vger.kernel.org>, 
 "=?utf-8?Q?minghuan.Lian=40nxp.com?=" <minghuan.Lian@nxp.com>, 
 "=?utf-8?Q?mingkai.hu=40nxp.com?=" <mingkai.hu@nxp.com>, 
 "=?utf-8?Q?roy.zang=40nxp.com?=" <roy.zang@nxp.com>, 
 "=?utf-8?Q?lpieralisi=40kernel.org?=" <lpieralisi@kernel.org>, 
 "=?utf-8?Q?kwilczynski=40kernel.org?=" <kwilczynski@kernel.org>, 
 "=?utf-8?Q?mani=40kernel.org?=" <mani@kernel.org>, 
 "=?utf-8?Q?robh=40kernel.org?=" <robh@kernel.org>, 
 "=?utf-8?Q?bhelgaas=40google.com?=" <bhelgaas@google.com>, 
 "=?utf-8?Q?Zhiqiang.Hou=40nxp.com?=" <Zhiqiang.Hou@nxp.com>, 
 "=?utf-8?Q?linuxppc-dev=40lists.ozlabs.org?="
 <linuxppc-dev@lists.ozlabs.org>, 
 "=?utf-8?Q?linux-arm-kernel=40lists.infradead.org?="
 <linux-arm-kernel@lists.infradead.org>, 
 "=?utf-8?Q?imx=40lists.linux.dev?=" <imx@lists.linux.dev>, 
 "=?utf-8?Q?linux-kernel=40vger.kernel.org?="
 <linux-kernel@vger.kernel.org>, "=?utf-8?Q?stable=40vger.kernel.org?="
 <stable@vger.kernel.org>
Message-ID: <0FEA6868-5A7C-4955-9FBB-BE9A1AE8D3F7@getmailspring.com>
In-Reply-To: <ar07ubdYLk-Tje1q@SMW015318>
References: <ar07ubdYLk-Tje1q@SMW015318>
Subject: Re: [PATCH] PCI: layerscape: use default error response
 behavior
X-Mailer: Mailspring
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



On Sep 30 2026, at 12:41 pm, Frank Li <Frank.li@oss.nxp.com> wrote:

> On Tue, Sep 29, 2026 at 03:43:39PM -0400,
> jeffbarnes@linux.microsoft.com wrote:
>> [You don't often get email from jeffbarnes@linux.microsoft.com. Learn
>> why this is important at
>> https://aka.ms/LearnAboutSenderIdentification ]
>> 
>> From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
>> 
>> The Layerscape PCIe driver programs PCIE_ABSERR to forward errors from
>> outbound non-posted requests to the internal AXI interface.
>> 
>> A PCI configuration access can race with the link going down after
>> dw_pcie_other_conf_map_bus() checks the link but before the MMIO access
>> is performed. When the resulting Completion Timeout is forwarded to
>> AXI, it causes an asynchronous SError and kernel panic.
>> 
>> For example:
>> 
>>   Kernel panic - not syncing: Asynchronous SError Interrupt
>>   ...
>>   Call trace:
>>    arm64_serror_panic+0x78/0x90
>>    do_serror+0x84/0x90
>>    el1h_64_error_handler+0x30/0x40
>>    el1h_64_error+0x68/0x70
>>    pci_generic_config_read+0x64/0xb0
>>    dw_pcie_rd_other_conf+0x1c/0x68
>>    pci_bus_read_config_word+0x68/0x118
>>    pcie_capability_read_word+0xa8/0xd8
>>    find_device_iter+0x8c/0x160
>>    pci_walk_bus+0x60/0xb8
>>    find_source_device+0x78/0xb0
>>    aer_isr+0x1dc/0x230
>> 
>> Restore the controller's default error response behavior instead of
>> forwarding these errors to AXI.
>> 
>> Reproduce the race by instrumenting dw_pcie_rd_other_conf() to call
>> map_bus() while the link is up, then schedule a worker on another CPU
>> to set PCI_EXP_LNKCTL_LD. Synchronize the CPUs immediately before the
>> Link Disable DBI write, then perform readl() using the address returned
>> by map_bus() concurrently with the link transition.
>> 
>> Without this change, the overlapping configuration read results in an
>> asynchronous SError and kernel panic. With this change, the same test
>> returns 0xffffffff from the configuration read. In this test, AER
>> reports a non-fatal Completion Timeout, and no SError or kernel panic
>> occurs.
>> 
>> This effectively reverts the error response behavior introduced by
>> commit 84d897d69938
>> ("PCI: layerscape: Change default error response behavior").
> 
> Subject should be revert ...
> 
> I am not sure what's expect behavior by other dwc PCI controller. returns
> 0xfffffffff or report bus error.
> 
> Frank


Thanks, Frank.

Agreed on the subject. This is mechanically a revert of 84d897d69938, so
I'll change the subject to:
Revert "PCI: layerscape: Change default error response behavior"

Regarding the expected behavior on other DWC controllers, I don't have
hardware available to test those implementations, so I don't want to speculate.

What I have verified on Layerscape is that with PCIE_ABSERR programmed,
the failed configuration access is forwarded to AXI and results in an
asynchronous SError and kernel panic. With the controller's default
response, the identical injected race returns 0xffffffff and the kernel survives.

Please let me know if you think the behavior of other DWC
implementations needs to be established before proceeding with this revert.

Thanks, Jeff

> 
>> 
>> Fixes: 84d897d69938 ("PCI: layerscape: Change default error response behavior")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
>> ---
>>  drivers/pci/controller/dwc/pci-layerscape.c | 12 ------------
>>  1 file changed, 12 deletions(-)
>> 
>> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
>> index 14d6ac4fc53f..d333f1ae8a41 100644
>> --- a/drivers/pci/controller/dwc/pci-layerscape.c
>> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
>> @@ -28,8 +28,6 @@
>> 
>>  /* PEX Internal Configuration Registers */
>>  #define PCIE_STRFMR1           0x71c /* Symbol Timer & Filter Mask
>> Register1 */
>> -#define PCIE_ABSERR            0x8d0 /* Bridge Slave Error Response
>> Register */
>> -#define PCIE_ABSERR_SETTING    0x9401 /* Forward error of non-posted
>> request */
>> 
>>  /* PF Message Command Register */
>>  #define LS_PCIE_PF_MCR         0x2c
>> @@ -103,14 +101,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
>>         iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
>>  }
>> 
>> -/* Forward error response of outbound non-posted requests */
>> -static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
>> -{
>> -       struct dw_pcie *pci = pcie->pci;
>> -
>> -       iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
>> -}
>> -
>>  static u32 ls_pcie_pf_lut_readl(struct ls_pcie *pcie, u32 off)
>>  {
>>         if (pcie->big_endian)
>> @@ -180,8 +170,6 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
>>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>         struct ls_pcie *pcie = to_ls_pcie(pci);
>> 
>> -       ls_pcie_fix_error_response(pcie);
>> -
>>         dw_pcie_dbi_ro_wr_en(pci);
>>         ls_pcie_clear_multifunction(pcie);
>>         dw_pcie_dbi_ro_wr_dis(pci);
>> --
>> 2.43.0
>> 
>> 
> 
