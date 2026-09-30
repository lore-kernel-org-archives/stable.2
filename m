Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC3470EB1;
	Wed, 30 Sep 2026 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758764; cv=none; b=mWn70tKOge1Ll+6/Ze7JoMaz4M20BXRBXHoJk46hhZUxibxQWkXXUo9sTVdzFZTXTwnVLldINxtlkIQD3hAHiXembx4Y6PnfmAgz3646g9Sx2S/TwUuia6qKFjMa+EDkeEDXoaeHGo5CrDdQMFc8LGTvhkjwK305Lz3htNg2VH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758764; c=relaxed/simple;
	bh=OmUHCkAs73ibvKmK1Abofc+q8MOtTzRwvp+yLwYwZZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DAigDKt4bxqhbQQ+s5aiHaHQ4KZWQNZ/QM7JaEXNt1y7KhfVGuNvKfByZ+ibdniWJEZQ5Ut+pItBZr89jkwwqT6CXEtSYemELxykZihPZCm6yzRDF/wsTkQgfm8RPPNnpfhEyiYFVfwJsvkOMVmFSWUOgXeMnAxdJhom0WujdCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runtimeverification.com; spf=pass smtp.mailfrom=runtimeverification.com; dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b=g8q4q8O5; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b="g8q4q8O5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=runtimeverification.com; s=protonmail; t=1790758749; x=1791017949;
	bh=bSeGWzfefGFoP0p1q+y8/AwoWuF0ZEokBDM2mII67sE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=g8q4q8O5YWTjXriMgVt/zbs7eIWF9LmCWE/dIN9eBAMsZw6RW3A79UMZszMchbZXV
	 EMaZ1gd/QalspPZm9k0DQNFjYUlAEtyk9kw73MUdTVRz4wXClyo2X5fj13IPsgJvHl
	 M93iB2CJEZtLEera0xKE6Ty5Kg7mO7/WVl8tGhgjk/6YKhqdCqOf1dG396P4g1j1bJ
	 gIX9R6vTmDYv5hVATVI+/2BsoGLPzbMKAExLSrIhnEuIQBuyxe9NZXeLn2uf+qMNy0
	 UehD/UaqRIWtQpN0q1GLdRIct9hviSBan97OyJ+5Pd27rsU5qUO2VDq7ncbrDoWpGF
	 yhoTDDUTLNaKg==
X-Pm-Submission-Id: 4hvpr76D3Fz2ScDC
From: Natasha Klaus <natalie.klaus@runtimeverification.com>
To: laurent.pinchart@ideasonboard.com
Cc: david.laight.linux@gmail.com,
	hansg@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	natalie.klaus@runtimeverification.com,
	noambs2999@gmail.com,
	ribalda@chromium.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] media: uvcvideo: Fix integer overflow in frame buffer size calculation
Date: Wed, 30 Sep 2026 11:58:44 +0300
Message-Id: <20260930085844.150633-1-natalie.klaus@runtimeverification.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928205331.GM4406@killaraus.ideasonboard.com>
References: <20260928205331.GM4406@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 28, 2026, Laurent Pinchart wrote:
> Is this patch missing an Assisted-by tag ?

Yes, and I should have disclosed it in v3. I used Claude Code for
this series:

- 1/3: Ricardo's design, from his diff on the list. Claude Code
  applied it, found it did not build (alts left unused) and wrote
  the dev_warn() text.
- 3/3: my design (skip rather than reject, inside the uncompressed
  branch, same approach as 81f3affa19d6). Claude Code wrote the code,
  I wrote the comment.
- Commit messages and notes: drafted by Claude Code from a list of
  required content I gave it, then edited by me. In 2/3 this covers
  my changes to Noam's text, not his original.
- Analysis: the call path analysis in my review mails and the zero
  size case behind 3/3 were found by Claude Code. I spot-checked
  them against the tree.

I reviewed and approved every change and built each commit. v4 will
carry Assisted-by on all three patches, say in 3/3 how the zero size
case was found, and describe the tool use in the cover letter.

The original patch in 2/3 is Noam's. I have asked him to answer for
his part.

> I also want to know what device this has been tested with.

No physical device. Only Noam's UVC gadget over dummy_hcd, details
in my reply on 1/3.

> > +		bufsize = DIV_ROUND_UP_ULL((u64)format->bpp * frame->wWidth *
> > +					   frame->wHeight, BITS_PER_BYTE);
>
> See the reply I just sent on v1.

Thanks for the numbers. If width * bpp is always a multiple of 8,
rounding up and truncating give the same result on any real device.
They differ only for descriptors that are already broken. I kept
DIV_ROUND_UP_ULL to match the FORCE_BPP path in uvc_parse_format().
I can go back to a plain shift if you prefer. Which one do you want
in v4?

Natasha
