Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E683D7D8C
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774711; cv=none; b=eXFMQFUKzjOIk9Ax5qO9/7DlSHR9ovCQas1RKsniqI//T1T3Zx0Q/SzsJv2FxNYCMjbGdo20bg/ARZ01++jCE1XywDJJQTZNRnQuVUfGSDJs1SpC3bmeTDGoDEBbEoUq5n4g0CKTK9DMHS6Y1Mnm0pLkODXotqEfOO5c/FmlpSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774711; c=relaxed/simple;
	bh=urG1iZTE5pMhTITDBPpLAnh71/kpYVN05V0eeMNJzkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/T2InRqdsiYBQIU4ljXG5ZBmQ1obDTC19ns74gT6ge4J8PfnwSs6pv50yFZmDB9g9rIhgIQJUpObAbR1unFrKAEdSIzG192ztmahMWAwNeKvhHajthjh7UxiS2/QcnKaEStOB7mWRk5G2RsQS/nYgJUY5U5aFWTCa8CXTK52cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qTAvaI3H; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qTAvaI3H"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ggwKy2sknz9tsq;
	Thu, 18 Jun 2026 11:24:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781774694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQyI2dSUVTbIxU9Z89sIcmzDm/G1DUgMHNgWI4ZJ5/k=;
	b=qTAvaI3HKCPIAYsKjyBofzfFDje80NOiTqnRWVgGELAxvZdo3vL4ARJhwNO/BP0uhxbcQ4
	XaFoZoXbAFpvBBJOeEBjbl5utDzlPLQEp5XHPDJUUsxdcGVKbUw/XEcEuzwTt15SEcEv+b
	kH4PLI4gJ0Jzp3xTkGZ53i6iJKuAe/qm8OY1fMyaiiRy9GWy1QSL2h+kfmN67niTHIB7XE
	TJuKKgoSCTZupEfDs+9KPPNFL70RV3rRuMcJCJmembYPcWBIxpJzXfDRWI3GiMxkqw/1Tg
	FIZYIkzDoEAX2EyuKJJa8dLEDjEdBoCQFabTSBsw/ZYI7vphhPv6fwc2xbxfAw==
Message-ID: <d177cd76-4f98-4a23-b461-5fc0c0dd521d@mailbox.org>
Date: Thu, 18 Jun 2026 11:24:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] drm/amd/display: check GRPH_FLIP status before
 sending event
To: Leo Li <sunpeng.li@amd.com>
Cc: Harry.Wentland@amd.com, mario.limonciello@amd.com, wiagn233@outlook.com,
 sysdadmin@m1k.cloud, timur.kristof@gmail.com, xaver.hugl@kde.org,
 mario.kleiner.de@gmail.com, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20260616201828.389985-1-sunpeng.li@amd.com>
 <20260616201828.389985-3-sunpeng.li@amd.com>
 <a74f1233-d63f-4bcb-a379-3c9a6332cfb4@mailbox.org>
 <75732f3e-8ffd-4cac-b205-8f6cf705daab@mailbox.org>
 <7bf196dd-c43a-44b5-91e2-ee7ab40fd6f5@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <7bf196dd-c43a-44b5-91e2-ee7ab40fd6f5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xun9c4djyi6xzuuhzar54e78hjto4g44
X-MBO-RS-ID: 50ad6863b3a1faeff7c

On 6/17/26 21:27, Leo Li wrote:
> On 2026-06-17 04:56, Michel Dänzer wrote:
>> On 6/17/26 10:07, Michel Dänzer wrote:
>>> On 6/16/26 22:18, sunpeng.li@amd.com wrote:
>>>>
>>>> * Add a flip_programmed completion. Arm it (reinit_completion) under
>>>>   event_lock together with prepare_flip_isr(), and signal it
>>>>   (complete_all) right after update_planes_and_stream_adapter() programs
>>>>   the flip. It starts in the "completed" state at crtc init.
>>>
>>> Is the completion really necessary? Wouldn't moving the acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED assignment after the flip programming suffice?
> 
> [...]
> >> Or even just moving the unlocking of event_lock after the flip programming.
> 
> I initially thought about doing so. But the possibility of update_planes_and_stream_adapter() sleeping made me think otherwise.

That is a problem.

If the flip programming could be done while holding event_lock, this could be made 100% reliable, avoiding the issue below.


> I suppose the worst case scenario with arming acrtc->event/pflip_status after programming is we deliver the event a frame later than it needs to be (which is also the case with the current patch), thus stalling the next commit via flip_done, and making userspace think it missed the programming deadline.

Yep. Hopefully won't happen too often in practice?


>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index 00f7a3b445ebf..571198c46c0c2 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -4384,17 +4384,17 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>>>  		 * from 0 -> n planes we have to skip a hardware generated event
>>>>  		 * and rely on sending it from software.
>>>>  		 */
>>>> +		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>>>>  		if (acrtc_attach->base.state->event &&
>>>>  		    acrtc_state->active_planes > 0) {
>>>>  			drm_crtc_vblank_get(pcrtc);
>>>>  
>>>> -			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>>>> -
>>>>  			WARN_ON(acrtc_attach->pflip_status != AMDGPU_FLIP_NONE);
>>>> +			/* Arm flip completion handling and event delivery */
>>>> +			reinit_completion(&acrtc_attach->dm_irq_params.flip_programmed);
>>>>  			prepare_flip_isr(acrtc_attach);
>>>> -
>>>> -			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>>>>  		}
>>>> +		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>>>>  
>>>>  		if (acrtc_state->stream) {
>>>>  			if (acrtc_state->freesync_vrr_info_changed)
>>>
>>> Pulling event_lock out of the if block doesn't make any difference (other than locking it unnecessarily when the block isn't entered 🙂, does it?
> 
> FWIU the crtc_state->event pointer itself should be guarded under event_lock, since it can be NULL'd concurrently.

Gotcha, I was fooled by the acrtc_attach->base.state->event disguise. :)


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
