Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494176;
	b=TOsDK7XYv+0QbglxUOs4ic/Y9JCThpn/akN09fsl8OR02VXGFSJPOAr0oWHAb37gGxVQ
	 B35imGg7sn3vW33Wo+IJIiNrmF85ogPXp1R7nbu9kB6/k942NzPfqR25Zh44vIBL8Jcam
	 cOKCE++zQNwf2jNzIkWTvx/mn2ozetlirFabtLWyiTITA5BJEdsLAWChL9OOeacyK0aAE
	 eg1hpajN3STNtj9SP/PU8xfwwYqTYPR9gpZFtlPtEqapLk6ALzmbxS4vtmDachjEtv3zO
	 x+Udz+97gAJ48re9jGSRhtywTajUmDr8l5Z1K8L/+AUC9E6JCkWlLCbvaO6kNIE9FqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494176;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	b=Bdv0S5vBUotci9an/PogT9/g8PBNNiyQee1BxHq8Mp+GFTX4KQdN2U89TcSBrxDohLlY
	 EbC8g60/IkYShtX8uJ6eWh0hzmjusK8UXqPxl7IpvWdTIJeybORspss9POW6oaRBtikYg
	 I28QR0c+A4JKE11lKCfX9YUhNnSiscUIWd2zsOfvyRyVg04qmm0R0HHDUjlUXVnIWT+li
	 xrBbSGFxdL3lV1f2R53Yzt7Qev5+zq9+tdbt6zLJInfWuBm66gaS0wIFwSyEPytx76wlz
	 FoMnFM/BkJTnzVaW7afJG9tOJ5H7L6N6N8hE6zIUVQDkaY0xooob9m4HgkVG3fG+4rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcUx3IQr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DA1606A321;
	Thu, 12 Nov 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcUx3IQr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AA51F00A05;
	Thu, 12 Nov 2026 14:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494176;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GcUx3IQrY95GpMz1YuLvtve+j/PK/uiacmn4jnGODi1o/uQnmYZtG4O5lLStFR8JI
	 76AXTXn3MMS0nbMuKnp2qDg+TAkS++7cNdLUPTt8eZYAuDwVIS8S3iCfBU8Q39IU+b
	 kVGEaSdKEaRVcikAJyVttOdV3UuDy2L3emI3yJkKpzUVRv2Ugn0RxOk7gAb+Yzk+hr
	 8wMJ8DC0mmpu+MGKyF0Dx863zHVSw1cRvyrzDD3IeN9p4IQcEqnnPQGHLesPYZJSKi
	 Lp0ddtEfnfFIzn5Zdgku/nZHdZy2ENBZUJHLUs4ZI/gF/3b48Qce6SqK9u7ThhBLAP
	 MSrH7l+jcqVIw==
From: netdev-bot+sinfo@kernel.org
To: Anthony Pighin <anthony.pighin@nokia.com>
Cc: netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: gianfar: clear the pending Rx skb when freeing
 the Rx ring
Date: Thu, 12 Nov 2026 14:36:15 +0000
Message-ID: <179449417576.2168702.16619704784193243313@kernel.org>
In-Reply-To: <20261112143140.1395197-1-anthony.pighin@nokia.com>
References: <20261112143140.1395197-1-anthony.pighin@nokia.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
