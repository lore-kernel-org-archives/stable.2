Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4780F41835E
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420904; cv=none; b=OwFaYg0y5TOgpNAeaNWoPAzrP+Pnk7wPMos4xBuqBGmxVllJAZc/Om3GvFD1Dkj7VZdjp7y3DGFUlC4Qhni6OFXK2hluQsQRBgwoBLtxnWM8ChD1NSxFI2jcf+gL+DTFAKcUUpLbO95sqx3c7fzDAdu9OUfXvFGHMaIQMZvpU98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420904; c=relaxed/simple;
	bh=PkxrvKzvWb3F1SkAOototNbsWKeC9WjvFW1F0e4iRFs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c7NYFRE7msYl4UqJ61N0T2ou+e5B4E8cwbRcdZq54ZRQQ0Oohvl7pqmzPQLWii5UaS1vXRaxvrO8fE8+jpDWxaC1pfbusDTlGq4pQXGs2/AcwI21a5RgT4KKRQ5twBvj+ieP1Ue5rRT22HKc8/JdX0qeKYdgCGs6CkSTJBUCG4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6b13266fab6so1820701eaf.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 00:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788420902; x=1789025702;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NLoKDNgFkZljVKf80yy0HoTFlUo9qExOXyKkyCU30a4=;
        b=SSpLp5lqu1SA8ctUzh65dM772IEnLfzYPQfr45wEyro4KuDaajPwlPM+3OW7eNyb4T
         AhNxEGdtSjClkrzc9FymKb1COBXAXrFZgzosjf21L1cMhJJGwvkib32VOqBd6AAZWSOV
         tusKn7JgOpXsT38oqIpjGN1Ea3am/M+lkZshsPAHIfVEKLYld2mMqlP8Hoe9OiK8PCVq
         wSOrUldfcyOv2e9fe293LFUm5N2hrH1tUPaAorNlbgebiLovgjtry/Njj4YtAmYQxzdd
         oqRH6TAGv83akDmjAtEsVEWb6AE5zyVPkV50xQyqyHYjH+Z8VYMQ3E/HHiAjx8CLcuHm
         HNVw==
X-Forwarded-Encrypted: i=1; AKwUvByw4h6kYpovcjbyuTlM5LF/91SUUblQp3qrQi21aOLWdRCd9XIFXqa895uSo+cEcnksKCBL4gY=@vger.kernel.org
X-Gm-Message-State: AFuF++mdvcQB99bwEvl2p1FKijMh1J4jUxZI/mm+DkweoRpDMS+aXaT+
	BWh1l1CuHP9b90x7ETFkh/p3/SqXyQBA9ZFXfdUVYuzX81opy+l5Yvl6M6vMgzdDVVSfepnbtqC
	cBYn/4rWQd5E4lnC9r4b9GIUwMuTNoh9b0WFl1zfxos+UuFXZNtpaWzGoxzY=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:212:b0:6b1:7798:a80e with SMTP id
 006d021491bc7-6b47ecca7f2mr8356531eaf.6.1788420902197; Thu, 03 Sep 2026
 00:35:02 -0700 (PDT)
Date: Thu, 03 Sep 2026 00:35:02 -0700
In-Reply-To: <20260902185451.5ba1a829a15bb2799d121bd1@linux-foundation.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a992326.e7659fcc.146146.0005.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in vma_set_pgoff
From: syzbot <syzbot+f12658786a4153df5113@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jannh@google.com, kunwu.chan@gmail.com, 
	kunwu.chan@linux.dev, liam@infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lixinhai.lxh@gmail.com, ljs@kernel.org, pfalcato@suse.de, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, vbabka@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com
Tested-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com

Tested on:

commit:         940de590 Merge tag 'hardening-v7.3-rc2' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147d1f79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=f12658786a4153df5113
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: i386
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b190f9580000

Note: testing is done by a robot and is best-effort only.
