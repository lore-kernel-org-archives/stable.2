Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29B3D75C7
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.43.1.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769270; cv=none; b=ZSC38xirJ0adshJxrbKb9T9+cV2HweOaaxFezdSUEcRXQeT8Uzxmqx0pgoXaopxwsfVyw6QT5gruSDwGssRt/FzbjhcufqxKzpJgu05GQSFWKzGSlPZ8RfVGE0ZWXvWCg194wgotEyld53SyN/QWnK9Msd4/nsW8dAq+vsU6IE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769270; c=relaxed/simple;
	bh=a0BkesiziiTiBP2wivGnpMcRxQH5E8eTrQYCjzGrwl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q370aLhApDyctvxS7D2g47A2flZLz5bm6XdqK7+VBDDE9QAtMn0v1O29374goWXEotwUE56yZMFCABx2lnBSR0rUeAzHOuXhQafI8Nd2T5CWbRqzFmYnYZbZEbk1bmRw7S4w/HyUFKqn3IFwfRW7qYqNCtSiTIa6Axtg5Y6J/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kde.org; spf=pass smtp.mailfrom=kde.org; dkim=pass (2048-bit key) header.d=kde.org header.i=@kde.org header.b=hSYVrWZY; arc=none smtp.client-ip=46.43.1.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kde.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kde.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kde.org header.i=@kde.org header.b="hSYVrWZY"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(Authenticated sender: zamundaaa)
	by letterbox.kde.org (Postfix) with ESMTPSA id B7B7332E4C8
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 15:54:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
	t=1785768863; bh=a0BkesiziiTiBP2wivGnpMcRxQH5E8eTrQYCjzGrwl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hSYVrWZYDGy6zfzVuyIoOsbGwVXvDEYbLPs2ZjgGF4EJGaQZkoZIMwIdJYhj2geLx
	 uwlLoXGC1bhioQ/XFcLBhFjO+Q8Zkcomi5NsKw+WoWR2ddUMF+UAnjtAOUKCFWrnGK
	 suRByerIq9B9Ak+iDcRVp02Fk0IRN51hq4JwUXJmwYgGNtMm6jmESGtoiy4omKn1xK
	 baw7gVXwoutJFPbfIcCMeFsGytYDZcroPQNuf8FeFbQlxm1KUYgPjfzuO1sFpISQaL
	 cvYC+2hVaGKlZdeXWxt+leq3J4on3saKAcbDH6ql5MjPChKaq/or9YVWzWBYPOfbtO
	 OCpaOp0AOG50Q==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8efcef23d21so21534766d6.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:54:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqD280SJ/fqyTvbTd+K+D2QD30rkpUIwMkY3lJ0Nb5lQaNoakwZVHGC7lki5ewdnlWTHDUM5BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHik0CgHbsfRGDyHI+gWZfmMCO+0E/js3YYKsNab5XSYujAaQ
	3kuTG01Z1zc3D17IVcn7/PfgYMJmszxP1zEY6roA9nYGlggCCsG1m4lbHONs5zbGfdDIKufz8ey
	G5EshDrvhhgf5FXJVVe4Ec6fNoMrVct4=
X-Received: by 2002:a05:6214:528c:b0:906:7fea:354 with SMTP id
 6a1803df08f44-90849633cc4mr243324816d6.18.1785768862617; Mon, 03 Aug 2026
 07:54:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803144120.11524-1-xaver.hugl@kde.org>
In-Reply-To: <20260803144120.11524-1-xaver.hugl@kde.org>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Mon, 3 Aug 2026 16:54:11 +0200
X-Gmail-Original-Message-ID: <CAFZQkGytEnCmA=7-7KYt5y7g-TcEK3yAthX5wG=A8QZpEyUOzA@mail.gmail.com>
X-Gm-Features: AUfX_mxSqXRXC109RVODPTknMe_SuFnrXMSJd54k3fE4Fw3j1Cula-_7HFxPK4s
Message-ID: <CAFZQkGytEnCmA=7-7KYt5y7g-TcEK3yAthX5wG=A8QZpEyUOzA@mail.gmail.com>
Subject: Re: [PATCH] udmabuf: vastly increase the size limit per dmabuf
To: dri-devel@lists.freedesktop.org
Cc: wayland-devel@lists.freedesktop.org, kraxel@redhat.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There's also the question if the limit is needed at all, the commit
that added it didn't explain why it was added in the first place.
Could we remove it entirely? I don't know if that's feasible for
backporting though, since it would remove a module parameter.

- Xaver
