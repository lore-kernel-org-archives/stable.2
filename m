Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278862;
	b=Gjj6vexibQQPVxSA++EP7B90nMcefhiGJK7CyCIC8k/K+6jCu5uaOpPvNl0Zm4P5b2JH
	 0fD6eq/CmCFzjsKP+VGP0AnDSYLSDTlTFjQbtFTNu7b8CEp/wGvIhFAdvJH+E2rW+rMsq
	 ioGUx0vGrc5SBOa+P7s3mt1L8zaw1dJbt0Sh66yIRb4gLhz0pEle6IdV8VKUe6r/ki/ob
	 jOzOLJvbClDa6FyBi2i8uPGTgAmVb/M0pgl9A9ZSD2mShLLHthCdsUcvKsIH8euuxpZht
	 lVFiku+aRxRdMk3jvkQCOeYQXQF4bVWWzoBlZA6aM1chcVTjdhvHOZvv/Cp+3svRofg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OGI87JTmKxRRfHEIswCBbT6wa5pP+uXrDb2vu3bdzdI=;
	b=PiF6gPIKdJgKW+xGNPxyuq2q8eWbN5FQ2T7ZwXK+J5Eizf4EsUndBwyH/0FNJbletwpJ
	 n2dQca1tkyNpIBrO2mzdYBYylYdsH7uIhE9o7He85AJX/tYeOTIw9kDFa9GF0vmE0zKgz
	 5dmaZuGZoKIGfEDVt89kLPlPCnq7jnSOXeLE4YY64ScxxHzSimcD+v7C7LrX880nlbrfa
	 3suQta29e5kHoz5bxJ8N8jwKsIn3KJeMxU250ccUj5TfAeWj4O2N8hUr/U9hsW6nlrAGF
	 SByN3+zxGEVd/UCEeF5hjLVKmp31Kya37jLvEJEsJXN6QQFjHSUtKMhD48ySg6PbHrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xXDhpVPK;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA961606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA961606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xXDhpVPK
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-99be54f9c14so1119826241.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 18:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278861; x=1794883661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OGI87JTmKxRRfHEIswCBbT6wa5pP+uXrDb2vu3bdzdI=;
        b=xXDhpVPKhEwmXYlSdgVQWRD0yKtOa/0Jw/dE9lGk+00h/qpIBRBu6nYBUWXUzsBIKu
         Mk8lf9mhxkiuZuVqgGV/DcNb6gN+cqUzzGaoVl5hEoVetgWT1Qa6qEvst+uqueb0Rluy
         rBpM45G0Kgmf7f7iLFzxPiXDygzfN35egxwAa8x2ibzfO5rHCUYA8aFVS8vz4Sid4MJh
         tx52lBzwWWNdu2Bllk8DdCHnir32H9HeDfZcmF9poJ44gPcpBRnEuLO/ceeQNmo9So/9
         ZnR5bGpZAXa1CAiDxN+3JKm0XU4q8b6B+hCLP1i5opauNmPLdkxI/Vd+TEPrE4qYv449
         BA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278861; x=1794883661;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OGI87JTmKxRRfHEIswCBbT6wa5pP+uXrDb2vu3bdzdI=;
        b=IM7gJtMvlUnor5ZBACru++q5uKFs5S7wO8nBNhJP/4YxD9OKYyTGyj+5be/imKL9+2
         gcqjeYMw0/zyQ2tVJYXbE/apv+p6yriJNbJPrgN40X1uwbLr70OAcn6langlEfPFTDiq
         dMNrer8PSpVW97wlWEMwDXyLUc3R1s/Pc5/m9cN4v+dkb5tFg+FKeET1+IYE93O7prsf
         bUDyn4MYxN+FbL1a0T+Mowg0j+W0LUdSBs5cKsxfTb5Yfb6Odgs6U7J4LZSGZ5HIk1VC
         0bQkqLwp/p6hi7LBjQZY8lLOTGKLZK/4HvFLRVIPrUzyUxo81LJPih6K7P0OW0VS3o7w
         ZT+g==
X-Forwarded-Encrypted: i=1; AL+hErGQgpe1Jh2EneO8hvXFul8D87gMvPSFzC6gTMib2mNFF45dI9+5SafGVqucLt2r672spzsSTj8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZeRSxPAf7fu5HjZ/73htZ2Ps9n8NvSfMFijl1kz3tUENygteb
	WDw4MQHW9INVnMjV/250FR/KFlReblRLYRzlNeL/mAxcIMCLAYwxOdPR
X-Gm-Gg: AYBFou0hUskGRjtaSWpT8S86Lh2aS8zZHEYEBvxaz4L/ZYeTg+F74nIeUTONyHf/+4C
	/gWYr1jGoGy/Z4oLJ6VD5xxnpGYMxnvaIRrBVJWuFIbEv3f4Dcll9CYGhbH+VG7S8SWBKCUf3Jy
	iGvbzo1DQOyDnL3SFobiExnbxxLANhYX1t9EQIBnbGN/vrt2X8ABU3xppJVMkvyTBzI3XZR3LVI
	QWRr3dCoa7vGVgIp1pIU6ouBkOqvvW6dKqkezpTmcJD/1FSpk1i3GqizmwxEywlsFKyKqX+fNzi
	1mlTCuOJq0/N0BKHu+O2XEI5zyWkGn1xlp3eBDd/el/ay/efVeobA267u4VZ2z/9LJnULedpMJj
	SxDCglkVSrWlFKyhursBeovaM0EF9BALo/DgtKU3aBWifFz84Y1Cb076IzvfS8S8nJ74N5nuy61
	IC5FGeTMPfqjLz1fNHfroXIHmc2G5XMRRutYW56LUBMXIHHTcBlIXXVQ/36im+pAhhzn4/ZTav6
	9RWnwZzgi/IWGyqPSURrlWq+KrADG74JDfCwaWeUeUsHn4QxQSBnyx1FKeFbV3VsKeWP5RQAGth
	QeFb7wqi2GpI1DVmYArB5fyfauYdDYo/fVPIDrN2zJq1IXFDGM/roSFMXxj3Mb3yJODvsfa1h4H
	EqX3jto3SZ0FsBNrFxI/iQoP7lFsH3lZhb+YnOsy1gS/y3kRbAmovpDYSia3++HitXPGe7Bk=
X-Received: by 2002:a67:e116:0:b0:7d2:d876:fb3c with SMTP id ada2fe7eead31-7d3011e2755mr389213137.35.1794278860666;
        Mon, 09 Nov 2026 18:47:40 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c2019bf87sm1116873241.11.2026.11.09.18.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:47:40 -0800 (PST)
Date: Mon, 09 Nov 2026 21:47:39 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>, 
 netdev@vger.kernel.org
Cc: dsahern@kernel.org, 
 idosch@nvidia.com, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 yana06070@163.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 willemb@google.com, 
 tpluszz77@gmail.com
Message-ID: <willemdebruijn.kernel.2c8d7027641a5@gmail.com>
In-Reply-To: <20261109014400.9025-2-yanxia@cmss.chinamobile.com>
References: <20261109014400.9025-1-yanxia@cmss.chinamobile.com>
 <20261109014400.9025-2-yanxia@cmss.chinamobile.com>
Subject: Re: [PATCH net v3 2/2] selftests: net: exercise SO_MARK on connected
 sockets
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xia Yan wrote:
> cmsg_so_mark.sh sends to explicit destinations, so it does not test the
> route cached by connect().
> 
> Add -k to cmsg_sender to connect first and send without msg_name.
> Check connected IPv4 and IPv6 UDP, ping and raw sockets with equal,
> prohibited and zero per-message marks.
> 
> Add an exact mark 0 prohibit rule before the connected cases. Connect
> with an allowed socket mark, then require rejection of a mark 0 cmsg.
> 
> The same test fails four IPv6 cases before the kernel fix and passes
> all 54 with it.

nit: empty line before Signed-off-by block

> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
