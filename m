Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5D49D587
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791588596; cv=none; b=NZ6hWog7rjClomXBlrZ7zef/8KvVW8HtVhF2+DwKI6ghT+HhmGupEunNa4JN2i0iMldFIwgBkCDZK/gIWg/ReJb9x/SYPk2Ai7A49cibw1Fx05jGflm7t6qyxm0L5Z8xRwpqivLQJiv6qtSJvblkB3ygGD6ryyvuAyy352USavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791588596; c=relaxed/simple;
	bh=W+0BKaSSS5geABgZG0ihHeDh9uE0UJzbPOc7RSsg218=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=cirq9tINJ0AeQesG4ctZcHmWzFnXs7Heg5AOr1grLnOApr+LRVVyyMpEdQPGo7aneX7tbRwB7vL31+xV4Pq83Wvggy8TRVqTq+P7VTbPmFgslp43u65xUY6wcFwEUYuR8IPGq/wocpDKjUxv56TMm6nz/FRPoijhDltEodJVYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=PmkrSmev; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="PmkrSmev"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-356b1e20700so556464eec.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 16:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1791588594; x=1792193394; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IcQaew24vaZlVXB9zMTh3pNgIar2qi3hXpDnWpO6VUM=;
        b=PmkrSmevm2sDe5jGI9CxwQzFdSgIzwdvokHx3jFvwiOBeP5Pkv0VOFRhxih2YWDq2D
         d+vbSY4br/g57DzdDi2gXV0QjqGm851Gg8Fdqvm2Qy8QlDSIEplFJmQ6XVi7LEsnl2yM
         0/Ca2WwbLUtrKlxMlRdN/vlpC8VNy0N8WxYktMLFHVKmLeHwe7ur8Koh04//IBJlCuem
         IPvPOSxG1X+WNbF8mjOzqz9FREEw8VOoXfOSMFTcY6m/MSDnVGRSOEA86qipy3ckQxw7
         b7SXKMehTLgjVyBX9ve6jEvENGg1zaHpKRVRcN04IOt/VEKAjSb7RRhSCksZL7CM/0LS
         uT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791588594; x=1792193394;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IcQaew24vaZlVXB9zMTh3pNgIar2qi3hXpDnWpO6VUM=;
        b=iMdCJw41XZu0oIxNpMUqhWQdZGKM8B1mSF3U2OVfW7EOaKbcnMnP3tDqyirJpV9JR4
         MqaBE+2QSEXYyUf7V4ZKShVqdWfJrcZ/sROUYy7PY0RuaquwRAdw+q0LXOaEEFT5jIBP
         Yn4wwkpgMkbvdtHfyDUwMv8xW0f+s87FD3SBAEXhg2DJInplsnIH/dq2Et57auleRZIP
         sbwIuqP2sAm9eMtdI1rQMmhKJvkOtzxTLP/r46Obfm444ffq9KB6horyMpYqaodSr8+9
         WBPK0Pl+cUPwZ+IXcyeLeiReVBKgFI+f+XuV0DwWkk3ekaiNBTDXnIerizzI9Y1UuzdL
         0j1A==
X-Forwarded-Encrypted: i=1; AKwUvBxG9jKsqTbM/q0ZMYjFYHXbRfcn4fUY1kkiF2SsPlC6E2VzU3ibxJMeXwkSqyvNSsI+Vvm08u0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjkhdZoIcYz7e2XTBcKayHFOLyxqu6ipvHJ0mm6XcKXyQrTZkK
	Zdu3LVyoE38JoI+PgXcP25y9nGebWPdkDn+nZ7NZZS/zr5yjdCnfrm1ZapNBQQO/aKkLZRrLMZO
	CTJnJNTw=
X-Gm-Gg: AYBFou0obTUPgVQzf6/iNhIbwNM55xJIIafoxIWxvYQJ3KRs0gAZNZs5P3fpvykNSW7
	mPs6mrqnUN59PxOenjCgyDQJCrxV3bytFJ7Q/PYdvBdrMVQGtqc/nAn6SnSeFpc3dSw6evoQmGi
	6BBYsam1u38A63C3loI592R5z/pb91oNhPztwP+zuuN+vDG7i8oHJ5iaPA1iYZuSGnw0vGEeH/K
	xHpFnTNoE/ad50s8r9FUVHE7FU56RZCpwqrQJFsTOQWsxjgDnCt1H1+EO6Ri3AUfWsip1UQbyrS
	5MjpUIz17nbPCzq+zDaZGqYntmGzx+EP7bhXaKRU7tNFJ/KRLWqymps8MQ0dhmcqCW8oOQ3Exlv
	6sFTd0xc8O8f8GMTpT4AKkHUD758wgSBewkeJRqMlRaFtykUEIma3HU0DwLO+OfDYH5EqjJ6fXv
	IRX+At+95Q3D8A7EUIVqg+MGZYRqr0biiGhYTDgwHRg63P0OM0UIPwDPw1CYYCDqkSY2nl7g0=
X-Received: by 2002:a05:7301:fb0:b0:354:cca:1cd7 with SMTP id 5a478bee46e88-3540cca326dmr2855507eec.4.1791588594254;
        Fri, 09 Oct 2026 16:29:54 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm9419413eec.10.2026.10.09.16.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 16:29:53 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 16:29:53 -0700
Message-Id: <DM0P5HE7X6JY.2JCW21G5D10FQ@nexthop.ai>
Cc: <patches@lists.linux.dev>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>, "Michal Simek" <michal.simek@amd.com>, "Andi
 Shyti" <andi.shyti@kernel.org>
Subject: Re: [PATCH 7.2 280/428] i2c: xiic: defer RX_FULL until all trailing
 bytes are in FIFO
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.22.0
References: <20261009140946.008206689@linuxfoundation.org>
 <20261009140952.249649769@linuxfoundation.org>
In-Reply-To: <20261009140952.249649769@linuxfoundation.org>

On Fri Oct 9, 2026 at 7:10 AM PDT, Greg Kroah-Hartman wrote:
> 7.2-stable review patch.  If anyone has any objections, please let me kno=
w.
>

Hi Greg,

This one is being reverted upstream, and Sasha has already dropped it
from the 7.2, 6.18, 6.12 and 6.6 queues:

  https://lore.kernel.org/linux-i2c/20261008-i2c-xiic-block-read-nack-v2-1-=
76735ed0b0bf@nexthop.ai/

Noting it here so the review thread matches. 279 and 281 are fine and
should stay.

Thanks,
Abdurrahman
