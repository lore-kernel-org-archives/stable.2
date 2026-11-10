Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326774;
	b=lY9aWu0tcm5xT0xZmt9jAk9Def3Bvt1NDVJFgrskEjwGvpOsDbP+MpiK52LLDtw877wx
	 GwVichqm+IuVwsgXyw8/ZMT4CHf19WWuMcCng+v6aIMBVhh6DoIEm8mr6kUXJj3jJW/5i
	 naUQiHQ8Zg2GJ0dYs+CxO7wmJWmwZvngOoALik4LP4xA/dT3beFWZIwu/DFEB6G/RIeBg
	 rWKJz9VoiQt55chpzKxhkzJivIFAUqnrc/2hAp7552XByxt/Ucxmd7DOHGQNWxYrRUZgU
	 q7LXvfu6Eq/Bzs019SbNmt/bGytc/+VQe3d4WnplIxpBDOEkBkbo0Xxr1s5YUdI+qGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326774;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-META:
	 X-MBO-RS-ID;
	bh=L2H/pxduNiYKQqjz4ouWTik9hJ0P2GnqDdb+wXeBGM0=;
	b=uXd1q8RuvIU70Th96tZqweeFOGvzLhkxUwam0WvXcKGNE1sbDOrt/J15xJuKMEbTzxW+
	 gwNze5nrVkAuCPK2pVJwmCqCiJ7mnDV+VzfJHNdpk5fmTF33S9cfJH+QSIQGvpV4rcgpK
	 c6dyPMGSw5lEAPLR5WUmNDQAUSJ4LD/yBWyj2H4BvHyhXPAj1ECeSe0jtICUh6JJP9jHS
	 Yg5jC7JSVrWEBhFxV/owoXwQG5i5a5UCZFDi+159BJmKImJKR9YBMK7x1o1Jc6nOKrY1L
	 InP6++QS8L+v6WL2op8TpasnWCSOK77ruYYa/shOX7oIY0X6EqwjhFRzQQ+XItgANhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=uKz7oHJ4;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6895606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6895606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=uKz7oHJ4
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jPBN15LVQzMl1M;
	Tue, 10 Nov 2026 17:06:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794326769; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2H/pxduNiYKQqjz4ouWTik9hJ0P2GnqDdb+wXeBGM0=;
	b=uKz7oHJ4fWyE4FbHfMfY3+a8Rus/wgGWqT9lD48bQ7N43K45LFGjX/UQ/MTWNV7Fo9UnEs
	5BnoZcNcdJ50OTdSnXgMZCNzxuIhv0OcA27rw8V/HG8KSY0PTgIY4WqcS0LbDZKQR+kOKa
	gwpXKbQew0+sMRBAqNCsQnmVrM/VAspgO26l/XOh+AhcNCjj25uG8YgMN21QsQgSB0MwvO
	s6DnYPPdsRCURJOD6NLoGKoQMFrCmyzr+An+k00qTGTJNIWxVrxwXcIVJwr8BEihO2Mcpw
	OYriFeO98kH7Q1Y+Cl7ksa3LJvYieoToOSrg4r7as13MXpMuXtxYxN3GFrTgPw==
Message-ID: <29aff55662591ec9b0e329b01384bcf24e3fb071.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Ensure stopped entity cannot be re-added to
 the run-queue
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Luben Tuikov <luben.tuikov@amd.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Andrey Grodzovsky
 <andrey.grodzovsky@amd.com>,  Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 stable@vger.kernel.org
Date: Tue, 10 Nov 2026 17:06:07 +0100
In-Reply-To: <20261109160743.17020-1-tvrtko.ursulin@igalia.com>
References: <20261109160743.17020-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-META: d6w7mquascwrry3moutanxuotoax4d3i
X-MBO-RS-ID: d325a14c4ca09da072d

On Mon, 2026-11-09 at 16:07 +0000, Tvrtko Ursulin wrote:
>

[=E2=80=A6]

>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

I've proof-read it. Makes absolute sense.

Applied it to drm-misc-fixes


Thx
P.
