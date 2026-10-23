Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792716028;
	b=1zKMWWooX0R+EUER/VvBUkQAxdscoaRcj/BJ56+4KpgFtBHbGM6Cz2V2i4x5sjAGE9sR
	 79NjmbIHf+N4HBuFihOnlBvWxodaUEIsmaueWQbTq23UIOCU9kbP29MWAq62ZMyAnlUng
	 Y9FlnpOv7dko6gCFEhnZMens1qtyP3qJ2hmpxyu75BirLVf9Vb7nSrb7DL/RjT65U4X/i
	 T/qz4qKPvkxprYy0SskAVcir6EzL/Vz3pu6Ly9YWgY8QD9Gztv4PoV2JDDgWn523mhS6G
	 1gomuPRcuP4/3iq6JUCW4jb+3KjaG1oWDzT16fasuXIpANtwPlWul1h8NlkGjvEIeCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792716028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZTx9dOA+V3c9E2l48EAUDZlXgm5BgthbGaJoqzKG/Vw=;
	b=W5CXdXal37BpEzxs4IBKDOxhYVkQJtiVsnHqxfT23Nfxcdd7IE39EHWPwsGyWPS54L+4
	 KTHCeSJR99lSdDW0thKn/1Lou6xv6SUWTCfLzcE4gf/gpXj/F4BqFs0QLmJNGNv0z8oZ3
	 moSCtnQ5wuvDirMkmz3fis0tr8/cg9FGrnrmqjhA/3cd0Gp8xoLxRrfHkeyrKocDHu5I3
	 Sd2+k9jT15zeNIU9FfmJPVLe2fHizo+62LcfROYRRi75fbIdxH+wiHorGrLMRpZ4p7RkV
	 dFv3oPNvENCqruCkbAjHSHC1VQsGaHvVcz15bvubUttVH8ydSJLKPSGGftdjkyIvpZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="KLCb/S7o";
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B95606A319
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 00:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54B95606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KLCb/S7o
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso435011a12.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792716027; x=1793320827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZTx9dOA+V3c9E2l48EAUDZlXgm5BgthbGaJoqzKG/Vw=;
        b=KLCb/S7ocuj99JyVAApM/6QDX9Cz2zbxPrGTyACgHjD8EXkNbW8hpspKv0Lypr9T0u
         wtBN1hqypTjgzlYM1TfBFBxk313oO+wR7scKDe4hYdEq6AHqBh6bI79FtvtTxHw5ilPL
         nraSxLDgL+EZf51M9LuatFGFCZs3FbFYJwJEJPTQ42Zn6ajl6uAw8qaz0GdB1d+2pe/3
         +4S2FuhwHKJCXEOU8tARFmhEvLHWIU0Xmr884ARrtojQx2+9ERO4bJv5Ke/1O9vyP0py
         lYdyJXRqMPcJRywjXiBUWQ7a7KxNvH4042q6uLRwkp6MQYcUtKzZeL8T4GlOM5Q5sqM/
         SANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792716027; x=1793320827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZTx9dOA+V3c9E2l48EAUDZlXgm5BgthbGaJoqzKG/Vw=;
        b=UcpvjzpgY86AQ/HoNETxo72VXjLyTOfo4PFGexbwyEg5EdhB6xyK+hpLtv8VVGV9tq
         FKbXxyuWvnwLgRv2cmrmEDK8gaiUyfx4DOvCuxzBpL0mhbW7PamYArtDjGPULdnDfiXH
         dEy3ne7wksu50DIDL4neA8bI4rypeJTburTJw6GX5SwaL6NYZpk7G40vaNvs35QOzQCD
         baWTw65QYX3imwGaLAXFPJ5R/XUi5/Tu9Ips7gsbxt/12dZ6kKxq0VvsG27XXt0kZRik
         7m6Jykes2lqGvRFqT6auA4GHfWgXCu0DJ0quj6I/gP8+btaGtbZX3ByOUm+6Ti8c/nAY
         vNdA==
X-Forwarded-Encrypted: i=1; AKwUvBxca7jCA23XTFLdvw9DSk2xBzgaHW7X2J5mvSrs7xw/HIf5GnosW3fXEvil48mMMpMX3EzKE0o=@vger.kernel.org
X-Gm-Message-State: AFq9FYIM3XqlhfBYw4cL4O+GPBo0SfhwAuQVYFUUsePsb5TAXbgUN0Ul
	l+mFuYqecHw1gOiDN7JRwRNmUvmnFZgIckDl+8as7IPhDvz/Dbn5y9Vm
X-Gm-Gg: AYBFou2ZVF8XbEt8kXq7ejRE+U06Taj5QX9H4obLt5js8P7LR/GEickczTvYnvKRun8
	tf9tebH32emxM99vTl8y1XtSsbpjuPBVIHH2w1E2eF3t8h4bIuu96IMf837WIaUcGeOGMIRZZII
	I/WvzCd1nSzvS/UKdy5POypFjGsNJGHmCH0/9jxm2UJ3vfzmtNoRfQY6gQ9n+co90rK55H9kwTc
	48p/puO59abyCFBCqLWa6yPsNtjQX5LlOJFkK5gmU+8OXQFlkYk5ZNdCgzXuqexFmbp6HMYdGgn
	BlUQ42Mxm3NT4ec3ZClRB348WC+hYgN5n0cTQ7/8nKdyu3xS3GAMJgs7BAIbQ16/T/7qfZ2vrA6
	iLo+CKgVbfemfl2m+0KUF4/QbuFLXnkH57XeMSzgcZHCz4Kh4QQ+YOkFczCTVzOifekaAArxPue
	U0nbC0elYuIJZuG0zFAT0NA2mlz2mncDyNR2RDAeDFe/O2dHXjyPNRKqtCeTO3jn40DuY+e5mle
	uIZMZxVcvgM73JF3NUvwVSmWUiQLIhsoNlKFgjytCfA10ClNn/yyu8PznNi2fmbP5mYhXeF0mSS
	AWOvlc7sfHMTdlfLuoDkEzKfWLBRc582SoNVnHlz
X-Received: by 2002:a05:6402:e8d:b0:6b1:cea1:a011 with SMTP id 4fb4d7f45d1cf-6b432a94c76mr1525699a12.0.1792716026746;
        Thu, 22 Oct 2026 17:40:26 -0700 (PDT)
Received: from localhost.localdomain ([45.93.75.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b432c96badsm426013a12.14.2026.10.22.17.40.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Oct 2026 17:40:25 -0700 (PDT)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] ksmbd: restore Kerberos logins with released ksmbd-tools
Date: Fri, 23 Oct 2026 02:40:23 +0200
Message-ID: <20261023004023.98453-1-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023003855.98316-1-mike.michalo@gmail.com>
References: <20261023003855.98316-1-mike.michalo@gmail.com>
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

Sorry, this was re-sent by mistake. Please ignore it: the patch is
already in ksmbd-for-next as commit 0fec4c24e197.
