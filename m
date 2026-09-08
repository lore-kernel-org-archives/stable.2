Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8129D5111B9
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858739; cv=pass; b=jBSF5p5QWARY3qNQXFQ2FWAcKwLCW52FBpnRZmFDVOqHorWrFQyCWcJh0rxh5uF8cdvbIS4S9awBmiKznJKt8ho1nRk+85Gh8mcMPqJPi9f1Jtb2y+rI63UhnyJ4D8+pbE1jzw84KPuMG8hp3NhrmyG6hYxpj+hiwto7iF2OOfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858739; c=relaxed/simple;
	bh=Ln5N6LgmXlAc04GlN1hKzCJC1CG0QgHSWv228EdYC0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4jP1wa39INy+eQnEdHvCqc9VylBIqXioz6H98q6QsaRo+Rd14LsPbjimJqAtJQMbKLTdpcQYjfgLFN7AkMq2/D+NoysBnb8P4RoGleLyKRnV9Aqp4NzrzeCfEn6lQChaJe8mPnJt/WpzX3KcMXAvZB/PyUt16HLPwAgHQan4z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=XWHIuzgW; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="XWHIuzgW"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a0faa764beso29377351fa.2
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 02:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788858735; cv=none;
        d=google.com; s=arc-20260327;
        b=ay3IH+jHYAwj6E04Vsqld2d6m6SdDpBWZVdIo8r5k+ksLWmEwivfRpptcYOsqq0znE
         RLora3bl+7ds4ShSxdG+P0hSfRbGinLccUSkrYx0hWEg/OAkoER8oI62Ht/5AoKSCGA6
         wjCf3uCEPr6KuriZx57oRJ0KO1LzWeNz3caJkMp9NRp6ykJODWKqqZLAB2uGToAR8rtH
         KFzPtTDzK7CmUAtMoXSNxAiC4DiN8PjMkUe4o8PJtgVdWQoBsFfO9+qnaMY9DFJfl3VQ
         hvj2h7TfZ1d9tJX0CPkGpSJW/GRgiLv2r7yv2TpUq+nE3z6xKV/q/OJp/DJiSaznJRiB
         n9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zp60sdfO4ardVW9ZmRnEnuo3Pw/0xpFjf52DftQhuI4=;
        fh=uy3i+Zyj14MDHiwInxJMS6m7swTiz2CEfrCkl4udRdY=;
        b=qThu1CadQeXP8I2Vj0N9Wil9sXuX7pY9prLof+ZGf5bdnCa76bTjSjJxBJ33pmqr6P
         QkKXgFU4D0OptIc+6zKd93R0HEh6kMB5dYmzPym4yXJxN7Ew4dL5KayeDULH5Hh0yVwv
         7OZeJ+jBL6c6KsFtgdOmh4GpmuZDnpyKsl/0Kp8dOO46cHJ7K4EAcdhqQbvIPBo08RuW
         BMRfETsQECPkcc7eEVHGFDq6idXKDDJnht07XJSXAB7eKQCm91pYGrkd1oQ4gDz1ve8O
         mN5CWy7aHcbUKMj52iSRCArdPoUyLZh5qN/8ljM7Cu68j9fUbd3j71wYqWRatS4sBKvF
         HIsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788858735; x=1789463535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zp60sdfO4ardVW9ZmRnEnuo3Pw/0xpFjf52DftQhuI4=;
        b=XWHIuzgWV40PFZ8HPljurhBn5rj4tX5+v4D1AAgPD9oF5RjjX7cGD6VoIM7sUJCYxl
         tapys12u9HlnRNugcNJxHtcaznVRbb2P20a1gUtKD1HxdrYUbfGdscSYNzNCF2pZDiWh
         VzxgqkG4FJsgRK1Py2Rjw77ZKO5xc3XPluYMeH2BmGqFSWx7UFG3XihONWmR2TZYFZhV
         8Ral2z1fkcz6QYhFQTlD6Z9xizHPgRO8j7wAacyjTiheQumt8AdEigf/ni1T0p5gjavL
         MpUn8X/UayPl5CMEvrXDOvmpaY9KomOxEuzi74PHJUROjyhnT01CNBgDIA2UuCuQl0Ks
         3xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788858735; x=1789463535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zp60sdfO4ardVW9ZmRnEnuo3Pw/0xpFjf52DftQhuI4=;
        b=aVMlqmr3juHguIdrk4AgYceVT2ieBpU/NK/ltdCQtlykdBQfiz5zI3xBqrQaGBqXPj
         shD9IjHJkw3ZJzHxRQJ2J/5O3Ec4C+P8YuIpvx+g4C4RmEQEvnxsnjpzrHV2Z+U3p69Q
         d0XM8bch8YsTjV8DERlhJKQgoIPVrit4cpl0lCTvAnd8JJerHeRvmM4ahXiC1yG4jStJ
         Oiej8u9aXKs26FyQyw03VBOozzrTivixaUptrq+fSmVH4KR8agP0C8U4M1KDNONXB3PL
         G/89VPhQvAAn9O4VMi6bukr9Eh2UawV7KEfdtcmhmmdB75J/Du+s8zaXbmEXUkynd2AW
         qxTQ==
X-Forwarded-Encrypted: i=1; AKwUvByFQlF+UPnJbHYmg7/d9bymq8b6rImyafP+OiyPIj5YaLHA/TA7qe1eMKul5ZBTpptJ1tpj3TA=@vger.kernel.org
X-Gm-Message-State: AFuF++m23so2VumyBxTYT+UOh1XCcFVg+kfonzgbmtRfPxSSdP9LLP5n
	GSKz4jXWnaqIaef1z8YtPlYXZkDCQO+bPiPlYh2amaTRD1f5M2RzrP/Qe5rvQ80fIdDx1VyuuaA
	3Gk/TarfQr/I3C5IkRqHh0stfMzDBhIfSyvRKYYJxuPk=
X-Gm-Gg: AYBFou1B7eC7G2BkFiROw1xwLjz43K3X80Oz6kmveKZNOJMtAK2HljxBY9JX3TBBgoi
	/wJcoRYjxTFKBc5OvB575tPjL5Q0m3afZhIgSkmtlQfkjsL43U19aHx0iF+lel3Cl719X+EIYpJ
	uMW4oee+FopM8jISrz/07QzhywbrsQ/FLjFDdHo3crrZovYgbcROthftzxHH4TeOVc9K7ru3obp
	GzJT0hMdVY20LUv7jk/DJczLHAcFrUwJpM7szukYUZVIOYd8lzDapE7pZ8UGrhBi9tgWHG+Mlu7
	acX8mbGVbAul8vSw7304/cTHs5fg/n71zwK3CrkVL5F9szKVY5HhJ0+QAiJtNH9VQpYsZSIHKFI
	=
X-Received: by 2002:a05:651c:2214:b0:39b:2ff8:64ae with SMTP id
 38308e7fff4ca-3a371baa751mr31491061fa.9.1788858735444; Tue, 08 Sep 2026
 02:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788539302.git.zihanx@nebusec.ai> <a2bd6f3ed29919a7328363b548299ae583f052b0.1788539302.git.zihanx@nebusec.ai>
 <1502561.1788855907@warthog.procyon.org.uk>
In-Reply-To: <1502561.1788855907@warthog.procyon.org.uk>
From: zihan xi <zihanx@nebusec.ai>
Date: Tue, 8 Sep 2026 17:12:02 +0800
X-Gm-Features: AcwNN1VjbRsYQi4-L2RFvdf4MtUlRnpbC25DyHdWsl-aWFY71LW8z7GWMLBUSh0
Message-ID: <CAANe3eRBFAMdZaUEL_ds0xc2N7jC8gOT1NTEynY2oCQimiv6Qg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 4:25=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> Zihan Xi <zihanx@nebusec.ai> wrote:
>
> > Reaccount encapsulated packets against the UDP socket before queueing
> > them on the RxRPC local queue and drop packets once the socket rcvbuf
> > limit is reached.
>
> This seems reasonable.  I do really need to add separate accounting for
> buffered incoming DATA packets and for all other incoming packets (especi=
ally
> ACKs), but I think that can be done after the skb_orphan() point you add.

Yes.  Once the skb is orphaned, that split can sit after that point
without the UDP rmem charge following the packet onto call/conn queues.
>
> > Clear sk_user_data under RCU protection and release the socket only aft=
er
> > the local queues are purged.
>
> Is this actually a fix for a separate issue?

No - it's required by the skb_set_owner_r() change itself.

skb_set_owner_r() sets the destructor to sock_rfree() and does not take
a ref on the UDP socket.  The old rxrpc_destroy_local() released the
socket before purging the local queues, which would be unsafe once those
skbs are charged to the socket.  rcu_assign_sk_user_data() plus
synchronize_rcu() is only there so a concurrent encap_rcv() cannot
attach more socket-owned skbs after teardown has started; sock_release()
then waits until those queues have been purged.
>
> Anyway:
>
> Acked-by: David Howells <dhowells@redhat.com>
>
Thanks for the ack.

Best regards,
Zihan Xi
