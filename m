Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219041A4F6
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786808388; cv=none; b=FePEs3BvgKPRJnOxuGDJIecJ0M0WHc+IA69lwXoxEBN9rDiJheOfG+uMd1DXtxVXc6uCSjb6QGcXT0kF066XfXZPwcE9VPJJYNcZ24OM4tAffyXoofjfV9Uc3XeZUZjLHCe2vK/0SBy+deBpIcK1zVdxhSULzEVLHnmbiD/fsBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786808388; c=relaxed/simple;
	bh=jtNz48xCi0S5F6jkuyRThkivP3pn+Gi7R3SLLhEvaMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhktsOF0JPCQQq0ctooWIs1poE3GRYB9ut3/6u6YzyFMaz/r8VJtvgTkJUJyRKBB8qi60X6ai97qmd1t4p/ZADSLW0Y4GsxXMsDZQ2TgQH81WExEmoOo/Q2XDMibIzWgZbC8nE+K9v0e3xAdVdL4jJDMf1/M+IlSX0ZTt0OpWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQmCeMfO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQmCeMfO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4956869750eso13766435e9.2
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786808385; x=1787413185; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=63FZWuPp/rokKWnhrlhEyVlpDgyE7yf/8PcWB4UXVa4=;
        b=jQmCeMfO9SHqpXfswM/L9c/Pk4/Ibj1MSEWN3Hq0fCToirQxNNqHkiRKJM5PhXAtQm
         tLpds/hbqlx1WgP1b/neDCJ3JYSs/bWPxB/f9j3bg+PApcbGO7/oB13kVw1z1y+rVFn9
         Vh8Q7xOAYmXJuNeeauxYMSyIXr+nMbpI3bs9m4MU1mXBkSYabodH2d2uVhfMEJAcKGjR
         BipgEHEo6Epr1YO1IBTgvi7F2BrBjRRMav7QsPz9q8T4Q1llV9qfUKl3xpagTb3liur0
         mM9mURw397srSrRYafB3l0twekvXp14+M7RYs0QZAPtARtcvX2uPP43IdhOBUMQgJ+Ep
         nsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786808385; x=1787413185;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=63FZWuPp/rokKWnhrlhEyVlpDgyE7yf/8PcWB4UXVa4=;
        b=FCD0dierrbA+HA1bvmEGA6s2ELu0xuuQ4taTPKTGXxe182LvWSBHb0AJ7oQKS9Flrl
         hc8KVMbLryq20SUGDqDts3DTRg/X15yz6uJXiixxZvO2R7LicPXv/bU2tSWKQOWAbAat
         DCo1Jt6rktZu2upaWA30vHzu3qP0b8HQTwagxUmmkL6oiVF8+M3wFaJ67Bvazk99l5d8
         oAkQp5MasC+CltSFv7WLGDHsFR+OnOpKtdT6G1IAYwd49/5wm6pcNQ15/1yNkcAJPNSh
         i48NnXtDOTYDMAG/Dbf4twfqGp46Mu12cywmnJX0VrOmM7tiO/LmMJgQOibwKrAmzZdr
         twKA==
X-Forwarded-Encrypted: i=1; AHgh+RrbnrwUJLAf+gafJV4a0lBDDT2pqZRmqqoZXVwjLaTDv3Xutj6X1eQ4LOwi/EKmWV82yQjkKuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2XfDnyPPAk+sJwMLZeMA1hYJtVaLBjB2A2USyWZSgrnJpCAL
	TcQvyRotLVPYaDNvdAuTDY7/U+aa9sRpeJKjpQ5mAcXrvom+7UjYU+dU
X-Gm-Gg: AR+sD12iurVL5M1+iopReTRTuzjSRLmDCFZbuMI3pt148EAXc6AxLshHEUDFsN6SU6m
	OqzJN42P/2SEJ4tDc/DIj4qVWP/nJ8OrjvD+7kcUpwDlIUtOqGlnt+QE4+6yuuoBHMmsZ48muSB
	aQ2thTiono1bUe3Rwvknkn4tvZg06tpVV7d+JAPkfo/mE+ybKurGDMymxUO4BNMUDSszLueDBOQ
	3t5UUwLUeNWQzjFEd0X/J2YYHZLWg3pAifRLHyvZ5RnHF2uIOr8cscYLqd0HTv6kdmitHPqGuMm
	ebgfZ8ZzpeKvBbaNj2QuPMGppo0XZ2/rbsgieqSTLyhPgiV8XQC4wi3FVcSe9qv/0XoDJRINMxq
	mOrWncWzY0oN4mcRCvGjDMOyoPXPhwvvlsEbEIsEac82FYup6DRQpSGQLphH22YnmnnDlwMQd8t
	U/a1Z/oXR6A5m5D4GZzN3o56jvEe5y6uLX9CU7NdFt/9hZN/mQpPR43srMtSZAREDFq23aGtG4s
	b6tnNuEnsx2MLBdDZyNGT0HSyzq29q2bR4rCVc8XaUYIJk4Wv3nh1R3sc3mtPtQ63h2C55EIAr2
	SwPhO/gabso6DQZATchnYu1rzoBjk07zcxGTXM+7GxMd7Gn22wnZvuz8ipybyQCJYw==
X-Received: by 2002:a7b:ca57:0:b0:499:8777:ccba with SMTP id 5b1f17b1804b1-49987961b86mr146990645e9.12.1786808384630;
        Sat, 15 Aug 2026 08:39:44 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-aecb-d601-fc34-eb31-14a1-3704.310.pool.telefonica.de. [2a02:3100:aecb:d601:fc34:eb31:14a1:3704])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b24746sm259187945e9.12.2026.08.15.08.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 08:39:43 -0700 (PDT)
Date: Sat, 15 Aug 2026 17:39:42 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Fix NULL pointer dereference in CPU job cleanup
Message-ID: <aoCH4xjqTOiZc0_K@gmail.com>
References: <20260815145914.84154-1-kmehltretter@gmail.com>
 <cdfaab3c-89b4-470b-aae4-d16f7aaf18ea@igalia.com>
 <aoCEGJXl5k6IrhT5@gmail.com>
 <d3aaddb2-b7f7-459f-b80a-e2c4f7b3d87a@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3aaddb2-b7f7-459f-b80a-e2c4f7b3d87a@igalia.com>

On Sat, Aug 15, 2026 at 12:26:37PM +0100, Maíra Canal wrote:
> ATM, no, as the fix was part of a larger refactor in V3D's submission
> code. Have you faced this issue in any real life scenarios? If so, I can
> think of a way to backport it.
> 

No, I did not hit this in real use. I found it while looking at the v3d
code and then reproduced it on my Pi 400.

So there is no hurry from my side. Please decide as you like.

Thanks,
Karl
