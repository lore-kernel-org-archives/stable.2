Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496401;
	b=GM3fy1WDf/ARkIWkKDDry4qaDmlLuY1w/RS7ByNl4lofP8EseqrKcpl/Nc7UQa1hYc52
	 /3MCOFfpJiRs1MkW8eQJQ5XlFgUoIkP8PQfxG9dN5oPfxh5QGEVOFvtlpFw4GWkaYbY+p
	 eXngxe8JYwvu+mnu2bQcgOZFrRHFYYRAbOI+fcSfIG7O63JDuadPlmY2Z2tLZKzOAzXS4
	 xm4bifSV/iwbwbHmEeRDKy+Ug0A6MxIsUJRE61OgGOFvq8NpOhMoGspv+XjssqQOlB9X+
	 hu7cTzobAnmP73LO5eoVAMIV6UvisUUPaSCID6f0VKKIlY83RNBGnKjI3qAoJHzyXEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oW3CDQ8hWTvJxUFgrwX87dctU/0QppQ3eb5Z2AmQA5E=;
	b=m8zMq/7mtc0qGDD6TgqXQWsCQb4chM9YnUIlYSER4ipB3lwMoiU5pbvlEww/cqfzCtYJ
	 zuH+Bn56fw3xWGlITf4u6sCEwzJhZ+Zh6hSiwJ1yq9MWJZLNu3r3QrsfCAHiYN8zBkXIY
	 Fj7Q6CoewBXFsv8GbDNqT2TessSFJKqeVYKqnB/KT8sCTSPFI+NoBdQtNmJtaCTwLa2XG
	 QLzIG+Fr/J/I8K2GgNgNM1pB6toAwe9HVslykQFdgu2nXgCyLX88ZWuOFJQR0LPhAGtSr
	 FCYDzR6JkQoxE3ofUQMuny62XiGg+6n14nJSqRcwX5lAYgjR69qnh5ukKYdNgzGmAag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pnbqEWqq;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC5606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88EC5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pnbqEWqq
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so435224f8f.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 04:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792496399; x=1793101199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oW3CDQ8hWTvJxUFgrwX87dctU/0QppQ3eb5Z2AmQA5E=;
        b=pnbqEWqqPXivjtNzYZssc4sPi0e5cT8ldBrc1e4TlbBt1++lqwYJWEp7jmGnWElU2D
         S26ldoKeRJGFACatqK3dRhiLRDVaRBcHq0hp91y+dgoxS1MZPCCa3ySPtx8K5ZljdOls
         UzpTg7McrRchDHMLyZzBMpYKAlJkaww4rZahNmDRHvmW20vbOS/rztuCnOjD6E8oYlXs
         G1xYxYEpIFq1nSrG6M40wvp2AP5b3EypieCbqq4MgX9v97GZy6PiRDmDORec2MjESsaV
         xx2FHio3h8QQrmPWQ2V+T4fw5CW1P6qCs9laIdM6QrJ8qeCnuoqSrAIHVmNucG+8PurF
         heMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792496399; x=1793101199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oW3CDQ8hWTvJxUFgrwX87dctU/0QppQ3eb5Z2AmQA5E=;
        b=pU0VuMVn4qrCtahAooWOp1GgnLhjSux7lI+jMLbASM4410ZSmyRtka+9tgnPB/TiZn
         AyAbYo6FtgF2cq4mrZL8C1RBoJCiF3/ZcXkjsJdJGREwwmi13yrjIpPF4d7ksixvNsh3
         ckMLZKXsCYPeDolYTlg/62lloGRiSKnTeCBNTK6F7lnGKC+Xcyh/BTPgiXt+jGJmbzmh
         oNIMTGcVZHJsGdJKu1v+wf9n/+o7HS86wtR5DxLSAFIeNaKaBFOY1lqD0HXKi3OgqqGS
         0KRkusPKvrpVKuvPxw4P8r3EZKRM7rtbE4PrO+IXxxrbKEB8rAlUMpM9w+FpV+KkTQg0
         G9pg==
X-Gm-Message-State: AFq9FYKnqcNuTYSVu2c9OZnGwh8QmY6OVe5zc8hqu9IwMkJtuHo3X4CM
	moEkmq5GtUyL0bkJ6s6rOYu8RIAXmZHJ4foi+IEc4gcAgF9JuWdQRGlw
X-Gm-Gg: AYBFou38Ldoi6GDa+NxI+DAdvWjy5jgUywwCU4/Le2gAQiRopbH6Otm7ztuvFIKekRc
	dAQN9mRbu24ExGBqmLIkinqSRqpLkYRwRiBhMjQ0E5HbdaV603TriMN3ilLoxpv5l9XupGZ1ytI
	9kYhAC95NOvkQk02rScanYHakB2WZmkO6I+/Sdlnxqp4IJsmxIlk/4B/5FK1jniGib8hWy9DC8F
	Hqpm+TEFZH2sF+dqerg44z1YFzHQL3dL9R10N7EVsPWFe9Dfopsjwx3Of+/FRgCb72qiEEm4n26
	thL2ZSmw2liQO7Y9EyXUHbII9Y5XBm4EJYK4+wKywaE9ozOQg+GvOX5rEGUfBYGv4Of1LolM5q0
	Mp5r/0YRRIgtUb89gEbYUP52MeumUGMX0y53gUIfc9l/KQolw5hvZbRgdUaUEFIJxFU2V5hVZNk
	QstKJXmdF3NWv2swj8dz7W0IrZnbgU612t/fQWWsWeQ6SJ1O76rQ+Qw8nVJVQvcC0qpw==
X-Received: by 2002:a05:600c:4e04:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a1f4c7f3c6mr41266915e9.5.1792496398642;
        Tue, 20 Oct 2026 04:39:58 -0700 (PDT)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2c242dcsm62439595e9.0.2026.10.20.04.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:39:58 -0700 (PDT)
From: Andrey Misiurov <andrey.misyrov@gmail.com>
To: Alexander Antonakakis <alexis@maich.gr>
Cc: stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-scsi@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	1151377@bugs.debian.org
Subject: Re: [REGRESSION] 6.1.178+: lpfc: boot hang due to use-after-free of mboxq in lpfc_sli4_driver_resource_setup() backport
Date: Tue, 20 Oct 2026 13:39:57 +0200
Message-ID: <20261020113957.951380-1-andrey.misyrov@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <29f6c901-5209-4681-81cc-ff768cd405f4@maich.gr>
References: <29f6c901-5209-4681-81cc-ff768cd405f4@maich.gr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 20, 2026 at 01:23:03PM +0300, Alexander Antonakakis wrote:
> Moving the mempool_free() at line 8178 to after the
> lpfc_get_sli4_parameters() call and its error handling, as in
> mainline, should fix it.

Hi Alexander,

This looks like the same issue I came across. A patch doing exactly
that is already queued for the next 6.1.y release:

https://lore.kernel.org/r/20261008184328.2857037-1-andrey.misyrov@gmail.com

Regards,
Andrey
