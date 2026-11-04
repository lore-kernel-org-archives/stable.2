Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829549;
	b=QT8JablOVBavusWNAXJ4OKikbcszvexsmW96OXOwWbl41MmJ1/mlMLfir8o5IhRbMx0Y
	 oThMHIJsBCORe4ONqZJVCG9lqlccLAou1HZUMvb59zSHU2ZXavmHVv9En54KZcog6DSk0
	 FSaZj1XRrT3M7Fi4HdbJLUhkqRYLb1dKDAIQMTxubB0hCMFckpmFhYAX6or5o0l1O2VgT
	 OBJXFunzJewId1V3VFyJCAoxsYQ/FLlf+CBWj/ioyEsTnyFzC80UUZE650VJijGbOk0Fw
	 uU9xrIoDLpOWA0oAU6aU6GpymESZRy3N6WxMBnCHAu1lHY7L54ZzAqgXEPLAEtklWlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=ZkhxvqPukGIcBJznzX10lt4vtzyGYrCvHp5sOj4146Y=;
	b=ws+FlrqMkGyoAmt+TWzc2ConOlfc3GyD7BB7+QrCbr5aw+PSxQf0rbFzpW/JaiIjvhYa
	 OoV3noD3/6ArwGXmGTbtE+WWEw41RydHOYETlNOahumJbxXkSfskm5uAv8LPI/YjTWBUX
	 wqWUwlKXYuqvpiv3U2ixVwlpR2PePgUhWmLarAOiZfI236fOoZxSuY4w9o+rvzBp3TnGW
	 EocDtgq47qOQrHZukwiBLSe5oVKQBJ5O3ZWglNJv9or9M9idHqA0Vg1iBKS6jsZi58lnO
	 JtsmpJIdkH0kcWKc+g28F91EfjXibkRVU8u2sVR7Wob1/J2iDh2siPykaDUm9/qwyoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=PZbFVlou;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAEC6075278
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 21:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EAEC6075278
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=PZbFVlou
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35b2c599f43so532142eec.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 13:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793829547; x=1794434347; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZkhxvqPukGIcBJznzX10lt4vtzyGYrCvHp5sOj4146Y=;
        b=PZbFVlouG7VB6kYy8beMNvA6S4FF/SAG+ll+XybVwVXIO36X7ttQCSPdZeJgc1iWb4
         KcECniB1xkvc9o0S/l4e8n7z4cG1VXfpk0B+RIdb4cnedIId5WQPa2qJk0oe/P7qd6wF
         4dhmxJEilwwCZ/gi+OcL586BsMfsf27OTtzHBhz87B3DjcBOOgRAa1XpB6rhNHivxVFR
         TQs32QdZXWG2hPM6mHZ5EZuqV3c0O/JSPwP3CRxBsiKlpFFEJo0kes8XGI4rKVjV7wY/
         feo8NxWI3XXFpBMfy/Xn+WEFIANVe2ZHANH0Usa/f+Mrrwl191rj7b1oxuwlbjVmL2Fd
         NWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829547; x=1794434347;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZkhxvqPukGIcBJznzX10lt4vtzyGYrCvHp5sOj4146Y=;
        b=rTnnnP6ZRLBmC+2eH40xqjoyrB8BGXqzSNGw8OwY7rfUq4uJXkpTLLaviVYOnJAZxL
         BppMiDYzLXK7/PNeYwzM5MzTZ3juRuxsf9Bx7BUHDL59umednd8REtA5As2J/YEJIe8N
         lBE5JlLvImMaOZ3p531m9RgJas5ZlYR2ymmXz6maQQ0jTk7N31NKyMYvrIdMw6+ZJo/g
         ipuyl2YDiWJnNY28QooZGHgo5ul0BIRpmohoocYR7nPhp+Bwynhyu5QKBxod1JsFtuSA
         TXBA18AgVY3bfnPuG3LDX0njcuIwJVKSStvLRJ6eUftU2qhYTyBuNgjEzU6IrHLohipo
         n+zg==
X-Gm-Message-State: APuU4Z9iTq4Mwz404Gas+bYmGYTz2ZD21kagUI0+4XCj/g+Y6ubJRiYY
	9FOBCKD3s8i1qGulo56D4CU33XOCYjFWJ4kLpJhbhfW+4QhzxcUXT7+UengCwZI686qXWSlsUvO
	riULH
X-Gm-Gg: AYBFou3d4G1/AjoFsHgxRh3hiZ0/OrAT3A69dSC3PiEwvlzcqTdJnKGMEIgHUaIzGRM
	j5bN+Et6nP1ZdM2GKEeRTQ0/o/RTEdxabS6uTLqr27oir6M+J+Pe5s680i6ua+GbKxkB18neCXV
	htc1Pt/O3XWo7Wpw4qi8mdK0Obe1CKPC+OC850rtTlWbQxPy5qco6SiJV2rGGM10oVxGVd9JpFN
	VgV80ZxM59OvsLxK4XqntdTd4YfLjc+ikWrmAcf5SHU1luszZD1m47ml7VEI+YW5coM1XW0H4j7
	MaZtAVjw4X+f1+0dfhwBmMDmfFGZR58MeYbs+Mv4zCcOVLN8sjXimLpPfMEYY9CoagNiA+JMmKR
	NLEtkPaG1htivDZODyYuWtGmG2gad7/T4Pff+Qxxpu1TJqBlBiG+68UNFYsHu4+dicpDD+BvQv5
	vA6zamtQ04j/UHofpBNzA/q/u2ACkOaEJEO68qXWKK/Nn5GHYVa+CTVFpW6udMCiD/5hUVpOaYI
	5AjUrvF7ICjmEts78HQGRI5KpSf7XiCXt+M+qlMgCxCYFndd8jK4eAdaDiti5ZgJctAEZgry6jq
	qt7tiigveoI/vOKuf4WRRw==
X-Received: by 2002:a05:693c:20c2:10b0:36a:22c8:ac57 with SMTP id 5a478bee46e88-36a42436a2cmr27503964eec.33.1793829547128;
        Wed, 04 Nov 2026 13:59:07 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38fe477sm9276367eec.17.2026.11.04.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:59:06 -0800 (PST)
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
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)implicit declaration of
 function
 'huge_page_mask_align' [-Werror,-W...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 04 Nov 2026 21:59:05 -0000
Message-ID: <179382954505.331468.4469230582048386061@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
implicit declaration of function 'huge_page_mask_align' [-Werror,-Wimplicit-function-declaration] in arch/arm/mm/mmap.o (arch/arm/mm/mmap.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/mm/mmap.c:77:21: error: implicit declaration of function 'huge_page_mask_align' [-Werror,-Wimplicit-function-declaration]
   77 |                 info.align_mask = huge_page_mask_align(filp);
      |                                   ^
/tmp/kci/linux/arch/arm/mm/mmap.c:77:21: note: did you mean 'huge_page_mask'?
/tmp/kci/linux/include/linux/hugetlb.h:838:29: note: 'huge_page_mask' declared here
  838 | static inline unsigned long huge_page_mask(struct hstate *h)
      |                             ^
/tmp/kci/linux/arch/arm/mm/mmap.c:131:21: error: implicit declaration of function 'huge_page_mask_align' [-Werror,-Wimplicit-function-declaration]
  131 |                 info.align_mask = huge_page_mask_align(filp);
      |                                   ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:1a8b20df8702363fe4ed80c32eb3d186d6d3c4ea
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  87f290f068db5c53cdb05eabedd694141b5eaeac

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aeba1e45b429d354eeea8c2

#kernelci issue maestro:1a8b20df8702363fe4ed80c32eb3d186d6d3c4ea

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
