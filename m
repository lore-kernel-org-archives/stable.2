Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596347;
	b=ExpG3UHg/tttDDPZpI5AJM/x8bPEQT8kw8+G5XFHU6OM21PyJaQ1ICKqAwwkbeE/CkMt
	 nc79viRO8Q+Ssscr9iQ3IBdglFUTCP7OycwKU5qW0Qin3U4P09o5hJX+Tro+uJwakNBLw
	 SMKj3ID6nFEjEyxP3zZw8KZQ3flHIZ6jOMXHsFOWqdMkw/3Kun0GsBpp6+X9wOZf8TT7A
	 /KiN37mrNvFc6EduPfMsUKWyAmJF5JJaghnUqKjq0to8e+nFFvv6ZA6WLY4rezaUOKjFl
	 V2zLiv/yHrRjFIryDfKyxFSfgGG/gNK+OM/sx0mYwN3BCWFRcWNcIzlbJYZkBmU+zQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=Bi6SM16UMqYrDjnrIDPz3CnPhV8n1NY7lKM/zRXBuv4=;
	b=UgtihdbCmuHpCtnySDm7yMLeDke0ki/+2k5ZyFpYa/hIEpuGkFOs/F+t8db9fL52bYUc
	 kUjDh80NbDmyCAGZRdVjdN9MntKVomaJtcxV1MCt/hKdCaB0YQLCP8KhuW7muFLS3kCLr
	 EnpTE9gOAYyeBuq8hMoUp7zMPpyuusFy7AcTZPJTiaSi0nIKt6ySDt2UOGP9+QU0zf0zA
	 42Nfhlbgi0sRhUx6ZXNznIfX6WqYmKG7MY+PMWgAzIwYegsJVGv1+dFBPafqCYmZ8M1oy
	 GH6rQzF6K06S7RVAcCACCMHPl6zyPDhF9RIUpitLBqrl08bbJB056ew5SA+kZzKUN5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=R4kX3z6v;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358D7606B2C0
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 18:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 358D7606B2C0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=R4kX3z6v
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso1719319eec.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 10:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794596346; x=1795201146; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bi6SM16UMqYrDjnrIDPz3CnPhV8n1NY7lKM/zRXBuv4=;
        b=R4kX3z6vmqXxmg9xiyYZAz86tH4sjuUTv2q4J5uVPbnAG7d4s7dSD38Fx7X1FBHWFc
         m53lQd2QM26fNw8S2g/Wq5opj+sK8l02IzUqIXN4TkHlc+3LwoGtgk8Fiur1UjIIe104
         4/U7i9o6XgyL6MHA3mdx9d2IH1oj2AyNSzqJB5MTotpmYywobJRAPv0l37YD9v/exFdv
         AxRDpNIdM3TdMgpeD4C2yS3uPt3eN/qcdvW0g18vT8fgNMJLsxRpy8vpRXiVR98vLlra
         bOAhU5rzMLd1grxzGquprAcpTWq+4DYx37kLHgGV8yHd4DAVHNa3rFfmSYRWtOdS9N3A
         bKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596346; x=1795201146;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bi6SM16UMqYrDjnrIDPz3CnPhV8n1NY7lKM/zRXBuv4=;
        b=HcxI+9VSwQ++Ca75UME10V0x51G/G6YFOyYRyQXVpyS1ygKvvZA7qtt8IVYsi6Uu4L
         1dsM1fF8R93kbeIlRfgMwRhIO60qH2JbGQSjSE4eUrqPVYST4ak2BrI6YaQryXrvmaQY
         t1MnYZSj+0F5Cx3aQKcifmPhJ3xi7/9g1Y2DefSjp8naHEvoMX0Klm5wCX24WSUVdvjG
         EtTva+f0lRUVsBVTd4e71jkbAMGDnx3cMYmMaL7SvW2+Dudn4GGU5X5oSsDmz5DMiUib
         RVIeL6oG6ktRrIkGEk5yOkmFh2f8cJkx9o6IUjOSU5yMXXWPqsX8vmk1c8wcV5VjC1kA
         VrNQ==
X-Gm-Message-State: APuU4Z8uTd/ihFXcQWbqh+/5882nz1Lvl2aYBENs6qp0QUvj7JXAQxL3
	ajK9G2SLRBdWa3HHNjEqn2hkDNzbIhAgfKaVuqtBKqzUwDuzEn3pHfHxsynMsSF6QxjNRv5pqkL
	y614m
X-Gm-Gg: AYBFou1HkmZN8028GFT3LDSF9ZY1V4YykCjRgl5Mj96wXycAyzV5SpC62Mh6GGoY0nL
	RTsfOgKOLfADql2kYWp+VPi8NkVQkdRNFyg3zEcPHdVZb/5KnLvmlrveJxkSNvPvicggz6lZu/W
	0TyEN6ZiGmQHJ9zkFrS5la2q2nah3eHh5ZWNme5xOfXNHqsj2YHcjoffgjIAPIJkivqPO6fKH/o
	/5bt3s+9fAR87uPdnPmRFsignlpx+35gdMS3/77G92iKdoJrzoK7Uzfghm7K1xGtnp3SbIlhBZU
	yW4EmqwWg3fBPeE0+XrAGfJvum2guSLQjMqqjd7F7/vG5hrZJzaDT806DXvHLLM/rvmnjRLwvDy
	uEW6vh+p5TfSNq1HUbeTS3brrlDEJAI8UUh8kCiWM4VodDU+R5+VcDVeWhHBgqLMIMCAKf6AyJY
	J5ACY0DKY04eNnjo/otS4y2sED5G6nAzZSBFNRLlCgAk8GU6sbSDAUsI2ffKF0g8CO5pN2jI+fi
	3jhL8kr/0H3ivVWA7NzPrEr6Wb6xP/CSQJamrLwFRNIpZoSOeezclSSeG5gmDewuhH+uTQDpYYd
	uVC/fMw7AKEPHX33sGeh+Q==
X-Received: by 2002:a05:693c:895c:10b0:35e:f1a5:9ba6 with SMTP id 5a478bee46e88-37963a4f1femr2974890eec.5.1794596346128;
        Fri, 13 Nov 2026 10:59:06 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795591f4f8sm9612078eec.13.2026.11.13.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:59:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)no member named
 'set_vtotal_min_max' in 'struct timing_generator_fu...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 13 Nov 2026 18:59:05 -0000
Message-ID: <179459634484.47862.5334006106332979492@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.10.y:

---
no member named 'set_vtotal_min_max' in 'struct timing_generator_funcs' in drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.o (drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:389:16: error: no member named 'set_vtotal_min_max' in 'struct timing_generator_funcs'
  389 |                 optc->funcs->set_vtotal_min_max(optc, v_total, v_total);
      |                 ~~~~~~~~~~~  ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:e3ba3de4f8b5e1660c9199a6b37406d863c591e8
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  a320864dd7e3be8aba44919f934c03e20b015e0a

# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6af738195b429d354e4dd8b5

#kernelci issue maestro:e3ba3de4f8b5e1660c9199a6b37406d863c591e8

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
