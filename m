Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794480348;
	b=DrouO43Dv+1iii+L+GjHI10FqBFRlqmiN744R9ybNJ20q2bJqQ/iPkVkSMKgmpJVhCVA
	 ap+miq80cmKqFik1eUjKC18D+uI/1VxST1LZXi6juk3sldkufxf4v2JC17fDRV2+3wMqa
	 RIopjjRxQfsP1hl8coOei7IFhnOFIRVpqQJAnjTWD7yphH6KaLnLbaLWIJg2U1s/Eie2s
	 sISibmSK0HVtCCg5ypRnWfLDb+cA/TM7iggX3qeeYhA2OT8YMLElxdP+9k/9thB8IZLh1
	 SplRiSwgmMSX+ZCnBj1BIcgNJpbZ81Xky7Qc0S0JvzOR4347/+hFzm7/GNLwgzE7L4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ddYVXCpBhwQ+2ajmiZG9m0k4vsq/lXRN7BsHqaZoQkw=;
	b=GzlQuyLr4UfY5clGs+atunDwX9JnTdUlVzll60rf78uJewKnUOBHiJAlQIR70cEH5Tjc
	 0vAmVvJc8NVDi3AeMFKKOhPvQTjYyYfZ5vcB+lefw0b9RKyQJ/R/ct4qp/696u7toEicr
	 +z5rm6HUUMfr7p/E4uItKql+q74huZVEqg7bQD2CdttoCh9N8B+7WADIimsrNRSdlX782
	 J3z91KEFfGqsBeMMOCdbFxD89L2XOfO/ga5HLketwJ1e7SAJZW6I86gmK8DhRoBgxsi9h
	 KUGoOEeEJ4fsi5LdVMf3Vkb7ThXHglBG3CDbfBhtfyOyiOlhg5IhGDeSlciVBpVtG5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcPiMBtA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0859A60A6F6C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0859A60A6F6C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcPiMBtA
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-70b875f6f1fso3339056eaf.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:45:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794480347; cv=none;
        d=google.com; s=arc-20260327;
        b=GlSWwV63b+k4umyeeT8geAXc6YS8jgqlE/iTAylGI2+Pi/srCGgq5rW/X+LVHB5vrx
         z+bqZlCTw6/j6fAHfafwZ7s+6GVzCawXnWBaAol+QnSN+6U82+21HCcwnh0qViC2xVlR
         UyNvz/xBWmkk4Vi0MYkNS0NUALH0/uO5GGGttaB4GVPQHfH8TOGJoRbV3ruA+TrZEgUF
         x4v/lmFoUn9f2x40WIs9vLbtTHxfaMZWCtYPNwMkpeRHyBkwg0e1L8d2s+Achc/KYRcu
         jnARP3PLJtjw4fpL8ePDcrt9IVKA+o+UO0gWyVnZIQQuTGj76rojmtkY9EbJ+kJux4mH
         FgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ddYVXCpBhwQ+2ajmiZG9m0k4vsq/lXRN7BsHqaZoQkw=;
        fh=oNVrSBbVGNQ7GmJ2aQ8X7QOtcnKwcxkWt4KR+lqC7Ys=;
        b=YEBZp55kyGGu7rLVS5hJrP0lh2VQ04gvm0qPHqtPvhBWfnP4V836gjLaXkUGqbb2/5
         8mMd+MJql5f7FCGctIDSQ504+0FKGet6PtKKLKzOLDnkGcDry3p+gsXd/bphJBDkJC/m
         NQ4T+ch+Z4Daq9vQ7VPuMekY2JQoqFr2YUofsezc/OyTti+mslBuxLurTIwuPw36f/7k
         DGP88kqwGvFbGqP92YPOZu2nDlRMBovs1Jh/RUn+xNU1mYDnvxynupMDiMuBic2dc+U7
         UpeQtsKaEULkugvWGOOFbz8+x5O09258un/wDnaw2f4CaQAXV41boiCTO9/8htoDjYSn
         /xsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794480347; x=1795085147; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddYVXCpBhwQ+2ajmiZG9m0k4vsq/lXRN7BsHqaZoQkw=;
        b=xcPiMBtAELHn3sgyKErFDHKe52oZIdZV/+UcUTJI51MVq34g1dR2eDj2nxtlt6O8gN
         ujxl9Kp9NnxitTdfcTiU7WqI0qa/lANz4ihDJAVj0BDAMGEHP7tr+TCelsKdxbzp18G3
         76DyE+oRDfmbDAilSh4EmN3LaR10QHrrnzWL9YKFcGqWSCIHGZYuP1NjuC1z+BZN3dFM
         8snWKAclZQnbkdGtLr68y3k5r2aQuv9o4eFn/9v/7VnPHBWCpEpPHp7/LGS5cDcJrUgg
         2dKjCloKWuJEZjPp+YRKZgkOxYf+LYmZJAACS2/6j4uCcShl9ONNzfmKBhuj3OeIQYKM
         8Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480347; x=1795085147;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ddYVXCpBhwQ+2ajmiZG9m0k4vsq/lXRN7BsHqaZoQkw=;
        b=Z5fPpn87smOCQL4sugf5DbY0jILcQGhALixDJT0QpfYpL+poWMBye71YVQDIDAXDF3
         j1glZ/zEl/Ieyg1OlsErsBgRIUceIZ8VbtIWUxdELm+oI4IwifPXzhQ71Ru+viCXRudT
         tTuscIAwwTggJ/LOp2z7xizofkh2RK73RTI2U8Q+XICZYOHMCP3tCsXipEFgqhoRyok0
         +GUyd4sVHlgvr/Fbt2FsGUWCQvUPBYZAYndSMiHj+oAgR+VqcGKv+aEl6fO/+2k4Dyyl
         vPIrCtseMdFFi4+cB0tZw+XEk9ek4NvLqCVrpy9gsDyO8eRu+GhNOvPGW5ILhQRlvXvV
         j/mA==
X-Forwarded-Encrypted: i=1; AL+hErFIfpfuEHAIpA9mR2NJPR5Aezagrk9XHImmVBUWHutJc9W6odBQ79jkCROtNfwVsFpD5UPNPLQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BiCmxoCqGkBH9KstflR4DlOr3coLeWq3hCpYMrNdLaaCrV6R2
	O6mNuiko9Nff+U53rzZi9P3jn20EziViLAvn8Ao3aXRrYmMuFZL7HDWTi4IECTgRyaOmx8rdpHr
	MhCQXEtUpEJSu/AXGOYpnWH90gmNUjAA=
X-Gm-Gg: AYBFou0Fuwouv5ujPmFqAzPHW9m47jwrukp3/J2kPVFoteA35rah9tDTG1wUnvzYQN8
	lcmwjOch4eYm+zbk+F1+VWr73RbtxZe4g1uW7RXxruIaFRDkqYLm4/OfaBQhZYNRKU7ByhYA04h
	iOPZZKcJ8ba40f4XuAxAOH8xaIxmccjhN1lieniKqEd0olOw2VI8jxZjkimmY6a/yaQoHbJdyqP
	4LSdqjui/Ii7CxUWvfKsRIPTboLkvG65yE21yvdPCWq/YPWo34HDGRO2C9kt0xPBDEhEsch1zbL
	5mQc9J+I2mdFqoulUlOltVBZ4vo4eNVohxnrHVZLVyTW/6Z618MstbkV7bzHqOor1uElcGXTu0D
	iXfVULCw0xF5rArvJNQZclStKA0PsPIRPbfvRbKM=
X-Received: by 2002:a05:6820:1621:b0:70d:77b7:6879 with SMTP id
 006d021491bc7-7191788d816mr3318135eaf.36.1794480346869; Thu, 12 Nov 2026
 02:45:46 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <avA1wXhTMs9eY2NF@chrisdown.name> <6B8E9261-3FF8-441B-8F47-7D35834A8D35@gmail.com>
In-Reply-To: <6B8E9261-3FF8-441B-8F47-7D35834A8D35@gmail.com>
From: elenchist <elenchist.dev@gmail.com>
Date: Thu, 12 Nov 2026 19:45:34 +0900
X-Gm-Features: AclHuK8UhlNcIj8rZxl-jPAQ-TNb4Ro929pQ1QbaMvl25O9AF4j0sdfra1fF6R8
Message-ID: <CANYAW49zq97w7ptUO6xkXZ3e+CNMzWH7qxQ1bQu4an1L6_kXuw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcontrol: Don't lose track of exiting OOM victims
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Zhan Xusheng <zhanxusheng1024@gmail.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

My mail client turned the backslashes in the reproducer into yen
signs, sorry.  Every yen sign there should be a backslash: the printf
format in overkill.c ends in backslash-n, and in run.sh each of the
two "$" right after "echo" has a backslash in front of it.
