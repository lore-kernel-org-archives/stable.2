Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433E37F323
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822156; cv=pass; b=syGaRzs4Le2yj8gBGJNkgEYGGtT46mbGJ6eiSWqGHIez4xtJ7JkB/Fk1HOCuY1RqX+O2hO52hYoRckZe70YakY9C/uE4vDLIxaLm69f8SVHkP61JHXcsiCPWauT8I/OK1x7747XwWGY+UmiDIJ+XNimGchqPnSt8D2g7aJR/ePI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822156; c=relaxed/simple;
	bh=TviD2TfpUyvALHM/EIRjWbCupkH+Sjjc0vKErzmfC5w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=M5dd430hLQi3WiOFroR5mqhtOGqD5HVLwxIKXVZgbZ0UrbFUjQXahUZwoOoZv2M8Cei6y7ycEj8K0Yc/rR2v6mFgiy/Gftb4vz3FqValpDtBwDn6Gz/HdGKmKyLp0bLAoDB7ntVczn3qtvr8Qqz3sf9OJ3hL+HkG6/SFQx24Hsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5lHJXin; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5lHJXin"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81e83f1f15aso5812617b3.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 08:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784822152; cv=none;
        d=google.com; s=arc-20260327;
        b=UZhhOUwaq0Fs6DdzSrDvo+Ohf3tF5x23peEkFAqzlsRvbUbHo+qSEJG5BE3gp/NwwH
         RwoNbI7KJwmgPJIj0WMrsqWrPC3EA3v+JPvekqzwfsKaG0Wd7Y9a8lrQP+WNmqtfCEfO
         7Q2IQDmENMrsVoZ4nBBxhjB3ZCUDHCMKek2GGLT5FQuajcjB+arYzJsqthVv0nacM5hD
         bBzvkHkit29tRkVzovmM3OsEjLBIwvHO/E+s/BS8OwgNbSzGhih1t8/98x7p7qo7R+hR
         KMVU5E/yFWP0SQcRfTgG9wBM9G/t/31cyoKOtvqxwnCMGNLiU0vZgSq319T36L88ful8
         JUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=TviD2TfpUyvALHM/EIRjWbCupkH+Sjjc0vKErzmfC5w=;
        fh=wpfBrz8Oq4YQpFssWRRbOw4H2KWsXiYNZP1MuaR6qmU=;
        b=bjY8VMhXzfYWG1j4kZxt6WyavuzcfDkO+/j5MzAAOTR2vibQhSJYI0Qj36Wr1+HZjE
         aPvxRCPV9M4X09/+v+ZiB7N2M70TDpbhQo6htEMW6osIrTjJGpBSC40ZNh9+kYqmDj57
         IznC7qI1xjX2nE9VFQmJxE6e0B4w5/zabkECj8ALfkWSgxKh904deCtbdFKuS52JKKMs
         Ti52Wtvqm0fgqCG+bZvW4dWuDg0PEx/QygEz6ShBtpKDNq40HZCFZKEO2w7IT2i+BpLD
         emWqW3Dqn42K4ptCCPNFTBPXDAlm7SAIjhHLZxTnZHIj/a+CyIoBpeZywVGswJHdUK6g
         RrYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784822152; x=1785426952; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TviD2TfpUyvALHM/EIRjWbCupkH+Sjjc0vKErzmfC5w=;
        b=Y5lHJXin2EGQPz+h5dgA3pvL/9tBC+1wDi/YVS64qlutHNtI38OD2eu4+5lLSQq/4D
         SZDk7WOQ9Zlg20lYXzgYfrNszua2SRWAXJ4P1iv+ezHAWlw1OQXxxHSDRY26gE9aKKv2
         GHRxkrq2rrDbk0vxa33otFLug3Hzjy88R1ClLD56I+yUVTvCOKrhHTZXhgnqxM3SI3jG
         zzwv4KjCly4Sj9vWXwWPZEvyPtL4GSR3hLuZlvKuirnWftc3E4uipOtUAFnBslXHT8x8
         w93EonOLA/t+yl5RnInp/dQ/ogI5uq0erS97Z5j2EQz+dWmlWQ0HhsoFpG1eH65nCUx6
         4Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784822152; x=1785426952;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TviD2TfpUyvALHM/EIRjWbCupkH+Sjjc0vKErzmfC5w=;
        b=UUREkqG3w3Mhq6hmMU+nFqSUpgWY6ICuLZ4e4HT/d3MQRkNVmqdCalw8RsApROsm11
         cJWoLV2Ms36xv/LzQJdYtU+S5w9/efD7iWbIqYtsIFi6fvmuaisRLM8D9WweXrIthKKB
         mLc5c0pCAU1ybxBAPhecWnjEdJCtAhpt5Ch+8D68S7Vh8ayRpm6kDvAQY5jRzvOrYF53
         JUW6Pd32qRhAdCC9XGWcGIzACvuQxWs7BTkM5Kn8BYCVi7efzF/rbkGCAZfv3sRASA0Y
         ZxfFg0eGSBu/5YAtKR1+oTWcFyOGHkb+vvZ3aIPFYOgb75mQcgd8EDFoczY6Agq/KePb
         bquw==
X-Gm-Message-State: AOJu0YzKO75aZujtPiGV570Jz7nwsNAHbRyEuHzIfb1N93Kzqn2P8UyS
	86cXP1PikpqsZXYh7zl1BCBcM/6B54PGPpCx3la0l0oBGxDl1dUvPMATb2qZjqtEA4MISJdFLGv
	N4wVaDZc8ILIFVMZrGIgroo4SduX79TKteNDx
X-Gm-Gg: AR+sD11BOvbv45IHLpTs3t9gtmdgjs+Q/pi3FQPMgi/fUQ4smEUTQAYogix3KYGcaKg
	o14BWOwlXQ0fUSkF/cbGF49OtPvvrfaQTrQgCYBp0+W2nD+P2+6QBuoEL+Xme7MYUYbRr8hVzcA
	03mtDaxvy7elJ9eSosSZKM6d/bSQHP6nzHndX3oLwQdu0uI1cVF09QGVbz81YGzuJ9z9fdbUecN
	+cWN/YbQFdiOocTSM8p0Ic8zme4RqnLTH1qvKZa5uHFp+UOgH5yv4uGv3ln47ZHfjaTCX0ulXrC
	yShOWZY4tyBXbo6Jn6bB
X-Received: by 2002:a05:690c:9988:b0:81e:a56f:844d with SMTP id
 00721157ae682-81f4d674777mr8493697b3.34.1784822152252; Thu, 23 Jul 2026
 08:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Seungjin Bae <eeodqql09@gmail.com>
Date: Thu, 23 Jul 2026 11:55:15 -0400
X-Gm-Features: AUfX_myfn2FaMlmkA2LiuJzSjqX_ZEXsJgUtW-kCkzcBZ33Swfp-26sycjak0aI
Message-ID: <CAAsoPpV1WtUsPRtuRHQb8VuCvMHYHG2K-NU-LKGhFL6rWBdZHA@mail.gmail.com>
Subject: [PATCH] Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Could you please pick up the following mainline commit for all
applicable stable trees?

commit 875115b82c295277b81b6dfee7debc725f44e854
Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()

This fixes a heap-buffer-overflow in the ims-pcu driver that can be
triggered by a malicious USB device. The missing bounds check on
read_pos lets an attacker overwrite the index and corrupt heap memory,
which can lead to a control-flow hijack.

The commit was merged to mainline without a Cc: stable tag, so it was
not picked up automatically. The bug has been present since the driver
was first introduced, so all stable trees containing the ims-pcu driver
are affected.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")

Thanks,
Seungjin Bae
