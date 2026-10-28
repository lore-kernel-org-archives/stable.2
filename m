Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210353;
	b=pHx8l6plxTe4NrgVPyHlU34XtajJRcpk2smtkB1UA+kOdZPr7p2bGxpzcRHHWGxp6DnS
	 Q2Gu7C9BhQAZgBpS38MudW3ehevJJFvE4BJt9H0V6MfVXpVv5kyp4sd5XfSJfH4GBzy2I
	 fPnJiil5fTWWTOe5mptQLoKOyO/B+62/i6AvJ9i5AzS8W+q2gmuW3dw4Otu8cgKHOj7sh
	 nEri+apgoiV3GzH0U4UvHkHZZCKlQOZ4J02BrE6hR4dmmn8cQ2vpw9tma1HXbqPdwwqDi
	 yNx+ugQtzkS45AFf8EHyiSzfcT0CtXln8Ix6MuKDSym4v/ZK3LcEjs0HPJrOPe20FSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=ZvPsn+Javfxdic0EX1jPT9Vcq5WYjZk33sRjXkfQ/zc=;
	b=D1U3+8D7rA4MNVf1Ejj7fw0Rn2WPazYtdInU8P72Q/60EKNX+YdBngkzcLCSgTnTMZO+
	 9JZWqYYNdEv1hd+Zp5asAXOufPwo81jYn1DQf25COsCgnraZ/j5XLFjzQ3tjU+2lEltwq
	 vboMee3EISwXpByEOmKvnob6J9/21DHpyWNN4zLikanzvYXcNWsDtZ1tq6pZRsj3NHFe5
	 xRM0ZYrg1M4J7hSpxiJXEPNmfWcgqntHkF+skbNGV7IR8q1HsU2RsZqTqXE0eNtcP6RFg
	 usLskp10BnDseDAtE8RL7aupZF+P+8Q1Pq/dGX4ay7hM9xnFhOBvDCa/ffW0G4cUhLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Wmn4aFNQ;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D80606A322
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D80606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Wmn4aFNQ
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso1488057eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793210352; x=1793815152; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZvPsn+Javfxdic0EX1jPT9Vcq5WYjZk33sRjXkfQ/zc=;
        b=Wmn4aFNQPV+/h3cimcoBx3Blcz6iyQnYRpJwrHP/pdEpOUhpjf5pT8p7AhvUcthaGj
         Amc28W0QsTw1voP1dOFOWTzC/d0ViPDK85y+1NlmF9QYN9JT66nnTd6VR5fS9fwQXFbG
         LH/Q/nR2Jf55m7UvkDSZz9JBDNOhY4vkUCTfdsMmaOzQbzVpIsh9zLcRblfH3tbtVgQ2
         slG8Gdl4cLjWI+NSi6U3YKSZB0hJPzVPJzTJ3nimZsXurHQIUyXog8qMA/US7oq5r3yp
         On+GYv9SG94lkWuA7Ak9Ku69TjZ4MuQA3cRbbS72K/xK1OVlv+1yD5Fo5a7A6PQucqsz
         qepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210352; x=1793815152;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZvPsn+Javfxdic0EX1jPT9Vcq5WYjZk33sRjXkfQ/zc=;
        b=QfO8hqAoaZFSAiMp22aXjBJ5Wcg9F5BXCUFKJ0FOBGjbbKdBdr4n+WPTMtP6KPbmC/
         MTf2UJ1EVowS4y2PqCZGOLJFGql0MvYMExsb5WK8UDrkJjdI9Rld83n9thjB9C3TLAvo
         fCRqpsSQPgBXP+VbG0ZKWuXvZcTiBZgdSWn4khMAWgRhajxONW/bH8RIk86PuOYcvF2O
         ljiiXpomI3VMs1PnXHKFuCVSWXzwQugNKUqKNPYYpO1OzCy+rQparIVZQvTb77O6EgUK
         hGe2qTXH9QRxiyPBVyL1I3eKwEp26Bw+ZPMFl41/GAuuXNviFyUWEQ/W+RcxWlrc2BCP
         tlnw==
X-Gm-Message-State: AFq9FYKOCocF8V++2Mei2NEI8dY8H3VHxPdeRt7+jMP/iK3d0nWByE1q
	oPeOm5s0/jFSe/6mWFyovPEb41W6ZyfJSjiSxvkU8lzHjidwyAJbrFTMFQikXFdItyPoTpHSC3N
	dRHu8
X-Gm-Gg: AYBFou22wiKKzh41eumupYjX4k0IMsVMZ00F1eqdVPtiEFCjATSEKo9mO1bRhFWwWcR
	KPCTmv/uWD3eQlqFe8bnZGfq49Z/QrU8t8fur5pL+Ig80MMyavcATviH027c/HNZjh+BPiW/ZuL
	Bj70vWMTY8QiOA8uksJoDx6vsWBviYF9iA+kN3ZLU6SRIqJIdftvQvsBHSufI/HPGCHC41fu3t9
	eBb9V29ixvT8Ryb3Bw3kqi+QnQJweZGEjtFcHhwicay71vx50YOx45Pq66/YsQpMAcIFfe4Vxsp
	YNDGaDORtF30f1BPJpENRJjeKEyQ8VSwuyGk0KDYtamcbPwcC5HuRVbxc0Ki2thIdcz7OVLafKi
	cv3l8svEbuOzAgvEFzwiKRnBLS1ntnD9hai/Pn4nymE+fC1Aclbd6BG8xSDswDB4PbApRKd6sM8
	GbvAoJvQEFf0aCejvh8cAu439DiKm+16gCpR1f08knX9CcF+kc9a83nO8txJOSa5QQzgswmb6MJ
	AHxzJqbDgzHTtszfCRcZgvNF+TOYNW24NsyWpDEQPvKAxWEipwFuRLD428sufOkVHbHb+VRG3Du
	J+an5O55p+jRhB5VUj2qAA==
X-Received: by 2002:a05:693c:240c:b0:369:b75e:d24f with SMTP id 5a478bee46e88-36a20108feamr4080436eec.24.1793210351652;
        Wed, 28 Oct 2026 10:59:11 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237bddb7sm7634777eec.3.2026.10.28.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:59:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REGRESSION] stable-rc/linux-6.1.y:
 (build)/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit decl...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 17:59:10 -0000
Message-ID: <179321035043.43309.751982386555331792@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration] in init/do_mounts_initrd.o (init/do_mounts_initrd.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
                 from /tmp/kci/linux/init/do_mounts_initrd.c:13:
/tmp/kci/linux/include/linux/highmem.h: In function ‘memcpy_from_folio’:
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^~~~~~~~~~~~~~~~~~
      |                     folio_test_hugetlb
In file included from /tmp/kci/linux/include/linux/bvec.h:10,
                 from /tmp/kci/linux/include/linux/blk_types.h:10,
                 from /tmp/kci/linux/include/linux/blkdev.h:9,
                 from /tmp/kci/linux/init/do_mounts.h:3,
                 from /tmp/kci/linux/init/do_mounts_rd.c:12:
/tmp/kci/linux/include/linux/highmem.h: In function ‘memcpy_from_folio’:
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^~~~~~~~~~~~~~~~~~
      |                     folio_test_hugetlb
In file included from /tmp/kci/linux/include/linux/bvec.h:10,
                 from /tmp/kci/linux/include/linux/blk_types.h:10,
                 from /tmp/kci/linux/include/linux/writeback.h:13,
                 from /tmp/kci/linux/include/linux/memcontrol.h:22,
                 from /tmp/kci/linux/include/linux/swap.h:9,
                 from /tmp/kci/linux/include/linux/suspend.h:5,
                 from /tmp/kci/linux/init/do_mounts.c:7:
/tmp/kci/linux/include/linux/highmem.h: In function ‘memcpy_from_folio’:
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^~~~~~~~~~~~~~~~~~
      |                     folio_test_hugetlb
In file included from /tmp/kci/linux/include/linux/bvec.h:10,
                 from /tmp/kci/linux/include/linux/blk_types.h:10,
                 from /tmp/kci/linux/include/linux/writeback.h:13,
                 from /tmp/kci/linux/init/main.c:50:
/tmp/kci/linux/include/linux/highmem.h: In function ‘memcpy_from_folio’:
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^~~~~~~~~~~~~~~~~~
      |                     folio_test_hugetlb

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:cbe9d20ed2024c88cce004da9661802e1d8c6041
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  406de00ce2971abe3010eaabc26c71e84b4ee9b3

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae228665c0836a8c2f04729

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae228745c0836a8c2f04741

#kernelci issue maestro:cbe9d20ed2024c88cce004da9661802e1d8c6041

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
