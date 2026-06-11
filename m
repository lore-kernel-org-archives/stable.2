Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB13D16E7
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175592; cv=none; b=nBTRg4bb669N0uiFkPhNtGM/uEtJ83juj8i+V0QQ90+ZZPTIhbSKwoCw/nTQuF3ef/U2D5HsBDTlTAkCi9SdEMNfks4trzdangWqBqXIInvpRG5K7SIsr+tllLnh072F8TZxOu6IZ3VznVXBV1P1lKlJVXDNmaR5LzL5rd1k2MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175592; c=relaxed/simple;
	bh=ifamMReb0BWhkfjGxF//h0cAx/mHBlMkmlRIFK0occw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IMlixFiBMLl9hyystRb4XXnVujNDlsOsHLgwfKAGcm6hRPgE8DTVF5BiY10la5QQPBvoiGXQxNqarisAbRxhRzOEy7YT5cLPgQMSLbyQLmss2teGERfpoWR7hYIIJKUpB0qHoVmTRRLklNG3+UnEmaFjpIIitUbK9/zfPqDNe6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQZ5RQXx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9dSaYII; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQZ5RQXx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9dSaYII"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781175589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OE5i5Cs1x/Y1/tYzMUIth7XXWL2BCwQTkDQ8GlOHrbw=;
	b=JQZ5RQXxJXFjeIuUWy3FD0d3RyH99GGuJxKPjQAaFwJD1Aja9HGPCt9KzxRhnrCcj8d+3L
	tTbBwgehNPH/95FDLdfXJjMORDGZWhliIp0kcBX5peB4xfu9nefxSe5apBja17v9Gmn6xS
	X84JZdtj0zl1KaUEgxXupyezT+NqtR8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-rLen4dCoMZmX0N7yykqDew-1; Thu, 11 Jun 2026 06:59:48 -0400
X-MC-Unique: rLen4dCoMZmX0N7yykqDew-1
X-Mimecast-MFC-AGG-ID: rLen4dCoMZmX0N7yykqDew_1781175587
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46010bc0f1eso4681354f8f.3
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781175587; x=1781780387; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OE5i5Cs1x/Y1/tYzMUIth7XXWL2BCwQTkDQ8GlOHrbw=;
        b=W9dSaYIIViGuSop919c8zZJHNXYQPBQUrbxXNpvTsE9g7Rlvbk6QnzEPAIq8ebuDMg
         mWWXpiP7y/sEzWgLErq2MWqBjplFi2vecc4yMgr1sNJPmWKI/UUEbKI2Etc3Uqs0+1Gw
         nj0trW25t7JtMkoy7lahqLX2X0g8QWLe0d+gllhYDYiB5vGsPvjN/AnQJnDlEFoGXdcb
         mqPuLMcBIAwNDzqyOrRUZdTRNcyq1Zzl+6kcy1iH97GFr6GxmDrSbie3RjUT1xocX1Kv
         5bw5ZWYs5NTml2Th7nNMghtGhpEnmR/kBtel69HQISubBILKk1IvcicsKMjTT3pppVFe
         DbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781175587; x=1781780387;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OE5i5Cs1x/Y1/tYzMUIth7XXWL2BCwQTkDQ8GlOHrbw=;
        b=gyWHPfshYacgCUJ6Hw/0xYGOgB3LqvUplnM88blTvNGfVZ31xjVtqHRJgqO+ninrll
         IUwpufmd4sZduAPs8ZnUep2WLAW0Nhk+RV08xr6hUqcv4cSXuqs0z7v5f+K7Ijc+tNwi
         BKCr+6QPHA9kSM4uJNlE2+59WbPrS1I3knT2vHjcW1yeoEQyb6cbolXgl5WpTt33VvwX
         2sLGITAOhitZDh+pk4gueW/FOMUtLCdGPx4bDP0oNmk423ixBCSsWcWI6Gat2g9Xaf3w
         yyEWT5jtkb5+AokdOxuLWLqY9nljl41NJzCFiTbiRbhpj8VQzAxfaYerh0Ekm4lccT26
         fY+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+xO1wAQzQ50CxYCJGARoyFf/9xFjij2T58dwpz2B9KnOJDLMndf3toSg/yKgiR45wz9ZgtiSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2yecibZwxWtPy3yWkMcbyfCmQlt9k9ZaOVfMSzz+20c5GCbdw
	GJmvxvIn0kY9mZyjZPg4oLhyZPQFJjs3zLzvwGz2Vf0erUa8QycXBSfghnkBDOwAC8Igxb1+cYF
	tPHAu/UNIatGw/Xrz2FIMr1RLZYC60vpH0N+IwRne6zkTtqklXrpFMtnigg==
X-Gm-Gg: Acq92OGg6kR/dWpVR+1qtbFV7t2MhT4MKmYZIy/snRViFo9SyLfnC4saLRWyhGoRtY8
	w2Mue+DndJkVAvazxGiRI01Vr/ToJI3j5XJBTSI+O5ejn7QvfICggCYg/CAFdh9x2mO/bLHKoXX
	fQHITGWGkoPrTLUhZN2D3SehMAH9TEQDsMdUM5hv6sdcSizytxIXkll7FvVBgMUVLwF5MOOA0hg
	TIrFoyOpGHcJrXs4WZw/Y8+yl1pG/Cw+Qxti9W/uy/sazXuM1lg6zlUjVhI1vdX3NgqSK5arpj3
	BoNxC47WeoJNtcIrO8k/9BZKMn0uu0ZE3y7fSAJsl+IEjQ/rxrbGiKctZObakeZ5yAF7hsBhPvA
	kW9oHBhxKvvlU1XlhuJ0N55bZ/YLYAbDxGCpVGpnA4Wv85E+GaKpVykyND9QHFMVhL3XhhwqjUU
	3qJRszbHSHIOtDBq4=
X-Received: by 2002:a05:6000:710:b0:460:1c5b:f25f with SMTP id ffacd0b85a97d-460677b1af7mr3240521f8f.20.1781175587102;
        Thu, 11 Jun 2026 03:59:47 -0700 (PDT)
X-Received: by 2002:a05:6000:710:b0:460:1c5b:f25f with SMTP id ffacd0b85a97d-460677b1af7mr3240484f8f.20.1781175586716;
        Thu, 11 Jun 2026 03:59:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm81947989f8f.1.2026.06.11.03.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:59:46 -0700 (PDT)
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
 amd-gfx@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 01/15] drm/amd/display: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <45aec54a-ec80-48ed-9bcc-84e7bccc11eb@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-2-tzimmermann@suse.de>
 <87y0gl5qw8.fsf@ocarina.mail-host-address-is-not-set>
 <45aec54a-ec80-48ed-9bcc-84e7bccc11eb@suse.de>
Date: Thu, 11 Jun 2026 12:59:44 +0200
Message-ID: <87mrx15om7.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi Javier
>
> Am 11.06.26 um 12:10 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>
>> Hello Thomas,
>>
>>> The mode-setting pipeline can disabled damage clippings for a commit
>>> by setting ignore_damage_clips in struct drm_plane_state. The commit
>>> will then do a full display update.
>>>
>>> Test the flag in DCN code and do a full update in DCN code if it has
>>> been set.
>>>
>>> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
>>> to ignore damage clips") introduced ignore_damage_clips to selectively
>>> ignore damage clipping in certain framebuffer changes. This driver does
>>> not do that, but DRM's damage iterator will soon rely on the flag.
>>> Therefore supporting it here as well make sense for consistency.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
>> I don't think that a Fixes tag is correct here? Your patch series
>> is changing the 'struct drm_plane_state.ignore_damage_clips' and
>> the changes make sense, but definitely isn't a fix in my opinion.
>
> But shouldn't we have added this test in amdgpu and the other drivers as 
> part of commit 35ed38d58257 ? Sure, these drivers don't use
> ignore_damage_clips, but it's still an inconsistency wrt damage

I don't think so, since the original scope of ignore_damage_clips was for DRM
driver of virtual devices (namely virtio-gpu and vmwgfx). These do per-buffer
uploads instead of per-plane uploads, and so there was a need to force a full
plane update if the framebuffer attached to the plane was changed.

Your series are now extending the scope of ignore_damage_clips to be used by
core helpers and force a full plane update when doing a modeset. This makes
sense to me but it wasn't the original intention of the propery and that is
why I don't think that should be considered a fix.

The only patch that IMO is really a fix for commit 35ed38d58257 is patch #6.
Because is true that the plane state ignore_damage_clips was carried over
when the state was duplicated.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

