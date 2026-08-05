Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF7C33343C
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944764; cv=none; b=gIqTtEQtoSTm/r2BH2Pbv6niCG0rcOlfjk+zR6pVV1YWB1XKlUEfV8KvSgm+h08ptmwo8WfC8VJfW+3N5N3uJz+o2tNqyXCdn1yL8GJkL3Uf9RIzLzHoAg0931iBznIPs2uAhSWgSmUFs8sPyCxOJ6Nf8JzzxwGe72B+WX9A/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944764; c=relaxed/simple;
	bh=ZL/4J8TTn3wXba9R5vqZ/yXEDwD0Q2tEaZEhsVWwzt0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a+IHT2WTTCb/rwZvdbpqYQ7I0vr2EPR2YT3u17p8To+EromCBcHFytSOQY2MKh0BLAbQTZbHHoKLeRoZtl+paPUrb+eOEa5I+nnKuACeM0UkIUeNK9bfPd1xALOkgLV0vYG+Lgt1b8FklEVeJ3Jfl6euSnmh/gmKv2KZDKFN+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-451fd211101so617575fac.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 08:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785944761; x=1786549561;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BeLwYL5ydMClGOYDYV09QEDBbdMa0yN74n5ogutYg5k=;
        b=RcvyvFWlLYpQ70DSyQOqRTDEpKIAXPbZS9g6iR9Ab9VDaFe9PxDsJD4i/D/nCWHntB
         mREK9iLPD8axjWbL0BfX2PbETlOparihCkjsklc8f75qZ1iLceu4ecLRToUjHWx4AUP+
         6g0KFs+Cd8BZyN6o4aHTRplJwvB3w96fv6znoALT5kLw6kG/Grs5zAH0WnX5uwx/GEeC
         bvnUWOIBGdWUECVtKwRyr+mGlomfyC2vDZthFIhBp7P5Ps0kiNVZa1v3wpnHq6y8F94K
         xHMr3FGEw7b9e8TxjQhda94Cs0qdgdyPDxO8hVb6FvQ0pk95o6FUcpsCU1+e6j5/fVDV
         95Xw==
X-Forwarded-Encrypted: i=1; AHgh+Ro67t55z8tvGOk1I0DQv94RlSQb1wkpH1v9K983sfZnRA0IwsnDxzgRyz3Jm3jh7Vxs6UAeSlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoIm2/ZP7jtjHwQYNqj6dm0wRZ6yCvaVLhrqpcrlh2rshzjd1
	xS3SSJkkkfZ/RHlh8L4+8q5WEGJKGJf85usZoMLkVBgsLfGuMYL72o2iylNplr+iEh/OvluoKb5
	i50jn5MKHwOUpry58DqSlXgKpqtOsRYUkd0xAXN+FHaj1I9a1k0f/tgTLe+w=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d0a:b0:6ae:4475:bc48 with SMTP id
 006d021491bc7-6ae96ecd66amr3716387eaf.22.1785944761784; Wed, 05 Aug 2026
 08:46:01 -0700 (PDT)
Date: Wed, 05 Aug 2026 08:46:01 -0700
In-Reply-To: <05be9bb6c5609ca9fc503c25596c9c9e411591d6.camel@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a735ab9.41e285c5.91630.006b.GAE@google.com>
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

commit:         bd2b92fd [NOT-FOR-UPSTREAM] repro: pfncache HVA-invali..
git tree:       git://git.infradead.org/users/dwmw2/linux.git pfncache-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=10362bb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=0948c82180d475ad24e2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
