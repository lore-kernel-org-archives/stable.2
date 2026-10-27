Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106791;
	b=X8yFD1O8ZTDbZ2qOfxbZT6YeiX3lE5Onw2q4nb4jIAyGvmbx5SMTXYo9NL8Xx53Pk54n
	 KTsdEvdup8yoPIvyCecQKBjiw9Gd21UeZf5NrZ/XGPXsWXxeuQvlAoHyrs+lK9azCa4K3
	 L14cUL3W+1hWYSUcYvD9z2rfl2iSbC3OjQYz2ILZsqXmMTyTcsZbMuBjmgPUtPdAGnzKt
	 V14OerpTduohFyhE97LDZ/9sqH3nXxMsC623rQySzB471Fk3tMZEZ0HbiPhbQMYY/1Ve9
	 gjXxVfs8Jo9g+rJJejKxgHguX8rR15CyyeYtp2OsKNBue/Pac29M4KQ9N1JdcC9DtrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=NLb4nDnDa6CheKrcmNiCI0BRgJPIlEmNmuOLfa1pfGM=;
	b=4ipxUeOqtUlMsqKNnMN2ZwzAyMtFJUupoO4XUn1VgeGrgU7FNpnnE1EdtOFVAknea0Ck
	 A3Bl3E9BynGP9EGxcyOm6f1eflS7M/14UyX62aXqndzm9ienutds4I0wQXd8H/ufjyW67
	 64fEnNda6dr/BM8WrerheFSMfyFLkJ3cC5Zwo0aTazZf0pVGg3OEHIq193LgpfHYzIcbC
	 k1c05qIfHcIxb0aN14ViEORqxtXSnxGrP3KX4zpgo1tlEiK2ugv1H3Td7J16PuYHPAH0x
	 UanlkZoRCibM+pCG2Nli6TNLtLaMQg0tcojM6OcJDX9fzUE1fqroZoog2AW/JgcJ3hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GdQnafCf;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ABC606A335
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 13:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02ABC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GdQnafCf
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a17a332ecso569591eec.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793106790; x=1793711590; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NLb4nDnDa6CheKrcmNiCI0BRgJPIlEmNmuOLfa1pfGM=;
        b=GdQnafCfs4JjE1bf5swyZn+lUdfkEWIe19XaOfaI/jr6nZJrRlM6EDaidtXyggEWzn
         z6mqlIb+cs/xO51JFD+8ZiFR2wAQvf8Dlrvh7feSj/iyZtu5rSvjsX1g3WFw354kr6BK
         4DcL4gBDT+Er/iQ5G3sLJbNJeWLJYv8+4YD5JrZiUDT9c1qaWkCG5dWJp10g1rfT4x6R
         E2ncrHWrcjzOo+gNaB82xl0fyCHWwBzbmGDop1K2JWsasCX25ZRdaDtihYxiOYWIjtSi
         Oo0KW0aKkdsirAuAo4RnGtiqb7evofLpBW4k3c4W+XIT7MgRamX9jVfkGGbLyvFVfEgc
         8Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793106790; x=1793711590;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NLb4nDnDa6CheKrcmNiCI0BRgJPIlEmNmuOLfa1pfGM=;
        b=et6RCdNoI3TuWA0PlKv5bAMKxBqQ3jxg8EXytsWQW9FnGK+nGCNMvTf5bSp5oRYo/B
         N8CBGUc5kygpu4ylF+oickJiqR4E75HATXnod75ap6BCGFiZQ1woSzFjSVc2rCbVOx4d
         Qzbz8Jd6kMz4Q5veVHeDILmfCPjeZXZ7ZW3mZghrwcGdSm0zAuNkYmRNvVNhZ6eSeoGY
         obFqG3M4Cj3uaXVqNIB7QVmRU1PMlT5SJRz/p9ydyPSeNNGdDU/qIEO+Ia0ue0QQhxP1
         Dr8TzSzLHB7Zb4jcT1SXAQ3DITxrSvsDZ5q+kuMraDx3KR1cNpQjdOzcteFWCcN1T2AS
         6O4Q==
X-Forwarded-Encrypted: i=1; AKwUvBx0tFiKor0qW36sgKUw0DCQgalzYcSy8Wdee5shub5cipRfHVcmsUN804f2iBUm6vGiaOvT924=@vger.kernel.org
X-Gm-Message-State: AFq9FYISH/+tR1zuiojZgbtkUP95zyipOlcW7gniTfWL8EOwEehKcow6
	t9fmrTpAB+USA68n6yW0+rHaIgPMUs2FHK3H7HdFFjUQ1zD7foxkJV5P
X-Gm-Gg: AYBFou2eGxiDX6JlBpXvGaBXVmJ4gpBx5uTjLcTnelwrkKIOkjUi66UkldFDLYNks2X
	kKvx8xgiSFYHWatIwbKIcs1Du65SpkCw8Fc+FS8SYUftFGIeZchELmeq9WYvBv//eRErOya3W45
	BaZX0YNQM8tixcdCTB7jaRf9BNJjSYVWu9hNfH2lKZU3cbp11vc+J7L8GJZnq5Nt0ErJ9aC0OxA
	zeJu5SKFioslTYGsa9m+5XKmwt0XqUD0YwC1KHAncdUbrEG2stpaoIJg67YlsM+5cplPoXVleAt
	SCishteFvrjqzYWnjYxwv2sYz7FQ1+mFs8Hn2YWyv7Ob1Cg4ALswU9cbgdcnjq7rPt/Yq8W4d7R
	lAPEaTskTytx3aKe/hYUKuY5yL1LM/jkQxLlPNDmFiUiSiD40SYBo3I5VMxKBo+lOGt1sqHEcRb
	6fCZHCewZohoj6SM/81gMfWQcj4ZglvzkykgNEKeMJWDXuIcSXiAtXQDWJwsJKbA7FKmRWkqyqP
	87JMIijNqsY7QdMjzL0F4KkAKOM5Dig4vANGExJkYSfzA6vYGpH0jtqWYhDS11DI8/yc4RdgYDD
	6ZO1QJ0KPkfbMnOzag==
X-Received: by 2002:a05:693c:88c1:10b0:367:5e31:ce29 with SMTP id 5a478bee46e88-369e84fe37emr14011879eec.20.1793106789881;
        Tue, 27 Oct 2026 06:13:09 -0700 (PDT)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a002a486csm19339403eec.22.2026.10.27.06.13.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 06:13:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH net 2/2] Revert "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU"
From: Esko Mobius <echoowall@gmail.com>
In-Reply-To: <CAL4Wiip=TkP2hmOFR-1Y-CU4rYHY_q=TBDhK6RmTj9UEMQ95Gw@mail.gmail.com>
Date: Tue, 27 Oct 2026 21:12:52 +0800
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
 netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 regressions@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D438C59D-09D4-4008-9240-18DA0ABBDCEA@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
 <20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
 <e25fd292-5391-41fc-a324-0ec260828415@linux.dev>
 <CAL4Wiip=TkP2hmOFR-1Y-CU4rYHY_q=TBDhK6RmTj9UEMQ95Gw@mail.gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)

On 10/27/26 1:45 PM, Jiayuan Chen wrote:
> This precondition does all the work. The server only learns the PMTU
> when it sends a full-size segment itself. [...]
>
> Please re-run the 6.12.107 case without seeding the PMTU.

You are right. Without seeding, 6.12.107 stalls the same way:

  kernel        PMTU seeded   SYN-ACK MSS   1 MB upload
  6.12.107      no            1460          stalls
  6.12.107      yes (ping)    1416          OK

My reproducer took a shortcut there. What it should have modelled is
our production setup, which is the masquerading relay you describe:
the clients share the relay's address, so ordinary downloads by other
clients keep the server's PMTU entry fresh. Modelling that directly,
with no artificial seeding (cliA downloads 1 MB, then cliB, behind a
firewall dropping frag-needed, uploads 1 MB through the same relay):

  kernel        SYN-ACK MSS to cliB   cliB upload
  6.12.107      1416                  OK
  6.12.111      1460                  stalls

So I agree it was never a designed mechanism, it is the side effect
Eric describes. We have since added MSS clamping on our relays.

If it helps, I can send a v2 that describes the masquerading case
instead of the seeded one in the changelog. And I am happy to test
the net-next follow-up on this setup.

Thanks,
Esko

