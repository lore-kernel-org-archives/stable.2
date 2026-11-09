Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794243304;
	b=lkMVu4ZgqYr+AEh0imF4vutrv5AtwOX0RHMmF9cjXMSiMNTntPpMBgncYhx3m4E307SP
	 EbdOwdjH+B8lyFF3ttY4WsVetx0L0gBD+hp9SBdjYmqp7gIN1HfMHYO/c6Fa+JT0to5Zi
	 Fbx11YZ2AcNfrj6e2rNVMHSPHHK1Yn77XsBhHC2Koh32dFqps++EA8/5ZnPMKeKVAdHsU
	 2xsO+5+iP6lgbXzkbWW8qdN99+SjPaBUNx2f+EALZrVW65qUC1jnTGTwS8NBS156ZXT3L
	 n7Ff6Y/T2ctYcNAvwQD4yG2LaldtL383d08J84Kqg3GXVAK31L8wIiCF/+7ZY9pSndQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wz4f5GFlzpgFeRAMcKCd/VPFtcaIvfSeX5hY9+feV80=;
	b=jwp0WlzdovXrDUGOADoSJrKsAdqXuiffSQkjN8isNhADJJ+Jvh6hfno5Uk40VJJVZEG8
	 Ss6ZUB+505LOp48gWm0MDt58Vk0T9ME+xV26U2xKcNtMf6Q15AXoHslW99RWv6qO6lkuC
	 fXjlxG3jDoP6O8Y/oZUUmbGUpmYFUa1a6nDNGtW1o0EWqSWT/IDYXyz6FxVezBFesyl1O
	 aqv8EE6/vcDXkdmrZJuiznyOdT22tmQEyh6ouh+q6TTsMp1sBgNPfL0yrqUISJ/iuosNS
	 cIGOPNYIAOR2tkDk496NmYPw4kZTIBV76yhdxtFVRhCU7058IbKK9KkdFHbOSxdluhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFdEGxdd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B1606EE85
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 16:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 197B1606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFdEGxdd
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be53e5fce1so937712e87.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 08:55:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794243302; cv=none;
        d=google.com; s=arc-20260327;
        b=aqDtvfX4l5/Tok7dOETKVAGiCepbeCvLtok2LhoU+zElQPAOTSfZOHezF/QbginRRF
         s8oDbrZ/g3G83hYO/6RsU7SWQVV4f33wg5AKl8uCz2PYw6ew8mryAFlrlGiCK6LIjflL
         AfUi0r5f0kM6YdfYQStYr8rrtiQWeQvaoGvDqIJC1a8KeXC2iDDibWF1s3368qTX06Sd
         pyFDiKJmjme6m3kqpBPHb/84bwT+PO2EeUFmEeY4RO7CY8Yk9KqEAW79wInUcGyIGQjH
         tniM8vMHxhdW0V1c+kMRMVhQG/+vPcYdgNLiuTO3iFiTL3ycps4kxAs9cdtG0fJFd6Vp
         2XXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wz4f5GFlzpgFeRAMcKCd/VPFtcaIvfSeX5hY9+feV80=;
        fh=wkKOBGs9ZQTr+ij7nqXHZh8/6aT+Y33ugx3gvfjsB8c=;
        b=oR+vHiqnx1Ab5VcDEg4/jWQqc0JRYbjglzCX29/x023RJbr8PZdBQXWFVByaKPQ2xF
         bOBfb7L7Vz8/pLsbSIFBuT94s5Y9zA6wOhwCc0EMnrdrYqMTjB9kMOAVkwLE216f35zO
         y99lwqZZKDd8lBbnZLUpx/0KxmDGzdYKvqxK7OIW3B9xO+AVxEMSL6lbmyuU9pDWLdf5
         Ybxqn4c84n5yZ3PweK2SNtlyb0lTieSxEvMK33D8A4mFMK+NdD84AevUSKyjYa1vIvPX
         G4qOHPXK+7zMViws0fVy6DqJi1N3/hUfzZMyiS+y06JryVD+3pELRMoVXt5NC+RyDu2n
         JVew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243302; x=1794848102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wz4f5GFlzpgFeRAMcKCd/VPFtcaIvfSeX5hY9+feV80=;
        b=bFdEGxddJqX5BX4pwqZuaRc/MfV48JNSBFpxk4lB1VmYqCeTysCvS9snhTAQODDh6J
         5D+Wea3NHEWipZKvkX4e/EjeTlhKaw4Xh3bqaw9QtRRAmQ9l6897uN/53suAnXBC1ie5
         o/s2W0ShbqiPSDJbs9QbPejS6A9g6icC8el1xJKwMScdoIslwfHhJscdHN7byv1kjjKn
         7TVgMUqPcG7wyThIoSBew9QegAcvonf7aJ9TF2dD7p3a/KG4HYOlvHmAjwid8lN0P2k8
         cRaSGgq5SlfleS2oTNBm8zUjZgS8UvgNSHpExuIlf6wlBlZQ7fq8u7a8w0s+Xvx1uXhq
         CRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243302; x=1794848102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wz4f5GFlzpgFeRAMcKCd/VPFtcaIvfSeX5hY9+feV80=;
        b=folOFmdsuTExBolzPU/XZlt/OdBNLFuvSfN1rys+vT1qucFCdM4UzN9Vk1qMa4L7fe
         Xt8RG3e9KuoVTTBPzIElhup/T4B1UZ9IJWk8dqL1kWGQ15qey/4lx1RrX7uiEkk+QElX
         dLeOMb8ltr6kQKA8+s7BvPffhOJlJ1tL/wakFLC8s4Hr872hhVrOGZXdkUf73LXvryPo
         hz0LGq0lXoPB37Kpy24rHVAvGXWC106q5h2mU+bPpmP6aPkx6LuJFdYd6bhGW5EdZV3+
         xDec6sGcROMnbnhEHpSIOcvFXI56n/RwidrcdtJCDEgEtgctcySShq8gigpVm1ASeVsc
         iy9w==
X-Forwarded-Encrypted: i=1; AL+hErFwyl9JvN8Bw7QDWrkFhoJz3+NsdXu+hZ5Gu1tAh4tXVEbAPFhXnZqTJand6ig4LsxefZsJUHM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Iz1NeK5fkX4xJaRxQCi9nWIYymYt6Cqk1/QrlKzZU7TJsg27G
	nV26ForCIXAdXwWJQfmCJT7dOJE5jCtJvBD7N2suhhKf35XMKsUFtcHXVpBQsdq5zD+GajZWPkZ
	gHgG04NciRFDGbcr1isImmrRxk8JYnHI=
X-Gm-Gg: AYBFou18W1jU6ftYjsiqD8QtF93C2T84Yc+HrXGtfGm60T8GPEw/ObFphhA52zUqIJk
	tPr5rpC8s4kqQmkYrVKHRR2Cg7Hh2iViAZzRyBEyULcJ+qr+87kzCkqJGnY76jPO7V5floVO0KU
	LV9p7iw4556Ea4waLTZgAz4ubWeVRoYK/BOL4ijkxB1Rz7djm2KlZg46eDmkiIEmowufUAa4NOP
	IJbAZMTr56+ZBff5vZhg/n2DnJL+2csb+OkDoTRwchehvomlr+9CCeo9ou7EBJV4OfeugLdR4cZ
	3TSvESf5JSq8S3cT8QpT/bbcOwXE36TAY54PdBatEAC+48GazqY4Zu4+dbVJ512m4geb8hRU6LA
	JRLqTbxvf/tM694FPTdv0m0LPOLy6ssjcjKUSl+yOyNtwXyDXBkp129LckeJpd3rU/BLcp/lZ0H
	QQ1r8MN9aRzVgSVX9cuM7Ml3zjFLjjf29ledwKHOkG2+DjQqiePKvm
X-Received: by 2002:a05:6512:39d1:b0:5bf:d54c:1fb6 with SMTP id
 2adb3069b0e04-5c14c0269fcmr1310915e87.44.1794243302053; Mon, 09 Nov 2026
 08:55:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106160432.2552507-1-nphamcs@gmail.com> <20261106160432.2552507-3-nphamcs@gmail.com>
 <CAKEwX=PiM8vc27jOVdinOGO9AdCOpbKozu=Hj_b55y10-ynFyA@mail.gmail.com> <CAMgjq7BuAKZ1BjTmdTmXHV+SZCpGMT2YL+q1qvbDOSeqYA==Tw@mail.gmail.com>
In-Reply-To: <CAMgjq7BuAKZ1BjTmdTmXHV+SZCpGMT2YL+q1qvbDOSeqYA==Tw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 9 Nov 2026 09:54:50 -0700
X-Gm-Features: AclHuK-YPpD4TepwOXmHYRcmkMcbFS6VvgciVhmro5ByiYQtUy7Yf8RUTGbR0xc
Message-ID: <CAKEwX=O_wiq-iYhLrw_zVFuO-cMigoSF_zmKYAQtcGFVj2BmKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/swap: publish cluster tables after reacquiring
 allocator locks
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, baoquan.he@linux.dev, brauner@kernel.org, 
	chrisl@kernel.org, david@kernel.org, hannes@cmpxchg.org, ljs@kernel.org, 
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, weixugc@google.com, willy@infradead.org, 
	youngjun.park@lge.com, yuanchu@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 11:03=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, Nov 7, 2026 at 3:59=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Fri, Nov 6, 2026 at 9:04=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> > >
> > > Under memory pressure, swap_cluster_populate() can publish a table
> > > while its locks are dropped for a sleeping allocation. A cached
> > > allocator can consume and free that table before the populating
> > > allocator resumes, leaving the resumed scan with a NULL table.
> > >
> > >     CPU0                           CPU1
> > >     swap_cluster_populate()
> > >       drop local/global/ci locks
> > >       allocate and publish table
> > >                                    swap_alloc_fast()
> > >                                      consume the table
> > >                                    charge failure cleanup
> > >                                      free the table
> > >       reacquire local/global/ci
> > >       return ci
> > >     alloc_swap_scan_cluster()
> > >       read the missing table
> > >
> > > Keep the count table, cgroup table and zero bitmap private until
> > > swap_cluster_alloc_table() restores all allocator locks. Install them
> > > under the cluster lock and retain it through the scan. Initial bad-sl=
ot
> > > setup takes only the cluster lock because the device is unpublished.
> > >
> > > A stale reclaimer can return the isolated cluster to allocation while
> > > its locks are dropped. Abandon installation if the list state changes=
 or
> > > a table appears, freeing only private allocations. Restore locks on
> > > allocation failure too, so the caller can return a still-isolated
> > > cluster to its free list.
> > >
> > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > Link: https://lore.kernel.org/all/sashiko-outbox-181084@kernel.org/
> > > Link: https://lore.kernel.org/all/sashiko-outbox-181086@kernel.org/
> > > Co-developed-by: Kairui Song <ryncsn@gmail.com>
> >
> > I think I need a
> >
> > Signed-off-by: Kairui Song <ryncsn@gmail.com>
> >
> > here as well...
> >
> > (Kairui - up to you if you feel like Co-developed-by + Signed-off-by
> > or Suggested-by + Acked-by is more appropriate here. I just filled in
> > the sketch you gave me.)
>
> Let's go with Suggested-by then :), I didn't even check if that sketch
> actually works, so thanks for taking care of that!

Okie dokie - will update that in v2. Sashiko picked out another issue,
so I'll use this opportunity to fix it too :)

If something sticks out as obviously wrong to you though please let me know=
!
