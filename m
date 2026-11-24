Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795486534;
	b=j72c07jFWyO8xB1WLf2tZqV8uUhJ24Tsib6NI36ANTvpT7u6rL9IltyL38zjgGdDfA2y
	 j0RtBvON3hcuUnKmWgKm5+yKI/NWI3RQhMaLPiylScy5PaflchjAUMOprjLqiDNm6/usZ
	 h3q0o/LRSaH+WKYoxJPrFWzBSIVZCZV4R32a6KErnG6GsA11x0GjKsuCvfei98+6jdM4O
	 jwb0KAG/Gl5qzgfAiT5B46mWHeAqhjS7QqstQG16+UQnKcLsQLgBP9tgYlA3cQpQZU47r
	 66CnxG/YJlVhz1AxMkW7b7IJPIRTd3JfhuB8WiTev20qihkDR3Xx5gXP2PaP0JX6pfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795486534;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uUs9GSPSgpK2xdpILx772ilrW07fhOJy+bZ7K9nnqYw=;
	b=drXPqV/1CrjbaTnk0LMY+efDLKqZ0zkmAlk6f6MeGkO6Ju4Rgtu4gouKnEXYaKDlPTip
	 AMXtOo5xwD3heY+ixL6E0O2CeOy7ISwlm1oLmHGHlhpp6/9IFYxLuD94NVHw9zLNGldwt
	 T6bLLxsPRr+xfsRYTwDu6sJjn/dN9QVKHmOI+DCiRLxtG0hRJFJJ5IGMe65ZNwTmy1Uf2
	 AdMkFevyWTkTYp3x99uNpCRUyPl3FRjDcnT76lAOhddwORM3NDcqS6oulAuzRysOLKqmm
	 y/2N8bwoBhvAxAsGQZJa/Axd/GHWLAEiSisv4bZBndUqUKc9dYN1YvhT7HICE+Ao/1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxfKsjya;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D4C606A321;
	Tue, 24 Nov 2026 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxfKsjya
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970651F000C0;
	Tue, 24 Nov 2026 02:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795486533;
	bh=uUs9GSPSgpK2xdpILx772ilrW07fhOJy+bZ7K9nnqYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bxfKsjyaGK4aKNzoI5HaOm34uiHXZzxo33ft3izLVeNPrI3/g3pUWN+hYPvpVWAXF
	 oq6GFS6FJi+LlSDQZuVcpZuyHBGdkQGoNXcviitsW8TTs4lRteyYiRfaMRSxcXOTft
	 TiGFJouM0AODBMCn5pPMWqpkOSh+4lRITJ14FWy4O/+H5yKuL9xn7hG3bYRGdkzy8x
	 92paAcjTCa22wMf9BCikleK5Dv2zmkqsahgpGtYN4ClvCCumlXjuoJygpfwBhmWnHu
	 6jyjrmLPsMWtiyXpCOwFIbpiS8FnTUyTtbMY7FqjClD5h7Qq8pIXyI1gKS/7o6RejM
	 WKoDVRlY2eijA==
Date: Mon, 23 Nov 2026 18:15:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>, Henry Martin
 <bsdhenrymartin@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nfc: llcp: walk the accept queue under the socket lock
Message-ID: <20261123181533.629f0389@kernel.org>
In-Reply-To: <CAL4Wiir7GS+-0tSH6D49f+xZv6njk+sbc-_E45_qnqgHe6V4TQ@mail.gmail.com>
References: <20261118083811.1721010-1-bsdhenrymartin@gmail.com>
	<CAL4Wiir7GS+-0tSH6D49f+xZv6njk+sbc-_E45_qnqgHe6V4TQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Nov 2026 12:05:01 +0100 Eric Dumazet wrote:
> Next time, please specify the target tree in the subject ([PATCH net]).

FWIW we don't take nfc patches directly. So [PATCH nfc] I guess
