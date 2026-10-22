Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689606;
	b=wpjLp0oQEGkf8waigEJIcRlSB47GRjzrjxzDgRkLXTwQycOD6h6ll5ePa0l9sx/sClbR
	 kRSKRYMFzxCMRtbWBRbwGwff5YpJBAEziEID5drR+AFUi5E3JCmousRjhwSqwZ4iih3fm
	 7Y1wsl+0wPrQYpAH3cpRs+vx17G9faabtR/XryoHni8ig1fdJa84TCKXT28iFp+DA12Yc
	 nTDuSi1gYOksV/GT6hv+yp7/WfdcjE2rCz5Za8bh7VZiIHxXtofRkaraipRW7RLDMei0O
	 9GfWSHyi03ZFaNeHgngBiFEsxa3HYz69cMiaVNMVY5SQvnpMoXrgktHKaC0fmV1bUwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689606;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=4UT4wBei7lo5P9ke+g//ajLXiPvxYYsQ7T5yHwgF27o=;
	b=kVrDFDgugtJX5HyuzwzDhtFv+J0tLM0lNRuNdG/NW3N8H1SWRrkqH1R74yyoo7ViBMsg
	 frgHJH5NYP+CTVKPdobBrRlVI0ZHjx4vKlHtXPpYYPg2+u2ibA5Tizz35Tlud26BuZPdN
	 6koACvfv1u1BBLdxF8btXdeMefZiBZIIHgesbGaNDtI4RhZFCbC/vMDCwWZkbmGnpvUAI
	 or8UHlqrcl9t0tLq1xdGFxgwC9gUsuFpRgmegNWsh+qqUnLYU04KfbK94fCUqUdzkJISK
	 7IdT75bjIc9694VXMkTIn1ATLYUv27j2rWqhO62EpNB6IeWxcM3Poa7KK8OUVFh7toA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1E3606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A1E3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-5587351d419so101007b6e.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 10:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792689605; x=1793294405;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4UT4wBei7lo5P9ke+g//ajLXiPvxYYsQ7T5yHwgF27o=;
        b=y9+ERW8A0NUKqjttokdSPhzgDgk+FxCNNqvMCObQZiNFbsc8IPbWJzNDmFl/M4P/Wl
         AQX3jMjnCsD9+22Ysigswkw7aWR3gGnI7NamDiJWv2GKBc6wVbU5pbBbeZAsZjAPjQuv
         NdMj4JJAZttI7FPRjzJ0G5ilk2NVV92gt8Jw7kgjsn7p5xUZwXUB/5PVl3w4xAu51u/A
         iWtzFmy9eCFY31bMLr2KjzUul/a++8TfvRFlv3Wu3GiVJ5BzGSVIDTSrwo1gY4x8XtY/
         9ax93TplG+NSMDbTp2s6Q3SZH/IJNSfoUK48y7cLDeA+BQhsqn83oF2/4hkZW3fAWgUp
         +Ltw==
X-Forwarded-Encrypted: i=1; AKwUvBz7aLs7huzfDMbFDnDyVi+1P3BqgCyCKiMFrUgl7wN0cnR9yXQ0UCzoFCY12WXnTnrS368Nm1s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTR5jzJuMOe3RwtpJXFoCr6XeHxiFTh1BBXUETar2xSucgCRl+
	Zjnpaohp3jzMKfWgKW+6BkDwfZ0ifsvA7ysyfJggF5CLnthfG3K33KS1+qHW252/a25AUxhjG5O
	pm252E4K3m9C/Razy3a8HwFK/IgDno7csa/24gKt5qeiDNL0wu90XipRPIzI=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fe1:b0:4f2:f229:1895 with SMTP id
 5614622812f47-5535c2846ddmr5380130b6e.43.1792689605345; Thu, 22 Oct 2026
 10:20:05 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:20:05 -0700
In-Reply-To: <CAO+rqLgLRszT2U_x49hYVULuJ6Lm-80EdokzQUyNO_mECKEvKA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ada45c5.d1c214cc.659fa.00dd.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in nf_flow_table_extend_ct_timeout
From: syzbot <syzbot+521f7e7e2b974abde99a@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	edumazet@kernel.org, fw@strlen.de, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mike.michalo@gmail.com, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	phil@nwl.cc, stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/main: failed to run ["git" "-c" "core.hooksPath=/dev/null" "fetch" "--force" "675adff2843877c2da27b36b2517f827bc9915ea" "main"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4b098695335c89f
dashboard link: https://syzkaller.appspot.com/bug?extid=521f7e7e2b974abde99a
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115f4d0d580000

