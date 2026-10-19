Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424539;
	b=BoNiYuhs+DYoJfH2RV/wHV4slDh4rZ6Bvbm2GB00DO0Xwkku9/AvJRu5/hmddEsfG75c
	 Rc2oEhiY/A+GoIi13MpFYr1oq0sehKm5uIXCYtHZQ5Oi7iB1roENPbfm+2+KbjCOWT1oR
	 COddjiE+k2Ck+zrKm1Ya6lo9O6trLRdq+9MTGkUs/q8Ci2crOV+xmV/2jeCMa300UajsG
	 a6X5mrsAu4N1YRNaj1EALoct0LlO8Aj+zsmE2vUWJXNNKXE711Xt8f++TKDvRlypQZwLm
	 gdmOk5XFs895/5rZ9wnWadfKSOixf383Em1KTTfFTWXLtYGATEAPbRZHR/EEJsD/8yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iMgrhjGDM6hEQh8Aw9yzZbHzALMwxiGfaVEBL4NiDa0=;
	b=0L8TF0D7OvtMVLGMXn+pBvkxAAl0YRjTNHK3GrktzAc2wKyhcKoGDkV/vEIKkzjQxn7J
	 rvoBJUEOpTOq/f2OAUHSkSVrS3DiJqbmIqbnUp5SDT9xEA5G4lBCuuYAyJvUKGWkvNKZs
	 t9IzsJaUptoJSmXa01VK0+rE5JqCnzu+Yx8stPPMuFRJzp8yCfZKkOthYgX8bY3np35Te
	 h3G8Qgo4HKA+yzYU9Sl2XItHXbCVIMGydMFP8zJyBa1MhNKbjKdl8zqt05AlF4ib97oSD
	 WkfTKGE3LBiR1LW3PdGiiZTXPDUJyigIuuxugoRtyHu1EuJTLFHRmR7WTiz8S+Gav/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtrAjbZ7;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D586079D67
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57D586079D67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtrAjbZ7
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc758830601so1556103a12.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792424539; x=1793029339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iMgrhjGDM6hEQh8Aw9yzZbHzALMwxiGfaVEBL4NiDa0=;
        b=mtrAjbZ7SAOmcOlZpgZxkhF3asxHxfJiQO3A09sNBNjc7sZcnqZ8/tI8OPhNsV76aL
         icwHtvXRU8zBKnGPZBb8g8/atROCdBAspRO3AOnTaGDloW5UL1AOKpaCJgfFA0w61vUt
         Wb6OWovFSxtr/1+hN3+q3+/ImDqABvueQrSaunej4SdbfvoDodpzUp3Osj1Qw9PdvBY3
         Fd1GKV2p+YYThzzjPGaZ+cjSiaCCN9iUM+Yz95vkA71FreJNIZ1JM+VsZ1kT44ehlZy2
         hgfjd37pjAxY6+EaGK0TzqFpaiZIvSdFGjXfbDIrCMGIkDkngyQji0Dmd7OkpBImGojh
         pUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792424539; x=1793029339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iMgrhjGDM6hEQh8Aw9yzZbHzALMwxiGfaVEBL4NiDa0=;
        b=g+reQnxmSUUf/Ozb/VtMEeXZNAj6H9uE9UzLX59jdw8onMjxhORRm0dtpVVrJu9bFt
         c1Y3Ba4Nx6Orv3uUx6eCJmYfLEI87xjy5GzNwscgzQ7TY2ETSiJ9amSrfJyZJIolmno4
         aEwahmWgk3WvggJFrOQWsues7nLJW3G0V1UUDKQ0U1eUBikiL7JDDJlIjv1IfgVL88EF
         mzCtBfUvdO0LKH9VmVzJZkxQARwq35wXLPYGbNFHdtdAatBQL1ay4KbU4XwjzPDteizI
         AFqzbzxaUjTrHghjV/ewE0DjDpy8QgFYDhNH6bcRWnQlBNkE4VAcXRaxmg9EIRpU/wXd
         KPsQ==
X-Forwarded-Encrypted: i=1; AKwUvByggAgX6s6Qjv/lI/YD1s+n/K5HWK7zVuJyS+qUb7MllhNtVdGuSVmeiPvi6eW5S/D4GvV62NI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJS9UTdQkGUgg1Xmq8tooPiGJeIiITZxEHOLkCEN1g0C41siFAf
	T1FjtaWuMyW/Ei+Cuua28TMz636YsUCpF1aqXaQ7ZIHnKI2UV5SYq15G
X-Gm-Gg: AYBFou0Yr50czOLQM/O2PA4RU4qm13zqSm5VX9B2lQTeD5QuLAX+fi5QrOR5r/GTXRg
	rlDDST6PswT/S7MBy5W0d1L2C61Tp8QHWzkuWsiAfY9YuU2ynHXQAaCYhUvaCWu57N3CfaVLHNk
	+nW4qEb3uUqdYgJzfg+I6PrYfVOx7nBS3L0Nb9BxES5AvOiUkDPQNwfdIxg+9gpr7JZiBaytfT5
	irURk8tSSId4G9MVg1+mZb/2rYwgDoZq6KOITuI+/elwqRyWCff2whWfac2Bt7UYVOnQTprChtl
	l3HGx4m4rKenCyktNEQLUfkSdedM5ysZC3c3n1f22Rzqb5oUFsWkmHM7fP7YW8XzdcGeGRXjwVO
	L5LTXT+uP0HRc5uHTH3AlwFuyCafAGt7Oc3J3eQoIzHY/Ep6XkRY8HUR12xuuwlREDIFVwR0B9S
	jWo7FoAXgdc5QZJBmXM8V3NjbW7/L2FR6+X0edhKQETyJ3p1uR9v7jkij119INA3ZKxhfY
X-Received: by 2002:a17:90b:3d4e:b0:3ab:2c2b:1026 with SMTP id 98e67ed59e1d1-3acef0c8911mr6398917a91.34.1792424538542;
        Mon, 19 Oct 2026 08:42:18 -0700 (PDT)
Received: from hachimi ([101.5.170.156])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm3926364a12.20.2026.10.19.08.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 08:42:18 -0700 (PDT)
From: Lanfeng Wei <xlfylawarthur@gmail.com>
To: tzimmermann@suse.de
Cc: airlied@gmail.com,
	decui@microsoft.com,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	longli@microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	regressions@lists.linux.dev,
	simona@ffwll.ch,
	ssengar@linux.microsoft.com,
	stable@vger.kernel.org,
	xlfylawarthur@gmail.com
Subject: Re: Re: [PATCH] drm/hyperv: add a parameter to disable the vblank timer
Date: Mon, 19 Oct 2026 23:40:43 +0800
Message-ID: <20261019154121.6257-1-xlfylawarthur@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c238f4ff-d5d8-4a9a-8773-793bd9056c9b@suse.de>
References: <c238f4ff-d5d8-4a9a-8773-793bd9056c9b@suse.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas, 

> Yeah, what's the cause of it? Switching off features does not fix any
> bugs or improve the status quo.

You are right that the module parameter is only a workaround for users
affected; it does not fix the underlying scheduling problem.

The cause is that the synthetic vblank timer is used to pace completion
of atomic updates triggered by dirtyfb, in addition to providing
synthetic vblank events. In Xorg's software-cursor path, pointer motion
damages the primary framebuffer and the damage is instantly submitted
via DRM_IOCTL_MODE_DIRTYFB. The Hyper-V dirtyfb path performs a
synchronous atomic commit, and with the vblank timer enabled that commit
can wait for the next simulated vblank. Under continuous pointer motion,
these commits dominate the update path and delay normal client updates,
resulting in sever frame-rate drops. 

This particular regression results from the combination of the blocking
dirtyfb path, synthetic vblank pacing, and the absence of a Linux DRM
cursor plane in Hyper-V. While the Hyper-V video protocol does have a
hardware-cursor command path, the upstream hyperv_drm driver currently
exposes only a primary plane. Cursor plane support was deferred during
the initial upstreaming [1]. Without a cursor plane, Xorg has to fall
back to software cursor-rendering path and it competes with periodic
graphical updates on the primary plane.

So the proper long-term fix could be adding cursor plane support in the
Hyper-V DRM driver, which may take some time. Providing that the stated
purpose of the offending commit is to rate-limit display updates, while
its current implementation regresses the existing software-cursor path,
I think adding a switch or reverting the commit until the requested
features in the driver is ready, is a reasonable short-term fix. 

> We had another fix for a problem with vblank timers:
>
> https://lore.kernel.org/dri-devel/20260914110004.211027-1-tzimmermann@suse.de/
>
> Did you validate that this fix is unrelated?

Yes I tested that fix and confirmed that it is irrelevant. It solves
issues with excessively long frame durations, however this problem is
found in normal frame updates (in my case 60Hz / 16.7 ms per frame, way
below INT_MAX).

Best regards,

Lanfeng Wei

[1] https://lore.kernel.org/dri-devel/20200622110623.113546-1-drawat.floss@gmail.com/ 
