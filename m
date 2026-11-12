Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511137;
	b=ANuqnv6pib94/LZ6alB5NsKGlkNiE7V8eIOfe8PEl1NsBVxxRQUA506y4rAozYmd2oGT
	 /gwszjH6hyIxT8/zxkYUcSfaUgI1Ar8bC8bBTpLmKl6tyzaHOcfzivSm55weuyLoZWdSt
	 wB/nYnHhZPOOJ90pizGo9A3DUgkvCKWcdk8Xnndkuy2yMqEOdXYIEIFD7x1bl3CEklgLl
	 Pv7RzL58tzh3/PNcKpKcEpyB01kE3AEG1aYGAscwcb2p+ePX6HUM4dY6F9znJR/S61JJh
	 t/htdUTHHUaPuoXXNkIyANMV3w6K4l9pWcv5Tox7n548f6E/VeFjQ/7C6fCx0/hvADA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7LCfS/9rwxDTKWh5ZrMSShB8a9ZcGb6m70vtz1Y3Ey8=;
	b=VQzQVJwfpsQIkDpkWgxAPxD1+wqmXorhjgo1tw7tCb2mlwm5q9f/qY5BFJSw9X/hEBbP
	 JYs8eOaszlJZgti81RbUR3gjPRXSH/Is2bF+3jM2qzsaD2hc0I7B2mB898XSSLXp/LJi6
	 pkQFWm5XZb4R9C16yKB5URFuhLMVrZ+RYdjXa8JkTawJ3MjORkw0EoUVtiHUsd7zgHqRe
	 n7SpHfnIdnk1K6X2sMdyO6XefSoJjNbOik6nsPVXnePZASM+d2NEV8/TAUaxNjNMexLlW
	 WmbjbaheCzF/tWvWIES44ZS0Csd6OcFDaUal43bgvcLAiq88oISlnD+SqS0rAu59AtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cX3T5FnK;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4E606A8A3
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAD4E606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cX3T5FnK
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eb2437d752so2704755ad.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794511136; x=1795115936; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LCfS/9rwxDTKWh5ZrMSShB8a9ZcGb6m70vtz1Y3Ey8=;
        b=cX3T5FnKUMfbrTjrPTh99cQ79TGan5Z6s2UUOPVu6OYyNdnBKi1By/mEXCSuIgMpXq
         BEMZMcu9EdYn9uwn8rkiTgfa4Q2NCf4bl6YbtJJ6Efz95GoLI9+e5G4Hb52YpDyz8AVj
         Arjsm365XfLH+T41PgGtBzouYbnmfkUfbvpzGI8Pl7W3WqD9iEkq/qtLsHX/njVwhve+
         vThaLGQuUxii5CXTjvNhbJOXC1Zm1exUHk0SrqgevjfSQ3x4Sb8I1pVjpfu0lmpmI8To
         okadTTfHQ1JL0IC0Nr5njNWKeWjdrVN1o0ZSgcMSXNAk+Dl+zNzzNWIDpeVL0xaJRLGt
         v4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511136; x=1795115936;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7LCfS/9rwxDTKWh5ZrMSShB8a9ZcGb6m70vtz1Y3Ey8=;
        b=gW4N1O/fh2qRZ78Fa/27X7BkeYK+dvsJJJqIKnVIjoyNhDVqj+UOg8sPLUKkhHlxhV
         vvINI9F5Pz0TlXX67Xb+VUqBldUHrAWfcIvVVCfgpIA5GZpW4B7rcM+qJv2e8T+ub6C2
         wUaAptmQUScC1qViGPGYNenntTTfGLpfb5LikfroErXsSm/B9XcVoARtD5pxCJzDH70i
         M/1GSEJGC7Y1qhd1ITDrIXQeCgHhcg2YlYzCjTo96k+P2AP5hPGG/wx+kLlUnZY8ybiz
         8W/QYQS7xNW/cUE5iuToHSThE0Lbv1VlZiETkFED07vtUiJOMF6TzxUSmpl3cqusag97
         jySQ==
X-Forwarded-Encrypted: i=1; AL+hErGzZQ4O6FAel8/wS9DVefIF4IOsCByywk1/c1QvxkgpP/bmfIohSn3wCQqtnggg5hdFHVduATQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1UU6jz33z/PQ3n34yIWYiPwbVyFVg1sgdzcV427slrqYxSrcY
	vM47ZosLb/u3G0JeTBLgb8zfBfKZLdCHDCUv7FANDBbzrhJRzzhzeQXRs2kCBQz4EmqzADkCh6o
	B8b1sLQbg5A==
X-Received: from plqq10.prod.google.com ([2002:a17:902:c74a:b0:2ed:de1d:fc13])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c8:b0:2eb:4a05:4b4b
 with SMTP id d9443c01a7336-2ee0dcc3023mr3285625ad.49.1794511135954; Thu, 12
 Nov 2026 11:18:55 -0800 (PST)
Date: Thu, 12 Nov 2026 19:18:50 +0000
In-Reply-To: <20261112160448.41566-4-lui2012qwq@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112160448.41566-1-lui2012qwq@gmail.com> <20261112160448.41566-4-lui2012qwq@gmail.com>
X-Mailer: b4 0.17-dev
Message-ID: <179451113093.3909038.18000407710443328258.b4-review@b4>
Subject: Re: [PATCH 3/4] usb: gadget: r8a66597: free the IRQ before deleting
 the timer
From: Neill Kapron <nkapron@google.com>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: linux-usb@vger.kernel.org, b-liu@ti.com, gregkh@linuxfoundation.org, 
	nkapron@google.com, tony@atomide.com, bigeasy@linutronix.de, balbi@ti.com, 
	shimoda.yoshihiro@renesas.com, robert.jarzmik@free.fr, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 13 Nov 2026 00:04:47 +0800, Chengyu Liu <lui2012qwq@gmail.com> wrote:
> r8a66597_remove() deletes r8a66597->timer while the interrupt is
> still live: the IRQ is devm-managed and only freed at detach, and
> r8a66597_irq() re-arms the timer when sampling VBUS (VBINT).  An
> interrupt landing after timer_delete_sync() re-arms the timer, and
> r8a66597_timer() then runs on freed memory.
> 
> Store the requested IRQ number at probe time and free it before
> deleting the timer; freeing also waits for any running handler, so
> nothing can re-arm the timer past the delete.
> 
> [...]

Reviewed-by: Neill Kapron <nkapron@google.com>

-- 
Neill Kapron <nkapron@google.com>
