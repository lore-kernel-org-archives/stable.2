Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EFC3921F6
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787397826; cv=pass; b=EZZyce0PtI8GQpsNKEDwtXO0fzR0OZ+Q8c8mXPkIzFxiRzezzQcnBQhoxUHmrHiEMFZMiaeObpbHVeCyOyPhaF32Mof30siNkCcRh4KzR2yeJypgjfllHRecoe2PJ/RXNwH9+ln9g/ROpqgg4Y8IzvVYgdINYpekoizfkGo3ln0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787397826; c=relaxed/simple;
	bh=KsycAkx9ZIocqaOJ3xoXKL4wv70MFfNTe1zuqSRoU68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILHLxBSym02xhtcSkiJR8z+Xe3hadarTb0qQHG+gDmLlBAQIDXlPKuJZbOq8R2UFShITpyBSFJAQE8j9aHCthPYPQ3pC4yp0zL/hsaWSLxKwZzNxuYaaVfC54EKDYhh82dNgVkqTb+UIQgee1ALx8Y/HoNviQMVUH89xl/T3yAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b=jPpSo4Yz; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b="jPpSo4Yz"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15d111ca99so220342666b.0
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 04:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787397823; cv=none;
        d=google.com; s=arc-20260327;
        b=PLgtqUB6CjFytkQmtFOmVgIlQSbi22+I/aGMS131its6zHbnrAfECsDUeAjFbOtQ2w
         neNIQD0o7Y/Z66KmnmuVJsuvi39LhT1Q7pwYuk58v9c5O9MCa10dX7LaDMzTj4Ikd5H5
         OPtxQ58xW10S3NUbZlg/GdIBWHCs/vt+UUTJmfpWiX5jiHqh4wgPHsGifCFAgob9E7Rw
         8yfWNwhoAk+VdR19nk7JrEMnm5zJE8cptzQYF0Psjj3WEWvtHo2gmjAbMpIUJncAL8ND
         qtpwPOGHUYg2uSULN4n8laJvyyiwe9UoGL4EC1fZkxvBsvlEJVyS1mBCXSwP3ApfL+S1
         U7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+oioSyEnPpQforztpGv2/Sue2PGm2iOMt0YGvkfoWek=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=ZQRMI4rItLCOC3bERMfBHgWbQ0Ri0euBMonCsdkcLqrixApy2yylO/VczvvwPlfzPW
         G/DvS6iH5YZ3ayVXPE4oLEousUdIiSsfEVQTtZicbsk82ZYPP03p6p/MtpNuBOkqTvoZ
         K0oq2Q6ULAKAUmqfsV5u0yd0X79oUp+2PDtvds8L4i6UVL+J8U/4U++JH+oqdGhqQq74
         e8ZK0q2BG55437a+bziBBAHcBeQaeTLdwEuWID33fnh3zftkuWjLQZgvgQ+Z1huqMM+r
         DjIISYtQTrsSs6AJhRtbywYRkVWholOII721OQCKdMDciE2x2vF55HRrzfO7lRj3IsIP
         UXNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20251104.gappssmtp.com; s=20251104; t=1787397823; x=1788002623; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+oioSyEnPpQforztpGv2/Sue2PGm2iOMt0YGvkfoWek=;
        b=jPpSo4YzeMk5OaE1u1i1XXSgy/SLbbOh0nNT6n8lQIxqiabbPh3AnUk7ant6YsLw8k
         b/i98Zv9GBz17XlBay7jcCwF2yFpjSxoyGuIZcgcRXrsrNJZRFaNXbsp51ZXTLx5awRF
         NbzRfWdOyS3dhbvCcxOwTrmlKEllOr7HMzCrgdlowgYoph1iHoQxR5aGldbHvQwWHhSr
         kMbBwUC5x/s3rtnI+0ZLKsAZ/pVafLcdvYk5wGh0v9vIJ7pMIdMxxEirJJPdah2rgm6S
         X2XMigZRBMSeYzGtOqyNWaSpMFqvuL0QOljDM9l0GdwOxWa6AT+s5kmH675ubBrCBlCJ
         ymKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787397823; x=1788002623;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+oioSyEnPpQforztpGv2/Sue2PGm2iOMt0YGvkfoWek=;
        b=HQBx7HTo1BmCdzEPDU2zRQKz6WV7vnZdP3ygSfw0dSds0jqH6Nj1BKBJYTXHWNr9TU
         oUUeqL5p0u3CKMkMJcNbgJHkMLjSyupBGTpJyTqRu/SMk+QtX1m5XEZeIgxQFYFNSpzk
         cmd9vuUl+iY76tU282npWkwfPrmTZnhc/LKLR+vkhS3WyMyBMPLdB4I1S9jeYFzyZ6LT
         hUBCMEEBXxsMf9LtnSZ/TkrvzLpHxJyzR9UrXprRoqvb8fWY33e92KwO2N6a5ZNdINgK
         vD8kmGv99rXCasxIj4SJZOfTx09LrKpVLtIc8+qAr2LQDH1dW9e3Ebz2dHUjDzhOhwO7
         8n4A==
X-Gm-Message-State: AFuF++lfTxZj8J8s5ayie0JED3O5TF0rLTDHJNfjw2kkkAc8XUvbRzTe
	8C9yGbxqte4COoEKlXQXYEBsqoQwtGjYzJbNumprp2icM7Bm0FALTj89SiSsT8B+YBweq1XozgO
	5lExpwWVnPbC53vOnk4CEvsDQUHwT05wrI5mLwZzPfQ==
X-Gm-Gg: AR+sD13TmU0Qk05hcClWenChrUvGWIAUglG9ZQIPkGysRz2CLhIvZGH2tlgsmhQuPrZ
	eRv3oFmhViiV2QHdgIahJ1YbPH96Nrb3kALzqNAszzQinM2k01uQ+9v6iHau7I+NSanN7nBKfYQ
	brVeSOeVBf7gxHPRT0zd7prk1m4hNZWdctAHZ0egLPcbzBjs2JyT9AOQz5PvobTjwYi9ezVnzvT
	7OjhEbE+Dc7gyBgponT2t1pk8/W4007/TcISJTlzC/N5+7Cg4c9aieK9BboRk2Ol9jxv5O89aHV
	bypAC0UsJ663YNMZgLiWtEv5pzVPiA4RWHD2DPy/iqBRVpO+dl1/jhgtlVotbXFaT0XyLX0WxcD
	vG7gLXw/NJ4HOX1C7sCiUP3d4NMl7hwG1hewhWureUqUlNpSykZww36C8NjLLWlgGbEiDOBNu1N
	H4wCljHKVFj2pUvvlQZ3nv2v3R
X-Received: by 2002:a17:907:944b:b0:c20:23fb:bb05 with SMTP id
 a640c23a62f3a-c24926a1cbdmr566541166b.15.1787397823424; Sat, 22 Aug 2026
 04:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820145244.450574346@linuxfoundation.org>
In-Reply-To: <20260820145244.450574346@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sat, 22 Aug 2026 16:53:05 +0530
X-Gm-Features: AcwNN1WGeBnoYhB_lqBVMGt6wzNqX-2N3ScSbhRcQjjFZWrFEibQEHqoPnk7yQU
Message-ID: <CAG=yYwk8bW=5u8GUU+m8J9ZJBAAxFoTMHR-+G3WNU0YcN8L34g@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/228] 7.1.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

  hello,

 Compiled and booted  7.1.10-rc1 (using qemu-system-x86_64)

No new typical dmesg regressions .

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology
