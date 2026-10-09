Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C34399E5
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791586866; cv=none; b=EWQfuJrCktUywNS7gDqrEVetY9sAnKgdoFYwJW5ooeP3ejZVJjK6yU3IedpgsKJ6aKTlGk5JLaZHAHkP8/T/6QsFOT6nB6ocfYCc2t+5/jP7+ECWhtBNSF9uU2nj5+ZH3UTOz0Kj67nUT90gb7UDFhUAQ17nQRVcfqpHPkGwkgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791586866; c=relaxed/simple;
	bh=YVehI8L9SJ/A2wQFyYiJGvjdJACXkIjxc5WMgO8QJ/A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=K5XJ5wRacyc7p4c8sS9yO4uedWywh61Xuq6sXKT1pys38OxfVgj719uvMqCcFMApsmHI5+W1CAEfoY92ZpuU+fnvVD0Lh0bEof8kEnHlwgBhrupnl/VPmgPtLy34Mj4uBZqSOF+HyAVW+1T+d5Pi8AX7g55BSBySndatMa4UQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUyUrG6G; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUyUrG6G"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33fb4680717so498883eec.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 16:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791586864; x=1792191664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LUMRwMi42ONolR4FJ6zVYn5shjf3e1soCnTUAifdauM=;
        b=hUyUrG6Gl44lqhkykP0p9NT2TAQe0zeQiifnOL5bcgYV2igs/HofHnbKT1NDCmSaYj
         wP8frLLgnSVbQn5ILIt4o2lQ30d6BCaQh/S54Gdjt7KZhmcDOWzA1FylcVeLO3HJVPJU
         1ElJwffJDgMyJWlO54wbPd3T5ebu5YYHXpkZOPx3fkXSDM+1dQ24dUFM3j8V6mkXoK0g
         0aDjzAlLJ9jC/yRhdu3LTz2PrgGjkA/Ol4zp8kWE9IhtF+kOr5z79oE3va964kXS2/qE
         kEJOaE56bIIgjMo5kOyFeJ9w+ZOojcKnqQUItA5hJ3nma7+GZWFP06K30bPqEdwtJauC
         GKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791586864; x=1792191664;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LUMRwMi42ONolR4FJ6zVYn5shjf3e1soCnTUAifdauM=;
        b=0W7aavJABvDZYrv1ayTA/9yol9Dl/HFnl70vppq8VfgMM/njAgNhN87a0ZUX/SAGUs
         Swyac6pUp7jvJIm1GqTWAZjIzdreBtaamf8OCj0UfjkHUazi74om+XbYu6nUdETPltoB
         l5WypYgaI9siVsX09BYYun/yLxHK9XkzzMJ0x05iVnqq/l2sScfDcxJR7OOL1rM9+4ir
         COU/0fJG0zlPH+RVW6qi2DKHP/yAU9KptlO4n+Uc7nWfm5DRTURSgR0Q3tZpHbqJp1eo
         Cf8c40OmPOZDs60yB23dZ0AJ4RmXOmk3bD4g0QSSnMY/MGaKI+jc5nDqlfeRbnca6Wen
         V/SA==
X-Forwarded-Encrypted: i=1; AKwUvByUBtryAzCRiJfUyCuLpIb8671KiqBKD4M35xWPDHHKUcRXEZNXBBXjEv5x8VeRl9RMJh8j4Lg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLy1hzRtj8vVltvQbg27wasvvbIfACbe1rokgIJ5/yD1zSYzkHQ
	qDokcn/i9+u/jVogwf1Chr6o/CW8JnxIoujCj2AMPX528gLoRHb/x7xr
X-Gm-Gg: AYBFou2qdvgFrgvIFuc44s+FRU7JGVg1RA6uEklOrgAhCCgOpYhH/hpK8+b9efioTf1
	ifflExhch2HO5Kg5uXwRISUVeYWrLlC56MOis2PDN/fR5AZXwdYAqREktuVtd5xsWMrzCBzbE2U
	EF/EEASK+yLcjJAOzTyKJTCbV76mPj7bfqNUi/E/ext30lOecut1MYSwhMcm9b6S9YEatlDcL/M
	pZqcjutAgN+GwAJIb659SmQv23t/jhabyWMQ8LB4w7AjEObvph1E6WSj0gV9xEcrLrKamf1UMYt
	dYyhOSoJD87KB2dZuy0TG6o3sGtOZjIqMvUuSqhBJWTYsVZfEiRh2vx/wV1F7LVJCKELgv8hC/u
	J7HhFluU9Vmks1CgnC7Q1Pm0sSbVpCIC5Ixs79ZKLo14HJZxPxE1wSHl4pYDIgy8z33TmPPzZAF
	V55sMUuAAIZAuvvwDWU5RSicrqaVAuEHXcL6AhUE8JAttAYaT+3VBEfzS1SF7/ceeMNRtK2Jnij
	jCC5qLXv7GgDFXzQZxucjRn6qatwtQgHS45XlNgcXtn6Zdys5sTrliVoiAvr/xr/sP0
X-Received: by 2002:a05:7300:cf8f:b0:351:28eb:8cd8 with SMTP id 5a478bee46e88-3537dfd8b22mr4251148eec.18.1791586863163;
        Fri, 09 Oct 2026 16:01:03 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca6d20dsm9521259eec.12.2026.10.09.16.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 16:01:02 -0700 (PDT)
Date: Fri, 09 Oct 2026 16:01:02 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Rong Zhang <i@rong.moe>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 Hans de Goede <hansg@kernel.org>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>
CC: Charles <hanker007@gmail.com>, Navon John Lukose <navonjohnlukose@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_00/12=5D_platfo?=
 =?US-ASCII?Q?rm/x86=3A_lenovo-wmi-=7Bother=2Cc?=
 =?US-ASCII?Q?apdata=2Chelpers=7D=3A_Improve_robustness_on_faulty_firmware?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261009-lwmi-wmi-new-api-v2-0-402828382679@rong.moe>
References: <20261009-lwmi-wmi-new-api-v2-0-402828382679@rong.moe>
Message-ID: <AB350CB0-8739-4F10-8055-875FE31EF242@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 9, 2026 5:53:42 AM PDT, Rong Zhang <i@rong=2Emoe> wrote:
>Some devices do not support LENOVO_CAPABILITY_DATA_01 and define the
>query method as a stub that returns zero buffer=2E Unfortunately, some
>devices do not implement the stub properly, causing WMI errors
>(including ACPI errors)=2E This was reported by Charles=2E
>
>The current lenovo-wmi-* implementation enforces the binding between
>LENOVO_CAPABILITY_DATA_00+01 and LENOVO_OTHER_MODE because of a
>limitation of the device component framework=2E When the capdata device
>bailing out due to a WMI error, lenovo-wmi-other becomes unbound and
>unable to provide firmware-attributes or hwmon/power_supply_ext devices
>for the other functional capdata device=2E
>
>Therefore, errors must be non-fatal in order not to break the
>assumptions made by the device component framework=2E
>
>Poison the capdata device by releasing the capability data list in this
>case=2E After that, NULL list will be passed to lenovo-wmi-other on bind=
=2E
>The latter will provide whatever is available, or unbind the components
>if nothing is available=2E
>
>A poisoned capdata device releases or skips allocating most resources,
>e=2Eg=2E, the capability data list and the debugfs directory=2E The devic=
e
>itself is only used to satisfy the component dependency of lenovo-wmi-
>other and coordinate with the latter about the absence of the capability
>data=2E
>
>Meanwhile, for devices that properly stubs the WMI query method (but
>still declares >0 instances), keeping the capability data list with
>empty data is meaningless and causes lenovo-wmi-other to call
>lwmi_cd*_get_data() to retrieve nonexistent capdata in vain=2E These
>capdata devices are poisoned as well to save resources=2E
>
>In order to release or skip allocating most resources for poisoned
>devices, some preparatory work is done in prior=2E With the preparatory
>work, it also skips allocating most resources for the WMI devices that
>declare 0 instance=2E
>
>Also identify missing components using the new wmidev_exists() interface
>(introduced at the very beginning of the series), and skip adding them
>to the match list, so that all components in the list must present,
>fulfilling the binding requirement=2E Some devices need this because they
>either do not have the WMI GUID of LENOVO_CAPABILITY_DATA_01, or do not
>implement the query method, causing the WMI core not to create the
>corresponding WMI device=2E This was reported by Navon=2E
>
>The new WMI API is also adopted to conform to the behavior of the
>Windows WMI-ACPI driver and improve robustness on various WMI ACPI
>method implementation=2E
>
>Finally, add myself as a LENOVO drivers maintainer as previously
>suggested by Derek=2E

Hi Rong,

I'll try to fully test all my devices this weekend to add a T/b tag=2E In =
the mantime, everything looks good, save for that minor nit you already ack=
ed=2E=20

With that resolved, for the series:
Reviewed-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>

Thanks,
- Derek

>Reported-by: Charles <hanker007@gmail=2Ecom>
>Closes: https://msgid=2Elink/CAKtz0s8UYRQYW_0bh=3D0TMx47Axm-W-muEay-r3rqU=
BS1NHMPVw@mail=2Egmail=2Ecom/
>Reported-by: Navon John Lukose <navonjohnlukose@gmail=2Ecom>
>Closes: https://msgid=2Elink/20260928190901=2E1369497-1-navonjohnlukose@g=
mail=2Ecom
>Suggested-by: Mark Pearson <mpearson-lenovo@squebb=2Eca>
>Link: https://msgid=2Elink/9789f452-d7eb-4f1e-8a13-7335332193a7@app=2Efas=
tmail=2Ecom
>Suggested-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>Link: https://msgid=2Elink/782FE636-A06A-4E12-9563-786374805947@gmail=2Ec=
om
>Signed-off-by: Rong Zhang <i@rong=2Emoe>
>---
>Changes in v2:
>- Add PATCH 1 ("platform/wmi: Introduce wmidev_exists()") to the series
>  as discussed at https://msgid=2Elink/83776200-4A60-4756-A99F-D5A3BB4D83=
4A@rong=2Emoe
>- Add PATCH 2 ("lenovo-wmi-capdata: Do not stop the AC notifier chain on
>  error") to the series, as adopting the new WMI API will intentionally
>  catch more faulty firmware and propagate more errors
>- Synchronize mutex initialization with release-acquire barriers (thanks
>  Ilpo J=C3=A4rvinen)
>- Refine line wrap (ditto)
>- Replace the term "poison" with "stub" (ditto)
>- Add PATCH 10 ("platform/x86: lenovo-wmi-capdata: Do not match missing
>  components") to the series to solve the report made by Navon
>- Update outdated comments, function documentations and commit messages
>- Link to v1: https://patch=2Emsgid=2Elink/20260914-lwmi-wmi-new-api-v1-0=
-7a400f2f69f8@rong=2Emoe
>
>---
>Armin Wolf (1):
>      platform/wmi: Introduce wmidev_exists()
>
>Rong Zhang (11):
>      platform/x86: lenovo-wmi-capdata: Do not stop the AC notifier chain=
 on error
>      platform/x86: lenovo-wmi-capdata: Only allocate sub-master info whe=
n necessary
>      platform/x86: lenovo-wmi-capdata: Store a pointer to component info
>      platform/x86: lenovo-wmi-capdata: Defer mutex initialization
>      platform/x86: lenovo-wmi-{capdata,other}: Only allocate capdata lis=
t when necessary
>      platform/x86: lenovo-wmi-capdata: Adopt new WMI API
>      platform/x86: lenovo-wmi-capdata: Register component even on WMI er=
ror
>      platform/x86: lenovo-wmi-capdata: Detect stubbed capdata device
>      platform/x86: lenovo-wmi-capdata: Do not match missing components
>      platform/x86: lenovo-wmi-helpers: Adopt new WMI API
>      MAINTAINERS: Add myself as a LENOVO drivers co-maintainer
>
> MAINTAINERS                               |   1 +
> drivers/platform/wmi/core=2Ec               |  33 ++-
> drivers/platform/x86/lenovo/wmi-capdata=2Ec | 450 ++++++++++++++++++++++=
--------
> drivers/platform/x86/lenovo/wmi-helpers=2Ec |  61 ++--
> drivers/platform/x86/lenovo/wmi-other=2Ec   |  24 +-
> include/linux/wmi=2Eh                       |   3 +
> 6 files changed, 400 insertions(+), 172 deletions(-)
>---
>base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
>change-id: a504a929-lwmi-wmi-new-api-f5344d48a86a
>
>Thanks,
>Rong
>

