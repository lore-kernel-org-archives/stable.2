Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD231F992
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051920; cv=pass; b=gGUwUs55XKvyuHr7xHu6HPq6ysrKqAk+/MxgjMCc2T3KXz0rRvAzcEg49breVGaAylZokasKur+P7cWKHhdBc+wjtMLlt7RIuEco4S0gvn/lIm/CN1Sf7O/3QUNROE2caFCX1w3+JGFEH3pb9r0hOh+pD4rVuRvLgpDNDk6bxII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051920; c=relaxed/simple;
	bh=lBh87CRQVK/bQItX2JEUtPyQ2PHFCrCkEVZmQXZdgXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tC8m5koZnZrMcoaUocX3mA13BQIuOf0K+mzvtf2CDvlW8N9n2uLTJI+c+kLfB7cDuHfvxVtSGLPV4ezm1vKpzDdeZyp6t4i7tJcnn3qhwi8yr0K4jw/vRgzQqFzJoP25F8+pzaZY2eB3NC85neqUis6pD3H9AkaJ2OQ2Li1TKSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gb0HBjvQ; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gb0HBjvQ"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeb688ae83so32972e87.1
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 21:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783051904; cv=none;
        d=google.com; s=arc-20260327;
        b=dOCj++7Hsnvq5qoWvDDkJPkVWctHKB5iYUrMysgFH3wivulxAsYGs4WpJP2PpTwdZc
         4upQ8KfnrgWpSDAR7q38r8gNnoWECn15uNYy0JPGDO4b+xQ3qZNaN6TONnbfz9EweFPP
         UrxIQv/d1RTC3D28jZl74/G3+O0sZCjjgl07LJRmn8BoGymAtOgWD2HBiNxGRRkTnI3m
         lzBwk/oBpOoTiTuffL4HSbf9c/IQcP2nSykHAxipNEGbe9uUW6nxsPCiP38RsJj0ZsEu
         y8TpwWjVLjOslvy/+Nkq17r24Qtqzx1wW1QxSjk4tujUatc0mgmedygid5udoO0+nSic
         w7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mYG5gbdqiZUgRx9K2qyqNMU3tiBr/+AhYbboeAOaEGY=;
        fh=tihscYClbCLSQfRryz3qBIYZWk+IfGlUkKZwc400LWU=;
        b=kQLiUbT7ERV+uY1AH+i5fncjAXLkFX7BYIWXa3vXRLbtwsecwNFq9FjFU5gSS8429U
         TOTlPPtOhaNGHC2F5ejvTJuQ3P2qho3DJz/ey3LpOK4ZFseV41eVcKjxRHbwzwc0YEBZ
         OEDQY3AeE7cqXAHcdYcrkWOoGeEPfH8+EYqo7Cyx1f8Y3bDlWfkp/ju6ZWpzHkG/1CIy
         rndIjqzBJZVGo2Er/43QUgFHSDZLOA47bkkJ69W9q8dMc66cjC4ayX0+rbtOlaTnvs1s
         DeK6MRfkCdZcYDcKJXf4cRwKc5w/ExucXBTqVxB03JmEPYzRSAvj47pXujOillNFxg5G
         Weww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783051904; x=1783656704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mYG5gbdqiZUgRx9K2qyqNMU3tiBr/+AhYbboeAOaEGY=;
        b=gb0HBjvQ4z6+qygSuofxlKUgbse307TxADbyAPkkyL2GmNj89WAYZ0Zbj99JJ8uWH9
         PnP9MKfchTPBZo3OGceZN9SUUHYrSberO3f6xxrAcO4YXLVmXXBuH0nfbzpadVYabbm0
         tjYNt3jqs/hlvXVwnX8KDjExGJrXwubRV0hEJoUHj1kn/FvrKWH4IOz/h3Alf7Tm7kxD
         /MliF15Ct6jc8NdDt2S/Ro3dkQuEIC/EznuPqDNiye0wdeEMph3kGuBXYMrMp1FvgjV/
         nC9YQ8O3amPvKpcrtCSCBemodUYM5qZWcns0eOldKTnyDgYUG6hPL6Nt6f37d3kO15fs
         jpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783051904; x=1783656704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYG5gbdqiZUgRx9K2qyqNMU3tiBr/+AhYbboeAOaEGY=;
        b=Xzj7ML/QB9k/WMW8nah5/vTBMATF026iR1PBLNOpHOIuS/lqJx0VFQc+hp8Vhkno1o
         BfG4eIp9qzPconA//LnvWGSZZoLuJ+a4bdvuKcqdfSsBojHCIN4icVL3OsnBb8tQvOpB
         Dd6ufgd2JB1Kip4cnZX9uwe5YrcmxMbOS/BowxZNmT0wFm5+lPknIckDZ1cFdT/fFr/+
         Zvissg1kcWYc3k9H1+WGaTT9dY7WMIqQXverD4jd73sDOLKhC/1S7BxssMDqWKLF+W0R
         fs9YSFiVJzY5Y7PnnX5U7cR9T7+tDgVQxCTwfT8x9T8PYYor2whPdvnoHYDvEmvTFTr2
         1qjg==
X-Forwarded-Encrypted: i=1; AHgh+RpCeo+QvQFhI61xUKV7MnUYX4laXVPEZY9W3iDa8NN3lFgMY6g0jMmb3fjhjKQjzqH9JdkDWCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7vCp/3260XLA1zCXoKKiyWNpNBwa7HYRhrPjGKrNUk54iXyM
	b2Ghh0GC0XdSUlkBeb+tvbTm/krDWKwPz/QtGjz5NI6fI7fwIm4CGQJS99bG+n83+6hhjwa0ko8
	zjPEF9IFXiOmFpq+oP148VfY/Kx9V5Z61djkmNm4=
X-Gm-Gg: AfdE7cn5jiBlJen1r4nC9laYONvG6yN0ITksUSz4ZYyQaNHmzKXCZsBYDQQMVPX7B4h
	osvXmoOuoQ6rFnF4V4WtF6pMN4oSNec8XrO/dBOEBWkJFr1ffhJLCajSk9x2n0e2oIV5nOgesls
	ETrqdGjJFH4HNS6VmxPbjMI5JOVRxA4+GRe6sYcfgdeDdysvJvPSXAC2ICT+Y/c+N3ngK5pjZsJ
	z/LxhSPyRBqpic6h09e103iG1h7IhPtdkXO3TVmkfWwSzy9dYbX2fdCyFUO8cStUluedXqGmrw3
	nvyxx3W+0vzvjap3tpLXotSyeKzAMg==
X-Received: by 2002:a05:6512:3b0d:b0:5ad:4a8f:58ed with SMTP id
 2adb3069b0e04-5aecc237342mr247261e87.7.1783051903965; Thu, 02 Jul 2026
 21:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com> <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin> <ajryxMaT5evDUxaq@google.com>
 <20260623235350.6540eaa2@pumpkin> <20260630124252.GD7525@ziepe.ca>
 <CAPd9Lg9uY1RZvYUtcbKUg=VdWM61M2f3aqmS5veUg_8M_Ce80g@mail.gmail.com> <20260702091040.35eff00c@pumpkin>
In-Reply-To: <20260702091040.35eff00c@pumpkin>
From: David Hu <xuehaohu@google.com>
Date: Fri, 3 Jul 2026 00:11:31 -0400
X-Gm-Features: AVVi8CeOojzP-I_HmExSVQqRC_n17UpgYFkRlrxVBr237r7JGuzRVJ9YNtE2VWM
Message-ID: <CAPd9Lg-ti9hOr4-62xExbNuBJ1fmnhg_Vi1uxFZ8h-9FoeGAnA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
To: David Laight <david.laight.linux@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava <praan@google.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	kpberry@google.com, chriscli@google.com, sashiko-bot@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 4:10=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 2 Jul 2026 00:56:40 -0400
> David Hu <xuehaohu@google.com> wrote:
>
> > On Tue, Jun 30, 2026 at 8:42=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Tue, Jun 23, 2026 at 11:53:50PM +0100, David Laight wrote:
> > >
> > > > > If we restrict incoming dmabuf transfers to fit within VFS-centri=
c
> > > > > limits (2GB), we impose unnecessary overhead on the RDMA stack, f=
orcing
> > > > > it to manage a significantly higher number of memory registration=
s. By
> > > > > cleanly splitting these massive contiguous device buffers into
> > > > > page-aligned SGL entries, we directly improve the efficiency of P=
2P
> > > > > transfers and memory registration.
> > > >
> > > > But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think a=
ffects
> > > > a lot of io) when the quotient is always 1.
> > > > Splitting into 2G chunks is a lot cheaper.
> > >
> > > Doesn't matter this isn't fast path stuff. It is better to use fewer
> > > SGL entries, IHMO.
> > >
> > > > > Since this change doesn't seem to have a negative impact on stand=
ard file
> > > > > I/O or break existing VFS constraints, I'm curious why we shouldn=
't
> > > > > support splitting these >4GB P2P transfers? Am I missing somethin=
g?
> > > >
> > > > I was only wondering whether it was needed...
> > > > It does bring up the question of why the >4GB transfers even need s=
plitting.
> > > > But that is another question.
> > >
> > > SGL can only store an unsigned int size, so any large physical range
> > > has to be split down.
> > >
> > > rdma now a days has code to process the sgl and restore back the > 4G
> > > sizes since mode RDMA HW can accept that.
> > >
> > > commit 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e
> > > Author: Michael Margolin <mrgolin@amazon.com>
> > > Date:   Mon Feb 17 14:16:23 2025 +0000
> > >
> > >     RDMA/core: Fix best page size finding when it can cross SG entrie=
s
> > >
> > > So whatever this produces needs to be compatible with that to undo it=
.
> >
> > Thank you everyone. It looks like most open issues are sorted out.
> > I'll wait for maintainers to weigh in before sending out v3 (which
> > will remove the type cast for min() per David L.'s feedback, and
> > revert to ALIGN_DOWN(UINT_MAX, PAGE_SIZE) per Jason's feedback).
>
> Does this code get used a lot for 'normal' transfers?
> I'm away from my normal systems and can't check.
> But if pretty much all of the fragments are small (< 4G) then
> it is probably worth adding a check for 'size < limit' before
> anything else and optimising that case.
>

Hi David,

Thank you for raising this. This file (`dma-buf-mapping.c`) was
recently added [1] to exclusively export MMIO device memory.
Therefore, it is bypassed completely for `normal` transfers (IIUC,
e.g., video buffers for V4L2 or DRM).

Regards,
David

[1] https://lore.kernel.org/all/20251120-dmabuf-vfio-v9-6-d7f71607f371@nvid=
ia.com/
