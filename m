Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E486D181334
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924822; cv=pass; b=bIwSkVUyErd2ejRjLT/uqrbMHxwYfYGXNfF8UQmjZQWo6mrFuzyJcR9VeNORoabzYA7VQR44NnftdXizte4B+fpjtHGhZ6iB2Jcg1IeytPKqc5L+Pjbtb/Jm7y173uaVrzALVMF7U1bY8eRz2OtwXMKCE3wFYFY5LreQZ+nHmZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924822; c=relaxed/simple;
	bh=pi+Udzy+By3sZoElReOh3poO8JLX+wgGZCDTOhVncSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0TzXJ0wFdC01EPiTgKafHj4Eadx85Hbbetw5kf/3Ndswl/87HW55BrvPcp1IkmyD0gMZWCf1WHBB0pg2AQBEEh2WbilmCdXFPmRcqdi3PSLYpBOiOhgtHyUa6ZWrbIlmP61QlfRm9IcrnxPqdcuo69BTrdstOOl9EQFuZEpCJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+XIfWl6; arc=pass smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+XIfWl6"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14c96a4b7c7so517121c88.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 00:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790924820; cv=none;
        d=google.com; s=arc-20260327;
        b=NpJnD8+pqWVwxCV0cn7jZudJtayu//ea7ifR9QSf/8dlIEv29VPce/4alYVq+EFyEV
         ds7PTxCFgPaN6pzPvtXmf5OtrYGCE6ZtQAPwAe6dwioIGlqzN+PKiA+oFNyK+Io6WzCE
         2oBknyNiT0pfu6VJu4A7mJriziVEsskSKIppAFxsXofT+zD8U50i9KhZFZXLYZQXicX7
         b8d1rE1V8Y+2EEKln5f/hOI0ELUKKRRg0WD5YUtiT7AcdfJGP6+5DqEkHCD9YZh0T5T4
         sYbZdpD5jUoISxGnt19VXJRZGZaYaZb7MgrTKz+IWDP4j3Th6gO5o17EpJhvSvXBYxWK
         nSNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pi+Udzy+By3sZoElReOh3poO8JLX+wgGZCDTOhVncSw=;
        fh=pyJrYH+aAM7l820OqgwesZNkmxsXXulz3QU15h6EycU=;
        b=BmxH4viwhMW8q/XybYThflI1f/mXWOk8V0CvbtnP+KQRymThRtf7BPqxrFpTZRmeAs
         IC+Z+i6afqr4Jp30EyDa9TDn+xed5ZTDB94qkJNnMt2a+rcYAZa+CIn+gVrxz2S9E0W/
         ZmXekfdN+L7oaoy9Pap1db7G9D3W7lj0WnUsNYzw75uQZnQpwSzFYd2q9zA2qzBs1eHI
         jtFbafKY8jk3Axb5gW8rjFCZrEehXBavEJVLV/3A7l8eUf64eCtdokVdHXyo+Om1raUZ
         iK7f00RkA4hQugTuOOoKDhgxfOdOkcGPridf/crUU54b0Prv/mTvJ3Ly8GxZ3Vk6Q1rT
         j33g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790924820; x=1791529620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pi+Udzy+By3sZoElReOh3poO8JLX+wgGZCDTOhVncSw=;
        b=p+XIfWl6LbHMie/BHkCHdP2ema89ERjaTV4fCpLKy6YZn7cvKyla1DJgQtJqYRlNtu
         oj62bYE0NIdp6ehQf3Ny/G5UYEH49WYstCoysZRlaXpB84cY5SlqEAC7whxpSZptWYSZ
         a2Cy1V5tVv9GYTWuM4lPpslqra4a465H1LJoqLUiloe9G54c0JN0ZwuUUUlnsCOcGvTH
         No74/j2D4xngRQNG7o85UVb/1tY/bKIFwtrLXWtZAWhdIFpxB9Oe8r/dQf9+Wr1n3414
         bTibqUSHk8OeVL/lkRdbY+oF+kXlnmT/jXz3jMhkvwqy1ZpBLUSVRftD6mHnbgCUW2Rj
         xxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790924820; x=1791529620;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pi+Udzy+By3sZoElReOh3poO8JLX+wgGZCDTOhVncSw=;
        b=2r24SARsZ9NfRNfT1A//40yjMoVcMXexN+/fI6F7WuKkYJHp4+ff88RJ0MS6mwhzjG
         7S9T0EyW1gDwl+jr5KDulwBKbZfBuw51Cal/t2om0aFZfoYLmPq+LVuv6ICoUWiHAoxL
         jwUExu3C/df6DLa2CO3PueQ0uIXzmCsn5Y3ZexI4vS+ez2xMjoUaMOA7j8bhZkfo5xgG
         pgbY5QBrtlB2TVK084YAe+zlUsj+dxd0sPcn43iDUHu50gO0DG7xXWA+xMRG9SV3LdC0
         gkN+5lA/3FVl8wurFTnqhqVXX4J1OiuixF+45NznZg7FQeoCxw4JYMelZJ89DtIpnXNL
         eB4g==
X-Forwarded-Encrypted: i=1; AKwUvBxdBYJ/Rw3sm9V/B+tCsfa0gS3DKXr9w6rZEnXwJoYvMY/nfybVj/cgtdZPAWGykN+6wiGOgaM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwTbK+V2aKDrgNueVeAFTFqfDuDQ+ldZSboa61ui0vHGvgXc0o
	rawZSCVMQCwFxI3Ldwhg0PZVA9nxiMmK+66+pwCM8vIVyfwPDk4L/CPHgjv3qO0OOAGSvxYW4fb
	luuMKCYyhi4Wz4MnAncX0tU65OWqqIac=
X-Gm-Gg: AYBFou1SI8bp5qZHCpJi4aaSt8ENvh21cy2lF/o4KM23SCyAlLMcQ0wZ9gWW0o+ObFG
	AoynjFmOxg8eBqpROhsdEehcBb/FcSS+McefcgzaGzT4FefO+3eJWcsIkvro1yb4qP4IDQ6oUoU
	BGVmQ9tVTp++7/r3FCIDvedQT1LDeNMc2FYVcByYmxNgTHQvNwzFbDEc9b7mW3GVJN8qwD9w1cv
	u3epyeuF+ro9raBPDwjz2Mqll4yzCtT10GvGW3W7+mVtzN7Lb9hkP+dCtX2rS7EVfrz4CutJBaG
	gBo63LeHahd/vrSVNuJeSSBcv5wxPzPh6ZB49GYb6efmg1kK+6nsTIaBW2CmssD5AAKriq+CMDY
	PJ1fJTUmJ2YPhHNI0yzGd0C8zVfnNbW4BPJSI+x14dyaky0C2n4mnH0pYjHBNqeVm9+pNYDkT4E
	1PIc3okaJDsyUXsRJLcphCcp9feQ1J8OqXp5EBARpwOpupag7f7PuNR5/6hBf0hQ==
X-Received: by 2002:a05:7300:4f1c:b0:34b:101f:cdaf with SMTP id
 5a478bee46e88-34f1501d239mr2860107eec.1.1790924819859; Fri, 02 Oct 2026
 00:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001123103.2198104-1-tomo@flapping.org>
In-Reply-To: <20261001123103.2198104-1-tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Oct 2026 09:06:47 +0200
X-Gm-Features: AclHuK9aq6CWZxEjLyQFN3qCeoottkqFWF4dz3y4arkdWfxJVGxahHmXpJ6rMsY
Message-ID: <CANiq72menqxT-7Wv559u+=JQAxvucBTubs62=eN_CHCj7wtEzA@mail.gmail.com>
Subject: Re: [PATCH v1] rust: bug: pass TAINT_WARN to warn_slowpath_fmt() on UML
To: FUJITA Tomonori <tomo@flapping.org>
Cc: ojeda@kernel.org, a.hindborg@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	dakr@kernel.org, daniel.almeida@collabora.com, gary@garyguo.net, 
	lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev, 
	rust-for-linux@vger.kernel.org, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	linux-um@lists.infradead.org, david@davidgow.net, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 2:31=E2=80=AFPM FUJITA Tomonori <tomo@flapping.org> =
wrote:
>
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> On UML, `warn_flags!` calls `warn_slowpath_fmt()` directly. Its third
> argument is a taint number, but `warn_on!` passes its bug flags there.
>
> As a result, `add_taint()` gets 2304 instead of 9 (`TAINT_WARN`). The
> warning is not recorded: `/proc/sys/kernel/tainted` stays 0 after
> `warn_on!` fires, where it should be 512. It also causes an
> out-of-bounds write in `add_taint()`.
>
> Pass `TAINT_WARN` directly, as C does on UML.
>
> Cc: stable@vger.kernel.org
> Fixes: dff64b072708 ("rust: Add warn_on macro")
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Applied to `rust-next` -- thanks!

We should update the `// SAFETY: It is always safe to call
`warn_slowpath_fmt() ...` comment to cover everything that may go
wrong (like it did).

Cheers,
Miguel
