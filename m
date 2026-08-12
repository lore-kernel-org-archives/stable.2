Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E06B403AE0;
	Wed, 12 Aug 2026 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573309; cv=none; b=AY2WZavSvM+BOcv2HvYdAmHhpmEe5/ijoKt+LmuNRq4K0zf7P510zfNtuOWrfWmiJz4MXCq/NB/CiNPHZ5eU62XP+WYEp8FIo5LGpWQ1jLDMbvadhhEWKSnKW3THIuMUBOacFsW+74hsWEHibWGtlZMknkB+Gd4vOmg9DQeE9IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573309; c=relaxed/simple;
	bh=EsfG38HkJbkAV/VN4qU3q9SxTzbrIxMHdzU8kvW0EpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldvX9dva8XyoAgXuCB1ymI32LoOS47mTrR/xDHe527VxZbbTZo1Z9SJHnzMb6fujdMQNfmMghub1+lPX35NAGFpEUlND8P5pfMAVqZHDyqFLGZc55XyloDIA4nILmVrSPSSe8Sxy/nNrE8SHp7uPqOSUoJf5d69wTH7zp66I8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyzytDJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyzytDJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772CB1F000E9;
	Wed, 12 Aug 2026 22:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786573307;
	bh=lSjfsT9lz56s5Gpwb7v0lw3+r8UguBFDrjycJYrRh50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WyzytDJLW4uygTB8IkrNv+M6l8KIdEXdWj0ar5ta618faApIAlLlo6conCSs2Vnf8
	 /RmPyIQchw5ZRaEgcfwzoN/asl/qrvGpDYC/EmT6+MHkCHruoug94FEa/9ERu3Tgjf
	 UMARMLQSCJAPLr8J7MLgeiQLTOt2EDgshkBHbbERI6funv0ohrjMmthWR2NUqikhoo
	 7m4S7acpeOBGRgcHuOKdlx03xQoh6bAiZbpXi/7YThGLbExImYG6uoIVY+Ym57rzmL
	 zCxtonGW2KVyLbyH3TxflcIV4spiCqk96HrQTfYz0p1zPjZgH/WWjAriS6804MHqgx
	 PwklUDbDxCZrg==
Date: Wed, 12 Aug 2026 18:21:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	George Zhang <george.zhang@amd.com>
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
Message-ID: <anzx-jMt6_6OTdTI@laps>
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh>
 <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
 <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com>
 <2026081151-reabsorb-calamari-7442@gregkh>
 <8a0fad2d-788a-403f-a880-2f97c6708275@gmail.com>
 <CADnq5_Pb=ox3nWfdpb3Qeo_eSQayuc7UqUOnm0x+WS+EQTVWjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Pb=ox3nWfdpb3Qeo_eSQayuc7UqUOnm0x+WS+EQTVWjA@mail.gmail.com>

On Tue, Aug 11, 2026 at 01:25:14PM -0400, Alex Deucher wrote:
>On Tue, Aug 11, 2026 at 11:25 AM Sergio Callegari
><sergio.callegari@gmail.com> wrote:
>>
>> On 11/08/2026 10:08, Greg KH wrote:
>> > We aim to be "bug compatible" with Linus's branch, otherwise the
>> > "pressure" to fix those bugs goes down.  But I defer to the maintainers
>> > of the code involved if it is being worked on, and they want it
>> > reverted, great, we can do that.  Otherwise we prefer to leave it as-is.
>>
>> I understand. Sorry for asking about things that might be obvious to
>> most people here. My expectation was that only a selected subset of the
>> patches on the Linus' tree were to enter in stable, so do we really need
>> to have stable "bug compatible" wrt this bug? The original behavior was
>> not free of issues, but they were rather minor (a reporting issue). Now
>> we have this very bad behavior where the display remains dark.
>>
>> To make the matter worse, on systems that have encrypted root the screen
>> remains dark also on that password prompt (observed with plymouth).
>>
>> In any case, I managed testing 7.2.0RC7 and it is fine again.
>>
>> Looks like the Linus' tree has more changes wrt backlight, and the
>> interesting ones are probably those in the cumulative fix
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=973fd9493ec21f12e760fbbedeb7b0b2317c02f4.
>>
>
>Thanks for testing.  It sounds like we should revert the change from
>stable.  There must be some dependency we are missing in stable.

Hmm...

In stable kernels, convert_custom_brightness() still scales the user value by
(max - min), but f1b5d8f9cc54 ("drm/amd/display: Fix backlight max_brightness
to match exported range") widened the exported range to max. Past ~(max - min),
scale_input_to_fw() exceeds AMDGPU_MAX_BL_LEVEL and
convert_brightness_from_user() returns >0xFFFF, which wraps in
dce_driver_set_backlight(). With the defaults the cliff lands on 64533, which
is what Sergio sees.

Upstream only hides it: mod_power_set_backlight_percent() clamps at 100%.

Does this make sense?

-- 
Thanks,
Sasha
