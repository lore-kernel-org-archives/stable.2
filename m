Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155827;
	b=0Q80gtxGFrmFmmQKJ7tPa6W126EMKrA35EnUGQOHF1VGVEC9R+8m7pizP1u+pvzpyDAJ
	 WrDSASrsI7SfbcQrANbpc83KTuoQnsydkadB/Pl5740qlnKkaqhD9Y/7N3BPzSWATeZIA
	 fypnVGncYQSudDDkgv9jFul7u8KTqLPNzctb7uMk6jW0WpkexxSdTGQgbMf/oIKP9WqCl
	 QaOINa3ngR+EeqbGWn07PM9XeQfei+wMDKtaTN6+KkQrPysKeOVevBxlGVf0aAlD9B+P9
	 8msK3Z0v0Quyp4QmajssD/VwNuFQD2E1prjHDkBuOZzn6z/ucSN29I7tyQCOyzgfGxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155827;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=tCjae/q4wLlfXAhddmNJo6fTWQEEDX3DSwL0YYJnPco=;
	b=ycrifyxdBK6DjTsE9mQYjgLGZdPWIVEttQOCnvub9nftuyRLD8Ol7bcFe1z99ny8wAp6
	 iCSXNyhRJBSdBrxk4UfSTiGaWw2SM76RS9RFwFSipWoPj6c2aNNg9mjUkwv0UdVahNnKw
	 C98oUuv+VEDiaSvZDE8cQrsmEI5mumMoQ9GhOg45tKfZlVr3HAC4vP5oOqoTotvM+Pcvn
	 eKVdgST6E5UNfq+4BBuDPB+2odS1b95RQwNlAqqqVvxFPoreNONtYjS4OYCpXFCcT6DeO
	 +sTl+U0EhQHBgcptpL7T193aUrezJZd/vDoMOZaFs3Nsnhq66MjkYnyoLWDM2cjO+Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RiCtJE28;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF660A2600
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEDF660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RiCtJE28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795155828; x=1826691828;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hgmexZriQZp0WwfBeXt5A0lOC7Znhg31K0HLXiX1lYE=;
  b=RiCtJE28HHoW4RsX1qL/qc0qtibW3KPofL9ma13jvE3ZFsEuAndPwPwD
   5yN0Jnz4GYykt6OXUVEoYKgEJ8ntrrICs51GVWCVSfSEpe+cb2XTnWjFH
   WsCU/7YzoZca2ELoLdgKtoQJ3p9FlCgzcpesqqzt9K6iClj0ZQ/YXaryh
   CHvPQgK3IkUoPWasBL6rKQHfqK89OYYCjBb/Pm+rQ3VU+lFiNARuR40dL
   1ONgzrFZBlzmtOf8oqCFGUhLEBzqWYpcYWW1unfeYzjSpptqUdg4E62Dx
   fh1G5+bL2sXoSgPpp0UrzcrigBQpcX4hVsD+bp7WKALmR3ici1fbRf1ns
   w==;
X-CSE-ConnectionGUID: JOQG1gh7TCitPbnXRihu7w==
X-CSE-MsgGUID: 2SlgVkshS/yeFiF5jQe7TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3918127"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3918127"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 22:23:47 -0800
X-CSE-ConnectionGUID: HNK10SwxQ9SKY6iz49hkSA==
X-CSE-MsgGUID: bDLKpNuGTeatXlKB9z8t7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10617394"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.9]) ([10.124.240.9])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 22:23:44 -0800
Message-ID: <6e48bcc5-8f7c-4e5a-9e34-1cab1c53dd92@intel.com>
Date: Fri, 20 Nov 2026 14:23:41 +0800
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
Subject: Re: [PATCH 6.18 0942/1005] KVM: TDX: Enable Bus Lock VM exit
To: Sasha Levin <sashal@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Nikolay Borisov <nik.borisov@suse.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20261104211043.516122098@linuxfoundation.org>
 <20261104211109.504581890@linuxfoundation.org>
 <dac4e304-98e6-4e61-93f4-8d971069d936@intel.com>
 <2026110539-lived-blast-ef64@gregkh> <auyRq2HXJIfMXgBh@google.com>
 <20261106-re-kvm-tdx-bus-lock-drop@kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261106-re-kvm-tdx-bus-lock-drop@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/2026 9:19 PM, Sasha Levin wrote:
> On Thu, Nov 05, 2026, Sean Christopherson wrote:
>> Yes, please drop it.  Thanks!
> 
> Dropped from the 6.18 queue only: 7.3 has the prerequisites.

Can you pick this patch for 6.18 queue now? I check the linux-6.18.y, which now
has all the prerequisite patches now.


