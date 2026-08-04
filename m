Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEA4377004
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.43.1.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846491; cv=none; b=ltxlQM6yw0vODJRm2+/lfSaKHjkifu4o49GTH+UTRjbvULKLjOEOVOdmwjm4Uy7AtShNndgoBPL9Dfp6lX5CWi51ZunHrsasewZZGtj3t85f4qvLylYZ52977Nw1S3h+oGUTfHIKi4EaOaXLWrhPgpgNnpVxW+khmyO+41SWKag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846491; c=relaxed/simple;
	bh=DTKgAiDAoqWybX/1QUJfHY1C1iV1Yvx0fh8FqJ9VSw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svNa3vYYRqJYoqLWN/YX6Anr36qKf6SmuSXmWxaNhyWgCpDFSPRvWNCDncUmWu53XuY/f07Ox3KmJ2Z4FB9unFC6VM7Sq0sRCP70vbr9rqROlhpR8mk7zR09e5tkXhzHyC7k8MYYSLFfPry3e+szK1l8jhHlaZKCbweblNRyonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kde.org; spf=pass smtp.mailfrom=kde.org; dkim=pass (2048-bit key) header.d=kde.org header.i=@kde.org header.b=GduH9CIL; arc=none smtp.client-ip=46.43.1.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kde.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kde.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kde.org header.i=@kde.org header.b="GduH9CIL"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(Authenticated sender: zamundaaa)
	by letterbox.kde.org (Postfix) with ESMTPSA id 4214D330AC0
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 13:28:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
	t=1785846487; bh=DTKgAiDAoqWybX/1QUJfHY1C1iV1Yvx0fh8FqJ9VSw0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GduH9CILW5fEFtpzvRm0IyhSLw/jN6zFcQFYDnCVwAlh7iJmW0mfEDrIe0SDMX4Yv
	 WZ6tVhwM3Di2Qjpgma+OrHunaoIDQ3VU7dMLjZfDuei22uaDBvODAEvDAM977G4j3e
	 C5JQs58f+gfZQj/6WcHwJPFckYgr6QH7U0EOFyVrXUdC5Cg12zTiUbWjhVug7uVTff
	 1L9SXvrYVGk5KnzvHkdz9eO1MGiWCtBjz5XDI2mczyhdEtJ9vMmR3ZfnHu/E6XyrPc
	 meVOhQkJZIFKGaUA/1tIy87dhpDZ98+P4E75TFWrkNxsjAddWBRg7w+bBj2nNj8EL6
	 MiB5zGxaAkAzQ==
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51e4ba1cfb4so26486441cf.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 05:28:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoXCPgHI2LVIwWfH8KVIK1X8skCTCITrh/5RYT1qHdCHhDUgRLSAsB3e+CjXY5Iot3l/W0EleQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1WkAYAci23MVY7d2HQO2NYfZAB/TxOxfHxoe3Jq1k/i3ItapH
	J5Xl2PIo4Sko6CXIZFRNHIFfgy8zSXPKrqnO9JHrhIYjiqewnRJb3LSTlFlfm1RBB0IR3qj1RGB
	7iOqVahLqbpJkx0kaoloqiPLzcJ8HrSE=
X-Received: by 2002:a05:622a:229c:b0:51b:9873:e379 with SMTP id
 d75a77b69052e-52b56796913mr269348581cf.36.1785846486036; Tue, 04 Aug 2026
 05:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803144120.11524-1-xaver.hugl@kde.org> <2353697f-b1da-495a-b043-7a81d875856e@collabora.com>
 <CAFZQkGyfDwjPuciiOvZM3Ha8Xj+YkgkMaveHZtBK2w_S+Z+Vcw@mail.gmail.com> <c6c0e544-5a19-4ca1-b113-c085bab0c967@collabora.com>
In-Reply-To: <c6c0e544-5a19-4ca1-b113-c085bab0c967@collabora.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Tue, 4 Aug 2026 14:27:54 +0200
X-Gmail-Original-Message-ID: <CAFZQkGztAGqKUuYarQGOcKnoGq-1CAxqXTTjLWZ0SqJZtkpOXQ@mail.gmail.com>
X-Gm-Features: AUfX_mzCRJgqh4Y8EZERLOI0LGWIwkCaQyXiFvRk2SJ8v-VgLOGEjAX-EZkppKU
Message-ID: <CAFZQkGztAGqKUuYarQGOcKnoGq-1CAxqXTTjLWZ0SqJZtkpOXQ@mail.gmail.com>
Subject: Re: [PATCH] udmabuf: vastly increase the size limit per dmabuf
To: Robert Mader <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org, 
	kraxel@redhat.com, stable@vger.kernel.org, vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"

Am Di., 4. Aug. 2026 um 09:04 Uhr schrieb Robert Mader
<robert.mader@collabora.com>:
> 1. affected distros could backport the patch or set a higher limit via
> kernel command line
Yeah, I'll put it in our packaging recommendations for KWin.

> Arguably having a working fallback path were possible would be good
> style either way - would it be a big effort to do so in kwin?
For multi-gpu copies, it's not too bad, and I already implemented that
part. For software rendering it would be rather annoying, but it's
arguably a very unlikely edge case that would be terribly slow at
these resolutions either way.
So it'll probably be fine.

Thanks,
- Xaver
