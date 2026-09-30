Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404CB2EEE63;
	Wed, 30 Sep 2026 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800104; cv=none; b=UxA5O/Ok6yqbqJ2Gk91MhEtjsfpwTHPsQXkgvqnzndtSr47JMgSX4djzplBWv2IET3+D3Jp+3HWCzNbQRc2Qq97y0rwpUSNT3GHdv0eq+zveYVlElfQ8NmanODKzKhHiWFMq3mOLoqZhfi4Mqhdkka8JBmK2LSMy3xlyQPpHNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800104; c=relaxed/simple;
	bh=9rktf2hgl/uVrRZ4iHt8YW+bXpVafwJlLDS7CU4phOw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhZVr6fshc9v2jQIPDHweWEcWNwhcTRlC93R8bNLJZBowHL4Asbw8ohObQfHZAu+O52p7vELzLYvmFu9bNX0ZhR98bjTmoCcqRaVVFufVqZwv82CCp6l14kdH7K/RvDA+tLPGp99iMe9SzWP1rGoHZh44fvWLk1juAXkQPFHZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WyXbAwo3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WyXbAwo3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790800103; x=1822336103;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=9rktf2hgl/uVrRZ4iHt8YW+bXpVafwJlLDS7CU4phOw=;
  b=WyXbAwo3Yc4tgY1aGjXeozymZTtGy57YozuZD5DMmEIaP6djGm8swULl
   EIG/zv4EP8kKIUUOg4LUPAtzX1qh9VkY8y8LS2O5wYZwbrZyq180kbYk5
   +kqJJJJStN4do9tKosfjKV7YIEzlZTdvBowVkDa1HKj5QZZzLHRIahxMY
   lnYIxIkp82wQcN/umIPthTDiODtcrIWb4RQ6KknJnv6P9Xu/2r+Pz2/tw
   SUea+wzokOmqwDVaBZFLFr4wd77parRpRshyh4B2C6yxrZRkMlbbjY2rZ
   4aAYHYqyAAoiOT7pcCXswVvwArjM0TfJfsGv1xGcus2pS8jdzwwtGYMZz
   Q==;
X-CSE-ConnectionGUID: O/3wNvmjSP+39QUL+12FEA==
X-CSE-MsgGUID: 9xzOCQQSSoWPFtpbDRt0mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90585429"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90585429"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 13:28:22 -0700
X-CSE-ConnectionGUID: TrL2uQ2PRJiq6Hj8/WZkXw==
X-CSE-MsgGUID: w0BQJxGNRV+xYIrTGfGHPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="275329860"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.223.41])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 13:28:22 -0700
Message-ID: <f3f665ca76f9d914bf4b91cf03358223596d922d.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Continue restoring
 limits on resume
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Guixiong Wei <weiguixiong@bytedance.com>
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 rafael.j.wysocki@intel.com, 	platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	wangyijia.yeah@bytedance.com,
 stable@vger.kernel.org
Date: Wed, 30 Sep 2026 13:28:20 -0700
In-Reply-To: <20260929163133.14326-2-weiguixiong@bytedance.com>
References: <20260929163133.14326-2-weiguixiong@bytedance.com>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-30 at 00:31 +0800, Guixiong Wei wrote:
> The PM notifier iterates over every uncore frequency instance to
> restore
> user-configured MSR_UNCORE_RATIO_LIMIT values after resume. Entries
> that
> have never been configured legitimately have stored_uncore_data set
> to
> zero.
>=20
> The refactoring that split common and enumeration code changed the
> iteration from active control CPUs to all allocated instances. It
> also
> changed the skip for an invalid or unconfigured entry from continue
> to
> return, causing that entry to terminate the entire restore operation.
>=20
> On a multi-package or multi-die system, configuring only a later
> instance
> therefore leaves its limit unrestored after suspend, hibernation, or
> restore if an earlier entry is invalid or unconfigured.
>=20
> Use continue to skip only the current entry and restore all remaining
> configured instances.
>=20
> Fixes: dbce412a7733 ("platform/x86/intel-uncore-freq: Split common
> and enumeration part")
> Cc: stable@vger.kernel.org
> Tested-by: Yijia Wang <wangyijia.yeah@bytedance.com>
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>

 Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c | 2
> +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-
> frequency.c
> index 667f2c8b9594a..c44e7e38cae25 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> @@ -211,7 +211,7 @@ static int uncore_pm_notify(struct notifier_block
> *nb, unsigned long mode,
> =C2=A0			struct uncore_data *data =3D
> &uncore_instances[i];
> =C2=A0
> =C2=A0			if (!data || !data->valid || !data-
> >stored_uncore_data)
> -				return 0;
> +				continue;
> =C2=A0
> =C2=A0			wrmsrq_on_cpu(data->control_cpu,
> MSR_UNCORE_RATIO_LIMIT,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->stored_uncore_data);
