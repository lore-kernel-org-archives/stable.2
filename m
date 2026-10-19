Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438504;
	b=uz1lAuLfTA2JFKJnW67r+PGhnvhDDu9uFm3olyrXQHusOmZbbZrCUBVoihfMBe9yoFCp
	 k/pSaveshEtiWDEu6QxnCk09w5i7pTwkw3bhVTVRH2ym8gwolAvlzP1tazuFpNx2l33O3
	 wKYJ+flLqz9oSNv0AUiFQLKkiC1lwiJaZa79NTjPCVZBkfZVUoQsqF6QW9245nFXyAfhH
	 yvkDeQY54M1DYy0zZXygBoy2rAW8OkHr/4vdROs7Cm8VBkbcvkfNoggQ0ba8XQTpRsxPR
	 3/YxHvt0WSj2vxRjX2k1kZb7k1TcJL3wwYZHEJgMvrBabvaHcGb77LosennT+NO7ViA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438504;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6FDivqGbQ2m9S9GI11uVbE4gSmSgYlZcK4N36HyOXSQ=;
	b=knV7aw3tWfjTjVKuWr8Bu0VoMfmw30J/y+WhJmA4DnfAgd4G+6gYXZwKviubK0PsnllF
	 cP5LcxIUUDMCFD91cb2YXoh8A4lYCiCUffQRNWvftM0Z8dEa0SkwEzoguTRsbyjVEsg05
	 qhYILZ/2aebGKG/xOYFE50ZEYfLOw54oTp7aRuTjfToJAoaceaaIkiP10Y8umPzv0Ak1n
	 ieppNvYRdkFl5/BAJWPLECPKmU8/NjI2mnLjegkwM+YhQYAYUHr9ddUwOj6uCVX795Sce
	 FfOaB+h5Ux0Scbe6fF3Py8VRR7rZOBT5kddeVvtXvNv3z+9wK8hQ6wgEP6vhHzTsqvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z3h/7BmJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE41606A31B;
	Mon, 19 Oct 2026 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3h/7BmJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D386A1F000C4;
	Mon, 19 Oct 2026 19:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792438504;
	bh=6FDivqGbQ2m9S9GI11uVbE4gSmSgYlZcK4N36HyOXSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z3h/7BmJS1RrcbU9aAVifUeRE5MjTyhhuVlT6S5eQiKtPgt//Y41wQ43AzVIYNwru
	 C8m8u6pLfMAYxzbOIR0VSSl0RMG1RVFC/uENvW5RGuPcolKJ+8hGVY+s4KAfxHrZ9R
	 uhQSi8kxLJrSSVI2EzRuDhdOP2F5YqvME2NGxeT17URibgGDSpVF6wN1cO/rfBZpvB
	 +aNknq0/S7D7ibmCZmk77ck5B5wM5ygl1aP2FBBvTl0L8yo89rs+CAAhFoLKUcZCYk
	 Y2wtRQM0APLPvppYEcg/Gc9EGqfvK8+x0+CWP2CMHOnNxbv+7PL+0v9hS0K37GvTIg
	 3N62bJmcVfOIw==
Date: Mon, 19 Oct 2026 12:35:02 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] KEYS: Verify the key identity in __keyctl_unlink
Message-ID: <20261019193502.GF65095@quark>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-7-jarkko@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019181732.449591-7-jarkko@kernel.org>

On Mon, Oct 19, 2026 at 09:17:26PM +0300, Jarkko Sakkinen wrote:
> [PATCH v2 6/6] KEYS: Verify the key identity in __keyctl_unlink

There is no __keyctl_unlink.  Seems you mean __key_unlink_begin.

> Let's define the following preconditions:
> 
> - Two keys: A and B.
> - R is a keyring.
> - Both have the same type/description/domain.
> 
> Then:
> 
> 1. KEYCTL_LINK(A, R) => {A}
> 1. KEYCTL_LINK(B, R) => {B}
> 2. KEYCTL_UNLINK(A, R) => {}

Should be 1, 2, and 3?

> Instead, verify key tidentity before unlinking, and return -ENOENT on

tidentity => identity

Also should explicitly say what the bug is.

- Eric
