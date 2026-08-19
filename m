Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060B4363C72;
	Wed, 19 Aug 2026 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126674; cv=none; b=XBRvFUIJK8b2TyoIy6Gbr3zWwapZM4u9KpjMWJPbLv0tObMnFTNk7t9xOHGB/n4IpvtEFVoUcbgoJwDrIgKLl/HIaPaBG84Cv/B+TlwmfaG39aj42zNQWPY+S8WIB0vlKvreVoyh9IteWNxt25bAGc8db2+5Iq0o1zBmjNvkgS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126674; c=relaxed/simple;
	bh=A773qLd3ogXmuF14lwth/VidQueV4hL+Yk1fLJrt6m0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nR4OBqSOvt9aZiuGU4RXaian6yZot0yoF8YObA2B0geVAOjACQ7r2II8awRbMgHjsdYe6KVnR9Hv1M2u/EO3NER4zoJeZtzWHdS2oti5tej3xeBhR/F9VFuyBsWBlC6d8aWA0H5TLJfZ5/uO4gfA3Y3QRo2Sg8AcitsDhZX4fes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ludFtmFZ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ludFtmFZ"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hPzcQ2qbQzKvtG;
	Wed, 19 Aug 2026 10:04:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787126662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A773qLd3ogXmuF14lwth/VidQueV4hL+Yk1fLJrt6m0=;
	b=ludFtmFZqyIMiJTTL0gs9tJ8VvAw6Xn3LwQspn5ynBJ+UVgbI7IUe8v4grZiJXV9oRxQB5
	i+tLmis02MEgQweJ3PnP1EF1JRXER0/Y08T4gB/jXu20VlObJqNFYSRo8qUcT8WsDKsuTx
	BCEmg8riSIIAZnbtx4lQKKnrQYIZ5XmZgQtnhefKweWr3aiqxmQoE8TPA+b50NHqB2CA59
	mhost6nXt58+Ilz+AyirBL/D63iz8uqvT2qvE4++mGIO8Ad+d0uITIjx1XLQrYwCZX1Ldj
	mUb+eZCFJ5trBFrsxBtkD6HUcc0BBN02fmM705UwG4TY4THwCriNJh6Ea+7Ylg==
Date: Wed, 19 Aug 2026 16:04:18 +0800 (CST)
From: Ming Qing <a0yami@mailbox.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <1775000803.326379.1787126658830@app.mailbox.org>
In-Reply-To: <CANn89iLBDiwaLZ-1cp50HQahgrDD8ZDw8mix6C+Ukf3v-4xXxQ@mail.gmail.com>
References: <20260818162108.11456-1-a0yami@mailbox.org>
 <CANn89iLBDiwaLZ-1cp50HQahgrDD8ZDw8mix6C+Ukf3v-4xXxQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix AO info use-after-free in
 tcp_ao_connect_init()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: 64dc00576a5515b9780
X-MBO-RS-META: bdc6xgp7eoyysuub9brg9r5fqex39okt

On Tue, 18 Aug 2026 at 18:21, Eric Dumazet <edumazet@google.com> wrote:
> Why keeping WARN_ON_ONCE(1) then?
> This will crash with panic_on_warn=1.

Ack, will remove WARN_ON_ONCE in v2. Thanks!
