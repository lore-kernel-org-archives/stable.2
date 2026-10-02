Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90647DD6E;
	Fri,  2 Oct 2026 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936987; cv=none; b=aoIo1k3+08mkpW1GP3H+cOX13t1kO8AUs4iNlJ+qQIqTgcPlrYGerOmZo1pSD3211G+LZhsyE0q1Txlv4ImQ3jOWWJakHxPbhgvChYimhkik/90UEjCrQRD2OIJfE9/bTS6CNS5e++oIReucNzSDxuE9qENpcq5ADNKXILVdVjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936987; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZuxw3F00u4VSwWG1AWBhzF1bKUwbRAV973GbzSgQZk2ZJI3dAqU9WBu68vYcLNfZ2ve9ALcLJs2yXfLU34BBg3Drj6PG2E5XxPprEfoiftJveG8b0yggcPu/r45VtRm2alpPIvuNimtkZceq5mf/ZxN1XyjwYgAGmu6AIcywK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx89kAHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx89kAHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D165C1F00893;
	Fri,  2 Oct 2026 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936986;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mx89kAHYOXUrkPtgi4Ej7cRU/Yd+coe/JBpFI08aJ1xFJTAXdqOfAn5oh/y4jvqEK
	 GjlS2X2SvA5AzVukDbw6aVVdNyuZg6Qu+JQlL9FoiFFen58scOsTKEbRaBgaO17llV
	 8ZM8f7oiVeYdg7jIMfYSt08IC1q5zdEuKKyHUe8phau2n9t9iA5YspQarzO+p4TE91
	 9SWQJ1+OTmT2VPOH18+A4uEo15HpeTNZPOAMgbHx+jsc7jqo3Vk2ZpG+fx2JSI9Ffx
	 Br1RfUncDt3AJjrHe+bmrAv+SzoaCkFOQVu1TF+cQc3XPPiapAeFkcfX5qEXiRh4RO
	 s3Gsxq0T1QNsg==
From: netdev-bot+sinfo@kernel.org
To: Bruno Produit <bruno.produit@trailofbits.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>, linux-kernel@vger.kernel.org,
 Dominik Czarnota <dominik.czarnota@trailofbits.com>,
 Sabrina Dubroca <sd@queasysnail.net>, stable@vger.kernel.org
Subject: 
 Re: [PATCH net v2] xfrm: espintcp: reserve partial message during allocation
Date: Fri, 02 Oct 2026 10:29:45 +0000
Message-ID: <179093698536.1402591.16703491801413392699@kernel.org>
In-Reply-To: <20261002102447.148835-1-bruno.produit@trailofbits.com>
References: <20261002102447.148835-1-bruno.produit@trailofbits.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
