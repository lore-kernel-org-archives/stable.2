Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F13BE627
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802126; cv=pass; b=OOfPZRcxk7OOF8MBNeZc27y6WTIa5+8UJ+ZLsnthXR4BPe9rcZcO83xu9MWfyMmYM2zBi7ivEd2Y9JPojypQDkzBy/s8DmVBzQk501cXS4oO4sADtKoAbDyp7Ikf4hWErJc76alc7vR0gWIECkXiwuwT+RSILutCay28B8UWZxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802126; c=relaxed/simple;
	bh=yJxWfUPJuEqTfpU+R7hcqH890XgyQDGvAsHg33GYD/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTCJW79yQSonv++/NsYflZbs9MBZXDOvI9EkL/NhMMSropqtjCXxCqcV8ODT0cH2I6qPIb4tMFcjU9rUavLhrT6n6Bb8Bgor4haZznrUbUhLB+9BAEcX5eam+wdEXrBWKQLMPonmVx4Ml0YbULpVvIDTCJKSguX16Onghdkzd+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvBFtxeK; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvBFtxeK"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c262f1186f0so226875166b.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 03:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791802124; cv=none;
        d=google.com; s=arc-20260327;
        b=PdGMwp2zwplXkved7P+C8sZNTNy4LcLocpa9nPWalkHCv84FbT/Eeo9rf0gKY8EguH
         0vb0N3yexna/lkX3QXC6r8+92E0ChhX8l9yDZjJn7OAx1FrVPt4DRoxmGPVVzm/WE37q
         mqiSwXHiB9bkpyB5G2spFXd25LVScihXnfW0/JQwvyn0cZ+XPP6oZK52idx7zeSuBWhv
         1lpwu2wg4Cv5odHvBquhi6Zxt13uMu/DKK8XfQMEhLFwSailB4pHcVdWitcyzxmNlDdy
         9sYzJOiyCQSEFzFNpSQ4Vsa2SZWCqxnJdA3RHVcEMe4q8ElevMLAYu/N8BXRNhbN05N0
         S3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yJxWfUPJuEqTfpU+R7hcqH890XgyQDGvAsHg33GYD/0=;
        fh=6EUhpq+ybhS2FOGTSffE33hAfLllnatBgkgDkgDYOUg=;
        b=IdPP0Y7Fg1ozsPI4Yd7hu0XoUj0kCRRkKxEicfM8qzVeljNP9/rTBE3SgCguzzgvKT
         +8oRJRmwZE85Aah1+nke9HS9QPJHz5gi0NLjjQN3gYuHiZaTPVY6cicf3HYIRQ2NOQhU
         OWr2J3Ubt+AaHkFsyRnIQ9yPVSG4Ww6urOcU71Gcro7LjAT9UhxZMusTjFa5UEMtoLDO
         htK+GeluKaSYJjGOnThOlsi69Cd3MPfuaCGmJIgdzaKcggSA1sBFDbVSBG65K2DNnzrw
         FDgJIRsjgRpiQykO1TelXaU7IkX8Y5PlrVqk4RtyhAuv2c1P2zzLWy666/JR8YjE+lej
         86Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791802124; x=1792406924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yJxWfUPJuEqTfpU+R7hcqH890XgyQDGvAsHg33GYD/0=;
        b=MvBFtxeKDOS0EdVSG2Bp43g81Bi6onlFsI6m7PX2arlBI/Lf9WVTJGY55yT1SPwWG7
         VQ9mZ5HJ4UgNpK7bxJWf1x7s9S6wA/KvlBGmonjzZE0fJ+jry407rP27T3xYbvwCsOHP
         o3yNZ5XMViZQnksQUsNwVOMznDRU3qDUgMNTsvA8OSeSDB5+CRVFIT8V/zvlKtDuOsgI
         DtS+tr21PELCB22XorPSM34sJzvuUotH2ZB9R/AZYEJJ/y0x5xbrznN4VjKuurYOf84t
         bpPbol/Ss626BRA2J7WIvbpHqdUwbZO9UUCyWC2xj80XpNtCofoQTI/9WOknG9ytT9xL
         88zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791802124; x=1792406924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJxWfUPJuEqTfpU+R7hcqH890XgyQDGvAsHg33GYD/0=;
        b=cMm3u4c7kN4ecvHf+z6gHWJG3rPqSYaT6OhEqDF5+vE8RxN32Brye/0NTIkSjrOqbr
         2PR2Ms7CO2XqvKkJFamjO4ZMCjB98ulN8zBR9HLcEc5i2XK5UhC7C6UtAYc9Ohofb+Cc
         sCmkeTJ4zQFbYoVh1qDAJ+HDOEumDTgQVYGoNNY+l1MKET5x+IS1ap8a2yuzJAPjBJ/u
         mD1A0fszhjoxkBmOqsgYpQ+wFG0g4fzgMRQN5jSrRgFPuFquZ5GsI624X0ipvcTvYp/m
         4oBuySzydh6bDnAF1rnaRxV4MJQ19cWWC5FwUivVj4Fpf0aB5YPFQ/VNDmjY7ldwEhr9
         zbNw==
X-Forwarded-Encrypted: i=1; AKwUvBxduYvFRfYx0ZNiREqkq/uYpacF9CLXOfMmuM41rkBOWmtkpMRBB13bHDXvncPV/chTR06K2vY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJShnMGuI70QWzkMDGriNZjmOKzykzPxM5q/O4mN8VlY/uOkVJW
	TRfQXYcEZcm+ApYU76Bey9Wm6quYb9S0YE+4NeBKCWu7+OjzaJvInyM5oikJp2ALXIsHMnA9yRU
	RLJpf6RcZTnONAfqtE3ydmFZO2Cdicuc=
X-Gm-Gg: AYBFou144pSDpAnEZOiz6MT9aLTWygXRvq6hwpCasaFfI4U6iWA7MN5+8yMvmX977xA
	Cf88Hg4MjeXFXPeb1s0flc9KMWrUj873sKKTGt90S7BYZyyRSsacDoilHaNPig44DoiLut/zRiR
	u2qCYpHb/pMoJUYAqaoN5zRoFb55+5ine7KObJK30fXiIx/4VIQneCZpYO+q+WAwHmOUocHGxPF
	kXluRbqoof5ywbUvJEoSQGJzVuFzo0DQGH5CueL5uBNt2VG+LLoeIcLRpIPyMl0y9FjCWhoPff1
	VMiIBXZS0sKnBd5vd7QUE1IadIUOdDiiwqUqu/q9MoaFPEReCBi5U81JJ5+1q8P7ylM=
X-Received: by 2002:a17:907:97d6:b0:c2e:2944:d6c7 with SMTP id
 a640c23a62f3a-c31aa036549mr927162766b.29.1791802123504; Mon, 12 Oct 2026
 03:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
 <20260930-work-mount-fixes-3-v1-14-be34c83956ae@kernel.org>
 <20261001-prollen-rutschen-amtssiegel-31392f0a489c@brauner>
 <CAOQ4uxinQiXn=F8p92rCTzwX5AcBiN0abWW7jE9jKE+zqjb1_g@mail.gmail.com> <20261001-abgehackt-herzmuskel-worauf-80bcefb0a8dd@brauner>
In-Reply-To: <20261001-abgehackt-herzmuskel-worauf-80bcefb0a8dd@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 12 Oct 2026 12:48:30 +0200
X-Gm-Features: AclHuK9M9jsbz9zheu8tLl_AdY6hC66_jaZlchTl42QorNNsWlRmIkLJwfQ6nNk
Message-ID: <CAOQ4uxgXLcV3tmFp-gfF4Fm8ivvqGJzZXf3hmSeqo5dkzPv-=Q@mail.gmail.com>
Subject: Re: [PATCH 14/17] fsnotify: detach the connector before destroying
 its marks
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Chris Mason <mason@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Daehyeon Ko <4ncienth@gmail.com>, Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 2:06=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > Isn't the inotify problem described in the commit message already solve=
d by
> > 669bb5af15d41 ("fs: make sure to call fsnotify_inoderemove() only once =
when
> > inode is dead=E2=80=9D) on vfs-7.4.misc?
>
> Indeed, I forgot this patch existed. Good, then we can drop this.

Alas, not quite.

Kyle Zeng was able to provide a reproducer for the race off-list,
which is not solved by 669bb5af15d41.

He provided a tested fix patch following the same idea as I mentioned with
FSNOTIFY_CONN_FLAG_OBJ_DEAD, which he called
FSNOTIFY_CONN_FLAG_DESTROYING.
I provided RVB for his patch and I think we should go with it.

Regarding 669bb5af15d41 in your tree. I think it needs a new revision.
I will send it with explanations on the email thread that lead up to
669bb5af15d41 [1].

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxj4sYikVUEhV1pdUdzoq2U4pBa6=
RheZa7a0WanBmXkEow@mail.gmail.com/
