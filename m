Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136288;
	b=3awEndJuIl3+81E+DN8JuuPjEEk4pd6gf4rHNrzoakdOV7EQwoPLuRZkuGdmpSWepn/8
	 QhvRE9VlnqKyZfDhUtZb77BzKhgjF3XIfGwCkPy0EzbCvOmgah361zUZgZdaqHW4jMiqF
	 e8UuvP/dWbS7SBBeaNeYKHbPGI8L6Fc580ddR27hD7k2RQq4lIgn8ya3pyKAEcvUF+Pjq
	 WpovOh90JTqKFneiLUwQMKA7aiPJdphtqIVnQBvELgLvyGJxf3zbY39hHM0Dxi7RcZNCB
	 wBCTJbEoJdxaxA5vSYVcbr/fzQOjj2ku+muVKG0IaxEY+Aw6DO7udvGj2UHwHYxFhPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136288;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	b=tYHospvLOhStY4eBjX1u4l7KnbA2bfY59Y4X/yAuLTcJ6wrVTj7g9ZSae+kyfwXSsMOu
	 uvbokUWaAbCrQBPcSU95ojb7igfCRkFehSa6FxJPalGhRmDHdmpMGJUWK+irPf0DRwC/q
	 HlmJaMJWGIL9d13l+XYogceN3sfSC53MbLY2IRy2xbCvP7vaaPud531RZ+q6sKuhn6HeM
	 1p6kta8iMti9MYgYUBYYI3o2cOHEFAo1xDRM5A8uTD0JnGdFFyM5YVPAI1TiiH3GUo+fX
	 0MZ4Lu9a4KZt8K7W91bNTKDh3C0NW7kQXc3YYa8HOEeFkU6ue3+4BhE01Ni+81gSijA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90039606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90039606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-567ac848d83so31079b6e.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 03:11:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794136287; x=1794741087;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=k/hcCaIPKM923T9+ICPXjqpZ604/b6+r087xFgtAVlPYJNDUGeZ8c5R4X83XJqSaVL
         wPJ/s15oYA3GRS55BQpvzZDSaTI2wolAoZUo0uvhvH37x7wiz9UMzQMYIqD6XDbpHr0O
         jRwLQNeI9xL0Fz68UhxdnmNQ5th22BUN/jrvlO/altDJD7gPJ96IxzSqMcc4RVlFfju9
         V5sZh5Xza9VRgo0XurajYSZMI3va4yzV0r8Kq3Q7raJVrOujsGu20W9g+B86mqTSh63t
         oMXT38qKAdOgIN1ohf99cnZZZOasVBIobTwIs6E+HfSiOCR1gNUAbDY7Q5v2qY3dfaBO
         kXHw==
X-Forwarded-Encrypted: i=1; AL+hErEuNELxgPWHjwlGbdQ0l5nkzWoohxlGG+sRy/Bo6aFS1FI7ovAnEDmeWeLRaQwzbqHqLUaLWok=@vger.kernel.org
X-Gm-Message-State: APuU4Z9yCHTFrErmuxA+pxP9J8NHaUGIJ3WlcvsxK2RzPrAZcxqw/ryO
	41tUDu43HPz2Ow85PEB6sRyMD6TYDBJEf+1akyChAGmQDEnH+AxhdhgVWuA7GMolXNRh9Qd+REu
	ApxM8Il5hcY2qBvkfC0CufdA6aDJ/qlZKNqWGISXWnmZb/Bvosw08BsWXlGs=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a0b:b0:567:f6db:8b46 with SMTP id
 5614622812f47-568143a1689mr647675b6e.34.1794136287572; Sun, 08 Nov 2026
 03:11:27 -0800 (PST)
Date: Sun, 08 Nov 2026 03:11:27 -0800
In-Reply-To: <6a6a98ca.86abc875.e5c3d.0057.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af058df.f50b2b3a.2c0de7.0007.GAE@google.com>
Subject: Re: [moderation] KFENCE: use-after-free read in virtqueue_get_buf_ctx
From: syzbot <syzbot+0f659760bac1ecb01812@syzkaller.appspotmail.com>
To: david@kernel.org, eperezma@redhat.com, jasowangio@gmail.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzkaller-upstream-moderation@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	zhaimingbing@cmss.chinamobile.com
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
