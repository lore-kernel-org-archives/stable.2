Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.216.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794056751;
	b=zOZgQN50R5tdSKf2RZGnothbEtGxFE7i7vEetII9+dOoIxSqBGFAsNfpQPORSfLzS8mW
	 z8ie7RwAUyyQEq9LUdbdckntUHGpwx3sSt3apg0PPDdQo4m3cC9v7IFYdrW1IklRM9faS
	 NIAu2rRfzwea2EJWSNOZWCXyQAzVcFlSc5u5JGkaf764LpK9umwKivOeAM5jDMHwcI9Om
	 3TONdsAGYFA+kXRrD6Kxdx9mIBcQnZUgqAVn/VycmFRFypHSzcxTgVBkx8hjpCTAvXVYQ
	 1yWEMdnSrFrcV6OyIaM/SOHTzaSlqBMyGxc6qay4MQ7xISn+0UvWWqUQjsANSxdllTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794056751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=oQJywcCCzEM8mXQiNt3fOzLIyIQh4hJRiekOYxmYR74=;
	b=rTrD5ks1QcnvMgvpRjoMmLtxB1D5H6Nq2PYBaofQ0i+4IPHLFOT67G7C22Ls/F8NJnFV
	 mJyFleHmpD1OKbR7qGfGWlRBocIMjDGn+8i1jM9aqNCE3cliXJcp8jDNE5eUqPfsv7HQr
	 fGbeQ2mk66OEdgPrVhuNThj3+7Drz+nxMz28ZtWY+S8S1AFdDAVkF3iNY4hwXXYFYP3M8
	 1kzaPBCfEe4d9wMLga5Q5yOSw4SPg9BrdzXIqmV0tTLxudS4C6D5P+J4yxjPL2GYPnsid
	 Tqc0Fas2BOl9+XP9rAEYsBwoELmtQUyvpvTehEA0kwhbxyVtI7NELotPJUYiTxapyXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FLbKviSq;
	arc=fail smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561E606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 13:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5561E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FLbKviSq
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso706868a91.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 05:05:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794056751; cv=none;
        d=google.com; s=arc-20260327;
        b=oArS3ezuYBfCboq2+3gU5sPi3sGC2GLRdYqcuvTuaMi4/kJMQ/7xhUBWCSocOrV6j7
         kSBHdCJROHU4UxNdgWH9sTzxM15+t0zQnfmeO2HF/3eLOdDh5SKm/es0/DCRMMOJo6Cg
         zTPVNkIvj3lCoj4z8B7I45UvN41S1HBuZZ8aVjob2NoWbago4NRoOlr6KcSRx96x38X/
         pc5JS+HbzsK7lzGRnpP10sUAihBPJ5VQh3GRhC3LnoOiRkCtaWJ4vVZluWpVZ5qeImuc
         lObY0kr9w1hw7q/FgUBIfFHAfoQVsZlBkjC9BFqTZPJxkTpriK7Uu1c94gwmHx/SOYxs
         5Jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=oQJywcCCzEM8mXQiNt3fOzLIyIQh4hJRiekOYxmYR74=;
        fh=n5ciFnu1NuUVKzXfcNVnqcq4F4/zud9insWqgejXN/k=;
        b=Fk5wuqO1JwmrO6iD62eROu5zsX4SJM8E0YUHQpE2vLIfnlOaJITA/y5AtUPutQIFIu
         CUOldIqg60uAOBuj/RyO0AX/EEjtHz7i5+gf7cgTEdgv9zl1prkCEN1CdO37eozqGkev
         FbLxTYKqHo0JlgFXuNwCAs+8irE9loe+uXyrQ3uKzItQfYakxwYzzgaySOni5quaXDXg
         Bf70+VhNCbh29FR3O5P7q/OEm+XRl3KTjIVoMynNxkuMiNwH+3Ua34rAsoCOjl5QgB4x
         niN/MWiqWakxK8TZCAKAgHp6Yg44qG5gtYBZR6Gadmr8F30WIpM8H5C6Cx5W3QFGDhYa
         rCYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794056751; x=1794661551; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oQJywcCCzEM8mXQiNt3fOzLIyIQh4hJRiekOYxmYR74=;
        b=FLbKviSqVPHw0jjOiHqL8zF9TZPiXOyLOoY7/ZzZCprYr8XeFPQ0JBXf9NuEhgyXP0
         /6vE0gCRNIMa2jibUdJ54+IKM0kGvbgE5pCIUoWxCS+Byl9bCH95305djdXHPGgIzRbq
         986x3HLgc1RmLfOEoug1djDbKhB+HAdsFYa7VMuHP9uP40audXgnfwPZbap6Eq9zWvu6
         RZXc13ych4UUrTtpEpTpnsM8nH94JnvPbaZkTjw1Vp3Mv8Qa6Vh8sHANeh5ZosRh2ibT
         uqbTI+m6HnLks/VxIpCGYWULfmhZCdC4B98QMHd6huAAowXrJRP1EeupKYNgarYPdCcl
         a5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794056751; x=1794661551;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oQJywcCCzEM8mXQiNt3fOzLIyIQh4hJRiekOYxmYR74=;
        b=1DnN4j92yAR83B4pU0QVv8RgWDfb8onb9AxZRfHXsiW32Cs+/ihY3BsWcIMf1Ere42
         8Xm1SqU452a+fznktxkLF6oIHsu2etctiS4MbWCwBzSVJ2mnTEqeC/H9oFYwT2dRzKO6
         2kY7z/A6simfg4PnGgCs3EBoh4ve7vITKlp0JQ5aOQ3tmWLbfI8uUvtbymppfMQ+4pZK
         gNrk9KiTUaK3Be0b83rlFFOrXxOBOLOGh/GsPwtx7F2IeKFF9Rrb1HZr41aj9RQ4ZAOS
         xSP5TLdFPf7kOtt6CPeQgRvR33zQbk1WiIM1aUaSv7GIQ7cvvkh3M3pWu4YwzKaFaF7t
         UQ7w==
X-Gm-Message-State: APuU4Z9vzG7keHBnxzhD7n5D6rmhUs6wXA2Sb4WDkDWjrM+5hUZxucKh
	zzM97Vxm19lo9U4JsGhZIQ2fBvrwojDnkRg9rbTC3F+bd9WP0B8xQbIiQgLDTYIaeKfbfERDY4V
	xhT3aHi4amBHWLntsgpoFYaTV1EZnDqU0yPTtRKo=
X-Gm-Gg: AYBFou3hF3xA/R/Mfhc/QDisoBBV9RxFTHQmCwokopSm6eR5IRVQhTiG1PAwrYgWfLF
	tCo82SOZSDn9l9kwpHeJDrAvn1Ex86/94+cUDtlRVp4w0MT0J1njctVufcPaZ5poXfnqobRS4ZS
	KpV47AZDYUjYqtfDaJOgbWvkpaVgaVmWDPrJmK7uv/6y8GxkmspcIGNIPA99OeGrcM/OKYSAGN4
	awnj8nrgzHTdWTXfw3MrpFeGqvNoXqcw/LpZei9pgRhEDn2IS77c9TEUnc68JF91BdIslfqKUrA
	2152X04tHevPysokjtPs+SC/Kowxk6fynWGPmJ3CF9rd5msnycZ0PMCWklRi8CUOer0mzJCp9nF
	tdjFGw0k4wd0k1vZPVeXdjy4AJfbAjSGeDDasng==
X-Received: by 2002:a17:90a:d88e:b0:3ad:c482:ae9a with SMTP id
 98e67ed59e1d1-3b0db5ed5f3mr5380332a91.1.1794056750595; Sat, 07 Nov 2026
 05:05:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Laszlo Burian <blktk2000@gmail.com>
Date: Sat, 7 Nov 2026 08:05:39 -0500
X-Gm-Features: AclHuK_Nu6d4jiQSpYGFEFSB-JOYChIi0OQWBT09P6aoABeV0XFldC_HzcBMWc0
Message-ID: <CAFgCxzCT2uo7ujUJN6V7gsKHcC=61A=oqptzX0Ktnnb7qeqnVw@mail.gmail.com>
Subject: [REGRESSION 6.12.y] ALSA: usb-audio: please backport 70b4db7d2581
 ("ALSA: usb-audio: Use the right limit for PCM OOB check")
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-sound@vger.kernel.org, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"

Hi,

please backport the following commit to 6.12.y:

  70b4db7d2581 ("ALSA: usb-audio: Use the right limit for PCM OOB check")

It fixes ef5749ef8b30 ("ALSA: usb-audio: Prevent excessive number of
frames"), which was backported to 6.12.114 as 81e4b0009f2a, but the fix
itself is not in 6.12.y yet (checked up to 6.12.116).

Upstream, ef5749ef8b30 caused choppy sound on a Behringer UMC2020HD
(https://bugzilla.kernel.org/show_bug.cgi?id=220997). I see what looks like
the same regression on a Fractal Audio Axe-Fx III (USB 2466:8010,
snd-usb-audio, implicit-feedback playback):

  - 6.12.113 (Debian 6.12.113-1): playback works
  - 6.12.115 (Debian 6.12.115-2): playback stalls. The PCM is RUNNING
    but never moves; /proc/asound/cardN/pcm0p/sub0/status shows hw_ptr
    stuck at 0, and clients like PipeWire/Firefox hang waiting on the sink.

Going back to 6.12.113 makes it work again. The only usb-audio change
between those two releases is 81e4b0009f2a. Its check
"frames + counts >= ep->max_urb_frames" cuts playback URBs off early,
and 70b4db7d2581 replaces it with a check against ctx->buffer_size.

The later 06be918062ad ("ALSA: usb-audio: Bound packet copies by the PCM
buffer size", Cc: stable) touches the same lines and depends on
70b4db7d2581.

#regzbot introduced: 81e4b0009f2a
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=220997

Thanks,
Laszlo
