Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88469393DE6
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686601; cv=none; b=r0BtjT/pwsmoUN1/MDTxjMg4ECLFxlug2JBMIDnyV11S+RS9S+KXmD+Z7f9sm51AUJaTJ9tvtqdUHTgYvNU0CUtisqY9JBQwVjl3AMxTKnh91oiy7icqs7a/vUih/0EL7v9pqJTWh7+h3CXZndvc44unt19owqYL01prRCbeYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686601; c=relaxed/simple;
	bh=XY2HOqzlG/nYIYo90LYQw8MToNV3itTqKq4/B898JEQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TurVxjPxoSKnVN28uCQBT72Ml0DXoM1z+QehBPQKMiO7r13KfzfJg3UKsfTw4LgWEF8Bq0QMlBWUBEh3WbOa1O3ONhAysEcgEgv2j9z/pfO037F7ss2HONFMb/QhqqevRGurT4riIHzEj9Jg63u7wKDV2aNDi8HBNO7xV0kKfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Vs+ZWAF5; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Vs+ZWAF5"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ggHll4jHxz9tDY;
	Wed, 17 Jun 2026 10:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781686595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+iPxfC5TMMNi1lfsggmVCGZmma3jL5bx6yHG+lPg8A=;
	b=Vs+ZWAF5wiWq2YV0EUiHkvhvN8AJ9PjDn1sYRiPUU2m1P0FOPChyE94vW0/Pg2EBA71T6X
	38ND77wRa+NedDxHKkWQ9d7n0HCMzztjI/VCNyoo8LJrwFOCgsJas4DOKR4B0Srahu39gq
	nnEqldZLltEzPDb1TZsHHiEeILReKwXH28EOF0wqvCW8Lb51MUNjstanKXiHmIW3emNE/4
	iTQoPSFjhZRLjMHulbbM1+U0FHZf8rCfw8yNthD6eZ6tSC4432nxN8mR5i+AeIzRKMxRcJ
	yQ7+0twyeCQ+DD/zWd4TZhUXOFFmvKwBkYKrvzrk4AWTjDLfPaXycTuCyHWUJQ==
Message-ID: <75732f3e-8ffd-4cac-b205-8f6cf705daab@mailbox.org>
Date: Wed, 17 Jun 2026 10:56:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] drm/amd/display: check GRPH_FLIP status before
 sending event
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
To: sunpeng.li@amd.com
Cc: Harry.Wentland@amd.com, mario.limonciello@amd.com, wiagn233@outlook.com,
 sysdadmin@m1k.cloud, timur.kristof@gmail.com, xaver.hugl@kde.org,
 mario.kleiner.de@gmail.com, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20260616201828.389985-1-sunpeng.li@amd.com>
 <20260616201828.389985-3-sunpeng.li@amd.com>
 <a74f1233-d63f-4bcb-a379-3c9a6332cfb4@mailbox.org>
Content-Language: en-CA
In-Reply-To: <a74f1233-d63f-4bcb-a379-3c9a6332cfb4@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8huag9ouc4kdkionuhr7y8aczfmx86o8
X-MBO-RS-ID: df22362913b26cb4cec

On 6/17/26 10:07, Michel Dänzer wrote:
> On 6/16/26 22:18, sunpeng.li@amd.com wrote:
>>
>> * Add a flip_programmed completion. Arm it (reinit_completion) under
>>   event_lock together with prepare_flip_isr(), and signal it
>>   (complete_all) right after update_planes_and_stream_adapter() programs
>>   the flip. It starts in the "completed" state at crtc init.
> 
> Is the completion really necessary? Wouldn't moving the acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED assignment after the flip programming suffice?

Or even just moving the unlocking of event_lock after the flip programming.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
