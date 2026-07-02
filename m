Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E21FB1;
	Thu,  2 Jul 2026 00:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782953284; cv=none; b=m956lvXSStQ9zOVzG7Dshi/YjI5XNSH08iupuojvCxDTHoOfpt1t9l2Z8IPSdtfTec2z1BhL1LgYJteRBqL/UNuzvkc+LHrcTRxnKI4MLkzqci3fu34yNg6PblGeIAU5Wenvzt9jOLtNxSov6ifpvg0Rrm3Zhz1d+Su9dPM4Rz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782953284; c=relaxed/simple;
	bh=BrXmYfiq8X94mS/qnS8FEVmwl0FSazp4G6SU7BCEJZ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=oAupIbsduVTLb8F3Mq+lZS9HqH5nm4Qzc7oQQznCB6JOmxzXa9aFMNcl14RqvInppWBymqcr6IDKFfimQXn4tYAa5PRFaiph295ZiVXneiSITr46Dt61//3FuH0rqmp1ylROs6rebuQO07UOFJcrznIMMzpygedzA6+b5o/x/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKuf9TPd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKuf9TPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B307C1F000E9;
	Thu,  2 Jul 2026 00:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782953282;
	bh=BrXmYfiq8X94mS/qnS8FEVmwl0FSazp4G6SU7BCEJZ0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=GKuf9TPdYjBwd4WPDF0Mut7aeIb7YaoH7Ythf/mbW117DlfRaksxaXPKMUKk2diLe
	 d+C+gqsfS4hkEW3JL+34ZF5vIJgxffCIxITeEj7i+sBeEln4iYjmpnWq1cIYHZyer7
	 9lHzz/AXiW7frh+7o6drEztCG6SEClGBhls+sYOp65FSsHIoAtXlg1MeJBP22GA2x5
	 8qUW/lrRxxBoDELysx3fMNevPZCd2UVb92C5hicc51PFQWvu5Ic9fL7zwrTGQVMwY/
	 LXB/JfZQ73w9PC4t5GryFtPLhWv42B2VMRN1MIhibFpqI2mp0ozExdXRNHBfamhVOp
	 98CmF6igche8A==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 02:47:58 +0200
Message-Id: <DJNO6SIE8T88.1F0ZUILIRVDJC@kernel.org>
Subject: Re: [PATCH v3 2/3] drm/nouveau/gsp/r570: Never enter Gcoff state
Cc: "Lyude Paul" <lyude@redhat.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Timur Tabi" <ttabi@nvidia.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Kees Cook" <kees@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Maxime Ripard" <mripard@kernel.org>,
 "Mel Henning" <mhenning@darkrefraction.com>, "John Hubbard"
 <jhubbard@nvidia.com>
To: "David Airlie" <airlied@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260701182857.190713-1-lyude@redhat.com>
 <20260701182857.190713-3-lyude@redhat.com>
 <DJNNQVO96RR1.141CE7TKF6MZP@kernel.org>
 <CAMwc25qA6GFb1Q=VHTa8BcM85B2dr22RrgdJcHTz70P5Xjj_bA@mail.gmail.com>
In-Reply-To: <CAMwc25qA6GFb1Q=VHTa8BcM85B2dr22RrgdJcHTz70P5Xjj_bA@mail.gmail.com>

On Thu Jul 2, 2026 at 2:30 AM CEST, David Airlie wrote:
> On Thu, Jul 2, 2026 at 10:27=E2=80=AFAM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> (Cc: John)
>>
>> On Wed Jul 1, 2026 at 8:17 PM CEST, Lyude Paul wrote:
>> > It turns out that the only reason our previous fixes looked like they
>> > worked for this was because we would occasionally set the Gcoff state =
to 0
>> > in the normal S3 path, which fixed suspend/resume on desktops - but no=
t on
>> > machines using runtime suspend.
>> >
>> > The proper fix is to just never set this flag. Our current guess for t=
he
>> > reasoning behind this is that Gcoff likely coincides with GC6, and not
>> > literally power off.
>>
>> I don't think GcOff coincides with GC6, it should actually be a power of=
f.
>>
>> From a quick glance in OpenRM, it seems that with bEnteringGcoffState =
=3D 1 it
>> also saves off buffers flagged as MEMDESC_FLAGS_LOST_ON_SUSPEND.
>>
>> My guess would be that with bEnteringGcoffState =3D 1, GSP's resume path=
 expects
>> certain kernel-driver-allocated buffers to still be in place that nouvea=
u didn't
>> save off, or rather never had in the first place.
>>
>> John, do you have some details about this?
>>
>
> In nouveau we have the INST_SR_LOST target, for buffers that aren't
> preserved, I wonder did something change between 535 and 570 around
> what needs to be kept around.

The r535 code never set bEnteringGcoffState in the first place. In r535 Ope=
nRM
seems to do the exact same thing.
