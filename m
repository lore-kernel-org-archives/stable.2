Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18E30E0FE;
	Thu, 27 Aug 2026 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859283; cv=none; b=WAK0rhSiGaFcbi+Fp3Kg/4x6qoLfcN97jpUHejImU07fUX3g5Kn6TpI2D1rPiitbS8rlOq/qHVD5jc71moQQUvUUzOydQOgqWBsW8GUZN0IpcflP+X6p+93J7j9mKwDTP326EAYQXOWIB48c1QxTskGYjjYCKL2LuqBTEXaZL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859283; c=relaxed/simple;
	bh=5pDmZX89itqKoKJ9A3hSOA9iC6V/f0PzaEuakE3HF34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZViLdyzR2h0P6vn+G00Ka3VT9pc73mfMGZxKPmEZtp3sN1MHSa/GZeAJmjcBVKS+sxcwiajSHajSEEEtwR/jeIFFKcHKEbyk59rkh5mGnm0vCmXOxejqVghTZTV9j28gTntVsb69tzOnUvV+TQs08bczifwcSyZHZxXdcfpLsBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTRs+Evx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTRs+Evx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787859282; x=1819395282;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5pDmZX89itqKoKJ9A3hSOA9iC6V/f0PzaEuakE3HF34=;
  b=aTRs+Evxx+GWKQVIK6FSbtiLbk7EFqBvzChvaKT3IeIy17afM2uPgDuu
   aU0cZg+Ch1e1JcIo5INc5fLd127s+JESQKylL38EsD+9/BV3+mN0Y3a1d
   uJl49uOmq8/95bu8hSTfQf4BEKDg6XdYaic+/feLaOIrA9YUgCYyBuFe5
   05VoC8099RsjQp7rwN6yAYwJqFvAwo9lAn1cOi7eMJZxMTFziaMeTNwUB
   6JfMaiaj4L/OcHpdal3Cp5mxWbwer6gDb3jyPMiFEbsq/vCTe6635ZBG7
   1cVAn+PRzkHAcq8QNasW3S7g3k+zYvf2fLKBrutSgwq+0ZhEdbPwZeoTB
   A==;
X-CSE-ConnectionGUID: n/kDvqfSSmatzSScWywNLg==
X-CSE-MsgGUID: fXwSJEloQGK/y3dVBPQlFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="75909793"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="75909793"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 12:34:39 -0700
X-CSE-ConnectionGUID: 5BP2QpfsQZG8Dn/MRn243Q==
X-CSE-MsgGUID: TfbbbNvwT7qLxPE0sE3hNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="272181922"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.244.166]) ([10.245.244.166])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 12:34:37 -0700
Message-ID: <6ef9d29e-e0f1-4807-b7aa-ee0b54861fa8@linux.intel.com>
Date: Thu, 27 Aug 2026 22:34:28 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: Mathieu Fluhr <mathieu.fluhr@gmail.com>,
 Michal Pecio <michal.pecio@gmail.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, linux-usb@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 Forest <forestix@gaga.casa>, Slavik Dev <developer.slavik@gmail.com>
References: <CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
 <07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info>
 <aosGtkE_diwVJJtB@eggarch> <20260823174059.46fec036.michal.pecio@gmail.com>
 <aoser8dLytrwqBC2@eggarch>
 <CAPyJwA8m_Xd2oyV1i9k+-6f7A-j0FiC97yXL=Ci8ZAErs5W4vA@mail.gmail.com>
 <ao1ovvdPAy6n_F7I@eggarch>
 <CAPyJwA-QALkCQn8J1+=U-nuE_7WSEPhVcUEKb+MMYMaA_1AVjQ@mail.gmail.com>
 <ao7aLXk9q_v_jEyX@eggarch>
 <d5a395f7-06ad-401a-b026-e975f620f017@linux.intel.com>
 <ao8bM2SrASNh2u84@eggarch>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <ao8bM2SrASNh2u84@eggarch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/26 21:11, Lovekesh Solanki wrote:
> On Wed, Aug 26, 2026 at 04:40:14PM +0300, Mathias Nyman wrote:
>> Roothub needs some time to settle as well, but 200ms might be excessive.
>>
>> xHC can triggers wake (PME) when a connected USB3 device starts signalling wake,
>> but port registers changes are not always visible to driver before link training
>> between roothub and device is successful.
>>
>> My educated guess is that 120ms should always be enough for the roothub.
>> This is also the lecagy msleep() still apparently left in xhci resume
>> to detect port changes in xhci runtime resume if there are USB3 devices.
>> That msleep was supposed to be removed now that we got the hub changes.
>>
>> This 120ms can probably be further tuned for roothub in some cases,
>> especially if resume is due to userspace action instead of xHC wake signal (PME).
> So the patch I sent above unintentionally brought the total hold from hub
> and xhci side down to 120ms, which worked.
> 
> And the correct fix would be to bring USB_SS_PORT_U0_WAKE_TIME down to
> 120ms and clean up the msleep from xhci_resume?

120ms for the USB3 roothub, I'd keep the 200ms for external hubs

> 
> I can prepare a patch that addresses both if you'd like.

Sounds good, but better to split the hub and xhci changes into separate patches.

The hub.c tuning might end up in stable as it mitigates the issue seen on
unfixed AMD based platform.

Thanks
Mathias

