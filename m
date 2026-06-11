Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F321B9F6
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172780; cv=none; b=NQvbz7/1Ii5+8LfCqp5PUzd2hCWiDec19m4xgKvMZ4uEReD+360OMyF/IGQjdYFFODRAnj2eYV6C9HrCGVVu29xMICE+aY0euOjkQR7ARDK1xEw7fbbo7RCrzcCmyKuQI44//gPdH/+mhd7eJ/h5cgUX9s/w8KXeTBR2q/dyHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172780; c=relaxed/simple;
	bh=JQ5T8Ove8mxcipFoyWUXvQY6lHTB2vT/asE++CDukY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ThMQRVZ/zJdVO+QYADDTKtHh3sZTp70z5RFjX2esDbb4SEfN/VA5PLvHsa8eCbTbE2D96h5eyyAbhdJa/K42l4ue3cZpD0K5mbggkAT/8UR87Gn+gTwi2WaN3/Rc0rQNvItXknIgV5E1/l8bqusC/9NYMFum/9hwq7fNxPGjbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5P8aYKS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXxR86fN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5P8aYKS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXxR86fN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781172777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dFYGrtWClhfZ3Q43+mH8yJXNZwovzAkM0JScXulojb8=;
	b=W5P8aYKSblK3mjJytCe0Ph6MGhk/zYy591McbqpHdtgc5kRUjVo6Uibuz314zqoR8ND4AG
	QZ1jdRPlTX1qhVOO9F9cdF8bZ5grbi+hAWRyio/5e2OaC1xV11HkTD+5kOQc+/i2izSCKz
	Lv5uu5PjTZJCM4Xe1rB06/6F5cvl1TA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-MrKkpy2qMJScq3B_kdQP6A-1; Thu, 11 Jun 2026 06:12:56 -0400
X-MC-Unique: MrKkpy2qMJScq3B_kdQP6A-1
X-Mimecast-MFC-AGG-ID: MrKkpy2qMJScq3B_kdQP6A_1781172776
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490bfd70b0fso78222505e9.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781172775; x=1781777575; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dFYGrtWClhfZ3Q43+mH8yJXNZwovzAkM0JScXulojb8=;
        b=MXxR86fNpMK2OJliQ1xWyAYroB+y4pje2MzQ2LzDglJfeX9+gsikXoQmeyrFdzpRsb
         YEE/VR4MBldAruYqG+EdchGJ727Kfox2A+AgqT6XpMDo1hG+uQaL+6DUMOEAox3jv/Nn
         vHd5Dp72LumCHe6v7UHqD8WhymbA68gHwyYYBEbNyzeo23AAUIYxYDSZixmkjEXxkhhk
         JeCDMrvLi8p6+bAKDs+X3/upH7KmN7phxBGQydi/Rm9kTMiMZbe47aEfvg+f7sVSp7Ch
         cQaQBKOSKT8gHifd2WR0gd7BHj8a22rlxPHo5fFoKS0MONDKI2+RVyxLfDaRxyrvDjs8
         cqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172775; x=1781777575;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFYGrtWClhfZ3Q43+mH8yJXNZwovzAkM0JScXulojb8=;
        b=XHW2LlD2GQoLR4Uaue9fjHHO65deVx1+le720CmHurJS4jmOMk4Kwu5Pc66V6zu8GP
         jm/1M8XHGN8T0oL3LEpbAH+88RqgJMD8p5JdUvm5mmQ78SQV4rk5G1u0uPpfz4SW/QOD
         XIjjE47JlWboFI6LV++C8arWeYB3993rPWo1uLIPk170aOof/QkywZ5hTELl1eWlGJni
         rzFGjUZLXR4hct38KPBKO3xK5d7GhOLZS4RQm8KdQvU/+Q2j3smZzSYyH2Qm4kA+++rp
         ZXikiyKWo0ZifRa2DccX+XS5+YpMuO/LChkdTV/UhShPZ1RUaAi/ZRtlwnlzg6yLlu7p
         curQ==
X-Forwarded-Encrypted: i=1; AFNElJ/K+Z/2aySGbhB+tR3oYgPVxHly+2kuz9SObutmS1M5WqUSPgSuNj7rDrIB7QPeC1QXURvVeow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNo6zANSAxZWrwLaS+BCLlcgsBj7h7skj2dYwe+TvoaYDjSM55
	mF30K2NJVQKd9TKwEvd9BFfoVv7UNlqNSrivsdpJ5868EVQrSU4GW3aONQUkRRlNOG7lCJc9xAj
	f4StWfUym0y5qubHmPNfjj3BeFpG/snEDZya9QBsTcSgUJCHhDwcoGZt0PQ==
X-Gm-Gg: Acq92OHh0mZQj8je4aVdHI4T3eGOvIpRxfN+YeLVONr0bqJihqVC733Ns0gY10J40WB
	BmpNX8HlKYMPbfan1Mas8bm/8krYkkNAE3BpvFqt/4QWguxDIckgPBQmWbB3YBK4psM3DY7lwKI
	dSJT0WqIO56IJpPoC3WxppSl+/F+HiXDYpya5HWSSFOtITUcO6ZurnCW2me5jzj65Kz+3MBkoHZ
	ycgHD8hggZzjJLgatnzEu+4DzipeJV70x4yGQLE+tvc5EQunBTb0kenxNfw0PM6ugslTN2qMvcV
	xhV0MXASEhyFLi+h6yhY7vAIRzC9IgpQ4gK4vqG/YIaQMwMJnhSsyBVRzrw91Y9zyGDY18INUn3
	zzRLfEA3B2i3nyVNsGO3Tkd2sCmbeMiuUntogx2utK8nG+5bs39wohm+YKhUnysnoblSQMoOZB6
	pUvuyjET5sUO+Pj/4=
X-Received: by 2002:a05:600c:c493:b0:490:a298:3859 with SMTP id 5b1f17b1804b1-490e5639bf0mr26218625e9.24.1781172775416;
        Thu, 11 Jun 2026 03:12:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:490:a298:3859 with SMTP id 5b1f17b1804b1-490e5639bf0mr26217975e9.24.1781172775016;
        Thu, 11 Jun 2026 03:12:55 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e532c778sm38051805e9.14.2026.06.11.03.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:12:54 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklkml@zohomail.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Zack Rusin <zackr@vmware.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 04/15] drm/vmwgfx: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-5-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-5-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:12:53 +0200
Message-ID: <87pl1x5qsa.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update.
>
> Test the flag in the primary ldu plane's atomic_update and do a full
> update if it has been set.
>
> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
> to ignore damage clips") introduced ignore_damage_clips to selectively
> ignore damage clipping in certain framebuffer changes. Vmwgfx does not
> do that, but DRM's damage iterator will soon rely on the flag. Therefore
> supporting it here as well make sense for consistency.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

