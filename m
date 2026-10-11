Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF722F8E90
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 03:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791690475; cv=none; b=slXA06KBfS5kGlfzqMCO4T8CEEf9ImZhL/ROEbJqFwsFzNDFwLqvkk/Ku7f4TDfyMWbZ3cQPDIrBoGSnX/NmVMXKQhyaW6rswRzu+H6ETNpbJOQvLGYnt99c5wWkqWKXd30AMjAQijg1lGPXtcDRL/j7fNTrQX/ioff/I3kgnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791690475; c=relaxed/simple;
	bh=n0uiX78IPrTN/TLii59hko4ih3t30FEhDQIhTr+AN5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iE15aC/DlyVwPuunG4lrNy8UUfzMt9idY5D0hdnjujPTd/pkZkex/51uqCH/xHs5DzpA3TZgrIp2HxUxU/jd5ibcAVQHKTN58q2xJPoNzRRuQ70LpzPVZedXKzqm+qKM3E5gMqQDGrx7Qkqrkoy49BFsXwo5/FRimy+/Ma3L/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=gf8Ywsc6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="gf8Ywsc6"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93cc1ab5f6cso122244985a.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 20:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791690472; x=1792295272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FB4MPXLOykFptRXKNBWjPGR4VJPoRGtDL9e2tNF9Rw4=;
        b=gf8Ywsc6VV9A/pv3FZsKNSX/6+/KFd/030OLVuGBQs7r/xkYLqiFkfgmkSGU6fKlby
         bXF5VqseYzBW0Mv1m0lzMueMjOBsLCvJMsPIeEUNBs+GvD9s5gLkPzYhbLNQgzb19BWi
         2OcFViFQCq/XtVwDkJOPe/IRRqAihyZTypqyWzrcoRGlZTNKILghnUvPbgFMz9ZvWifx
         jad9TGf77cq9oMD1KXWZ0WSA/adOvrmcvK8LW3QsFyftAwD8sQDXfiKPTJcaQvLPm1FO
         Zo60jaQQrWJtDYUAl6K+hfUI8P7iGhKjQvmBA2vft4otJpw5BlKcu0NGhTJPc6zJB5lJ
         qOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791690472; x=1792295272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FB4MPXLOykFptRXKNBWjPGR4VJPoRGtDL9e2tNF9Rw4=;
        b=gWh7kukSIzowVNUtMr2zSMp9Sj+DbbW5HH60zacThK1AMi/y50T1/ewOEBgsmefUWS
         B68UoJLEiDFdW/LJN9HFdgxRJORNSjTsZxygJ5kgaHqT+Zz90bipWASL1LO72lPaAwXJ
         ZghHvOdAaex++++uCzpNyzPvvk77vAdzcnoDIT+9IJpNOAIxmFRis1MtpC4Jf3GoZBlb
         LA21P7EUZqwGUpbjCXJJP4vf/03+MHuarriTTVExgMqMJCU/NtVbvrNiB/6rC9tX6kum
         apHjGmUfHBIMclti/fR8kz6vknc3b2aBaZG/1gtBkLrlAnW7hAz3HNSiETZT1C/uBtcf
         JD6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxE3YDqxayLTvGOSC8ZHcokbx9Din6fouMK8HvYVLGlfi5eNkNL7TU4hn55RmBAsiNys46eW88=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkjGBQUNVY9PMyAnqd64FJCMvHq6n6S9kv6tscJBAT/MSCnEEb
	/NAIVOvUC3QLoYY8RBdz++8CpoiKNXG4y1OuSQE79D8hSmyCEPu75sZVsXGYND9MZw==
X-Gm-Gg: AYBFou0eMTL8SVd7ZkGHwcySx/XwdXWqP0WX4JhNuwdu0iX3qbClw3Quo0BGom7a1RN
	6jfC2ZX7DI7aRsqAAL1yWfFctu8btsg1tmaU+BWoDmUHsn1fD84hxkcl83dVVuOq7TAT6JjxJAt
	5nm7qZaDZNFycOTZ0wNoEL1DSwXy4nSWrT94pMTPXPX4DD8cl7Ehxou6R8JdFBZ4v/SzoHGJaro
	rKY/BFyTrCzO5l+brKUwfMBR4AX01pUTPYG5HGU6EEn/CH/vssLhf5o/QvH3/Wa2hat+r6/mzoL
	yAqd8JAa1s/vvuYqaY6Z0cnupFxJVIZDt/Ex0yheevVcHdRrzLp+9g6FSW0/2sFctVj+fDRRhpj
	h4DQEsaX+Bxjy5/VIDYS3aGi5FkF8+wu7n0RqtzO6ucu7CibRdy0fvbsjPyLu09aJrNBs86cudy
	a4hSwQNLL7ZI+3N2NZCqAAX/MeyXYd2GpG/uXHL1iYIy0hkVFVRbQW3yN0+QoLd6MeVik64GkhX
	hvg1p/Riqo6UtxCREp+Lw==
X-Received: by 2002:a05:620a:890a:b0:939:3a81:326 with SMTP id af79cd13be357-93ebd25989cmr1027862585a.37.1791690471864;
        Sat, 10 Oct 2026 20:47:51 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9847f37sm558267785a.10.2026.10.10.20.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 20:47:51 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.com>,
	Chris Mason <mason@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix chattr failing on nodatasum files that have the compress flag
Date: Sat, 10 Oct 2026 23:47:31 -0400
Message-ID: <20261011034731.1054465-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <41987a33-f2dd-4ffe-b35f-d669d36dbcfe@suse.com>
References: <41987a33-f2dd-4ffe-b35f-d669d36dbcfe@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026/10/11 07:47, Qu Wenruo wrote:
> This is very LLM-like, and very LLM's objective-oriented behavior.
> Disclose it first.

Yes, and sorry for not saying so in the patch. I found this while
comparing the behaviour of different kernel versions. I used an LLM to
analyse the difference, write the patch and the changelog and run the
tests in VMs.

> Explain the reason why it fails.

chattr reads the flags and writes the whole set back, so FS_COMPR_FL is
in the new flags. btrfs_fileattr_set() then calls btrfs_set_prop() for
btrfs.compression, and since cf1afec09e9f that runs
prop_compression_validate(), which returns -EINVAL because
btrfs_inode_can_compress() is false for a NODATASUM inode.

> So when setting compress in the first place, the NODATASUM/NODATACOW
> flag should be cleared.

OK, I will do it this way: a new inode that inherits the compress flag
does not get NODATASUM/NODATACOW from the mount options, and chattr +c
on an empty file clears NODATASUM.

This differs from the documentation in one place. btrfs(5) says that
all files created under nodatasum have no checksums and that
compression is disabled when nodatasum is enabled. With this change a
file created in a +c directory on a nodatasum mount has checksums and
is compressed. Is that what you intend?

In chattr there are two cases where I would not clear the flag:

- The file has NODATASUM and already has data. The existing extents
  have no checksums, so clearing NODATASUM would make them unreadable.
  chattr +c would return -EINVAL here, the same as setting the
  btrfs.compression property does since commit 0e852ab8974c ("btrfs:
  do not allow compression on nodatacow files").

- The file has +C. check_fsflags() already rejects chattr +c on it
  with -EINVAL and I would keep that.

One more question before v2. Files with both flags and data can already
exist on disk, and chattr +A on them fails since 7.2. Is it OK to leave
the compress flag and the property alone on these files when only other
flags change?

Thanks,
Hengyu
