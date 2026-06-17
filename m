Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51A3364EBF
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686496; cv=none; b=Fjqz+z37Rt8xn1GlSu6Ux/xxZa3ip+93y4r85XXX0OKGE3IiyIbPPIUQQoV15SzUgK1+V4rBPDaxWbr2Qcdekl7RzWiNRhH09LWZjW3NhRnIjYk/1EgkVNHKP2W5sW/mo7IgY9EDYmuGgRxudiwuziPxa8skoqP3tGpB1TFB8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686496; c=relaxed/simple;
	bh=ESMwUbBb58blTKfxbAvXVh7cgSzNJA2y4c5yV1z3x0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lk6yiC5CaJa2Q+BY1afVrw5qcPoNeLHRLsrJ//O4VWH0MUblJ7VR4JqxOs2Gl79VW3iw0EdikLU/jfi2PB8ZXBZ8Xs3VXokW9in7BkeqxELK3VZiSt+H1ZsNr3ra7WVy5gqL0pMpPeigyrfEh9KppIewc9o0SV1noQDNYQQFihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iArlWrHW; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iArlWrHW"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ggHjg4P44z9v8h;
	Wed, 17 Jun 2026 10:54:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781686487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RY/xsByTrOU91RetAIh8oOO6g3ivb2EbISGMITVzFDs=;
	b=iArlWrHWUoZ+jqjxV/71Fo8A+C1Tq7Gl8KPUlxNMvFTA0IGUiY9EfyCdEkynmqsUhf++0E
	ayq1H3oSQI/adPQ62D45Im9utO54Tq+nOqraJLaKMJCznisqREhfW0z7E3Aqjtn4w2j9ka
	CdAQDMxewFA5UWTO9cRyNuBFdBIOTZL3psSNrnvs1rXHM4OMROOIwO05jSwfhy+54Vg38p
	j5HgDIO9idMuJZmFhtfVFujpYkIVVyKeXBh4RCJ03qkSdwRVCWXalSbWPN4SOfx6oY3VjD
	8RPJVs5NKBx5oX98rpc7ypIz4P4qoJ6RVBLW2IT9wC20Mb1vEgtFtzjqPgQY+Q==
Message-ID: <4e3b5744-e797-4026-aae6-e2a4ec49d905@mailbox.org>
Date: Wed, 17 Jun 2026 10:54:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] drm/amd/display: check GRPH_FLIP status before
 sending event
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, mario.limonciello@amd.com, wiagn233@outlook.com,
 sysdadmin@m1k.cloud, timur.kristof@gmail.com, xaver.hugl@kde.org,
 mario.kleiner.de@gmail.com, stable@vger.kernel.org
References: <20260616201828.389985-1-sunpeng.li@amd.com>
 <20260616201828.389985-3-sunpeng.li@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260616201828.389985-3-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: eh9fs3zibkf6fj435aya7dt83zcug9o6
X-MBO-RS-ID: 3d650d757189b9313ca

On 6/16/26 22:18, sunpeng.li@amd.com wrote:
> 
> 2. There is a window during commit where a flip is armed (pflip_status =
>    SUBMITTED) but not yet programmed into HW. If the VUPDATE_NO_LOCK
>    fires in that window, it's handler would deliver a flip event to
>    userspace before HW has latched to it. If userspace then renders to
>    what it believes is now the back buffer (but HW is still latched to
>    it!), it will cause display corruption. (This issue seemed to have
>    existed ever since the introduction of pflip_status.

AFAICT this issue was introduced by 1159898a88db ("drm/amd/display: Handle commit plane with no FB.").

pflip_status was already there before DC, and AFAICT amdgpu_flip_work_func has always handled this correctly.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
