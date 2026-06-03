Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671933859EC
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511063; cv=pass; b=ajIOP59pngzGYuYUQLOKY6Gs4mBJuHSrsQV0gP4Vl3mpcbymlWLwHsuGglcma4aP+vVvnMcnGTKUzMpVNZ2FQiqdQQjLJ7FsE6fjXc9Zh11BRN2zOLVDPzhBP6VEOLvJX1lknmKBXdc9ZGghdKHsif1RVNYXwSIqVz6HuurbAMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511063; c=relaxed/simple;
	bh=HWdGSfSJ6XiOwsk/gmwA/nVjIEvHExoXM0cys0ZgUws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdzBirx/aoQXP9WvwL2iYsMrcOsJc5nGkLQvraoO+Kje9gNIJ/tSdCdzvSdndi5V75RFZkWESGBHBljFmfJxSlLSGWaEEDUc+TfEjRlr+75fJEKUMrsEVSzAkPIBQogYKjaw3n2l14394vesnFSrqzA6Xas4S65SuaA9KwRu8Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDW4VNKM; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDW4VNKM"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68bd7ec2371so1161a12.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 11:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780511061; cv=none;
        d=google.com; s=arc-20240605;
        b=EydO+PbFrt/eMZiwte7cTbM12SF5z8hIGBOwOsCeBVMoWJ2jxZlmAfcCfGxc+SdZEf
         qu1UakZVcSnGlYkD1PRg5WM+feDTB9iwhRGd/305o8bnqcsGL7AogztJNpyLoZqgwSRN
         rFrcYrz8WUbEvRWFz52MtBXcnX3hl4uxsS2cBdSRomNDqqkA/Sxv3/jUuKGCZOtqpTi/
         e4eNC8KVy9PHi1dIA1fG7jv49uIVAH7aUCEg9FE0kGdTVlt9tdx+okY0LHeCFNBirT+N
         IwyOEp7Yfp88vZXZdbLjZRhm9G/9vPC0nPICL5A8xjQY+e7ozMzehAmV9wC0VqkuJQDM
         JPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2c1pnarNV0BgrbYBT5WI/9g8oTdViMreYH98GUJuRCw=;
        fh=qLWMaA/e06b7iOEc9l5sX2/Pl5Q4EqrPL/OcP5D01b8=;
        b=Rsc/8KQfpY+Q4Ur7C1Y7NQ+RezjvdKFpIWztTKVeBOO65irgCpCY/lBIdpwHSNAD2R
         /hJ3L7a3IDXUjaJMOzr3h1mRof3CmZjthYUbbnWCpmfPbXUlbCBTETO16/JetWGZqFSO
         Gx4/DPlcxp8a7skumKNEymnvCANAgE/Q8WsYkOgpDTuMSd0YJy3/xH4vDWLaJo5wau0Z
         pC5otKvpVHcYmbRs6enoejWKS54lbac08TWw60tONp4/OKGjc9j4HXQYZCeyIemYusTd
         lY3A7xscYa+oN//a8dtaBOBZpYaY3KWvEwYcIcN5gDcuQsrF8pPdGn5PwgYIzmyWLkAy
         aQtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780511061; x=1781115861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2c1pnarNV0BgrbYBT5WI/9g8oTdViMreYH98GUJuRCw=;
        b=WDW4VNKMeS1T1upBXj2gFftz54NnBPendE2Fw3Z6doAar8VU5J7nu5zsWtAtu3mx3D
         RV3T4SziMwoF+S6BRxkeYIPXCRM3z2HpM23w4d9NieV3rO6SNqrNGZaQmKivjSgYSknc
         TlCMaB2tdwVKgjPnosOKJ6jsbdfu1fCmWlMRBaTznJiYtAi7Ogg/OhhZIlxdGKUTorJE
         sGIAfHsNXH4rS/PJGrcI3vl0UGCRIEiBhNP5w0ZQb5/JeNcBbx/7N5Jqv0207U2fn7Ol
         8WkDdX3tSqmW7GqzZmCe9k9/5JvQxBXGbBSF8A4Jq4Fyaz+P8LdGSiJ5rvPuKhcoyCHf
         IlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511061; x=1781115861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2c1pnarNV0BgrbYBT5WI/9g8oTdViMreYH98GUJuRCw=;
        b=Zm8Zb9Vgmv/lrLUeeyID0+lUOcOAXbbI6cvWHGIWKKYqojZjBaKgNORXdaYvrtnOYu
         rHpwdiM8Qm8GSHN+1FyIaUYEbFMf6dNzquIMv279rzcsMVLKg6+5xrB8ohwH8ntB7A/+
         OrASptlB7lfOcdvwL2fH3B96JYZM5CEpoRT3FcZYaJ+SrheQAdJtf+8UM8Pf6gNixwL0
         xVLnwgD398OZeK5Dj3+mS+BuVGs36CaVqNPCe7SX0ONBgWHrCLqonTyCt6l9yW1e1cuQ
         r1PfTvG5IOTsFuk0GxHETxHFFvJ8KLa5Gvv98t/oeP5nKA8T0myfMtzkW8syhkBk7the
         HMrA==
X-Forwarded-Encrypted: i=1; AFNElJ+XtQWdSFNC8jXOhOTdJtYfjX8HNW07PaiSCqy6nfSAjmoIdcz9ppzLIErK6k+kUClu9U7vI9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKiVHtFGpDNbQTK0Y48Tli8v658d8fbSqJmtL7YXgXR2pZjV2t
	vNAFo2tKvGjJbvDgRymd/jWcItX9J8oSdqVXJqCFxuZvbrAjKyHRJPYhRaxwa4cKtNEt9eZwAFr
	r2l3vsle52ItW/9Fnm8WYjn6Q7Nu6Ff/c4LX6eKRF
X-Gm-Gg: Acq92OGBCBD8nBeeWSh3L0XCn7ku5DmUqpl3juXEGYOou9XALWpygMxPvnfbhsNJ5q/
	Ap5qFK/W1oz2QikLt6tOzBMl1aIjrqTzM5u2TXJEaGLLCbHqvRC9u27uZ+kpCfL3Rq8jjmO9xyt
	kQw2N6HxSJvyzTnWb/T8UqN4l4u3+qrQ5tfymwYemKij/uDujHtO3VJn8HkoXMfXltC21bvllsY
	dsLw8vtr/pKkmnA9+VfwWMAIXc9tLztYIRvRgptNyCAy/sEzNEiEKNxTRAtK+sR4fqrpFGGr6vh
	nLm4J0zPgRwXqyqXXut8J7E09cTk8Iq/w2JDiKeRId3QtJCJFuZlNj66ge4=
X-Received: by 2002:a05:6402:4d:b0:671:fff6:f82c with SMTP id
 4fb4d7f45d1cf-68f120888f3mr9598a12.2.1780511060391; Wed, 03 Jun 2026 11:24:20
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com> <20260603181523.GW2636677@ZenIV>
In-Reply-To: <20260603181523.GW2636677@ZenIV>
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Jun 2026 20:23:44 +0200
X-Gm-Features: AVHnY4KcxLLBzYv04O16lPgfRsGmNsi92bRo0L6SiX4sR-aXpPDHaC3GJOZ42Y4
Message-ID: <CAG48ez1DGQ8MbFWWi+n0Br84cBF_wSrNgPqd+NSxAcbAK7WR7g@mail.gmail.com>
Subject: Re: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 8:15=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Wed, Jun 03, 2026 at 07:38:06PM +0200, Jann Horn wrote:
> > Fix it by taking rcu_read_lock() around the mount::mnt_ns access, like
> > in __prepend_path().
>
> > +     /*
> > +      * Containing namespace.
> > +      * Normally protected by namespace_sem, but there are also lockle=
ss
> > +      * readers (which must use RCU to guard against the namespace bei=
ng
> > +      * freed).
> > +      */
> > +     struct mnt_namespace *mnt_ns;
>
> Umm...  It's somewhat subtle - at the very least you need to explain why
> there will be an RCU delay between umount_tree() clearing that and
> having the sucker freed.

I guess I could write something like this instead, to make it clear
that this basically follows normal RCU rules, except that this code
isn't actually using RCU markings and accessors?

"This is like an __rcu pointer which is protected by RCU and
namespace_sem; however, because most accesses happen under
namespace_sem, it is not marked as __rcu, and RCU access is done with
READ_ONCE()."

Or we could put __rcu on this pointer, and annotate all the locked
accesses with rcu_dereference_protected(...,
lockdep_is_held(&namespace_lock)), but I guess you'd probably prefer
to not do that?
