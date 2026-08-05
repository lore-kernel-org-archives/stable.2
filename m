Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E7443A81B
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930649; cv=none; b=azVdQdYJcs1z6BhLlNndNshbfDf7740xr/2UeJ2HOsnN5XzItX+af3wJGc6ZYjHGxZiOz+aUETfXvF6ZEePDBGpUBuIsU3ET4yudbYQRCoOHYzJ5WyWfKslzpsTma19awogHG6pVXJJDYIxOc6KP8MJu/8IBGBzFzcf93ChPIiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930649; c=relaxed/simple;
	bh=8pB7ceD77AuYDPuNy5sp4YIR/n6BG/LvwP4jI0nxD+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9vvHy8HvBB3wOKOr0BweLWT6hla8ku4UeuZG+OJd3jF2en1+7Lb1NT88YOBpIOJ0hJxO1mHYu6pON18tcVJPZ6Ck+qpRKTk2fEZYAPYaz+zvMmYAh7oDQyRNVXLi9wVnEw6o0WXmoJJyJ0ZCjquLDtJRocu9SbmCsp2XVVfVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Id9ZbJPT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id9ZbJPT"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso782358a91.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 04:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785930647; x=1786535447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9VOjG1qeqbpED3aclWfN9lJ5XhH5+1/8WZV2to/loYI=;
        b=Id9ZbJPTCWTxJejmJ8zF26h8rAq9Hsz19pmsfrNKNk4MZPtixmPIubQ/HfbUMlYlwj
         Qrd5Je9sc9u3jwj+Oqb30RXV6Q12LC38VgFAB5uRyZuvhMVHt7DQvLnMDuUphPgOQT+f
         LMEdn/cPWhDhStvUtWqHEy9f3VBh2wlPKuIMf74HguZsoBdQP/dwTXV9eBV5oqXYcsdO
         sG+UhEhNDnveXWJSEzMZV7xyYolyzt8SoTUaDCZAL+ugSua9Tpxcl78JXZ60/Xkct78/
         0UbP/+xtql/e2/y5ovXjvIPMPKq6rUD+ypyWUndAgmQ7wyJ+tXMn39mr3GTDTPUS6hMr
         ZpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785930647; x=1786535447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9VOjG1qeqbpED3aclWfN9lJ5XhH5+1/8WZV2to/loYI=;
        b=fLATPkCN0/jBMjLXb0YyK9l8L79/SNOP5EpqTssAl/7MWke5gr4LHVn9xgAUv9WzCW
         kdsalu77apTaVLeBYtPPVYxkSfuYUlQfib2XZ8jWHIPtmNTTZFQvGIxKOTGuEc5aTRTu
         1h9Ui2GJSbgcCFJxNZ8P5v3W7QU/V5WpZOMrbvcqc/ytsq9a1+0AqsENL3b0P94IYgGB
         nweCyQqTdLB3OKJ0LPTohmKnDwmXFqECycOr+81CzNWD4287r2mSyGHJUOw/pOPcjDd9
         iZTg8KLXagCJlCYS6002cR9C3046JIQOqyhekYvyxHp8wFiq47OsIHyJz+NGTPFPTiTk
         Xpkg==
X-Forwarded-Encrypted: i=1; AHgh+RrjkK5cu0dIEOoREEitACGWmEJPktWwmK3xibpE8+Gn93dvl5FVZ61ko2h1BQVnpqWE5QkbfUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87vAI63anBo34UW3yU8dREhowu12Ktil8z+0Tcw38oXBfb6rK
	6eZQ2s3ZmGSRvKbo7Ltp4bpYk7aX7XqK0YhvOe4voDmWdtMk5DXRpMCP
X-Gm-Gg: AR+sD10lsXhEj9IkitY5K4tuoPjG9OBIGyKfAZ2N53E1nSsn8qjSdIR7ydUSTf8Rc2J
	0OrzoIP2zPbN4HCeQ+GDlKKbCtCJ0Fz6b9jiYA3DdM7h961IX8ex0Flbs7mtTgPHhLpfnPhMdE4
	ftI7wz6cpndvl28Al5rV7TpA2kk4cspG99Gncr2SwrwLsVxu5OzNsq8BWit4l4Z9JWBJkGIHnU1
	H3FvQKNj2/3EqZXD5LVoBCyq0NEOJVWth61bJdLj10PN6UX2xOyTv7PMXJvOkbZDL6MafiXV5Ko
	dtjboMRqAxR7TGs8DGX8uUzsljLSr/lRLyiqZyCQuHI14f9vB3+qKFDUiNCxt9AfKI0A4TFoga/
	BYkNRLLL87XrO/B7tu0B1UZ7QGzgB1RA0zrhEvkLJF9ait0LAUIfVsJDetVvRlF0rwcg6uHNS80
	NudvuUtcfet1gXX3MqU2pvEg1evUywR3KNx0HEKXBzom4zeumqr4/FU3ZWOdWf2ATHBaTOr43J7
	CKTyziO4xlEtsub7XoM67p/bj8XS3xQKFFExkPkrqGJy4nw1WjE88EK3W72T15zeS7+WJIyNItG
	jjsK01RNQ96+JBw/e6IJLybR30zwXa0n5wQoJOsHJJUEpGT7KgZK
X-Received: by 2002:a17:90b:224e:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-3903c5c443dmr5103146a91.16.1785930647103;
        Wed, 05 Aug 2026 04:50:47 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903927db6esm2936674a91.10.2026.08.05.04.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 04:50:46 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Roger Pau Monne <roger@xenproject.org>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Roger Pau Monne <roger.pau@citrix.com>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yannick Martin <yannick.martin@okazoo.eu>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH v2] x86/xen: fix init of balloon stats again
Date: Wed,  5 Aug 2026 19:50:41 +0800
Message-ID: <20260805115041.409008-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805094008.95778-1-roger@xenproject.org>
References: <20260730143548.39320-1-roger@xenproject.org> <20260805094008.95778-1-roger@xenproject.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Roger,

v2 looks good to me.  Keying append on the source of the initial count
covers every case I can construct: by inspection, a domU always enters
the fallback branch (current_pages stays 0), so HVM/PVH domU and the
dom0 hypercall-failure path share the subtraction branch, while the PV
start_info path and a successful dom0 XENMEM_current_reservation append.

I also ran it on a nested-KVM Xen rig (Xen 4.23-unstable, Linux
11028ab62899e as dom0, static busybox initramfs):

- PV dom0, dom0_mem=2048M,max:4096M and 3072M,max:4096M,
  CONFIG_XEN_UNPOPULATED_ALLOC=n: no WARN, current_kb matches dom0_mem
  (2 and 3 GiB respectively).  Same with =y.
- PVH dom0, same two memory configurations, =n: v1 WARNed in
  balloon_init and returned -ERANGE in exactly these cases; v2
  completes cleanly and the balloon driver initialises.

(Scope note: PVH dom0 userspace stalls later in boot under nested KVM
for an unrelated reason, so the PVH evidence is boot-time dmesg and the
balloon sysfs state.)

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>

Thanks,
Matthias
