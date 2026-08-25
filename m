Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A9D481252
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665254; cv=pass; b=byQx6a/7M0ObeDLFI8LNuMOfx4BySMhhiw9Xve4DNHxxiRmL1vFJG/3tqqlnbms1ZSvRUAazwMKPXll1AXegjfMJggx24iFOvH/axGpah4o2VFu3HJA5xAQkdzrOwmI25T9kaL/31YbxuP/4vcqwgj7PIFJlb+rnA+uaXVTokB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665254; c=relaxed/simple;
	bh=hvKyXzgJppJMaaEEyd99Thc93IbcMAS25L7bMTUdZT4=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gg+JvgyPh0Xy11N+oS6t3V6pfQ/Bn5tSkO3DlbYBvjuxZjc0ZMYa8P6LSLHu0EB2qNeOCcgJRifRJpPUivQ+Dx+0ALpbaAf6FOtYKOTRX1N3WyzkhLCfPAQgUt1jzXx9KLK2VIgevTSeDeZOj6U7CPvq+WqE7d+k/RK/SIZRyoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eByTozo4; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eByTozo4"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso5366166e87.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 06:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787665250; cv=none;
        d=google.com; s=arc-20260327;
        b=Z+3ypB8CiOoFULO5I9KtyV2eRc8a037CcguYElcUKcD6jz7Ve4cePQoe6PKDiHu9vz
         DGbahRpiHDMv4FHFKLHGMjxf6Gb7EkRQ/OQuKWnu7g1wgsAWsuDBru0X+Qr4Be7O2ifS
         vR+vqiyyNU+7s846ub6pFdBPJez7qaQ77uES5ljuVzVCUtKX05ng50bRkbZAreApfWUT
         KlB3tNmihXiJHpeQrrjgPTrp5Q+j/hK7+lZmppkVSdrFHZTwaB5ZfuQlBJxw8WuwTH8p
         yrlrRpy61zwnG3pnvpmTGmCPOiPXR8wldhzUqJe6RrHzgiKS6vAsDEwxbV77HweznjXv
         OSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:dkim-signature;
        bh=hvKyXzgJppJMaaEEyd99Thc93IbcMAS25L7bMTUdZT4=;
        fh=C6unatxLx/EPVtL0cEOfKtrBePbyMDWsHPR6RmlsjPA=;
        b=YdUd6O5UwOChK0gDxcWg0y7mQ2ZbE/ploJo390WYmhazRNa0keOFFx3gXvlFyd+O6f
         PcDd5ogC9bCC1I8ub9joOaE0dLzQj6eWoT5jV1XVQHJCcbejikc99cdLeD49T+zPPOJT
         X0xuOrXL2EdbItyy18n80eVU/+TuB7/HkNO5o4k2wjt0rM3BJNEbuZel8qtdQIX1k34f
         HPHim4iyDXnyFa8tB6TII4S8+2kdqc0BArmfTe5p6Knw7IXpdqHiUcUsAancpxeMRYzh
         WwIb7tlqDYk/GMt1WVBTiO7WjpVrfMdAZSjYo4yajmoZbVKEN9wzUxXtKhL0OteFYWap
         sMbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787665250; x=1788270050; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:in-reply-to:references
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hvKyXzgJppJMaaEEyd99Thc93IbcMAS25L7bMTUdZT4=;
        b=eByTozo4EwWCk5mAcBWZaktfPVnJehwLLuPYKY4OnfQA5UM/D9zqZejfFJ7dxXYqw0
         921HEW33MSY8pzRmcm7enTI4KBkkph2l0obH2vZgOS9kBnuM+V8sAphs+DmkrkCdvROY
         CDfF+4M56UsFofGmLY+Ao4OF+XPP9ZSWcs88/Ydeqe9SxJZDx67GY9CtyeGHYOrh5M1X
         tyTq621MQCuOlYGu53TCM1M5ULNalrpBTplWcDzi73Y9UiIaB32xekhS6MW0ATenInpK
         RJW8w9HYvYflSdmKhDq8tCV16rsDgAZpwh9PN6s4/CsoGjKFcK1yJM2UA2E6gtgdZynN
         fing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787665250; x=1788270050;
        h=content-type:cc:to:subject:message-id:date:in-reply-to:references
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hvKyXzgJppJMaaEEyd99Thc93IbcMAS25L7bMTUdZT4=;
        b=sJ4wktIR8fAb3yqWnK7L7eLXh9Qpcl+zbtT4Os0aR8hyEuawz0XKt0mAwbYG/Yp4VZ
         lzS4zrkmBW0CkUyZsx1OEi2mSGH78VxpsboX1F8MOZSIuqTz9pJv+WK/6yfusxCf08GB
         Z/DhBGEZ6mj7eZGgRgchTi0nOShimIplIlD/RZ8nlDwXnTQtJ6X2rt72LFn8lqg6AJco
         Cid1xDx3gXM0iS/LVsHJdzBicYhDdM4zc8TdM0q85W9MxO/nUlNcjV591Q0IXEtUUG36
         4Q+x70fuXDq/r+BrLwy+LDLZ2tqndySDI7LdRTrgaukpPIEDEBcBuxEVwoVxnMO3qi/F
         FGjw==
X-Forwarded-Encrypted: i=1; AHgh+Roz0rtZlF3y+DTQW2Go8bx08DnZT7rkeM0xJW+DKfMLJQ9bgM+6SXb3TX3dbGJIJZtV0UrZRtE=@vger.kernel.org
X-Gm-Message-State: AFuF++kFQZUwzsc82kTKFLHno2k88Uw7NCKyKen69gV3lt4YwMLnD4b5
	P779chb/WPHtsPCyZ1lD/nIVPBF9ZI8W+dcmf7HEkrSR91b1YPthw3HojVQXQo1mG2moxQi2Kzj
	OkxMGU+6QFIdxVCTRUb7l9Nnpr4kMX/8=
X-Gm-Gg: AR+sD11maMvOZK48EZpe27HxX2a482MZXXR/Mmbf8XC7u796lA3mG5wbewt7AXbN0Bk
	bG6IKNeyvqlkX/CZ25ue5jG2zaeZwJUtskUynSvH0ueMQ0axWjcVP63pmCWDS6M1a+ALvUcEYIH
	VaInadUCHsRAnda/9dqMvnNkvZt3UXHvABEjfWbOyMCsB1xTbyGVKx02k7Yak/yiafogzgvUjKP
	RJ9X3vjwEYCr8RAs8wQtoVfTfTCYSWWbYf9a616JltSawxwDpjXXajEvIlY4uOxxl4Yp0hbGOY/
	saUVRgZIxz10fWkVtnCDis0rT9ZKH5kcloMxNubIcip/T0I2UwFbIqgNSfOMOCvzFHelMs0ZyP5
	GWvqhfq6f3D9wietLfOnZm296cdedjUjDfHNz0REHbSHcdnuDSzcYewO7cpqU
X-Received: by 2002:a05:6512:3d1d:b0:5b1:5a31:86b2 with SMTP id
 2adb3069b0e04-5b4842513bcmr10922031e87.16.1787665250199; Tue, 25 Aug 2026
 06:40:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 08:40:49 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 08:40:49 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Kamil Serwus <kserwus@gmail.com>
X-Mailer: aerc 0.22.0
References: <20260824053227.317496-1-junjie.cao@intel.com> <77f94165-3d5f-41de-8969-c7318284fd6a@leemhuis.info>
 <CABBYNZK9ax+iw7xKBtdZTSERsdhQ7t41Bg_1EnG88KOYj6kFHg@mail.gmail.com>
In-Reply-To: <CABBYNZK9ax+iw7xKBtdZTSERsdhQ7t41Bg_1EnG88KOYj6kFHg@mail.gmail.com>
Date: Tue, 25 Aug 2026 08:40:49 -0500
X-Gm-Features: AcwNN1Wug9vDtoOA1TaKYTIovtZeS8SWGR2PbmXd3NJe-LYW9VPQ6Emgzep44ig
Message-ID: <CAO+VTThX-p5sT7sDVsr+Yqf-rWBdWHEBdEyWvDNbqZnwdwhfvw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Junjie Cao <junjie.cao@intel.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexej Sidorenko <alexej@sidorenko.cz>, regressions@lists.linux.dev, 
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Kamil Serwus <kserwus@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Dear Luiz,

Yes I use this version 1-2 days. It works for me (with reverted code).
(as the same as before commit 5ead2063611ae56809b1b113ac44cef9547c81d7)

Thanks
Kamil
