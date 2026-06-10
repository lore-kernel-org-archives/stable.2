Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3D4279E2
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107264; cv=pass; b=mNY7mtFtxF75P+imDjjI0Cz+fTN6qLIX1WDbFVXSoNk05B1lpZfzhHChf4wGar/hL0ZIJjEs7LlC5vp2A9rW18D5OyTZ7h6N2JKe+Af0EbRYZP9VXYWTar+T53jBR00i+igg06z9v1VkMS5FxX+U/iol75cYxwi/IbLXdE6P+WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107264; c=relaxed/simple;
	bh=bB3xA/MHCU+PelFiFJxUbLWzHMG3lJQds9/bzXf05H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plGnXbpJa9u7n4RDoCeOAA6Gn95RVocmQrRkfHuyETAkuiFtCT4ff5GPvU4KIcoLv8EntVO2v7tYUVLbVcOK4js8iQ3JcaeLyAvDR2lpJgAYkFNzTfOLQLaPXL5XFYums1uZX9wZGAhdU1tqJEFWUpg/NjPuWBfj8zJhw9dh54k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbAuxWGe; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbAuxWGe"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6605469c263so928827d50.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 09:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781107262; cv=none;
        d=google.com; s=arc-20240605;
        b=iKwTrD6gxAUCaYKp8cDrQP8Rz7VrNX6JjnbHXWisFIfO4Y9EFe+gUr/fGWmaeAVNbY
         GSFu5nFZMCW2CsYE9UWihGsbpNO4+uOMtwqqzGfC9VCkNmZ0QINyXyq98wKcJaQqWqeq
         dbT4fgukdnrTNAJo7goO5tOKti5SWWRLoKY8jnX6BIUYmV1FR2tcjnZvFq82AK+Iq5M/
         HUFvRT2o7WD2eDRGlUo82GDspYEenK8Ujb3BtuqDS46TioPVCgcB0cSsk8pgnrWV1X8U
         JiLFKyC7x8JIq8y4WL9A34RBJLPfInh6UCvlob+1DuQhXQY39goVvflzar9RNd5ewAL5
         FZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bB3xA/MHCU+PelFiFJxUbLWzHMG3lJQds9/bzXf05H8=;
        fh=cm1oQJLYbSeeJ8KHoEOLcUpVW18rGfYfn7D/mtX7e/g=;
        b=iBEjAtqnGN6suHxMbfehgMnxlBxIUuc9qcumdL68qFZRpkXA+Cys005Rca/CpW/Zty
         mecn1m6smG6tdLU/Av42xwauEdX6mcSJnKWlWAQHYcR90u5OlZbli7bSBKZ5WQkZe66c
         K5in9iMaLUwiSe/PKcOnZ+VIclE2paB6kRrIdv8Z+lKjYe7jpTiP8lF0XvLfR/VcaTRg
         1CMd21LGlOgCBqsvDaKH4HaLTSX9GFIRQtjRy5xJACkZS5lwOtK+AWKYmhbXCzlam27T
         IajPQld1VpyMXP6KbW5yZm2UBmr0TDMei3Ksz6MzLiN/EiJJqcj+O/3Fxhr9F92sdEjF
         e/MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781107262; x=1781712062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bB3xA/MHCU+PelFiFJxUbLWzHMG3lJQds9/bzXf05H8=;
        b=kbAuxWGe9/dPu6qrO+Hu6OeB2T2dq9c7MjxAfqqkcPcsxCd626AgKzF6gW7ph20y8G
         o/REV0c9X65VUBAx2abwj2QaZkxWhQpREgjbCuWqqtCFF6YahWTEP+nEBl3Nr8gAxf4r
         c+fv7GIYeNs3cn0Bj5lCh/xgaDwFBil7tJfu5fepC3eJVJZNK4XVbdZFSAXITwMi1p1g
         lKseXQqOEcbHnUddwA4C0mGEZera4mLGimwwDBBydivQS1u6cXIHxBvuRlgoyzjMMp4O
         9O+j2tCZyBn9O7rTi/Mi9QLal8pw6f8ZBl5OGZBFdzg1mbEh4J2u5STA3nqA8AbBhbSZ
         qMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781107262; x=1781712062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bB3xA/MHCU+PelFiFJxUbLWzHMG3lJQds9/bzXf05H8=;
        b=a9suQ2LaojprKo/Phv6hv8f5AU0UDYL7qa854rFDBmReIViJZ/HTCeEXfofQikD4R8
         LxsUoZuqQlyVEJb5cqis2Ecbi2niU12J8AsDA796CeRUSQD3B+iW43ln0ehMxOVUxU7v
         XzufHC95w7TshvmZtYcJARLKw4Cjc3pWpqBcXjOrOuo4+WhU6MwnYRvOy4Ot2rn8FV0k
         S/+UKtgEijd4zpmg5QvdTmNfvTqI0kP6LWl/fHl36oYZOG2SzsVcmjwze5RbRytswQDY
         ISVUMkibJ2whPBynA3hciFL+Osq8dpT9nugrOTxYc80f/ef1M5kSrBFvBHTKm9y9Z8pW
         QXNg==
X-Forwarded-Encrypted: i=1; AFNElJ9d+ei8WIBR/MoHHQw4+aY//m2z34EDEPk5nkyHJmJqUTvXuWJzZpdfHA5vzOXvd3XrO1G5pJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2JJCTJEoU2JtZeJMsXPEzAoAB2LrUP8RmgbqVxDksqWDukozd
	H6RiGQBBOcJ2jBQO5GSnt/imiZYGjBJ1F3z+klq9L7AKbCRZLYpSphd9DGoZBz1Urp0T+AQuo6s
	+HYZcAgX4lpfg3p3Au5AyBXL4yjb1g8M=
X-Gm-Gg: Acq92OEGfudYzjWASWyYwBP4OJbsJo0ReoduBE6cDXkGHrA174EaHqhSpmrst19UxGi
	nNSLq0jDlBYPY8hzbcQJnxz+JEvG9fFqVpsmPjVV3057PUPdnKE9ykd49l1Ac2rvB4GA9uKNAVz
	Tx5Z9C1V5pMOJMgISl162HMutxGKaDbhKylVtLKOz3abOkMIQ/mFykv6ocBxwHdU7D9jMazdyHy
	jsuYWr9lIXYFIgCj/AVnl5KKtH0iruKNtkDp6+/BmuH3qhF3ZgCS1GNRGvMxdDG3NdUe/rqnopy
	qBzd3hdanjUwYwQDEu9jUB4MjoYf3s/cmyRJ+BmFauKyLzc=
X-Received: by 2002:a53:d845:0:b0:660:56ee:ec03 with SMTP id
 956f58d0204a3-66106e5b480mr18896264d50.21.1781107261714; Wed, 10 Jun 2026
 09:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610114206.3749904-1-michael.bommarito@gmail.com> <1962500.CQOukoFCf9@weasel>
In-Reply-To: <1962500.CQOukoFCf9@weasel>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 10 Jun 2026 12:00:50 -0400
X-Gm-Features: AVVi8CfE6Z8Gd2v7H8nISX8O4sfO8iVy30cFRa5xdFkX4tgN_Vkz1s3oigsZeEA
Message-ID: <CAJJ9bXz=01tvoUTF8cQ6rUiCbsyYQbGKTcXD7LwJSwBu6y=unw@mail.gmail.com>
Subject: Re: [PATCH] 9p/trans_virtio: bound mount_tag show copy to one page
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:46=E2=80=AFAM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
> I would say no, a 64k tag is at least suspicious, if not even hostile.
>
> Therefore: what about simply rejecting the device at probe time if its ta=
g is
> beyond a certain length?

I think that's much cleaner if the user base really can't think of any
legitimate purpose here (or in userspace utils).

FWIW, on a similar Xen issue, we're also talking about blacklisting,
which is one step even further.

Thanks,
Mike
