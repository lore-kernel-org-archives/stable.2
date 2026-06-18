Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD102F0673
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798394; cv=none; b=sRdLnshXN2nh6cepmWB/Yr6UwWyWI4R9vieIdbEDCxtt6y/yWQu0DDO1XJIk6nbwdtv5XsPubGgUbBuxhKKO96MpKyea2PTWpar9Ls6XF3+GlbpAPQ20e8tCllNgFOWB7O4wLk4uyxQg2m23sn6er32lopE9KfKZ5ttS4s9v2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798394; c=relaxed/simple;
	bh=E/y+8JHnTb2d61AU1IWkSWGOzzfnMcc6kvneJqFfPXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJVNX/dhsv2Lt6wHTWYb8V0aPDRSuKMfbE3GJdSv0cIyILvgLsuX5XivRpa0AxaGCea84OGdsNMAPoLfNQcFkh/KXeTe4gkvG+f/eKJw9rBsJYMhRyc5Q5NTirtnuTzlJsh5qOqczZfy/aDaQ30uyNsZUvuufIlZCMOIwiZ4pMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5ujQVV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5ujQVV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0B31F00AC4
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781798393;
	bh=E/y+8JHnTb2d61AU1IWkSWGOzzfnMcc6kvneJqFfPXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=h5ujQVV2unfhhUt4y37D9VvddJG3uiubKL/E6PIYh5HGICwvn4/W9jVD9qDIRtyer
	 Aor6nKt33SyXviyzg+R6hmpA1QTgdf4AgvdBgLjIwm4obAKPWd2orntN3xI6SYFpfx
	 fHeAScNm61TpVUXNqcK7te1RUXawZ9QnD8oYKNI+ZUfZSU+QESqjN70FHD1XaQSpH/
	 DmEmyR6tPyfEkcKyuR0wf/gAlut+qEUKFI8T/eGim6ucb+v58bksvDkFxcVodm1oBA
	 PNet5eu+2pnhsPdDkjPl2f7LxagmBm3vFRrDNxS6V9CNYeVXPv1yWfGENZv6vRJMqm
	 w0rKP4LVoWNjg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c07fd4dc2c8so84960766b.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:59:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8dA31G5X7o7k0rIayrDYCkggm5CKjcQ1Z7kKLtvWKttHm8B/fQSOfTdMB7amRtNhpyna10Kpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbES5KPQ3tVP5Kqek1FJNiMDh5VwcLoytr+2JVVntq3iqzvGk
	7qy/BcoQzgDCkPXLWckUQ58skAFs+Mf0y76sLBa52I4Z+Vn6s+fKycffjICgoD/+UhlF7yjjaPN
	bJ37V9pALJvv4I0PbqD4gr7wSsIzUBg8=
X-Received: by 2002:a17:907:26cc:b0:bfe:ed06:5a16 with SMTP id
 a640c23a62f3a-c074e7bdfc7mr268582366b.52.1781798392113; Thu, 18 Jun 2026
 08:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616214652.2157032-1-yosry@kernel.org> <20260616214652.2157032-3-yosry@kernel.org>
 <3551571b85bc94a7b0a9eaf9e3c5561e46c5423f.camel@intel.com>
In-Reply-To: <3551571b85bc94a7b0a9eaf9e3c5561e46c5423f.camel@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 18 Jun 2026 08:59:40 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO7W+nPQWAzZzqqEWs9c_tHgYpb-wp=5PXXx5x0ePG2Mw@mail.gmail.com>
X-Gm-Features: AVVi8Cc8lUAhY1yGX9oBQ_QzAfruGIkFYg_kzzB6F_neljHEng7bFmdzI5Pl7bA
Message-ID: <CAO9r8zO7W+nPQWAzZzqqEWs9c_tHgYpb-wp=5PXXx5x0ePG2Mw@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: nVMX: Decouple INVVPID operand checks from
 flushing of vpid02
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "jmattson@google.com" <jmattson@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 3:57=E2=80=AFAM Huang, Kai <kai.huang@intel.com> wr=
ote:
>
> On Tue, 2026-06-16 at 21:46 +0000, Yosry Ahmed wrote:
> > From: Sean Christopherson <seanjc@google.com>
> >
> > Separate the INVVPID operand checks from the actual flushing of vpid02 =
so
> > the flushing can be adjusted to do the right thing when vmcs12 was last
>
> Nit: vmcs12 or vmcs02?

I think vmcs02 is more accurate here, good eye.

>
> > loaded on a different pCPU, without having to duplicate the logic acros=
s
> > multiple case-statements.
> >
> > Opportunistically let the VM-Fail paths poke out past 80 chars.
> >
> > No functional change intended.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Thank you!
