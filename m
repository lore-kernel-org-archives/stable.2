Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003A5318EC1
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313520; cv=pass; b=mt4FmLweHw9LBdf7ZXuvvEi9MJT6AEx8OcK4rUr0Hxit02VzhlWy5tNaCBtjm0g9eB7ls3cwso504Vkt9pbmDlTB4SwG51zd/0fciJbEKsWfwpF3kWPM1JX2595oOWszexyXWeXWKBsvaqg9bsS5TsouoirI0ijobra5T9kbpGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313520; c=relaxed/simple;
	bh=yszJgkZCWn8L+J9sz17zUOD/xufK8NMtC/jiWVOFC5Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nbZ9tPrb731hFrmViSK4F/j2Lb/Upsjku77lvS+FD5O6jPYJmL0zcQ4O9XCnIOUYUyTZdsqGQxNE+ZP0S6P0+6esPDuIJIfTEokD6KHREsv1olr02zTK1TsKaXMglMEN963jDxNfwhdAVtDqewZtUofPpTD1vax0RNyv2ycLOcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAAbRrFR; arc=pass smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAAbRrFR"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-13621cca8f5so7281335c88.0
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 04:31:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780313518; cv=none;
        d=google.com; s=arc-20240605;
        b=MbZ7E4zAesMoDK/37whE9T9sfFIeeyxhpHp+l6bVbQ96uyB3wD1am5gwBg8mUHLa5Y
         3LzdQcvRPLA0LuyiWliifd3Gk4oeTk+A/lq45bp3sj+C6nr2N+KFEySQxvuBmngTxX5l
         38AhJAkQ2oCXRhV9XiYVIu1sy7eaIaGLrPdwttRqaMXcmtoI/2s9dl1wGb91SjotxuhU
         gOKyImxDmGmUtaFM+c6NoWJr/bPkmTr4RNnBNwTb05Pg5dFscbxJfVxz1qZsrPZkGKcc
         5BxN7UOSwKwgoCh10crrfNWD5bHjC1lCE6JtIBUGgE8lC+2nAdG2ZwPYY3sDmwVY7JFT
         61gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Cqxcp75xtoM57dtYJ+S/ObM2E9rTcqiq8xwIiEu9bBY=;
        fh=tnDJa69asIcMf0S261oWsKWCRDbcGo7ASJc4laRzBMM=;
        b=bnvs/n++ZKWsmLZXeEnJgIaHoV7/NBe2aJP2cOV79l6mo5cxKuts7HCZAnG0Q6i0oG
         0PwJiDufPSm559Oc0yXPKTV148lpwTHNWOpMo6dEgfat1MR4UBBChFt4gLd3jo2GYiSm
         O+P2IVq+EO8kkiu0n3wi+gxkqqqy5L0bEcmGWJcU5E6eOYGLDtI5wLAmbmr3YnJVkOKZ
         iDwalKeLWBQC3GIdZWY7KdaBvWiQ75jtfaep1pMbFROF7OsR1+BYJqacRgLk9KHFnkoM
         hChcaO0pABUeUm7FBjxtTOCPTrh8uzq+aNNQ7XPfQEA6KlgTynEeDc9LjQkeLmbWqs57
         KhfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780313518; x=1780918318; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cqxcp75xtoM57dtYJ+S/ObM2E9rTcqiq8xwIiEu9bBY=;
        b=KAAbRrFRLEY4qF/4mjQ3f1UiUQtiSbfzHtE6YkKMtz4kbv7WMHYZZduU1irdoFu1RG
         X3H1QVzRlbdcKapY+Mc8CYbiWJ0g+Fb5ht0xpiKaLbf974vZzSHiqR95/SBYCYZXWeGS
         2apeNvaWbm590C8K8R/UWruGoQAOmWHXuUhI0ZikmsjCvOoF/bjEgk2Nucn8f+8G0YMm
         5zl0ZYPqH1Jgmlfc/fAqpSjGTK8cyswDZrjoPJ/yZTrIuU4V+6WpqFELU4eLPrDi3sjP
         Qu00teTpdaKxu5Y5EXqbd0k/wxeZA0Ma7KZ1Oga2j6RFRxHyeFgKIxgPDtyAaYnz/fw8
         i9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780313518; x=1780918318;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqxcp75xtoM57dtYJ+S/ObM2E9rTcqiq8xwIiEu9bBY=;
        b=Xiv8lKvPIyU7wtokJJGo+Hd9iXKwxmJiy8DYqwKI2H8v4A0+20AKITL7l2GksbmvKQ
         UeKDBvEZpLL/wKGDZzEK5MytRgFgPf5WGTWAxD6/YWhyLn0FUyWzg8d89Fbj38k5Rndd
         qtkIk8s7gFcZYpjZH/rTI/4/xLWnueGugrzUoZTTfRTT3QjPupB29aDdmOpc3sfJAMyj
         8YUDncdKA+JVYe3DhJ9qB1QrsqeGcEXRsapmjhDif3FJlU0CnYZ9x8uoVctbfShGKzXl
         jVFr6zFHUJFG8k9Itk0GLn97GEXyYFNpxgW0ycgfmR9pNwcANxtOvh461NwQXY2SWx9D
         P/dw==
X-Gm-Message-State: AOJu0YwsYQ0E7JPDqBDgb8eKoC1Q8qjZdoZWKK+mV7aA3TS3ptM3W4yj
	we1bPAYRluUWIuf2XpAvQuNT7Tb1xJ4/1LhYtBjQFGaG6IN7y8nxlPuEWS/umRhVpAhHVDeU0mU
	J7IuJuvY0Kpz6yUlvpzN1k4OU0kjpcf3vFRMvsNEwN5TRCD8=
X-Gm-Gg: Acq92OEkZ6rrVrWlvvOnfUeGB+SxQ3yEqHWu/KTwgDRD4YS4No3nsaqgVkYfZjD7qCl
	Yt6rikwJx5HSCTfkDt8xeGYqET3eDL5UPIrlEq591BXbDVRsufwRTP40lQCgi6qbJH96671ghf2
	hfujcOlbKr9NAbXgD0W0pIPUY3LMS5YQghmCTevLyn/eSI1p3BvSqGcPtOSvdVSyJj36bIDasFU
	ZcyxCvzE0WUIMVJyerhMBj2HhDTzkXJnfXOi+0w8kafbzctWqyGckYV3jgCqlIhSWAMGkZyh941
	Lq/RTdY37Id/z7RlT0kVSmzdyrHU
X-Received: by 2002:a05:7022:392:b0:137:938a:1044 with SMTP id
 a92af1059eb24-137d425e735mr4514505c88.33.1780313518020; Mon, 01 Jun 2026
 04:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: boz baba <bababoz943@gmail.com>
Date: Mon, 1 Jun 2026 14:31:48 +0300
X-Gm-Features: AVHnY4IkZaXRztFMyZ0UAa_2Q1e-88z0noe4I9gVIsgWROR6bbGX68MZKK77zWg
Message-ID: <CAAB7JC+TiyF6-1uvzhOcJ9KeDUhNgLmXk8unHNogY156xSu61g@mail.gmail.com>
Subject: [PATCH] net: esp4/esp6: missing skb_has_shared_frag() check in 6.1.y
 (CVE-2026-43284 backport)
To: stable@vger.kernel.org, steffen.klassert@secunet.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi stable team,

The fix for CVE-2026-43284 ("Dirty Frag", commit f4c50a4034e6) added a
skb_has_shared_frag() check to the skip_cow path in esp_input() in both
net/ipv4/esp4.c and net/ipv6/esp6.c. This fix was backported to 6.12.y
but appears to be missing from the 6.1.y stable branch.

Affected: linux-6.1.133 (latest 6.1.y as of 2026-05-31)
Fixed in: linux-6.12.91, mainline (f4c50a4034e6)

Vulnerable pattern in net/ipv4/esp4.c (line 912) and net/ipv6/esp6.c (line 960):

  if (!skb_cloned(skb)) {
      if (!skb_is_nonlinear(skb)) {
          nfrags = 1;
          goto skip_cow;
      } else if (!skb_has_frag_list(skb)) {   /* <-- missing &&
!skb_has_shared_frag(skb) */
          nfrags = skb_shinfo(skb)->nr_frags;
          nfrags++;
          goto skip_cow;
      }
  }

The missing check allows an skb with SKBFL_SHARED_FRAG set (e.g. from
vmsplice()/sendfile()) to bypass skb_cow_data() and proceed to in-place
aead decryption via:

  aead_request_set_crypt(req, sg, sg, elen + ivlen, iv);
  crypto_aead_decrypt(req);

This is the same page-cache corruption primitive as CVE-2026-43284.

Please backport commit f4c50a4034e6 to linux-6.1.y.

Affected versions: linux-6.1.x (all versions, fix not present)
Fixed versions: linux-6.12.91+, mainline

Verified by: source comparison of net/ipv4/esp4.c and net/ipv6/esp6.c
between linux-6.1.133 and linux-6.12.91.

References:
- CVE-2026-43284 (Dirty Frag)
- Fix commit: f4c50a4034e6

Thanks,
boz
