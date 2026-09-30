Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF8463B9A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756399; cv=none; b=PH0PWOBobaM3ZLs+vJ5o4nzCumPtErkZ5T4ggFI2cdKxcAbBkYg836Zj0PCw639L03kiZVEDE+JruKxZkbFnQ2AkCK70nH3fuUyA3xTBw6CRo6vpQsMNqPfbnVVtehfTaQu+a4XTk5IweyyYml3v5rCh57kKN9OaIS4yJF8B8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756399; c=relaxed/simple;
	bh=enU0N7uRFm+CiPQQfCZQiNG6I6dn5+gaY0icBM12JG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vb1P6ACtmT5ufB90jllCc5fzns4eFFio9zxdERklTOKz9WmrUPaaCWhweQXtcwVUJFDBZw9OxKjCZAJXEp7o1yXKDkSVX7eRAifhydTmTauA+H/5QCn8ukine8yDSZTLQG66QUw/7Z5OcndlmLkKWUTXY/LDBqZbkWS5D9JaVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asMr0gWv; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asMr0gWv"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4d04d740cso1939885a12.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790756392; x=1791361192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5r+yyKKy88D8/jouNE3+ZYHc7zwXUtNu9IJ40uPJuDQ=;
        b=asMr0gWvrTjdxI39gvU63MGsVsS8zzt/NXQAe5Ggx7HuJn8hMSIhI18zUm0fJlb8R5
         eTHYWOPiACH+SoRFUG6qwnl3biyF50pCxWsKoHGzf5YOr5wztF0K2Xu1ABJuSaBdtQwO
         e6fU0sPfju0cSxXMhqAhggK4yKc3CDE2TTOLNeHxM4Q0xtW1DRxWxPUio5BB6bCxJhbQ
         SEtDXM4oKizoPjao9i3Eam5S1/bkXEAgv6iGIaRfNf/B9oLkdzF2WfxfKmKlCd6nshej
         53okj1UGRonxBFk9p8xT+FYm+iy0RuZc/wRp9K8qciHNo/+0Czp6vLHfB1kQWN0E26Rh
         Biqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756392; x=1791361192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5r+yyKKy88D8/jouNE3+ZYHc7zwXUtNu9IJ40uPJuDQ=;
        b=FwI6jKfbRvskN0hufehHQ2LeUuT+8+W2ev7CpuRRZfoRDJeCRJxu39iqZGehsFlhnh
         Dm5vzXeljemA4GocI3CGznC+qmWp2DvhBiqY0g9NmScSPF+uAZPzdBlenI4K1MyeQqbv
         HgPGqHrKew5vHdQJRwdKot+EkEALJeaxaShPJnhZUaMvykYl/H1H2ELZAKYhCLyOWWRm
         7vgoPEbToH9cbjK0D4wiz5chkZdnJVf+03pUuhG8CGYjNJCyBtq1PAnqCe86LBh+P2Fq
         mcjUMGt/0094S3iceDFLkEX+kfk7yHm1VQPMwCzM9RMDRULHe7GFAMjZXwKPn+RZWt3r
         cxmw==
X-Forwarded-Encrypted: i=1; AKwUvBwTzlDS3lXKF6IM0qhsBBM3kovSnd8t9+/0oLURWvGUKBmr1cWt6WLq37mmqxF3bQeLcCDAa8Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nfxjQTXHk8NBmUVL3MglkPOYA9jqlSQgxwQKJZYceym3VHPB96
	7KYIDYytTQBiw8XL3DQ5g/8mPUsK/Q57cGukIZSQuybOFaaP9FtXFUeS4Kcyrldp
X-Gm-Gg: AYBFou3/x6y7UDZrbrqvdh6J8MJ7aBo/NuDFbfzRLVNc8eC1ciqi0VtZKSGygp6zz+z
	e2wZIkS7EZeRVFIdGqIdC1WIH6teNyMS0AWU5iSjqFL869IhqVNBtN8i4VVVV9vuy5iZATXrpok
	x2VuyBacqPnsDsiPUTjm1GRA1zdeKaoD+nkQ8W0kX7ho6VDleENBMxcjyjHc+RqJhV9i6Rce5xn
	ia9TbY+MiYWNXrpGQliqiILQl+y+yyfFC4hs5JDejYf5iaYNRS9Lnv+tNpERweeJ8SKfArl5LQf
	MY3a8jPtw5ZfqEpD9E4gQvG9CYwqlEmXZHZVjG3hig3gaYEFBopAftrCY8G0d7WHnhp14vFq2cN
	wi6+dBIo5TdMEK1m/3IyjOIUqsiqLUGCXuTFIZDKisP/WxHgkJN2oMm1RO1wAz7fNVtdyLkHz0a
	xRX7B6des7+u+gl8e4UU29oUCFQyCkMjHKZLFQDd+LWzhV+VTeAap5qVdKDZzgPYC60OYo0vwS5
	S/bKuwmyMSxJzzTPg8+xikUZuBtx5dhb2L58nDUOB6hDXzf9xcz0pqMU3kyREjOJNkoprKI/8jq
	Au6VW1Khcw==
X-Received: by 2002:a05:6a20:d791:b0:3de:2d39:b5fa with SMTP id adf61e73a8af0-3de9e6e5c96mr587085637.14.1790756392513;
        Wed, 30 Sep 2026 01:19:52 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7da126a49sm453319a12.7.2026.09.30.01.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:19:52 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>,
	Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5 4/6] qnx6: clear sb_buf after brelse in qnx6_mmi_fill_super()
Date: Wed, 30 Sep 2026 08:19:45 +0000
Message-ID: <20260930081947.511613-5-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930081947.511613-1-benquike@gmail.com>
References: <20260930081947.511613-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_mmi_fill_super(), when superblock verification fails, brelse() is
called on unselected candidate superblocks, but their buffer pointers are
left set in local variables.

Defensively clear sb_buf pointers after calling brelse() in
qnx6_mmi_fill_super().

Fixes: 3377755f1064 ("qnx6: add support for MMI (MME) media filesystem variant")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v5:
- Updated commit description to clarify that clearing sb_buf pointers after
  brelse() is a defensive cleanup measure per Matthias Goergens.

 fs/qnx6/super_mmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index a8b512c09890..19f123d45678 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -102,9 +102,12 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 	if (fs64_to_cpu(sbi, sb1->sb_serial) >=
 					fs64_to_cpu(sbi, sb2->sb_serial)) {
 		/* superblock #1 active */
 		sbi->sb_buf = bh1;
 		sbi->sb = sb1;
 		brelse(bh2);
+		bh2 = NULL;
 	} else {
 		/* superblock #2 active */
 		sbi->sb_buf = bh2;
 		sbi->sb = sb2;
 		brelse(bh1);
+		bh1 = NULL;
 	}
-- 
2.47.3
