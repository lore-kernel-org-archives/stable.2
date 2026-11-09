Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236766;
	b=GD4OqD1ufuGcdOv+CHQ5ijporb0yuyQpBLQpRmogZXNXZdLZWLCDlOwiSDQlIi1n/8wi
	 vs3n4d8Nn/FnFk4FBMCjV329jwhrnUh6sHcxEaY7LtwrULjOTZrylW0O/Ba1E7Hyvj640
	 cp/crMt4YiU6kP9g0vXo8QzZgKuV3d9Aae9ABIFWBtbqrqYAnRf5GFB/MIX+OERKlMKIh
	 HsdU/0SlKkTlV0GtAbcHARt4oT0ygZN+Jt/5RyFOsi0oa2A+/bnvm19By7178wOsPZpcX
	 ubKUhwVHEGwhTXohMZxZkI5yDXl82Cy5osHbm0ytzZByQ37NJgIJUXla6yszjsodheg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236766;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SBNR7S/KICTrvxoHmWt0a1setwZvkrCcd6mgVRAY6jY=;
	b=wx8QGLFXuKOj+VFF8pW9ScGmNA++GqbJJzRTeZ1zWuLwdcTPGFZ0i/yogUPnbrHUcdAQ
	 L1SqAEIWTtvIg1D6NImip+vvE7R37WvBy24FEn08uofZtAOj1NKNePawS7XG6UkK319Pb
	 QK9/gvoaSgiWGJ6qRUtYJuAY4cIebDUeNXkPRNG+flhPxi8ow3c1oM2n7E9rpRuwBX2NH
	 gEaAb8E8IE/KjFaENiIsOf/pn8MoZFiy5wUR3xymEyB3PJEI7UjC9ov/Q/tUu7+saN4v5
	 vAD2G3whnfmD7iJ2k40UcdaTOZ0mml/Rbtcs4w7UxcTtO6OcoMVRlUaGbn6ZI8Ylzwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RKzlacj/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 68086606A321;
	Mon,  9 Nov 2026 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RKzlacj/
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 63EBE1F0089F;
	Mon,  9 Nov 2026 15:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236765;
	bh=SBNR7S/KICTrvxoHmWt0a1setwZvkrCcd6mgVRAY6jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RKzlacj/m9VsfrPgnqX6wcqouiCwZykkrYWVcqVJGqQMEU/NnKcciQRlzu0wdwSet
	 BeM/IE74o+c/ZOSC5w15ZwXCVSrpOgbxKrMwbB9CsfQIkS+zAfgebzSPAkPhA85fD7
	 xswepqKyAPwRnrSZ3u6E7tnpsr1iwmRPfNKlB2WSJfvy7CH91NZkhqhPMVOkAjVCZR
	 wf36hCpe8H8mhZ97uuzEOJ7mhpNxqrdZnWZPs5sYj4TOfxvdjMUJyPzl7TyzNCf9Gh
	 R91kP/PVCTJWvjGYE5hmkzshtudBwA+2QU5dW8igLtbfFupT8R2X0l0Cl3IoKC8xp1
	 7ZdEuAGX9k3bQ==
Date: Mon, 9 Nov 2026 17:06:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yuansheng Yang <0xbeac@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6] KEYS: Protect pkey method checks against type removal
Message-ID: <avHhWgofZ4eG99Uj@kernel.org>
References: <avCZIMCsZ4um18e-@kernel.org>
 <20261109055204.31673-1-0xbeac@gmail.com>
 <avHhAv13pbc_hfoX@kernel.org>
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
In-Reply-To: <avHhAv13pbc_hfoX@kernel.org>

On Mon, Nov 09, 2026 at 05:04:38PM +0200, Jarkko Sakkinen wrote:
> Thank you!
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

And the bug fix is not without value because now I can rebase my own
patch set on top of codebase that is not as broken as it was. Zero
disregard on that side.

Br, Jarkko
