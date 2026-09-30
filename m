Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68809503BF6
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778279; cv=pass; b=CrwPYaeJEOECIVQlo+9DIow+oy++ejmhno30x8NwgOQbXKopCPdt2KklIRSOXW3QgdBBWmhXp/XSvKLQqbFPNltRDEtjINTzE5JYwU51DS5gKg6pL9sP/qaIjDz/Ebv9QJj9LO2obcJfS22baY4hCzBCleMBAvWORErCFNLuRIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778279; c=relaxed/simple;
	bh=9AcG3Bf/TJyVMvU8LCLEiBB8yyyCf0GJT1IqMscVjJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJXdnTrhi5rMrokdb6d1KJq4GjhjXBSH/9It/KxftMWwnCv/8VnDausDF6LLMhtog33X8Bd9oQkr3tGGe9uWYmHmQE7ImTB8Kq+69CKHQQNAsUf/Xc8mh7+UfJ1dy9etwfh+YTJWrHkHQLyaZkQFAKUiTiZMmcYa/ZaeRUhGQiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sk4kxMWO; arc=pass smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sk4kxMWO"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-14b1b157591so60288c88.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790778261; cv=none;
        d=google.com; s=arc-20260327;
        b=QwRJSkUgV3lD5+90c1j54tvFIHVLQdQuj6c9oU0kjaAIsnuSzvPcqQr1SDLpqYyMA6
         RqndVxvg3K6Ull4rM2VoMgDrXMNID3mdbqM/OiEbyidHnF/YiAAz1cF7nN3Ly55LHLkm
         gVdTpU19NObTCGSJDKOUgCqmUW24g1uAD3aOgb6+R16RAYrih85FlIp7FPDXDia8FnAn
         ArwVaxIrtKrPrViNG4yh5gNCUHMdgvM/+xirkjfYgYizxXj+byeVosTBHEDekD+YU4iE
         Lw47rU3TxjxJtcI5Rih65Ohc3Pzrr5ewbFgrgQ/BLFKCP85CwqAGwBPsP6uqogTQfOJ9
         5Tcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9AcG3Bf/TJyVMvU8LCLEiBB8yyyCf0GJT1IqMscVjJ4=;
        fh=2KZhcY4ecY7dQFZs4r9w77m67jGzMmjuev805E2Egxo=;
        b=Vn3wHj7RgEvQY1ps9bZuqGCJXFPjfNFYgz+P5bQbTp4Q3pLCSUTx6jCI/lqg4l/jTt
         Lv/azNtX8VYexTTk4l3+kxJsZ2CWgDoxK8vTSlZ/OeIcqwJ4aDjDvuxbqVRc1km+t+Ud
         0rPAezwiW4BhyHcNWdFcv+3m4f0Qt0VcpeiQ2aO2pLZp/9IrrSqQNV2pw3mMGmKBAqmS
         C84x8fjyoCWnxbB93Aijw1hyE8xi7HTzNbL8glvSzypA2uBBOU6v8X+1GENxaZx96IKG
         jr/lFrE7TG3WoOchsYG/uy71IOYq9elbDt71U4YJt9uWKha+bTeT3dSb5qvfF/4iCqst
         Wvyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790778261; x=1791383061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9AcG3Bf/TJyVMvU8LCLEiBB8yyyCf0GJT1IqMscVjJ4=;
        b=sk4kxMWOVVnaTOFZf432GocoRBL677Xxam0UzbCB/QPuPLbkh+zM0j3MLH015uOyMc
         OMjeCYJOSJfM8k2NViemZBwjfB3j5Km5eXtm3B2sRIIFpntQvamJY2tNRjFeYwelz99n
         E8x49WNiblIR+vreI5TqBqXmNQ7HZ47ln8wYE4emKxG9hgFm1coZajsPDrq6UFz3ohSm
         jdYAtzXI3WAMpajTg0JuFVmNv3TXD2sa+SED98irgGnMdf6Le4bW26NkY5wMqERrKXTP
         I3CijC3Ebn/w6GMmcHnmOeHceDHCheEzyRO8eigs48GoQY8GYw1TNraN5KpI+dAYcbaZ
         TpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790778261; x=1791383061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9AcG3Bf/TJyVMvU8LCLEiBB8yyyCf0GJT1IqMscVjJ4=;
        b=j2OD7bdy055saiEAMXIc/srsHpg9nBayLMMqH7IFTC7cjzz1T38VQgyVDmn2K22PMW
         EhLFKErkX6XaMy/9NDBrv1RioQ1Eu5ivUOZ3YtMIZp8P/D2NM/fdU1k+lKEPrCiblnlR
         gmULJ3uEP15d0hRPH8uzSZf9sGGsi7JPbr8rYFPggkT4q2zRVIuq8CWuc4M4+ysZfhHB
         vugG5auJODCjz0NC4QNaUgea/2nCXRheGMbjwSHjcEheGgDqRXRKd2auMlKl7ezg75ZP
         IO12mUanrIf5WxZxSmoL9wRRaJkWYbNbZfqOq8G+WvPyy6UKDNGjgKlr30rHYEiQgAZZ
         SZTg==
X-Forwarded-Encrypted: i=1; AKwUvBzfwIzcMUcVmnduxHomdaK+mMlruIR/kls8PnKogzx5IkqefKXdt+ZTmUZf0+eYw05GeTEuv3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaNEcHSaFDt4cNq9SYEPCq9QkGK5rrqBVZeswoTEh47Cx3yhCk
	CY3zrsS+DmS9hDZjG9qZ1vZJWRmYePLkDMD0Z3cD96WvUs9Btycnqg66IHv8rNDacQfQiaEVKUS
	6OEAK2/j29ZcTx470nDTnP1qT71lxD8EQqN15
X-Gm-Gg: AYBFou0MkRFTEpOoQnUKaNfcKl0znhdVU0EdT5RQl4TU72d7119JawfR45BOqYY+SMu
	S24BX8kvZ7GUCLsS9XheuYshpRMSdO71+2RPXQoLwQPYHNlhVvDPDtF/zqx45iLf4r2jGig6rtt
	LMEpESloI3+ZLQAje5wXa8okNW4Vi00CaPMM+eMJ7/7B82KnpqvcAld57pcj+4AxrstDh7l3Jjn
	89p/RsUUCeItcHfKHfeTxfnxFnO1il64TlvdbI8B9h+oImgfbH2PQ0GhsbkwhIwZzmUkCDUwANe
	VBmu+cl7t45tp/rlsoGMIC/PuDBqy+5U3BuNHhQ4FFpxWpnJeU1TdDUyYZaNebaqNc0IDamxRiO
	FHf73eKEgyeYSrCxVgpIhJME+CZdKv5CynRocVEhIv6/vwp2A7VVSOQyTCs+1cnunmxP9oMY6UL
	UKzq4AUmg7tzUOlJMOW0g2JY3U1E8oliUZ99FvSfeDOxZyRT9A3Do=
X-Received: by 2002:a05:7301:7309:b0:33e:6714:3945 with SMTP id
 5a478bee46e88-34cdeb6be9cmr2983232eec.2.1790778261266; Wed, 30 Sep 2026
 07:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930123645.302318-1-ojeda@kernel.org>
In-Reply-To: <20260930123645.302318-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Sep 2026 16:24:08 +0200
X-Gm-Features: AclHuK8GB95XWuO8LKxnbuc-rexw5qTBlkNwTjmQZMYAdkZPzMK378NIg3-sfCs
Message-ID: <CANiq72=kA67u9vmvAALL8ibWEX4AnvkWB9ncj2Kce8DtxVpW4A@mail.gmail.com>
Subject: Re: [PATCH] rust: bindings: fix VM_MAYSHARE blocklist entry
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:37=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Commit 2b6a3f061f11 ("mm: declare VMA flags by bit") added constant helpe=
rs
> for the VMA flags and blocklist entries to suppress their direct bindings=
.
> However, it listed VM_MAYEXEC twice and omitted VM_MAYSHARE.
>
> Thus fix it.
>
> Fixes: 2b6a3f061f11 ("mm: declare VMA flags by bit")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` to go next to the other one where I noticed it.
Thanks everyone!

Cheers,
Miguel
