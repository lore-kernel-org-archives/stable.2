Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5EF414434
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069971; cv=pass; b=m5zow59la/U313I6oOV3pnOq9jG9pV31IWPwGo64SlgMqJflPHS0+Hwa4RmGaRuUWJ1k4sxwCyfW7vtd+/ALdpAmemhGTslXgwvYs9ockb+sNySiHBMikBWfORLWmuSfmPPp4kPmp9R2MD3bs1AI28GNoeGGtGb8GsqYB6sqXiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069971; c=relaxed/simple;
	bh=5BYR2LAlRCG7N5sJ/J8MZfMB9gZi5CyLaZoJi76cKSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=to8urZYmJsxIu/TSnlHqjaCflsN2KZkcAdCZpEgAKKSUDg7aLX+ZBsml7b1PU9uHHbE5BtmckfmPTNzRk+wnnEYyuUls6ALdSJN6RUhs5PMxSd3CG19FsEKdxcLdMkKPvk8d0Djjpa+O0F5nnAqUGCDDpHwkaiDxg7WOaqlLeiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDrO6TR5; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDrO6TR5"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so93543f8f.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789069967; cv=none;
        d=google.com; s=arc-20260327;
        b=aDuZM1YMDJz6z1cJ7npZQzpVtCRglk3+oKyIUu0OjPu7x9aY2YPpVIB8NnpIuW7icz
         1+MCNu1LsV/n/e9JmPKE54sOdV1Bn4L9HkyXw1DTvCVKQruOiogdW7obdPsPkfhFsqbw
         hZwUBeisnwX0HaQeEe4zl8JAPnVz3ztwbl+y09pkoMbWf3+h1GgNwm+6LkqZjZ4xMM/V
         vo+enAJImTHvoKqwJDFTkFwLn3H017qy73eVncjIQe3XyyAULLITW5dEkq3tv3fupqKA
         56E9vPLLyg/RtGal6OBNVdTNNgN/fl2fTK6BGlaf5k14k9Sp8wripqvioerWydvp6KP9
         VDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5BYR2LAlRCG7N5sJ/J8MZfMB9gZi5CyLaZoJi76cKSw=;
        fh=eHm3gkqh3jr1UMbHjBx/kZgXyGzlV8Qj+ScJdsWKwgg=;
        b=OQVEwy+pX5Mol0mx3TQSCWZLq0oMA72/J5FV1n8/bZ8OVzBRPjlRfmTbMTv6exYnof
         SYiy4NpvVtZ2p5AWJsce4Efm5lWfo/oqRmY+Sacpg52430s4aAzKaVUHknuWWRlLRi06
         6/spEaCWfv3pNdAVwvLwVgMhs4CtOokAjRAbuyCXMatgcJ/x4AvNfiKRZGARbNpsH6sn
         cfQ3Q4c3jbvcWL8jn6W+yBnrpADcd0qa8C+6mIiPpZCGdCniLSrJ1ZSH4UbYvoDdB6G9
         RlUEIK90y9AoON4cT++WdvMhzJeTpRrJY2IrOL721q76HaK4Fe4MJQyMKcVMAZfrGi98
         SyYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789069967; x=1789674767; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5BYR2LAlRCG7N5sJ/J8MZfMB9gZi5CyLaZoJi76cKSw=;
        b=PDrO6TR5mHiQ6mkfx3NfMoUR+P1inFsrAZ095Ddog1bZa/C8T2HrTVJucMd1/wImuc
         VTYJ53FTrIo8pO0o792CjTEcUs8tbp8u1Nkkz/jK/MhRyO06432FWYfJ6FLew3FXjubO
         PlY4oU/WdLAF93SxgxAcYKhj1FRrtm9O74Go/MqEZ503bFBZjm0JEWaFBmrCz2tLle81
         zYQxlODiLL5k9wC8kwRIjWrcqyMbHd2Hweovjsji+1muXNvY3rvoOOR/d78cGdEIv+Ff
         Kmsdq3B9OWUgaBgc7aENU8I07kTfkdgkrotJkws/Mi3Hqzu89rTynCZE/26hSEPmocjV
         FngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789069967; x=1789674767;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5BYR2LAlRCG7N5sJ/J8MZfMB9gZi5CyLaZoJi76cKSw=;
        b=Dt37+3v+UAJ9IwlGe8Z2Sn3qNJvCyI1vqJMba2fDPyf39goJ3f5LWcMGsvvYhM0BJ7
         aNimqkSwRaFqIcA6YV0c/jUhGJI3evmWDN7gVl2uw3B08Q1s+cdisyLvlvYgXgU+jYbf
         D8TDmt9kemy0S1QgQVUwkY7+WiPab2Q/zIo2GS9hMOblMQB+YF5km7x1GEyLasqqIar+
         Z7hC7ezpz1m+or4plZ1PTNPYs4l/nxLuOu3J1qVZQt0BaLthZEi7m1ruGBZGcAcZvxyc
         +kTalwAehUJief0Qim4rW+0Tk0fYgwzRPkRwGTxGK2D/2vZznMwsVPvxy1PkRYRZObr7
         45Ow==
X-Forwarded-Encrypted: i=1; AKwUvBwkxbjCtsh/gMvcCU1kdsliKopP7ebvzcVSLm9G2VCsddzgP7jptu2NnlGcEvIlToRE2yzfaUc=@vger.kernel.org
X-Gm-Message-State: AFuF++m1dpmhrAk9BtCB8PkqQs0i6dBJFJwuuMw+CPSTDkRobsqWODkR
	gITTCK5tZ1dcm8n8gXfLgi3pLTHtteKFKkh5RVybFKtH5+gHKG3fVdLG7lZFY48tK6xDs9NsKzo
	BDLo7XJqgXWL3qazRrhcMbzXFYOJIgdBzcSxkXRcK
X-Gm-Gg: AYBFou1NkE4WZcbLgWn/uYsjQ2XhZK8o07gev0tORp2+Qq52TEeTQMsjqYW/Edsh7os
	p1f9iCGdMVr9vuFLQVUwURIWzhVMz+j4l7yH19bwTy14kX08puI/wnN5aeXXeePsXxl3wrsqipt
	iZ+bdcM/qHuye8PZuE5Ag4vkWwukRUqkaDNjrTjk8CP9Nst8VcMqMdaPbvi9SH5xmvKLKfhAo6Z
	c4SCs2BwU2EjxJaXxU2MptjRq8AmoNLcSbjHIJ5vkoLaZeMWBSEep0tQRlZD/5AISkd7d28gNOk
	G7BOa046fqHOZ0rtIXew9V1r3hRAWdqT66r28QbkFLH9XtbTgAvxE56KtQPx1/zGzgkG1Ieq3dX
	/XwW2jagnyg==
X-Received: by 2002:a5d:4483:0:b0:482:dac8:cd0d with SMTP id
 ffacd0b85a97d-486eb33ec05mr931955f8f.21.1789069966721; Thu, 10 Sep 2026
 12:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904234401.2339633-1-jthies@google.com> <2026091023-numeric-husband-1b03@gregkh>
In-Reply-To: <2026091023-numeric-husband-1b03@gregkh>
From: Jameson Thies <jthies@google.com>
Date: Thu, 10 Sep 2026 12:52:34 -0700
X-Gm-Features: AcwNN1W1WwceoXxfw7kV1OcYc7DN9h4A1Bt3IOdWqxeC9UAzLths1l0qeH57h3g
Message-ID: <CAMFSARfnRpkq21j7WZYqdthy4aC7VSPjQAKm1eHvbYxhM6pOnQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: ucsi: displayport: Fix OOB altmode array index
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bleung@chromium.org, akuchynski@chromium.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg.

> Does not apply against 7.3-rc2 :(

7.3-rc2 and usb-next include the v1 version of this patch which fixes
the OOB issue but doesn't incorporate Heikki's or Andrei's feedback.
I'll send a quick series to revert the existing change and followup
with the v2 version.

- Jameson
