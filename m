Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173698;
	b=yDoaIX/oRHv7JeAHmlwUReVOmeCNCWogcZubJHryBIp8aaVfZmaVM0NMLjkEAGQpweLh
	 36qTSeBhIo9D2MPOfy1FCfaxK0DfqMiJJatoclTYbJecbPRdNGP5S3aA5XCavJQEPuDFT
	 49o45i2YSS3p2nqKWIGUHnX2OQZuY0iTDTurfHIzjFiwWt9wdkWoYu12GjmDto0Zoc4ib
	 +D38tEl2l9SQuCsfPGmlldCPptbpuIDBFm02YscTipA7lHis40z5F79mwVXI8y3pZ94oR
	 50bNrvOodEYnGXJgjkEodflIdc9rp+VPrYhdUIH6j9U3qWwvQKbzLCMDVDt2AzdmksA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173698;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jCl2TmQeyiSmIDMPF2MGOrqFWXsWxkkElgKtLsrXBBo=;
	b=J9UhQEIymwAEqi5ankNIJt20V1LVceLhkcFXZ5I7FEpn7tKKRYj5ApS7ppVxMoaQdgvs
	 QFJcQKdLg6xypzjsHe8MclTc9nbXoAExy6z1XJ+NND1i9JLsYSxoq11o4BzaAchJEX3T4
	 uD9LR/djwZsaO5wZmkDxWSi5NVL6kLIKMfaTpefUr7bPvf1n5f1r4JuQz4dIPCyNIbbDw
	 mnzGAl9trGb7M0lMY4SE5YZgN9D0oKPInbYJbCBUGu18DC8hBt02v0vElXr5RCO+xGhSL
	 DblpZz/QU5poRmRPct5OwrRJCfDHYtbFuwYMeukC075QE6ELcHMX8gRsIPrYUG/2q6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oEbvXxMK;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE8606A331;
	Wed, 28 Oct 2026 07:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79AE8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oEbvXxMK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793173698; x=1824709698;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CXxFxifzrPn2IDDPxeNmOw7Uu6zmJAFolihpjLJ3g70=;
  b=oEbvXxMKY6QhRm0mypwH+GDnA1h6uz0BqrxmYWttxLb+enC34k0Sosr5
   vDg656/Ny3gB8rjBkt0LzP+MbXzCaAJCSM3I+2aK2RJgw26hX1nkOuegJ
   PHFgpMC+uywDN3KjCWsQCIa3QSaA2bqppCCLvoilkdINP7MoSGIujdNOw
   RWW7EJ+63rEspUSqb10bsY/sLRTd8fU7ElTTDxT2qA+Nbu9PJstVppwit
   bf5/WQz2/8HiSYeUUHFkbg0GBLoNfEIscn4DuygbwRBbAltNGPu0k1Ri/
   QFBuIPXpVekBl1d41soxtAPVEFaor4cljnP45MtFxGCyJUuoRRio/eNAn
   w==;
X-CSE-ConnectionGUID: mGZwtFAlQYSiBKCkv4ZqbQ==
X-CSE-MsgGUID: ev7ReEcfTViHQ0EYOGA4iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1900440"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1900440"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:48:17 -0700
X-CSE-ConnectionGUID: 4kIF2y0+T1qlIvX9QdOLfA==
X-CSE-MsgGUID: PNMSS8WsR+ibOr2oV/S8cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5110912"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.126]) ([10.245.244.126])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:48:16 -0700
Message-ID: <37bd12e8-64dd-41c4-8f5e-0967e7a00759@linux.intel.com>
Date: Wed, 28 Oct 2026 09:48:49 +0200
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
Subject: Re: [PATCH] ASoC: hdac_hda: Keep runtime PM state in sync across
 codec remove/probe
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
 kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
 stable@vger.kernel.org, tiwai@suse.com, perex@perex.cz
References: <20261027144655.31988-1-peter.ujfalusi@linux.intel.com>
 <179312291692.199157.15417382173460679457.b4-review@b4>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <179312291692.199157.15417382173460679457.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/10/2026 19:41, Mark Brown wrote:
>> After the codec has been removed, its runtime PM status is
>> RPM_SUSPENDED while hdac_hda_codec_probe() powers the codec up via
>> snd_hda_codec_device_new(). The pm_runtime_put()/snd_hda_power_down()
>> calls on probe and registration then see an already suspended device,
>> the codec suspend callback is not called and the codec, its HDA link and
>> the codec_powered bit stay set, preventing the controller from runtime
>> suspending.
> 
>> @@ -554,6 +557,12 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
>>  		return;
>>  	}
>>  
>> +	/*
>> +	 * Resume the codec to have its link reference (dropped below) and
>> +	 * codec_powered bit in the same state as after the probe.
>> +	 */
>> +	pm_runtime_get_sync(&hdev->dev);
> 
> What drops the reference that this takes? 

it is dropped later at hunk 565, I can move it closer, after the
pm_runtime_disable() for better visibility for v2?

> The probe shouldn't have exited with a runtime reference, AFAICT it doesn't.

Correct, the probe exits without a reference.

> There's separate runtime PM managment for the CODEC in the HDA code...

The get_sync() is not for holding a reference, it is to make sure that
the codec is resumed before the snd_hdac_ext_bus_link_put() below. The
HDA link refcount follows the codec's runtime PM state on SOF, so the
put is only balanced if the codec is active at that point.

>> @@ -565,6 +574,9 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
>>  
>>  	/* Balances the disable above, cleanup_for_unbind keeps runtime PM disabled */
>>  	pm_runtime_enable(&hdev->dev);
>> +	pm_runtime_put_noidle(&hdev->dev);
>> +	/* The codec is cleaned up, system suspend must skip it from now on */
>> +	pm_runtime_set_suspended(&hdev->dev);
> 
> This updates the runtime PM reference tracking but doesn't affect the
> hardware.  Is that what we want?

Yes. At this point the link reference is dropped and the codec driver
state is freed, there is nothing left for a suspend callback to do.

This is what the driver core does via pm_runtime_reinit() when the
codec driver is unbound. It is needed for the case when only the card
is unbound (machine driver unbind): the codec would stay RPM_ACTIVE
with runtime PM disabled and a system suspend would call the runtime
suspend callback on the freed codec state via pm_runtime_force_suspend().

-- 
Péter

