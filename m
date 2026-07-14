Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209C3F1ABB;
	Tue, 14 Jul 2026 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022459; cv=none; b=E84hQzSmmaWN9jI5F5l/fIM4z0qIbvNVCwL7jJysEq0O213od4Z5llMaobKBACnRYwm9h/tZFdiwG5+MaT/XulqPFKwqnJxLum4FQG4DtFc98/u9lcz27oVJi8y5A1CM0nkYu1INAe8x6/5IpBO5DzSr3UwdsK7uba6Vvp8LSuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022459; c=relaxed/simple;
	bh=t4XiP/IHs/MAWTmAJpg8U8XhqPVl/Di3JCGllCa8vzE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=s0rxQpGrKAAeAzjwpsFqi6UpEu8HG8pdReDURSe+hLEkAMfxBgaGSrfzxmbIry79nia0qP6AevUQYMzHPjLHjU+4Pakp9p2pz6ycM8BITLRjwICZ9N2BL/n6kwujlDUQi6y1OqCKbRTHiNJ7y5GaoO26qsj2l8rdpCnUNItSpiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0sXocaS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0sXocaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44AC1F000E9;
	Tue, 14 Jul 2026 09:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784022456;
	bh=3cRD5tp61vGr5S2DsLizm6q3lmn7Tl+FjuVbnFjpaWY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=V0sXocaSYQi1xJqIt1MJBdQzPhZD56BHBzx2m7Yw0YvJlKm/n/fHnWNSauFyKWV5z
	 zNzTWGK/iFFwE+3x1Ak1tagoeCjsnadtm9wSEkHbw90gj+TOltpVAtj9SXn43yKJmf
	 0n/67q79i+1sQA53I2SYp+edL/sjVAnbH56U6DPa4G9rAY6EusqDThdfaNYdZroMDE
	 lzwZ6EroTsbWJw6S+IjzuD0irNPcqh8slpr3mzTzFQ5oR47KkQ0VmF7KH9jsma9UOV
	 4A4d/TMUv9TB6ORGVL/BtfLzbJPS2jeOLBLIQFffPB2cUzJfzQFXluodTlVZNLTyu8
	 hVfMkzX/tHOLw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mm-hotfixes v2 2/4] x86/mm/pat: acquire mmap lock on
 page table free to avoid ptdump UAF
From: Lorenzo Stoakes <ljs@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Lorenzo Stoakes <ljs@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
In-Reply-To: <20260712165341.GAalPGldsKpBs5treJ@fat_crate.local>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <20260712-series-vmap-race-fix-v2-2-ad134cc3a12a@kernel.org>
 <20260712165341.GAalPGldsKpBs5treJ@fat_crate.local>
Date: Tue, 14 Jul 2026 10:47:20 +0100
Message-Id: <178402244099.69739.5281491459981359633.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=642; i=ljs@kernel.org;
 h=from:subject:message-id; bh=t4XiP/IHs/MAWTmAJpg8U8XhqPVl/Di3JCGllCa8vzE=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLCWFcta9IJr9ALSwlJ11PfNz119ZLQC4ssPNa9fy9c8
 53xZt7HjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEwkkoeRoeedzY2VCb/y5dql
 I87/W3A80feA/QmBunpebqWfO4IZyxj+J/eLv1gpe2b6b+2PijPuX0mbW1f4l+297Me6f7PDA9j
 CGAE=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

On 2026-07-12 09:53 -0700, Borislav Petkov wrote:
> On Sun, Jul 12, 2026 at 11:42:25AM +0100, Lorenzo Stoakes wrote:
> > This patch resolves the issue by acquiring the mmap read lock on init_mm to
>
> s/This patch resolves/Resolve/
>
> > provide mutual exclusion against ptdump, which acquires the init_mm write
> > lock.
>
> ...
>
> > We also include cleanup.h in order to use a scoped_guard() to implement
> > this cleanly.
>
> You don't need to explain that.
>
> Thx.

OK will reword on respin.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

Thanks, Lorenzo

