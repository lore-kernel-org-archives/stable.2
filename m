Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409DE2E6CB3
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785046144; cv=none; b=FwF3Ou5hE9iGGgoUGZ/CIGrPVhhTS0sbVrvvTTXuc5o+8oLXZYdKlpHYjc2j4iHrFW3XOQumCNhjpEMKRt27jW4d1d94QOOWNxZ+iEzeD8hiFplsUF0djzJNzAcDGX6Igochw9biEVNfZREprG/+3zfo7/PeILC5MCjzG5IhluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785046144; c=relaxed/simple;
	bh=Z7TFJuHVHJKvY8/Mc6ddE/wit6HJie13aC7mOZ54YNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZltCVuEtBXVrkFTaYS3yMjr3XkTMmPztNXM3dwUtoA4h8m62B/QHXyYFsr8AxMGJ8bCpOJ3kmPD3KRHKuMGtoXpah4yrYLsw8FKXiXSBrZGcIdwoY3J8sINhKxA80QO7DLI4RZkDsmgxcXCJ7u/aW1n21drAhnk65KC+nCox05k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz+g9aj6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz+g9aj6"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84861fc51f5so1230769b3a.1
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 23:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785046142; x=1785650942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7UFhWQOa/vwyik9QrUHaltpmfCg9gV5b8FYD7Vbdi7U=;
        b=jz+g9aj6e5FFzOfbp/mpUry7APQ9iM8WH7a9JDUIi/YkYOCootVmeDydu5GrwSEdor
         8wgw3CAB/aENcUq9ivmkcIBWgwvYoVlKXSMeuzOZd7pfndyi/TsmylME6ts7oOAuUzhX
         GbPvHqV4KS0WtBQsHNQaOWKxa7sVfSXgOKVEPVQk/utltGACl9xHs+OxfnKSygaxItep
         DFSKpSDb5OPjhB2FnDraueFjnCk16zhqxnNSQC0CSJuWcFVImOMiQ9NKp2ZRhBtuRlH/
         B0hlNc6qxoP8djKwyP5Wsa69/W221inGfE9I07t/kMn3B57iBShaX/MpYc85/jWcT1hJ
         w6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785046142; x=1785650942;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7UFhWQOa/vwyik9QrUHaltpmfCg9gV5b8FYD7Vbdi7U=;
        b=X0JY3O96kEhlvUiKvY6u4bjbFJ/LWIEiuxoAotXhTbzmksLAOcNGYvnx0D0DrDcOll
         ghUf1wvONUU71fUMPzY+stgrHepoHnzxE9d0/3ZXVS0WLDj+rOwM0MN+5T6TDFQkk+ZS
         xZF/h2q+/CMGAsHEBLDRTC6t4+21pE5VRjpwelYLRHSJ0OzYxeHLqosjlN6I2HcJB1vj
         zMhgw+UKEPe9GdLthYdc7jVyMCJUvHfBRZaacLoCwRL/eLSWPyEHhuIErQvSoeQn6WMC
         Wui3XpEsFUwnvY3Jcuv+AGDYh+fKnQmDAMw3TWN5w3jaK141JZlZd8e8GQ28zSKPfph3
         0nVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqlIYWkUkNHxJstVORejINxFnBUeeFox/fwhixvD6/0GJo09z3ju35GfzTAPvKCbUvMLqVKvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6IWurY0a9wR+qccsQ5rwTXCzACR9Y4+MCa+pAmOx2iKeWbT/
	0XC9TJIdOaCQryIQg7EoQMvMKJcVBA7k2/yvelDzb1Amg+d52QtEcCXI
X-Gm-Gg: AR+sD10h7oyuMR51qXuHe0Pio2NVIQV72bI7WZRQcjyG8qSDl89xW0eSYQGTupScaWF
	hodWPQQAGMzmXkbswoz9YFKdfZ36iAIhUZrCEaARUg7YVfY6yMmlbAI6QcrVmc8dpoe3KGMF8sw
	O55DAH3HsaasmtSLQwu1IfZuF/WnSj2mMGkSjT5se1EzI/+UkMJ0m4PnBwNgfEc9q+o6f8AHJr+
	mWWXUrPjFHmwgxdahJ9AYzZnSMQyCLH3BVEHciLP8LK8OZkplRVgKrKpAFUzm58j3FOcb8OlRrR
	5wL1aYMvaon9GHurdjXfE3srhodFyYbwSJ2olHJQLw/4XfmYaG8MIL1j9skM9xbsC86Xz4BEMri
	xFhoBGgRmSrUjPJ1cYlu7Gm2JhxwO2CoU6H+ACDKv8rw3lPB9Fxegc9SeTeqlFqs93Kvy104l9e
	0LUD2u2c1J5iM5moeTiwVw3tGVGiB5p7bd6A==
X-Received: by 2002:a05:6a00:390f:b0:847:8d54:f4f9 with SMTP id d2e1a72fcca58-84e595810c1mr3014064b3a.51.1785046142393;
        Sat, 25 Jul 2026 23:09:02 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533d1644sm1609938b3a.37.2026.07.25.23.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 23:09:01 -0700 (PDT)
Date: Sun, 26 Jul 2026 15:08:57 +0900
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, 
	"moderated list:ARM SUB-ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>, stable@vger.kernel.org, Ard Biesheuvel <ardb@google.com>
Subject: Re: [PATCH] arm: mediatek: fix secondary CPU boot on Thumb-2 kernels
 with Clang
Message-ID: <amWfjDyn0jrnIf63@buffalo-ssd>
References: <20260722172443.534251-1-akkun11.open@gmail.com>
 <CAKwvOdnbPKoTy72EvfpKtT9Ne-r+O0j99KFX8OvjGk8ZxsuEGw@mail.gmail.com>
 <amHYO1c-5vzqSekt@buffalo-ssd>
 <ef007a23-46bd-41d6-83ff-264831341093@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef007a23-46bd-41d6-83ff-264831341093@app.fastmail.com>

On Thu, Jul 23, 2026 at 11:53:14AM +0200, Arnd Bergmann wrote:
> On Thu, Jul 23, 2026, at 11:15, Akari Tsuyukusa wrote:
> > Can you send your fix as PATCH?
> > I think your approach is better than mine.
> 
> I think we should wait for the llvm issue to be resolved first, to
> document whether this is considered a bug in the kernel or the
> assembler, and to see if any other kernel code may be affected
> by the same thing.
> 
> Looking around other .S files, I see the same
> pattern in stext(), cpu_resume_arm(), mcpm_entry_point(),
> all of which start in arm mode but end in thumb.

It's a LLVM bug.
The LLVM assembler source code explicitly mentions this limitation:

  ///
  /// FIXME: there is a corner case where the state is changed in between the
  /// label definition and the .type directive. This is not expected to occur
  /// in practice, and handling it would require the backend to track IsThumb
  /// for every label.
  ///

https://github.com/llvm/llvm-project/pull/211641/changes

However, it will take some time for an LLVM release with this fix to
become available. Since LLVM (>=15.0.0) is an officially supported
toolchain, leaving the kernel with bug(s?) on supported LLVM versions
isn't ideal.
I think we should apply a workaround in the kernel for now.

Best Regards,
Akari
