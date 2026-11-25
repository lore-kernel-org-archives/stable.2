Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795625946;
	b=IppfolCiFpE+yUAuxujSnVobzosnnLlO0biejiK5JYLa+qJWuenfOKCn08JjQNvi+NzT
	 tU0p6bW2kUSzGoCyfiXReMRag4UCEHpYsneJlXPRL8jpS/apVcs9npR/WCd1erMqpNGS0
	 JZ+FbQ4T2TWw8fzCiQkwQeR94wbRjVXboupSn9r4EZYFGBypE1VXmwYeDyZeh4Lj8l/Sk
	 Atos6r7fVndRGKhiDtr9hsLTeg5NzlYJ/HygGYwwEPRVJOtch0jMUNZsgYe+/RWLXcG7o
	 ele4l/P4tjrOHCZPTctruEoLsTad5VrfNG5GX+I8OarLPh2TM1wKLJ9CDqUsXp4lulw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ssqoSi76g+LtX30iLsvIWKdf1J/8p1hvBN52gnrjlGc=;
	b=gc1hcaH3xz48e6YuZI76PUdNc3+Sdq+pFtuS/gfWciUkBIR3VR+AMcsRgqNKpojuH1kS
	 rHFGeyoVCqzymsp78okQuPuVXbyDdsqMTTw5mABpZ/Gk4NFKHUS9AiFpwsW/gbUFo5n3V
	 dsNAr9muZm43blXyEESznBh0QIxNhpAkdMXWIQKNQGQ/Hp7M5d5i9+gGajN8ArNxHpuJJ
	 0nl0YfuLW9pGsGMiLnpPQHVYjHr6yz4Qr0oVOkRe+Ipyp4FgzCQoGtJOIF8l9eixeebWI
	 iCNthTptyOc1EjTGnYtnvuyeddnPXotjAeYJDSAVP9y/ypsTkYg6kNZUCGLCIPWCf5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b="L14WoLA/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69646606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69646606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=L14WoLA/
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9497a167a6aso828128385a.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:58:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795625939; cv=none;
        d=google.com; s=arc-20260327;
        b=h5b7XVDGLIH9U8vmNnUOxcXKRj5/vsrOV+iOE5oHyCSGdThHYY0eO+eCHKyrVFs3+R
         Z/iKmSdiqhdqX94Cdl9B0zXavRo0MaF/FHjS7OBV/PPMIxWMC44IveHR9FulQzBYwpzA
         h918muaTXcIivxz1W6j2H7zttDuZiOI42kYq2wG6w8fcyWQcl+k5lpEl7r+otyGZS5B2
         Wh6EPIhs79q0bJPi7PeD/kZoSg4bJxa+yFf93YC+owJL7AIqjphKiZkRMmVhS/9lu4I+
         4V/mMKgiApIUWbvO0GwyBWwTZqvCrOMEK1QL2BIwbyKQQko9SZIjF/+mjWrMvWEyC88L
         aFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ssqoSi76g+LtX30iLsvIWKdf1J/8p1hvBN52gnrjlGc=;
        fh=E5/EXd5lGZHpLBAKoEdItDSJpLXXMur6XFIpNivjap4=;
        b=J+3+cl6nOzuGCqS6k4ItvxlxJ+jea0kDV+/tuyETKll6Ikhk1zPzOMwVz4FU1KDsLL
         n/yNr5wcudKgjC0IRgn15HHbYUhj682Mgvhx8psDVsMEeGbFQz6kmDpMSW08SECQd9ff
         rJ6vt+Y0LUkqnldElOwMATBIdSWyb6giHQUN2TyQoCWDYT2NS2qrYzppB4+HypW1nk5i
         Y7T7Vrc9PlhEzzxKcAgX4sSwJwoIA724n8VIZ7cFoxpKOIj1hXgMGu5Sb3wWIcdkg6bU
         3msdOj6vBNoiNWAg6KxvF5Fz19gDlMQmcVq86evdeBNT6QL2qK49kjvU8x2+LfJzJo1J
         KHrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1795625939; x=1796230739; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssqoSi76g+LtX30iLsvIWKdf1J/8p1hvBN52gnrjlGc=;
        b=L14WoLA/qRDg+CVR/tmUvT8uk2Lab7pJ07N8cJEF3gw3FrRc7pYROp6eRI9hl3cXXG
         RxRbw8kEjQqT2sVOeOTRn0iaYrI5Vbok+kzkZlOjQdo5roL87Qxr4UR0kCbTN6pX/QCp
         xagytRSAbo64M+PxvJe5RHFPApTKyOmlSeajE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625939; x=1796230739;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ssqoSi76g+LtX30iLsvIWKdf1J/8p1hvBN52gnrjlGc=;
        b=HY0TS+j5oh4vfTJBwvkm2hDtXpY331Q76xsZXhYxgZEplASVlYI1Bs9gnvci3IXXou
         Dhz+s/PK2184sYAsbCSBsQ01i4gDKjt+Ql0K4LqcBlHEhZTw1QJ5SdJindKAxru+Lv8Z
         vQ3tVDhenaEELIvRqQ9iIc9/TL+0V4QtePI4xKRpHsnofldgj2Vf+9xRMm2hRh8L59gh
         RHigBdV90/2vG7f6nKhvK1fex0Q2Ittr/3hPfJEZ39W+JOUiv56s+Myo/Ifi44rErWOn
         V5Zo9+5s32czyhNrmCUDbUdqkCClKO1KQRpepZP2CL3YXKz3NiDupA0Twny/C4jGcRvT
         ybrQ==
X-Forwarded-Encrypted: i=1; AL+hErFj+VvtbCUrVD9gSr/5VmSbzvRKl2I97hQ1Y+e4Tr/iGs7fYgLnmBPvwPdSJvvJ5PZFsp3DEWQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+K51itwJKDT6kZei0r8yMPD2xIiDfjO5BCJS0tD+yj9Tjq9fM5
	tiCt01HaNJvb3RtsZtBPjKTtLgbrWvgunI/mA+I84wtc4ZLQ7/VDvuxJt1N6z0RwjZtAQnjxNKX
	Ww4Fa5YDz0g0P2hUOEhjYodhqEsonYfbT/20RjPJ/sw==
X-Gm-Gg: AZFdTZdDMZXWkvaDdJz9vPBJ2XbY3r4ZdcDfXEFACy7aYaEDnLVCtyN/aCZtw9BMOkc
	dO5iNN7V10DQ+tqu/7CWcf8U7xxXhBREdVCS9uaRIczF3RcB3xkjFVgeBF/+rR5ezenr0XY0rH9
	CC1MkY1ZPo/tmvax7D+LHP/WmGSRSIbvkRS5ikxOm2QdEnmau5lP1EGuqrLnNp3khk+eulqrQ8f
	xYmlL3WFiN91Nhwr1LS+kSTQSSoE2E/BIC0P2R24zc+IA9xRuELE2YMhNdnDb/sr6ohchfUDJJs
	5119V0aqw8YyQN3aCYySGknDWEf0U5XwBUvJhnN0JYHJDI++ktRi7X+3LVnLMiAZ4fD4/FJI3/U
	ywfgXzi6loFqAnYwwDe5dY1eW5RP97lCkNo+trqcILftgAFXNXK4jgJPDPC9e6JY50ZM0rQ==
X-Received: by 2002:a05:620a:130f:b0:93e:95ce:5394 with SMTP id
 af79cd13be357-949ba81953fmr3086387085a.2.1795625939096; Wed, 25 Nov 2026
 08:58:59 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-work-fuse-readdir-v1-0-44312add01a8@kernel.org>
In-Reply-To: <20261125-work-fuse-readdir-v1-0-44312add01a8@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 25 Nov 2026 17:58:47 +0100
X-Gm-Features: Aa3M54pPfuXZohQGDn5k0h9sL1sElbGXsBZCEsXt30y_HQ67RFbg9tpBWfdjmqU
Message-ID: <CAJfpeguDMe4ZooXec_djQ_Kv2jL4HNum=LvhUtA9iPrHStgnaQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: fix readdir with long names
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 at 11:27, Christian Brauner <brauner@kernel.org> wrote:

> The first patch makes the request large enough for the largest entry
> the server may send and makes sure we always have the pages for it. The
> second patch adds a selftest. It fails on v7.4-rc1 and passes with the
> fix. I also reproduced all of it in a VM on v7.4-rc1, including the
> memory pressure case.

Applied, thanks.

Miklos
