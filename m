Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAE1382F0F;
	Fri,  4 Sep 2026 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520313; cv=none; b=iRgzXVGDW04UHqcVm9b2k8YS1tjTvg8dTjnSzvMxCExh6jnHWvkS5rv+kze8dU9H7sUnjX1Bu0Qtk2qN4ikAGhUVbTL6UQL3BxggqOX2B86peyYuqmEPTD+/6wnDvt4/LvEKagUOPQAwU4UKyVTT5c9cSd2TaiA7nUrpv7euMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520313; c=relaxed/simple;
	bh=d0cVoilWRCngfR4Nuy1LBj53yM5i2PbNVP+KTFrQ4vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1m7Uxzzqu/FMDKP/7eKETfG3mZNIVI9V39jZwVwBXCUdIBr9TR/gvJ+R2DfvdnBH3HwtQDTUmzY2oQwsUsfKCx33hZ4Hv/cKnWi9u3yxNpQWmhaijWDwLZMZ1PwHhcYtLX/Ky1VViVIP8HRDtHzG2XBVWWBQfttqb2TM5irlqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPXtzvET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPXtzvET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001881F00A3F;
	Fri,  4 Sep 2026 11:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520312;
	bh=AZqiGs6USnmgkejTOdoFRDR8+zIbzcWv7bEqGrJVhUo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oPXtzvETPj01cO6iMs8bbrsd+736Zi0Whx6gKupYUtqqNGq3IDazqxVLQs1aLl9PU
	 ZKHna5/M55a7AvkncQXkDbPOes95FiHGgDhyAj4vdSyFZmErWVk8YlPjwS98wE3Ujj
	 LuIlyj3jzrXzt1AJd7cgWulbitV1lupvl3/Ih8SAOmA4br55qmTEw+i+bqatnkQv9k
	 SZohAluqDMq4KoqfYZcRQEfuzFtWxfgvK3eXJCSFrEhnD2zXNJBEMZavrearjtSiRs
	 vCcD0dWOvcWvm1QYfE5f6iaFlqSBkCN59bDzeSBt0eGJ3QLI22sL2Gv2Z6B10brgam
	 xyIK1mNz1QJeg==
Message-ID: <59481565-89c4-45af-9121-e514304876bf@kernel.org>
Date: Fri, 4 Sep 2026 06:11:49 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: altera: Fix resource leaks on probe failure
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
 Mahesh Vaidya <mahesh.vaidya@altera.com>
Cc: joyce.ooi@intel.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
 ley.foon.tan@intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, subhransu.sekhar.prusty@altera.com,
 preetam.narayan@altera.com, cheryl.bansal@altera.com, stable@vger.kernel.org
References: <20260902175637.GA1993694@bhelgaas>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260902175637.GA1993694@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/3/26 01:56, Bjorn Helgaas wrote:
> On Thu, Apr 30, 2026 at 01:43:30PM -0700, Mahesh Vaidya wrote:
>> The chained IRQ handler is installed during probe but is only removed
>> from the remove path. If pci_host_probe() fails, the handler and INTx IRQ
>> domain remain installed even though the devm-managed host bridge storage
>> containing struct altera_pcie will be released, leaving the handler with
>> a stale data pointer.
>>
>> Interrupts are also enabled before pci_host_probe() is called. If probe
>> fails after that point, the controller interrupt source should be disabled
>> before the chained handler and INTx domain are removed.
>>
>> Install the chained handler only after the INTx domain has been created.
>> Disable controller interrupts during IRQ teardown, and tear the IRQ setup
>> down if pci_host_probe() fails.
>>
>> Fixes: c63aed7334c2 ("PCI: altera: Use pci_host_probe() to register host")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Subhransu S. Prusty <subhransu.sekhar.prusty@altera.com>
>> Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
>> ---
>>   drivers/pci/controller/pcie-altera.c | 35 ++++++++++++++++++++++++++--
>>   1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
>> index 3d3519b8d88f..902ae2d81763 100644
>> --- a/drivers/pci/controller/pcie-altera.c
>> +++ b/drivers/pci/controller/pcie-altera.c
>> @@ -864,8 +864,23 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
>>   	return 0;
>>   }
>>   
>> +static void altera_pcie_disable_irq(struct altera_pcie *pcie)
>> +{
>> +	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
>> +	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
>> +		/* Disable all P2A interrupts */
>> +		cra_writel(pcie, 0, P2A_INT_ENABLE);
>> +	} else if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
>> +		/* Disable port-level interrupts (CFG_AER, etc.) */
>> +		writel(0, pcie->hip_base +
>> +			  pcie->pcie_data->port_conf_offset +
>> +			  pcie->pcie_data->port_irq_enable_offset);
>> +	}
>> +}
>> +
>>   static void altera_pcie_irq_teardown(struct altera_pcie *pcie)
>>   {
>> +	altera_pcie_disable_irq(pcie);
>>   	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
>>   	irq_domain_remove(pcie->irq_domain);
>>   }
> 
> This patch appeared in v7.2 as 7a94138caeb2 ("PCI: altera: Fix
> resource leaks on probe failure").
> 
> While considering this for backporting, sashiko came up with the
> questions below.  Can you take a look and see if they make sense?
> 
>    This is a pre-existing issue, but does altera_pcie_irq_teardown()
>    lack synchronization with in-flight interrupts?
> 
>    If a device interrupt fires just before altera_pcie_disable_irq()
>    masks it, could the chained ISR (altera_pcie_isr) execute
>    concurrently with altera_pcie_irq_teardown() on another CPU?
> 
>    Because irq_set_chained_handler_and_data() unregisters the handler
>    but does not wait for currently executing ISRs on other CPUs, could
>    irq_domain_remove() free the domain while the ISR is still using it
>    to call generic_handle_domain_irq(), leading to a use-after-free and
>    a kernel panic?
> 
>    Would adding a call to synchronize_irq() before removing the IRQ
>    domain prevent this race during driver removal or when
>    pci_host_probe() fails?

In this case, because the driver uses chained interrupts, 
synchronize_irq() is not effective.

Chained handlers execute directly via desc->handle_irq() and bypass the
generic handle_irq_event() function, which means the IRQD_IRQ_INPROGRESS
flag is never set for them. synchronize_irq() relies on this flag, so it 
will return immediately, effectively being a no-op.

A correct fix for this potential use-after-free would be to convert the 
driver to use a normal requested IRQ instead of the chained handler. 
I'll work on a patch for that.


Thanks,
Dinh

