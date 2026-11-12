Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499774;
	b=fL+daVPan8BeRdUWeKq3DTuiQxKOpEK7b7+uhckkpkRzlLW14vHGbQ9JB66yWL+vIXO5
	 YPaXO94bWw6eg4p1ynOsVh4E+hY3X8MZbkZOt2pxZUWqbG3zfwyiH+bv2lRaA5UttzXvS
	 egdtwiI3Jvy8Nkzv/WgyvOexuiavQ3lklMnPbNku4gfbwNGl2IOGnpXf/0w9LAMTulViJ
	 3FQeZuhaMPu6F1OZvP+vao9BSJScNSUkNGIj/2y1uBdy7Ex1tLgqsaXI2Nl/DaF3TStwl
	 2puIaTOBWz1F1ZdEtp+pY5v2tEDPxbWVxaadkIpzwF2qq7Uc5/rfExQFfOceOK6uyFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NprontI3S6wSUIPA9DtkrQi2JmNtITe/mB5h8L/dO/4=;
	b=igZys6gWZ7k0K0BNCzPyCYzaH6n5qeHmoDTD2s3hqqlEDmHptk8pAglG32K/O8zobQPC
	 NI5iSUDTS8+OR1099BRweT+5PJoxulmC9dxXKFk6SQ918O4H2EDqhcMCGiNeGodBOOD8s
	 i//dGByhB3/bkDAfJtTPI1Tl2ahTMLfFfJDuYzT4b3anfQYwnkuJSgh/WUGFseRgHWJdN
	 ux9LMRp2x1wIqQzYZZnmXvYKcdfNUKOcakzkVhv2yrfCLNg4mwQlKaX9BZEICh/kNkcy0
	 vXWxW3CwM69Rn8TsZfNmFPrvqknWyUlvQQIT3S17qspEn6RImI5vA8uVN6I3yyhsOGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SDW+3APw;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E321606A339
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 16:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E321606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SDW+3APw
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so47175645e9.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499773; x=1795104573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NprontI3S6wSUIPA9DtkrQi2JmNtITe/mB5h8L/dO/4=;
        b=SDW+3APw35sGo9ekbc/cfecReuJ9i1TnBef80x3C1JAK0/avQz1v9UcwccYU4FKSz0
         pVPWt0hwSsrG8Uv+XL9jeNx27BavcBj9zz4GD3I6zAklojicL2h5/PerDzzG2lk434qa
         IjXY65JigmaiHQVtD9uCZM8QadnjylirJg/8u7+E8m7brITD+QWHNDdrR2vUYbHkVY1/
         OpMiQNa5ZT6BQjbVphKxey9DoD7qJI3L3ridMThYOM5eu3UUSUqTJybUT62tZdrkp7l9
         a6D+aJPjA+i9y2PQ09xB52CTKbbYf0oF8WcybOMYN2ghJw9AxcaCvzEBJcoiV9+9ZX5U
         G8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499773; x=1795104573;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NprontI3S6wSUIPA9DtkrQi2JmNtITe/mB5h8L/dO/4=;
        b=c1cGmV1ZV0trEk2Y9v9XCOmcCSs1khxzF6Zli6aG/TYu+RHlfR5HWTilnFw8wld8ED
         854cQpy4Y+Eogo0K4RRkjShggX6tWJxYEFJdCr6fML7ty7ovQ3P7IneOmGcQVHq7sC+c
         +R4D9GzwBwx4+JkGS0OgL9+ngTCqToOzMmOCXFa36BkjgXumhjQc/iPuiELc2kx60Dtj
         2V3O1zIplLtm+Eqp52pz6swnriZnaxJg7pHjuqGmjRzwZqlzJb+uLcrZSTm534bm8gz1
         pZ9KXuCbfunuUZ9u51f8DPamUd+s6XvXqyW1Vn3/qBssdYjZn+DJ9m90vOyjS4/laQNV
         VkHw==
X-Forwarded-Encrypted: i=1; AL+hErGhd8Abspuvvbb/z0i96EmqaV9+mkj7v5lZD+vjv/TJY3emQZojbPnI7bgO+PxlPKFRk1+TX/M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nITjsbwj8O4CTcwLrh/rqMtYustNavhfbH1fPhc1XtQSOCFbV
	fhAIntb0H/cVYDBAr1DOwp8rjCVMXsG0BNfmB+BI1Emcg8XRd7ceJMBi
X-Gm-Gg: AYBFou3uFWfdonf3AfnjpH2IOQYyRNYhW6+v5rsoj6I/XUHeYgIaPhIxAkii1ug4pQT
	8LNuOWtBf9zL3ndlm1B/w3cNSO1+2O89iHySY86nE6C8ZoIEUGUZjk8yKskVFs6glUFt0AJC59L
	LaOxJX5ZsmqjEGM6HsCfyV4QCnANsDg6hmTCE8Srpu3ktoPrJNEagLB/T9w/GNfr3gtapQK79H6
	qu5NBWlTCAyIxNP/lilnHoNJAl1jpH7MQBrhA/gaGYjZNaOKmQPGWOEZl4/Wd6VWl6aQxxl+T8e
	KrgtXDqrRE2BKzsULtH8R6bvf1+HbBKNpDNkBq8Y8vsfK3BAEtAK1j5nHhhK7YDWovUn/IRNqGx
	32RoNaLbf8ABq3//DxEPSNWdwvG73RCMgPoHXEsn7cJtmYqeF3wx9j65xaOn23zfZAZH3gV8zHg
	26sGScVv/1roPRJagDrmdvjK93Bd5dUcQ8rdCll74oQRQ7FuT6RsCqF5fM2MRZYxNRljW2w1PxG
	liaOdd3gZFQ7ISPzH1TGdphiynhrrTvypwZBFCNFR5+aLm1CmJ2Ty7dtugL2E9Rg6rm1Wt/0IfP
	k4D565BXtmvA01nBWc/CmDxjySe17/tMllDuPP8i6ScXS8zCq4vcLBStkJDaQ1JAwlYsFHZ3fEc
	VWwiue7OtDT2xARJqrffvwr68pZCxPiC5tWGELKvmaLG7jDx+SsoDYk1EDVttDjRvZ/v7MkdDhY
	S8LzgdCFBzh3fCDSTM+MzTprlR6IKaasdckvZPehAcdb6cC26CrOZ06v2818PHvMlER8ixvi+Nk
	vi8ATvnzEUMsicnhJuiEnSvQpOiF2RXYd3b2Y7Q13LiUQxERTU=
X-Received: by 2002:a05:600c:871b:b0:4a1:fe26:24f0 with SMTP id 5b1f17b1804b1-4ba0938a4cdmr112713305e9.20.1794499772615;
        Thu, 12 Nov 2026 08:09:32 -0800 (PST)
Received: from localhost.localdomain ([2a0d:e487:413e:7996:2027:fa29:7e27:899b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e258e8dsm121173795e9.4.2026.11.12.08.09.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 08:09:32 -0800 (PST)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: oneukum@suse.com
Cc: linux-usb@vger.kernel.org,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	usb-storage@lists.one-eyed-alien.net,
	stable@vger.kernel.org,
	Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: Re: [PATCH v3] usb: uas: ignore UAS for ASMT135x bridges (174c:55aa)
Date: Thu, 12 Nov 2026 17:09:29 +0100
Message-ID: <20261112160929.6479-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: e6593c6e-63b3-4198-b587-85b5636e033b@suse.com
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 05.11.26 20:43, Oliver Neukum wrote:
> May I ask you to test once more, harder?
> If that remains inconclusive, we will go with blacklisting.
> We cannot risk filesystems.

Ran the harder soak. Setup: the same 174c:55aa enclosure (iProduct
"ASMT135x") behind a 4 TB disk on xhci_hcd, kernel 7.3.0-rc5-vanilla+.
The device was bound to uas for the whole run (rebound after the
usb-storage.quirks=174c:55aa:u cmdline override took it at plug-in).

Enumeration: the cold stall reproduced once, at the first UAS probe —
the usual READ(16) at LBA 0 timed out, uas_eh_abort_handler followed by
uas_eh_host_reset_handler, then clean re-enumeration. Same signature as
reported before, still only at enumeration.

Load: three fio runs, all against the device under uas:

 1. randrw 64KiB, iodepth=32, 4 procs — 143 GiB total, 30 min
 2. seqwrite 64MiB iodepth=8 + randread 64KiB iodepth=16 — 342 GiB
    written, 75 min
 3. randrw 64KiB, iodepth=16, 4 procs — 161 GiB total, 60 min

Roughly 640 GiB of mixed I/O over ~2h45 of sustained queue depth, disk
util pegged at ~100%. Result: zero uas_eh events, zero aborts, zero
host resets, zero disconnects; every fio job completed without an I/O
error.

So by your criteria this stays inconclusive — I cannot reproduce the
queue-depth wedge on demand. The enumeration stall remains the only
repeatable failure and it self-recovers via the host reset. I still
think the blacklist is right for 174c:55aa/ASMT135x: two filesystems
were lost to this failure mode in the field, and UAS buys nothing here
— BOT gives ~3x the sequential write throughput on this bridge
(~136 MiB/s vs ~45 MiB/s) with none of the instability.

dmesg baseline and fio logs available if useful.

Please take the v3 patch.

Regards,
Olivier
