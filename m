Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794719255;
	b=snyGBraOQEreXWfj3z2FQTQlMZyGBKZ4iE3KLbyqiuaCpzYDmdl3Zf+p+vB1dwOvOijZ
	 VN5isnZ112BuCj1PVt0LVbVaKxkyQYWdy3Oc+Jy54t3TIFDVZjTNtaTzVirA72Rm9ed/a
	 cPgWZy2o5E8buJjzICNdQE14eY+uz3vdwECCE3XFl7qgbzHSn5lRr6UahfVDm1OeKbeyg
	 +nnT64Ip4MabO6CllJmc7GmD2fZZXHyX14j0EbIxVdKJgqJykQylhaHu46NBDirpnkrxt
	 RKvaXn59Kppx5y6y07IX7sB56TIZsovtxT9+BnE2PbOo838VWc7uMks4O6hbz3vuVgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794719255;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ikScGg7wBKTFsbJ/gDhTQR58vzTQcrwVNkVKkfOyHeQ=;
	b=d4qX7KbUmnVf2t8fekFk9TMrjEqHneHkjaGX5bY8XbbjHd1uLXQKsvrstpFnbgzlF5h0
	 vWYR6xK3jDqljeUvAXtsCVmBnA+LGTgImc5lFf33cJ8QBshd+nNVBoAKJqGaTC6CcKYtW
	 QFxwHHqrSghPWAVpLphQW1Kh4f25cIGBO+sy7Quzei7W4VpGuewgI6lEd6iGaG/D6aNau
	 O2oxQL+P/sX2FCNQHVoGTGDJAhFoqZjIhabc6mvbb2qmgFx80Ax2HVw0V7xv2N4OhAuK8
	 5k469tGqGCjNuTDGQ+aUmao3jZhGEp7oyyUIl1w68+n2Y299t5P/IBUbZ22JabiwkbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gv182j1S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2449F606A323;
	Sun, 15 Nov 2026 05:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gv182j1S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5511F000C4;
	Sun, 15 Nov 2026 05:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794719254;
	bh=ikScGg7wBKTFsbJ/gDhTQR58vzTQcrwVNkVKkfOyHeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gv182j1SrsNW+vBDS+pykRsj8qYVG8aIuI90aGACVYsIszE1iQUPEVUMkp5txwyUF
	 T3K8o0/CUQtG/DAvzx1pVQJOuSP1W3t2fzF/Pr95ULXXWbl57C97Hh9JV01ZdWeEG1
	 Jc6DaZX2+JXCl8A41UzeRNTEFbr8pDeSM4YOwSLCFnGjdiR7dnEhp/QqCPK2wc+roG
	 GvnEu/fNdibLdCbbyLZe746MZJ9fENN3crBFZ5d6tNuaAP4UhLPJuhxncMc99SAZm2
	 p/bGLGIB/+YEtGq9EZeR4puJ3Avey3S/UjeIcjKHn6+xYn9vyMITYScAdziPbPPYYr
	 h4e51aFjHSCGA==
Date: Sat, 14 Nov 2026 22:07:30 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] x86/build: Do not allow X86_NATIVE_CPU to be enabled on
 non-x86_64 hosts
Message-ID: <20261115050730.GB600738@ax162>
References: <20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org>
 <20261114202524.GBavjDtC9Z3j7PrV3Y@fat_crate.local>
 <20261114204605.GA173332@ax162>
 <20261114205806.GCavjLXgsKNNwK0zLz@fat_crate.local>
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
In-Reply-To: <20261114205806.GCavjLXgsKNNwK0zLz@fat_crate.local>

On Sat, Nov 14, 2026 at 12:58:06PM -0800, Borislav Petkov wrote:
> On Sat, Nov 14, 2026 at 01:46:05PM -0700, Nathan Chancellor wrote:
> > No other architectures provide an option to turn on '-march=native' like
> > x86 does. It all lives within arch/x86, so I would just be adding a
> > check to arch/x86/Makefile instead of arch/x86/Kconfig.cpu. Making the
> > option unselectable seems like a better option. If other architectures
> > did want to add this option, I agree generically abstacting this check
> > would be reasonable.
> 
> Are you going to move it somewhere generic when other arches decide all of
> a sudden they love the native thing?

Yes, as I would expect another architecture implementing this to
abstract the current x86 support out and adjust that check in the
process but I can't guarantee that. I can only go off of what is
currently in the tree.

> (If it were me, I'd simply whack that native thing. It is such a waste of
> energy).

Another option short of adding this test or killing it entirely would be
depending on !COMPILE_TEST, as I only noticed this because
CONFIG_X86_NATIVE_CPU gets enabled for allmodconfig.

-- 
Cheers,
Nathan
