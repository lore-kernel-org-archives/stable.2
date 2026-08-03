Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19F403156
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.43.1.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769488; cv=none; b=PnE+BWawdJx1KWfsVd1OVaOEZc/30NqTskBzlsLtLOZaF+HvSd/4aHyhGGrFd1xwrSGi9cIFvTTAdd1VkBkbie6nIGgvXF8StaasENWFsBzLHBBycLpSc7shocN5xecw8xM57SaxUqrAYCUJ6hCnsnWtoYIX1svsZNW5gedVPz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769488; c=relaxed/simple;
	bh=bec7vQNQOVKg0g28IThleZ8LFfU+/ZLXxDRoimvaM/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJFw/V9PWhnmhpuxdegwxp2Z6W2qaexReo0Ufm0uMz8JzJgcvMZw0KOpCN3O1m7l+DIE8YcjewUS3pJ6SwBjkN778/418gJ71xuolMwvsYl3QNciYCI3e94REU/QDtjFgODPDdFGDLQC7GXNTt53iWaPgw01CRXUf0B/2Kz4SVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kde.org; spf=pass smtp.mailfrom=kde.org; dkim=pass (2048-bit key) header.d=kde.org header.i=@kde.org header.b=IJsUVJw5; arc=none smtp.client-ip=46.43.1.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kde.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kde.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kde.org header.i=@kde.org header.b="IJsUVJw5"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(Authenticated sender: zamundaaa)
	by letterbox.kde.org (Postfix) with ESMTPSA id 673ED330A3A
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 16:04:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
	t=1785769485; bh=bec7vQNQOVKg0g28IThleZ8LFfU+/ZLXxDRoimvaM/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IJsUVJw5E4911zpmz2XaKpPLyI/gNaxtcbenEqB6B5by+yut2fsC38cX4Kn4m4Uax
	 turaoc4WJOqUTg/anazRhyxUTaKNTjEWd/f3I/UK5tJ9SNXkuZImCBncLH++3fVIzj
	 OdpbQHmJ1VfAA2mw7gjo/PzLRRNuKPn0qb3pQ88qfyb5AItWxRYp0Pq7FU5uDNrugH
	 ot8GyI5bbn5i0W4kV9I8hAz9vHGi3iVMMewVHjd5rAU3WkyWAdfSoy6p0Ysn7kwnR/
	 nZUq6VNTifKBe4xEYEfrrjJeUc2sc8amxXB1hkxBnFwpA4iLJa0kdOGxhlHVS+smfp
	 EA7rezr4TrZgQ==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e99ef0902so174378385a.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 08:04:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro9ZiWF/rA8s7H2HunInc2xykW719EJWh01EFr8XkHs7ULuN19Uehnad7FuX9fOVeM4b67mOf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjlWp5ub8OAEDQ3ElqApn9h2KExnLI1jwXwDXk2m3wEcPdGAOv
	QmYaBAxMlPDKeB4fqDUawGzbFJ4Y+r45tGthtw6KeXmfblAZ4jjtm1e5Lzosifqk1WFlsI9o17d
	PT9oFtWniUGIs1+flk2cDS2xDQ3zOir0=
X-Received: by 2002:a05:620a:a509:b0:92a:dcf5:ba5b with SMTP id
 af79cd13be357-934a078ec66mr1874803285a.14.1785769484157; Mon, 03 Aug 2026
 08:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803144120.11524-1-xaver.hugl@kde.org> <2353697f-b1da-495a-b043-7a81d875856e@collabora.com>
In-Reply-To: <2353697f-b1da-495a-b043-7a81d875856e@collabora.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Mon, 3 Aug 2026 17:04:33 +0200
X-Gmail-Original-Message-ID: <CAFZQkGyfDwjPuciiOvZM3Ha8Xj+YkgkMaveHZtBK2w_S+Z+Vcw@mail.gmail.com>
X-Gm-Features: AUfX_mw8sK2V6GPnRFO7u88fP9ZT8Klne3x4kZYGrMC-8pF3piipOttVIK9wP9k
Message-ID: <CAFZQkGyfDwjPuciiOvZM3Ha8Xj+YkgkMaveHZtBK2w_S+Z+Vcw@mail.gmail.com>
Subject: Re: [PATCH] udmabuf: vastly increase the size limit per dmabuf
To: Robert Mader <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org, 
	kraxel@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Oh, nice! I should've checked the list before making a patch :D

Could your commit also be backported to stable? I fear I'll need to
find ways to work around this or disable the relevant optimizations in
KWin on older kernels either way, but it would be great if that could
at least be a very temporary problem.

- Xaver
