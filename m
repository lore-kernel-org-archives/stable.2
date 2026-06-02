Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F73CC330
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392604; cv=none; b=fOquqygwOtY3pp7sOhTd0mmNT9bqahfY5Cgvtjpl0PqM/WlFXOUjvNlKK0Gw5+he18steVPhleWfRb/pmkwFdPcnQKHzwN4DSSX9zg21sf/fhtvmtZBQaCBkk/glyePHc5NHrvIM+vfCpcKolSt70b8JJyrvCVlc3KRLb/Adls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392604; c=relaxed/simple;
	bh=xoZx8RO1JgKb4KOJkIsXr8a+Y0iiGh5oAeIjbm5rPIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkm8BV7gVMFFLklcdT4DhqQs6YaY/Q1jOMOs7GNGheq5S/6KBdo9xPbd8KM1DKa+OqmO9sigsvgORiJvQsffcDph+++2NH1/EeMXgF7hGeGY2aPqcGwcBcWNYMiaKQ3eYmCgua4mkzuwbBqUgatUTOVyGPNW/V4Dr44pTs0e428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE2NL79+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE2NL79+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-46013161068so917673f8f.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392596; x=1780997396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Frm7yzfjQmQ0s/P5aAd6XoliFRyibz6oy5ir9ZFIkF8=;
        b=YE2NL79+4J8j7W3/6ubXlcITLloedxvqZpk9LcnKBzHgpO3X1KEpaOOJJ2SDeuJEFd
         Un6c6xclFE2oWFhFnrwC9V5pvOa/zXca+efVAp4ZqsbhMQsx1fj0zDFLEgY8y8dYqnD4
         aARTIk28XVZjboyJAEF6QHDzqk8PQf8RjUyyUvoiiYZmmCy2dWMVD0LQhi2BW133b8ET
         bc5i0ekqn0nN3Z2FKZVG8/+arNGcMNuFOweiVhNiDPYM2E3mFq54Yc5KsO51H+wlU2de
         L0lMNdeDZwYc3IjMLCMELaGlGDxJPS4EnNlloY/wiDmTUOQPZaNiV/wc5mt7fVa2T5YR
         xMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392596; x=1780997396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Frm7yzfjQmQ0s/P5aAd6XoliFRyibz6oy5ir9ZFIkF8=;
        b=IjDxXWm6iDVC5kUZHry7S4t1K6B/TjLHVHXlwIXDKy/nQjXK1Wea2ZUh9b++TfG6y8
         Q1BTYiKMFg11l9hD2GcEnWbmInNPKV4E+gFRKKLpL8dCJN1/GKObKvfVasbEAwi0/vUR
         V9ndUTv1TKWwjHNjJdP3wPr3Jtah7BpyroxGx2wx8hfsDxNTCbLBzLXIEWsxEYv8JDa1
         oXm7GNKxkJT/CErTtKdXm5lFsrPK3WhlMSulatLa/hk1bxOlo07TmCyqRQGtn8sqjUNg
         lTW0blPyahTSEZXWq1rExCQDOsLxrXXf6h0WcrXhLQHb8bAf4rmW3VMsn8f+3RlGuL0a
         7v2Q==
X-Gm-Message-State: AOJu0YzO4+Pikk09F2QIrsqhNZ+u4/YQn1BlIg9TVFdvuErCw5p5UWwt
	uMACqavQcdWr5BavCOUVA9xB7DvPCe7e+s1xf/jgcrQ3+z2ucYNDCRt5xfqJBEcj
X-Gm-Gg: Acq92OHDxc51F1q+RdbdCt66+mbSw8TZ3gmskYvKE/QfL8yxg3ebZKvuh6/Q1aT4WL0
	rTGabW2NgeZ6GYzTaG+05/UI8V9s4qP9loyF4xj38oDIoYPovpRv2GL20OLGyUGBz7k1J4Mporz
	LwdtuDXwGSa9i4WcjgzEVMGkSXbN+3pVIrgt5/7KaZaFlDGMBrq50dcEOoJIRqfU3v0sEr2q7GQ
	lS089SSodmQWwXDhhXoWm2Z0B9ITiBxInExdW43qq+Dh8Zk95njEy3YHqjefjFntEwVrkIBgb3r
	+UHdTqzE60jmCuNbNz/ttMo3yDDxe8GBg2Gv8VZgGjKk9vtsb7UuUzDBcOigxxwJdJWH6P079+v
	XOtwIHvfgEw5VzlmYDuiCskIiCu5lp4cbkRbh9dvKzH1tbV8vuflS09KeoD4/QIpVmQ3pL5gzYu
	ln8oGzVFzC1aoDx/g7m2QSMeVGa2RcwdZcn5OCRN6Jzt5IVEFwIkNRm8Xj05AHOeziwIPnjmkkn
	Ckp1wGDgpWY1t1m0BCb2dTs3OVwQxnc2Npg79a2h7QdaJNn33dAsFRdCq8qIzz7NtESfxG+jfo2
	1oJaHY8J0h9pT+TFKsEF/NgwD0XDZ4HuNWWQDb1hQkYivwvbQOuALG1J+RwH8s+q
X-Received: by 2002:a05:6000:4284:b0:45f:f142:d56c with SMTP id ffacd0b85a97d-45ff142d715mr21823115f8f.16.1780392595787;
        Tue, 02 Jun 2026 02:29:55 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34bd896sm30652587f8f.14.2026.06.02.02.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:29:55 -0700 (PDT)
Date: Tue, 2 Jun 2026 11:29:53 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y 03/11] Revert "selftests/bpf: Workaround strict bpf_lsm
 return value check."
Message-ID: <7f512c0b1ad316af9ee70322a2fd2ff867f0c43f.1780392092.git.paul.chaignon@gmail.com>
References: <cover.1780392092.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780392092.git.paul.chaignon@gmail.com>

This reverts commit a1914d146622 ("selftests/bpf: Workaround strict
bpf_lsm return value check"). It seems it was picked up by mistake.

It applies to a selftest that didn't exist in 6.1. The whole selftest
was then backported as a stable-dep in commit 45108a7b4866
("selftests/bpf: Add tests for _opts variants of bpf_*_get_fd_by_id()")
(reverted as well in the next patch).

The new selftest covers the bpf_*_get_fd_by_id structures. Those don't
exist in 6.1 so the selftest shouldn't either.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c  | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
index 568816307f71..f5ac5f3e8919 100644
--- a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
+++ b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
@@ -31,7 +31,6 @@ int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
 
 	if (fmode & FMODE_WRITE)
 		return -EACCES;
-	barrier();
 
 	return 0;
 }
-- 
2.43.0

