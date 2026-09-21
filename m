Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60E471267
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986171; cv=pass; b=rM6AzANHztf8BvkwuLKaCOncuseIjGX6Vzp5ntusLreVkRf6HeildEFqxQM7r5K8dKKMKZ0K7haN4W3CEecbyNiI4NSTqcGOoz212Z8OYgH5ixsdjX8/V1WuSjTrvezt/Flm6XmRWUtrFOaWPt+OKmMKWpeTZcjE+jdw/fxpdbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986171; c=relaxed/simple;
	bh=jxiUfSa+budlgOb4deQ6ne2o5T4IBUsXkRWChU/Uls0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unWTaAJYv/1v8PGxQzKNWxWBTyCk5I3+bwEYqiAS2SiEG30HSKPdgWr8wfFE9EljNrIDon5BUcqwuW1GzwNkQOsq5Z94DUD6P8x0COv8WOCgQ06yfSRa2v/NkuGss5QbVc2AI6+60bGYGFrtOT8lGlh0oZ2rH8yz/W0lde3U9jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA6Bsv+I; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA6Bsv+I"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4d04d740cso1656590a12.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 03:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789986169; cv=none;
        d=google.com; s=arc-20260327;
        b=BajtC/fDKiBVU2zZAoRiO0tCc/laMs2PheMjRfkfU6h/IC56mFb6JvaEIxiQXikWqb
         L20MW/opnt3SnlWxWov+UlmPS8u5qDTIbraf+jh7giB+qJmL/a/6rUt2Bq0kXzSaWm70
         nxEUKGWrTuRsyztlGs4XOIB7xHHcXRjX4xp/Xlzw2teS63NbkzDxaoZl5xuIxlpZpaaU
         8hx2FB3I/wYSE2wtvi7MzhDCOkmTiS2yAkEapB9MnXWZhsBKRYopensbtYGLYqGq7vMc
         aaDQZGCgIcMCTWlsWVxx8c31k50SSkjrtT/PhpTsgz+UBkOQVlvBn+Pz7fKvn4SuqtW1
         GEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jxiUfSa+budlgOb4deQ6ne2o5T4IBUsXkRWChU/Uls0=;
        fh=hNnp9l+2UFVjYOQ44PQIlxgKOsvQ+JZ4EtpD62JNt+s=;
        b=rC5/UOYV/ApvILlc1ccZKc+mNGcDph2q93rpuT9Vl9oV0mtcsm45S+JaDo8MNZeAIc
         O+2M4on8RSOd+m7+e1YGZR7RneG/eDkHeu7SPY42dFV5oQiiQ7jx1VzTjdp4jZNstuTg
         WSRBerbZ0+SuA8yR3nLY+rCAI9PgDkk18NKIYyyoky7Tv63i7z8xH1umGVCfqZ2f0yJW
         U51SiFY1LUy5zKvf5ssQmJkUkdr4DsCpR28QaPqFDi7JJVQIk1fmNYwHXVb10vI7278C
         doaHeEgmP5IcrvluklJ2nH/x1JQWivNWBBjKFIRgig86CnnmWypcp6+80AbS4Y7Olv6R
         W8ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789986169; x=1790590969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jxiUfSa+budlgOb4deQ6ne2o5T4IBUsXkRWChU/Uls0=;
        b=GA6Bsv+IbjKXDV8Z+ZUxLSVfcj49O5x6PQJCBF+IBGTeLPjicYnO5sTP70HqUNXWu6
         zutnluptb+2nkx3MxD3mYtrxS/FLUfJ/NnumpxyO5nLSE1B3uPJkcXVOQxVAMJYsdtuJ
         Jf8CO6ges/3Og3148pE7WWM+9RkBxsgyfQfq0d10b1ns8TLsKxBZF/ySPAEA5Iq3Viq+
         Q+gYFGRwJYetsslUDK/s8vKvSBMEJj0TqUh84y8ZbERGVqYArVgXOBvrZGA+q4eAfcO2
         Bfq5eVWt7/gbaCnj3qiL2MlszeLpJUDU5og1g6VwZvGqvhxxotkYUkAUOhjcn8maCdtq
         NMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986169; x=1790590969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxiUfSa+budlgOb4deQ6ne2o5T4IBUsXkRWChU/Uls0=;
        b=RXqQpmcl1RaNHvThMuS9O1jtxDKknD062LDggDI0nzX2aY6kZ5K7UhRc0UUclVlIx9
         sj1VZqX+zJ6e6YtScbk1hEcwnjmpLlYwEmyzdOQYuAmPKvU77OkzH4ZXkoi3EBbruXXt
         498fSt+Cul5BklTVDhTpabjClNU6wxnE/HDWiP+LEJseAR+/tnVxcfmsRKPndqlHDzwc
         x4E3KfKxM4FRXRXB/Lui+LTx4JRhdX4WM35aShPAUuZPhkNfyoSAhUZkl9uPGgqVkBRk
         zqjbEgvuvFhANrT2r9TWJwKuLMSdsvLAyzyRIANBT+ZbcV2berO3R3m8zHA1DgoZIVe9
         /l0Q==
X-Forwarded-Encrypted: i=1; AKwUvBy8uSEVr6MvutZnnajtTxpKwH6zG+bJNt+RhqUBcuvpMGl5vK3lRF/eWoZpoogntFJmw50oOKw=@vger.kernel.org
X-Gm-Message-State: AFuF++kbUlt/PNvy2rvg0U9J1tt2P/6JhBtPZ1Nv+Tn/IBb+B/WqJ2+r
	UkEPO4BpxBxa0VNu5dJpV5QSlw9eBeJF6lm9VJi/hoNUB4m07p/ZfInC8DlUQBKunv6JAcdom8U
	Q5M8fNmiaTREw3VQjr2UwzvdQ9+bCBKk=
X-Gm-Gg: AYBFou2HcXjmKfXEbBLqfn6fnouIQxgQRYC4T2wSERxw3kjiQtiPSg7MTV5XwrRJqxW
	3/6d6hMqOCjXt/dVPsT0G/DGCv6+7OQRQbL5L90H+t3tBsHwzIfm+IdMLv+qhRJSGd0BUwqcyIh
	kMHaw/APGxvvId2qFrYkRahx6ohF/WtzB4ak44qf3XCx2SokDueymDxNRqerHV5NbTapLb/UTkp
	nMdt34WXixnsmuli6QB3Z3QXHk2WRcOiTWvIrWhaBTN8NQ9EUYZK7YTYfECG5LxOgrM0MCP0dMK
	jicMPEKbB9GFqn50dzdd6pClxlqbb0xhaCeH+CzZeoJdvk/JMcUzqPX2qWuLhcE53c7lRTfop8W
	b689DSRlrjoVC6vPXLqx44iMy9xSG3Djc54voZ5ul+HI9WdLmVvmmyGwE3/ACmgZiT0Qju6uSsw
	==
X-Received: by 2002:a05:6a20:728e:b0:3dd:85aa:4525 with SMTP id
 adf61e73a8af0-3dd8c4f0d4fmr17653691637.32.1789986169161; Mon, 21 Sep 2026
 03:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com>
 <2026-09-20-daily-reply-0011-re-hibernate-preallocate-deadlock@kernel.org> <a40f9988-7e82-42f0-a27d-7a7c94dc37d7@leemhuis.info>
In-Reply-To: <a40f9988-7e82-42f0-a27d-7a7c94dc37d7@leemhuis.info>
From: David Lomas <david.s.lomas@gmail.com>
Date: Mon, 21 Sep 2026 11:22:11 +0100
X-Gm-Features: AcwNN1VGK9eJqWQOMs5ndg88mO9M-KWXOKX7uR7KJ_FGuaACwylQwUWYMMOnr8M
Message-ID: <CALjEBWQrDh5KrEscjVutk_H3a0+jH-=DOa=au32z3aZq20fxug@mail.gmail.com>
Subject: Re: [PATCH 6.18 0167/1250] PM: hibernate: call preallocate_image()
 after freeze prepare
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, rafael.j.wysocki@intel.com, 
	gregkh@linuxfoundation.org, matthew.leach@collabora.com, superm1@kernel.org, 
	linux-pm@vger.kernel.org, regressions@lists.linux.dev, 
	Florian Schmaus <flo@geekplace.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> David, you might want to take a closer look or even try that patch.

I'm building 7.2.6 with that patch, and will run it for a few days;
obviously hard to prove a negative, but usually on 7.2 after 2=E2=80=933 da=
ys
of continuous use, a hibernate would hang.

I had one more hang yesterday, captured with SysRq: the same deadlock,
systemd-sleep in throttle_direct_reclaim() under
preallocate_image_memory(), waiting on the frozen kswapd. That one was
with vm.watermark_boost_factor=3D0.
