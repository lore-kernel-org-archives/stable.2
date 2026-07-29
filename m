Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6735292A;
	Wed, 29 Jul 2026 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307437; cv=none; b=HzWaXcAB22qJTKwqYXW2pHNjD8xuqzP4Sr5rePY6FEDakXuPx+ef2twStPyYoX0yBP2ozT9X0KdytWS5/Nax4xtRJWl2NsfJ8YFD6s21wRH5Hp/h4E3m2NFEtVtDonFhwRqHKXgBmFOGcPrfQWojGIyRDYqRsAsZ4f9VacQJr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307437; c=relaxed/simple;
	bh=zGQZ4woC9hgUS/fQQXjb3VOzxOMY06ya3rkOg+u5XjA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OKqqfcua2AkXz3wDLt/XpycEp2DdQwl2o+7elDYcONwRSiL3F5Ef9NdGXR2IrkQH3VpohEJZwE+jz1h1yBzuPf7QXKd1zN0yobLqg9tmxabCxwbQPokOvayytBYEdy9znkeXL9nvluLeDVkNZ6dC6crAJ+nDpRdmwxhDnbPmUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvlQRu25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvlQRu25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF831F000E9;
	Wed, 29 Jul 2026 06:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785307436;
	bh=caqnS6e4kiY3oUkt/HJWfEnD/2y5AMUZ+1hzT/P5Cy4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dvlQRu25NfTiF+5Ce8PRfJhxILSry53XqUXJ6ZP8ClrUQfOGtUFRdtGBLfkVubWfk
	 J/M+UDqVFOPPyrh1Pz2wZTwRpK/UxiKeNMAjkLOE6v3Gxtc7hd4Xc0aHq+qrdJpJZx
	 bAUirRJO5TTbeiE1C4429EyLrJ+QDiVHtfmMV7d4LELX72McLgOFbgV8KIeoYTtDkf
	 me/XZz4oyu4OO4/07X6qzonX+rBQg8H38JOatio7+Id9QfeercNt/kYelqV+0YtAgO
	 rcEjucc6Kq7sdJ7FW1aTUx5ZS77Yyd7yZPlRzhZ8q3dit23oB0Pp3mu6JII93WZRNa
	 xw90Lr0iSJLEw==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260727150240.889555-1-pratyush@kernel.org>
References: <20260727150240.889555-1-pratyush@kernel.org>
Subject: Re: [PATCH] kho: fix size calculation in
 kho_preserved_memory_reserve()
Message-Id: <178530738771.1195472.13332239668735060040.b4-ty@b4>
Date: Wed, 29 Jul 2026 09:43:07 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev

On Mon, 27 Jul 2026 17:02:39 +0200, Pratyush Yadav wrote:
> kho: fix size calculation in kho_preserved_memory_reserve()

Applied to fixes branch of liveupdate/linux.git tree, thanks!

[1/1] kho: fix size calculation in kho_preserved_memory_reserve()
      commit: 3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: fixes

--
Sincerely yours,
Mike.


