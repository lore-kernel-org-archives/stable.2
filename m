Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795226642;
	b=30mPXZldvS2b2ce4U4G2ArEgYZrchzPJwnkf0jU6W+bQAOsRTR1dSkvfILPw1DwYlhAY
	 0DV42DYxORvZEFOLh3N/0jzNwXLMHD0DwNbBQg+aImD9Yt9lcDhc3a9sLvGnShNWBs1mh
	 xHOwRkA35AUblCxSGS9UggHeN3rfMskPJ3juUrbiQGQBmJDdEnsWvHsUIGkcNoVhaqq7e
	 gCvwBUzp0/xZq00FO99UHfzhFVQzZry4lexNd+9peZbxuIEVnMJH++Fg224G2Go1V3Obz
	 sfwDAs69PGAiGZ/7UOjkZy2eAbQX4ENQZ9AQfc8gwammndvBPf98nPrwz4isdXg8ECQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795226642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=n/qO7LD749+M3gSeMBTLDHa5KpM1HSgouT3z95VV9l0=;
	b=0SRhWD65lWGeQWy/4sU0I+I5nfzvY6tuhvKxHymAHgr3OgLOuQpdqj28KL9rnQvMGD8u
	 x48x9XEsD9Eg5zKVwgobnEloi/4RGqwc5hzEUwQvAKw/NkWZ8uJmKpGJbz4We+2n6XOVp
	 OmLpSIEDIUzKzCTlCYZAFXQtksAhlHX9wqEMbH2Jlr8jlo5WLMz2Cm1X/B+gbNu/kSf8h
	 VMt7V8klAXldh+cFZ9JW64hxcjDlyOOesicGFeX1bGMGfsEuAKQOoQ+ACn7ZWBJz62L/D
	 upDe1wLRzRgKuHNeZZ/ncsNrFpc8WJdhjWGJGNWg5np1JlhJMVTGvimC9v+ATGzDTLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainchimps.com;
	spf=pass smtp.mailfrom=brainchimps.com;
	dkim=pass header.d=brainchimps.com header.i=@brainchimps.com header.a=rsa-sha256 header.s=google header.b=ksZWXCek;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E406606A693
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 02:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E406606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainchimps.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brainchimps.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainchimps.com header.i=@brainchimps.com header.a=rsa-sha256 header.s=google header.b=ksZWXCek
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c5062bcb857so19719166b.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:04:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795226639; cv=none;
        d=google.com; s=arc-20260327;
        b=fxGvSGGfNiUiHwZ1EoH3xxADwuo8sUJuu8iMun7yyX5thjQQ4DCzOIEnfl/MasDIrL
         9iGIgqrvbbkP94Quz66lzMb7IKXInRdiMhxZcHj+54jtlr3ycYByQqc+jSjMB/LUA3DL
         NXMPhylznvWL7QyEigVKklCdtnlIYslwQVjktJnnI73qYvkdOsYq+jnNlvsdVPhh77uZ
         C769wFrHwkQdg/vGDmSwMq2PqmvRM/UvBMwR93MEQkD4yhJtF838Ax2k5K9hEAtJD6bg
         b79D0iTUib7cpz0rOhwOzzhX9/9FGqmcJGtEC8pERYfxLuuhv4A0w2HKGgPC6Vd8ltg0
         xcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n/qO7LD749+M3gSeMBTLDHa5KpM1HSgouT3z95VV9l0=;
        fh=GGlQ1HRZaKnOjqEEfVMVX7woIsaTRxK/vzZ66VK/708=;
        b=Vyivz5IVAQlnOLO1pimuMp89GykSwd6GPgu8NjXwYs8Jdu+lF43IBlcdpJoSh5SzC5
         UUIpA5+I3dsvqiymkh5C5PCKF/0KtTyl4OdGWxWSAdqTPIgYYM7Rd1Q+6burmTezDdAa
         1woPsqc5MqNXA98Mr8BzR3N1lMbgRlHur3Nh523V3gb2I91wokPdBH5wSnkzW++8NBPj
         /8KfQm5Mf3Ufbdl9Y/ykYvDwmdYscchOY5ow56jNud+JJ1y7lN56PHhjWFOG2tAWCFAS
         EY50ZKmIIW7WQ5c/PQyTyg8YIbs46JOIN2CTJ81+P3VltBfOY4CwmrAU9etB+u+g2XV2
         dTjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainchimps.com; s=google; t=1795226639; x=1795831439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n/qO7LD749+M3gSeMBTLDHa5KpM1HSgouT3z95VV9l0=;
        b=ksZWXCekTO2t5FjUcoMAAKs+UMn7C/6pVwkTZKoN9rgDVF0U/V7K84nJDDjniu19Bj
         P6dx6KPEq4Jn+uhfJTLZkPfNM2WBpf/RMg5BRU4EN7rGdde40Al+ck0BaPKjL5qtT13q
         ljIlJt1KP6+AbTsbkrNReJ8J4fo5mhV1hPreXPg0VgieqsLmLKZAV3AhsWsjXi0rDHva
         NTNdZgTQMM86mT027+MsRz85kh9SdJ46DBJqOr+QW57ZA64LiJJTYYbk7yFg+eZ/gBWG
         hC5uC9qQ4oUo+GUkKGBTnCJ6bvfuaOurNVm1kY04XidbHb9CmP7waV58DnTLUf77bmBJ
         edkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795226639; x=1795831439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n/qO7LD749+M3gSeMBTLDHa5KpM1HSgouT3z95VV9l0=;
        b=bHPp5z2izOlhe9APRTizR/SMi6fYfZAnzQbzoyVOHnL6IssxdAgOLJhuW+/aA0tKHE
         s52KtRKGsSGl5XzgEElJMHfKXXr2ZfGzHnOYdq9fZkWP+k7l1Hy6YEkGZF+mVHCqmlup
         8P8a9k4pi+q6iOmkHKYlw89xCABynwezDVjtDwt54dkD+nGCG4KlSIGKMxKaxQrDNDVZ
         Edf+DDbks2ptE/ZCrLtZQK9ksfAIRLi0UudEmbhxQQEuzdp2VBTZhnCDzsF9k5nRgikE
         4Pf2jojjhLgiaGSU5cShcmfaLyVFWlFjQ9x3VLOMK3YdWLVsMhXTWMIeOKmSQTaka6ou
         WKSg==
X-Gm-Message-State: APuU4Z90rVQUeijF8z+PWEpR9OWCSXJm/baBeJtDAxDVs8P+e/k4p+20
	x8XTEDmmkQpRPu0hZDTQsMPp7YhB/EMj8TNG6AlNRKxl43K3AOxwT/tnRkiP88ZCeRhVR30W/wz
	tybVXxnVBi2wKcxmYr0Bvyw9zxRy/JF9bC2OCc0McBBlJrZ3el1UzUY26pw==
X-Gm-Gg: AYBFou0QFLG0icqC0Lu13JsiH99GY5gxslYabVHtLwq6PMkv4LJViyrQKXPSXDjLma/
	lXacOyRGID16ecw+tLVxqc5IiGgoq0Am4y1TvAl23AYmDNnRu6XUSwmERS3bdjpjOwkfFiff+Fx
	6845zzORC2MALQy9pi4eci5ESDymntEKCKxgaDZegtFaIStxEVGaa/UZQsO6x7vd4SyIjLSuY3p
	ybzMWcO6d4f8y0yGPR703pCtv+N10xOUi0NhB9wYVp2ewXoslfYUBBowRca4nHz2WC0mo6MYNJZ
	1eWwh+6d/WRw3WAeX/YLSDEC2lh6hgIGuFlveKneRItlls3MB7Uzx19KJI7r2h87zhjI9oZbotV
	17bKQeIz90VNRts+FjEhvieK8Kg7Lr18ax7uWeMOf+xtJBPxUTKujEq0hEk/CGEuxz01m6Bh0ce
	PL9L/FwmfJIaDt9djy/bWiKWaRm25yI4TXtWYCRJk9q1U87lxowQ==
X-Received: by 2002:a17:907:7081:b0:c40:5ee3:8694 with SMTP id
 a640c23a62f3a-c513a84b292mr379695966b.4.1795226639509; Fri, 20 Nov 2026
 18:03:59 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAEF_Rj9AGCqWh4TeX0y1sOoF5g7jEh_Xhp_EnKPSEQ9thU3mmg@mail.gmail.com>
In-Reply-To: <CAEF_Rj9AGCqWh4TeX0y1sOoF5g7jEh_Xhp_EnKPSEQ9thU3mmg@mail.gmail.com>
From: =?UTF-8?Q?Andr=C3=A9_Freitag?= <andre@brainchimps.com>
Date: Sat, 21 Nov 2026 03:03:47 +0100
X-Gm-Features: Aa3M54oOrMzEp7w-SEjGVGpRpYsyqAG1l4HpezljxUKGdJbEXqXNg0OHmP_jKBk
Message-ID: <CAEF_Rj8MFeLOXr+08ykGeASYXc7gCFwNuABiZDm3oC1DxCwoZQ@mail.gmail.com>
Subject: [stable request] 6.18: tracing/kprobes: Skip setup_boot_kprobe_events()
 when no cmdline event
To: stable@vger.kernel.org
Cc: tianyaxiong@kylinos.cn, rostedt@goodmis.org, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

please consider this upstream commit for 6.18.y:

  2cdfe39dc944 ("tracing/kprobes: Skip setup_boot_kprobe_events() when
no cmdline event")

Without it, init_kprobe_trace() always calls setup_boot_kprobe_events(), wh=
ose
enable_boot_kprobe_events() takes event_mutex even when no
kprobe_event=3D is given, and so
waits for the asynchronous tracefs event setup that holds that lock.

On KVM guests (Cloud Hypervisor, 2 vCPU, 6.18.57,
CONFIG_KPROBE_EVENTS=3Dy, no kprobe_event=3D
on the command line), initcall_debug shows init_kprobe_trace taking
about 130 ms, the
largest initcall. With 2cdfe39dc944 applied it takes 1 us, and kernel
start to userspace
goes from about 317 ms to about 251 ms (three boots each).

The commit applies cleanly to 6.18.57 and 6.18.64 (four added lines in
kernel/trace/trace_kprobe.c) and has no dependencies.

Thanks,
Andr=C3=A9 Freitag
