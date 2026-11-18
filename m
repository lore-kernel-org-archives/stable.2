Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794976156;
	b=rrVfaT3XQY0phyywoVy1IhNB0WyBU2HIwQYscF0qJdv8bhWWyWgyNac+avh5KgGbVUBi
	 U+gRss6/GIjtfCDMv/vW+046vV/ZEbDBgaw9Em4HxQ2zp2lY+7jHLTbixDGatirDq49D6
	 B0U4sohbFem1iMuYV212wd74Zg8pEatf4mBz73yq/a2NbHFtp8lkQbCkTCMcg10ojtV7w
	 EE3LtqhZVsYJGIdnnG91aNJSKmVikTJnmg1J/TSS9x7JmIs3AGce2f+q0BNRly9/eLZ+P
	 NWpGdIMMkE2xCA4Mhh9YZinityYcBKUP5tJQbRxpJ+ns08Y8deoBTrIc5Gep4pquXbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794976156;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=A02J3X3O1g4aC45xLZlyoNo28vIOlVQORrvvwYUfHIw=;
	b=dSsl8PKnYNU6KXXg0orbontw2RZV3cluteCGLeZTplCTyy9shcqx4tQNRpNNF4bvP2zo
	 ZCczbFDd2YI5Qjl8tua1e7emCbORRdLhuOdEmTNdil9ILFrKQ7JMDAxNYJ19X5tz2SovW
	 iwXM984g7nlO4PN3dZtCI7fM+K9ZtaZ5mBIROVnXDtXY95IylEQ8XvMjZGTADwpGB1bDD
	 9RNO95YJec0PIS+fA6po8vLeLwIQ8ddQ5n4KQ9HkJs7bYbigs9BqoFIiTVt2Ih+aDX293
	 2TqkbEfvFFsiYOFWs9QO2hmhbM5e2mAYGEIkDlpMIaPARpO13IahRpGwasr7lC8d+KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TFRYZSuZ;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F429606A31C;
	Wed, 18 Nov 2026 04:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F429606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TFRYZSuZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794976155; x=1826512155;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ciBMg2encgEkPWPqE1Lanzqyw71q/2dV81N6WR/JNBw=;
  b=TFRYZSuZCy3UMrovEVkkUuTXkK4O+4XGH6eJSR+hyHLecjrbWFU73WUy
   GVOWjqZ2bQOiIu9KC/Yb/PZkeXR48gbMEn3MpBhipMaJA8uLe9Cqnv7HY
   16Ud3QCJWV+284E+v6PI8nNaDPamX7E2GhdZ/ngx70vqePXKBdCZGWJU7
   zb5Pw+61VC0ZuJmQb8wQiglBGFSK7hS16EyNy7pIQocMOiLtRnsazi1Ov
   0+Z/S4zoSD7uxijtN3BPHH9y59GnLRrdXbdOqZz0WxyhwQNVwyFUfyLpo
   7nc+QJ4g1I/bzWNO6ffLa/GcUZWFi3DimS7ERnibUwxzvc6+zAHoHn2Z9
   A==;
X-CSE-ConnectionGUID: mMF1dOf7RjeVPMM4ZxBJ5w==
X-CSE-MsgGUID: qbgjI0tnTr+H2zD6rGssuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3796857"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3796857"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 20:29:15 -0800
X-CSE-ConnectionGUID: l2p3QlFCRIm6kgYbCeMUAA==
X-CSE-MsgGUID: rHboymlPQPeAJl+b1hVu6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9937595"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 20:29:13 -0800
Message-ID: <f9b9ab9e-949a-421a-a6fd-1c01c12bacde@linux.intel.com>
Date: Wed, 18 Nov 2026 12:29:10 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: Set FPD when tearing down a PASID entry
 with fault_ignore
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20261104051059.1345010-1-baolu.lu@linux.intel.com>
 <20261104051059.1345010-2-baolu.lu@linux.intel.com>
 <87o6c3uedj.fsf@intel.com>
 <7f86b03e-1c99-44ed-8d07-3502a21821fc@linux.intel.com>
 <CO1PR11MB48355713BC88BEA8794279E18C702@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB48355713BC88BEA8794279E18C702@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2026 1:58 PM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, November 9, 2026 3:35 PM
>>
>> On 11/6/2026 6:01 AM, Vinicius Costa Gomes wrote:
>>> Lu Baolu<baolu.lu@linux.intel.com> writes:
>>>
>>>>    static void
>>>>    pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
>>>>    				    u16 did, u32 pasid)
>>>> @@ -253,7 +238,6 @@ void intel_pasid_tear_down_entry(struct
>> intel_iommu *iommu, struct device *dev,
>>>>
>>>>    	if (!pasid_pte_is_present(pte)) {
>>>>    		if (!pasid_pte_is_fault_disabled(pte)) {
>>>> -			WARN_ON(READ_ONCE(pte->val[0]) != 0);
>>>>    			spin_unlock(&iommu->lock);
>>>>    			return;
>>>>    		}
>>>> @@ -266,6 +250,8 @@ void intel_pasid_tear_down_entry(struct
>> intel_iommu *iommu, struct device *dev,
>>>>    		 */
>>>>    		pasid_clear_entry(pte);
>>>>    		spin_unlock(&iommu->lock);
>>>> +		if (!ecap_coherent(iommu->ecap))
>>>> +			clflush_cache_range(pte, sizeof(*pte));
>>>>    		intel_iommu_drain_pasid_prq(dev, pasid);
>>>>
>>> I think it's worth documenting in the commit message why both of these
>>> are needed, removing the warning and adding the flush.
>>
>> Yes. I will add the following to the commit message:
>>
>>    Also drop the WARN_ON() for a non-present entry without FPD. Since
>>    commit 75ed00055c05 a concurrent teardown can see such an entry before
>>    it is zeroed. Flush the cache after clearing an FPD-only entry, as
>>    other PASID entry updates do on non-coherent hardware.
>>
> 
> hmm is it a separate fix?

I have added "Fixes: 75ed00055c05" to this patch.

Thanks,
baolu
