Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD52E7165
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785652743; cv=none; b=TyzIEzGDuIhnU6V6AO5jYBU6OBZW0Kk3RRaoJxpkzPSSXxK8LmSH5V/61TSVGGXSboov3xnx8up02EVZOTjwg4P7GBrtEaV6zHswiezTIwl1VZk2vZjCzeIkqXeJ9Bw7xB5jpLhw0EKmkGE/bnvRIzxyrYWdMJkMj3rH1wdbW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785652743; c=relaxed/simple;
	bh=+yUEQZanHC4u8Y4BXuNw3mU3ZCQ6yVkUgMer/B5Dwr0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fm3Vk3SNcCBvYp9LMC6qAxpM3Jo8R0ut6UVX5mq+4sY3v4To/3tSDKBGCeRf6OCijt4x8Q+YuRR9dgWkr+lxR49EhmjLA8lFHgjOq/+6Ce7kDyK7drzSSOZ4TBVw6Mh5e66D6rdNjbgFY64fv4d9FeSCdd1PxlxDD8mI87qiByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7eb60cfd476so1439031a34.3
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 23:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785652741; x=1786257541;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=74XbBtY7ExvSSPq3hf+QUk59lMz3b3X/8wvUXGrjgv4=;
        b=F/2ToCAUr9QhC9R7FAPRfUntR7DQc3pq020+f2E3cOA6igPLYiq5N3R3NX0mvQfa2g
         chZn454OeUgJb0aFIS/w16i8q2UeTBZg0qS5j031dMBbLjoc9umwt1i8ZEprNgK8LO72
         Cu+a5f/96tJ1Nm0CIgHd0Jmy0eWrA8jiU4zoZ7Ik0y5lGWSmpJl39u5aO7zR90+Qx1Hb
         zEax+w7e/QqhhDdFWI+TblUXfyR1hoc5EeFiGxLL8u2foERfze6XuQs7chv59A225k3g
         rFJoSsmr/OaL4gxVmqvhjLefZ1kQfhPkzhRw2qe9HolWutpej/EU1SqZxQgWMJJrxS4X
         5W9g==
X-Forwarded-Encrypted: i=1; AHgh+RoigfH5PUL2KykXQRhEajNRp96yk2ejIglklN59ItZdmvecSzc2RcWZBgB/B1Qv2ZpsAG6oVWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCLIBynM6JoqiN8hEFMcw3bNpR2IvYUSKtiD81t/wsaWa0d1c
	REkCWngImQDNrO5DXHME0K92iNWYtDA8k0OzdqmpH4HitlPdhUZkCVwpuUdP9sS6XqyDhDxqf6M
	5X7UAQO47SKbyCkg8urIz7oiBWu17bLfCnZPi1noIsbB0L0aDPBMLktilAQ0=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1484:b0:48a:ddd4:d36f with SMTP id
 5614622812f47-4af5e0c2e55mr9970356b6e.8.1785652741472; Sat, 01 Aug 2026
 23:39:01 -0700 (PDT)
Date: Sat, 01 Aug 2026 23:39:01 -0700
In-Reply-To: <20260802053214.3266477-1-matthias.goergens@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6ee605.2d659fcc.1d46f5.01d1.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] INFO: task hung in do_rmdir (7)
From: syzbot <syzbot+e68dbebd9617a9250e8d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, matthias.goergens@gmail.com, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e68dbebd9617a9250e8d@syzkaller.appspotmail.com
Tested-by: syzbot+e68dbebd9617a9250e8d@syzkaller.appspotmail.com

Tested on:

commit:         2d2338c9 Merge tag 'i2c-fixes-7.2-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104f2db9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=880a7ff8439764c8
dashboard link: https://syzkaller.appspot.com/bug?extid=e68dbebd9617a9250e8d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=175b2db9580000

Note: testing is done by a robot and is best-effort only.
