Received: from e234-58.smtp-out.ap-northeast-1.amazonses.com (e234-58.smtp-out.ap-northeast-1.amazonses.com [23.251.234.58])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D82233958;
	Fri, 10 Jul 2026 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662753; cv=none; b=NaTYnuAKTcHNY6lMJBW2UXt+fy14h0jdST0EqwA4eB2Xrf6xVADH3pUZWBVy9wn6SlDl7+izlx40w7EM98B0AbY4f1wn78sGlUayZRaYkKo3tjR63HIYUIo8D5i4lraepZM7ZoYAI9bFaSJQz41JL+EJt8lmYrU+COrAj0rHi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662753; c=relaxed/simple;
	bh=vHaU2coOYNDoemaojTQSVEM0trILUAv0APHfkLpvG/Y=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=LLanNpY1IeT6pq/2gBvDsdPPZsbPl5c16A3J4+esbrhy13onvrtPXpAgMJb7GDwTU5m8OPBxh1HEXKC51aNTjgu/MLvYYz9QhiXflTZVq9PZhYeWEct1p15C0hFVKgplGbOaWeJPqRKVk91OK3EOSUQOX/xQqfVlu8xYcjvHfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=send.mgml.me; dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b=KgQcXfNM; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Y/nb+UXU; arc=none smtp.client-ip=23.251.234.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b="KgQcXfNM";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Y/nb+UXU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=mgml.me; t=1783662750;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=vHaU2coOYNDoemaojTQSVEM0trILUAv0APHfkLpvG/Y=;
	b=KgQcXfNMHrF4yqb6DBMKwzIP9PVeA8vg2FVe7h8C5q+i6k7SvcofdvgaZYNAmFEL
	aVEfv4jXFzF71CTx6HHB2tBvsiRt17SpkdfSKDcK1ongvu7wlOgVcnVLpMoTuxulVPH
	n8oJoInUmAJSXYEmiowWIj48qMT0WFltu2WJQggM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1783662750;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=vHaU2coOYNDoemaojTQSVEM0trILUAv0APHfkLpvG/Y=;
	b=Y/nb+UXU2TI/ufSNzZVJW9GBwEk4azx0bg6VPOto3RVQhnr4sW3+at3N2QvcuQU1
	NBskt9CTKIUz5Deve6qHYYgiQjL3HVKUgxwB2BgnctPl+PtUttiNiZepasOFJC+56mb
	GhNBeouPFP3gZblJr5CFSljcantoCfqqNyVcKvUY=
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <stable-reply-item009-kvm-515-20260627162226@kernel.org>
From: Kenta Akagi <k@mgml.me>
To: sashal@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and
 related issues
Message-ID: <0106019f4a95a94b-890f7204-aef4-451b-b01e-14aa58b7a554-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 05:52:30 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.SskAFE1oaJ7KCjyyJFCV37nkSRmUZttpeGoevLE2CszduPSq19CK0OWqrkMmPMemkYWmFvQfvS6+lCR9ETv8vDWvEFaQZtUQ69n4DuGGNbGH4U7i+CnKWCHWm/HpilUFxPcCpCRFiQTHPHnKlfimqanQj7AjyJ2y8XQuaQGs83Sl+MS5tJ/lS6+Uh2zwyhRo:1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2026.07.10-23.251.234.58

On 2026/06/28 1:35, Sasha Levin wrote:
> On Fri, 26 Jun 2026 19:46 +0200, =
Paolo Bonzini <pbonzini@redhat.com> wrote:
>> [PATCH 5.15.y v2 0/8] KVM: =
fixes for CVE-2026-46113 and related issues
>> Please apply this instead of=
 v1, due to a missing line in the last patch.
>=20
> Queued the v2 series =
for 5.15.

Hi Sasha,

It looks like 5.15.211 (released on July 4th) does =
not include this patch
series, and I don't see it in stable-queue/queue-5.=
15 either.

stable-queue$ rg -l "KVM: x86: Fix shadow paging use-after-free=
 due to unexpected role" | sort -V
releases/6.1.177/kvm-x86-fix-shadow-pagi=
ng-use-after-free-due-to-unex.patch
releases/6.6.144/kvm-x86-fix-shadow-pag=
ing-use-after-free-due-to-unex.patch
releases/6.12.95/kvm-x86-fix-shadow-pa=
ging-use-after-free-due-to-unex.patch
releases/6.18.=
38/kvm-x86-fix-shadow-paging-use-after-free-due-to-unex.patch
releases/7.1.3/kvm-x86-fix-shadow-paging-use-after-free-due-to-unex.patch

Could you please take a look?

Thanks,
Akagi

>=20
> --=20
> Thanks,
> Sasha
>=20
>=20

