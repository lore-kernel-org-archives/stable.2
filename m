Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159223F99F5
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948905; cv=none; b=p6kgtV0x/WvODfNlr3rZvtSEOXAZpVSn1j8OlTdTrocjPhnTQdYBhDuLG652J444GLNyUCO8m6dTiX2yOCpITEEosmGjHzLu88fPlriIUeOerSIlrr7mde5Y31oLz4ls75TKQAmj9aXdo8ETsFSdfuWw+tvAj5tzKl2MJmEPyK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948905; c=relaxed/simple;
	bh=B44bV+HvNgz6vB9ZQr9ZCQ6zTs/lKADvcyiz2NMnIVw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mmtJK91tt33LsXYgABmrVhbNAMGme0SfD0gKsVS7JaCJvSQUVQm8ofKc/tanOt4Q+IRNn/N8jpUa+5MFxFZC+5ETX0J+N4uRX/XoeQjxyjVU83PQk70Q4v0qF8gR7SG5J8CcUV/yuBpN7rwYGg2oY4H9Z4FHtk1+qU1Jek+tbwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7ec6685adabso1745752a34.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 09:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785948903; x=1786553703;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y61IaF9Dfcz9/Q7k3HexQBdIGHRYMPT3uPOSCJoKxm4=;
        b=SHNdc24n2+qtUW10PnySS7yi/JX16UzfK1kDqlYkZQQNu2wYkor2pl+gObnLSEPuPX
         T/irnSV4YuJyiqY3PiKBVLGZ2bMFJjr30/jVTdDzk9P+Hqd8tg9TTkBSdGOOLXiBwrz8
         A9jX2KATTWR1mvk5Ce1HzjFjCFN5HrDAhvGt0ho9K2me3VTN/UIzs/EIGT+DnqCrhD9Y
         +y0CKfJxz0Rl9kHJkyV9FG38l+cz5qUlt14ijRyPZi1h56I1/bBeiaOdBtPa4qWc9ylf
         JENl+iTKV/jrbAJf2VEMI3OL+Ayp9549sB6LhByzDABRikA54iqYydvdaEQiyPRcalTi
         vp1w==
X-Forwarded-Encrypted: i=1; AHgh+Rpb2uWd7RzNa5twsr6etA+45b8CuRSsbh79QENltQud+lBXlI0PN9c1NXci3cJo9I8qwwvHgE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXgnEMCSlgb/yI9GaIdiR9N6t4HLVaXWJmkMQ53vZSxdarXZGi
	DIwMUjSPVd/Uh75tPQuh0kMlBUJ82RgimCNiiTDcgDhL2xoWmWKmwtOxJQPL68Nz8ouHsLrE6+1
	iuOfZEsitp3r7jLT4nRH9B0U7bAlna5IVGPkuNWlw44tT9gxCo8C1fAlFKJc=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b8b:b0:6ac:b07c:b34b with SMTP id
 006d021491bc7-6ae96c126femr4277608eaf.4.1785948902930; Wed, 05 Aug 2026
 09:55:02 -0700 (PDT)
Date: Wed, 05 Aug 2026 09:55:02 -0700
In-Reply-To: <faea706ef539a1a2d8620d97c59fd403155987e9.camel@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a736ae6.5aa550b3.77424.00c7.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [kvm-x86?] KASAN: use-after-free Read in kvm_xen_shared_info_init
From: syzbot <syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com>
To: aha310510@gmail.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	dwmw2@infradead.org, halves@igalia.com, hpa@zytor.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, paul@xen.org, 
	pbonzini@redhat.com, pdurrant@amazon.com, seanjc@google.com, 
	souradiptodas6@gmail.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com
Tested-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com

Tested on:

commit:         b020b491 KVM: x86: Use gfn_to_pfn_cache for steal time..
git tree:       git://git.infradead.org/users/dwmw2/linux.git pfncache-rcu
console output: https://syzkaller.appspot.com/x/log.txt?x=14be3bb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=0948c82180d475ad24e2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
