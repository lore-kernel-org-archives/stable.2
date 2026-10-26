Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004570;
	b=c1df9XLFaTsIxQBsVDCYa3E05iqSfWwuUutb7uS9d5k1v8oUKHX7RTPfHV1HE6acBwg+
	 yBQ78CLXtiK0Tw0ICaFV9F6cm6ISjbd+1RQN1p5SnwYd2OEh1/N/p/skhb8YL7XKpJC3+
	 GNP/0iencbmftiorUzi+Bb0wwnQhLnAav1mivRO9cKEW0rmrrxTsm9PRF19EiN420UKjE
	 SG6PlVEaWO4kfxjAm63gvDhQ2LyOGOMV4vc24RQ7jlxQkmJ8xlhsiBm/rZ0qkucAARLE/
	 95vAGl9DkSXmOBcZEB195IcTFu5p/ew7YEckh71pBXyOM7yHHaczH3PwElWH5ZJj4vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004570;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hEUhlXYmOnvIx32pUMr9YOGu/KYKt6iMeMoyJb1Rp3I=;
	b=u4KtBCTl9lN/P5oGpeaTvsk/fNQhDDxG/r0WHvHX/8Jy512KE8pQWPKCzvZK/dKi7mTF
	 B5tMtw3t78lTCt2/K3g7TEWkjLQK2/nLv7cZD7MMcFC1b9q/ccdiNs+kxtuITi278yz/o
	 aIhHZ3OLrkhJyoSP/u7zgq9msZYtzMyhdtQW0w5trJ9TR8Y5Rhm99EZUvpPlxKjI1rTst
	 NvN/ynM5lxj6MI+zcR4Ly0AhT0CCKuxiXK+pu0Qg34zaI4z+h13ZBI1WWB4v4rdCym+ga
	 ZbgyH/2I/r8CxdQinobiDdj3MniuT49z0+p2zSXqY+uGnx+1jL6vAS0+N7W0kpAGtjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vnl0om8K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8C606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vnl0om8K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB201F01829
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004570;
	bh=hEUhlXYmOnvIx32pUMr9YOGu/KYKt6iMeMoyJb1Rp3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Vnl0om8KVDS7hqHj+udnO7hkLlBn+sitgsxLsJXTL8ZebdSwEijKyVFP8cHTzFLI5
	 mapK67swQ1z4PlG9lrl2WvfzNI8wON+74huoK/rS09Sh0QI8+ePuAGlqxDtvQb27sc
	 fiO0QlrNTu+xJk+szl6euNFxFL2PE1kUS9P3a/WEXAbDSGvhJtc5dxhRSCpDA0Zo+r
	 FNYYfJ6nvAVxmOFJ60IKbZnTJxhN+EFRcQfkWsd3g6cLbmy58Z8WK/MD39ZyRAhl6d
	 ThbUEugoBHqYIXXqJ6b7GCVFd/Ed1apAYcbb1jlJPxg+1q+2shlfnsttLjuj35fMdZ
	 OOP897kamzxrg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-49429181ce9so1533195fac.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 01:49:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByJuhEPjOsmhKR/gFEB8I5DzT55X+iYYQo11cErNc0+OUUp3nXXTw2GI1UogzxNykOw4U3NSEs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKV2o/nq+ptT5511pxLUQvyzzqbz11jK5zKE+zW2X0eMDLNeysG
	XpzGbjRpqGfoxEBsfc1A4fasQMa8/1qd6jom+aF1Ti8yznbScTX4FeIxJCludfegg/bRjXjJfdo
	U3g1rmg0bn3q0/kLfwR8tgi3uoU0kcIQ=
X-Received: by 2002:a05:6870:638b:b0:4a7:5256:4643 with SMTP id
 586e51a60fabf-4a83f1cb6b4mr4108141fac.3.1793004569380; Mon, 26 Oct 2026
 01:49:29 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026082035.335770-1-edumazet@kernel.org> <179300318428.3327.13029076428746317520@kernel.org>
In-Reply-To: <179300318428.3327.13029076428746317520@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 26 Oct 2026 09:49:18 +0100
X-Gmail-Original-Message-ID: <CAL4WiiobBKAoqcyEu1P7GkUFJe0=w0hH2NFz2Tf2V=oWCC=hAA@mail.gmail.com>
X-Gm-Features: AclHuK-kCs5qDDd7Sd5Jz3gus2y-tEzXAz5O5Yd5Te4LMxEQpTSZWeyvvIGCESM
Message-ID: <CAL4WiiobBKAoqcyEu1P7GkUFJe0=w0hH2NFz2Tf2V=oWCC=hAA@mail.gmail.com>
Subject: Re: [PATCH net] ixgbe: reserve TX timestamp after skb preparation
To: netdev-bot+sinfo@kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, stable@vger.kernel.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 09:26, <netdev-bot+sinfo@kernel.org> a =C3=A9cr=
it :
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>

Manual code inspection, coming from Paul Moses discovery for igc (with
a reproducer)

Several Intel drivers share the same defect.
A similar patch for igb is also needed.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
