Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D839A4A7
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556628; cv=none; b=nxmZum7/lq+ECMTdF+avKCCerZVFCYLsoYQEuypZrnkyrhIacygMUJMarx7h4by1hrr7Fg6y/59ZABmQCJxEwHw7SUsiY+DidLX5THsHOr0EpvZE8/9vGZSeQZOt8zuPOOrw3KSr6o5yWgMCTtBxpJdaNQgLpCcYR45kGIbTreE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556628; c=relaxed/simple;
	bh=fbcfuCNP59X+xpC5IcevYHcbPlbySqO8B0ppbV4rWIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaoJdr6QlD90Z0miioK5PFqb5oJTrEIbF00uL06iQRM91RGBSfGOuvHb2QVTn2txhetU885pRHdVhauX1LlaDjaO9g7kDUe/Bu/+XMmwRfFcDnBNf2pciX8bre4b8TWP2gkPtuIzK0VqcZ19vXpgJBO/FJ6gKB12c744/8FE4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PawRyZl3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PawRyZl3"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so13877425e9.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788556625; x=1789161425; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QMge+xrP5bwgHdzm4UEAERiB2kJzyUIFVLBR/fB/uZk=;
        b=PawRyZl30RpsIFWClGmdd5nmrJpROzKDJfL5WiC3/1bYqUf+GJfpC7BOgtce7NkiJZ
         +fw1/nLgFZBbiMdda4pZaXaOs8+Aknc74gh+XfsCqlYuEupkBcTv67FPaCMJ0VkDcSgU
         TvdMer0cq5zfEH94Io+tmQXiV5hVPKj0mh8bWaHE+m7k6lW3ns/x860RAVO+OZuZ/Knw
         F8WV1nHKz4xEtcMz7WmoHYfGL7UeyNX4wZjBKQ7jBXxVg20FdVDkLtGcGHONTbvGsfOI
         Ihm3yCF/s6CY4FTkKK+43P6fA1JXmv8wQgG1TY3VY5g+rWQ5E6sElA//aGg+4P+gCfgQ
         zGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556625; x=1789161425;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QMge+xrP5bwgHdzm4UEAERiB2kJzyUIFVLBR/fB/uZk=;
        b=gIMXqijFzX9Kb13dk15kH2dssn/6iPRn9cl4RydF3hfjyvdDjjA2T5Zs8t7gfVMr/2
         il56iBGGXgnXzkepa6lbzUCFeR622vYh/uHjFi0ATLOIlKoodyhTFAH2WLiFad5tQmsC
         6ZYHFJqljCzuoCq5vgd3wMlGxC47x7cOI6xdurRbVc6y5dPSEvV0yastneUpgITHZ5vG
         Bo5UR6JPBgirxLhTbE3jxtLJkgp5ezQDOVAa9/GqHuJvQvVAvhq+cQalB8L0NJ8ylAVi
         rz3FWhm3Lbm9IS4ReAxmi5YcciwUf2YYyOLk2Wcq0QJsGRsqSyl9nFLN07sYrNYazW/S
         ikwA==
X-Forwarded-Encrypted: i=1; AKwUvBxdeaG9OBsLl4dluV9g1C/41lU+VN5ZzhcM2YnUZWFLRkPxoEKH9B9tyFzRI9iAVXIm743DSmI=@vger.kernel.org
X-Gm-Message-State: AFuF++lDp+VBg+QtT8zUATdXhbqHFfJoEkX2T5sBAiU1jyXEErTbYUNg
	DeAhd3AQudzUfV8Ah9CS+syCUKTPgsFyvjmPTqKE5d9MKjBGhfrIeM4=
X-Gm-Gg: AYBFou3D+xMTCMOrgEdvn4/b7uV4nZnkHRBsnwPNoDGH9LdlXzqVeZA+fo0Ix45JwUR
	pH0/08S52nM5TOjCrqfWGbTEguw7/i5tixv7gZZZkNJGfG6NZvj/9PJ/bm5f35UD+W28XFTRNHD
	nCAodVAR90NJfPmYs+vbb3jLqs7OrkhcN0Uz9g3uagdO0Ce+/buAT9OuoqvNpav1oxAIyd671Y8
	Ey68x5xNoreUJyJpWZblItkmypCa9t4GWuzEZhPTy7pxqbCWRtg1S2p08ojvjA1pnC4WqAG8Z7w
	hVWe0s6fKp/m31dH9Q9ckmysZzfzSZ5PHnbMGyqG5lDPIAgrEaW5JQ+HlYcqJq9/NY77fL5jgsq
	xTeyfbOjuA0qlr4HI0T5Pzmz4pIcfIFbuelTmd+2tUKF6utX8DqiUxd+nn9uicapSv26H3bNrEA
	o8ViUyi06O+V9cG29j+EeU5y+Ro3aRtQWVnbqw9OF/TGV308dxd+aBUDZBXWH6jpwpiHJypjFuc
	FE=
X-Received: by 2002:a05:600c:350f:b0:499:b65d:124f with SMTP id 5b1f17b1804b1-49cf825d1dcmr82117795e9.11.1788556624926;
        Fri, 04 Sep 2026 14:17:04 -0700 (PDT)
Received: from kali (88-170-213-78.subs.proxad.net. [88.170.213.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce591f846sm102532995e9.1.2026.09.04.14.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 14:17:03 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Derek J. Clark <derekjohn.clark@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] HID: hid-oxp: use cancel_delayed_work_sync() in remove
Date: Fri, 04 Sep 2026 21:17:02 -0000
Message-ID: <178855662286.3192124.2102579968112413785@gmail.com>
In-Reply-To: <949B786B-375B-4F2F-B209-C135EC62E1A5@gmail.com>
References: <20260904105800.3923987-1-tristmd@gmail.com>
 <949B786B-375B-4F2F-B209-C135EC62E1A5@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Derek,

Thanks for the review.

One thing the Sashiko bot flagged, and I think it's valid: if
oxp_hid_probe() returns early on an unknown usage page (the
default: return 0 path), the delayed work items are never
initialized via INIT_DELAYED_WORK().  In that case,
cancel_delayed_work_sync() in remove() would call __flush_work()
on a zero-filled work struct, which hits WARN_ON(!work->func).

The non-sync cancel_delayed_work() didn't trigger this because it
never calls __flush_work().

Do you think this path is actually reachable in practice, or are
the usage page IDs exhaustive for all matched devices?  If it can
happen, I can send a v2 that guards the cancels.

Thanks,
Tristan
