Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2EF3783B0
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781734170; cv=none; b=Rh6BRy4VxLnnNU+QnXezlcmaABxS5nC+h+5elbvosDkOrdJn2fRb5as3849TAktZBm3MjNeTg5liMuB5Bk7mcFNPDpxCt4kqKTGUJptr88qmSACUE0iHN0+dgq2VB8nPzrB0aCMKQMqKGJw9ZBn3uVu9g1Ht+wbNbQirYqG7oM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781734170; c=relaxed/simple;
	bh=uiLbRMVri+8fY10hQWutxRhmhQ9lR7q6Ndkzz8Cvgo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMnktDC3PsOc6BJUX8jKY9xVO4KxWuFKzlYf36zLWfTiNj2TycEUFCPttKmjh/6NhHiCrrx0QBsYDe+4L8Tk6hXP+wy6xT1Dq0J931i3CGzQc9k9vhnxjfqGmtpyd96nCwymcqvdsITQJEqrUwLbyqeFgxSC4qEI0pqR+q87lz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqtoNCAh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqtoNCAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88B31F00AC4
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 22:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781734168;
	bh=Far9lw1KW1BMkl8Osf95kqLeaticJJs0nTnapvnthf4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DqtoNCAhPA7DouswsmL6OHc+FWlZklUNRMUP2Wy1mumxfNgNoM5WMkWmjdOiDt4K4
	 QoeX66j9sefsXgD3mgXGFS7V+MH6U6AnZLpvuH7/JO+L1bAogMGNor8QHgsSeFjImO
	 5xiE4zSlpUN//NIPy59CafOMAUr2Mf537igdJh3xftvHZgd66d+HTsWbblChDYwune
	 rkW+XxyJ3FPZJ4q+vder0CtVg72aLkZIGvR6tLm/0bcf0DZAK8lTF5Eyj8Qpm3lxs/
	 VKDvJmfbj4u3ywI35wbqeFfFY6PpZEG7y3aiXCM8S7yxsmNZBPqaAv8VA1xhTIOg8a
	 LK10zEHv2sgxg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68e5f7c1131so308516a12.2
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:09:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9h+BPq/FiVbrobxSvXe8yUuwL2/2pFrsG9mlNIv+UUeFO1zR3ch3hSnoIdiemxFg3v2KK0gy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqwoQfzERLx6NHCBmNNiK7tiwGiG6W8CTnKf/HbqWHCcYYhopD
	wWd0RTyY2ycov2I5xFtnc6bDgft5Bml+rZz9VNRcyDzgEc9lNYi9j8rQY/zCyHZTN5ybHmRpf1I
	GoxlXA776rB1wjNqUxwp5xvTywSRbDXI=
X-Received: by 2002:a17:907:843:b0:bee:f0d5:1c71 with SMTP id
 a640c23a62f3a-c05a502302bmr383482866b.42.1781734167864; Wed, 17 Jun 2026
 15:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616214652.2157032-1-yosry@kernel.org> <20260616214652.2157032-2-yosry@kernel.org>
 <5b5a0f3f21bba5d25410382a9e0170a17c952738.camel@intel.com>
 <ajKbCii_1LpyQKjJ@google.com> <861c890587cb8cd0e2893ea4041555d33d8e9db4.camel@intel.com>
 <CAO9r8zOMkyjG+a8YLGskEaHaLpGyo4qnrHBGJu=pZc_4a3bZWg@mail.gmail.com> <dc5cb383eba7ff0130b74d1c0f3d34285b51cd3d.camel@intel.com>
In-Reply-To: <dc5cb383eba7ff0130b74d1c0f3d34285b51cd3d.camel@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 17 Jun 2026 15:09:16 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNQGHf4AjVNG-sb3iiF5NVsYL4mFqmaU3OoGY_CEF235w@mail.gmail.com>
X-Gm-Features: AVVi8CclPDICtYfD4IWOSkNzq-_3ehGROh0sAIh61alpB-5Lx1-axj9K3PT673E
Message-ID: <CAO9r8zNQGHf4AjVNG-sb3iiF5NVsYL4mFqmaU3OoGY_CEF235w@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "jmattson@google.com" <jmattson@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"seanjc@google.com" <seanjc@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> > > I think you mean the "actual flush" needs to be done on the first use.  But
> > > setting last_vpid to 0 is a setting which is to make sure the actual flush will
> > > always be done on the first use, i.e., the actual flush will always be done on
> > > the first use.  For this purpose seems to me there's no difference between
> > > setting last_vpid to 0 in enter_vmx_operation() and free_nested(), but maybe I
> > > am missing something.
> > >
> > > But I guess doing it in enter_vmx_operation() matches the logic of "doing actual
> > > flush on first use" more :-)
> >
> > Yup. I thought about putting it free_nested() as it looks like
> > cleanup, but semantically it makes more sense to put it in
> > enter_vmx_operation().
>
> Sounds good to me.  :-)

Thanks for taking a look and reviewing!
