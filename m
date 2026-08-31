Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EE83CAA31;
	Mon, 31 Aug 2026 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163481; cv=none; b=HnzPjrrNAYqPD/OtKQ/v6lOKT9RkZLiBh2o+aF2ENLgYeWm96YrVfo1nTSKpXUS5szgUJ8bXzRV9TDxpFCGcUorQL+LOmMohSxHwHUqmDW7OVgMhsmdTYh/Qvm4v5bdhhhYqJeQ5oB2loPc1gj2qPiRBvhyhwyVHyBrR/fDuXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163481; c=relaxed/simple;
	bh=Cl5NpPOdLVHO5bVj8nYOLe43QlryP/1zjbbrcAoNYp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jWbW6MKIevfDwXzk2iB4/7bcBPA+j+xgRgQffx1XyqJ5ZIFn6nWNIHoCCft8uobSLFcT57zIj3gBpR1+KDkl9LAklTCrW/NbvrL596XOJnpSOzLRSdM6sLQenNEi9nlb9DqrXzyRkS45tbOfu97nQEcOZIdx/ctXz/+OaiCtS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egHvMJhs; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egHvMJhs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788163480; x=1819699480;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Cl5NpPOdLVHO5bVj8nYOLe43QlryP/1zjbbrcAoNYp0=;
  b=egHvMJhsaPUTUCfsGpl4BSkpKNXqAnze1Z10phc2EsNIFQEpQI9coEOy
   UoCwOKtW1hHm0qol6sYVWajBZ7m8cJDiZy+Uy3J46Tre71any+mMbE42s
   /k9pvJ94IFKZratDJkCFux0k+tHOL34YkFpx8LwQrpAKVdPt8vmTpjqng
   xXf7nWqeaJjHa+HNXicdZYD32LqEYv00hjcMw2bhuG491tDwyhjlYHIE+
   8IRCVN8kr6nyGAZfOeWjp/OMbtYyS8/ZlmaAL6Jc+YM5QCSGdfEfXYiAF
   sjMniRelrR2YT/+jZVlzZ94fgOoN8CpmG+1BrqaxYjCglvnMuFvgGGszh
   g==;
X-CSE-ConnectionGUID: q4tyxi0dTVeA8sduZMNdAg==
X-CSE-MsgGUID: g9yGfiEZR6ac8V3q+ojJrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="92251005"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="92251005"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:04:39 -0700
X-CSE-ConnectionGUID: VH6q6OATRrSq7aC9al69eg==
X-CSE-MsgGUID: mAIosUkXSSavDVXXFTNttQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="268171932"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:04:36 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 krzysztof.karas@intel.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915: Guard against NULL driver_data in
 i915_pci_probe()
In-Reply-To: <CADhLXY4YXGWUi8JcfdYMJ4HhKMKS2RLg2WvnZnku_XK45m4-fQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260813064902.367504-1-kartikey406@gmail.com>
 <CADhLXY4YXGWUi8JcfdYMJ4HhKMKS2RLg2WvnZnku_XK45m4-fQ@mail.gmail.com>
Date: Mon, 31 Aug 2026 11:04:33 +0300
Message-ID: <79e8a3d71ca0e2cb7274aa1e5e053f934bc88333@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 30 Aug 2026, Deepanshu Kartikey <kartikey406@gmail.com> wrote:
> On Thu, Aug 13, 2026 at 12:19=E2=80=AFPM Deepanshu Kartikey
> <kartikey406@gmail.com> wrote:
>>
>> pci_match_device() can return the dummy pci_device_id_any entry
>> when a device is force-bound via sysfs driver_override, in which
>> case ->driver_data is unset (NULL). i915_pci_probe() casts it to
>> struct intel_device_info * unconditionally and dereferences
>> intel_info->require_force_probe, causing a NULL-ptr-deref.
>>
>> Reported-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=3Ddb96c5ff032f4292a8dc
>> Tested-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>> ---
>> v2: Drop Fixes tag, this isn't a regression from a single commit -
>>     the unconditional dereference of ->driver_data has always assumed
>>     it points into a MODULE_DEVICE_TABLE()-backed entry, an assumption
>>     broken by the generic driver_override fallback path, not by any
>>     i915-specific change. Add Cc: stable instead. (Krzysztof, Jani)
>> ---
>>  drivers/gpu/drm/i915/i915_pci.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915=
_pci.c
>> index 82415af47d54..2f03f95945f1 100644
>> --- a/drivers/gpu/drm/i915/i915_pci.c
>> +++ b/drivers/gpu/drm/i915/i915_pci.c
>> @@ -958,6 +958,9 @@ static int i915_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>>                 (struct intel_device_info *) ent->driver_data;
>>         int err;
>>
>> +       if (!intel_info)
>> +               return -ENODEV;
>> +
>>         if (intel_info->require_force_probe && !id_forced(pdev->device))=
 {
>>                 dev_info(&pdev->dev,
>>                          "Your graphics device %04x is not properly supp=
orted by i915 in this\n"
>> --
>> 2.43.0
>>
>
> Gente Reminder. Let me know the status of this patch .

Sorry about the delay. Thanks for the patch, pushed to drm-intel-next.

BR,
Jani.

>
> Thanks
>
> Deepanshu

--=20
Jani Nikula, Intel
