Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C756E3DEAE3
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397375; cv=pass; b=mQFB3WqNTTTgFx4ejp18Ga+v8Ryxeo8MvwQhr7cB2c+mcx0CbakTHxUXn2Rpkt6226xPhhgC3fSn4GTIwVqPWW4jiZgmvCzLAO0FfUw2FakecFbY3d7ypzspX4DJ3nuFqzPVyKPV5ci3gtgiLG4I8yyt65xnS6l9uXX+90tTTGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397375; c=relaxed/simple;
	bh=9D5TqnkicT2U7tRgx/dr8Iw0EFKZV2iKPc6zOXL2J2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okGNoPjOtuOJU+qAaep0y3LIUrouOhvrnjZLBHmV0SioP2Rr5jKiQ06RxNpFJ+FWYz67QgPJ/eolBjGsRk/+24jAE1OKPMkfwhcKgbwzDvOJkDItEMkTBDlk5KqIOdugxiVz0RO6xmFUGufbskFqdFQL0rj/UmqwSsALX0H+lvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=w3gwgMSs; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="w3gwgMSs"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c423b145922so140800266b.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 01:09:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792397372; cv=none;
        d=google.com; s=arc-20260327;
        b=OFU+n96u8lxfT78C+Z0ZyuAPRQWDRQaLifJLyHDzJ6Bi/fHiZvlVg4tEF5jsIukNYI
         idpoHlDyCSLQU2K/5BsITAEi1fn/fgNsocg0i9R7nZzxG/eIjhzDXZZaNBOROyVliGWA
         RkNa5SLAPaIFy+YjDL0XKtRVyXjZ2WTHAuxWVwGmYPclLZoeLoP0CmyYp4zkOYdhuxgt
         X2GyxVfrA/EN3YUvEyhtWIiCdMWiyXofTF0c5KUqekFWXzl7KS0qwr3I3mL3wtLNXUMn
         0pQlsMhbgy39s/GLAao12PVNQn9dYJLHB4EponoGjm6hwaj9GAGexFXCKiCCWN/VDTSB
         cOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mKp2lGowX8peLqRZk7J7Wle27OZPi0eWO/3k4N8FozY=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=GlUJDw2KBK+tUhQVtw2r2sHEPtcrAemVe4VkMOLGKsfHyYFyM5Ee73hUQD/Ncu/s3x
         ysMEtWdwpCsa6JXL/CsdFF1mcWWzwiyCnbWbPCe/mu9ZT3hWdtNmNwJmSNAKrlA3LGl/
         9HvL/1P/FHyZ+Ztip5wFzvZktTuRDmgsqJOxnj0/sgjf70Oi8Ux2KGsZrDQHdXMVKpnJ
         nMZLLczK8ZG21mDgUlmsYX6EqWXXGhyekKTYbAW4NKQGKBeasWw3/JAWL+dKrCKqgwJN
         wEkkdqZ5YAFrDUFXjevvWC+JosRIvBBsMaXlHWnWRRy7vn2i0tcIABPUpziCZ0p871G5
         1Y7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1792397372; x=1793002172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mKp2lGowX8peLqRZk7J7Wle27OZPi0eWO/3k4N8FozY=;
        b=w3gwgMSsj2oO7WQIuCObip/gnS/PHQTlQNHnZVxOh5PenQSOtasjQhzXs2VHhaPY7L
         dkkfgURsTAnCbJ8+aa4Zhih9RiuMOSs2ePs8Ek31S6s5b1WDfneqV+YroxPFtH4rWtMB
         PLuRGx/hTDEqSc3/ndmBgYr2OylDpWiM1SpNyjKX1R6J2YnBAvtcpGMHhNqDjvZy1SF9
         KgUOy5ED/IJ5z0BtvKwkldp53FtZr5v9Cj8o936eBtoH44rksJ3V38L71yQpMJMo8m/S
         xZWR+x2aOTCja6WiwTIksxMM047i1FYyyiCLuV86G0GXekKDlt6BqxxYgV5deApwlMbU
         6p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792397372; x=1793002172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mKp2lGowX8peLqRZk7J7Wle27OZPi0eWO/3k4N8FozY=;
        b=O3rCfe3Vnwtp3XWx3GirXHZ69NA7Uz2wfIIlbHDvdtTcXH1bSiRu5QOjQe1UXnkslI
         kJSJyWPBUIuj+CqJwc5jtZBkywxzUOOBJy2whMYeRBT2KKdr9IJ/lhm1U/zpWxFUz029
         1DUh3wULB8g2uUIYnys923FKaYR6FrWxep92+arUqMny6TGsRbzspkIdMb0LiuXPVciG
         03nTqiuWKYpDANrUZ6lIztt36h2oPyOQjpTiFmBnAo1j7DLsa9u9WjSZP3unQVmpg+0u
         b/EmLVU31dMX3dQ27vya7p6dOv2DnI09KdfAW1XSNcDAkTcQroy39iFCXym7TnuRfxz5
         OI5g==
X-Gm-Message-State: AFq9FYLNhnLHijj7SY1Y+vHqwU/q7FEcIBQX/bk6HMvbETaM9VE57tmo
	7MR35wyrg7yVLhjPzdIWw52/xCoufqjFM9d9Ok0zMZ7bEB/75hia504OGHKmPosYmsUsrWrVwZw
	T4lq4zK4+Jx1l8W0iwUi5kCD5O4LmAne/fzsWRPSuFoNoSi+qMwVItco=
X-Gm-Gg: AYBFou2MBVIJZxNkLfTSRCaXWOeNcqIMHHMqSYt/KrLILH91Tyu7NubA0oLCAYDyYpo
	8EsA73k1zmHbnT33KVH2MEC6Po34vU9ANveP/oKC6iS7Vrk2EAtFGYnHgwAM7ePpe5gwg4Le+VR
	7Ky93GQO+wlk9jx9JpQjpX8Yg8BOsn96tVoinZzvD2F8smHjssNvi97tKNUsq0iHUZcNIIWDGjg
	GhfHUlzsRk177Aiyo87aFvSxRnbaLdfwgYf97pq7AeEpUOplHZr0vSLS+pv62C+2KHpZV2oSm+i
	alIt57qgppM/zvqHwE7DuVv6KmWjG/xowjQZvMXUpmHFYtqONEHENuSUEhoc3Pa9N7+C8R4Anbf
	ySvVvQ2Ou+ekz/QGN0Zq4T+I=
X-Received: by 2002:a17:906:ba89:b0:c34:1ed:54d9 with SMTP id
 a640c23a62f3a-c41999720a9mr416234266b.4.1792397371695; Mon, 19 Oct 2026
 01:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261017155059.698368299@linuxfoundation.org>
In-Reply-To: <20261017155059.698368299@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Mon, 19 Oct 2026 17:09:12 +0900
X-Gm-Features: AclHuK8Huz6jdrYWmKBBEhptdxroSHGbHzeJx-piV8U8UsZA0jaDmMp3LdQ65vM
Message-ID: <CAKL4bV54AZWUbd0w4YvkbJt3VMEN6VmOz3HZAPHRZ6S3CWA_Vg@mail.gmail.com>
Subject: Re: [PATCH 7.2 00/10] 7.2.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Sun, Oct 18, 2026 at 12:54=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.12 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 19 Oct 2026 15:50:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.2.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Linux version 7.2.12-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.2.12-rc1rv-g590446e5a2fe
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Mon Oct 19 16:42:14 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
