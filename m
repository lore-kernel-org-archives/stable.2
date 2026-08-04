Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ACC423E95
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 07:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827057; cv=pass; b=ktWF12KMNDBbJVGxU9+fHGv2X86v5EAUE1jiIgzAu1x+YDP0LY6CRMa0FiR54uFm0OqgdtlfrmL/wt1hS68gH1Hudx0E6EzHkpjH5dxSfkiekMtI8V8VvAwhd/PfvPL7OmZP1TdsBf1++UX/PPZFm/OQdEE2Q1Pw7XRJTnr7oxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827057; c=relaxed/simple;
	bh=8cZ70URgE0B7jg9Zr3Tw+sHAe37y1pPJAWOK6UlBm5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecqmmbe74zVfbqNGgYekLVlFxoxhvI4YxUMRTX9KYJ2/SKcjwqA9czz9IesAQNxXtStha8tfGZRAnfxq0LYKBn3dfJps4Ig5LTi+dqpGJMdbd0clcEYGCDJ2jK/R1ug5LoIzBDX/OYbw2IGMM6ZU+Pp3ygTt+7lsw7P4hY42qg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=robert.mader@collabora.com header.b=A9h45/RL; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=robert.mader@collabora.com header.b="A9h45/RL"
ARC-Seal: i=1; a=rsa-sha256; t=1785827032; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YKEegjnpuSmHTOcRrWivKsOOzbbB08CCOj0SkP66xgoeeRUDl4q9qX6KRyJ0P/O/Uc0DTK7/ztOr0Vxbn5M44/apLUHVMNQY0auPY4V0BhCHSXE0P2lmLw3KHoVgQeWb+VrCU5JolVPMLXQAaQu6oB7q9hQo99tVRkiBJyU0Gq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785827032; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LgTqR8hX+MSPNZK1/ZnmYeT+jeK9oY4pjRChRQ3k7rU=; 
	b=DlFR7UTuyweWfc4n6G0VU5nhbzBuvVJoJxdEq3NvQgkAjIzPvzjFih1narD93mJh0yCmFOHN8yKnLk4ejqmRIfWAT3TNRUXYybNAlC5EpxiT9ts+TP/DvAcfUevdW8S0h26rXBKGdl7JgZ2kW0HuqdQtL9Y52gH6pokz8nge/6Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=robert.mader@collabora.com;
	dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785827032;
	s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LgTqR8hX+MSPNZK1/ZnmYeT+jeK9oY4pjRChRQ3k7rU=;
	b=A9h45/RLAnHcnEGuDcLxNPHwcp1TGklEP6xwpHZW9svKcRED3hZD6gdBwEtkSHsw
	oHg67mvHF2W6vbAKEP+cM+xvavZ7QP6GBcTwyfNg8IEDe/xxQFrH9ihYe7GkG6gekNr
	cvmMrcU6d5InLRWQZ24+iaopqdaIXsSUaIFergx8=
Received: by mx.zohomail.com with SMTPS id 1785827030764705.228708125434;
	Tue, 4 Aug 2026 00:03:50 -0700 (PDT)
Message-ID: <c6c0e544-5a19-4ca1-b113-c085bab0c967@collabora.com>
Date: Tue, 4 Aug 2026 09:03:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udmabuf: vastly increase the size limit per dmabuf
To: Xaver Hugl <xaver.hugl@kde.org>
Cc: dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 kraxel@redhat.com, stable@vger.kernel.org, vivek.kasireddy@intel.com
References: <20260803144120.11524-1-xaver.hugl@kde.org>
 <2353697f-b1da-495a-b043-7a81d875856e@collabora.com>
 <CAFZQkGyfDwjPuciiOvZM3Ha8Xj+YkgkMaveHZtBK2w_S+Z+Vcw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <CAFZQkGyfDwjPuciiOvZM3Ha8Xj+YkgkMaveHZtBK2w_S+Z+Vcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Vivek (thanks!) just pulled the patch into drm-misc-next / 
for-linux-next so it should go into 7.3 \o/

On 03.08.26 17:04, Xaver Hugl wrote:
> Oh, nice! I should've checked the list before making a patch :D
>
> Could your commit also be backported to stable? I fear I'll need to
> find ways to work around this or disable the relevant optimizations in
> KWin on older kernels either way, but it would be great if that could
> at least be a very temporary problem.

I'm not sure how realistic that is / how the policies around such 
changes are - there shouldn't be any serious risk of regressions, but 
who knows.

OTOH there are several other options AFAICS:

1. affected distros could backport the patch or set a higher limit via 
kernel command line

2. kwin could try to check the size 
(`/sys/module/udmabuf/parameters/size_limit_mb`) and disallow the code 
path if the required buffer size exceeds it (or just have a fallback in 
place whenever allocation fails)

Arguably having a working fallback path were possible would be good 
style either way - would it be a big effort to do so in kwin?

Best regards

>
> - Xaver

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

