Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856285;
	b=vmCFV/4h6sdt1WjFKQ3uRxDfS7trhmTsk/zkTpUG66YQROSgKOYVuDNewP0JbcDPqHdk
	 J+5FXql6qLKMVCVyGaN7EYoxCxSXIVGMhwlrql7vZ76bSYo3TJFPWWYqW7h9yZk8YSrgl
	 o/jZ9V8t3lV5/HH/hcBEPQpSx8Fnx/ScMOjkhmzGhH7UjcgURYCwbzueOgTwyMh74Gb/3
	 mFSxnvLNkqN9bYy/n/QgLfYQlqvgezIKFZq8Q4GFr0V8gmOuBJrVDxPSkN0K1tqsIjVs3
	 ipPiTD/QyySZr9TS7SwcXhy0/3IL+9SfFRVcgheOFkAY0o6birFCgqBV3BGZ3aXtFMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856285;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=l2y4MN7Q2AtsLMWjH9hP2piWATV0VLqCC4nNqGkTTHk=;
	b=mMdHFX6F1QHEBaxGyk9vctta1r5qHmtX/0PyGj4IVoqRHfCioeEaHP6d653DNtZCqEkd
	 f2q6wANBTUZyaHjBNejGxk0S8sooKsfIWFh7iQ5YgarZ+Sbvw344akfxj4Gei/aynYLTq
	 bibfoKuCzMn0KepdMF09D4lo5KDcGiNsTpplURZ2T+XmGgOZGhyoQIESomOJscx8UUUT0
	 chGhFd3cEy72nikwc08+73dPWP9/YCO+i/y/U6RdWBrNfKsaYZ7nlOweTstPgKHhvpsj0
	 5pN4vaf1WEnX1XSNmPE44ZPFTH1hD8tjauPs7/3invYlhKeDASUsrl2nIJ9eVgqGUSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZnPCR/Vm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94DA606A336;
	Mon, 16 Nov 2026 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnPCR/Vm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1AE1F000C6;
	Mon, 16 Nov 2026 19:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794856285;
	bh=l2y4MN7Q2AtsLMWjH9hP2piWATV0VLqCC4nNqGkTTHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZnPCR/VmpfSluwi+N8eSzvGc2Jo8NxsjSOKUdsz4e1mx0R/SQkRDQF/L2NSL27S3b
	 tsaGvT2Zd8agKyr8EAfg95GDpiokgRnWdej//K1WA6c7g/UmHiBQII2nPoSlY94huI
	 QDZNL82whlBr4KbBv5/PN4exvGE9i7YK1G435EzpT1wyXb6hHrwg1STEtpqj8zAAf7
	 vTbADrDpEhSj5TyT760Ibi6sZ5eAWop50r6YWWJ8Ag262BwZbASKUATcgn7TiwZCMW
	 XUDI+hvRbhAJtnahSSNFfQT+ht07ZCSp4YjYUWwqkp3YMAE7xmjPU707l+DADzbR1D
	 SeaZVr4gtuTvg==
Date: Mon, 16 Nov 2026 12:11:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] x86/build: Do not allow X86_NATIVE_CPU to be enabled on
 non-x86_64 hosts
Message-ID: <20261116191120.GC1036192@ax162>
References: <20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org>
 <20261114202524.GBavjDtC9Z3j7PrV3Y@fat_crate.local>
 <20261114204605.GA173332@ax162>
 <20261114205806.GCavjLXgsKNNwK0zLz@fat_crate.local>
 <CAKwvOd=f+ib1XVvFfiW2mF8NoWo1jr55fJo=QOuZCJmzQCVmtg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=f+ib1XVvFfiW2mF8NoWo1jr55fJo=QOuZCJmzQCVmtg@mail.gmail.com>

On Mon, Nov 16, 2026 at 10:28:54AM -0800, Nick Desaulniers wrote:
> On Sat, Nov 14, 2026 at 12:58 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > (If it were me, I'd simply whack that native thing. It is such a waste of
> > energy).
> 
> There's always KCFLAGS.  i.e. we _could_ remove it from the x86 build,
> and <whoever cares> could still do
> 
> $ make KCFLAGS="-march=native" ...
> 
> (I'm agreeing with Boris here)

I have no objections to deleting X86_NATIVE_CPU but as Ingo notes in the
v2, people do use this and it is much more convenient for a regular user
to adjust this single configuration option in their local configuration
file than fiddling with KCFLAGS (potentially having to modify their
distribution's packaging file in the process).

> Nathan,
> Was there a bug on file against clang for this?  I can picture a fix
> in my head for this...

I am not sure I ever found one. I can file one later today.

-- 
Cheers,
Nathan
