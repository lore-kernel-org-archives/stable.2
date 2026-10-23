Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776785;
	b=vCqQetWJ0X0D4sbkcFesMaqj7SMAvYez83DDZfWfma49nNRD/3wsgNBp9KBA74ibC27p
	 5Vx/Y2ytxA+3fy709gUYMrjT4hljxM2Ui1aQLNe2DtOAIJT/3ru3L0Iqt91j0CW7ulNoq
	 S9Lm3o0Kv+ShoYJMlXkpkCgZMErbNROHb0zuMyvWa6rVgXxHJsqiuK9EzDvtT/fn2LAez
	 kazNM+hvK2FaxUMRKRkEhbvldYS60wZcRWUSZfyD8ZN18eQiL+kDhASRqpJFIVS0LpXT6
	 9BxAAxhHLohY4oHQtBRBdPw+ydupanA/ALQngLGJsZh8Fer3s/CYAWW9Aa919THertQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cfFhlHkKVrFXSmeZYo5gvz1zhcXjNjoycIItBCRV3ic=;
	b=0jTnae3dmcq2q8ASbn2kKL42PnyhU3ctpkBe4PYFVdaOgOMbpCyzcsfyGrH2MTtOo3eT
	 N+Lpzh5hanMMNJMIdcRFMaE4nQf8bB3m+lLLASIO+czS+d06JYbJdtM5dTKHniyRhDQVF
	 0X0oxfEzyblUN4cyuQ8TXr5ThhSd7BF2ClpBUBAGWk+EB5ACW5qmlVx9tDPQyGR5GAnjK
	 8Qmk0YTlPgJ1Mrs5cQQ71RkrPbS+Qq8E7Ml0npvb4oX8lS/NCO15Rms5y8G1gtxwmeWF+
	 CnslmS8JsC2nLwuJ2F9fjSPEbjYrYgiRqUm6LbDdt4meiKL7nrQLnIFfnFcz0Oh+Y7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=VaUL86p9;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF5C606A31F
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AF5C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=VaUL86p9
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ae8607e8afso8938057b3.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792776784; x=1793381584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cfFhlHkKVrFXSmeZYo5gvz1zhcXjNjoycIItBCRV3ic=;
        b=VaUL86p9W8Ij7nYadvTnLVjLIfxoXTnftnSupztuaXFLBc6HgsqzB7Ud1HU3voaBfV
         c2YTLHbQHqYx2hkLgch0SU0B3lGA/gmKMIPW9VNGGCnHWFAFLxwS484qhvmHUJtoyB4U
         q2lFWjW0nq/2sf7CYgxkhuwWcEw43EF6y5znee2MjSsvzNxINWEHc4ljORwkMTsmrvPo
         s7HWAHb3HuI+5eNje7YQ2qyjU6I+vqiE7JDVD+pvU5F1MR6onOkC7wwX8GdI8yxmvUws
         5v5BFI9yt3KWaO3GLPyjmFYDh/LS0ZqzRrqFuwIXL7nRitjGWEBgml9N7vpBtdPzWlzv
         teXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792776784; x=1793381584;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cfFhlHkKVrFXSmeZYo5gvz1zhcXjNjoycIItBCRV3ic=;
        b=TsBKCEt3TulWVMKSAka0V49lzclGvFjdztxmssU5mLSFD0BMeRkhq5PY3VA9nK24Q5
         a2YjDOCXXvCEnukubr8yQ6A/1dnrzRQxshzYmK9jTdczV5GYfwg9clhIW/LtK8EqGNxs
         ylQGAqI9uj/cNc5mtFEMRA91/w1ict+IDS4EiZ1ymkfD14VeKMmLVNG02GU4wH+Po6W2
         2Y+RnBIfGzxz9hSBlZZSkY580oNwmFNvZzmGprNrrNRxEVy8WI5WEOzHRTzbz5Y8uy2N
         ZNbovh5pekIqtVZ+KKxFgV5tkZMmjntdhm8FGYb+SlmL6CQWCEk2ZlQlmK1dmLelhOy8
         oU6A==
X-Forwarded-Encrypted: i=1; AKwUvBxgXl2iIyirwU0N497otGl621394TBvztxGatnIyh/QUdlBPGID3B7HI7pCTxJ4Lukdd67B1fU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiwD6BQzfk8TCcqk2qp23ekExv254RGle8xuhalrOasY4Nyoio
	m+KIsPuREW5B0ms1Sj/GzN8+E6E9pjHAdn6vEFXuIzw0h2mztYsPZ/1LCYC0C1hLwTwbI/ga2E3
	VPrWcKg==
X-Gm-Gg: AYBFou3rvJdc3JVwrp2ZVkMTnitgiHSqZQD7m7KTTVxdrqGvLzdpFSvrgEgs6X1GudC
	RYJeSPKnlzaZUaQGAuT9Yaxb/uliujY3AnqitvoZ/PCJKa1ZQBAG8bdG+OoNjBhXxCUeb0J8DVv
	sVvwixX4kBCMLlUffipdJs0L8sEWNRoUaYo1O/qAfFhvW33ztes3wq4JlC1m3HScwbxmpKR8cBG
	DhAMT8efFbzqts+IsndDfKRiVLxIGOSwwPSeoJ04iy+r7nE8Vt1BIRhcgTkGtLmBq7MCj0RD9+v
	s10YxbsnCfT0va0oXUov1rR+vIGK1pVVrXcq6Zuu/2Nl1aGYkZyxSJndxhaOaa0FoQm44AIbrCs
	fsT/MIyrVzauti3NVtRnILuJeDqOutZkfiZeVtHvi26Lg26aWmkYNduyQnagTfMDWAnYZMpXBp2
	Q68W56A6fdgNMFtGudS7h8r3b5HeIAADvWiMcl3n0kQk9RVDadcfg7Sz/cl2uuk0ZOtvsRZlQRJ
	Ff/TYxIuwnlYIcmPD4irF+pSu9yuHtq0VpMx76mByFseFG2eaKhCVLrXwjv8UnVsWfMwvfPn0fd
	t9SSlc8lN+8LVwzLQEDBRcA=
X-Received: by 2002:a05:690c:4f81:10b0:8ac:d999:c588 with SMTP id 00721157ae682-8b157ebbd25mr16750107b3.69.1792776783879;
        Fri, 23 Oct 2026 10:33:03 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b163d54053sm2770937b3.20.2026.10.23.10.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:33:03 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
Date: Fri, 23 Oct 2026 13:32:59 -0400
Message-ID: <20261023173259.3275078-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cd6cc32dd2aae90b88b4c3d19e1fb35a5be6f4ac.camel@dubeyko.com>
References: <20261015110114.1649059-1-hengyul@cs.unc.edu> <b6f1cb66778d09015ad5862ff273edc37c44ef28.camel@dubeyko.com> <20261021153141.311425-1-hengyul@cs.unc.edu> <1797b66dee80c9553748d4a961470894c917bf5f.camel@dubeyko.com> <20261022120658.1328124-1-hengyul@cs.unc.edu> <cd6cc32dd2aae90b88b4c3d19e1fb35a5be6f4ac.camel@dubeyko.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

On Thu, 2026-10-22 at 15:40 -0700, Viacheslav Dubeyko wrote:
> (1) Check that deleted CNID is the previous to the next CNID. If it is
> not, then do nothing.
> (2) Oppositely, we need to execute standard b-tree search in the loop
> by decrementing the CNID.

I tried this loop in KVM on a804c5742bff. It fixes the first two cases
from my last mail, but not the third one. There a (CNID 17) has no
thread, so the search for 17 fails, next_id goes back to 17, and the
next file c gets CNID 17 too. a and c then share one inode, and
fsck.hfs -fn reports nothing:

    echo AAA > a; rm b; echo CCC > c

                          unpatched or loop    patch
    CNIDs of a and c      17, 17               17, 18
    cat a, cat c          CCC, CCC             AAA, CCC

A search by CNID only finds threads, so it can show that a CNID is in
use, but not that it is free. A file without a thread has its CNID
only in its file record, which is keyed by parent and name. That is
why the patch walks the leaf records when cnid - 1 is not found. Its
first check, do nothing unless the deleted CNID is next_id - 1, is
your step (1).

> Potentially, we can consider to have a small bitmap of allocated CNID
> in every b-tree's node. Any other optimization ideas?

A bitmap in the nodes would change the on-disk format.

Deleting 8000 files (KASAN kernel):

                                   unpatched   loop     patch
    newest first                   13.1 s      0.40 s   0.44 s
    odd ones, then even ones
    newest first                   3.6 s       0.26 s   9.3 s

The patch is slow in the second case, because cnid - 1 is free on
every delete there and each delete walks the catalog. One idea:
next_id only has to stay above all CNIDs in use, and fsck.hfs accepts
drNxtCNID up to 4096 above the largest CNID. So a delete could leave
next_id alone when cnid - 1 is not found, and the walk could run once
at unmount.

Would you prefer that, or the walk on delete as in the patch?

Thanks,
Hengyu
