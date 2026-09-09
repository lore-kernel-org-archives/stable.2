Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C2852ED47
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951677; cv=pass; b=JuMo66i2KnuLnYMBLzRwuoXzDenuzOq2gsEepN/wa3P2gvSCzCaWRYBlHP5BVKgee0McjJMMFPGtpExpPvMtF7LqZ7tKV/Ub7DR0JyceAlPcHhoG6yk1zdsXcyPMtZY93tzUcEWh3jn9+dF4ZOQnlEc07fQLbYSqa++clj1ymuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951677; c=relaxed/simple;
	bh=g/39UEqT9toqCrCnxGHkgjqNAqJ77A/mKbtdKnBETRs=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmWACG9FlZEEASogI5Z6GkLJ8X0Ti1Z1mWWxshwGRMvMKFDF06jMxuHqEn/80JU/JMq31nKvg79ApLyYCeIzChs5oeetW7b+t1C24j8f1Sd946dycAxuRf3Xj3QBJIrT7LvRkBMpZBIdHQUwLYu1ioX0k0shAvKCxkZRIIE3QPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLuiy9lH; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLuiy9lH"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c65093556aso4415479e0c.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 04:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788951673; cv=none;
        d=google.com; s=arc-20260327;
        b=ESCJ7h0DS6ewtpSk83NwXd8w01d0lomOsHH0QbDUUGH7YE6WKJq41/QXbKLyndw07C
         VQ4YrGoSelQm50vcSGELmJymeUpn1MEaEDch+RTvH8aKaAh4P7roau3aWvmMvDxHIeBa
         gPF3M/b9e+XeoczhkSlPzKhgKbPpjzeuaoOpGQx4i+dnATIXFmAxus188iK4kLk0fEZP
         h7yAWFlQTL9zMShG1yIKJfO6svBnVDv6vv2cbcIvHQ+FGlPNnF4T/YudjNH/aG43MjZ3
         o6DH7uCH/ds08QVOpI59ZbCBmos2HpLBiYyZuQ/pEDG8/N6kyNc5jetawUdGupupEMvo
         wTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=g/39UEqT9toqCrCnxGHkgjqNAqJ77A/mKbtdKnBETRs=;
        fh=aOhFyKi/b5S57K0Z/sGdbXTUUsS6bz6D9gBda7P5gO8=;
        b=KdnJNenhYy358sbK4EuYbqd2cLsOJirVMvRxep2s2mpNvTtBqUlemNxAJq1U+8JRr2
         qv9lBn7I6MZrkP+rFtoe+RHDguTxXMfw0SRJ/a+mjCjkvUBdPnKUWsWtSpNoE07rLFSn
         WGk7CgfdGmkPwLSP0brbjqmilImVSJe+zABvGEPwOFpE1Yz5psL9018HGPKlcN5PlVPa
         V9D/VBHdzIYYTxF9zAZlIbT8YLlXz949KwC8/G61y+ZlSz85Jy28BtWik45GtIxTgzu/
         GJZoip/zUKIH7y7zL1/IkhCjFGQkSyPgzV65kGjDrDAzOwBFX19QdESoGpD1ZdaNfMGC
         YhLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788951673; x=1789556473; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g/39UEqT9toqCrCnxGHkgjqNAqJ77A/mKbtdKnBETRs=;
        b=KLuiy9lHElUSQVyCGNhQ2N/Vy2L+WHxPwRqOwGLYJIauKAZkkT1R8DDgsI4jTIxX+t
         BqFn4kd8nO5aJkD5qFTrsjKIFniUfsvQFSr5vK0rWiIgQCU/zV+hXIIdGRPLlW1XRhJd
         +z+/WTUKvjgHlN9CKzW52/ouSEl3GxTYM3N8QUn2FaZg/R3QAAqcKVdx5JMbthxX4oLw
         r8JkANzWiZOStrI3gg8MC2OAzQ5vvcBi3gl/ooF/c0hEPSZ4kH9wpccm6ac8Ijhv0zp1
         aut1dlZ5CpwdlHaBfS7pHaCdIKN/+bRo0ltIvcGw+zXaUTjsw65AYSjO1TlJrS7hQwhx
         RvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788951673; x=1789556473;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g/39UEqT9toqCrCnxGHkgjqNAqJ77A/mKbtdKnBETRs=;
        b=bpl+2MrBkxXbAeIBsGDW04ZGnJMYjuumjHdIuCEfxYfFSlVj2gm48DoKPepwMpekDm
         bTwyJO/ynxR9Rj0k8Hs34av698a37acl9aV6fie3Ypv9dv6fyJHbaL0Qvp6kw3U7gk8s
         +L2N5YucPBiQVJIsDx3J8cX+DyfDGJ6gZhktkxrpf1QBQxlSIN0IqAlpdbfIgqhUgTIr
         m8cspE8Hlt5iMeG5+MFRTsGDl31Ke1d+5Kk0gKT5hjrfbpRTuwVnNN+P8UynasI/J4VL
         8WPg+sl9jKW14YKp/oLX06/XMBnVnrPC/VWw3IulWQPfFPkmaZbDm8323vIMDUJhklmk
         UQyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMZmFOEy5myRSrQO2tpy01Mg9S/Skbx/JylM27cKuwe2hFRXJWOfmeIxCuHc22jmyy4UIAaZw=@vger.kernel.org
X-Gm-Message-State: AFuF++ldBtdPRO3GjS7VBKW8KOZiupGdjCx/KvGzj7T0oAH/c9vBD9pp
	qpaRxYtvr4S//uhY1/DGMJDejbmYNMV64LTZ8KzSIp0uUtT65f8Ehzs9fN/aB4+BjSnlX3KNVMS
	a3fRbLxC9iuq6OLcZl3dZ5D/TLpSY8/I=
X-Gm-Gg: AYBFou0/mk1kdoH/+ZwKu4bhzTNCQwJp1v3VtLvouIQ3vTZ4Ge3bFmY3gCJj0H6v6E4
	WUOkZ3GIlRPbWfij6YuK1qvJIkypVt1aAwBc2+bd2GnctKmF8j8PBN00WgoqgZz9iiIqhv91QDE
	LdSthfO5jE6MumxphYFGmHGud+jXrfeCcwM6kPx7aoVcelwQLUaapepnj/rkoG7s9FljWNw+qnf
	za4sTS3OPbCe7DzGS09kNxrLe+5At7wlFkrEYUy//6XiC6Xm0EIGxecSFWOZ5NP2sQzmev458US
	ajZ9fLA42uXrjBcAad1BmCVe5Si4ohqRzo9L7kynQ9feOw/PmiK/nKDqRhvIkGoPn+WLJPaJAQE
	k0A3MFC+evEugezBotzdmKdCRe316dDTXr41ELUA=
X-Received: by 2002:a05:6122:d90:b0:5c8:2c83:9cb with SMTP id
 71dfb90a1353d-5c82c830f80mr1746396e0c.2.1788951672620; Wed, 09 Sep 2026
 04:01:12 -0700 (PDT)
Received: from 313336824172 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 04:01:11 -0700
Received: from 313336824172 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 03:56:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260823120039.A7B3B1F000E9@smtp.kernel.org>
References: <20260823120039.A7B3B1F000E9@smtp.kernel.org>
From: Julien Le Bourg <julien.lebourg8@gmail.com>
Date: Wed, 9 Sep 2026 04:01:11 -0700
X-Gm-Features: AcwNN1XvXL1SjFRBtFvxbHrfryC6LwXZDTu3lMkv6bOZrarcI4At3uMGcycC3NQ
Message-ID: <CAAK4M4VkRxnG9eYZWSiwqBKCMeWbF6XCGxekZLc-+8gt_R4hVw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Restore self-refresh fallback in
 DCN21 bandwidth validation
To: amd-gfx@lists.freedesktop.org
Cc: sashiko-bot@kernel.org, Wayne.Lin@amd.com, nicholas.kazlauskas@amd.com, 
	stable@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sun, Aug 23, 2026 at 12:00:39PM +0000, sashiko-bot@kernel.org wrote:
> This isn't a bug introduced by this patch, but since the stutter latency
> leak is explicitly left unpatched for DCN 3.01, will it remain vulnerable
> to MPO flip_done timeouts?

Yes. dcn301_fpu.c has the same calculate_wm_set_for_vlevel() helper and
only restores dram_clock_change_latency_us. DCN 3.01 also still calls
dcn30_internal_validate_bw() with allow_self_refresh_only true, and
watermarks run only for DC_VALIDATE_MODE_AND_PROGRAMMING, so the check
vs commit_tail mismatch is the same shape as on DCN 2.1.

I left it out of this patch on purpose: this is the DCN 2.1 regression
(360 Hz eDP dropped after b96150a70696), I have no DCN 3.01 hardware,
and I would rather not touch Van Gogh watermarks untested. Happy to
send a follow-up if someone with DCN 3.01 can try it.

v2 is otherwise unchanged. 1920x1080@360 is in daily use here on
Cezanne with this applied. A human look would be very welcome.

Thanks,
Julien
