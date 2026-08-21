Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A25363C55
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 20:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345366; cv=none; b=tI/n5xPtJP/c+icwPnAMHMC1ljC94wN87QsHAUTx3AOk9j/zrYe5rVdgG7by4MeE85+Vt0ukcd8OjvnG5/zprMXqzelVxgi+4u2j4dbVEmfGm2iSjChZm39crQqrtWIzWNvZXp1rczum1cPm7D/8FoR+ZglJczU2z/FFXgXddtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345366; c=relaxed/simple;
	bh=kqSSIILac7u1pKPNOUJ/EuEid7Kx/XiiY4lOm0AmR9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D84cr3R21dHleTv1OZXpxgf3kERjPYnQywBnFW5HNVKkwa0B28KT7VmhUDuFtTXPnQVQkCTKxBMF529kOmELE1LVcGuRM1N5LijEoX0jDKclyD7EMWFa0sp72GHNSRMmaYylFeMB5CQKs5NLyF1vAG/1AWnDnMZAtQHmPzxGofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anthonyvardaro.com; spf=none smtp.mailfrom=anthonyvardaro.com; dkim=pass (2048-bit key) header.d=anthonyvardaro-com.20251104.gappssmtp.com header.i=@anthonyvardaro-com.20251104.gappssmtp.com header.b=pxNlgQO9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anthonyvardaro.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anthonyvardaro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anthonyvardaro-com.20251104.gappssmtp.com header.i=@anthonyvardaro-com.20251104.gappssmtp.com header.b="pxNlgQO9"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e041ea211so1311899a91.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anthonyvardaro-com.20251104.gappssmtp.com; s=20251104; t=1787345365; x=1787950165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kqSSIILac7u1pKPNOUJ/EuEid7Kx/XiiY4lOm0AmR9M=;
        b=pxNlgQO9mm++xzF4oXrefkBI65NmRj4cE0PEedeGWceXW7ZZqIwefKR8zJTqWW49pU
         vivmGkd3PuuoukiW21eRFTEM7xAUsAQt0Ej2guG4g3I7iUHnprHcwz5wKp1fSZ0GHW5z
         xGC7EXSYdCBIO2gkBV/eOcrggfcIHRgDw5dNp3rmTldysedffpxbUKAvqm72xFMBJO0o
         Fue3GwRV1Ag9amZ7js9v93rD8a1zIkdAPa4mhXIPCdy2YclpWWExTvsafOwo7AYPn0FF
         CvlNUtZXMvQhFOEweheJZFbgY7F2to6+7n8juJbTlHhkJeufngmMyA/3UZIpJBUkkoC6
         wd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787345365; x=1787950165;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kqSSIILac7u1pKPNOUJ/EuEid7Kx/XiiY4lOm0AmR9M=;
        b=cEDV50P+80WxgQJ+bkKdqrj7OYHMlIiLsSs+MN6mkukrIdG4PwhWgbncQXGlREyMcd
         xWfjJ+4ifr0/cJuaeg8jJDmhJoTDlgRjbLf+PujIOEVW+X2uyOQ2iQd7FJv6hma5gMjO
         ifqC+b7T2Rn3uDOeNjDG9iMK5VFGjfQzzAnXGlVHwMWosUyUtZbJn4xCate429k/Prj5
         yb/X/DALYR8slFcMlH+KmLQL098uncIrJcAafnZIT0y04uud/P3reH8uPT86PsFV9eNn
         lPgjqQqUUcrdZniilGYTnWaEaWD07g8pg3FpJJpNm5gcd79An1yRbEJu1Z59ZLQFLXw7
         3RVg==
X-Forwarded-Encrypted: i=1; AHgh+RqopSni5dd3GWd/nwaRVQgbKNa9U6SrYPLVDRzaqGE3Sqw/8ugT6TJJIX8RzpCp/JWk2N2DXms=@vger.kernel.org
X-Gm-Message-State: AFuF++khTbzmz0sSFe9OAD1ufuVHYQiY8bQQzMnVJgOpY7YA2aYkPYdC
	Ls4htIIp8fQnqc4cA4N08GBOf9wmZlUmwVQX33ThGv4ZOsDnQG3KKiEVaV7QkvFC5ds=
X-Gm-Gg: AR+sD11LIjANp/Y0moQmMcC5VXpsM+Elw8t3Qncbh5O/X1aq+mwBIukYW2gPOFAQFaG
	9Ccf7g/HVr3LhCXMnQeXmHNHOYpfO+NITrBZ5VB3YnKlulkFVCdTLmujhuL9X+/HsMh43zc/5FY
	TLspVMobvf8Hv4LqbMhEOK4/GNhv2fbIeOk9TYnxSQsYmff3Mc2FNDlc/kl6Fbpqh5D2pT21ltv
	svOLthLjE+/aGl1Erxv1L6pwX2NzNqnx++UIrM2RQrhnGesaePRNpvGVxjeXICiQdCyzLloeD8n
	RevAWiY3gmebeedbhfpgrIXdz/cMsjEM35owU54G7RDs9LpdvjOY7cniP2Oyp2IzsOijgtp/s00
	+jYLtQbJwnpGcB5u9l4Rysj3l8Rf8czY+S5SHeRU0Ea6oHol36IWfYuYQUAbJvwpkU3Gc9Y/zH5
	AW/ozi3HYpwLnRr2J7W7WqkjcOSv5x/G0fSVnCBpUvqUBYmr+y7Ku+x1pcAChMwmaHos3ZJDKJX
	AZEuwDAwDO2y8DfI2gKmHnzW8x9EP6sQgIOWnAjs2CRQ4C3isZNrVXHeLpfVb1med8O62/6MCwk
	wZzCwz2agPYZrSC80Xwe0ETJpes9efH2RC35CgAgOkYj17BvszY=
X-Received: by 2002:a17:90b:6cb:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-395c2f13243mr17933317a91.0.1787345364660;
        Fri, 21 Aug 2026 13:49:24 -0700 (PDT)
Received: from coder-vardaro-vardaro-2-0.tail2dda0.ts.net (ec2-16-145-69-213.us-west-2.compute.amazonaws.com. [16.145.69.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2af01sm101253a91.14.2026.08.21.13.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 13:49:24 -0700 (PDT)
From: "Anthony Vardaro (Anthropic)" <me@anthonyvardaro.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Anthony Vardaro (Anthropic)" <me@anthonyvardaro.com>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] xfs: revalidate cached COW fork mappings during writeback
Date: Fri, 21 Aug 2026 20:48:43 +0000
Message-ID: <20260821204843.3223395-1-me@anthonyvardaro.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820161123.GH6072@frogsfrogsfrogs>
References: <20260820-b4-xfs-cow-wb-revalidate-v1-1-8a19080799ea@anthonyvardaro.com> <20260820161123.GH6072@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Thu, Aug 20, 2026 at 09:11:23AM -0700, Darrick J. Wong wrote:
> The buffered write path has similar data/cow fork sequence counter
> revalidation code, so would it be a better idea to adapt the writeback
> path to sample the sequence counter via xfs_iomap_inode_sequence in
> xfs_map_blocks, and re-check that in xfs_imap_valid()?
>
> I weakly hinted at this a few years ago when we were adapting the
> buffered write path, see [1].
>
> [1] https://lore.kernel.org/linux-xfs/Y2mcOCpKiDb4nf1X@magnolia/

I think that's reasonable. It's mostly deletion since
xfs_bmapi_convert_one_delalloc() already fills
wpc->iomap.validity_cookie. I'd still like 1/2 to stay the small
private cow_seq check so it can go to older stable trees, which don't
have validity_cookie or xfs_iomap_inode_sequence().

So for v2 I'll send two patches: 1/2 for this fix, Cc stable; 2/2
samples xfs_iomap_inode_sequence() in xfs_map_blocks(), compares the
cookie in xfs_imap_valid(), and removes data_seq/cow_seq, with the cost
measured again.

Anthony
