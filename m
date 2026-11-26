Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661111;
	b=0Pz7rQMU9gKGItrQriyrA7QuI6rPQSMdy/7MDpHe5L3Yla5pEI3ikYewX2x5o3x9Plc2
	 V9u3EDIB8yNknFmEEps7aN/WxqwCbnZX4Y+8RQS9VUXonUSHzu8ie/oJNyck92UDYlhmV
	 97SVV8RHKoF2F4yqqxt0tK0I4NXR+FvbA6TJCRIFKxVFLXcPcWxafm8+Ru6Z5hK+kVqjN
	 I/oRPTbPwI1Y+AoO9rSGzhOjow0/NZcYWxL8B8I8JiFJimUHeRwSIE6Cc4VGWrskLe+V8
	 azMwOZ/bTXXYcfOCwV5g/qCzxHf8gqy9TVzJD/Su36vn41iiWHamYPcoHhfFqa7G3Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=IxmkvXMkgQnOwD/l5V13TcFkz6M1bjc0D3MhK7eHCco=;
	b=ONo7jOqqtegF/bPMPpX7wZMaTT76YkidP9DDD7tAzElA4+9WFc2eDzXlJLLfn5i0RmmV
	 PGl9iDjgmvzbbRZcF3a2wwg5mBWMzQ5f0Jnq/FfvodqsR41BnBiEHsLPMgdozIRHYLQAh
	 BDxTDMQ9nPqQxMSaGuEVIwlX6pqosByHZ7ozZmMdsn6PkecYEjS1OXG9qzrej2J4RPDeY
	 N2kxwytTeEK65sxOy6gCcWfvXVooeRkOERr6yhGdsNdS/DiOnMgeiYZFCWlq4I1/qlhuz
	 uoRai0WDr/k2GGX8ODjEmZ/+ERhRwY57eWUqyzi3lTP9K0zQI7ZduRSRdRwU7jp1SAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=NeSlEDu7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D3606A334
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D86D3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=NeSlEDu7
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67df3b1ca06so7322298d50.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661110; cv=none;
        d=google.com; s=arc-20260327;
        b=sByfn7US3bse8HGVKFIs5eVl4ddxTYkrN4YlfDXwqlQVCY23o4IdKMm19TUiwzPwAq
         lDsnRSeIN7v9/fdW1eqRaE2om5NFSc10KPvwNH4KmfLNZiFFif1MiDpU6tzZygOfySZn
         N3XXDUHENhyLehj8bndA1Jq4cjjhVWXrKhfRkDA+OK4aMbtb+vth/GNmEk7f3i/km4t2
         SdSrpBwQBaghxrenVlnAzO5tkUOeFuq4HwHXPQgF4J6GVeL5n2Qo1qXqU+WMTYzqMr28
         aH+kL5wrYl4FTaNwRLCVt3xSO5W/YPtZFuFbPG2bf4xJZ1gK4/KocdjvEv3oCk1zLhdl
         5B1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IxmkvXMkgQnOwD/l5V13TcFkz6M1bjc0D3MhK7eHCco=;
        fh=Cl8p86fIxraTdAPl9TMEjG1uOAHTz1nspTZpzog1E7w=;
        b=aqRg0qxjw4sRSpF2Nkwqtyg407JHZlcgf7DitpEhnczE/ilV3gDVYPHtO/ftUgbr6P
         be+Tay/Si7RKkCQmKWx1tIKbHORvnqNS9QUINeFxKih5ColcTZuBXERBNYk6gAH2aiDs
         gA78bSRpJz6BX0sHAajtSNs7bQLVhpw4IWvD/NbnodcOxx0eXwEup9MJvH2Cv1NmF+Y3
         /dPh++EWspJDVcZ5ITozYBeQHmNMM9ffgGfNBl/IJCpti2Psa5peig0CWFKGC/8bAhAV
         DnO4BBO3ZFv8yqTaCgaKdLC/wkDtMoBAOoxycO2DFXFRLA3qZe0Vuc+LwYNZO/lyH5Ww
         GctA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661110; x=1796265910; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxmkvXMkgQnOwD/l5V13TcFkz6M1bjc0D3MhK7eHCco=;
        b=NeSlEDu7xUng4HSYEd263Fxb8S5qY0yxzhk8oZq4zTOCh9UfFU5+ZUfPN3X6v6cnVw
         PV+1vM39EsXN8upan+4jaaSe8Td3w95j2vTKN7lJ+5VFqI40XujO7b572iGw2bSlWTSo
         SFAOB1bnRsirR8QE1wQKi+Cy7Yn1IIFwDrW98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661110; x=1796265910;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IxmkvXMkgQnOwD/l5V13TcFkz6M1bjc0D3MhK7eHCco=;
        b=zppQ0C+igkrDG4igAg13sJit6Q9hbj6/MyVTo30IWwEVGE/cOkLisFVoQG7V/q5CHM
         z51XeEKCerXhpb/ioUVh8FGtzwXP8Itv3mCafT5D5CVfO/dQJwdpQQJuRfiMakxU89kz
         I7ut0c99tVIXLm1+UT0nJdF66aQIofWlrNUnbodSSxI4OZIek9TXzjGAhIVorDbGz4W+
         I2TGgG6IyADRLvFFU9FR4/GZSC5NyF6e2R6//aSv5ocTbzkiHuE7rP2SDa2NsSKzqPrl
         eNNhrFdcigiUFIwBAPt+aX5gCt/1y0vPKG9N3oNX/AZF0rxjDy3BATzGSUFptxMTd175
         oQyg==
X-Gm-Message-State: APuU4Z/k60TtVRiuK1IHc9BeELjQJ1YMQOokuquNhFoqZ/LA1AXvIN23
	/JxaBkWOOO7RJdzqhEHxDe1SLfNRUbUoFP1MRF7vojt0eCkphv4Lt8w03GouHQkVKSiRrwTyCS0
	qm6cviIwIYwFukiCLInqdeUUH9+vLlz8e74eTJIKDHUyAZELHnb1gWyI=
X-Gm-Gg: AZFdTZconcVQ/uf6jcLPVno+7NW+mOlJqyJNiTZXPzluNLh7uEt1QqXVBefs+1g+nm3
	SDYh6NLhU4YZ76CsRYVrm9kY4gxJCRsAKgQq655PI6X7WIykqZywW1DPez7zUAM/uEwHpZASeh+
	eSOlgUDdTKQTgoX06irfZcosDrXj5OhPlXZ9e7emTaVIpwkwqYFR+3uAGEiTLuHLZfWuIlzNP3y
	E6zST6JWO69VcS1F14aa1U++407nfraVu1Hj/tpiGHZdTMc3da3dLeHMLBGavCdlla7J02Q+HzN
	G3Wekkb0xGfs+SCIXkRCsCmzqSrNlOmcYltuC+EJbY8jrqxHQ0AaDiFErb7spTRq5ikatNwMgDj
	SXqciALQ5pYInuqR3g0LhhIIJFK3J2Y1WBtwvypEkX75/13K5XdodeE/EOuYYLU+W099E8xeqhf
	HnmwLj005lLpRBgBmwyOXHFN45swoVB1SnruATXSOgxOPyuTE8GXfLk04f6lLM1BBSBzN8/I1W4
	iMquqq4qBX0IpI99378eZJU1MjPelV2j42F
X-Received: by 2002:a05:690c:4a05:b0:8b4:f721:fd62 with SMTP id
 00721157ae682-8b5204e1c88mr77562447b3.48.1795661109957; Wed, 25 Nov 2026
 18:45:09 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 20:45:09 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 20:45:09 -0600
X-Gm-Features: Aa3M54o5fUDzNBLlbkpaC0Tp4I12r9OHBhk4IL8Av0uSQDqS6MfOSLPwSMIrhQE
Message-ID: <CAFaZ9erbsK1NBL42AdhkATgGz1Ko9Cqweu4Mzcn1xCf0+NSTRw@mail.gmail.com>
Subject: [PATCH 6.12.y 0/4] virtio_balloon: quiesce balloon work before device shutdown
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
	Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

This backports the fix for CVE-2026-90129 to 6.12.y, the same four
commits 6.18.y has:

  183a08715af1 virtgpu: don't reset on shutdown
  0d8aebe089b4 virtio: add virtio_device_shutdown() helper
  29536a923a94 virtio_balloon: factor out virtballoon_quiesce()
  7e17eef04600 virtio_balloon: quiesce balloon work before device shutdown

Since 8bd2fa086a04 the generic virtio shutdown breaks and resets the
device while the balloon's work items can still be running against it.
Patch 4 quiesces that work first. Patches 1-3 are what it builds on.

3 and 4 are clean picks. 1 and 2 needed small changes. 6.12 has no
reset_prepare/reset_done in struct virtio_driver, so patch 1 adds only
the .shutdown member. 6.12 has no virtio_irq_get_affinity(), so patch 2
puts the new helper right above virtio_dev_shutdown(). The function
bodies match upstream.

Tested on v6.12.119:
- x86_64 allmodconfig W=1 build of the touched objects, base vs
  patched, no new warnings
- x86_64 defconfig plus the touched virtio options boots and powers off
  under QEMU/KVM
- The race needs a balloon with free page reporting plus a reboot or
  kexec while it's busy. I didn't reproduce that.

6.1.y and 6.6.y need this too. I'll follow up for those once they're
tested.

The four patches follow as separate mails with the same "6.12.y n/4"
subjects. My mail setup can't thread them under this one, sorry about
that.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

Thanks,
Dickson
