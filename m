Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479BC3D953E
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086425; cv=pass; b=jK9qJGfJpQMHLZnOlZC97YMoJIGw/buD2beTau2wFxMx9QMDM3ONX4hiAHS5nbLo7m3w+CNMrFFoYSupI50lBL49CS7X0ff1+hrKjExO0fAl0KMSgUb+c6G4Zq9H+6b6LZ//wFN0ddhvLqY9HnEdFoL9K/QvYByAaJkdpw2ua/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086425; c=relaxed/simple;
	bh=G0Cun/sv5TG4it8HOQFdrnlDKaUupn6OAuYwGu89JEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGFbvw6W49QzHxj8n31bIYF89IcsPUR4IM+trEEfgOrEIMXAkGVhHFcuuGTvGSclY2WXjDF06x33LFBYYu8zLOZbh/l8xVUW+2TwXfJf/xNxDC9wsMCjPOIz3zQWNPA5L0oE2wahEBh/udkVVROcUS8fsVYn1JNIQ+RZ2KTyVZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsHuSI9Z; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsHuSI9Z"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so937491a12.3
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 06:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783086423; cv=none;
        d=google.com; s=arc-20260327;
        b=cdz3NHsQUKtznUZoN5Om37mho5YFHbv0QXgLBe3SSWWgBflvYDX0gY/8S2wkhmH/mr
         RURSZWrHopoutKumISyqEwBVsVOpcCa+Oj8eJ2AptFA1RdIuLXsoJM6PjP5egctZvJ1D
         IrGVvcJvJoBEcwUazZ+/k/bVLWbac6x3TOP/0MyVDC7rccXP11yYaUbUS9GjpFG4DrRe
         Z2M5TMi0ZTYBeaUnD8Al6fWpbCtQ6mOBrDWsSIZKuyrxMbC8J/sl0j8AhhWCPx62Vrhw
         dZPaLOKbhGAQIRnaSgwpL7LSzTijzFOx6QA2ZjHqzhFOPu7WQs4wjFu9Eq/dJn+DIXMP
         0/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G0Cun/sv5TG4it8HOQFdrnlDKaUupn6OAuYwGu89JEQ=;
        fh=4P1bJ04033QpEyoN2eS2xe3SH1ln7h2/Eu1KFKn1RJQ=;
        b=budnff9gIQ6DtStZiZupBgNj6HZc2qQ+0TRczbyHru0qKuplWWs+zHisMnlhySCReL
         c8+K3T+l/17czCrYR5OMoGY9BZJihP+w2adLlSpKoqqBuMq483ODc5hYMv01apMx8Hu1
         F4HXE1EJh3T3JCKBK4OFfZd9QG2rni9GnHTAcIQmJayFyB7gTF2MxmJajEGJRrnIwvkA
         yJL2/cczM2TLaoLz+H68Uy1ZLWVNT1qQHD2cyQfxeagUhG8wnArz1nGBlJHaVufeYuN9
         he3BncAx/M5fATlMYaCdtKYFDLupZ776gPFEjxh3d9E0QlkjswNgI4decf/yORBQHOU/
         qgnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783086422; x=1783691222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0Cun/sv5TG4it8HOQFdrnlDKaUupn6OAuYwGu89JEQ=;
        b=BsHuSI9Z2atWPA1RAOvtGdfEu3m8HCv6u7nm6v1YFkJD6ca1qI52bFcvERVTkU5oVx
         gDejIKa4FRNs1w8xlep+JepXVwhYSSHpoZyJJSc7gh9Ftbd7GJTNUDzTgsjpGWGIG7Gh
         vkIqQSXRGwXnvyZ2W1pSQ2qbW/MLf3QySAt9CECPwfJOQ/qWsp1Q3zXS8mkn8oXIzlcV
         wEWemWHFsied28qjfwQC+KLLAEk3uOyY29m3b3Ae7MHeTWTuzc1H6L+NVC6Cvldh5hzI
         MRBx4zkeIla3IWCpu+3UlxdtQjwGkAbjUjJgtJvAqwakSN1xfUrROcDhmnqRF1pdzNo7
         R3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086422; x=1783691222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G0Cun/sv5TG4it8HOQFdrnlDKaUupn6OAuYwGu89JEQ=;
        b=OaPEWk3eGmiMZ9HOPH+kPl5SvsfASeSHnMC27BXzU1wVfVp76N60aQ9snJBl889vUy
         lvxo7Koz1za3Za4FFSE7ZteS8SR72XFkP8yzYcizY8yPAQpUoFt4TpECf41h6fp18SCq
         ynQj7ojexN9TyfFaTMHTgBN0j2xNwHwr8ONnvN84NTuplgRakNE/Be0jGwkr22XzKxOs
         N9p5APvkArFT/Pweo/3vp2OdpQLU2k715qpV0pQxE2Z5/7pzLZjXdJd7ZyAdkrdX74fu
         ElhFPWHhvcDFnJNKZW8iG5Z2cwjXOLZdiF6FecCJs+rGy20vCBkOVncoAZLz2troGGdl
         Nh1w==
X-Forwarded-Encrypted: i=1; AHgh+RogHnHPEhkMnDhoC6wNBOKuR7SfJ8NPL8m9UHrEgNPctFFbevy3MJgKMJiVBXHN2VLrFrfLSCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqJyXZwW497QjNlTahqkXnMIwCHkr3YlCULhOgrF9l75tZTTEn
	5sGsnSCH1688VTvUQjCoZM/C9nZkMkJUiog/lac2P8ASzXEpQYyoDosQ+80oI63w92RGe3aO+ws
	n2lEgjaAqKnRVinP40Pr5MauNNF0El94=
X-Gm-Gg: AfdE7cnlDhr6IB6xgvU53FL6+bjX9RimfTotKfXe25q32DNxV/pMkP2/cnDhwkG7uNh
	UHNRGGBY8gXX0ywXTWWysTsRNtgw8B9nyyJ+ZpoU/lxoncNg96t8llzoNmqMyavYmUrhsg7XqM2
	Hb68N7yXY9DWmnUGySTTFcVnqVzRzRPfoZX89Fpw2HjkWaMe/YvlvxmvU2fNfjPW+Z009++74wm
	dge8Q7g81+fXyw0sNS1XhYINlO/pAVfB9HBdLd3le5IY9OPFseUwkg0pSMCud7V7Gd7I4sFCA==
X-Received: by 2002:a05:6938:a08e:20b0:c0f:de3c:dce with SMTP id
 a640c23a62f3a-c12aa136d83mr322721266b.41.1783086422164; Fri, 03 Jul 2026
 06:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701163310.GB6517@frogsfrogsfrogs> <stable-reply-xfs-235-fstests-66y-20260702213502@kernel.org>
In-Reply-To: <stable-reply-xfs-235-fstests-66y-20260702213502@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 3 Jul 2026 15:46:50 +0200
X-Gm-Features: AVVi8Ce43HwF7-ts3rhOcPkeuNZOA4woXfj768vFVH3SS2Roxor3ADq11c4OZCc
Message-ID: <CAOQ4uxg8AsBL=hrHY8H+U3gPM8aHg1C2-WDXnCAe3CFCOsBQ9g@mail.gmail.com>
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
To: Sasha Levin <sashal@kernel.org>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Carlos Maiolino <cem@kernel.org>, 
	Fedor Pchelkin <pchelkin@ispras.ru>, stable@vger.kernel.org, xfs-stable@lists.linux.dev, 
	Christoph Hellwig <hch@lst.de>, Catherine Hoang <catherine.hoang@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lvc-project@linuxtesting.org, 
	linux-xfs@vger.kernel.org, Leah Rumancik <leah.rumancik@gmail.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 6:07=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> On Wed, Jul 01, 2026 at 09:33:10AM -0700, Darrick J. Wong wrote:
> > On Tue, Jun 30, 2026 at 07:39:32PM -0400, Hamza Mahfooz wrote:
> > > Any idea on potential paths forward for getting this series in
> > > particular into 6.6.y?
> >
> > Run fstests, and if there are no new regressions, ask sasha/greg to
> > queue it.
>
> Thanks Darrick.
>
> Hamza, could you apply the four patches on top of the current 6.6.y
> tree, run fstests, and report the results here? The series was written
> against 6.6.84-rc2 about 15 months ago, so a fresh run against today's
> 6.6.y would both satisfy Darrick's condition and confirm the series
> still behaves on the current tree.
>
> Once a clean fstests run is reported I'll queue the series up for 6.6.

To be clear, it is not likely to expect a clean run.
What we want to expect is no regression from 6.6.y to patches 6.6.y.
A run of test group auto (-g auto) is the minimal sanity requirement.

TBH, this series is quite subtle, so this bare minimum sanity is not much,
but it's enough to make sure no silly backports mistakes were made and
it's probably better off than leaving the known bug in LTS.

Thanks,
Amir.
