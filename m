Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36253AEF21
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786947503; cv=none; b=Nu+E+j8HgrQo/9Q8v4FoCAkayJ8XhMrfbkGVIzdEH5K07IybjGi+UV1kk187C63uinK2VrIRzMc29p8kPWm/yXI4yTgLSLzSr1abOup9AUtaeV/cioDL3RCdd5GkJQACodgW931xHj4EiS4Dt/6NGvROObRM2W6Kp668Ryqewrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786947503; c=relaxed/simple;
	bh=reMyDrK0hE03cRO2mahxaHrPNwS22dsQavCE3aUen0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QirQrCnnRmBVSsXOwHAY6d2pR7glHhFsl2I0LvtKmE5GtxjWEBxQyvFa3fM7yXm2S0Zge5Sh5eXl4ySDXMJ2bP2aDy+lugR27SnssI4MDW7j66Ytw+rXFAI4e0r0OC3uyGNhaHTCe/5dzN8owG4wy0m+vx3B6xBYa8wEsNEmdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoCo/JjT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoCo/JjT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d01663d816so25768455ad.1
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 23:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786947501; x=1787552301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ydZ1qaMAatPI6sJUvOY/8UdKmUstagnsilcmYKxpewo=;
        b=AoCo/JjT6c3f7v7l2NjGjxZYioSV+inceLCZcOAkrjmgFDTvxBdTiy9xJSUr5Z6v5c
         V97+F09Jjxh64jCrmFous9OUp/JVBRNK1kTYYDy7mxaopc5eyd01oHErTP7aYpnRr8mF
         4q3vGZOM2PFemgN4RIV/nF/u1SV6CNLCTRmkxdnT/d0isrmkgbJARFC819Nprr+54+Fv
         tM+rsbUgc0Zcym1spA4aIZjx3ADM9Z08qOMWpcRhDNv0BI3Vt2kaISllKNur+rmZwngo
         RRElHsRZJ0enc1aDQMD4YBZRCFp1UHu6PiTpdohOegD8hbuAuTcmfvqY2qp8f2qfMBmB
         0q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786947501; x=1787552301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ydZ1qaMAatPI6sJUvOY/8UdKmUstagnsilcmYKxpewo=;
        b=l+WeH/q3ANeMuxfVjnhVl58fZwUniBKLmGLTgLyNBW1FZUtKWjItQuFZ4gEKKzLc++
         QOtuYpAVNxWTn+tj1P2XCBT6NI4M0nyy9emdxKY62cN1rZItl211g+ib65YeaKXeuFK9
         alfqM35W6dg+Dr9iqdIjw9zhQPHR+FFlbOQAVb3acZbu8nFykZXXMmNgUH3eD/Mz+Ch0
         M6fslwf4zheagGflyv0wZn0paC9EcmOzbti6VuMI3T9PR92DDKUGjj4mdKMfCQihuaM8
         mlXHF0+89gDw6mVuxG8bZ7vFb4JaSHwljn7IgPWstYYfeI3wlW7/hHJpr53Zqnq3oSkv
         F1DQ==
X-Forwarded-Encrypted: i=1; AHgh+RpyrgNyp3fBQVZr7mbVOA+ORbwVjkELgI9oXDvfppe0HbOC1VpaOo40v9v23TI0naE53s7EAvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8BE0rdlDPNrULC9DMHM1hiK02ZBiX+o1KDQD0vjhXcF7B5jzE
	SBWq0NAvOg7F2a9S1HID/iEZ+soOhW7P1Dk4ZxhEkQLO/PSqrmFyjAnR
X-Gm-Gg: AR+sD10duKio+ocq7Y4p7QymgsnIXJ2VX6Ky1ip37K54CdTuKIGga5qffXzRkhq910N
	jDgF0Hb/NFbIYuvsR1AcPmGHOXex2zPYYK1dGkkaTlR2zZWCf1J5E+x6nRgtmftapiD/dx0oOhm
	NBXsvax7wMqHItBxXiTJDwoD75TPmYO8M12sgfjXI/GfTdP5aLwhV3gkqQaRZfw+EzzUauxUBKx
	SZhjlKSeyFRc+g84c2QYXcMMwXPxwsQ31RssCJoL6S9xUo+qh2U1uPpzrS5jJYiXihIbWkYBdXA
	KpAbEYsbsVB4Y0JLRKkl3k62QbhDge9ig3Cw56yBie7wzqKFimxtJ6+E1UceWwtW/QHsYB072I7
	LGIHIEtspYpr4SzheMQ1elK4aWt+jloopnlcWK7mUFDnrthRd7cLy0AoJkHkccc3ZDIZXWF+Jwk
	nxIAyYzaVpeGwtxTnetL7nSnOm+d2drVqrYNZvCyc4Ckat4s+2/lAAvG+sKfPv
X-Received: by 2002:a17:902:da82:b0:2cc:777f:d67c with SMTP id d9443c01a7336-2d3b0d5ed01mr230431685ad.13.1786947500808;
        Sun, 16 Aug 2026 23:18:20 -0700 (PDT)
Received: from ubuntu.. ([219.241.133.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb498080sm940935ad.7.2026.08.16.23.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 23:18:20 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: cassel@kernel.org
Cc: justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails
Date: Mon, 17 Aug 2026 15:18:15 +0900
Message-ID: <20260817061815.154794-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814143833.1953415-2-cassel@kernel.org>
References: <20260814143833.1953415-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Thanks for the explanation, and for picking this up.

My testing of v1 and v2 never reached this case.  The syzbot config has
"# CONFIG_NVME_HOST_AUTH is not set", and I was not aware that the
dhchap option tokens are compiled out when it is disabled.  A connect
string containing dhchap_secret= is simply rejected, so every run I did
tore down with ctrl->dhchap_ctxs NULL, and there was no path that
dereferenced ctrl->opts.

I rebuilt with CONFIG_NVME_HOST_AUTH=y and swept fail-nth 1..200 over a
connect write containing dhchap_secret=.  You are right:

  clearing opts at out_put_ctrl:   dies at attempt 20
  this patch                       200/200, with 35 of the injections
                                   landing in nvme_add_ctrl()

  Oops: general protection fault, probably for non-canonical address
        0xdffffc0000000008
  KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
  RIP: 0010:nvme_auth_free+0x99/0x450
   nvme_free_ctrl+0x231/0x6c0

The injection for that attempt landed in kobj_map() under cdev_add(), so
this is the nvme_add_ctrl() failure path.  ctrl_max_dhchaps() then
dereferences ctrl->opts at offset 0x40.  Clearing the pointer really does
just trade the double free for this NULL pointer dereference.  Good catch.

Your version also addresses the two things I was unsure about in my
earlier mail: fail_unlist: covers the two exit paths after
list_add_tail(), and checking list_empty() while holding the lock keeps
ida_free(), put_device(), and nvme_fc_rport_put() on the unlisted path.

Dropping my v2 in favour of this one.

Tested-by: Rihyeon Kim <rihyeon8648@gmail.com>

Thanks,
Rihyeon
