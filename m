Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C91175A7E;
	Sat, 20 Jun 2026 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781926914; cv=none; b=lqtijPToU2Dk8T42/Igf9WRDg/DN4hZwFlBU+BpIxUyy3F8Fh8tzDpLWKfZRa+maqyDD4gXMTV1janKWn82aMVcfwpxRiLFy6I7SjUPnLRmkdQe0DMI709F0aspcjGw7XpfqRzix0epW+oc78t51KzNxE4lOmeCnZ2LFoo3zYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781926914; c=relaxed/simple;
	bh=gRn7+RaIMUj3ehI0AupbH+dTvmv9oBzS1ZIJoCNs2fo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KAN+KIwjv6TwuIT/XVK7pYsBkK8agpv7NFkc4tigl4nKZtnZNlEOOHRBgu2oh5uWpm/NgmxRFFG6gmNaErk45iW0P1Q2ogXN7CRIzl/dlTmHKFGeywRKB63Qn5nOn+YrfVc2jnuOen9MFMqXfeGS7hc06LyCzkgPSOJ6d4NV+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIalplrY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIalplrY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781926913; x=1813462913;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gRn7+RaIMUj3ehI0AupbH+dTvmv9oBzS1ZIJoCNs2fo=;
  b=CIalplrYlXlf6nYjq+fIs9QOBN0qVYEHidgeM2W9TmrXDY8GYExmyD10
   6d2HISrgjg1h70kLYuvXdP+o7lBXNdQ2sR72KH4/KN88OfZzj9ZC0IDEL
   UUzt9GSNcztUtM7nkiXC3POdckereP/P9sjIqJisAzHuj8yf/+UU4pq7K
   d1AQ9TWUBhpJRd2tDXlLLlIcLAALs0IJok5FjKd4Z6NJ/NEA6MKUsaCaO
   e9p9wZQ9KMOnZgHqbeRjPqU+264sGHEOSwlg2Ds3puBzFO3mB8uiW9vCH
   B9wGKLmP0ld69IPBtRmxj6E1nGTe1+hAkSlPAVKeY6AR6Oe9WlN9NSHcH
   w==;
X-CSE-ConnectionGUID: Be8LrNU4Q42kE/KVLcLjNQ==
X-CSE-MsgGUID: kza/5XGUSMuJM3Ht8DDa+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11822"; a="105552631"
X-IronPort-AV: E=Sophos;i="6.24,214,1774335600"; 
   d="scan'208";a="105552631"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 20:41:53 -0700
X-CSE-ConnectionGUID: ZPsFrOMLSCyit/irfxJXtw==
X-CSE-MsgGUID: cMKI8cwOTpuQulQg1GYa3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,214,1774335600"; 
   d="scan'208";a="272816935"
Received: from unknown (HELO [10.238.9.114]) ([10.238.9.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 20:41:50 -0700
Message-ID: <e9472b38-4a91-44b5-b75e-dc7abd23793d@linux.intel.com>
Date: Sat, 20 Jun 2026 11:41:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on command
 timeout
To: Desnes Nunes <desnesn@redhat.com>, Michal Pecio <michal.pecio@gmail.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
 <20260503071749.6abda137.michal.pecio@gmail.com>
 <CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
 <20260503213111.117db3a1.michal.pecio@gmail.com>
 <20260504093118.615ff480.michal.pecio@gmail.com>
 <20260518083339.507e24bd.michal.pecio@gmail.com>
 <CACaw+ewSWTo72fSk2Q7ZzCM8pNuyrX5ua+qA=SZOQuNNMKSA5Q@mail.gmail.com>
 <20260522110328.0d3eecd8.michal.pecio@gmail.com>
 <CACaw+ezqEO_PgjGeYCLq5hA2eKczFXgmZLa8qjPtVJZCGwsdsg@mail.gmail.com>
 <20260523022944.59799d83.michal.pecio@gmail.com>
 <CACaw+exPdwXVsJc5Xr=vN1WJt8XR46=X0-8PP=+5dWY5zUrKeQ@mail.gmail.com>
 <20260523102815.5c05c70a.michal.pecio@gmail.com>
 <CACaw+ezMnQh2_oqbZ0jF99+wOADMU2vSMqxh9BoJoefjAC_ixw@mail.gmail.com>
 <20260527103221.7f8b15b0.michal.pecio@gmail.com>
 <CACaw+exN3fdzGQE7oK-hRE3KpMrA3ckPDRAcXaFbd=ySXf8E5A@mail.gmail.com>
 <CACaw+ewuPm-eOACKX3Ux0UwJBRSftoBm7H+rxE2Z9E7KzWb5ew@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CACaw+ewuPm-eOACKX3Ux0UwJBRSftoBm7H+rxE2Z9E7KzWb5ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/18/2026 8:57 AM, Desnes Nunes wrote:
> Hello IOMMU mailing list,
> 
> On Wed, Jun 10, 2026 at 12:32 PM Desnes Nunes<desnesn@redhat.com> wrote:
>> I have just found out the solution for the bug.
>>
> ...
>> In scalable mode, a PCI bus may populate only the upper root half
>> (UCTP) when all devices on that bus have devfn >= 0x80. On bus 0x80, I
>> have e1000e at 80:1f.6 (devfn 0xfe) and xHCI at 80:14.0 (devfn 0xa0),
>> so the hardware root entry correctly has lo=0 and hi=UCTP present.
>>
>> However, after copy_translation_tables(), I noticed that root[128].hi
>> was zeroed-out (Present bit cleared) and another (expected) different
>> value on root[128].lo.
>>
>> In short, the culprit here is having a zeroed LCTP, since at
>> copy_context_table() the allocation of new_ce for LCTP context entries
>> currently governs the pos variable; which is later used to save new_ce
>> entries for UCTP at tbl[tbl + pos].
>> On the first iteration idx will be zero, old_ce_phys will be empty,
>> thus this moves the loop straight to devfn=0x80. At devfn 0x80, idx
>> wraps to 0 again ( (devfn * 2) mod 256), but since no new_ce was
>> previouly allocated for LCTP context entries, pos will remain zero
>> while copying UCTP context entries.  After all upper context entries
>> are saved, tbl will receive new_ce from UCTP at tbl[tbl_idx + 0], and
>> not tbl[tbl_idx + 1]. These will be later written in
>> copy_translation_tables() to iommu->root_entry[bus].lo and
>> iommu->root_entry[bus].hi, which causes the bug.
>>
>> In summary, the hardware tables were correct, but the copy path
>> misplaced the UCTP table for bus 0x80 when dealing with a LCTP
>> zeroed-out during kdump.
>>
>> To fix this, I created a v3 patch that uses devfn to better track
>> which half we are copying, so UCTP-only buses (lo=0, hi=P) are
>> installed into the upper root half.
> 0001-iommu-vt-d-Fix-UCTP-context-table-slot-when-copying-.rfc.patch
> 
>> I am doing some final tests now, but since this was a lot to digest,
>> comments at this stage will be most appreciated.
> FYI, all of my last tests looked OK.
> 
>> To IOMMU maintainers: should I send this patch to the iommu mailing
>> list and move the discussion there?

Yes, absolutely. The iommu mailing list is the right place to discuss
bugs and fixes, so please go ahead.

> I meant as a new submission to IOMMU maling list, since this started
> in xHCI at the usb mailing list.
> Of course, that is if nobody has any comments or objections to the patch.

Thanks,
baolu
