Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437814;
	b=KLnS7nZBEmSJrY0rQ/17MCIhUPmlUfTYnVwlV8B9NUL9rnfbiFM+mot9FAnDX0SytwcB
	 xXxLUaDI4srz334/5vXpSF+zvn9GVOoschTbRm/A61zmej8SA4BSZiSqHyyQ3yb3OAGZh
	 +4NWiWX6KBkGdYazFL4dASyIo6F6f8KxEX4Hd3zoaScybpeMo9J28TWrFf1bsEhPXbYuV
	 JYwbdEKluFy/PRIZHZ7i3BE/77Ff0Wm1Q1GNq1rgZsct9jJtNlK9cekGHJ9N83U3E8zhL
	 6q0GKn5vt5LgMNOhPj0u3DvFJ6T6GIZwiLOxvgsaWztTpKiZq9gB6KYM/JZlMeutHdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437814;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Syyh9as21Eq1SGsHwieN5MqC5jTlcLjU/4/08M/9bU4=;
	b=PbSSdU5+9xfb/nvq+3RGI7qrsIb2A1n+S1nci9EpPcGsPTkhxa9Dxw6y+/AGO4EEs7Xi
	 /923e0YtLE0cwfOdg7R/ehTqCLHcwHkwoeNvJXdwtnVLpsiP331mW5s5dH4p8xHMRL6Bw
	 vsVPFAhRFbTbmvZ0OW2Xn2X36lCsJ9sw07DhAUsuBvJ4QYwGJslmsXxzua+S4iXq8KXEt
	 /hagQsmdCVgCNl47wZrfychroBS6UJj3AP5C9DBQujeFbdepVOKwNFNHW99+vAvIOM2XW
	 0gEuQ94ppkwLuiVspIZV8OPIgH3F3ETZGWMPCkdpfTId1U4Oh0nznh5/uVkVwoo1gtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QgRRD7Rg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28735606A326;
	Mon, 19 Oct 2026 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QgRRD7Rg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D3D1F000C4;
	Mon, 19 Oct 2026 19:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792437813;
	bh=Syyh9as21Eq1SGsHwieN5MqC5jTlcLjU/4/08M/9bU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QgRRD7Rg+wnRcwhnQlvBnqZDd/ZJNA3MnrFxqnD2Doh7dkfunNI4w7uUaW5ZjZt18
	 B2w3Ovhq76e1oiSDVdKBmkdbM4omsU0RYY+SU1ccSwIbFoqTzgb3IkNyXJIK+Vjs2E
	 CFxCOlLQ/TBnlbKgVyDPz9yI82pOod5JZtn0CkK1H6f6Nu1n1uHj9bFMhekC+uCoH9
	 v6g0k/MCdB3ScZz/YgqLxxiOwiqTKs5IPit2MES7rFfsxoDysJHu7sYBatNdC9qSwk
	 wTmo+dR/fK9098pxjEUlHzIjaruEbVdZK9qS2mzqjtd1kjJKcd8Dmlo36cwpWPj11r
	 K/6AYmMf74g/g==
Date: Mon, 19 Oct 2026 12:23:32 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@osdl.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] KEYS: Prevent overflow of user->{qnkeys,qnbytes}
 in key_alloc()
Message-ID: <20261019192332.GC65095@quark>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-4-jarkko@kernel.org>
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
In-Reply-To: <20261019181732.449591-4-jarkko@kernel.org>

On Mon, Oct 19, 2026 at 09:17:23PM +0300, Jarkko Sakkinen wrote:
> Add the missing overflow checks for user->qnkeys and user->qnbytes
> in order keep calculations within INT_MAX range, which is the
> absolute maximum quota.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Don't keyctl_chown_key() and key_payload_reserve() need similar fixes?

- Eric
