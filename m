Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793226912;
	b=nhWpDxzNv4XH89Z50hNHoWW4bKeWzxMnQcOHwUQAn156CnhZg279gqQfWLRfJXX5XH7z
	 40AEHMcVcYPBcmQbASTnW7PSQ1vLxwzlf55srb/yC6I0MHxoi+RpALfMjDEqJEr68RFPU
	 ASKth7qa6C6GufhoJmws1hYQyvW9zyEFXKrzUbcuDg/JHi/S98+NPis3SnRj67TsFgypL
	 D5vPK/tZGQ4tuzoyHdPp8wn+DV3bAYLuxAfu6ki0zjWmqbEqA4ijgOLWPkd4ttYQFxuXY
	 Ot0YKIGMIjNDwC9tVMqLHOObQsfGxzzxnM1wQ/bVG/YFVkbdA4v44aGQS2xUKvIGIbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226912;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fj1eS4lfc64bEh7OA3VZVWAWNRRiYwPnCuxQ11/d7AU=;
	b=PXfxACsw4U9XmXu3gS0HG08B+QMwSuQ6cdJ7sudsnQZKlvaHzU1kFLtGrtwl6cKk4sJH
	 RNkk2Y7ypWW2pBy2pbsAsls6AGRUQEBK39WdJUd8XeNqKIBUUJ562NfB6pCPHGvwt6e7O
	 MpKUwmeIlBNk+pmuFAatxLgulqMFIhN62vzUeyVUhJKtp+UZiO7JAasHRdu3G+9CoxP/H
	 ZV9wEekI2i8DTpkKjbn/3q5NFs4L/K4x7r3cV8rZhdMkozWjo2G0qLOxgHm2Pj3r60po4
	 Y8m1Z8kd4QdDrbn+K7Mtme2tLmqaMvPIHD6moL4jhp3itmQiwe23Z66daqMUafrQtRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTipxEk+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C2606A31A;
	Wed, 28 Oct 2026 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTipxEk+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671081F01829;
	Wed, 28 Oct 2026 22:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793226911;
	bh=fj1eS4lfc64bEh7OA3VZVWAWNRRiYwPnCuxQ11/d7AU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nTipxEk+4XmCj1pqLeR73mgOlf/JKYE9ofgC7PRtRVI8QP9EnEmMVPK6d93IfIpw0
	 0tNxQQvGh16tRlaGBmj2X1F35Dt+6te05i8wmcWgbdTCFiYrW/nMb23npkocU62h2T
	 XOOdAsHFko82DeGCpmST/47EdVCuiLU8fecxOSu2JnP8rJFu4hcJQX5LFzdoujOltg
	 vfwoKyKWFi2K0g4fKeQ8KM1/BTWGD2pnJbAqzhjq6PzsPfIwzhn0TBZyCkv6L7+iFR
	 7eO6t7mONUb/m78wYlzfHp6sF9oeJVIOFCULbN4mzn+2IvD9yRfH1yv1gZofgfQNKr
	 mk8yxqV4cpcgA==
Date: Wed, 28 Oct 2026 15:35:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: dhowells@redhat.com
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, jaltman@auristor.com, stable@vger.kernel.org,
 netdev-bot+sashiko@kernel.org
Subject: Re: [PATCH net v2 2/3] rxrpc: Fix counting of in-flight transmitted
 packets
Message-ID: <20261028153510.2c0b0f23@kernel.org>
In-Reply-To: <0f7f68bf-d02e-4bc5-accf-5f89a599d37f@redhat.com>
References: <20261020201258.290827-3-dhowells@redhat.com>
	<179262720290.3135.1509720869529893686@kernel.org>
	<0f7f68bf-d02e-4bc5-accf-5f89a599d37f@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 10:07:14 +0100 Paolo Abeni wrote:
> On 10/22/26 02:00, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >=20
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0 (1)
> >=20
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >=20
> > - [Medium] Incomplete in-flight accounting: if a segment that is already
> >    soft-ACKed gets retransmitted, its tq->in_flight bit is set again an=
d=E2=80=A6
> > - [Medium] Behaviour change on soft-ACK reneging (ACK->NAK flip). =20
> Basically sashiko says that the accounting looks still not perfect. Is not
> clear to me the new status is good enough.
>=20
> Side notes: sashiko comments on patch 3/3 are not blockers, but you should
> revisit the commit message in case of a repost (and do not include patch =
1/3,
> postponed to net-next).

David, this posting is almost 9 days old (which is a cut off point for
some of our trackers). Could you please respond?
