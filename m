Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793063046;
	b=WTqmsnexDE3CojMESFtPp6xBOF/glbZnnV66m5F5xFAXE5iLw/LvP5wpwEhqdja4+iFu
	 iRihqnhOcId0NrA1upZjTJyTvOnITAzvTOCTLOuH8Igtp7He74BrFZJKrQoaBh9H46q/w
	 zZHrSrcz7ep26za0wY4IZKgc8gUKeyT1LJ425DkGNpNw0ms18QzBkXj7CChsV6ZvILmh8
	 G8yLVkkq23q2xrqAGBk3mfqgtLfizFPogMf3ExgpKju3GMBBwDRweeeebVv5XyCaO3wlL
	 aUw4qtG1kAeC0ugSrgBGmAhN2YG2dQZJMmo2YFL+AtH8/vB7JW4GS/hP4ICYDW67FGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=avJfK9ypBt2H+1641GuxSMWS3Ix3bhB4BbXP3Vk7Io0=;
	b=DnfisR7YVqqzL5mZ3Kt+AOF57oEdnsX4krkgy/ZezaNn/+4n6WogGCVU6p5sxBgmEc5P
	 26onZ2IJWNBHiCB5kYGLaMRUHWDAweM357LQzOeGby7412zizQaMrW/Plmd++nfOXqj7q
	 GHZSBS9sBrPM8jEHPPd/V6pWinROhfDZzXEOKQHrtdh5/rRfsnBNsH641VvMT1ZbTw48Z
	 RGjZvgkZfyHHCiSM0vO4zRIAd1VK+87QI2kCfMxhKMUE7OPxyZw0ggeuEEfLx8XwVWi/G
	 vskSRKBSfMdp8Hym2KgkybxoB8OoAnVtDq+HnPomLpLQuYNEcAwGjCmN3c51otUdEog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="BrUCgXd/";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71D606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 01:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F71D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BrUCgXd/
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35d0be18c71so577084eec.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 18:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793063045; x=1793667845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=avJfK9ypBt2H+1641GuxSMWS3Ix3bhB4BbXP3Vk7Io0=;
        b=BrUCgXd/vMTFKCS+tslv3QI5iMM2mw/qFh1VQWsnDLDYy6bpucSGruGQUC5QV3jnCC
         2G+/qG1otv3a3TADIOQsyUMECVh5QYu9ARLAM+2uW8LZ6TSY7isyWL3wk+KIZrOMn0XI
         ewJce7Pj8wwqY9s/fHBQYH6OO9f29Hz0STqQDdzciiqeNPLFf5oOy9oMDnQnLh6vQ+Q4
         CIg8/yBLGLINaVy+zN5W1x/2BnQqoCe1EbSgqa/TO6B+YDsWkMmSQPP2QR3s1uF3rmhn
         K1jZYEFD/jIrLobGT4DnSJI6dfRwjYA3Gl1a9M5tO/KZYo3NStDgq7g5rsvVH1VXuoX4
         UtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793063045; x=1793667845;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=avJfK9ypBt2H+1641GuxSMWS3Ix3bhB4BbXP3Vk7Io0=;
        b=pj9ruyJ4lJEtc0wF6AU286tho7o8osllJ89HjNXjoDJ3aNKFhBda1B9FzUQ4ewkUp5
         FiaHovnYCOu8N2IKTesA7iVsN1+fbGxnI+U40ILJvbZUbf/22tGum9jZnLj8aoq06FZO
         c4n2Ucaq8I+eO33MM8tuMVQsV4RtSabO0xbOJFJqLI8LaWLBO0ji7PlBn0nXKlh+sE9Q
         L5rKCX3aFnALMFl+pbOckkTtIA4DBgo8neM3ieEuC0DkoEzusGhHFt18AIwREwT/G+g0
         dGwkueDWlnsBWmGvFNxIj1QDcPEFf9bxZVN4bkgjf4ykL19De5rq6a6f7fzxciiHUhWo
         gCdA==
X-Forwarded-Encrypted: i=1; AKwUvBzw7KcCwHhJxbeLRL0gpTDSLoyV39yR97qVfueU5N6Qkq8kr+Sl8LLMGK4tWK4USJPXqiiJ/A8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUdTvvqxh5tdBpwHQhVNqNlZ3v3s0zVDvUhwvBrQZkW3z3liwU
	wxzrXtbeXLm9czy+bwfcxHgOra+pX222IDgNW6pRRmig1CtmsPAz+bUt
X-Gm-Gg: AYBFou2AORiKiYcaLLXKdguVy11y2aeyW8WbPpkywrF6qo9nN5r4LepWWNjl6Yb5+85
	+I9NbjZS++l4SbmCk0fzdGVfzc76jrwEOjkGJC794zgCx5pxseAzS/fkQTdSjHH7uu3V0sBMKUk
	CO0Ha+oSYmJMa0LqsMWQyzggIG6IVa9re/tUMnzGk+aPnzAYCnEkdLfhGTSBcIrdO2z83lKTCpg
	Fihe63XZmNwppcCkuFIZJRifH2894A/0WeINHXY+fjUehlhK7rhEDAF5VLcksXy6IFVoBuPIuE7
	L8bHucCvAJv1mvE0FolB/iNWsNI98nzN2F25VpwfEQ1RbBhPfWi3y8K7a4wqF7D0IhRODfeVu0O
	sHLSjfiwqVeALF2J18tgBQ3ZQp6nteLn3odruSrWcU7i/T22XQR8EP1Dab/s1l4XT3wNg5bWRO6
	sgt0OPtPKLqWptEBfeqQMoomHJtNd9FINTrVEM8E1w+2Ym0p94T7/OusC6q1iKKPsu8X0Q7UzK6
	2aUt7D1V2OaKBj/Mpu6IfEjNKP18MHVkAbiz1o1QzWW32HrDd1e7RRyzQvUzjRxaMhZfNuaM3iR
	0yTdbamhqpjPS/aEQ+zL/R7bgW974NWQklo/uKqpbTI=
X-Received: by 2002:a05:701b:2094:20b0:166:f097:6f10 with SMTP id a92af1059eb24-1a3c84c2d6amr1621178c88.11.1793063044277;
        Mon, 26 Oct 2026 18:04:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2dc1:2e1d:6b4d:5a9a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a14383b02sm937423eec.14.2026.10.26.18.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 18:04:03 -0700 (PDT)
Date: Mon, 26 Oct 2026 18:04:00 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, tristan@talencesecurity.com
Subject: Re: [PATCH] Input: applespi - validate ACPI property buffer length
Message-ID: <at_4L4QXfXikGrAy@google.com>
References: <20261027002919.3589149-1-tristan@talencesecurity.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027002919.3589149-1-tristan@talencesecurity.com>

Hi Tristan,

On Tue, Oct 27, 2026 at 12:29:19AM +0000, Tristan Madani wrote:
> applespi_get_spi_settings() reads three ACPI _DSD properties
> (spiCSDelay, resetA2RUsec, resetRecUsec) as u64 values from their
> buffer pointers without verifying that the buffer is at least 8
> bytes long.  If a firmware implementation provides a shorter buffer,
> the u64 dereference reads beyond the allocated object.
> 
> Add buffer length checks before each u64 dereference.
> 
> Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
> Cc: stable@vger.kernel.org

This makes sense but we somewhat trust system firmware so why is this
needed in stable?

> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Why is the difference with From: ?

Thanks.

-- 
Dmitry
