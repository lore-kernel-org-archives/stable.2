Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239640;
	b=WgZk6BpcZ0WvIyJUKBB5rpSiiG+BfgRLmbESkpSES9NgObWN8AmwF3SZr4jLvLRMODp0
	 Qn1gQG2PlE2esOCNwFE7Ctcaxa3iis+5QNKvwP/q+ar8ayFdhNNbiFCvGWuJdqXjPG9hr
	 JvJDj0ZC0VU4w4kR5oVSa+O3vjoXpKWIydflsKOBwVm3FQi0VjItkbD7rLyOop425I0ym
	 iHw4pghc+fWNwAHKaaiYTmNVw/I9d1WwH0277TWJQXO8kJCWd1c0HUo5Ex9iD2hhAHAzL
	 DVqK63qc39FDIeEEexR6PEy8WP47RUIkj2VKueyx82Sx2BW8vvSs5wt6Cd6miOfvMOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239640;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0LnNwAD/b+R7UPR0vyg50Bf+1zPICUQngT+lH0edTGE=;
	b=iHzOqfbGjkoa480MV4YkzKgekQFPxPLNDgSejXNdNzu52zc6ux87WIXa4WeGGuIYVMin
	 Z6CykfN8NjNl3lTYx+7Mh7m04RYZgBqyXxulNpQ9yNYfICfGB7v+l3qYIFIsn/+td2lzv
	 DUBawWIIhwQ3ds49MFpq9eWEm/9ScDapQ7z5MHyFDjgHrdHJBhOz0I+voIsEca1WZuUIN
	 qhP1LBw2R3aVcIzUgADMoDXHDIXzWpWHyDcBlr2M5TAR7IklEaa/N24oZOhL1v3HwidOl
	 tCkzBHghaRhIl5do3PELCeEidpb59lh0ibNwk0CHcK9Sr36abXrsc8zuA4RmkLmSB+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUL8jbly;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9CB606A32A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUL8jbly
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E8C1F008A2;
	Mon,  9 Nov 2026 15:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239640;
	bh=0LnNwAD/b+R7UPR0vyg50Bf+1zPICUQngT+lH0edTGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dUL8jbly924W8D9k7oAU0SPxzzgpk7AZu4+uBm3H5IdPd/6BtYKjR+9jc24FlFr1W
	 vIJeHFyns6cDoQt91SI9+hkV/Rlk9hQOQGxnazBKoS5JIwS23iA9kxYrVHOiajcu39
	 94n7p1BJsemDNDKeOWg/SJKL7/M5uqnklxT8xdZrPVa37ulhxsFMzZ5qIvq/KMj7k1
	 XUUmH0AzMBv5usymFgsT2zHSVZdg/ukFuTJ2GjjuGQMcQdyf4mAl0KPd0LAoZxIeLQ
	 YOiL9j/s5dX4ns4GU1BeB6+/trGxT6j0dyvK6fdWWTB93qFrETag0XJmzzvqR8IKh9
	 A3rq/qZRZZI/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ard Biesheuvel <ardb+git@google.com>
Subject: Re: [PATCH -stable] efi/libstub: arm64: Don't use the platform register x18
Date: Mon,  9 Nov 2026 10:53:15 -0500
Message-ID: <2026-11-09-1-daily-reply-0033-efi-x18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109122129.1396402-2-ardb+git@google.com>
References: <20261109122129.1396402-2-ardb+git@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> efi/libstub: arm64: Don't use the platform register x18

Queued for 6.12 and 6.6, thanks.

-- 
Thanks,
Sasha
