Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008114;
	b=5txmQX/uOFXpoxhYwROx7Z3wBd2z/+VAxuTXbSfevBNsz72JRoj5vAOtZEaNT0x9GKxJ
	 wxn2QRoJHfTzhUFP7dvowkb4FL0wKW1p5/9xhew8hoYXuAGHHTuVEnbJbKY6CXKrroaEE
	 OGIFSEi1E1GEr7mX0/t3CImViMKChxPWyuxj79x+IrKxCb8silMnGd/Akfjku4HbLBVYM
	 UtScK/+9t6JQu/35ubt7VMQ7IVcJh6KgI5fbVWUA6ybZJ9s53y8huRlp0W5G8WUmg+3Ml
	 q+GAyP/YjOoVKG+/i1EMZlAWIUJOnyT7UGqrlv5KAXD4hD+8H1+lnrE2uYNN4XwUOEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=p7Dcs8rqFWgV7vy5jckJd9/OMxXaRSwC9PD3XcVQ8ik=;
	b=l98epKluQBuip1UDdnr2I4Ip8S4ZFghv4f0/WwU8Omhfa8v4J2CLlxGQujJaYrlaHX16
	 Pa/xPHe10by5FLd7U11huFv3SPLuzguZUOTgQIVcJZgZb+D3n+cd++a1CMZ9eQTOClGc8
	 0J7b3oy6umytZP921iKJ8UdeoFZJtudfUXXThlhbl9eygtK/RjYZX/Hy86zOpoEuR2Tbq
	 L3VeUwo/lB2cn8liQJ7O1xWrtQmojWn0UhuH/GZwN4GHH+xKqYHFNtsnvAiTbG0CTYbz+
	 U38DslH5aSTQF2+oI+DLZPNvININgC535OOMauhM/FbXh2eOxMmOIOU+JZ5XVrGhO5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Llmgi4Dc;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3A0606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D3A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Llmgi4Dc
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b467581b98so11465265e9.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795008113; x=1795612913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p7Dcs8rqFWgV7vy5jckJd9/OMxXaRSwC9PD3XcVQ8ik=;
        b=Llmgi4DcPx325HGQxrpRFLWWHauQKMHVrrVD7XSd9t+wRFKL/4riBJzMtkOl4Sqate
         8nlBRAPedu7tq9EalZaGeXlImuSahc8dfswPg8GGEE3YzPp3sdhSV6jJ7RFp4I7U8uYs
         a2lnOfUXTfx+qXHUty/bX74ZYMZxL5CLD7texNThaooTfMG7J5PV/m0IIOdWK6SUZu59
         oM8pW8sZONvoMjT6EZBxzbhkqk6SLjeV/WuKsQts9/JSVu75NU8j2SQFk1GpXyIylviH
         T8w40rbeSXJgABpY0DdkI0umRKJmNojs5wX18Bj4nP4y48cDCBYVnHBIDbGyYqxTjuLu
         nC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795008113; x=1795612913;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p7Dcs8rqFWgV7vy5jckJd9/OMxXaRSwC9PD3XcVQ8ik=;
        b=oDwBIZQz8Rk/1ueIiaC3QOp5m0KB0rFpijNrbah3HcOdRRK/H392Zpio9ywH/rSxHv
         viz2D7wl3iejo+QtwUzPwwVYpO3yF7tHdsH54aBEJuV8NQXVks8WFVcg21ldQPO2HrW3
         nGlCBnvxTcGeBN8Ze7vAy929Ob6z99FGvHb0YFRITT9DFBDz3mRRKTRyMqchNT3Hva0i
         fLPMuqxVW5TfCjcQm6dS4z86ERXcKQkhDad96WAmbN71scEKWzMcM1DWZ4h8zHRXABPW
         8lbg94RED7I1YgJi4x1yQqj49yGdxw7O2oJDfTTXzVq6NXb6p07eimG9OhtngVlpH8OU
         xyeQ==
X-Forwarded-Encrypted: i=1; AL+hErH8/OEVXht8mRTVNJnCdhSVsJ1J//16r5AeohQ2apNWp++LW/3G35U7PXgICKMnReF6k1dV23g=@vger.kernel.org
X-Gm-Message-State: APuU4Z89PElJpjxdogxoOkLpyx0w5CSNSTNY/jl1J1ULPJCDE8XNd8K1
	jm6nZl5BgPKF7DkTZOz9yqNyI6n241yg9ZPiWS6ioBxdDsZ8IersDIC8
X-Gm-Gg: AYBFou3ezMewr7S449v/Xp8pzopX/6sitVLUUsI9ucRqe0+5XeEJW8+W9X9atmFLCnT
	9K7z15aympU3WEf58JUbzTj+V5mYrjGfwW6j1hiLnYY2k7nrTea/aNtb998huR2VJaR91lIljKi
	E7pY9LjKngSns0pzg8fDOjSGAbUJXLGkFBksrk0vMpXQy7y4faBbYlJ67Lu191pN6GFn6fAh9A5
	vYsRyzXKt+DhPBtLrTNRmzrr9auGIrHpK7rOUNBKE/QI8VZw2IB3fWXyGITw2ITkhktrdjFdSf9
	nprQEDAIVfryS4F/YWZj9ydWVbws6j6BJJ/a3jIUM3lUOomL1qnPerbdfSfdiJ02Y1ZoUsfklBy
	PWTD65EvCVbyoST4fG9ITMdB0q2v3UeA8pIwiMwi5fsNJV47iGeWX5gvEDyRE4XT5kPt6Kfsl+j
	0pbxn1oGSwd/7gS3h1QZE9wc0QJmHIFUFUCtTlzFkJwvF1mFMyU6ztwWkG+k/PA9c+Es35460RM
	F1KH2bWBgag4KVg4ePDzmuMGxFFNGuweygmt9FARv7FEUNOhQ6poMIvGNuFYH7W1X+bytD6G/Yp
	dgECXIlgP5m4MvlPqUvkBiluTopflQKkN74xRC+AQYnZ93tGdte4DE9X+LnSwvHFCOgh+JtHHlh
	0ajSLX/LE0gBtz9FlMsDAWhhOU3njZ640OHU=
X-Received: by 2002:a05:600c:4f4e:b0:4bb:7033:c92f with SMTP id 5b1f17b1804b1-4bb7da0f671mr58393325e9.11.1795008112703;
        Wed, 18 Nov 2026 05:21:52 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65541f3b3sm4899303f8f.23.2026.11.18.05.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:21:52 -0800 (PST)
Date: Wed, 18 Nov 2026 15:21:49 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] igb: fix RTNL assertion when resuming from
 runtime suspend
Message-ID: <rab7ustlezklu43vnjkby5mqh33bgqoztlz6bv5wxkjqfvbtfd@imjngi6j72nz>
References: <20261116153041.3002666-1-antonio@mandelbit.com>
 <20261116153041.3002666-2-antonio@mandelbit.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261116153041.3002666-2-antonio@mandelbit.com>

On 16 Nov 16:30, Antonio Quartulli wrote:
>Since commit ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in
>RPM resume path") __igb_resume() doesn't take RTNL for runtime resume,
>but __igb_open() still calls netif_set_real_num_{tx,rx}_queues(), which
>require it. An asynchronous runtime resume (e.g. after the link comes
>back) then triggers "RTNL: assertion failed".
>
>Skip them when resuming. The counts are set again on every regular open,
>which happens under RTNL; the only case left out is a fallback from
>MSI-X to MSI during a resume, which leaves the stack with more queues
>than the device uses until the next open.

RTNL is not held only on runtime resume, it is held on a normal resume.
__igb_open() skips netif_set_real_num_{tx,rx}_queues() for both resume
types. Maybe it makes sense to skip them only on runtime resume when the
RTNL is not held?

May I ask why is it okay to leave out the fallback case, can't it lead
to trouble if the counts are not updated but a fallback happens?

Best regards,
Janis
