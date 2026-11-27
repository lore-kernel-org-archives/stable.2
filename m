Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790324;
	b=WWT0PlkF3eGgO34mReBkmYREN2Um9CEZPOc6Du77mf0/r3dXN39G4DudlE9bX/mFXnST
	 1A7LbUsJ4zbgqvhZUlBwIq8wN/W+wsbkLHV59puz+yqrLOoAzp7bMjCna8MeO4HdVYrpc
	 1F5O4v3xZDx1pQrOwP5u67BJJfybfyRs2Q63unMRuhBBgjGtTbjPqDMEmWm8RfbvMLlOU
	 /xZ6uFVvoeINXdkulmyixA6c0yz0iEtX4s4Jv42VDAtQHnZaxUzlQD+Czy0kp16fEJerg
	 B6y/ehNjeaLsaXwEmrpSJewudoXZdIH8wu/KI2KwzPHiWB8m/lD2HbJcnEK/5u5y/MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790324;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xJpIceYu2KxI6ncR8keKatQpZCcoR32gRrL57WMYwKo=;
	b=yXipJa34oVl1fx9EeAU3FIJa/ezBhH5tz8t5z5E7TiuaJUYWtI9fXQ30+ZvchDhFp6fR
	 nAX8YB0srM7wANwAHpB58bIO7ZWLDR8MbAJaDIBeZIIjursEsEtwxqqtMd78F21FQvi1Q
	 WtLCV3JzVHaexBjZkuUlq7pDNMT7rVwqcmtGZ757G+7KXNFNl6KGYJsmD79kDbL0OvoKA
	 a3eDnjBAIwCMLc7jABrAytvDBqs7ovoHsffJlhrBJgsmiLi3s1HABKrqBiNIBtWSoSDlS
	 6Z2tK97B10YFE5Mb1n8un+S4MP4CA/skYjk7R2MY1Vr39Xl5YwphnjnhTr6JS1J4QRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+UqYskQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD8606A333;
	Fri, 27 Nov 2026 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+UqYskQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697601F000C1;
	Fri, 27 Nov 2026 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795790324;
	bh=xJpIceYu2KxI6ncR8keKatQpZCcoR32gRrL57WMYwKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=I+UqYskQCs6jwv4Cusi7O+4pkTVlALVF1TR+b+Kgf+/PonKcfSXU00z977gQ/tBcp
	 FGkyl4J2uQZKym3I7F+tDjiSBdEzOjUTx1xgOMfRypRpK0vzAaAHarr38o7eVYC+hA
	 DMzW/o15vea1pYkiMi76xXQqRmInwGYUX9TKpIB6u03wJfJ9alVRvr27zZS39FD8FE
	 0/vL3o0Xs5LyYAVK+tCdysBuzI+1oMzgIDl/Vm7t7yFKyIJZORfmBd9G9h7zNsz3ME
	 F9vOALJ60KMrJFwgsa9Ud56Rut7MVOEYa0MLOv1wJ05559wERQgvZqNeLaKJGuq7Ip
	 YayBJ2Zk0Aiyg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>, willemb@google.com,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Jason Xing
 <kerneljasonxing@gmail.com>, stable@vger.kernel.org, Petr Oros
 <poros@redhat.com>
Subject: Re: [PATCH net v2 1/2] net: reset the mac header in
 __dev_direct_xmit()
In-Reply-To: <20261127105347.72997-2-kerneljasonxing@gmail.com>
References: <20261127105347.72997-1-kerneljasonxing@gmail.com>
 <20261127105347.72997-2-kerneljasonxing@gmail.com>
Date: Fri, 27 Nov 2026 15:38:40 +0100
Message-ID: <87cxrqgwzz.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing <kerneljasonxing@gmail.com> writes:

> Compared to __dev_queue_xmit(), __dev_direct_xmit() is the only open
> gate for skbs whose mac_header might not be initialized. A few months
> ago commit c2707480cfbf ("net/packet: reset the MAC header on the
> packet-socket transmit path") solves the case where AF_PACKET skb can
> miss resetting mac header if a few conditions in packet_parse_headers()
> are not satisified and it will cause out-of-bounds access.
>
> Similarly, Petr reported an issue about AF_XDP path where copy mode
> can also trigger the uninitialized mac header problem.
>
> In reply to Petr's patch, Eric suggested to add the reset logic in a
> general layer to stop future issues like this happening instead of
> dealing with scattered cases one by one[1]. So anchor the mac header in
> __dev_direct_xmit() exactly as __dev_queue_xmit() does, before
> validate_xmit_skb_list() so that ndo_features_check() and the vlan helpers
> see it too.
>
> For callers that already reset the header the operation is idempotent.
>
> [1]: https://lore.kernel.org/all/CANn89i+aacS2PfaMXnimzGgbCLz-JSnqo6QyoS1=
22Gf+kxya3w@mail.gmail.com/
>
> Fixes: 35fcde7f8deb ("xsk: support for Tx")
> Cc: stable@vger.kernel.org
> Reported-by: Petr Oros <poros@redhat.com>
> Closes: https://lore.kernel.org/all/20260817153957.3177627-1-poros@redhat=
.com/
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
