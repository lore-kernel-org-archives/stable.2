Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF528E0F
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786500306; cv=none; b=P3r+gwVnU9NGD6+HyXJeOjs8Wv+FEfkF60Pb95qvnpFlDgbbkqpZPm/1sIi+1d209fb2QQ3yvyNxEiHzBMVcAxLJAsbGfI0moXQz3snNBpDqzWSuCscGtmyoPSLWlJmm9oEKNYRDGb5yvWq1j07AkRulu0UHvuYvXFeDxOJvBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786500306; c=relaxed/simple;
	bh=l53+bCK+s3XfLKQLI4D7AwncT2lDR0DUaWKL9AA4f/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=G5SvctlncOUKRVqjq46Np1eTScXwBImfHatXK7ihvo5BEGV378OomUoStGSAylUx8aEIuTL+W7zy+DICjDRz85ptg1/TcttFwEwv+hmf0h0eHm7JmuP8sc7r1I5/ibkjbpCU9whbc+Xav8nKtTB8RS3Fa5O79T5j2RoCHfTvy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-451d8064053so540935fac.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 19:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786500303; x=1787105103;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s9evbO2I7ciUf/cL+zjOgrgUssIXIiXh1znAt6bzrcI=;
        b=RofcTkI8zvI92BkbYmbGc/STd6jLAnlKg0zi094JPVAywTHWVocRsieuayjBHg1NLS
         HouxtFuiAEgNBGPx85sED+JsA2jyOqrLG8pCUZEqikmkyag7B5SasCLxG9KnEeJjLNKX
         O+cr44psxcu1Tuj5UC4WfaCV8mu21Aplz5MWM3Nk32GNnQVKWOPQqTh4B4r1GgPJnZjG
         KPgq0yuAcU6GZOpkjNSiqp9BIthhbA9VjCsCu+82sIXDdqE+uKSUExhh3htOouub17Cp
         6qP6rahn4wjYs36SSZ1ISCohvPNYdSe9kbI4eBNd3DZJARagPx4JG6Wc7MQzuUWxjTtM
         GAIA==
X-Forwarded-Encrypted: i=1; AHgh+Rrcj6KY0Scf7EojsOjwNjwaBJFqiWuo2m8xrTBS0NxcdBZpaCjPsQGG53apQ4rQ0SwbKRVB37g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFB/Fge1GtdhgUBVsmoNPdL4qF54NHL4jrnuUEIMFgvDMvy659
	ktEqK9aSB84izoy7q8lJQIC9O42Mam7Y5tsINY+qV38fwEsEpyKpD+AHo8AYul+FbyNNNdqRA2q
	c4UzwG5k/0yEE8D2XvU2P2sVXB0JxJjFydlpuHNbW8QP2x8jOXRjvVlrWv3o=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1305:b0:48c:4c00:596a with SMTP id
 5614622812f47-4b21096f219mr1771757b6e.5.1786500303527; Tue, 11 Aug 2026
 19:05:03 -0700 (PDT)
Date: Tue, 11 Aug 2026 19:05:03 -0700
In-Reply-To: <48230456575d27aa83ce8640de8fc07cc62e8efb.1786498693.git.xiaopei01@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7bd4cf.d5f0ebe7.22d851.0005.GAE@google.com>
Subject: Re: [syzbot] [mtd?] divide error in block2mtd_setup2
From: syzbot <syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com>
To: joern@barelysecure.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com
Tested-by: syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com

Tested on:

commit:         f5bbbfec Merge tag 'probes-fixes-v7.2-rc7' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1336f879580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=b320a4d5f65a61dbbf89
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13241479580000

Note: testing is done by a robot and is best-effort only.
